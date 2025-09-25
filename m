Return-Path: <linux-fsdevel+bounces-62763-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F736B9FF00
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 16:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A311189532D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 14:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E74C288C2C;
	Thu, 25 Sep 2025 14:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Fpcco5+F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30521E503D
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 14:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758809495; cv=none; b=OgdYqmZQyHslWNyJkqhUOrUvyHYZLZWLJoi2/P2XETG3YD3RA3Rm5l9VM0OsQmKYycJX0Jtn/aC9t6rZ3bmm7MzdXU31WlVsXzABUtkL7t/34FvjlReSIXejyKjiiW2TdFDe80baocVrGE8ctMy4EE8NTLy+wRdb2nPJWLDc5Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758809495; c=relaxed/simple;
	bh=UWpobgG7AYD6hqiWmnB0mqamozgaQ8uj3AzemTe7asc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FNkX8bOLPRNmVnwCzdatYYo1L+hmRRrW4Z1PJYVNHFviJGs2Qmmrua5qslgvDVpfXpeFbwqSVBwmSTPPtkjs+7uOVFdsK2XbrLKfDCYeRQSLnoe80AfIInps4zCOuQnysuZv6DiVEKaIHJhltq5kBfS1PDtEUUV5TFLCJIhjen0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Fpcco5+F; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b7a8ceaad3so9374961cf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 07:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1758809491; x=1759414291; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I/427OD6W7pLU9IsyNgBLHy3+mHgHSmXy3JA0vIM0rw=;
        b=Fpcco5+FgBeRXCE+FP1vA3EcLguU66YWq2sA+3Sjwwzhgf4hr4WUd2H/FhkZZeOZ+X
         naXU4k8EEiE9eHdBiN+0O9/0k4tydH30C7+g5+QZ5WYV+yltls5a5yhOWk2jpww25plU
         Vi4Ji1jll2dw5D1y2IBuZFjKLp1IywMSzPSH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758809491; x=1759414291;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I/427OD6W7pLU9IsyNgBLHy3+mHgHSmXy3JA0vIM0rw=;
        b=nLKgHmkoRWQDVpNHnvA4nK9OP2W7wOoiiviACkGIapR5uU4Xh/u9HE8tDoAHDLsMkl
         XPgCUbgl6D8/r4VbSPpP0yAMEtuxpQ7oMjsw8a3TCNkGYfgmPFbrmqSGEmzisQGBEkD+
         qiPfhhKijLK4/4WeCjD6NPA04TnunPHq3rm27HrDzq2ZblgWgxBlw26zFsE5VQwQNu5q
         mG3tFLArUUz5uFR68MGJm5N3OFkHJYQQ8iVaY4w6XKSmvgfjmCGdq5oraiMOiAM0k+lk
         AD5Cap0fH46E7lUz4ayiCewQ6442chucER8RSOuIqvOp1joW2wwt2ENHEMvSpQ1yV/h7
         8AlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwa9roepFUwEwvcnHDUzudIjFdm/LiQM06xMfg/TKfzY6/IkozT38GkuvZGXR2fITuYS4wWiRHW11GGeNS@vger.kernel.org
X-Gm-Message-State: AOJu0YxLaqKaVqPPu4BCiAzeWwXc5Hpc8ixJlnwNaPCaoJN6ElnjpPDo
	GLURKSi0jYioNNzuBLUyfQLC3pb85jBOUqF8S0QjvtcOW7EJ1iL0XPRIaLpgZ3o2K+J64tl63bx
	zY3C2bXefG+mJtllWWTw0nKs0Ih+qPq4Pg/1rxyVj6g==
X-Gm-Gg: ASbGnctwGFhZwLrtVcI7ESa01yDtjbL8FWDhVlVsgfbRNOtbOYh8exNpI8k5ItsYNU4
	QdtgzMEEy0AMzhZQPeWZey16MMV40YaeaTXK50alW59BXtpTMvqiOP9WslaWi+dB7psmm63YL9u
	RRYW1AgLP5zu05rWodnlSaAMX3tjmIs8ZTE3j7uhGPIg56W8vZGK02iByiC0+MnUrI1vRn+V/Dj
	eT/TBMiIa+jG4QNHuX9ZRQKX9hQZ3hFJwZYzgM=
X-Google-Smtp-Source: AGHT+IFhfosi5V3Lpsu7k3dFcUbA4i0T5Z6jiPcQqhRUf6vnqPoz0t+a4rROD+26tZnIGA1reTjuZXid96Lf4t28HXw=
X-Received: by 2002:ac8:5802:0:b0:4b7:983b:b70c with SMTP id
 d75a77b69052e-4da4d503cfdmr38924161cf.67.1758809491232; Thu, 25 Sep 2025
 07:11:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175798150680.382479.9087542564560468560.stgit@frogsfrogsfrogs> <175798150753.382479.16281159359397027377.stgit@frogsfrogsfrogs>
In-Reply-To: <175798150753.382479.16281159359397027377.stgit@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 25 Sep 2025 16:11:19 +0200
X-Gm-Features: AS18NWCGKknJWI0OJGH_hfKtcByhpGdDRX_5eBsqXozD3JQr_kkA_sCThsBDjJU
Message-ID: <CAJfpegsr5rOu9n=smii33E4KugyTSqSmQzcSzi2A+5Qi-es0TA@mail.gmail.com>
Subject: Re: [PATCH 2/5] fuse: move the backing file idr and code into a new
 source file
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: amir73il@gmail.com, bernd@bsbernd.com, linux-xfs@vger.kernel.org, 
	John@groves.net, linux-fsdevel@vger.kernel.org, neal@gompa.dev, 
	joannelkoong@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Sept 2025 at 02:27, Darrick J. Wong <djwong@kernel.org> wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> iomap support for fuse is also going to want the ability to attach
> backing files to a fuse filesystem.  Move the fuse_backing code into a
> separate file so that both can use it.
>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Applied, thanks.

Miklos

