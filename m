Return-Path: <linux-fsdevel+bounces-58155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39737B2A205
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 14:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBCF5171A7E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 12:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED31C31CA6B;
	Mon, 18 Aug 2025 12:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCkg6G/d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940D731B11D;
	Mon, 18 Aug 2025 12:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755520776; cv=none; b=VZeojTLQ/+sA6/jMY9TsyljqdVf411zhKbty/KdNOXaaIUDXFopuPIryp1qdNN09/aMunrA0W1gltvuWIPSg48RIJa6H5ewOLkHIIqfJyrRgAeKgUgfOIFG8XBQVczdc6MNsyXoapZjO09Emphx4PGKSWferBkKXZU5XMhzGgcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755520776; c=relaxed/simple;
	bh=iRiQFMBV+DKdPhtateZaMw71WRCGXS+1o0qcYMlsaNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BA/AuoVy7T1bDJcoXnCcE0sq46g/D68UrXpWiFGoFLeLKPR1hz4YxV5egp7PtAvV/pJrMGSrCuH1WnkzCg0fGnlvTTdGnL3Yt5kl/SGyyK0izEQvAe3BtwXrrdAkL4pZvpMSfkTIGeaF3se3zmzpNJQT7Xwd8cQ/BYd3CxgLodk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JCkg6G/d; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6188b73bef3so7369849a12.3;
        Mon, 18 Aug 2025 05:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755520773; x=1756125573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ubbjo8h4cvXI+kpbxgHKGsgNRSO5oS6kJQNOdicLg+U=;
        b=JCkg6G/dEzZAyztvOMPrbTJUURh1ZfaJwZJvoJFNYb1IhakyprOGSklKUBjfkUiDRz
         ZLxndigssEOiOXVJkEE1SO7jA/Q83wH27/mduR/zIQqBoDewr8m7XnV4lTiwEvW1l6kH
         YG+W7RkxeuB5QgMdG7wdLpt+k8XQld/5LSTqYqxCLsKsTT2nlMAvZKlVKxLKiJNZpW/M
         Cm7Xmf58QxLWGb8fxjDaQznds6deqC3AXmsuappwZg3OhtDLpUfyb80Wvf2hNy0ru774
         6c7sPpDfl5dYsK1/OzTWPs/Fz83B2fvy2vieXvlhLsrmPdkASen6klQoAQd7jS9buzIT
         bKYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755520773; x=1756125573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ubbjo8h4cvXI+kpbxgHKGsgNRSO5oS6kJQNOdicLg+U=;
        b=Ml2paIi0BRiZidRnxAFMA29PlPUhRC2Pjf3myF4lAcGAvpi74r9XundLc3oKE4vTo+
         5iiPVSH/BOjTGXfKmzWbt6tSmC7ROgBuWL7/IJc5Bt4esHWT9G1osAvMHmP5aPjv33lU
         xTJHKjxTudTJq6vcU9RChsWfkPeBvgEDArfGG+v1z5K9SIVakF4jPdtVwmXJsy6D8vUt
         OhDpXpfZwVkg1GNHR6Yc1X/XWJeQLb1w0ndQbUd0XQ7V1cNmU3YOehZoW7loRAKB0lIU
         ewaeHEmni6VeGtXbBzxda5xlXEmBjg3RpB76+qbPF+bNA1K+jsRW+GMbSq/WzPtjQkur
         a/YA==
X-Forwarded-Encrypted: i=1; AJvYcCUGH52+LRpXAuQYgtnvNZkh2xvRGBikEGYyI2kU3YZsABSYTZ8u3+P1o0KkkUJgYvVZvwF9fsw2mfSF@vger.kernel.org, AJvYcCUHzAO8Vlcbwj1aTT2OHmpiqINDYD722CRI1haOnsbMpYoXjs+jXRrPeRP9hWdb8D0k/Va1DX4SuXE=@vger.kernel.org, AJvYcCUbO0DM9dONilK5jCRh/k+10NLexU9h8QGx7OTYkyuf1o9pZqfSuH1to7R4qVbMRarBXNu2KqeaUH7KOtQ57Q==@vger.kernel.org, AJvYcCVJIo6t8ftsTupNlRWC1VpqeDOyhWwvKNXksIj+IvLPTLfHHXAFTVLkNmjBBYdXNjCMELV/OQjTPuFpE0Lh@vger.kernel.org, AJvYcCVehUBlbpVCzwLALZh1Zc8m6BMjqxdxleqW01NiN086UgIUJKkXcdwhcz+CIHklfIcKTntiEZK7IVEd@vger.kernel.org, AJvYcCWKgkWcC5I/qRD+EVGTTQChe8UW1440sD+MogJqkALxV09CwbmuVL0LQ1GdM1Mziz1MSRtSizZ0NPHoc+6akQ==@vger.kernel.org, AJvYcCWmuqJIVhdHseERtcLDubnOqNoa7mm9SaIysp7mDCkOyJC3ftjuzcccXfqXkV14Oumea2Pb84zT2QiM@vger.kernel.org, AJvYcCX/f/0UMtL3kYMtTv9NLfSzy+RljlR0bk9EP1aTfImiSfY6lRnEvnnuVvZTH16Zn7azJpiUFa0lGbuPZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnE4h9ZL8/PjdHeccvqkKQyTZymbijRnJEG8letTMeYXuN+rVk
	Ea58tGhbbbBuKInNh6mYWWTiCK/sponVjvt4y/8Q2lJORImSHP4t9MYTYMZXBfVnnzb8hInyd3Z
	hA5Txoc2oDndm6eJj2lNU8J9VX9sH+TzDHxTQoMHKIQ==
