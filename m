Return-Path: <linux-fsdevel+bounces-75299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBahIOmMc2l0xAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 15:59:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 273F777605
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 15:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21B76304EA9B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 14:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868812E06EA;
	Fri, 23 Jan 2026 14:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E03gqZWO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930ED33555D
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jan 2026 14:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769180311; cv=none; b=KzPIL7v10kWWUPHdNtWeBTfTmoNG3eYPJ1KH7zMBPTkxR2FgIj4Vsy9/8fDliH6YppHqt/nI8PV8Re1vnhaDTZL6gnOZzzedS0WucBW/IRGQN9K563XltajDhTkMKE1GBVS+LGhtXRW9ZyUdLzICv5hQTX1mJV2iBc20lojQRMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769180311; c=relaxed/simple;
	bh=yLzY19MuS3iN380+AoG930YPzVQx3y4RwEr4smOpjaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YU/BGPsm/BwoTCxt8/09M7/PA+Hjimdv4AaBm0AbuXSNPuHC67JWYefn0iNxVdHUFz9p83pLRaRsZlW5J52klpFFH++QRW7AvYFDEFm5tTDwrIIacBvPCoVFdeeEa8JIpyZ4h7WH0iIAaRAIKxdlYMA3tEp+GJC/5tX66rJ19o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E03gqZWO; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-81f5381d168so2450565b3a.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jan 2026 06:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769180306; x=1769785106; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eEedmtOY7Y8eJ9xgbPCCWxatDC0k0Q8serp7IKoqpeM=;
        b=E03gqZWOFHV3q/QQn+Zg2MgCO0R4louQSem3MkoQbOTGUL4ZT/EziRRSowEbQN6H/p
         aUNsW2+IbwA0Q3G7kYkJO2679gs98qiGwCy8AU7TIQ5J42HcAr8/uZYDHlMDgLJwgSdM
         t3drZyVjo4hbGG5tGlmZSsT/K3OVgs4pZlSLZDlzAeMh0DR+3zB0YArA7v8/Q3NaSyAy
         wIDi7QDlO6uWxeXZkfZRTsSGBs2RTiThdFdUop9xefCTEC49ZW3/39gKcxojKAyTL+j+
         3N0sdIGy0CLWJsN/lt9XyzbUYpBuZFhrQCoPRUSFmVU2oozpDmWtVu7NxJU28n00sLff
         GgAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769180306; x=1769785106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eEedmtOY7Y8eJ9xgbPCCWxatDC0k0Q8serp7IKoqpeM=;
        b=AyU09sQkCyUmzCy16acDbZ7HQ56r/Pi44R0UkDBtnV7SIRDfieGRkbF2vRW2QOI4N1
         FbU9JfmAEgvBPH53Vv4NbG5fa1Lw6l7RmYLCyep/nzmzXv9DgzdQ9H748Xp6U27YY+Sb
         ypFInR+BnKvG4bZz73tdCk77GcoUL1CvFz/MDMIaAPJLMY3Nk/quGbJ9+v2hOIIpamDs
         D4Q1WHW/gghDpjVYNCeFsWtrMCTcKwwJEi+JzQhZwuo/IHTKceLEX3JNkizOVJzgR917
         LmPn2xh+1/E4448UdvCmwVhsUkxJJE+Pwfzmc3nkMZKxKrsfkKbeGkzZH+b+5TII+ujz
         tmsw==
X-Forwarded-Encrypted: i=1; AJvYcCXJ/bQJ7mc4kd+2HlU6yRSBG8Fad0VFe5jV35f5ru8mYQ6y34vlNhe4FS7YUj4XXdRCLtvKxGm40aRfhBYU@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5AOgpVGJMMco60HzR2/AaXOd6HxNMOHWvKXW8mnIASuERN/KQ
	EvVbSpY6QhjDTDzIx7dK2+wRiHQ2lkVDSezSfhBcc3iCw+crZdWgIynWEnQbUA==
X-Gm-Gg: AZuq6aLVUqkWoLerKqCLao1Tt/LLYthVYAMeLVQucfZGyBAwX0pkymnwUV8XbCQcASy
	k6f0XFWB22E2ShJzjeyC98ldvpFpd+dRzKUiO/ZTHW0T7h9EWYykr/Yo6laZ8TxeU/lZTfMA3e2
	x6taWCbPUQXGXdgumi/CCLGyom9jv0DxEoSXKjh5cIaBHELe7v4HDQR523nAhKyiDpcg3kjx78G
	kjUoZKFTotMZ09yEgGuk2hKxM0Y8eWByZBJfysMOey110u6RwzBP7yfB/5kLNdH9n60SWRE3Kf0
	uOlc+SfbfaI2HbhFGfwAmHboSlKVynUI5scJ7r4iqh7uO6/PV7qmOljVssAXjpKg7t93a+sxsXj
	tCAybzCJ3yDfZ+msgCObXDQ+8fBx/MEj8zwQ8ZpYRgwGiTHGxGC/zAHR1+rOgvHNUxZTld1wUBc
	rC3HmRDXB+/2w=
X-Received: by 2002:a05:6a21:3944:b0:366:14b0:1a41 with SMTP id adf61e73a8af0-38e6f8297c7mr3334491637.79.1769180305734;
        Fri, 23 Jan 2026 06:58:25 -0800 (PST)
