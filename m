Return-Path: <linux-fsdevel+bounces-36655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA29A9E7618
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 17:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3698016D7E5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 16:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B9421AAB6;
	Fri,  6 Dec 2024 16:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qa11aSgb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509CB21AA99
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Dec 2024 16:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733502690; cv=none; b=eF/mttoh7+8a057+ZZY/NzlFtaVpYaJwiDX97CHbj9shGblJYpPop/BK+ns4uFOhCCCd3IM0PN2fBmcKqPrEFUTjgLEKA2tMKNBXQfGqoZka94OwgRPeGXT4sgCjnPP9fUYzayL0Cp/VPUGKJX2nV9G6H8dhxmVid5tnrP/CklM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733502690; c=relaxed/simple;
	bh=IKozF9Mftax0AieO0Y9j1HejthqPw+VQWZeRhstxAyI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u4UGjyucYYcEaQqvPZarhN0395XtYJGeEY179cpbz0Bs4Gr2QIoNaMLgG36emBPAWI1DDRtaLCQAQ/JUVCPITPlf4lGFSGzxM6VtDynb3r7kF+7AzrjcFWiCywiDZHGEcpJV9tuxhmx3NACs0Y5kWSMgbOZAY45GNA8dGWv8+mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qa11aSgb; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b672a70f4eso190591485a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Dec 2024 08:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733502687; x=1734107487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:list-unsubscribe
         :list-subscribe:list-id:precedence:references:in-reply-to:message-id
         :date:subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JYKZQc3pbAXh4ofh6JZ/rb/JinDxcB2guaf9yNNOuFc=;
        b=Qa11aSgbRn2ai9bUCl149MoG8HEDwlPpSsmZq3DH08pEqtDw8BQAkhKO5aPPBoJCbk
         5PAi7HcNtxcj8XKqMH6KU7aAsScScRMleb46mZY7YlFEUkT1ZNvP5+4s4MT5pwbUO7Z0
         RBFUPpT7PedGzu8ScoV/fXJ64MLUjG6JGJiG1Lg9sg1809Yg1slkBFr5/yljG9AqsmI8
         djZP984cRUmySQNnPsDp2p6CEIa0Fwf64ysyW1sEih5vg+osEO9o2MgFuJ8FzheclFJr
         EzvTgsicdvWEIRQFhzjnMIBgdcR0W2B/cgPYRPtccdakZUIEgV8qkxcexDwzFw4aDdC6
         SOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733502687; x=1734107487;
        h=content-transfer-encoding:mime-version:list-unsubscribe
         :list-subscribe:list-id:precedence:references:in-reply-to:message-id
         :date:subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYKZQc3pbAXh4ofh6JZ/rb/JinDxcB2guaf9yNNOuFc=;
        b=Eibjf8wtt/r0fzivQ4sCbBY1b/eR1QTCDzjmo4+DeRjMSbPWqAE79O1GnEevnMT3ZD
         HY3sz36mRItojk3/YHrbLCCyOAuEXM0NWIo8LyBGLbcVzNWuDgXunqJOyX4z1Fx0y+Kl
         nn0YqsvO8XVhOBYdQFGkv5ou3EuRJ+FmrJKY2orrRg8iTpApwKb3imX77iX6ZELZe/FV
         ps/jy9akpnxVLVXrI2C9ptLV38RhSkvdbkbFW8Yy/gkKbba8ITMjOuB6MEDk/xN0YgEY
         bLDQafzwzx5yuS5iKy/81saXDvRmLWj3SzpZqryJA8WZj1JMsWFvuZGPtFuRSK4HJHtQ
         Ny6w==
X-Forwarded-Encrypted: i=1; AJvYcCXoJcdMrWUMcLg0LpWzJDYsBuhA43Jj7pcXoQ+Ojo2WY9oWB9Ua+qpG/NRiwv+g3x4v5LBsdTfGX7opDUyg@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/EyJ85RPrVGZQ+sno7ld9Yan+A9lirhzHXcoggK9xuvgHppWC
	teksXqCo0YF78Ew4l2rygRquiB6RP6ozH1d7TLcTF2lzvQPXH5RS
X-Gm-Gg: ASbGnctOH1exYINskzUl0PPoS9cRHdPWVcUVDLt9mB6YQclTLuM0JW7h80FdReNR6xG
	1ajDmaAJOdWr/t+UI3HfyUBxt+Nmcu+tstnJfMapx3dEHrggtXI0UqfQIDNBK3xyjJBWlEMZ4h9
	JYPSZPIrY91XTuma64hhJjRByAM7Bj2twXOGJYz1M9erPwzobePtiI26EFG4eIQ+f5YX/GkM9Qu
	9cEC6Nr+xA9SpLRUjMUKCZWtJ7vOWIHJcoM8iAe3OHNGsfvTOfVZsd/0nyMAbQEOJ01rKGBcOVD
	TkEWBDLQnqF4ADP8MxR8IGW2F6TSAy6Tk0NdV4wQmKR5+fZYHmEuta6Y
X-Google-Smtp-Source: AGHT+IH/Ibd9nmtnFDdrpkXOXoOb9c9oXSbBE/QSWUA8VvIxnCDwop4X0c17ZCRFP2wBynZ/jp59XA==
X-Received: by 2002:a05:620a:4144:b0:7b1:2016:7775 with SMTP id af79cd13be357-7b6bcaf3582mr584907585a.36.1733502687071;
        Fri, 06 Dec 2024 08:31:27 -0800 (PST)
