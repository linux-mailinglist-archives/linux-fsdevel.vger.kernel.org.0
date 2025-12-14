Return-Path: <linux-fsdevel+bounces-71262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEDACBB63E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Dec 2025 03:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73F0F3007E7A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Dec 2025 02:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E372E6CA8;
	Sun, 14 Dec 2025 02:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bo+i4+fZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AAA155389
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Dec 2025 02:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765681139; cv=none; b=clYMLJtLx6x5Etktuc1NXn+kNb9dYDuZkX4WfCggKMEQbBsAxSavbB0gYRTO8QDR7mjKzlCbb/MTxpwIB0pnaiHIDIP6lUc9GU8ze/ab6oOQ97wh0V3FTinYEAH/QJZouOieqOSDERUhfxybdxKChtgOnsCD3r9P817DwnSY1NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765681139; c=relaxed/simple;
	bh=wwfRvi28pL2p+zBQtMegMQj1QE0797HDaDlIpwIIrRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=siC2HvK98hH9zIz3jAkj+xDgw7tHfTolNQcIFkZRxZmAytHrNsi2UWYInOSgWRnVzmDr4pofeAHX5PjhK4lk7PNUqzT6Gq2Ycx8nN7KcWSkRdkfdbHyZotbzmeLLVBlvb+XamdSj9A+9Rf9NmcGMZKEAnzzslFg6SYGmMy3GKdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bo+i4+fZ; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6418b55f86dso3298473a12.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 13 Dec 2025 18:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765681136; x=1766285936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qJ+q7iIue0Tx/Hxz3ZmAPYvL7gomatzvU4K/04hqSKQ=;
        b=bo+i4+fZfKWSeKegntZlAjL2FfMM4Cq967IeQiHaaP+QKIMAoIbCc1pZX68BMmLYRD
         cbO3CHfnnWoplg7Xi7Ai6x/j1I6gYBhzgASlu+LYMTj1jkULRlgTMPEgl0aFlECqO6iJ
         sZ80uVyk0emJGpZdrI06hCehjbjR3RNnkzvTcHkYdzz4T2rMaw2JyVEuJlRsqpbh2ie+
         1o/zSBtf+4rLRoyMcGGE4HQTdokkEe75yQCbuGWMsvolx76+KBQxrdubmZu5TfabUVaH
         vgL1fgAOHnIGCXp36cGRzb9cXrd5Fydw4m7xYidVbxzwf+DFrUvZfYAfW4pn8E82BWSn
         F9Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765681136; x=1766285936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qJ+q7iIue0Tx/Hxz3ZmAPYvL7gomatzvU4K/04hqSKQ=;
        b=PtDF8HmPUYafFbNcSCsxe+JFv+ERLHhq9MkXpFw9KJarkSXsD1xfPvKsG+MqxROqyb
         ZJtWmnI9Z5vnSNAE/pkGuocMDGYE/euN24TKnXyWgp9k0iDvgP53msqPWXcZx/+nqb6A
         SOYE1mI5el6qIGICoGm9xe0hMPnTuDR/Pf4AkJqxvoD13cPM/K8AoSGvMZQe7DYAaIPf
         wqe+lcvb86fqua65XoU8tWHTVJL+Wu/lviePxNAhsz/lNzgnRE2KMPzqdLwfLfwRCUf5
         vmRwiqvQ/kU0mmpEhUVeGGxMvIJ6a2eSlRZg743a4IIgnc38x6wYmGE2/EUPjVEM4zZG
         TxZA==
X-Forwarded-Encrypted: i=1; AJvYcCUebfxn+V7UsFXrhyVoYNIidbkbmQPZ9CTPSvWm3LDizn+5kqyklA1df8TDSxMMQZIeNA49Q8UY5Tfu1250@vger.kernel.org
X-Gm-Message-State: AOJu0YxLAi2+/1tAsSEFKRWpDBB1j+MZsQrio2u3OqPhEfXUXKV7zmgv
	B2H/gn2dqtuzz6gaDInaR9uWegiRTq47dsM+b2rvzrqrAK5c3uSq2c35mWezj5VnQ5phO4dKNBG
	ckshq0uhoL1903rV0bxig+ZJ8lqeWi8E=
X-Gm-Gg: AY/fxX5Z+Bm0sdsb4jYn7dL273/v3eEQM51jvhMsldnAN7kFTyPWrstdIZKH1YeMnAW
	ZiLMoR5gW78Pu7Qh9YYqUPJ73hJCEDjCJdXsYWXa9VuZnsEL8IjDyPdOmhjgndKMkXPbzq1Ltrd
	1G5r5SD7MMN3klJSVXXxutLabkPM2a961qIDAdmc1Y1piSJjOezVunI1JBp2IisYtdtafeF59S0
	SiISR/RD8SW7KMaenJJksoIWrWbGsBejwTsnHiP51EKXPPoCsXmKsT3HI624tjuK7av+Dt1OLzm
	jCzFiUJNxr/PSts7/66anW9Zl0k=
