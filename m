Return-Path: <linux-fsdevel+bounces-10569-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 100ED84C522
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 07:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD11F1F25536
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 06:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A0B1CFBD;
	Wed,  7 Feb 2024 06:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+k29odj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB90F1CF8B;
	Wed,  7 Feb 2024 06:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707288377; cv=none; b=jVzk7hWyQlv2asM4xVLoidj+6uWSHYWUo4yDTt946QqOBi808VzVfKD3FCoPFnT+LcJBTLVjEVm0mfePPvGDlTqahqGIEscAK/LFxs5kdr9pODrzEJuCIzvcbdp3hvUI37ng3fS/c6Ynl48Vn4pzlX9ZCAPq6qszptaM4UpRmv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707288377; c=relaxed/simple;
	bh=PWIegwB5nz6v/YXJjqW/D2O29mDPZR7zuWttz9wVRxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e4w29GZ/Om+TTsKaQ4lnyo6mPRs+x5DRiEc1DMXHUsyIjziIzNZFx2oFl8FJgoDVM80JSlNQeYppJvYsen1ruMvvgbun/cWAmOPA2/LlqCwZ8WijAU1uvm4A+KsrIVSuZwqiOTk59fQuT4zeg8QG+9vlzj0N9cMPA6ypq0cw0oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+k29odj; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-68cbff3bd92so397686d6.3;
        Tue, 06 Feb 2024 22:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707288374; x=1707893174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PWIegwB5nz6v/YXJjqW/D2O29mDPZR7zuWttz9wVRxM=;
        b=h+k29odjIOwp96KtYcwZifXmoEAXQtmsyxbS0Ks3R4jPFCL/877KWMaSwQr83oMy/j
         kdOSxszSLt9BVLSwiQ83RI3WRUPlVIOZCeln0MenUln8YwfFaNG6820ezkFAt35DinEi
         fgx4NbEVPh3mqrjUzEpLqZH1z05KAiSgoScKzJ/WSezyk3UGm4aeUu9IbZR64uyiez+J
         Tk8mdLFQaVN+vXumsd2+ChbyVVGMbF8bd8+WiR+5wSDbOymm4ZOV43Kic3VjPcMdbs8B
         4e0v5FBxfp8SFUA4vueFxzJK15DhmV9AmUE+GMLnwkyxeeTMopRXaXOTwIPHfEwchy+W
         sjSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707288374; x=1707893174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PWIegwB5nz6v/YXJjqW/D2O29mDPZR7zuWttz9wVRxM=;
        b=k6NR+19Y20GxgQZHgQC8sIM2Vesd6y/Wl4SqT3jKlWRxPWHIZuCr1/cCyrP9yA0BhX
         CI9WQ1bdBTFdB2agAbKXYZOcJY9RxveFovbYcfCe16RZZyb04ZqhVstUJ2E0ZSsvRk7E
         wGMDpNIfue08E4l4ow3iLTecDvZKLDztXt/5ZEEe56ooa3op6NeBnVdnxPjsyIHPU+7O
         xaSWG/W3RYssSifFxBG62x+EeUqnZpuj4d+YqlkbubPDZVwa4j6t+Yls9j//r8YYhtox
         xQL9xhDSXG3lcilIFtRixJzcUcj2/q6/7fA4CPKjyyHsgSlMu8J4Sk3+FYYpHPsvylij
         O3yw==
X-Gm-Message-State: AOJu0YzG9zLujgbZGiG7wkNvU0BkqxsX829O3xrLO3UK7y0QmYo9a4ZM
	NQtI/FS1ipwxWNRTawwxncKHohJq18JEhqOzZy7GTE4r24i1WViJqL+gHPBdOo/xnr8OWQRfjaW
	KEu8/zJUaIs/ToQXfpUQz+KLqmQs=
X-Google-Smtp-Source: AGHT+IGRrzhZE2376FU07LO1KsClgMkPeDEZo/RjTs4IZi0v0HYlPtfpVJO6k+WkHKQqXUOR/oapKZ02MJqojGFUz+4=
X-Received: by 2002:a05:6214:62c:b0:68c:9d26:81ba with SMTP id
 a12-20020a056214062c00b0068c9d2681bamr3763302qvx.28.1707288374733; Tue, 06
 Feb 2024 22:46:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207025624.1019754-1-kent.overstreet@linux.dev>
 <20240207025624.1019754-4-kent.overstreet@linux.dev> <CAOQ4uxi-nBzm+h0MkF_P8Efe9tA1q72kBWPWZsrd+owHTf8enQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxi-nBzm+h0MkF_P8Efe9tA1q72kBWPWZsrd+owHTf8enQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 7 Feb 2024 08:46:03 +0200
Message-ID: <CAOQ4uxhroGgtbXuhoSzk6tMRML4QnVpbvsFcikdLZxR7+ATrkQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] fs: FS_IOC_GETUUID
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, 
	linux-btrfs@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Dave Chinner <dchinner@redhat.com>, "Darrick J. Wong" <djwong@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 8:41=E2=80=AFAM Amir Goldstein <amir73il@gmail.com> =
wrote:
>
> On Wed, Feb 7, 2024 at 4:57=E2=80=AFAM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> >
> > Add a new generic ioctls for querying the filesystem UUID.
> >
> > These are lifted versions of the ext4 ioctls, with one change: we're no=
t
> > using a flexible array member, because UUIDs will never be more than 16
> > bytes.
> >
> > This patch adds a generic implementation of FS_IOC_GETFSUUID, which
> > reads from super_block->s_uuid. We're not lifting SETFSUUID from ext4 -
> > that can be done on offline filesystems by the people who need it,
> > trying to do it online is just asking for too much trouble.
> >
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: Dave Chinner <dchinner@redhat.com>
> > Cc: "Darrick J. Wong" <djwong@kernel.org>
> > Cc: Theodore Ts'o <tytso@mit.edu>
> > Cc: linux-fsdevel@vger.kernel.or

typo in list address.

Thanks,
Amir.

