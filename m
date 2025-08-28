Return-Path: <linux-fsdevel+bounces-59509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EE9B3A5AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 18:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C84C16E858
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 16:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAAB250BF2;
	Thu, 28 Aug 2025 16:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jb4Fd1U7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DF126A0B3
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 16:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756397192; cv=none; b=n0NAIN9dqxi6Zg80Ut1Shhq00YkpWQEqm45UAo2ICPxVfjbMguUqZur//BcMyqOHSAU5Qhm7rmx65ofhpotay/kvR1oj+0pthZoe4dL94uP+s9RUY8nSRIMuTpvvMxuhSAxEN0f+Ny4bRm6LqUz55/SRKHkXy4c4aVBXcuZjwig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756397192; c=relaxed/simple;
	bh=rzf5W9L9vUUhN7ldDyihEVx004N7zMo1Hx8PwLmDO7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BQATss3oYt6ZBOqSdvw5RJrohcKN2snDZQ+GBB+EF0akG3X/fJ3JR6b9m9hd6CbKaNIcOR6eCIaSaWbetDnBUDfedmohWZ9ToO13ygBKGrar/wETXfxsn3dcI8pA4O09clHit6tlDPXWlkwCA/rdPYDqJr01Qql0agBmdDUzy3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jb4Fd1U7; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b28184a8b3so13129741cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 09:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756397190; x=1757001990; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Otsyf6XESGNyQGGGXYHjJBLXKN5OoI7hyMYYNbGTHU4=;
        b=jb4Fd1U7Q3Fj8IGmBMOMmHwKTX+JaicnrMUp/I5HTKfiAPmr3QlNuHWDJQEh1i2Aie
         FnBxyErfre5A3AmLkq4pCZW/7A9bnaKhJ07kLJCA8Nm5XI9VxElQCNrGuQVALyPEjhTd
         yFad1v23ziILUvCNlB+QgyMfjNHx+uwU0kgoLHy6bJdd/N+NBUQPdZS1BXyiQsVf1LuP
         rkO2oSvtoupWYLF+/bX4dXPRWeqnWT66YLQFVJKjXcR8+fsE8K1bgeVpWQHbVteGrBD4
         RmSDICBVUNJcnu/XeWuKKv1DhPnvSynF9H9MKtNrHY8YvV9eenPOz+DTZkLRqeNSAYKJ
         BLnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756397190; x=1757001990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Otsyf6XESGNyQGGGXYHjJBLXKN5OoI7hyMYYNbGTHU4=;
        b=attAwAul71fj7WId42ZwoVSLd5CtfPQ8/KmYn8qpwGhKoX1ti/Jw3SpT4K/E8cThh2
         OGLUs4HA5lYB+Vgp01D8H95eXe8l/VltiWs3b9ZCE7+jVwGa7f+aGDIQVVRTGBVfK+2a
         rFpE131NOPF5vxzPHpi71y8yQj6mQ6cZCn8Cu1LHG/jQS/Wlf+6H1IExdhlVE2Nq9WmD
         CILjbKR4Y9y4K0kco96bTGDHXe/dI+T0gUXRsI3iuTHhYsZ2NFvYVLJeOwiKlWjl9Yj6
         PirAkcp1fKPT4HdrH/ryDTmrpVBXFiEmn75AHHIJ/Jiib8d7QwTrwYwDNTQfB8NZ9g0S
         B03Q==
X-Gm-Message-State: AOJu0YxM6Mw0Kz25B+b2bNjG2lF9z/4gQYOGIQl/ECNiukm/oiMVLPMV
	gP+m0uVRe2aamX/Ivuyr4SkbsT4maQPZgJS/0rOHjoA8vyrJtaVxctbFpaueaVTiqtdbwAPnk02
	uNEOoNkgeCKyBxY6B/7sRNKLPDgLVKww=
X-Gm-Gg: ASbGncvS0VSNANg1g4f/umw/X9iftr8auoIpRWPSva+Toijgk85tTl9YB9MYFvEjkF4
	AifQrZDauwgebXh65bYI/+Tj1KBXnnmaFA3ljaHvN86BVY4VuvCtelzmQvwUw/q4mR0LfChZvUq
	xVxQmWYtoDSHCJyS27LsalF0WdMApDhJlOjYu56fZTn7d/CLyvwxZV73ZGEqvModNt0cDm3yGOQ
	R2PQAxovr4FjQxG/xs=
X-Google-Smtp-Source: AGHT+IGo2cEHSaDIU3i2YjVnJ1wQ75/Ojr8Hq5qjHHzDAkyefNqjbrfQbD6UhMkSR7etgV2FIf7H50ueoEToRj6TeYg=
X-Received: by 2002:a05:622a:298e:b0:4b2:d6d9:cf75 with SMTP id
 d75a77b69052e-4b2d6d9df0amr158755631cf.30.1756397189043; Thu, 28 Aug 2025
 09:06:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827110004.584582-1-mszeredi@redhat.com> <CAJnrk1b8FZC82oeWuynWk5oqiRe+04frUv-4w9=jg319KvUz0A@mail.gmail.com>
 <CAOssrKe9qPTGh6ghkLX+Gngsd-ro5JUw79Syxrnyy9U0Q8nQdg@mail.gmail.com>
In-Reply-To: <CAOssrKe9qPTGh6ghkLX+Gngsd-ro5JUw79Syxrnyy9U0Q8nQdg@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 28 Aug 2025 09:06:17 -0700
X-Gm-Features: Ac12FXyUglLY16zX0Fj07u5LwGy88q3vFP4jDX0Etkn8HqwkyrR-B-ZD5HPdGug
Message-ID: <CAJnrk1a8LGNKiKycbB52TL4Q0tjYrp4wCnhvbgE1pxes_v=3gQ@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: allow synchronous FUSE_INIT
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>, 
	John Groves <John@groves.net>, Bernd Schubert <bernd@bsbernd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 6:10=E2=80=AFAM Miklos Szeredi <mszeredi@redhat.com=
> wrote:
>
> On Thu, Aug 28, 2025 at 12:57=E2=80=AFAM Joanne Koong <joannelkoong@gmail=
.com> wrote:
>
> > I wonder if we should make the semantics the same for synchronous and
> > non-synchronous inits here, i.e. doing a wait for
> > "(READ_ONCE(file->private_data) !=3D FUSE_DEV_SYNC_INIT) &&
> > READ_ONCE(file->private_data) !=3D NULL", so that from the libfuse poin=
t
> > of view, the flow can be unified between the two, eg
> > i) send sync_init ioctl call if doing a synchronous init
> > ii) kick off thread to read requests
> > iii) do mount call
> > otherwise for async inits, the mount call needs to happen first.
>
> Do you suggest that libfuse should ignore the return value of the
> sync_init ioctl?
>
> That doesn't work, because old kernels will return an error on read
> from an uninitialized fuse dev.  Also if kernel now blocks before
> mount, that might break some odd server that expects an error.

Oh right that's a good point, I forgot they might be running an older kerne=
l.
I guess libfuse will have to have two code paths for this regardless
then, which seems totally fine.


Thanks,
Joanne

