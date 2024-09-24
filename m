Return-Path: <linux-fsdevel+bounces-29976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C940984596
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 14:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 311BBB228D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 12:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7531A724C;
	Tue, 24 Sep 2024 12:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="gm7R3UIv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5551A705F
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Sep 2024 12:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727179763; cv=none; b=pZ9KCeD3JKcUTdEgJX7MZ2DX5fuY9R6xpnZL9f/47ZGB9puXdRpFFETvIONscmNAUcRnpPKoN3t1DpKvVGcMRuPhCSa8k2Ne20l42yDeZms4U/KYJ84hJ99Itv0b5R954PCYdcw6T6lkOKAwuP9HF/UrQ4QbQzubq4r6hqKfxjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727179763; c=relaxed/simple;
	bh=BvUTmY5lbhUnkyVVgm9OuCiU6O0jmChf2XvYIXk05jU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tpv39QwH5sZCbseKirzSjmsKCJpZgYNQYi/DZnXh/HtWFGtb6FK0W/r7/6C7cQC/T0zScXsdeFcxfBWB3YObTZnFymWqBIfegUdr6YRncdj7vR9BCWcw1QYif31g8d7k8fCMzXtS1/c1DlIEEEYGPT3dQOvf7FtyZAgafEWJnWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=gm7R3UIv; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7a843bef98so736716566b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Sep 2024 05:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1727179759; x=1727784559; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BvUTmY5lbhUnkyVVgm9OuCiU6O0jmChf2XvYIXk05jU=;
        b=gm7R3UIvKY4ekHXLrszSg0saUk/Dm5xW8cXJQhwjB8ZCGoEpjdmwsCbemWE8fxKhej
         SE3/y6QK/GWP7iLYy7UV64kWW8NbD9oQn0Dt8fdyzvJT5ya0ltCawOnrrcMeLDNMcxYP
         f/y4jLxPv+vKr5vllbqlbAiCLsjWiWbqTkMgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727179759; x=1727784559;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BvUTmY5lbhUnkyVVgm9OuCiU6O0jmChf2XvYIXk05jU=;
        b=EZUNh6X9sYcnSc8Gvfow1Q9JXaVGNCWhIitkovg1YbnV3vpSePcod607DgefBUPLmj
         v17DklYzYhoN2ZoBk8FjgoBKDPiL/EZu2zWHFW8PpmvRYHlwRCLd7BlTtxsdysMR8ZSg
         tnoyl1Gul4j6M7riALqOJwcYYHPtsdrZUaH9O8o6LaJ3E71fjmF6Uvyxg9ddQ7nn3nZd
         wGDu5WvTMYoopLvwIhrb2FKYSPd9p7fNu5WtCfuxnRukWIfdv5fmfYDiERr44Y7IOARP
         Uzqi/nKvjMz7UN2dB1vjInVLzCJxMPmbvX0u8uk2bMfEP+K/05TNMW//1weGsqyrJPYZ
         TYaA==
X-Forwarded-Encrypted: i=1; AJvYcCUC7tfBOgRz8RMv0CKNgkm3sAM7okaMYnPb/ZO9x4SCPqRcKIZqDK8QKNFex/N+7B4rRP+fb654f++5rBhR@vger.kernel.org
X-Gm-Message-State: AOJu0YyNY9LwAjfk5wJvPq9BuzjThJGxwYgsbbIK4bjVwIFwP0vt4Rlu
	Ynzx9L9YuMl4kYzA8J7IhWWP3z4JNxCPoxv3HRNQWKGhFeOzpj81JTxMqb3JNv6sxBDxx3CYNyC
	nvuOYnFl/xFrSTzTVQVzmUhslHm0NXgEc6pCjnQ==
X-Google-Smtp-Source: AGHT+IHc1JR9QMgqKdMTlXTxL48H2g9ftDvx9P2vniBzPVRb0qvG8oK7TzS/RhR++h3rYWNaS7nD+TzL6dQUiMkD6lo=
X-Received: by 2002:a17:907:efc4:b0:a90:348f:fad7 with SMTP id
 a640c23a62f3a-a90d508b211mr1446850366b.38.1727179759275; Tue, 24 Sep 2024
 05:09:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240914085131.3871317-1-yangyun50@huawei.com>
In-Reply-To: <20240914085131.3871317-1-yangyun50@huawei.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 24 Sep 2024 14:09:07 +0200
Message-ID: <CAJfpegt2_7R2fu9fva4ptxUKVQ2HJm6JVrbmuPr9yxCM09TdOg@mail.gmail.com>
Subject: Re: [PATCH] fuse: use exclusive lock when FUSE_I_CACHE_IO_MODE is set
To: yangyun <yangyun50@huawei.com>
Cc: Bernd Schubert <bschubert@ddn.com>, Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
	lixiaokeng@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 14 Sept 2024 at 10:55, yangyun <yangyun50@huawei.com> wrote:
>
> This may be a typo. The comment has said shared locks are
> not allowed when this bit is set. If using shared lock, the
> wait in `fuse_file_cached_io_open` may be forever.

Applied, thanks.

Miklos

