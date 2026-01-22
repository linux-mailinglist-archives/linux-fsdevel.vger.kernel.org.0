Return-Path: <linux-fsdevel+bounces-75002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BWtA4P3cWmvZwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 11:10:11 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AE08565089
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 11:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4FFAC84823E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 10:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152BB35CBA8;
	Thu, 22 Jan 2026 10:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="GM6cSHwx";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="wu1Zz0IP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mta-01.yadro.com (mta-01.yadro.com [195.3.219.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9CC2D0C9D;
	Thu, 22 Jan 2026 10:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.219.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769076159; cv=none; b=o9cIh0Ru4rcJKW2bmn/4doNefb74SpdY4ecyFRyT6t8slXEnM6mbgQEtM0yl7P3pKBrjTWTOybtA7TROgZLkF6Jv2kcXuW2k346ZHBmnOG1jJU4Omq/jt626cXCFHzSpPtcW8YRFtFXx27jQPyhAGJHVS0f0uKItMfXC7461/vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769076159; c=relaxed/simple;
	bh=U7gZ4KtU9pdT22CPcscPa0l7Fcikaz3hIApZkPxTY3w=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T61Wu/Ftu2fEnxF69MCLeYrP0i73ggadcpAmKC0Re3I1SP9mDfAx2YVkkEYkfjJMa8eXaq3owuKxlJ4c1zGq8LWPrgwII2mMsb3qWdncfTSmvFipnkn1pldoYjdiri1eU0oMHSyIptyPZOez1pSBQaCHuBe9i1mGtvTGH6QBsRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yadro.com; spf=pass smtp.mailfrom=yadro.com; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=GM6cSHwx; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=wu1Zz0IP; arc=none smtp.client-ip=195.3.219.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yadro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yadro.com
Received: from mta-01.yadro.com (localhost [127.0.0.1])
	by mta-01.yadro.com (Postfix) with ESMTP id 5706220022;
	Thu, 22 Jan 2026 12:56:25 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-01.yadro.com 5706220022
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-02;
	t=1769075785; bh=TSfOQSD1nGDR+S9g/1A7cqiXfGLSItDDZxx/gk5oYV4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=GM6cSHwxWxQIE/Qqnda3N1lU2OY6aRIz2KZQ7Afc+jUt/g6qEUXymwk1wRdjVI4DU
	 hFwBbdTRxx2AZAQcM15Zm1pyOKvG491T3HhXFZt3bd4VZa2nNNftSZmFHfM5csOzQO
	 DZfLGCHpzXTcCJfoCE2SKC1nkrU7fwYTaXEcLYzYydx1R3uh6p/f+90/09flm3TmtA
	 ErsUYgtO8jxm+1vZXA/A762ZUjdzyxFTQ5ZN3jCdpHkWIgy45mbNVmOA5bXpOgtjXu
	 ry97qMIN1N182hgcFEKgildkjk/d8sUB2LDTi3kVD5+NOaP+4Ld1ie4MqJN7dYAxS1
	 X6756Slyc5NIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1769075785; bh=TSfOQSD1nGDR+S9g/1A7cqiXfGLSItDDZxx/gk5oYV4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=wu1Zz0IPBuOhGnzc4XKQscYXl8X2pPQwP1ujmLx54P1RKlIFiZ3EYdlby7K/ipAEm
	 oHVky1BvXyJ/NtW3FEoeY1XpnAbc/plo6pPRugw2kp8sdm6ux/Sz+RPI/AsobUBb99
	 sxgOIChJkxR9B2kfLSoSjcmWFn8z5xGzJwdyv+DgzBjKemrOzGM8JL5fNWwJsYfWmB
	 pAmeFvC0PjsTt7iQXGsOYdL003iyIcAubeKK/REAczBzmjMGk9ihF94K9znthAE1u8
	 tyBD1yqIw6iloQgYPSNeozfkSm8UeTK8ijxa3pqsrN31uF5MnRWAqwT3T+S8gJY/i/
	 G9G+8s0RFHR+g==
