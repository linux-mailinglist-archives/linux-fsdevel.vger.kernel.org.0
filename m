Return-Path: <linux-fsdevel+bounces-36182-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 065A39DF049
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2024 13:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A083C1633E7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2024 12:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C889D197531;
	Sat, 30 Nov 2024 12:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfJvP2z1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8381474D3;
	Sat, 30 Nov 2024 12:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732969340; cv=none; b=lIqJr+ZMn2SX0YPMiAnab3/JX+1oKD05UZ+StEEkBSjg3lpLTShHyY/wGePPQhmFzwQgyKWowJDxrXewYrvkEkM06/D9VV0907E+2o7xcsMMLoFKNhBdmFBBJbk9/3yNk4uWluiY5oiocQc9V386ihgpg3lEOzISGNq++PcY+qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732969340; c=relaxed/simple;
	bh=C49EjLtQSVvotvQ7l1FJmOzGw4tfqiQPXKNC30ME6hI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ex8ul2Sd0WWianyF74Ddd3eeCDRp6xH2vZRGYuEEXscbUgFM68zY2riMjCZl/P4xHhxZ1NufmX+sPri3nf/JcL5UDCaP5BZaTivOix7zQNH65zzGpojywBzHhsBpjwTTq/CliOLJ3urWUjC09n+d7C6Nr4LRcJMUPakSelevaK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfJvP2z1; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5cf9ef18ae9so6526634a12.1;
        Sat, 30 Nov 2024 04:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732969337; x=1733574137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C49EjLtQSVvotvQ7l1FJmOzGw4tfqiQPXKNC30ME6hI=;
        b=hfJvP2z1FaDsy6oMfUbdAf9C39Jm3EwLzexdrvgAReMyfU6KRZ2QDwLGzjO2umDgBe
         vCDJQdV5GQkrJj2VHuraX0hcmNEBC4fjZoUg/KergitU7jtrYfgrQOnt3Yn3N6Sb1hGw
         oYISFgfZzGIyRZ4ncaFer4Cc0GzWybj4I7dcrVBWaD/b5ri+h9TPQm+v35zLPtvQ5wcw
         gJEv986ObUTG8Vo6qVuePVNeIK9CqJlHkpTPmkMPCsTnzTykIIgRwuLb0kAwddA2Mm/g
         pOCfGZBkZak9Ix1MGWHwUCjZ8mqnazXExYxMpm4vRZoOgQvjJb/cZl2DQBn5aKo4aG24
         qSAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732969337; x=1733574137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C49EjLtQSVvotvQ7l1FJmOzGw4tfqiQPXKNC30ME6hI=;
        b=jUzAr41dbZf/wrmoystkcxZOTEZpf1OaSNclIB205Zb/i/AajoOZV2AvEK3jomKKyj
         r6WZaDqW/IjiPjPSe7RX0zp1HOy5PoafyKlQMVlUR+cLb6Xlk/JgKOFBXwzx8tLn2CRd
         miCzlzLoyIndt8MJQErmS1RYMmYdfLqv/xDWEUjkOzz4IA/RUTx58ZPrnGaS8Ump6Gya
         IIIPel0tsZ0gOmn50D7naC0nggFfbBpvS9RwBx07fU7UAVrnyHskonOodLp6UY4nWYch
         W2ewrJdpallEKNZNCBLWWyDrns7Nce3hbdNMlJ+fC2nJUXH7Mb5b1RfJN2x+OoWvn8Oj
         vz3g==
