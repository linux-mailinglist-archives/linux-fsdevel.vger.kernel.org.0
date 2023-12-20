Return-Path: <linux-fsdevel+bounces-6584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F05819ED7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 13:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6500E1F22FC9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 12:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468A0249EE;
	Wed, 20 Dec 2023 12:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LH0YNGSs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C694249E1
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Dec 2023 12:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2cc8fd5d54bso6509511fa.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Dec 2023 04:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703074603; x=1703679403; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7n6iL3d4qNPvf8xtJN7qqI9jX7DKX3Q93kcVPCR1sbI=;
        b=LH0YNGSsTOqmRTvnBw64ipRA3DV+bQt+vC8HvWSyI1fA05fDJdd6NEth9T2Ddhyjje
         LJhaUn/97hvNOyFvbrn+PGk91OBpMRSWvbfb0og1r3umsNK2TBaU7h7XgrDDACnWlaGZ
         iveL3afrK1GKR+Ora8vM1wIwOtZi3xnASTpmSDcWzNOLzKaFl38rrG38fQ1cXaxaCz7I
         272We/6ANBw3Hfb1EaJU4+kApuyci2RXXdOh73yPN3Dl0X50KDTaI/xzS9EJ9wvILWWs
         sQjXC+g8x5jPCnO3BhNc4np+EbSgfKVIj7Du23QGAjhqW0qMcHktVFIJAePlSXNZ0srL
         Yq/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703074603; x=1703679403;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7n6iL3d4qNPvf8xtJN7qqI9jX7DKX3Q93kcVPCR1sbI=;
        b=P6PtOcck1hqbQEcfEyZizsF/sIH/YgX023l40KRZ9gjV138EdG8ViJZsDzyDdSKXzm
         feWrBdcCz8iFqZqdUI6ipdiqh+GRgwhepcZToVWAksKki6jCs/DELXgf1QFaV/4RMGSh
         JFeGWxUEn5IGWYFdxBVXs8RjjsBgJkmt1m1F0DeBMuEkbV+QC9ZVnXN3+8dEHr61ewIM
         DhKjy9gX/ahVTFPuYs86ICWGy7+/9xMXz4Q+LDXVYPett6R7M2knP5uKDmrGzU0DKZx+
         ZgPNArq6/1lupmnvat2LjyArkZumQsd/az+Vm5IY9n29I2phmkiSeXxT1cYFr5eqUdm4
         2T4Q==
X-Gm-Message-State: AOJu0YzMCu7Cxl/zzXR+IiAHZ+Sd6j5gxg7S4SiJjrEx4T1AyRv4uBba
	ubvz9ymQfMnYe+cam0kA3LLk3DZiHymVPpd7vftrg3eN
X-Google-Smtp-Source: AGHT+IFOLrhzI2Ou5EZOxoLEPhZJ0tZu02zwE6sGZ7FwGh/nzkYpdQCAjd4pm3x4t1BfJ8asGxr/aa2G8hbc/GdT2BQ=
X-Received: by 2002:a2e:9403:0:b0:2ca:30f5:7e02 with SMTP id
 i3-20020a2e9403000000b002ca30f57e02mr10000879ljh.78.1703074602898; Wed, 20
 Dec 2023 04:16:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220051348.GY1674809@ZenIV>
In-Reply-To: <20231220051348.GY1674809@ZenIV>
From: =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date: Wed, 20 Dec 2023 13:16:31 +0100
Message-ID: <CAHpGcMJO=3tSg2Ouwgw-WS8HD6viyomr1hxqG-8CiFmMNzCriQ@mail.gmail.com>
Subject: Re: [PATCHES] assorted fs cleanups
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Al,

Am Mi., 20. Dez. 2023 um 06:13 Uhr schrieb Al Viro <viro@zeniv.linux.org.uk>:
>         Assorted cleanups in various filesystems.  Currently
> that pile sits in vfs.git #work.misc; if anyone wants to pick
> these into relevant filesystem tree, I'll be glad to drop those
> from the queue...

thanks, I've added the two gfs2 patches to our for-next branch.

Andreas

