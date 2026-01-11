Return-Path: <linux-fsdevel+bounces-73176-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BFDD0FB64
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jan 2026 20:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E636C302653A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jan 2026 19:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C839D352FBF;
	Sun, 11 Jan 2026 19:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Sx3fkkWV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC298349B1E
	for <linux-fsdevel@vger.kernel.org>; Sun, 11 Jan 2026 19:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768161397; cv=none; b=mf4Do0EdCu88eVkOxK8b48BRvA1X2vRg8TnrcO5VOgygG/9Rj3sli+WgkR7Xev1CpEJIAJFwP4A9rJxQ+3UrrqbrGeJr2YJGUNtokCCAgKOxHc72azrzBH23SFKffeeIk4Z2hZ1t50l8BGl5vFCgVlWggZka/qoGqG/JCv4+ook=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768161397; c=relaxed/simple;
	bh=QHl7x7hOeSAon2QJW6cSB8X7QgA6HF5XK1F2xB7PV18=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YRFld8K+7wQJQ5DChH2vMGY23KLZ0rC241+e+bWLr731q7MY4l//d/KO8R3mcy9mBGMB7ujcbzlp7Fb+tMCGCOx+bSFbfzjBP/vtmU6+U0FGrHH6Ubnm9PFOA/ZYPYU6yiSmDA7KJexGFsZgYSdUTua7ljehE/A0fa1YKWNZMzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Sx3fkkWV; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-657490df6f3so3036037eaf.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Jan 2026 11:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1768161393; x=1768766193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGVfI0/8+u4L//09+zks70nTh/iqSyXGMYjvkVqtgSo=;
        b=Sx3fkkWVBZHHJM9n3IWzYWTNAd2N+/izn1DcVhnV+Wmjk4Rghjlq3gSRADQ7AQeeqz
         oacE+X2y/0yWzZ8ASy63UfQd38q0z/m8SJHcXKoEMfA/HAeONmanViEoJYDHnrwVhN3K
         gnsmAhviinhaWy/CpHl4EYjKOcvuFM2nLLcNB5geM3geKuJwq3oXV15i2cw3VzPx2iOh
         pioNQsvF5/2eufmkwAYVErcunNfUqi0F0w2GKlHqt1TEk2AP59jxSjgCl8btmv02HYvp
         tYshpkcVVox6fmV6u8IVBo2OiZ/ODgsZt98nDLVUtUIeCGbxmfBnNOyqZwBZo5EBDsor
         27WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768161393; x=1768766193;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fGVfI0/8+u4L//09+zks70nTh/iqSyXGMYjvkVqtgSo=;
        b=hKVOUxtq9SdsOaafpDooEpeEoWgfsKdCgYwCdskPZ76nOzJg2YBPhMZd51W8X7TUhp
         6ju0aBgmzWutIwK/GrBT7lJaThNviORaAVaknX2U6JzNzZSQ0L5cbfJDKP89mMDzLieV
         9KdG6G2SvGp4+yCgZspkYmy67LkPzbYkYMV1cFf25WaKiPsSTlad+ZF94b3xmV6/MCfd
         FJYLqii7vY6il241LDPV5SCBOFgueF/L7IV+lwwjFBPLd2Yzw7g4RdNOIBa7QZNQM/Z2
         PahhU9xeFsyUnfViRgXOAKprm6y+3HlQXa0eM+GtJLtiaJQvQsYebNcwIHhYd53pza3M
         QYHQ==
X-Forwarded-Encrypted: i=1; AJvYcCU36xAt28mKsH6bZyB6fG27dBmCFsBCpzKHL/sJ9HtpHKKf/y4YJce77QieqaXnnINvtjHh+WWAE8/nrVnA@vger.kernel.org
X-Gm-Message-State: AOJu0YxL76cHtWIGy/fgmEtrDfGAMfShSmHE7/AeW+TI2dulpwSTotIC
	oMBwPVHaTdPtUuIL78HkFpByLYPu2+E0VbIZu48gSIW3PMP4mhbQOVbhtxhTgxNtt2U=
