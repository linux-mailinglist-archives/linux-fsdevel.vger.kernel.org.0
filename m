Return-Path: <linux-fsdevel+bounces-49677-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFCAAC0D2B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 15:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B19EB7B598B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 13:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FBD28C2B9;
	Thu, 22 May 2025 13:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXk6pgHb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB00123BF91;
	Thu, 22 May 2025 13:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747921676; cv=none; b=oyxOBB5kC/UFG8TfpWGO264tLfnVK/5uLaxg+8TlXInW3sXHpu42RId+hfTVU0cs0Dt4ieeQZSm+HUEq0TfaigBf0+osKbtfIvLknQeFsDNbNUhN4M1dlM+PD9o7CuRTn52JueFC8ds4ZU1e0xuTEaZafQVgvhr1eAJukBHldNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747921676; c=relaxed/simple;
	bh=gwohU6Ig1npopAo3mhkz9ur1Zu1wXs8NB8drSSY/Z48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VXQ3rPGJqPvai8k8F71cElGYbT4DDoDDcn9hcphUt/n2tnAxNa3LWsvBRZAkPo40Px263jIHcqfTYuYMq8p2PUdeJZlGMq+/x8/KXAGR+9S59xfwsxxfpi2CaGLtSgzIaWRsIGdLhcQXvNCUqg2VpIc1SMa7Ri6wFU8t3Dmmv7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXk6pgHb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 582E2C4CEF3;
	Thu, 22 May 2025 13:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747921676;
	bh=gwohU6Ig1npopAo3mhkz9ur1Zu1wXs8NB8drSSY/Z48=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WXk6pgHbIm3fsLjW8ilg4TUFeksijBDJLIlTFUwR/pfC1ptF9NMsjc7QLZHgE62Ya
	 tc0asSbjvjxNEc/mnzmR0b161gtEukZiBy+VdDMu7YdQJyL5yHsufnYrV2uudvyE4U
	 buL39qaQ5+uoIV+6zLz3UUW4Pw+QBG87ZmDjovJNNCl2jLnAhAj0QRYaUfZZVu6WmZ
	 pAYmSewJ8KRb6KH9zF3gBpdqnFgKmEDAgA8ATV+mYxIYRKuDDPjciGdDiAX2mlusHn
	 pZ7O5s/RR8cKuXoCuxTPzZqpeDEm9yUXOkViwMrAHaX8FEzbwCCLKDgtDZfN5xgLMc
	 yvwK8awm51C+w==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-310447fe59aso81634681fa.0;
        Thu, 22 May 2025 06:47:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU2h8S9WuvgDiPF7AFd6xbi/tumNIHgPgANNXBBZj/lWGU7JRPP7CcTLrnIibH0o8SVfskx44l+fMM=@vger.kernel.org, AJvYcCUyAjuBk5NmZTV+gif8F8D371qihX8nh64iJ2m6ofDoxiPk3Rhwh6erecZi78jMM7useQfs5l8JZvuRqRvhqQ==@vger.kernel.org, AJvYcCXbG27LpbqtNPmRS9gsyqo3PMSzjjV2CjZmB3TiwPEUwkNGy70yViNiYUlhGw3pxUIIbA+oVd53i0GJ9lGS@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm9ZEidmC1dAr2X8wcDrF6dyEVMDduR+6q8arnLAwfLnHfY9fO
	RGwVdVMkcl5O/uesNLyInMqkWFjbqekJ2KJBwM2mscYjvYrU34Ewzaqeyo6M7bbu0tJuSbVJUjp
	gwxtNPjwXEifi6lN1wdb6tceTtzKX4CE=
X-Google-Smtp-Source: AGHT+IEMvYNEB/rHOZMvg11AlkNQNkP4RBwq+3Bi9QTB0TiaaIGIV4kY+Fdf57+Cv0TkzXfdKgRtMTNYyrI65dtO0J4=
X-Received: by 2002:a05:651c:54c:b0:308:f3b4:ea66 with SMTP id
 38308e7fff4ca-328077a32aamr108535091fa.28.1747921674685; Thu, 22 May 2025
 06:47:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6820e1f6.050a0220.f2294.003c.GAE@google.com> <CAMj1kXEg88Q5GCV+YW13UT4eDEzMpnKW8ReJNDjLqX7xeXaw=w@mail.gmail.com>
 <20250522-exotisch-chloren-3fa7b7ce5266@brauner>
In-Reply-To: <20250522-exotisch-chloren-3fa7b7ce5266@brauner>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 22 May 2025 15:47:43 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHHq=n=e9Dmw8uXoz+Tms2UZ7jtQtMMJvGCE6PW4muD5g@mail.gmail.com>
X-Gm-Features: AX0GCFv-_pVFI7LdwnbeYfI6H5i0qZ6LC8G0JxE8ncBX0rwPmgl2pC6WYHA-fq8
Message-ID: <CAMj1kXHHq=n=e9Dmw8uXoz+Tms2UZ7jtQtMMJvGCE6PW4muD5g@mail.gmail.com>
Subject: Re: [syzbot] [fs?] [efi?] BUG: unable to handle kernel paging request
 in alloc_fs_context
To: Christian Brauner <brauner@kernel.org>
Cc: syzbot <syzbot+52cd651546d11d2af06b@syzkaller.appspotmail.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	jk@ozlabs.org, linux-efi@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 May 2025 at 14:24, Christian Brauner <brauner@kernel.org> wrote:
>
> On Wed, May 21, 2025 at 07:28:34PM +0200, Ard Biesheuvel wrote:
> > (cc James, Al, Christian)
> >
> > Please see the splat below.
> >
> > The NULL dereference is due to get_cred() in alloc_fs_context()
> > attempting to increment current->cred->usage while current->cred ==
> > NULL, and this is a result of the fact that PM notifier call chain is
> > called while the task is exiting.
> >
> > IIRC, the intent was for commit
> >
> >   11092db5b573 efivarfs: fix NULL dereference on resume
> >
> > to be replaced at some point with something more robust; might that
> > address this issue as well?
>
> Yes. It's in the merge queue for v6.16 which kills off all that
> vfs_kern_mount() stuff.

Excellent, thanks for the update.

