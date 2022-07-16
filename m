Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3727577173
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Jul 2022 22:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbiGPUwJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 16 Jul 2022 16:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGPUwI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 16 Jul 2022 16:52:08 -0400
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E891E165BF
        for <linux-fsdevel@vger.kernel.org>; Sat, 16 Jul 2022 13:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1658004727; x=1689540727;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ehewac0uUV7EymZaGAlgcqgsCoQ1UULfPeD2FZoNrRA=;
  b=i06fP1hB02k8jZNfX/AbeNVvaKpz5vUgezZnFLyiD89C28GY97RKYIur
   5345kjEw1zGRF5rbwQVAuizWxIEcdx6eSAtsIoRrahtTfscY3sWJzLyXY
   yJZteACaIADBE4/Jh9cwX/fz9jcc6A8Z3b3I+Ruerjd67iIRFgQVqzgfo
   k=;
X-IronPort-AV: E=Sophos;i="5.92,277,1650931200"; 
   d="scan'208";a="219154370"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-5c4a15b1.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP; 16 Jul 2022 20:51:55 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2c-5c4a15b1.us-west-2.amazon.com (Postfix) with ESMTPS id 16BB14346F;
        Sat, 16 Jul 2022 20:51:55 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.36; Sat, 16 Jul 2022 20:51:54 +0000
Received: from 88665a182662.ant.amazon.com (10.43.160.111) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.9;
 Sat, 16 Jul 2022 20:51:52 +0000
From:   Kuniyuki Iwashima <kuniyu@amazon.com>
To:     <chuck.lever@oracle.com>
CC:     <jlayton@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
        <linux-fsdevel@vger.kernel.org>, <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fs/lock: Don't allocate file_lock in flock_make_lock().
Date:   Sat, 16 Jul 2022 13:51:44 -0700
Message-ID: <20220716205144.15142-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <82C02F62-8EBA-4860-89BA-19ED9F51281E@oracle.com>
References: <82C02F62-8EBA-4860-89BA-19ED9F51281E@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.43.160.111]
X-ClientProxiedBy: EX13D08UWC002.ant.amazon.com (10.43.162.168) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From:   Chuck Lever III <chuck.lever@oracle.com>
Date:   Sat, 16 Jul 2022 16:18:41 +0000
> > On Jul 15, 2022, at 9:31 PM, Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> > 
> > Two functions, flock syscall and locks_remove_flock(), call
> > flock_make_lock().  It allocates struct file_lock from slab
> > cache if its argument fl is NULL.
> > 
> > When we call flock syscall, we pass NULL to allocate memory
> > for struct file_lock.  However, we always free it at the end
> > by locks_free_lock().  We need not allocate it and instead
> > should use a local variable as locks_remove_flock() does.
> > 
> > Also, the validation for flock_translate_cmd() is not necessary
> > for locks_remove_flock().  So we move the part to flock syscall
> > and make flock_make_lock() return nothing.
> > 
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> 
> It looks like a reasonable clean-up. Handful of comments below.
> 
> Reviewed-by: Chuck Lever <chuck.lever@oracle.com>

Thank you for reviewing!


