Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180D05F162F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Oct 2022 00:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbiI3Wcd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Sep 2022 18:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbiI3Wc3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Sep 2022 18:32:29 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BEE69166489;
        Fri, 30 Sep 2022 15:32:24 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-106-210.pa.nsw.optusnet.com.au [49.181.106.210])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 078B88AB6CD;
        Sat,  1 Oct 2022 08:32:19 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oeOYM-00E7kF-Mx; Sat, 01 Oct 2022 08:32:18 +1000
Date:   Sat, 1 Oct 2022 08:32:18 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Neil Brown <neilb@suse.de>, Al Viro <viro@zeniv.linux.org.uk>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "xiubli@redhat.com" <xiubli@redhat.com>,
        Lukas Czerner <lczerner@redhat.com>, Jan Kara <jack@suse.cz>,
        Bruce Fields <bfields@fieldses.org>,
        Christian Brauner <brauner@kernel.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH v6 6/9] nfsd: use the getattr operation to fetch i_version
Message-ID: <20220930223218.GL3600936@dread.disaster.area>
References: <20220930111840.10695-1-jlayton@kernel.org>
 <20220930111840.10695-7-jlayton@kernel.org>
 <D7DAB33E-BB23-45A9-BE2C-DBF9B5D62EF8@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D7DAB33E-BB23-45A9-BE2C-DBF9B5D62EF8@oracle.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=63376e77
        a=j6JUzzrSC7wlfFge/rmVbg==:117 a=j6JUzzrSC7wlfFge/rmVbg==:17
        a=kj9zAlcOel0A:10 a=Qawa6l4ZSaYA:10 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8
        a=P6V2cQqVOOyE__6v1BQA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 30, 2022 at 02:34:51PM +0000, Chuck Lever III wrote:
> 
> 
> > On Sep 30, 2022, at 7:18 AM, Jeff Layton <jlayton@kernel.org> wrote:
> > 
> > Now that we can call into vfs_getattr to get the i_version field, use
> > that facility to fetch it instead of doing it in nfsd4_change_attribute.
> > 
> > Neil also pointed out recently that IS_I_VERSION directory operations
> > are always logged,
> 
> ^logged^synchronous maybe?

A pedantic note, but I think necessary because so many people still
get this wrong when it comes to filesystems and IO: synchronous !=
persistent.

Ext4 and XFS both use *asynchronous journalling* - they journal
changes first to memory buffers, and only make those recorded
changes persistent when they hit internal checkpoint thresholds or
something external requires persistence to be guaranteed.

->commit_metadata is the operation filesystems provide the NFS
server to *guarantee persistence*. This allows filesystems to use
asynchronous journalling for most operations, right up to the point
the NFS server requires a change to be persistent. "synchronous
operation" is a side effect of guaranteeing persistence on some
filesytems and storage media, whereas "synchronous operation"
does not provide any guarantee of persistence...

IOWs, please talk about persistence guarantees the NFS server
application requires and implements, not about the operations (or
the nature of the operations) that may be performed by the
underlying filesystems to provide that persistence guarantee.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