X-Gm-Gg: AY/fxX5H3KwKKJ1lkYCqahuCRcebEw7sBHkfkF9ANh1TMbiGF0JJai1BNsU7Dh3x5HZ
	K64HIFsNwYedvrmAsX9bZMs85Y5Ty+Kz4uOXChc6+w5e0oF0MiqoA5OnnDGph0hEpQCuWxp23Hi
	k7i8FLupGvRVE2XL4omtuyEpwaetBIMZedQTbtS6Qpeyjoj5MY4ATkBDKblF8dpi2zNARzKUcKa
	0Ygc571ubqv1WFPqRSwbCswpJIk/SN1ZiYRO5hnGLVsYXjPsHqIDiv8Zti8hh1l4IB3+f437Cpw
	+e+xbX1qVeJK+WdriJkppxQ0/4agLAKyUmgQfMpm9izfO+CqbHsa/3O51DGoQg8GJKtj1PkOwFS
	ow7gePLESyimWSClB4XRkjS51IhCtzM4J98yE7gYE1C1SXDi3O4IYW0YaoEo12lB91eVBfbnd2P
	EdUl1J5rkdO/HVlw==
X-Google-Smtp-Source: AGHT+IGBtFi/oNMknJ7q23MRiHrgmzqkvOyQcIAGMR95gDlAmxm0egBAU8gy6B6FNAE/n6bQHA+jKg==
X-Received: by 2002:a05:6820:168d:b0:65f:674e:f1ca with SMTP id 006d021491bc7-65f674ef243mr4958633eaf.35.1768161393624;
        Sun, 11 Jan 2026 11:56:33 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65f48ccfbdcsm6306629eaf.15.2026.01.11.11.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 11:56:32 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Eric Biggers <ebiggers@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-fscrypt@vger.kernel.org
In-Reply-To: <20260109060813.2226714-1-hch@lst.de>
References: <20260109060813.2226714-1-hch@lst.de>
Subject: Re: move blk-crypto-fallback to sit above the block layer v5
Message-Id: <176816139201.218180.16174213874094266429.b4-ty@kernel.dk>
Date: Sun, 11 Jan 2026 12:56:32 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 09 Jan 2026 07:07:40 +0100, Christoph Hellwig wrote:
> in the past we had various discussions that doing the blk-crypto fallback
> below the block layer causes all kinds of problems due to very late
> splitting and communicating up features.
> 
> This series turns that call chain upside down by requiring the caller to
> call into blk-crypto using a new submit_bio wrapper instead so that only
> hardware encryption bios are passed through the block layer as such.
> 
> [...]

Applied, thanks!

[1/9] fscrypt: pass a real sector_t to fscrypt_zeroout_range_inline_crypt
      commit: c22756a9978e8f5917ff41cf17fc8db00d09e776
[2/9] fscrypt: keep multiple bios in flight in fscrypt_zeroout_range_inline_crypt
      commit: bc26e2efa2c5bb9289fa894834446840dea0bc31
[3/9] blk-crypto: add a bio_crypt_ctx() helper
      commit: a3cc978e61f5c909ca94a38d2daeeddc051a18e0
[4/9] blk-crypto: submit the encrypted bio in blk_crypto_fallback_bio_prep
      commit: aefc2a1fa2edc2a486aaf857e48b3fd13062b0eb
[5/9] blk-crypto: optimize bio splitting in blk_crypto_fallback_encrypt_bio
      commit: b37fbce460ad60b0c4449c1c7566cf24f3016713
[6/9] blk-crypto: use on-stack skcipher requests for fallback en/decryption
      commit: 2f655dcb2d925b55deb8c1ec8f42b522c6bc5698
[7/9] blk-crypto: use mempool_alloc_bulk for encrypted bio page allocation
      commit: 3d939695e68218d420be2b5dbb2fa39ccb7e97ed
[8/9] blk-crypto: optimize data unit alignment checking
      commit: 66e5a11d2ed6d58006d5cd8276de28751daaa230
[9/9] blk-crypto: handle the fallback above the block layer
      commit: bb8e2019ad613dd023a59bf91d1768018d17e09b

Best regards,
-- 
Jens Axboe




