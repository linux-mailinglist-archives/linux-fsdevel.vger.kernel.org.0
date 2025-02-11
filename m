Return-Path: <linux-fsdevel+bounces-41510-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5753BA30AB6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 12:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A2AA188B843
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 11:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D7F1F942D;
	Tue, 11 Feb 2025 11:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="mwhW6KXM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EF81F8BC5
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Feb 2025 11:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739274414; cv=none; b=PZOM73sJIywBZJhK6CStFOeL348jEda3PdGZMQz25kVXFO7AfVLK8cR85v3DiwycHGr5lD4XsgyerxnDXGol2zJZ13za9YZnN0JHkaKLD7VRpnH/ji6nCpzQcjFCwitZX0vHs5MRQ4rnbB+3ZC2PK/snAKm1ZrcVMvKuh8MHI3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739274414; c=relaxed/simple;
	bh=HU2lgbAvTzZczLwDFM+mWgUlPFtVZnOv13XC/0hnkYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sneTEtT2AgertxtfuBxjWgYof2RRlLxaaEomc1iHeSoFdLN/9YfhZi1YisqgftWU8xKHMiPrz1iBZZYn9H232AuXBIa0/VK0QFOl/8KN9+V8RDsu4D5xw4iH0uLPCEjBYkil91d9vlvNz8wesahg/zUkdCbK0z+z3hiaIZlSLL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=mwhW6KXM; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4679eacf2c5so55637291cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Feb 2025 03:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1739274410; x=1739879210; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HnL/Dz2TMv3JHkN6lrci9rKkr9vWVmRHytpkEbB8hbI=;
        b=mwhW6KXMSQu3qUzyGLTNL9hdaDihFijGsBgNE8qtDQc0/d73CLq18hfFRyUZXZHYVB
         KLZrrwkwoSPTRifBHxL5KCD6ibPjKIXTdOF7wC+OLJnDvHrr5tfOPdM+XfkftZ2+UH3u
         11X0FTaDXZDLXOJ9DaCpn189WrhQpJFy4w5ko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739274410; x=1739879210;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HnL/Dz2TMv3JHkN6lrci9rKkr9vWVmRHytpkEbB8hbI=;
        b=gQtC1j4idGyM8LnJGeQvNmjI8fiTaFttpwur4GvVz4ObfyotiPu5DgTxPyoZo+g0QA
         ah07w6IxsPuq8JJRYymKziQh7X3J5MIvvKACGiC420K22kxb6boZzBgwmUTCbk/kZ79G
         QS1Knai+MJYG3+TDFDK9WpfJgAZnUxCqIVBYeb5olmgHmKEiIVdmu6fKumWw7MFYUV5U
         EUywre8HWBBZFm+KXwiZUUWlVR9YDK8T9gkWtyC9hzsHuhjhN11yDjK3xPW2CMApVBpD
         zad6g1YEeIdChWTnGnQJIv87JpxlJz0Jyv9cvJzjscqIIxps5yIukAQOBO7teDeXF7ZT
         3TNg==
X-Forwarded-Encrypted: i=1; AJvYcCUspkTcWGACqV4l0V8lXOUoSQhQvflxq/HmVuPCZu9+W+s1emq3U58N0aJrcANfpxk4QnmeQXpYIy9FS1iX@vger.kernel.org
X-Gm-Message-State: AOJu0YwjMkWMAvBuepmSocyz21e+g9zwbW2P+udKQSI+hM2QLMRndH/z
	vDxTk1A9jWWyk6tJfV3yOTid0X097QxuHrH28J/4DahaqTddhn9JUlAwpQf/br8jpq06lipdSwl
	XagjyQ4uhJAqW/btjGX2pVBuARJLpg9kG6cpgFw==
X-Gm-Gg: ASbGncvMQGWP8fcr2S0YnhzkF0F5Pcu6FveklkkfXZcR23qBdrjj3NOof5ub65m3kYB
	P9vgKR5IcuNh64Lubrd2U7ClNIgrzlvTxu8Q/TQckS3rX9J5sr1tMxvfblKh5p4te8DmqKQ==
X-Google-Smtp-Source: AGHT+IEWW3RDakLCwdfQuLRxiMstZeo43djhBnTNbsyfx9bWAzDFa1o0+Gc/AruWfR7kCc0WspRxJsr3bC1B9GBeV3k=
X-Received: by 2002:ac8:7d56:0:b0:471:8e90:dd5e with SMTP id
 d75a77b69052e-4718e90e1eamr108072371cf.42.1739274410167; Tue, 11 Feb 2025
 03:46:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210194512.417339-1-mszeredi@redhat.com> <20250210194512.417339-3-mszeredi@redhat.com>
 <CAOQ4uxiqis6kawuv4pa6jxHYgpQPc18izFP8e0TORfA_mVu_-w@mail.gmail.com>
In-Reply-To: <CAOQ4uxiqis6kawuv4pa6jxHYgpQPc18izFP8e0TORfA_mVu_-w@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 11 Feb 2025 12:46:39 +0100
X-Gm-Features: AWEUYZmQtFnTTI0mTs7aDw6kMwxBThmXcOVaq7Luf-4CoUDMHKifueQXBzbE4NQ
Message-ID: <CAJfpegt=PWs8ZDF11p3nOCWHbWescE5nwVtUt82f=B6B+S0Miw@mail.gmail.com>
Subject: Re: [PATCH 3/5] ovl: make redirect/metacopy rejection consistent
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Feb 2025 at 12:13, Amir Goldstein <amir73il@gmail.com> wrote:

> What do you say about moving this comment outside the loop and leaving here
> only:
>
>     /* Should redirects/metacopy to lower layers be followed? */
>     if ((nextmetacopy && !ofs->config.metacopy) ||
>         (nextredirect && !ovl_redirect_follow(ofs)))
>           break;

Nice idea, except it would break the next patch.

I don't like the duplication either, maybe move
nextmetacopy/nextredirect into ovl_lookup_data and create a helper?

Thanks,
Miklos

