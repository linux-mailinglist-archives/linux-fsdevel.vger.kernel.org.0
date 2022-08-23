Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A74259EE7C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Aug 2022 23:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbiHWVxj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Aug 2022 17:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiHWVxi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Aug 2022 17:53:38 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 55FAD21E0E;
        Tue, 23 Aug 2022 14:53:37 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-4-169.pa.nsw.optusnet.com.au [49.195.4.169])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 7AC9962E33A;
        Wed, 24 Aug 2022 07:53:35 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oQbq1-00GiOV-Pu; Wed, 24 Aug 2022 07:53:33 +1000
Date:   Wed, 24 Aug 2022 07:53:33 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     viro@zeniv.linux.org.uk, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        Jeff Layton <jlayton@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Frank Filz <ffilzlnx@mindspring.com>
Subject: Re: [PATCH] vfs: report an inode version in statx for IS_I_VERSION
 inodes
Message-ID: <20220823215333.GC3144495@dread.disaster.area>
References: <20220819115641.14744-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819115641.14744-1-jlayton@kernel.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=OJNEYQWB c=1 sm=1 tr=0 ts=63054c60
        a=FOdsZBbW/tHyAhIVFJ0pRA==:117 a=FOdsZBbW/tHyAhIVFJ0pRA==:17
        a=kj9zAlcOel0A:10 a=biHskzXt2R4A:10 a=20KFwNOVAAAA:8 a=84BadPHTAAAA:8
        a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8 a=-sNG4CTRcTQKk6ulFHEA:9
        a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 19, 2022 at 07:56:41AM -0400, Jeff Layton wrote:
> From: Jeff Layton <jlayton@redhat.com>
> 
> The NFS server and IMA both rely heavily on the i_version counter, but
> it's largely invisible to userland, which makes it difficult to test its
> behavior. This value would also be of use to userland NFS servers, and
> other applications that want a reliable way to know if there was an
> explicit change to an inode since they last checked.
> 
> Claim one of the spare fields in struct statx to hold a 64-bit inode
> version attribute. This value must change with any explicit, observeable
> metadata or data change. Note that atime updates are excluded from this,
> unless it is due to an explicit change via utimes or similar mechanism.
> 
> When statx requests this attribute on an IS_I_VERSION inode, do an
> inode_query_iversion and fill the result in the field. Also, update the
> test-statx.c program to display the inode version and the mountid.
> 
> Cc: David Howells <dhowells@redhat.com>
> Cc: Frank Filz <ffilzlnx@mindspring.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

NAK.

THere's no definition of what consitutes an "inode change" and this
exposes internal filesystem implementation details (i.e. on disk
format behaviour) directly to userspace. That means when the
internal filesystem behaviour changes, userspace applications will
see changes in stat->ino_version changes and potentially break them.

We *need a documented specification* for the behaviour we are exposing to
userspace here, and then individual filesystems needs to opt into
providing this information as they are modified to conform to the
behaviour we are exposing directly to userspsace.

Jeff - can you please stop posting iversion patches to different
subsystems as individual, unrelated patchsets and start posting all
the changes - statx, ext4, xfs, man pages, etc as a single patchset
so the discussion can be centralised in one place and not spread
over half a dozen disconnected threads?

-Dave.
-- 
Dave Chinner
david@fromorbit.com