X-Google-Smtp-Source: AGHT+IFw41clhzWHWtnfh7TvuxEY0PoCi7sWkxdmaiOksNC8o7annTwD5roRoc69bNfQZgB8QGhvgM1ZfBvecBJ2qbI=
X-Received: by 2002:a05:6402:440b:b0:640:b978:efdb with SMTP id
 4fb4d7f45d1cf-6499b300da3mr6139779a12.25.1765681136357; Sat, 13 Dec 2025
 18:58:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251213233621.151496-2-eraykrdg1@gmail.com> <20251214013249.GI1712166@ZenIV>
 <20251214020212.GJ1712166@ZenIV> <20251214022745.GK1712166@ZenIV>
In-Reply-To: <20251214022745.GK1712166@ZenIV>
From: Ahmet Eray Karadag <eraykrdg1@gmail.com>
Date: Sun, 14 Dec 2025 05:58:19 +0300
X-Gm-Features: AQt7F2pQoI_D9wi0-mTQfEfKVzUyM9VgmFpnnlK9abWK1VO7vBcnwqZbt7ISmrE
Message-ID: <CAHxJ8O_3CG9vmQcbF7qkG-CXB0423ark2bfYrKvt-HfLYD68BQ@mail.gmail.com>
Subject: Re: [PATCH] adfs: fix memory leak in sb->s_fs_info
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, skhan@linuxfoundation.org, 
	david.hunter.linux@gmail.com, 
	syzbot+1c70732df5fd4f0e4fbb@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Al,

I apologize for overlooking the double-free scenario in the success path.
I focused too narrowly on the failure case provided by the reproducer and
failed to verify the fix against the normal lifecycle.

As a newcomer to kernel development, I truly appreciate you taking the time
to guide me through this analysis. It is a valuable lesson for me on lookin=
g
at the broader lifecycle rather than just the immediate bug.

I will implement the changes you suggested in v2.

Thank you for your patience and the detailed explanation.

Best regards,
Ahmet Eray

On Sun, Dec 14, 2025 at 5:27=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Sun, Dec 14, 2025 at 02:02:12AM +0000, Al Viro wrote:
>
> > IOW, there's our double-free.  For extra fun, it's not just kfree() + k=
free(),
> > it's kfree_rcu() + kfree().
>
> [sorry, accidentally sent halfway through writing a reply; continued belo=
w]
>
> So after successful mount, it gets freed (RCU-delayed) from ->kill_sb() c=
alled
> at fs shutdown.
>
> On adfs_fill_super() failure (hit #2) it is freed on failure exit - with =
non-delayed
> kfree().
>
> In case we never got to superblock allocation, the thing gets freed by ad=
fs_free_fc()
> (also non-delayed).
>
> The gap is between a successful call of sget_fc() and call of adfs_fill_s=
uper()
> (in get_tree_bdev(), which is where adfs_fill_super() is passed as a call=
back).
> If setup_bdev_super() fails, we will
>         * transfer it from fs_context to super_block, so the fs_context d=
estruction
> won't have anything to free
>         * won't free it in never-called adfs_fill_super()
>         * won't free it in ->kill_sb(), since ->s_root remains NULL and -=
>put_super()
> is never called.
>
> A leak is real, IOW.
>
> Getting ->kill_sb() to do freeing unconditionally would cover the gap.  H=
owever,
> to do that, we need to _move_ freeing (RCU-delayed) from adfs_put_super()=
 to
> adfs_kill_sb(), not just add kfree() in the latter.
>
> What's more, that allows to simplify adfs_fill_super() failure exit: we c=
an leave
> freeing asb (and clearing ->s_fs_info, of course) to ->kill_sb() - the la=
tter is
> called on any superblock destruction, including that after failing fill_s=
uper()
> callback.  Almost the first thing done by deactivate_locked_super() calle=
d in
> that case is
>                 fs->kill_sb(s);
>
> So if we go with "have it freed in ->kill_sb()" approach, the solution wo=
uld be
>
> 1) adfs_kill_sb() calling kfree_rcu(asb, rcu) instead of kfree(asb)
> 2) call of kfree_rcu() removed from adfs_put_super()
> 3) all goto error; in adfs_fill_super() becoming return ret; (and error:
> getting removed, that is)

