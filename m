Return-Path: <linux-fsdevel+bounces-52106-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6191CADF707
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 21:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 027B3189FD94
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 19:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE97219A7D;
	Wed, 18 Jun 2025 19:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="f9h8Gs4K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65EA20296E
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 19:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750275847; cv=none; b=CTzoLetHeiVK8kQjGBHWj0coM9Yr0gKxSO9kgPoAJlDwyU4GDDXOen8gHVvETVqucMAZABw530I1BOCOMdcAJvvxkvhlDUCVCkvE2soaBdRL5dHmckFkabHNPBtqrUgUfO73IdCFLELu9L952pTjppCf3EsOnFmJVL+pIXErufI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750275847; c=relaxed/simple;
	bh=BdsvR831RfumlL/UwyMPt1soqER6WJMH2J5sWfMGpMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HT3kAkVEZes/+xM+ela8BwLkyLMCirbRordStimw1h7Jmm/nPLtCbvZZ3G0sRfWH9Vebbc1kXeypWB2ZonxakrfvxYxGzafv/PmYnMMBLeD6/u4JfgQAqvxG5P0sKQzH8EykJprIz9irVWnXM3a0KicaKldLYSJWmJxjinzK0Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=f9h8Gs4K; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-32b5931037eso254681fa.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 12:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1750275844; x=1750880644; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rfRs4Iw0rSkTelGeDNWHb8UmxngR0iJ6bEYkU8J792g=;
        b=f9h8Gs4KlSkoYopDbqrfORcLB6bV7NdoQpJu/gvDJsS7tilFUgA9xx4lOcnlQeYggN
         fjTSOTpxLhD2TsqihkI49xvPXJ2sXmZTQ1o3VS3MNlN3Eiovz4cXXRb1tfPAUdKWCHwn
         ezBe3n1gFv0K9iBZKeKpc+ZEGVqQuiM1MwkMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750275844; x=1750880644;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rfRs4Iw0rSkTelGeDNWHb8UmxngR0iJ6bEYkU8J792g=;
        b=g6Gm4KDRmf3sJAcd05RTgbiI6L9kcehAZk/emDccsqIBTDnx9omV2g1ZVhG9L/yhKx
         zPMGPDNeyL2gmoDqFYTUk9eIpRCHZSm5sLMzYkFog2K6CwYOxOo71XpGOhiHKOk7eu0Z
         zaRntUfUR89On/7u8ybsJtHWbCyWbdXLxGEHbofBJVm+N5anP/phKEHjqFuvRMwgi1RR
         /FXmFvk2Htt6A2YdNB6j9VdTtEgJqcPtau90vvu14bPL6NNBzjk6KckF7qAihVeB9jJf
         Jmk8YAwWY3BFqbCpOtGzGEE6jbFv32XNG9xUTOoM3AW3wewTcvJSl8kS3wPHrneQi912
         nJLw==
X-Gm-Message-State: AOJu0Yz8sOQO1z93oVKdC/+OgB1RaBBxpMfSTInQM+ymDoYDV5mCQTnq
	0+YMjBeF9LDtYzrpbOw7Qj1fLo55UxeGpRObXvyZrVcvKC5AwSl0tp9WuyqVpUxqtYg3DSn/mm7
	/jdARdi5Jm9Y2PMMdTAqe4AvmGwUxcSsLxuT5IyPZ4g==
X-Gm-Gg: ASbGncttktXTNnSiUYcWIgyn3a4UAdFvmzJytwpsh7ywcR+dC1Kf3TFRdFuLbhEoync
	wxjAkDBmBxSEjhmKWsveXSVT1CbLz7yQRpXXSRII8oeUFDaHQLo7lSDO8yjUPZhBwa4++D5YOvj
	srZk+rXTIGjtEU9z9v26Vb3+RJy2gRIjOHA+JArLuebYyZ
X-Google-Smtp-Source: AGHT+IFmSI8nuMXnqnlK9icO9cbarVdC2Nm6GDabVchXBgBVp3gYL197zgPUh+/0fJWeSLAPQdJ3l/snqfWsL3lkaqs=
X-Received: by 2002:a05:651c:b0b:b0:30c:50fd:9afe with SMTP id
 38308e7fff4ca-32b4a412cdamr63150551fa.9.1750275843621; Wed, 18 Jun 2025
 12:44:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617-work-pidfs-xattr-v1-0-d9466a20da2e@kernel.org> <20250617-work-pidfs-xattr-v1-2-d9466a20da2e@kernel.org>
In-Reply-To: <20250617-work-pidfs-xattr-v1-2-d9466a20da2e@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Wed, 18 Jun 2025 21:43:52 +0200
X-Gm-Features: Ac12FXxGUZseBQvuT23w-SMGozJeWhq-ExP7I1MZsuzlt3kIN3PCr79cuUNeNHM
Message-ID: <CAJqdLroQ1BfCUVOsmFm-wPc3hzROSGd3MsyWU1G1MFj6AFUBQA@mail.gmail.com>
Subject: Re: [PATCH RFC 2/7] pidfs: make inodes mutable
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Lennart Poettering <lennart@poettering.net>, 
	Mike Yuan <me@yhndnzj.com>, =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
Content-Type: text/plain; charset="UTF-8"

Am Di., 17. Juni 2025 um 17:45 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> Prepare for allowing extended attributes to be set on pidfd inodes by
> allowing them to be mutable.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  fs/pidfs.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index 9373d03fd263..ca217bfe6e40 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -892,6 +892,8 @@ static int pidfs_init_inode(struct inode *inode, void *data)
>
>         inode->i_private = data;
>         inode->i_flags |= S_PRIVATE | S_ANON_INODE;
> +       /* We allow to set xattrs. */
> +       inode->i_flags &= ~S_IMMUTABLE;
>         inode->i_mode |= S_IRWXU;
>         inode->i_op = &pidfs_inode_operations;
>         inode->i_fop = &pidfs_file_operations;
>
> --
> 2.47.2
>

