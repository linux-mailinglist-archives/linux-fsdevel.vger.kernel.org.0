Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559DC58A1E5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Aug 2022 22:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235810AbiHDUX6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Aug 2022 16:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbiHDUX4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Aug 2022 16:23:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E2624F3F;
        Thu,  4 Aug 2022 13:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=j3nssgGOsRxAdk5zbSCKB6B+tougXOTHjwPnHNLEXAk=; b=G0azAtGuDambxjDpzyqDYcBUfZ
        LsxmuVeodWclf/6+9lPostC4quBhOZy7wpNzCSSHCIXZvHn8e9RhsP/3HvX1e48bDLiQjpett1fPp
        Pluw6e21Me890vAC28ORsZSley5oy2+ejXMYxsutAWke8I2DUfCJxFOLkmQ/C1MpTkYww5G58dj+f
        NO2DUstfysuQ+1agReIexwbYTVLFF+uW2H1pIFkKDqaOTXoI/2aTEKvbC4OwgE7gv80kEWFOy3Qa5
        VtKyw22vulMPNecC9f5VPVULECwmXgna4cLqH/j2kOxAValZdhz2wXLSDGWhV5SvOmRTRhm55SF5A
        lyLRwKJg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oJhNi-00Ac9i-R7; Thu, 04 Aug 2022 20:23:46 +0000
Date:   Thu, 4 Aug 2022 21:23:46 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Enzo Matsumiya <ematsumiya@suse.de>, Tom Talpey <tom@talpey.com>,
        linux-cifs@vger.kernel.org, smfrench@gmail.com, pc@cjr.nz,
        ronniesahlberg@gmail.com, nspmangalore@gmail.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        samba-technical@lists.samba.org, pshilovsky@samba.org
Subject: Re: [RFC PATCH 0/3] Rename "cifs" module to "smbfs"
Message-ID: <Yuwq0kUJMTAX6F4m@casper.infradead.org>
References: <20220801190933.27197-1-ematsumiya@suse.de>
 <c05f4fc668fa97e737758ab03030d7170c0edbd9.camel@kernel.org>
 <20220802193620.dyvt5qiszm2pobsr@cyberdelia>
 <6f3479265b446d180d71832fd0c12650b908ebe2.camel@kernel.org>
 <1c2e8880-3efe-b55d-ee50-87d57efc3130@talpey.com>
 <20220803015655.7u5b6i4eo5sfnryb@cyberdelia>
 <cf24d6b5496598e7717428c6bdcb2366a7d49529.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf24d6b5496598e7717428c6bdcb2366a7d49529.camel@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 04, 2022 at 03:03:23PM -0400, Jeff Layton wrote:
> On Tue, 2022-08-02 at 22:56 -0300, Enzo Matsumiya wrote:
> > On 08/02, Tom Talpey wrote:
> > > The initial goal is to modularize the SMB1 code, so it can be completely
> > > removed from a running system. The extensive refactoring logically leads
> > > to this directory renaming, but renaming is basically a side effect.
> > > 
> 
> This is a great technical goal. Splitting up cifs.ko into smaller
> modules would be great, in addition to being able to turn off smb1
> support.

I don't know the CIFS module that well.  How do you see it being split
up?  It's #4 in the list of filesystems:

$ size /lib/modules/5.18.0-3-amd64/kernel/fs/*/*.ko |sort -n |tail
 369020	  28460	    132	 397612	  6112c	/lib/modules/5.18.0-3-amd64/kernel/fs/ubifs/ubifs.ko
 395793	  50398	    960	 447151	  6d2af	/lib/modules/5.18.0-3-amd64/kernel/fs/ceph/ceph.ko
 477909	  58883	  10512	 547304	  859e8	/lib/modules/5.18.0-3-amd64/kernel/fs/nfsd/nfsd.ko
 609260	  84848	    640	 694748	  a99dc	/lib/modules/5.18.0-3-amd64/kernel/fs/f2fs/f2fs.ko
 622638	 252078	   1008	 875724	  d5ccc	/lib/modules/5.18.0-3-amd64/kernel/fs/nfs/nfsv4.ko
 717343	 111314	   1176	 829833	  ca989	/lib/modules/5.18.0-3-amd64/kernel/fs/ext4/ext4.ko
 884247	 206051	    504	1090802	 10a4f2	/lib/modules/5.18.0-3-amd64/kernel/fs/cifs/cifs.ko
 890155	 159520	    240	1049915	 10053b	/lib/modules/5.18.0-3-amd64/kernel/fs/ocfs2/ocfs2.ko
1193834	 274148	    456	1468438	 166816	/lib/modules/5.18.0-3-amd64/kernel/fs/xfs/xfs.ko
1393088	 126501	  15072	1534661	 176ac5	/lib/modules/5.18.0-3-amd64/kernel/fs/btrfs/btrfs.ko

... but if you look at how NFS is split up:

 311322	  76200	    392	 387914	  5eb4a	/lib/modules/5.18.0-3-amd64/kernel/fs/nfs/nfs.ko
  25157	   1100	     72	  26329	   66d9	/lib/modules/5.18.0-3-amd64/kernel/fs/nfs/nfsv2.ko
  49332	   1544	    120	  50996	   c734	/lib/modules/5.18.0-3-amd64/kernel/fs/nfs/nfsv3.ko
 622638	 252078	   1008	 875724	  d5ccc	/lib/modules/5.18.0-3-amd64/kernel/fs/nfs/nfsv4.ko

you can save a lot of RAM if you don't need NFSv4 (then there's also
nfs_common, 408kB of sunrpc.ko, etc, etc).
