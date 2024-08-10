Return-Path: <linux-fsdevel+bounces-25590-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 303A194DC00
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2024 11:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0F7A2820AB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2024 09:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88CA14D714;
	Sat, 10 Aug 2024 09:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbrFb+tH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E4F43ACB
	for <linux-fsdevel@vger.kernel.org>; Sat, 10 Aug 2024 09:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723282605; cv=none; b=On7yNAhA889IA7im5E9RYGdJNPb+wT/gQ6b7sVJxhctxBptG/ScZAnDuDJejHgGQvceKR9ByfR60o84EnFtrzkL+4i9H2CYjGOVBc+HHiD25k6HtH6OUE44+0v+0ryyjY8kJH3y4lTe+3nJh7eJbCpMpuZDSAThr2qKKgBTn4/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723282605; c=relaxed/simple;
	bh=TCWNY5v+WntrG/qjrMGNjXNmsLZK5TyaKRojN4p135M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VzITYPQeiTuR7PG3hVeMX3RzBERPw2mSZf49xSn14Csg4lRLm1vHokuaMfSPY7WbscOr7xrvoF+Ng4lvVxUpcu6ky5ufWmX1WenZXergLpKKOjFykjnngOXpoMvxaBK0fzh8tTKC/rHLODoP3StqhlVEvTq9s/gbFGngAXQ+wqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FbrFb+tH; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5afa207b8bfso2911243a12.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Aug 2024 02:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723282602; x=1723887402; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xaEEX/IgmGllSzPdescFTCnAysQGeKBTUd/W3DGc5C0=;
        b=FbrFb+tH288n44wVbJ4Sc5OCvRg8gLx6nUFWb3ULXGMpYiMvsRGtzSGX+8eZ5owqOZ
         GSK2/wO4BZgM7pgnvQ6uYdyE93cKC0e0J3IHeTzHBp5geFWYiNx8HeGF0XW6eDFonKoN
         EOd++iBREvIksm3ySr9r6KGN+DDI4KPtSA9pHm2ml8rjgKyInFoqyBqzalTqtRxxyA/S
         I2uN3aQbgI/6DXVpS3bPM3nsDAoAKyuzLRjYNhFoQx81GSMzRKAtm20K6cGeOcPpwtsP
         M5slQEdpy8vIl+oX31xZ1eyLOEpTsXX8YY1VYWZKus3xNGaCvVrrhaAUHXWXBHkIkfCT
         XnIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723282602; x=1723887402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xaEEX/IgmGllSzPdescFTCnAysQGeKBTUd/W3DGc5C0=;
        b=lLBEBldohzcSE7TsXLXcgYGNHHoEmCkAteRyf9j+qKuxKE0l3YfBihmvq8gt3i3YqC
         BTiwAWErDvgdBPAbdDCj/Bj11ZqVe8iHF/rhPgiKMg7yhsoYLrzSQ+d16XNt0j73EHPN
         JBv4IuLgFge3//eJzc9wOA+Qd5Hn64+bvW2qC0HnGBcWRJDraW7Ycg/V3OhZyvNME0u2
         haTdneQBNImvRbhFjjP+2Y3wFCL45WNgOngL1iMNyidzarkPxyOtF0mu8kIfrxyECh7E
         U7lfuMcdnes5jrlfpq9q2XMJlsEP1iDBdTXZHTfrD8kvQV/KVwLGHMleG9O/Fyy+XxjT
         pTTQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0KWES5S/Qok4gV7yGlvdgFfV34dpTQIZczvSyFe6+ZBqzAmSC2UY4UzgTdXqiyoZnN1HeUU89W14QpcKg8KYqQzgwgSC2vQCiUpdGGQ==
X-Gm-Message-State: AOJu0Ywttty7BEbK2cliE2PSCzXkYRQubROu3Vw7UmccLK0yOp8GAXvP
	znQyhBpd9DoUSdv9XfLJI0+78xz5ywG1aSs7sBBGFjwP3uie4x9O
X-Google-Smtp-Source: AGHT+IG43O4oTkOqaXKUdmrLasOOTA/+oKA9+wi6xdvpTL3aC7oB6gFQuCtNh8HCa/oNRNavY4p0mw==
X-Received: by 2002:a17:907:f160:b0:a72:8d2f:859c with SMTP id a640c23a62f3a-a80aa5e006dmr287031266b.33.1723282601325;
        Sat, 10 Aug 2024 02:36:41 -0700 (PDT)
