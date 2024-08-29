Return-Path: <linux-fsdevel+bounces-27804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 663E69642EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 13:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC0AB286552
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 11:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E09F1917E1;
	Thu, 29 Aug 2024 11:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMvQdcKW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDB07E59A;
	Thu, 29 Aug 2024 11:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724930790; cv=none; b=Q0pr6PVbQaJr+DqPXwsohBnUfRVeZ++Kqg0U2yLpImBlTbp61QjAffIUj4cvGSIsALj/wwL7Nx3HLL5uIe8W3sgyo4j1w+Fei/Pwwx9U4K244jIr5sHIikLyqzYnTdF8FEwLlZXHMym3P3T5cmPEX77Q+r+tpNyzZkmLiRgpc/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724930790; c=relaxed/simple;
	bh=gOx6qmYz1ck2X6HyQGme0UfMW99Cp51bAJbqgEhNEeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EnKmFXA1AMEOqIZtTBp82J9BrMYlqg4hQ9uqA6MovbhOZdWa1tMKuqSQMb7ZaM3vsx0a5IbrANd3vQv5lTI2WvXOcJ0CnhfTw7ypRAScjo70j1sa/LY3sjpaL1kOutBmsZDkOWJNaFC6OY4wGWFk+PutsfDA/1muuGuG6C/ouEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMvQdcKW; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6bf825d779eso2690936d6.0;
        Thu, 29 Aug 2024 04:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724930788; x=1725535588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gOx6qmYz1ck2X6HyQGme0UfMW99Cp51bAJbqgEhNEeo=;
        b=FMvQdcKW03eY2PheFvwldA5mr9KHxeNJUrqHjIWgDzV8khcn9jxNCOYbsr6jU2ZySb
         Pzg3i0cKzXbpNqyyxjkaAe+MJRR5tFEwb5Hgm9LBx8qmiImTZ3Tl7XXNurdLLLmAzR9a
         CHxRIPKO3TxoJjlmsJDfi1JkMMtbIF9diIsDjdOGZUiBFmA3KKGS2MboP6t1/aAGMgRh
         aoCJvz1RTTXQmEYnn8sAVOW69/jsQ+/lmnLoSeIG2TiomoI5L3bZHHfVpCLmNy97zwB5
         KZqv674iMXlUWyyDfsZI8NRU+MXpGZ+chnOCrX2NDpRlU8ZCSLuY0YN5LPwu9FJKFzE2
         A6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724930788; x=1725535588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gOx6qmYz1ck2X6HyQGme0UfMW99Cp51bAJbqgEhNEeo=;
        b=WCveoz3mHyLDygXfRxZ4kLhF9ucwMMklM7kSFabrZXWdVX/6lSEcA4vSWNDqM3b+0q
         MnOJc/G/NWS6/2zhTvwOcq344EC5G6X5eEQVYAsATYvR2Fo4R3uVHwJ9CFusYdOenM/M
         j3OKbaZEcXrSaSHIfzmuzkSsbOAglRZahiFYwsbJ+eIGA+T72mmjpCH1wxDLEUox2IvI
         dTywOceKrUnLTfJ/R7t2gGUlFSxiWiSkB9nZKgOM7Pzr9jrJ1JUw8g2uuigToBzYJqyq
         wq77vKtNzxVXTVlkYznX+U54m2DcQUxO1BGXNCU9UBWc/i7nXX+LKnjg7X7Y9TdAHm2q
         HhZg==
X-Forwarded-Encrypted: i=1; AJvYcCV27atyMFFTSa5yILJfdfF8ZE/o3L1ScyDqpKRU4rXws0+xDYqSP+OCAmSaF8Bys04qSiu+CUA7XXRWS9Qf0Q==@vger.kernel.org, AJvYcCVimMGLY1umN1SSZmeTjYdUPjgSuaEEWfitVBMHz4yk4nIV1w9BDt9+6rWr0gnr6bs35/kMEKo5pyUA@vger.kernel.org, AJvYcCXnzA9aMdKZwPgTYf+pemXFDRtXAQpV2taxqqEE+pzJK8bOuOUbqLLGa7jpKWzSZrCFCdYDrUra2OJfBYWRIA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5N72cUoCD00E6CCxURy2nygfgKI9aGBQ+8S/cDorJUaJ1alV9
	zvLn4dlhi2k9+nQ+dy+gcUWeXm9VVNxGG6dse15tj5YR+QBLHfFaLOssjkVSvuGcQz6+aE6DAlo
	rbaEAV56HWbFHEc4CNwnMk/HIj5w=
X-Google-Smtp-Source: AGHT+IF9Q1Ms8z/doAt1y4SkEv8z6ZQR3pz6NK2GvaKkD36Rbpxx93lLppwh2O+ZQ4ORSU1yEkhjdAHk+vkdNGr/aKc=
X-Received: by 2002:a05:6214:3388:b0:6c1:6ad1:72af with SMTP id
 6a1803df08f44-6c33e62452fmr25327836d6.29.1724930788119; Thu, 29 Aug 2024
 04:26:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1723670362.git.josef@toxicpanda.com> <2bd333be8352f31163eac7528fdcb8b47a1f97b4.1723670362.git.josef@toxicpanda.com>
 <20240829111510.dfyqczbyzefqzdtx@quack3>
In-Reply-To: <20240829111510.dfyqczbyzefqzdtx@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 29 Aug 2024 13:26:17 +0200
Message-ID: <CAOQ4uxjuySfiOXy_R28nhQnF+=ty=hL2Zj3h=aVrGXjm_v7gug@mail.gmail.com>
Subject: Re: [PATCH v4 15/16] gfs2: add pre-content fsnotify hook to fault
To: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
	brauner@kernel.org, linux-xfs@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-bcachefs@vger.kernel.org, Andreas Gruenbacher <agruenba@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 1:15=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 14-08-24 17:25:33, Josef Bacik wrote:
> > gfs2 takes the glock before calling into filemap fault, so add the
> > fsnotify hook for ->fault before we take the glock in order to avoid an=
y
> > possible deadlock with the HSM.
> >
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>
> The idea of interactions between GFS2 cluster locking and HSM gives me
> creeps. But yes, this patch looks good to me. Would be nice to get ack fr=
om
> GFS2 guys. Andreas?

If we are being honest, I think that the fact that HSM events require caref=
ul
handling in ->fault() and not to mention no documentation of this fact,
perhaps we should let HSM events be an opt-in file_system_type feature?

Additionally, we had to introduce FS_DISALLOW_NOTIFY_PERM
and restrict sb marks on SB_NOUSER, all because these fanotify
features did not require fs opt-in to begin with.

I think we would be repeating this mistake if we do not add
FS_ALLOW_HSM from the start.

After all, I cannot imagine HSM being used on anything but
the major disk filesystems.

Hmm?

Amir.