Received: from localhost.localdomain (lnsm3-toronto63-142-127-175-73.internet.virginmobile.ca. [142.127.175.73])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6b5a5b22csm187728585a.32.2024.12.06.08.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 08:31:26 -0800 (PST)
From: Etienne Martineau <etmartin4313@gmail.com>
To: joannelkoong@gmail.com,
	miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: bernd.schubert@fastmail.fm,
	bschubert@ddn.com,
	jefflexu@linux.alibaba.com,
	josef@toxicpanda.com,
	kernel-team@meta.com,
	laoar.shao@gmail.com
Subject: [PATCH RESEND v9 2/3] fuse: add optional kernel-enforced timeout for requests
Date: Fri,  6 Dec 2024 11:30:26 -0500
Message-Id: <20241114191332.669127-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241114191332.669127-1-joannelkoong@gmail.com>
References: <20241114191332.669127-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joanne Koong <joannelkoong@gmail.com>

> There are situations where fuse servers can become unresponsive or
> stuck, for example if the server is deadlocked. Currently, there's no
> good way to detect if a server is stuck and needs to be killed manually.

I tried this V9 patchset and realized that upon max_request_timeout the connection will be dropped irrespectively if the task is in D state or not. I guess this is expected behavior.
To me the concerning aspect is when tasks are going in D state because of the consequence when running with hung_task_timeout_secs and hung_task_panic=1.

> 
> This commit adds an option for enforcing a timeout (in minutes) for
> requests where if the timeout elapses without the server responding to
> the request, the connection will be automatically aborted.
> 
> Please note that these timeouts are not 100% precise. The request may
> take an extra FUSE_TIMEOUT_TIMER_FREQ seconds beyond the requested max
> timeout due to how it's internally implemented.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Reviewed-by: Bernd Schubert <bschubert@ddn.com>
> ---
>  fs/fuse/dev.c    | 80 ++++++++++++++++++++++++++++++++++++++++++++++++
>  fs/fuse/fuse_i.h | 21 +++++++++++++
>  fs/fuse/inode.c  | 21 +++++++++++++
>  3 files changed, 122 insertions(+)
> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 29fc61a072ba..536aa4525e8f 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -45,6 +45,82 @@ static struct fuse_dev *fuse_get_dev(struct file *file)
>  	return READ_ONCE(file->private_data);
>  }
>  
> +static bool request_expired(struct fuse_conn *fc, struct fuse_req *req)
> +{
> +	return jiffies > req->create_time + fc->timeout.req_timeout;
> +}
> +
> +/*
> + * Check if any requests aren't being completed by the specified request
> + * timeout. To do so, we:
> + * - check the fiq pending list
> + * - check the bg queue
> + * - check the fpq io and processing lists
> + *
> + * To make this fast, we only check against the head request on each list since
> + * these are generally queued in order of creation time (eg newer requests get
> + * queued to the tail). We might miss a few edge cases (eg requests transitioning
> + * between lists, re-sent requests at the head of the pending list having a
> + * later creation time than other requests on that list, etc.) but that is fine
> + * since if the request never gets fulfilled, it will eventually be caught.
> + */
> +void fuse_check_timeout(struct timer_list *timer)
> +{
> +	struct fuse_conn *fc = container_of(timer, struct fuse_conn, timeout.timer);
Here this timer may get queued and if echo 1 > /sys/fs/fuse/connections/'nn'/abort is done at more or less the same time over the same connection I'm wondering what will happen?
At least I think we may need timer_delete_sync() instead of timer_delete() in fuse_abort_conn() and potentially call it from the top of fuse_abort_conn() instead.

> +	struct fuse_iqueue *fiq = &fc->iq;
> +	struct fuse_req *req;
> +	struct fuse_dev *fud;
> +	struct fuse_pqueue *fpq;
> +	bool expired = false;
> +	int i;
> +
> +	spin_lock(&fiq->lock);
Do we need spin_lock_irq instead bcos this is irq context no?

>  
> +static void fuse_init_fc_timeout(struct fuse_conn *fc, struct fuse_fs_context *ctx)
> +{
> +	if (ctx->req_timeout) {
> +		if (check_mul_overflow(ctx->req_timeout * 60, HZ, &fc->timeout.req_timeout))
> +			fc->timeout.req_timeout = ULONG_MAX;
> +		timer_setup(&fc->timeout.timer, fuse_check_timeout, 0);
> +		mod_timer(&fc->timeout.timer, jiffies + FUSE_TIMEOUT_TIMER_FREQ);
> +	} else {
> +		fc->timeout.req_timeout = 0;
> +	}
> +}
> +
>  int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
>  {
>  	struct fuse_dev *fud = NULL;
> @@ -1753,6 +1773,7 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
>  	fc->destroy = ctx->destroy;
>  	fc->no_control = ctx->no_control;
>  	fc->no_force_umount = ctx->no_force_umount;
> +	fuse_init_fc_timeout(fc, ctx);

The max_request_timeout is latched in fc->timeout.req_timeout during fuse_fill_super_common() so any further modification are not taking into effect
Say:
 sudo bash -c 'echo 100 > /proc/sys/fs/fuse/max_request_timeout'
 sshfs -o allow_other,default_permissions you@localhost:/home/you/test ./mnt
 kill -STOP `pidof /usr/lib/openssh/sftp-server`
 ls ./mnt/
 ^C
  # Trying to change back the timeout doesn't have any effect
 sudo bash -c 'echo 10 > /proc/sys/fs/fuse/max_request_timeout'

Thanks


