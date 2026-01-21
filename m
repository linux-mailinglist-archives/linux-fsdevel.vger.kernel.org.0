Return-Path: <linux-fsdevel+bounces-74897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LPmNkI0cWlQfQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 21:17:06 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBF15CFA2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 21:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DE612B4B25D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 18:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFCE3A9DBC;
	Wed, 21 Jan 2026 18:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwDqE+KA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4521039B4BB
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 18:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769020174; cv=none; b=LqyOKP4KOtaDpxcKpgtt22B7dl/eKF9zqg4cwTaN0K6TwDOole+LFu+Z1YXIWRT0GxAer9pXfhu8kNIfksxzr3T+aTfgcKhkXzjKwxvZcpY1et8rV1uVDvVwI9WcMCj5Rty2ma0B63nZkeT7gOI2rDJKvZLRE3/EjQAocprg880=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769020174; c=relaxed/simple;
	bh=rXG5ZKvyvWBHHACzLV8wPF9nuPc1igUArEv0FBWhhds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dp7xbhkH+7RAzdrZevCFnz+3l5Tpeto6efHeZT3dNxU3lgbl/CrMC4Www18odc5gaFmxxZYL1IYsMF5V6kruKqQW3didFN/4GIqasAAuKM5uQg0Ca3hLVekYiBJvIzSK7HaXsrvDjEwA3ZdPWv3R/TZFkMu0tttkFk0WPVK3Sck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EwDqE+KA; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c5e051a47ddso46021a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 10:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769020170; x=1769624970; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tc2r2HxnJJlwpaCSqhrItmuiSzit6sO0uRPjBjoXBAU=;
        b=EwDqE+KA27Jc3Uqnl/XyGQy4encmWk6WZyAQFwLpBnyofdExoWnbyXMjUYoye8Gxu7
         6q7SABpPMN6AMu3LiMk50qXnpz5Wq/KoroGwU7taimXhY/xtlQ2yLf5O/qxpYGxtCi14
         7Nn6M855h4vW3GRH9Ii2U4tTX1YuEO3J+tTvb1lP9Mp9rYudL8nZw1aAd7ZgwCwn0qiM
         STZkZVQ5tHh7C2AV3D7sMze97ajBCwY8RCMRuZkWes8TeYkS8+fQywsVVCoayf7HEEb4
         FZGmccBnS7Ux0J+N2kABXmcQq+lIZKEeZDsp1hKfWpjTFbPX9BTV/ShqFxrpZ1ske37A
         fTdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769020170; x=1769624970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tc2r2HxnJJlwpaCSqhrItmuiSzit6sO0uRPjBjoXBAU=;
        b=FXo7Cofy0CR/HXkqfZUvHIpEgSPs+qEb4SF9uE+5vVIh2WRCvFYOtgITAdrPdiKWqJ
         Zvu59Of5pZYN6cWTRb9Qun6PUtG8mT0PIwq0qY43gGmuaWx1740VRbSv7i020cDfJBo8
         UdOw+ZnmB5ynSDQdoBTP59yQP6Xb3vrpdS4FUN4Npo4gYd81ncCrWuGpfjpydA6KGbwT
         qQnh1qpudOr4Uxx7gJTrrQKGb8Xyo+rNyjTFuXAr8kv7E0+eDPonjdqXfih25rc2soz0
         8SuOY/Qg1mH9yKVD/dsV2gOP9cecFqyT7ut809pyea5eIk5em4332jE65J3OTyiyuGrL
         GlPw==
X-Forwarded-Encrypted: i=1; AJvYcCVDDksnGFh2uLhWK8f81MvEKm0/jps3oljJzvUvLSee0Qubx3NXPcz24UpT70UxKhR6wNQJOI7i5KoK0GM0@vger.kernel.org
X-Gm-Message-State: AOJu0YxrSiUYPCrbtRW2+rwDRPUBXPDAVtv0vMaE/8ofQCXEkgpzlYwa
	l6yg78ZnLCP0X85mZisQ3eEl0scJysbiWqNKpoCCEd5W9Kg4jQomXf3a
X-Gm-Gg: AZuq6aIU5i3pg3AL8ErwLj6wpOXcpQ47/z9Ga+gnaR54G0Lu2kcqxuh32PzGKDbklSg
	wVtWAfrnBGzOLY4Q5tjdZ+xxtDgQkvEsUbZwQNqjQOBUVwyV5jMrq0DkvlB2JTSZb5Ps0NKLR77
	wgTRXRgp9U8hJ6U43dij+on48Xl3DzsIB4BHL8+Zu73cuoU6kQIt6TOlXHKIoFWG8Gsdk7NkEQN
	3X46Kme1Lsxmrkc89HJE41/cyOIcq9dvOiZjIyCvOoKGSPQD9WpmmmOEtTRuwY2qe2LgBLvW6Ih
	LvBo5+neU7WA6cEe3XkX4iDdtKuej4lT0GJ/AOAD4dIl0D/n0I3mB/F4DGMgbkK0G3+KPKOTpJu
	Wvw8n8Z+5Aw/FrSE4ymgWEQXXmH1sZasoQZYqxd+nlofeQ1fJvEigZbhcugGOPWXfhWSbQJL67D
	a+ZBvhP9GBaoE=
