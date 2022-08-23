Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96DFA59CCB9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Aug 2022 02:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238902AbiHWAFF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Aug 2022 20:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238567AbiHWAFE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Aug 2022 20:05:04 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7D97C52DF0;
        Mon, 22 Aug 2022 17:05:03 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-4-169.pa.nsw.optusnet.com.au [49.195.4.169])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id DB21862D5C0;
        Tue, 23 Aug 2022 10:05:01 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oQHPg-00GMEQ-1k; Tue, 23 Aug 2022 10:05:00 +1000
Date:   Tue, 23 Aug 2022 10:05:00 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] xfs: fix i_version handling in xfs
Message-ID: <20220823000500.GL3600936@dread.disaster.area>
References: <20220816131736.42615-1-jlayton@kernel.org>
 <Yvu7DHDWl4g1KsI5@magnolia>
 <e77fd4d19815fd661dbdb04ab27e687ff7e727eb.camel@kernel.org>
 <20220816224257.GV3600936@dread.disaster.area>
 <c61568de755fc9cd70c80c23d63c457918ab4643.camel@hammerspace.com>
 <20220818033731.GF3600936@dread.disaster.area>
 <0e41fb378e57794ab2a8a714b44ef92733598e8e.camel@hammerspace.com>
 <b8cf4464cc31dc262a2d38e66265c06bf1e35751.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8cf4464cc31dc262a2d38e66265c06bf1e35751.camel@kernel.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=630419ae
        a=FOdsZBbW/tHyAhIVFJ0pRA==:117 a=FOdsZBbW/tHyAhIVFJ0pRA==:17
        a=kj9zAlcOel0A:10 a=biHskzXt2R4A:10 a=7-415B0cAAAA:8
        a=NfTjnu3Su8rNoGYjGKYA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 18, 2022 at 07:03:42AM -0400, Jeff Layton wrote:
> Dave, you keep talking about the xfs i_version counter as if there are
> other applications already relying on its behavior, but I don't see how
> that can be. There is no way for userland applications to fetch the
> counter currently.

You miss the point entirely: the behaviour is defined by the on-disk
format (the di_changecount filed), not the applications that are
using the kernel internal iversion API.

Just because there are no in-kernel users of the di_changecount
field in the XFS inode, it does not mean that it doesn't get used by
applications. Forensic analysis tools that walk filesystem images.

Did you not notice that xfs_trans_log_inode() forces an iversion
update if the inode core is marked for update:

	inode_maybe_inc_iversion(inode, flags & XFS_ILOG_CORE))
					^^^^^^^^^^^^^^^^^^^^^^
					this?

So every modification to the inode core (which almost all inode
modifications will do, except for pure timestamp updates) will bump
the iversion regardless of whether it was queried or not.

I use this information all the time for forensic analysis of broken
filesystem images. There are forensic tools that use expose this
information from filesystem images (e.g. xfs_db) so that we can use
it for forensic analysis.

See the problem? On-disk format di_changecount != NFS change
attribute. We can implement the NFS change attribute with the
existing di_changecount field, but if you want to constrain the
definition of how the NFS change attribute is calculated, we can't
necessarily implement that in di_changecount without changing the
on-disk format definition.

And, yes, this has implications for iversion being exposed to
userspace via statx(), as I've mentioned in reply to the v2 patch
you've posted. iversion is persistent information - you can't just
redefine it's behaviour without some fairly serious knock-on
effects for the subsystems that provide the persistent storage...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