Received: from inspiron ([111.125.231.221])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c635a42e8ecsm2290372a12.32.2026.01.23.06.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 06:58:25 -0800 (PST)
Date: Fri, 23 Jan 2026 20:28:13 +0530
From: Prithvi <activprithvi@gmail.com>
To: Dmitry Bogdanov <d.bogdanov@yadro.com>
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
	hch@lst.de, jlbec@evilplan.org, linux-fsdevel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com, khalid@kernel.org,
	syzbot+f6e8174215573a84b797@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] scsi: target: Fix recursive locking in
 __configfs_open_file()
Message-ID: <20260123145813.wamnt62fwh2ihtur@inspiron>
References: <20260108191523.303114-1-activprithvi@gmail.com>
 <20260115032012.yb5ylmumcirrmsbr@inspiron>
 <20260122095634.GA15012@yadro.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122095634.GA15012@yadro.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75299-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[oracle.com,vger.kernel.org,lst.de,evilplan.org,lists.linux.dev,linuxfoundation.org,gmail.com,kernel.org,syzkaller.appspotmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[activprithvi@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,f6e8174215573a84b797];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,yadro.com:email,appspotmail.com:email]
X-Rspamd-Queue-Id: 273F777605
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 12:56:34PM +0300, Dmitry Bogdanov wrote:
> On Thu, Jan 15, 2026 at 08:50:12AM +0530, Prithvi wrote:
> > 
> > On Fri, Jan 09, 2026 at 12:45:23AM +0530, Prithvi Tambewagh wrote:
> > > In flush_write_buffer, &p->frag_sem is acquired and then the loaded store
> > > function is called, which, here, is target_core_item_dbroot_store().
> > > This function called filp_open(), following which these functions were
> > > called (in reverse order), according to the call trace:
> > >
> > > down_read
> > > __configfs_open_file
> > > do_dentry_open
> > > vfs_open
> > > do_open
> > > path_openat
> > > do_filp_open
> > > file_open_name
> > > filp_open
> > > target_core_item_dbroot_store
> > > flush_write_buffer
> > > configfs_write_iter
> > >
> > > Hence ultimately, __configfs_open_file() was called, indirectly by
> > > target_core_item_dbroot_store(), and it also attempted to acquire
> > > &p->frag_sem, which was already held by the same thread, acquired earlier
> > > in flush_write_buffer. This poses a possibility of recursive locking,
> > > which triggers the lockdep warning.
> > >
> > > Fix this by modifying target_core_item_dbroot_store() to use kern_path()
> > > instead of filp_open() to avoid opening the file using filesystem-specific
> > > function __configfs_open_file(), and further modifying it to make this
> > > fix compatible.
> > >
> > > Reported-by: syzbot+f6e8174215573a84b797@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=f6e8174215573a84b797
> > > Tested-by: syzbot+f6e8174215573a84b797@syzkaller.appspotmail.com
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Prithvi Tambewagh <activprithvi@gmail.com>
> > > ---
> > >  drivers/target/target_core_configfs.c | 13 +++++++------
> > >  1 file changed, 7 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
> > > index b19acd662726..f29052e6a87d 100644
> > > --- a/drivers/target/target_core_configfs.c
> > > +++ b/drivers/target/target_core_configfs.c
> > > @@ -108,8 +108,8 @@ static ssize_t target_core_item_dbroot_store(struct config_item *item,
> > >                                       const char *page, size_t count)
> > >  {
> > >       ssize_t read_bytes;
> > > -     struct file *fp;
> > >       ssize_t r = -EINVAL;
> > > +     struct path path = {};
> > >
> > >       mutex_lock(&target_devices_lock);
> > >       if (target_devices) {
> > > @@ -131,17 +131,18 @@ static ssize_t target_core_item_dbroot_store(struct config_item *item,
> > >               db_root_stage[read_bytes - 1] = '\0';
> > >
> > >       /* validate new db root before accepting it */
> > > -     fp = filp_open(db_root_stage, O_RDONLY, 0);
> > > -     if (IS_ERR(fp)) {
> > > +     r = kern_path(db_root_stage, LOOKUP_FOLLOW, &path);
> > > +     if (r) {
> > >               pr_err("db_root: cannot open: %s\n", db_root_stage);
> > >               goto unlock;
> > >       }
> > > -     if (!S_ISDIR(file_inode(fp)->i_mode)) {
> > > -             filp_close(fp, NULL);
> > > +     if (!d_is_dir(path.dentry)) {
> > > +             path_put(&path);
> > >               pr_err("db_root: not a directory: %s\n", db_root_stage);
> > > +             r = -ENOTDIR;
> > >               goto unlock;
> > >       }
> > > -     filp_close(fp, NULL);
> > > +     path_put(&path);
> > >
> > >       strscpy(db_root, db_root_stage);
> > >       pr_debug("Target_Core_ConfigFS: db_root set to %s\n", db_root);
> > >
> > > base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
> > > --
> > > 2.34.1
> > >
> 
> You missed the very significant thing in the commit message - that this
> lockdep warning is due to try to write its own filename to dbroot file:
> 
> 	db_root: not a directory: /sys/kernel/config/target/dbroot
> 
> That is why the semaphore is the same - it is of the same file.
> 
> Without that explanation nobody understands wheter it is a false positive or not.
> 
> The fix itself looks good.
> 
> Reviewed-by: Dmitry Bogdanov <d.bogdanov@yadro.com> 

Hello Dmitry,

I have sent v2 patch with this change incorporated, however it doesn't
include your Reviewed-by tag. Since your review applies, and the changes
in v2 don't invalidate it, I wanted to confirm if its okay to carry
forward your Reviewed-by tag or if you would prefer to review it agian.

Apologies if this is an obvious point.

Best Regards,
Prithvi