X-Gm-Gg: ASbGnctF7TubNPR8nXjABLwAbAovoikkJJWyA2KxcojMSOmbXvqweSrxDkZ0z8WdyZO
	hS7gmDYDrbMKsh3Lm+4g7hG/8fh3OQVpBJYJi+EOgspVXLlNS+9zcSFMfuh6tUnSUC3ReVBou4w
	pPZtiBxVLIqvrnCLZ31DbopEaU4czkD9UadP8R8V45Bdv7U1uUdJUy6ZJe+S5rTT8+d+24bjL9x
	7Sxwaw=
X-Google-Smtp-Source: AGHT+IHreI+It7iS6Rfr+brWbz70Us6HtoYs+C56L+JOM9s0ucMSXKqtnWOloo9akQbTFfs/x14TcE577HD2A1hPXyo=
X-Received: by 2002:a05:6402:278f:b0:612:d3cf:d1e4 with SMTP id
 4fb4d7f45d1cf-619b707c2a0mr6715378a12.8.1755520772728; Mon, 18 Aug 2025
 05:39:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812235228.3072318-1-neil@brown.name> <20250812235228.3072318-5-neil@brown.name>
In-Reply-To: <20250812235228.3072318-5-neil@brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 18 Aug 2025 14:39:21 +0200
X-Gm-Features: Ac12FXwaOAmOjlUtH5bpB7wOuhOZPTQBUdVvt2kp3aUZBDH4-UANLHNzz7IOKqs
Message-ID: <CAOQ4uxjFPOZe004Cv+tT=NyQg2JOY6MOYQniSjaefVcg+3s-Kg@mail.gmail.com>
Subject: Re: [PATCH 04/11] VFS: introduce dentry_lookup_continue()
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
	Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Tyler Hicks <code@tyhicks.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Steve French <sfrench@samba.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	Carlos Maiolino <cem@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-afs@lists.infradead.org, netfs@lists.linux.dev, 
	ceph-devel@vger.kernel.org, ecryptfs@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-nfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 1:53=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> A few callers operate on a dentry which they already have - unlike the
> normal case where a lookup proceeds an operation.
>
> For these callers dentry_lookup_continue() is provided where other
> callers would use dentry_lookup().  The call will fail if, after the
> lock was gained, the child is no longer a child of the given parent.
>
> There are a couple of callers that want to lock a dentry in whatever
> its current parent is.  For these a NULL parent can be passed, in which
> case ->d_parent is used.  In this case the call cannot fail.
>
> The idea behind the name is that the actual lookup occurred some time
> ago, and now we are continuing with an operation on the dentry.
>
> When the operation completes done_dentry_lookup() must be called.  An
> extra reference is taken when the dentry_lookup_continue() call succeeds
> and will be dropped by done_dentry_lookup().
>
> This will be used in smb/server, ecryptfs, and overlayfs, each of which
> have their own lock_parent() or parent_lock() or similar; and a few
> other places which lock the parent but don't check if the parent is
> still correct (often because rename isn't supported so parent cannot be
> incorrect).
>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/namei.c            | 39 +++++++++++++++++++++++++++++++++++++++
>  include/linux/namei.h |  2 ++
>  2 files changed, 41 insertions(+)
>
> diff --git a/fs/namei.c b/fs/namei.c
> index 7af9b464886a..df21b6fa5a0e 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1874,6 +1874,45 @@ struct dentry *dentry_lookup_killable(struct mnt_i=
dmap *idmap,
>  }
>  EXPORT_SYMBOL(dentry_lookup_killable);
>
> +/**
> + * dentry_lookup_continue: lock a dentry if it is still in the given par=
ent, prior to dir ops
> + * @child: the dentry to lock
> + * @parent: the dentry of the assumed parent
> + *
> + * The child is locked - currently by taking i_rwsem on the parent - to
> + * prepare for create/remove operations.  If the given parent is not
> + * %NULL and is no longer the parent of the dentry after the lock is
> + * gained, the lock is released and the call fails (returns
> + * ERR_PTR(-EINVAL).
> + *
> + * On success a reference to the child is taken and returned.  The lock
> + * and reference must both be dropped by done_dentry_lookup() after the
> + * operation completes.
> + */
> +struct dentry *dentry_lookup_continue(struct dentry *child,
> +                                     struct dentry *parent)
> +{
> +       struct dentry *p =3D parent;
> +
> +again:
> +       if (!parent)
> +               p =3D dget_parent(child);
> +       inode_lock_nested(d_inode(p), I_MUTEX_PARENT);
> +       if (child->d_parent !=3D p) {

|| d_unhashed(child))

;)

and what about silly renames? are those also d_unhashed()?

Thanks,
Amir.

