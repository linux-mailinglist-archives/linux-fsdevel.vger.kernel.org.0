Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA46BA88E5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2019 21:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730846AbfIDOj2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Sep 2019 10:39:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:33236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730153AbfIDOj1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Sep 2019 10:39:27 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E31B23401;
        Wed,  4 Sep 2019 14:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567607966;
        bh=aD2iCJ22nEGEI/+riKk0ElhPI0pFP/JdVCELOqTyRLc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=CXWl3wrv7B1MhicxS//ASRwy9E2tI43lQpfM25B6tGvResu/lXBTAG8gWvHIEpOfh
         /0AzWvLU2EG4J2ImPnL4/wTGNuwHC82IHlWW21YAkc5hrNh1i5W+jTGvW3l7iabdMx
         cb3gr/1m3m8tv+cfcWcux4KJ/bH8br+M0CG0Kd0Q=
Message-ID: <9b3433ebec78bb99690fd4805b329266edf21686.camel@kernel.org>
Subject: Re: [RFC] - vfs: Null pointer dereference issue with symlink create
 and read of symlink
From:   Jeff Layton <jlayton@kernel.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>,
        Gao Xiang <hsiangkao@aol.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, aneesh.kumar@linux.ibm.com,
        wugyuan@cn.ibm.com
Date:   Wed, 04 Sep 2019 10:39:24 -0400
In-Reply-To: <20190903134129.EC5E6A405B@b06wcsmtp001.portsmouth.uk.ibm.com>
References: <20190903115827.0A8A0A405B@b06wcsmtp001.portsmouth.uk.ibm.com>
         <20190903125946.GA11069@hsiangkao-HP-ZHAN-66-Pro-G1>
         <20190903134129.EC5E6A405B@b06wcsmtp001.portsmouth.uk.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2019-09-03 at 19:11 +0530, Ritesh Harjani wrote:
