Return-Path: <linux-fsdevel+bounces-15619-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB20B890E32
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 00:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A46D929069B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 23:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7451A5F873;
	Thu, 28 Mar 2024 23:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="whoze/eT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7199A3BBC1
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 23:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711667123; cv=none; b=XIt7laZC6MZ4jkAFMVlpeHpGpkk8WcniysGM/j2E98PCvbHw88mymbbo8lPUffamfFpuT+WEoDKcgwPELDo0/ThV9s5l0GoNo1w+Zqckiw15w/A5bbc5rnLSwl9J5U88kw2VOBaMvy+LEoTJKrGY4PmwTvLHOywz9H2yz4ynUo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711667123; c=relaxed/simple;
	bh=z3tf46ej8qpBQPDevbtFzGy9O5nWOl/MaSu7nJvWxGA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=U8MQWTY4cJu2EhM1nbH/k1q1MQk8iXn+Zh77p8B3jPUkp+GA816zCFPhRgjibl5QMd2dqUrouTSsIvpH7gcLBDG3oaGhfHmJu80mqslBSq0CyNxQxFwgUndEi3bdNRMcd+Ahosboe1gQCyNFctEMk3Dn8hh0i9YI2WhM6JJ5Wrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=whoze/eT; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-29df844539bso403139a91.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 16:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1711667122; x=1712271922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/3aFzydSyExlB9BmbA34QemVRJ/ZXxJRv4umeOt6fqw=;
        b=whoze/eTuQ7WCfQ2KvL3NhiXL9NdmAEclm+rcZS0cncIpOf/Vikox6zms2HxC9Ae2N
         4cWzjapfm+Ag5yRjl++DCupMT9G0IjnCYZ3nNC+kJfMkiLbw5EVML96+SqYgGbQPf/VS
         bAegt8fbYFAnyvUsUkMvGFyBvyRQ5XH1TQCwZ8wp/hMoUEc+ou+Jdrl/U/B/9hbIN9Pz
         ca5G59PaLbaPt/Ea3p2x0ca8jA0mNfAZEvQ0udRXouYnoxRhALy1hoiVPXZMyYFszsBy
         Y+cdwWib2eaKcRcCvB5aEASf2HOtQ3qrKmO1UrZPwMKUknip7iwA4w74FrCGZOhdUpof
         hOeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711667122; x=1712271922;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/3aFzydSyExlB9BmbA34QemVRJ/ZXxJRv4umeOt6fqw=;
        b=hj/NXLhGKVug4QSpd1qfJXq5CMPyxP99mDCMPrKbQ7tHlM16r9VCIRhBZeEfVxGz7H
         wlZMyqTh6AWHh7s4z4z6mL+W1qHq4wW5WwzC00Ur+BrMdQhV+rE2dkIPXiENPrdKRrf/
         3gKsee0CjVN3gJbrw85OOyr+CvLzoX1uLDxQzKiDrTMonKwr4yu5ABgeHA1k5QKfic/Z
         qFH0pkxq/MefUlLpj7UTu4zVwrF1KkBc/YVvFlasjI5K3l20XycmbmhJrqpOmESXLvRE
         B74hS/Iof2CcQPBLJ9qwItMj3XW4Oa//uJ58xOFiSCzB+inccSw5ZpW27/NXKlG0aul1
         XulA==
X-Forwarded-Encrypted: i=1; AJvYcCXhbCIj2sL0r/32cSc/oYFkvVvUjK+m2YF4Tzug63eKf68Y7Stf2rP7kCE0F16QvqT3N8W/IkTRpjbtAifih+sAO/iWAxlK5eQaktOVbw==
X-Gm-Message-State: AOJu0Yy6Grb1w9VrCRqcE0ggsLPR7Lc9eHEGGjGcluUR4pgmc7KKAdCU
	0nIkEv4rkpK39k2wfgEW49AccuTWij7dA4d0QjAg4fYJ8GYr0xEFmHLDb22ODHg=
X-Google-Smtp-Source: AGHT+IGt0gkc119snKbJARF7UnrFMVXsS7gpTXjZzbZBfCEKd0wr8mr1SMS6Ds7kY42qafqSBM/uug==
X-Received: by 2002:a17:90b:3504:b0:29b:780c:c671 with SMTP id ls4-20020a17090b350400b0029b780cc671mr907698pjb.0.1711667121826;
        Thu, 28 Mar 2024 16:05:21 -0700 (PDT)
Received: from [127.0.0.1] ([50.234.116.5])
        by smtp.gmail.com with ESMTPSA id cx18-20020a17090afd9200b0029d7e7b7b41sm4013902pjb.33.2024.03.28.16.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 16:05:21 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Muchun Song <muchun.song@linux.dev>, Miaohe Lin <linmiaohe@huawei.com>, 
 Naoya Horiguchi <naoya.horiguchi@nec.com>, 
 John Johansen <john.johansen@canonical.com>, 
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, Kees Cook <keescook@chromium.org>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, 
 Pavel Begunkov <asml.silence@gmail.com>, 
 Atish Patra <atishp@atishpatra.org>, Anup Patel <anup@brainfault.org>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Joel Granados <j.granados@samsung.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
 keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, 
 io-uring@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20240328-jag-sysctl_remset_misc-v1-0-47c1463b3af2@samsung.com>
References: <20240328-jag-sysctl_remset_misc-v1-0-47c1463b3af2@samsung.com>
Subject: Re: (subset) [PATCH 0/7] sysctl: Remove sentinel elements from
 misc directories
Message-Id: <171166712004.796545.8747989552701562593.b4-ty@kernel.dk>
Date: Thu, 28 Mar 2024 17:05:20 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Thu, 28 Mar 2024 16:57:47 +0100, Joel Granados wrote:
> What?
> These commits remove the sentinel element (last empty element) from the
> sysctl arrays of all the files under the "mm/", "security/", "ipc/",
> "init/", "io_uring/", "drivers/perf/" and "crypto/" directories that
> register a sysctl array. The inclusion of [4] to mainline allows the
> removal of sentinel elements without behavioral change. This is safe
> because the sysctl registration code (register_sysctl() and friends) use
> the array size in addition to checking for a sentinel [1].
> 
> [...]

Applied, thanks!

[6/7] io_uring: Remove the now superfluous sentinel elements from ctl_table array
      (no commit info)

Best regards,
-- 
Jens Axboe