X-Received: by 2002:a05:6a21:3395:b0:366:19e9:8a3c with SMTP id adf61e73a8af0-38e00bf6c7bmr19050575637.2.1769020170290;
        Wed, 21 Jan 2026 10:29:30 -0800 (PST)
Received: from inspiron ([111.125.231.221])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf37a7b0sm12838994a12.33.2026.01.21.10.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 10:29:30 -0800 (PST)
Date: Wed, 21 Jan 2026 23:59:20 +0530
From: Prithvi <activprithvi@gmail.com>
To: a.hindborg@kernel.org, leitao@debian.org
Cc: bvanassche@acm.org, martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org, hch@lst.de, jlbec@evilplan.org,
	linux-fsdevel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
	khalid@kernel.org,
	syzbot+f6e8174215573a84b797@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] scsi: target: Fix recursive locking in
 __configfs_open_file()
Message-ID: <20260121182920.hfen6vsf5o27wi3z@inspiron>
References: <20260108191523.303114-1-activprithvi@gmail.com>
 <2f88aa9b-b1c2-4b02-81e8-1c43b982db1b@acm.org>
 <20260119185049.mvcjjntdkmtdk4je@inspiron>
 <ac604919-1620-4fea-9401-869fd15f3533@acm.org>
 <20260121175136.2ku57xskhwwg7syz@inspiron>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121175136.2ku57xskhwwg7syz@inspiron>
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[acm.org,oracle.com,vger.kernel.org,lst.de,evilplan.org,lists.linux.dev,linuxfoundation.org,gmail.com,kernel.org,syzkaller.appspotmail.com];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74897-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[activprithvi@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,f6e8174215573a84b797];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 4EBF15CFA2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 11:21:46PM +0530, Prithvi wrote:
> On Tue, Jan 20, 2026 at 05:48:16AM -0800, Bart Van Assche wrote:
> > On 1/19/26 10:50 AM, Prithvi wrote:
> > >   Possible unsafe locking scenario:
> > > 
> > >         CPU0
> > >         ----
> > >    lock(&p->frag_sem);
> > >    lock(&p->frag_sem);
> > The least intrusive way to suppress this type of lockdep complaints is
> > by using lockdep_register_key() and lockdep_unregister_key().
> > 
> > Thanks,
> > 
> > Bart.
> 
> Hello Bart,
> 
> I tried using lockdep_register_key() and lockdep_unregister_key() for the
> frag_sem lock, however it stil gives the possible recursive locking
> warning. Here is the patch and the bug report from its test:
> 
> https://lore.kernel.org/all/6767d8ea.050a0220.226966.0021.GAE@google.com/T/#m3203ceddf3423b7116ba9225d182771608f93a6f
> 
> Would using down_read_nested() and subclasses be a better option here?
> 
> I also checked out some documentation regarding it and learnt that to use
> the _nested() form, the hierarchy among the locks should be mapped
> accurately; however, IIUC, there isn't any hierarchy between the locks in
> this case, is this right?
> 
> Apologies if I am missing something obvious here, and thanks for your 
> time and guidance.
> 
> Best Regards,
> Prithvi

Hello Andreas and Breno,

This thread is regarding a patch for fixing possible deadlock in 
__configfs_open_file(); here is its dashboard link:

https://syzkaller.appspot.com/bug?extid=f6e8174215573a84b797

Firstly, flush_write_buffer() is called, which acquires frag_sem lock, 
and then it calls the loaded store function, which, in this case, is
target_core_item_dbroot_store(). target_core_item_dbroot_store() calls
filp_open(), which ultimately calls configfs_write_iter() and in it, 
the thread tries to acquire frag_sem lock again, posing a possibility of
recursive locking.

In the initial patch, I tried to fix this by replacing the call to 
filp_open() in target_core_item_dbroot_store() with kern_path(), since 
it performs the task of checking if the file path exists, rather than 
opening the file using configfs_write_iter(). This also avoids acquiring 
frag_sem in nested manner and thus possibiliy of recursive locking is 
prevented.

After checking I found 3 functions where down-write() is used, which, 
IIUC they might contribute to recursive locking:

1. configfs_rmdir() - calls down_write_killable(&frag->frag_sem)
2. configfs_unregister_group() - calls down_write(&frag->frag_sem);
3. configfs_unregister_subsystem() - calls down_write(&frag->frag_sem);

Bart suggested that this can be a fals positive and can be solved using
lockdep_register_key() and lockdep_unregister_key(). However, on trying
this approach, the possibile recursive locking warning persisted, it can 
be found here:

https://lore.kernel.org/all/6767d8ea.050a0220.226966.0021.GAE@google.com/T/#m3203ceddf3423b7116ba9225d182771608f93a6f

IIUC, we can then use down_read_nested() and lock subclasses here; but,
according to documentation:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/locking/lockdep-design.rst#n230

I learnt that to use the _nested() form, the hierarchy among the locks 
should be mapped accurately; however, from the lockdep documentation, 
my understanding is that there isn't any hierarchy between the locks 
in this case.

Your guidance on whether the kern_path based fix is the right direction here, 
or if there is a more appropriate way to handle this from a configfs or VFS 
point of view would be very valuable.

Thank you for your time and guidance.

Best Regards,
Prithvi

