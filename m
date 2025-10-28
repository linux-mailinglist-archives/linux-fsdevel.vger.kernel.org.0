Return-Path: <linux-fsdevel+bounces-65966-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8FFC1767D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 062704EDB87
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 23:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B5A3074A4;
	Tue, 28 Oct 2025 23:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fnHEDd9O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3523054C4
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Oct 2025 23:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761695477; cv=none; b=b2gMzxQ1tlZiQY6v2sDYhGeHmhW1JWrqdvZ7fbbjf7AG5NLrjlqyS4Ygz+v0isKTfXKKYKLccVAa4Xmy/wPwNA65+S7MuGhDclp0cR2rCxppI9MXLoU1+mbVTFXvqc+pWEmBw18KOiyTrjoh8ru6KGDUVG86ThMsREkGMo2aYWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761695477; c=relaxed/simple;
	bh=zhqXyFTzb2t3B9Dp9QKvidvf264lh5WpAlH4hAvSPD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lqPn11MNUBToi0MMleb2iZawBkeCUMEz0Iz8Azg086TyJ6qs0XhG4wj0vMVLkrfqjJHOBoyPuzww2xfmzNNP7Dgfs6kZGPeKVDkhUxqoxDhEudRapk4bps+h4ignGWaHPHQa7GWhH5B2Lr58PDevpVeuCywwlR0WiyF5hmMupWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fnHEDd9O; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b6cf1a95273so4816233a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Oct 2025 16:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1761695475; x=1762300275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ss0xsZDTL1rwOqKY2yzsfuodL2zhm4Ktw8Z3rrAQsGY=;
        b=fnHEDd9OESW8jqv4smyGKFm+OqaP/L6WyQOyxmytcboxuIZmCn2d5OIjDlj4H83pbQ
         DNMSGk++elnzbqoGpEs3Y4W+aSy76QCWVvUzYJjTIm8e+POHZ9DcpC2LRXkQd5qPBP2g
         1g8lrMQBjzgUwgy2Ix8WUuVSVykKqvA0eTONevzKE4wNIUZ2IsQ/s+RvIiMp/pLyzCjO
         BsjYSxL3tJwQQgmoWHbQKIUcILsgzRPb5YTHGsLHMIp9zhbkHiGNfmD4n9T3CG5W3+el
         hvb43Zv8eBUA4zUNpTmOoJIXUE3+5YG9sb87y0t64ycC4jM8AxrEfokDiKCO6q3FDn1C
         hDhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761695475; x=1762300275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ss0xsZDTL1rwOqKY2yzsfuodL2zhm4Ktw8Z3rrAQsGY=;
        b=qUvxfelorlnALh4tRFcW6p8rGK1JmLInXW+jxPHcoFZgtTAhcgV1ynyyZ1rKfyhL6j
         b2jJmwyc56FNp2ptbf+BPwNERzqhxumklBHWcNaCXoFTWvZpzAmKJzN4Mrjj+gSFed4t
         3mxn+Y0PSrnyOlTx2w90gcp8oIN/2VMvZwvN78AjK30mxWlDtHSIjsjNMZaZ+NGSoQNY
         CZJhKIlBImUO3aPwR0JSU6IjKVyyyzWfvgtprChYwQdtOLUNPH7mVfCCgVV4fAYJ5tRy
         p48o6Oau3mp0cnb8B8d5+TnpCk5GSJ74woDK8ueSxtBwDmWgeel5qmYoMHJrZ90Q5C5B
         7QEQ==
X-Gm-Message-State: AOJu0Yz4XtOP3WB63jQW96xj5Kst3E+J2Ue27vcE9zIF4jCHVZ41z1ev
	/SR816B8ot6huIkffCbyKhDueyGBOXROlbMCBOWxsNplcLuvtkSK1M40qcJGr/6D7gg+CATdAfb
	XtUPDL8vOrUBCyW5CHbAAP29h/uS4eKZ6RFAiYITU
X-Gm-Gg: ASbGncuAy/DJpFXpf1/F9xJaSC3sDdbMFH5ywenvhC+vsbf4ePZrAmCfw9NZyoJO1Wb
	Xx8rfir9GOFP0DfcGw++f7qBCnW1zYbt+46zwPYPBR7+72joxL8fBVZ8iNELKVTi+9uK2UDhR3G
	8oXs6QX0v+UQFAbnFwokfEaabwo+MxAvp6+dLv0MNO+wZx9+IA3hOahWnpCoZfWFaeSbA7smzLh
	Cq2LQ1235lLVCThEVx28CNXNc3OKk2Yi5n0GfcfQR3UGNn1SZQ3OqujpDiK
X-Google-Smtp-Source: AGHT+IEQNyH4/UIhryBKstXm8OFaWiuLlbUq8UQcH5+4F6rsLQi06Pj91sWwNLFBJTsNKL1LL+PFGKuePdALOMKBWdA=
X-Received: by 2002:a17:903:32c1:b0:267:99bf:6724 with SMTP id
 d9443c01a7336-294deebc1a4mr13124835ad.31.1761695475463; Tue, 28 Oct 2025
 16:51:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028004614.393374-1-viro@zeniv.linux.org.uk> <20251028004614.393374-35-viro@zeniv.linux.org.uk>
In-Reply-To: <20251028004614.393374-35-viro@zeniv.linux.org.uk>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 28 Oct 2025 19:51:04 -0400
X-Gm-Features: AWmQ_bn3uluZWrDfxLWehWBukesK9g25bn5Thq9tyHBU2hJYs5NTI3fvunVput8
Message-ID: <CAHC9VhRa011jL86779TBk8FK-pcWinLkSkQ1MoxGyyfJg5SMgA@mail.gmail.com>
Subject: Re: [PATCH v2 34/50] selinuxfs: new helper for attaching files to tree
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	brauner@kernel.org, jack@suse.cz, raven@themaw.net, miklos@szeredi.hu, 
	neil@brown.name, a.hindborg@kernel.org, linux-mm@kvack.org, 
	linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, kees@kernel.org, 
	rostedt@goodmis.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org, 
	john.johansen@canonical.com, selinux@vger.kernel.org, 
	borntraeger@linux.ibm.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 8:46=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> allocating dentry after the inode has been set up reduces the amount
> of boilerplate - "attach this inode under that name and this parent
> or drop inode in case of failure" simplifies quite a few places.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  security/selinux/selinuxfs.c | 160 +++++++++++++++--------------------
>  1 file changed, 66 insertions(+), 94 deletions(-)

Looks fine to me, thanks Al.  If for some reason the rest of the
patchset doesn't go anywhere, let me know and I can take this patch;
it seems like a nice improvement independent of the rest.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com