Received: from f (cst-prg-72-52.cust.vodafone.cz. [46.135.72.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb1d1ac6sm54457466b.131.2024.08.10.02.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Aug 2024 02:36:40 -0700 (PDT)
Date: Sat, 10 Aug 2024 11:36:32 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>, 
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] [DRAFT RFC]: file: reclaim 24 bytes from f_owner
Message-ID: <6o2fjmgt2yixzjwc2fffzdtbr4cjey3vhm6kwpieag33kzmmga@5ogofkglj2hj>
References: <20240809-koriander-biobauer-6237cbc106f3@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240809-koriander-biobauer-6237cbc106f3@brauner>

On Fri, Aug 09, 2024 at 10:10:40PM +0200, Christian Brauner wrote:
> This is in rough shape. I just drafted it quickly to get the idea
> across. Compiled with all the SANS we have, booted and ran parts of LTP
> and so far nothing murderd my vms. /me goes to get some sleep
> 
> The struct fown_struct wastes 32 bytes of precious memory in struct
> file. It is often unused in a lot of workloads. We should put the burden
> on the use-cases that care about this and make them allocate the struct
> on demand. This will allow us to free up 24 bytes in struct file.
> 

Here is an alternative which smaller saving, but also less work, noting
it here just in case. Commentary on the patch is after that.

On my kernel pahole says the following about struct file:
[snip]
        /* --- cacheline 1 boundary (64 bytes) --- */
        loff_t                     f_pos;                /*    64     8 */
        unsigned int               f_flags;              /*    72     4 */

        /* XXX 4 bytes hole, try to pack */

        struct fown_struct         f_owner;              /*    80    32 */
        const struct cred  *       f_cred;               /*   112     8 */
        struct file_ra_state       f_ra;                 /*   120    32 */
        /* --- cacheline 2 boundary (128 bytes) was 24 bytes ago --- */
[snip]

And of course:
struct fown_struct {
        rwlock_t                   lock;                 /*     0     8 */
        struct pid *               pid;                  /*     8     8 */
        enum pid_type              pid_type;             /*    16     4 */
        kuid_t                     uid;                  /*    20     4 */
        kuid_t                     euid;                 /*    24     4 */
        int                        signum;               /*    28     4 */

        /* size: 32, cachelines: 1, members: 6 */
        /* last cacheline: 32 bytes */
};

So *some* saving can be achieved without moving stuff out.

1. there is no way using a rwlock is warranted, a spinlock is 4 bytes

Moving the lock to the end in this struct and placing f_flags *after*
f_owner should result in plugging the alignment gap.

2. enum pid_type would fit in one byte no problem, there is very opts
defined there. compilers support specifying enum size, but there is a
lot of bikeshedding possible around implementing it and I have no
interest in fighting that, fwiw in FreeBSD this landed as follows:

/* declare */
__enum_uint8_decl(vstate) {
        VSTATE_UNINITIALIZED,
        VSTATE_CONSTRUCTED,
        VSTATE_DESTROYING,
        VSTATE_DEAD,
        VLASTSTATE = VSTATE_DEAD,
};

/* use */
__enum_uint8(vstate) v_state;

/* implementation */
#define __enum_uint8_decl(name) enum enum_ ## name ## _uint8 : uint8_t
#define __enum_uint8(name)      enum enum_ ## name ## _uint8

as a hack here you could merely enum pid_type:uint8_t pid_type; or
similar

3. signum does not have to be int either, sounds like another one-byter

then this results in 6 bytes of padding which may or may not be possible
to fill in in struct file later.

> +struct fown_struct nop_fown_struct = {
> +	.lock		= __RW_LOCK_UNLOCKED(nop_fown_struct.lock),
> +	.pid		= NULL,
> +	.pid_type	= PIDTYPE_MAX,
> +	.uid		= INVALID_UID,
> +	.euid		= INVALID_UID,
> +	.signum		= 0,
> +};

why this instead of NULL checking?

For funcs which are not guaranteed to see the thing already allocated
you can still:
	f_owner = file_f_owner_allocate(filp);
	if (IS_ERR(f_owner))
		return PTR_ERR(f_owner);

while for funcs where it is optionally present you just
	if (filp->f_owner != NULL) ....

am I missing something here?

that aside error handling as implemented is weirdly inconsistent -- you
got ERR_CAST(fowner), PTR_ERR(fowner) and -ENOMEM.

> +
> +/*
> + * Allocate an file->f_owner struct if it doesn't exist, handling racing
> + * allocations correctly.
> + */
> +struct fown_struct *file_f_owner_allocate(struct file *file)
> +{
> +	struct fown_struct *f_owner;
> +
> +	f_owner = smp_load_acquire(&file->f_owner);

For all spots of the sort you don't need an acquire fence, a consume
fence is sufficient which I believe in Linux is guaranteed to be
provided with READ_ONCE. I failed to find smp_load_consume, presumably
for that reason.

> +struct fown_struct *file_f_owner_allocate(struct file *file)
> +{
> +	struct fown_struct *f_owner;
> +
> +	f_owner = smp_load_acquire(&file->f_owner);
> +	if (f_owner != &nop_fown_struct)
> +		return NULL;
> +
> +	f_owner = kzalloc(sizeof(struct fown_struct), GFP_KERNEL);
> +	if (!f_owner)
> +		return ERR_PTR(-ENOMEM);
> +
> +	rwlock_init(&f_owner->lock);
> +	f_owner->file = file;
> +	/* If someone else raced us, drop our allocation. */
> +	if (unlikely(cmpxchg(&file->f_owner, &nop_fown_struct, f_owner) !=
> +		     &nop_fown_struct)) {
> +		kfree(f_owner);
> +		return NULL;

this wants to return the found pointer, not NULL

> +	}
> +
> +	return f_owner;
> +}