X-Forwarded-Encrypted: i=1; AJvYcCVPSP1LaQ0389VO0yI/qgl5uuuFIC7aUArq8Gzzm46FvwAoshV4BNLnZRgzZ4dNZAOo4apbCjI3y2b1@vger.kernel.org, AJvYcCXFTo69PyM8aDMvaBD0W8InOgDhysz8APlL25ZWYUtTRI/QJysKiEVYu/mclYgpR9H2xB9uM0LYH+vFcF4u@vger.kernel.org, AJvYcCXw8ebEWok8VB3MaQ2GpNAU7EvQJu3nJSFnkpudpZ8gakK8JqgR3AdMRMmmRwVy301I6/ejwO5pacsJW6U9@vger.kernel.org
X-Gm-Message-State: AOJu0YwvwYM9/F5hr3+gmn0F/E5WiXT1IngsYP3B7k8JlwCXmZsmbsR9
	Vd7aIs+ZHUcCkeg0Rerdgx7TA4vi/tPJyiVZx5jqk2eQGzm5jmw4DUBtVs23gFKT5j5LS80l5e8
	QY3y+m9tCGwr3pwn/gFeANr2tYJM=
X-Gm-Gg: ASbGncu+QnMVHPfMusgdDvtd2/V5aHUvLkPGeOGc8WwEiLjoMEAfe0vyrAd4pfEaI1b
	CzFwE7ODQwJmAA1lh+5nqJ3nJ69goy98=
X-Google-Smtp-Source: AGHT+IF2FJ83y+mjkZXinRb9AUncGssgOTm6MhRbk4on0wq2m8yrBNc76xWxasrUcQhSLWqoPU2fV2BaZZX4PYSIKUo=
X-Received: by 2002:a17:907:9485:b0:aa5:3c18:eedc with SMTP id
 a640c23a62f3a-aa5944eaabcmr1524599366b.3.1732969336434; Sat, 30 Nov 2024
 04:22:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241129-work-pidfs-v2-0-61043d66fbce@kernel.org> <20241129-work-pidfs-file_handle-v1-0-87d803a42495@kernel.org>
In-Reply-To: <20241129-work-pidfs-file_handle-v1-0-87d803a42495@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 30 Nov 2024 13:22:05 +0100
Message-ID: <CAOQ4uxhKVkaWm_Vv=0zsytmvT0jCq1pZ84dmrQ_buhxXi2KEhw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/6] pidfs: implement file handle support
To: Christian Brauner <brauner@kernel.org>
Cc: Erin Shepherd <erin.shepherd@e43.eu>, Jeff Layton <jlayton@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2024 at 2:39=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> Hey,
>
> Now that we have the preliminaries to lookup struct pid based on its
> inode number alone we can implement file handle support.
>
> This is based on custom export operation methods which allows pidfs to
> implement permission checking and opening of pidfs file handles cleanly
> without hacking around in the core file handle code too much.
>
> This is lightly tested.

With my comments addressed as you pushed to vfs-6.14.pidfs branch
in your tree, you may add to the patches posted:

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

HOWEVER,
IMO there is still one thing that has to be addressed before merge -
We must make sure that nfsd cannot export pidfs.

In principal, SB_NOUSER filesystems should not be accessible to
userspace paths, so exportfs should not be able to configure nfsd
export of pidfs, but maybe this limitation can be worked around by
using magic link paths?

I think it may be worth explicitly disallowing nfsd export of SB_NOUSER
filesystems and we could also consider blocking SB_KERNMOUNT,
but may there are users exporting ramfs?

Jeff has mentioned that he thinks we are blocking export of cgroupfs
by nfsd, but I really don't see where that is being enforced.
The requirement for FS_REQUIRES_DEV in check_export() is weak
because user can overrule it with manual fsid argument to exportfs.

So maybe we disallow nfsd export of kernfs and backport to stable kernels
to be on the safe side?

On top of that, we may also want to reject nfsd export of any fs
with custom ->open() or ->permission() export ops, on the grounds
that nfsd does not call these ops?

Regarding the two other kernel users of exportfs, namely,
overlayfs and fanotify -

For overlayfs, I think that in ovl_can_decode_fh() we can safely
opt-out of SB_NOUSER and SB_KERNMOUNT filesystems,
to not allow nfs exporting of overlayfs over those lower fs.

For fanotify, there is already a check in fanotify_events_supported()
to disallow sb/mount marks on SB_NOUSER and a comment that
questions the value of allowing them for SB_KERNMOUNT.
So for pidfs there is no risk wrt fanotify and it does not look like pidfs
is going to generate any fanotify events anyway.

Thanks,
Amir.