> > ---
> > fs/locks.c | 57 +++++++++++++++++++-----------------------------------
> > 1 file changed, 20 insertions(+), 37 deletions(-)
> > 
> > diff --git a/fs/locks.c b/fs/locks.c
> > index ca28e0e50e56..db75f4537abc 100644
> > --- a/fs/locks.c
> > +++ b/fs/locks.c
> > @@ -425,21 +425,9 @@ static inline int flock_translate_cmd(int cmd) {
> > }
> > 
> > /* Fill in a file_lock structure with an appropriate FLOCK lock. */
> > -static struct file_lock *
> > -flock_make_lock(struct file *filp, unsigned int cmd, struct file_lock *fl)
> > +static void flock_make_lock(struct file *filp, struct file_lock *fl, int type)
> > {
> > -	int type = flock_translate_cmd(cmd);
> > -
> > -	if (type < 0)
> > -		return ERR_PTR(type);
> > -
> > -	if (fl == NULL) {
> > -		fl = locks_alloc_lock();
> > -		if (fl == NULL)
> > -			return ERR_PTR(-ENOMEM);
> > -	} else {
> > -		locks_init_lock(fl);
> > -	}
> > +	locks_init_lock(fl);
> > 
> > 	fl->fl_file = filp;
> > 	fl->fl_owner = filp;
> > @@ -447,8 +435,6 @@ flock_make_lock(struct file *filp, unsigned int cmd, struct file_lock *fl)
> > 	fl->fl_flags = FL_FLOCK;
> > 	fl->fl_type = type;
> > 	fl->fl_end = OFFSET_MAX;
> > -
> > -	return fl;
> > }
> > 
> > static int assign_type(struct file_lock *fl, long type)
> > @@ -2097,14 +2083,18 @@ EXPORT_SYMBOL(locks_lock_inode_wait);
> >  */
> > SYSCALL_DEFINE2(flock, unsigned int, fd, unsigned int, cmd)
> > {
> > -	struct fd f = fdget(fd);
> > -	struct file_lock *lock;
> > -	int can_sleep, unlock;
> > +	int can_sleep, unlock, type;
> > +	struct file_lock fl;
> > +	struct fd f;
> > 	int error;
> 
> "struct file_lock" on my system is 216 bytes. That's a lot to
> allocate on the stack, but there isn't much else there in
> addition to "struct file_lock", so OK.
> 
> 
> > -	error = -EBADF;
> > +	type = flock_translate_cmd(cmd);
> > +	if (type < 0)
> > +		return type;
> > +
> > +	f = fdget(fd);
> > 	if (!f.file)
> > -		goto out;
> > +		return -EBADF;
> > 
> > 	can_sleep = !(cmd & LOCK_NB);
> > 	cmd &= ~LOCK_NB;
> > @@ -2127,32 +2117,25 @@ SYSCALL_DEFINE2(flock, unsigned int, fd, unsigned int, cmd)
> > 		goto out_putf;
> > 	}
> > 
> > -	lock = flock_make_lock(f.file, cmd, NULL);
> > -	if (IS_ERR(lock)) {
> > -		error = PTR_ERR(lock);
> > -		goto out_putf;
> > -	}
> > +	flock_make_lock(f.file, &fl, type);
> > 
> > 	if (can_sleep)
> > -		lock->fl_flags |= FL_SLEEP;
> > +		fl.fl_flags |= FL_SLEEP;
> > 
> > -	error = security_file_lock(f.file, lock->fl_type);
> > +	error = security_file_lock(f.file, fl.fl_type);
> > 	if (error)
> > -		goto out_free;
> > +		goto out_putf;
> > 
> > 	if (f.file->f_op->flock)
> > 		error = f.file->f_op->flock(f.file,
> > -					  (can_sleep) ? F_SETLKW : F_SETLK,
> > -					  lock);
> > +					    can_sleep ? F_SETLKW : F_SETLK,
> > +					    &fl);
> > 	else
> > -		error = locks_lock_file_wait(f.file, lock);
> > -
> > - out_free:
> > -	locks_free_lock(lock);
> > +		error = locks_lock_file_wait(f.file, &fl);
> > 
> >  out_putf:
> > 	fdput(f);
> > - out:
> > +
> > 	return error;
> > }
> > 
> > @@ -2614,7 +2597,7 @@ locks_remove_flock(struct file *filp, struct file_lock_context *flctx)
> > 	if (list_empty(&flctx->flc_flock))
> > 		return;
> > 
> > -	flock_make_lock(filp, LOCK_UN, &fl);
> > +	flock_make_lock(filp, &fl, flock_translate_cmd(LOCK_UN));
> 
> We hope the compiler recognizes that passing a constant value through
> a switch statement means the flock_translate_cmd() call here is
> reduced to a constant F_UNLCK. It might be slightly easier to read
> if you explicitly pass F_UNLCK here? Dunno.

My thoughts exactly.  I wrote this way because flock_translate_cmd() was
called in flock_make_lock(), so I guessed there might be coding conventions
like we should try to use uAPI value.

I have no strong preference though, if there is no such convention, I like
using F_UNLCK directly instead of trusting the compiler.


> > 	fl.fl_flags |= FL_CLOSE;
> > 
> > 	if (filp->f_op->flock)
> > -- 
> > 2.30.2
> > 
> 
> --
> Chuck Lever
