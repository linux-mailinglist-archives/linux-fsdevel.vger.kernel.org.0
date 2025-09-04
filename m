Return-Path: <linux-fsdevel+bounces-60265-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D0EB43A1C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 13:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEA617B8CA5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 11:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B0630149F;
	Thu,  4 Sep 2025 11:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="EKmFoQpV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824A430103A
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Sep 2025 11:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756985210; cv=none; b=poAv3OklhxwasBYeIkI7COdmwXOu0SCGwQ83ZGqcav+BYrVY7o9kUm//AjeS1ed4JzSDfqcmi0+FGIjOLg02Zuov/vs1In/dkz15u+GJWq83Bhag5tI3PU0/NyavFc/C8XKx0dUGqwJ3WXuO8smsVKsMkrL4kzqGyO38zLPrBW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756985210; c=relaxed/simple;
	bh=c3bOEKedyOFqv8iVjE3DeS4mJBdFox3j7mrylAm5tMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bkj9rxdecM9WKzL8LgkUKz28OnoYaMfmCL1nhKevb4iQilpkh7EO4qObybRqtqMoODBXNmACAfXQCgHyUZjIluXSnz0GIcxYiIJQzfK4sJTc0pIbB31LtpKhgW06UWbqjtChgFHzksHpAC4BQ8nENaBycpmjcYri0CVX5hwhJjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=EKmFoQpV; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b2f0660a7bso8519491cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Sep 2025 04:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1756985207; x=1757590007; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y39MilzvEG6rg2Ci5XaVvxKE2ig7d6v5cPX9yNCAjgI=;
        b=EKmFoQpVmzs5LSYEE2Ahj6lPmz8s0bAI+KbfYiotPz17XtTjglAXLAmlU8PHL5QSip
         AHT4p5mNQkLqs0YenNnYfvgFehWLA3Gewt0pXvZKejxgEmjEpGwB/UlNBgGcPXZbqJoa
         ndqhbCUQZ7wigeRsdYILx22hndogCKSNLaImI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756985207; x=1757590007;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y39MilzvEG6rg2Ci5XaVvxKE2ig7d6v5cPX9yNCAjgI=;
        b=VFte4ncC4i1XdRNlYRj/jECwHEC342dXqZe5cF2AIf8vpLyzmPxXzzQThjPBm3Jlzz
         xQeZpfU7we7OpQl3T1+f0fsJAheI3SaPVV1k1VcpYa30Kln4560DE9BgreYg/jpRrse0
         IL6UaQqz/ml1u/Y7CiOm+NncJXwTYVUqYXjNJeAAH40d6bHwaM3ClpDO6zVTr9uBTuuz
         qhS5MXjI+4qmSsFsz+KvhAlFEe8FPhCrNL+XJr15zGYuMdHtVxYg4GvuLBBneNedIaYR
         JnqXnfzuP8i8+8zgnIjQ5OQZOyYTzcFcz2Ixkkuhrvj/zZHFxRwjDuwTRbx/hso+/xk5
         RlWw==
X-Forwarded-Encrypted: i=1; AJvYcCUKC99QNrxXaquI5MloVfYTTzw/3mFXcD0bZImCje7QFjnwHmRAbJSw2+4E9i9B+aaanrekrtwjWtEhVrvF@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv4xBGGdRchplhpKKCFcTCfjzOVs7qqoIAGm64hCSEWFOA9qBH
	nxytLN0AgK92h7MLWC2hg3OOy4jQS8+VNQghKw3nGqiRJr0ci60R1AbjX9LiV5MopF3/wH8KbWf
	QJn0wKFxMpyfuX2OIcxdDAI6gA+0cEpMII1uGxmpJGw==
X-Gm-Gg: ASbGncuyDpHXVWOVddM1NK8K1xBZ64C8jOdf3cK54iGwXz/s7ZLS5aZXhiKneftm8tg
	s4sP1nTe1/xhDh9C3uQv3YRMsxFFC/0FiX1ddsJUrEEcnz8Eo+QQRC9/EG07FsIaJrCKxtJnPvW
	cjupFmuKMT5D63sS7UhKfkFFu0POFNocAHRuGlj3gpCnEntGgcOIgxFsF3Y+ho5MhqEDS98aP/u
	5I2Z6rgY3edBSMKByBbhb2E1iPDqUD4f7SsItmf1rmLni3/8NEi
X-Google-Smtp-Source: AGHT+IHFq1btdOfmYUBigB6Md3BTJ98Uqkp3GklEgaY7KoZ89xwjaiK4HMvVajiGCrDvhlwtLAh6WNRV4N7bUl0Nd6o=
X-Received: by 2002:a05:622a:8c6:b0:4b5:de27:ccec with SMTP id
 d75a77b69052e-4b5de284ad8mr12163641cf.19.1756985207413; Thu, 04 Sep 2025
 04:26:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175573708506.15537.385109193523731230.stgit@frogsfrogsfrogs>
 <175573708630.15537.1057407663556817922.stgit@frogsfrogsfrogs>
 <CAJfpegsp=6A7jMxSpQce6Xx72POGddWqtJFTWauM53u7_125vQ@mail.gmail.com>
 <20250829153938.GA8088@frogsfrogsfrogs> <CAJfpegs=2==Tx3kcFHoD-0Y98tm6USdX_NTNpmoCpAJSMZvDtw@mail.gmail.com>
 <20250902205736.GB1587915@frogsfrogsfrogs> <CAJfpegskHg7ewo6p0Bn=3Otsm7zXcyRu=0drBdqWzMG+hegbSQ@mail.gmail.com>
 <20250903154955.GD1587915@frogsfrogsfrogs>
In-Reply-To: <20250903154955.GD1587915@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 4 Sep 2025 13:26:36 +0200
X-Gm-Features: Ac12FXyb41gDcBY54u9fYFlgRsP1acx0rmjFx_hEn1e67KNZzkPZC_2_FuMhOOw
Message-ID: <CAJfpegu6Ec=nFPPD8nFXHPF+b1DxvWVEFnKHNHgmeJeo9xX7Nw@mail.gmail.com>
Subject: Re: [PATCH 4/7] fuse: implement file attributes mask for statx
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: bernd@bsbernd.com, neal@gompa.dev, John@groves.net, 
	linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Sept 2025 at 17:49, Darrick J. Wong <djwong@kernel.org> wrote:
>
> On Wed, Sep 03, 2025 at 11:55:25AM +0200, Miklos Szeredi wrote:

> > Agree?
>
> I think we do, except maybe the difficult first point. :)

Let's then defer the LOOKUPX thing ;)   I'm fine with adding IMMUTABLE
and APPEND to fuse_attr::flags.

Thanks,
Miklos