> 
> On 9/3/19 6:29 PM, Gao Xiang wrote:
> > On Tue, Sep 03, 2019 at 05:28:26PM +0530, Ritesh Harjani wrote:
> > > Hi Viro/All,
> > > 
> > > Could you please review below issue and it's proposed solutions.
> > > If you could let me know which of the two you think will be a better
> > > approach to solve this or in case if you have any other better approach, I
> > > can prepare and submit a official patch with that.
> > > 
> > > 
> > > 
> > > Issue signature:-
> > >   [NIP  : trailing_symlink+80]
> > >   [LR   : trailing_symlink+1092]
> > >   #4 [c00000198069bb70] trailing_symlink at c0000000004bae60  (unreliable)
> > >   #5 [c00000198069bc00] path_openat at c0000000004bdd14
> > >   #6 [c00000198069bc90] do_filp_open at c0000000004c0274
> > >   #7 [c00000198069bdb0] do_sys_open at c00000000049b248
> > >   #8 [c00000198069be30] system_call at c00000000000b388
> > > 
> > > 
> > > 
> > > Test case:-
> > > shell-1 - "while [ 1 ]; do cat /gpfs/g1/testdir/file3; sleep 1; done"
> > > shell-2 - "while [ 1 ]; do ln -s /gpfs/g1/testdir/file1
> > > /gpfs/g1/testdir/file3; sleep 1; rm /gpfs/g1/testdir/file3 sleep 1; done
> > > 
> > > 
> > > 
> > > Problem description:-
> > > In some filesystems like GPFS below described scenario may happen on some
> > > platforms (Reported-By:- wugyuan)
> > > 
> > > Here, two threads are being run in 2 different shells. Thread-1(cat) does
> > > cat of the symlink and Thread-2(ln) is creating the symlink.
> > > 
> > > Now on any platform with GPFS like filesystem, if CPU does out-of-order
> > > execution (or any kind of re-ordering due compiler optimization?) in
> > > function __d_set_and_inode_type(), then we see a NULL pointer dereference
> > > due to inode->i_uid.
> > > 
> > > This happens because in lookup_fast in nonRCU path or say REF-walk (i.e. in
> > > else condition), we check d_is_negative() without any lock protection.
> > > And since in __d_set_and_inode_type() re-ordering may happen in setting of
> > > dentry->type & dentry->inode => this means that there is this tiny window
> > > where things are going wrong.
> > > 
> > > 
> > > (GPFS like):- Any FS with -inode_operations ->permission callback returning
> > > -ECHILD in case of (mask & MAY_NOT_BLOCK) may cause this problem to happen.
> > > (few e.g. found were - ocfs2, ceph, coda, afs)
> > > 
> > > int xxx_permission(struct inode *inode, int mask)
> > > {
> > >           if (mask & MAY_NOT_BLOCK)
> > >                   return -ECHILD;
> > > 	<...>
> > > }
> > > 
> > > Wugyuan(cc), could reproduce this problem with GPFS filesystem.
> > > Since, I didn't have the GPFS setup, so I tried replicating on a native FS
> > > by forcing out-of-order execution in function __d_set_inode_and_type() and
> > > making sure we return -ECHILD in MAY_NOT_BLOCK case in ->permission
> > > operation for all inodes.
> > > 
> > > With above changes in kernel, I could as well hit this issue on a native FS
> > > too.
> > > 
> > > (basically what we observed is link_path_walk will do nonRCU(REF-walk)
> > > lookup due to may_lookup -> inode_permission return -ECHILD and then
> > > unlazy_walk drops the LOOKUP_RCU flag (nd->flag). After that below race is
> > > possible).
> > > 
> > > 
> > > 
> > > Sequence of events:-
> > > 
> > > Thread-2(Comm: ln)		Thread-1(Comm: cat)
> > > 
> > > 				dentry = __d_lookup() //nonRCU
> > > 
> > > __d_set_and_inode_type() (Out-of-order execution)
> > > 	flags = READ_ONCE(dentry->d_flags);
> > > 	flags &= ~(DCACHE_ENTRY_TYPE | DCACHE_FALLTHRU);
> > > 	flags |= type_flags;
> > > 	WRITE_ONCE(dentry->d_flags, flags);
> > > 
> > > 					
> > > 				if (unlikely(d_is_negative()) // fails
> > >    					{}
> > > 				// since type is already updated in
> > > 				// Thread-2 in parallel but inode
> > > 				// not yet set.
> > > 				// d_is_negative returns false
> > > 
> > > 				*inode = d_backing_inode(path->dentry);
> > > 				// means inode is still NULL
> > > 
> > > 	dentry->d_inode = inode;
> > > 	
> > > 				trailing_symlink()
> > > 					may_follow_link()
> > > 						inode = nd->link_inode;
> > > 						// nd->link_inode = NULL
> > > 						//Then it crashes while
> > > 						//doing inode->i_uid
> > > 					
> > > 	
> > 
> > It seems much similar to
> > https://lore.kernel.org/r/20190419084810.63732-1-houtao1@huawei.com/
> 
> Thanks, yes two same symptoms with different use cases.
> But except the fact that here, we see the issue with GPFS quite 
> frequently. So let's hope that we could have some solution to this 
> problem in upstream.
> 

Agreed. Looks a lot like the same issue.

>  From the thread:-
>  >> We could simply use d_really_is_negative() there, avoiding all that
>  >> mess.  If and when we get around to whiteouts-in-dcache (i.e. if
>  >> unionfs series gets resurrected), we can revisit that
> 
> I didn't get this part. Does it mean, d_really_is_negative can only be 
> used, once whiteouts-in-dcache series is resurrected?
> If yes, meanwhile could we have any other solution in place?
> 

I think Al was saying that you could change this to use
d_really_is_negative now but the whiteouts-in-dcache series would have
to deal with that. That series seems to be stalled for the time being,
so I wouldn't let it stop you from changing this.

It wouldn't hurt to put in some comments with this change too, to make
sure everyone understands why that's being used there.
-- 
Jeff Layton <jlayton@kernel.org>