Received: from RTM-EXCH-06.corp.yadro.com (unknown [10.34.9.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mta-01.yadro.com (Postfix) with ESMTPS;
	Thu, 22 Jan 2026 12:56:17 +0300 (MSK)
Received: from T-EXCH-12.corp.yadro.com (10.34.9.214) by
 RTM-EXCH-06.corp.yadro.com (10.34.9.206) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 22 Jan 2026 12:56:34 +0300
Received: from yadro.com (10.34.9.241) by T-EXCH-12.corp.yadro.com
 (10.34.9.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 22 Jan
 2026 12:56:33 +0300
Date: Thu, 22 Jan 2026 12:56:34 +0300
From: Dmitry Bogdanov <d.bogdanov@yadro.com>
To: Prithvi <activprithvi@gmail.com>
CC: <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>,
	<target-devel@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <hch@lst.de>,
	<jlbec@evilplan.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel-mentees@lists.linux.dev>, <skhan@linuxfoundation.org>,
	<david.hunter.linux@gmail.com>, <khalid@kernel.org>,
	<syzbot+f6e8174215573a84b797@syzkaller.appspotmail.com>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH] scsi: target: Fix recursive locking in
 __configfs_open_file()
Message-ID: <20260122095634.GA15012@yadro.com>
References: <20260108191523.303114-1-activprithvi@gmail.com>
 <20260115032012.yb5ylmumcirrmsbr@inspiron>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260115032012.yb5ylmumcirrmsbr@inspiron>
X-ClientProxiedBy: RTM-EXCH-04.corp.yadro.com (10.34.9.204) To
 T-EXCH-12.corp.yadro.com (10.34.9.214)
X-KSMG-AntiPhishing: NotDetected, bases: 2026/01/22 08:49:00
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2026/01/22 07:14:00 #28140735
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-KATA-Status: Not Scanned
X-KSMG-LinksScanning: NotDetected, bases: 2026/01/22 08:49:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[yadro.com:s=mta-02,yadro.com:s=mta-03];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[oracle.com,vger.kernel.org,lst.de,evilplan.org,lists.linux.dev,linuxfoundation.org,gmail.com,kernel.org,syzkaller.appspotmail.com];
	TAGGED_FROM(0.00)[bounces-75002-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[yadro.com,reject];
	DKIM_TRACE(0.00)[yadro.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,syzkaller.appspot.com:url,appspotmail.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[d.bogdanov@yadro.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-fsdevel,f6e8174215573a84b797];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: AE08565089
X-Rspamd-Action: no action

On Thu, Jan 15, 2026 at 08:50:12AM +0530, Prithvi wrote:
> 
> On Fri, Jan 09, 2026 at 12:45:23AM +0530, Prithvi Tambewagh wrote:
> > In flush_write_buffer, &p->frag_sem is acquired and then the loaded store
> > function is called, which, here, is target_core_item_dbroot_store().
> > This function called filp_open(), following which these functions were
> > called (in reverse order), according to the call trace:
> >
> > down_read
> > __configfs_open_file
> > do_dentry_open
> > vfs_open
> > do_open
> > path_openat
> > do_filp_open
> > file_open_name
> > filp_open
> > target_core_item_dbroot_store
> > flush_write_buffer
> > configfs_write_iter
> >
> > Hence ultimately, __configfs_open_file() was called, indirectly by
> > target_core_item_dbroot_store(), and it also attempted to acquire
> > &p->frag_sem, which was already held by the same thread, acquired earlier
> > in flush_write_buffer. This poses a possibility of recursive locking,
> > which triggers the lockdep warning.
> >
> > Fix this by modifying target_core_item_dbroot_store() to use kern_path()
> > instead of filp_open() to avoid opening the file using filesystem-specific
> > function __configfs_open_file(), and further modifying it to make this
> > fix compatible.
> >
> > Reported-by: syzbot+f6e8174215573a84b797@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=f6e8174215573a84b797
> > Tested-by: syzbot+f6e8174215573a84b797@syzkaller.appspotmail.com
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Prithvi Tambewagh <activprithvi@gmail.com>
> > ---
> >  drivers/target/target_core_configfs.c | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
> > index b19acd662726..f29052e6a87d 100644
> > --- a/drivers/target/target_core_configfs.c
> > +++ b/drivers/target/target_core_configfs.c
> > @@ -108,8 +108,8 @@ static ssize_t target_core_item_dbroot_store(struct config_item *item,
> >                                       const char *page, size_t count)
> >  {
> >       ssize_t read_bytes;
> > -     struct file *fp;
> >       ssize_t r = -EINVAL;
> > +     struct path path = {};
> >
> >       mutex_lock(&target_devices_lock);
> >       if (target_devices) {
> > @@ -131,17 +131,18 @@ static ssize_t target_core_item_dbroot_store(struct config_item *item,
> >               db_root_stage[read_bytes - 1] = '\0';
> >
> >       /* validate new db root before accepting it */
> > -     fp = filp_open(db_root_stage, O_RDONLY, 0);
> > -     if (IS_ERR(fp)) {
> > +     r = kern_path(db_root_stage, LOOKUP_FOLLOW, &path);
> > +     if (r) {
> >               pr_err("db_root: cannot open: %s\n", db_root_stage);
> >               goto unlock;
> >       }
> > -     if (!S_ISDIR(file_inode(fp)->i_mode)) {
> > -             filp_close(fp, NULL);
> > +     if (!d_is_dir(path.dentry)) {
> > +             path_put(&path);
> >               pr_err("db_root: not a directory: %s\n", db_root_stage);
> > +             r = -ENOTDIR;
> >               goto unlock;
> >       }
> > -     filp_close(fp, NULL);
> > +     path_put(&path);
> >
> >       strscpy(db_root, db_root_stage);
> >       pr_debug("Target_Core_ConfigFS: db_root set to %s\n", db_root);
> >
> > base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
> > --
> > 2.34.1
> >

You missed the very significant thing in the commit message - that this
lockdep warning is due to try to write its own filename to dbroot file:

	db_root: not a directory: /sys/kernel/config/target/dbroot

That is why the semaphore is the same - it is of the same file.

Without that explanation nobody understands wheter it is a false positive or not.

The fix itself looks good.

Reviewed-by: Dmitry Bogdanov <d.bogdanov@yadro.com> 

