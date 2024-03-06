Return-Path: <linux-fsdevel+bounces-13768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D56873ABB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 16:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 161422862AC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 15:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD913135406;
	Wed,  6 Mar 2024 15:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="yiYpHRKB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2347FBBD
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Mar 2024 15:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709739321; cv=none; b=syT0mQIGHp8A75k1iGcXWnUuSS7SXucfeIjIhF+mZBowUjjmRA3VelbL1Grce1K64Ivg7QIJvk921ZPrEg7i9XEZfB74LFrpwT/YK4YFehlcNUGnHtd5WCbaIcU6LNfuRU31sbMq8mMTfBgWUdRYbfMr7qrXxM9Nlq1p8JpGqUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709739321; c=relaxed/simple;
	bh=4XBA7h4gk9kZGoLHOXMtYY2N0kUearBB17+7pA7xfVU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qQrj70C0iwFrAqsCTB6mNWTZAdP2YB9vFcvvUFCNFEg4u9rpbuv4m84+XYN6t2Mul0VQpZi3EBa+KT75ZUdOpOPftiPflsFiaau2ZXSd3a3hMMoxtxHB1IkY2aQehpdgM0DzGlw/pGHtxlyrEgMzf8FqR8Es9ue5p0bTPcZyH6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=yiYpHRKB; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7c876b9d070so12642239f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Mar 2024 07:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709739318; x=1710344118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+7aPckIbaw56xMg4x5zLxwpAKi5vUALOz1YbOan0kQ=;
        b=yiYpHRKB8dxaTeWc9yaeQfLV0CfWjyB8SuSfqu83kzipnPId7gRpCul+My1wnfhrW4
         WeSfOjc1biXB70d9M4Nw+Ml548ypNaxLsqZcGCqzytTtXClHL2XLV6iGUXvQTzXYr4s/
         cbkP2BhCH3FJEF63wysr9C7zXY8XfR/+ZWClTOxWfXR5i8g7bF6Io9svq0Y1cCjQX5Da
         mfmzHV9k13U4vQy4eBhOBBQEp6Rlnsjs4aJMJAs2WHM1PJvSLmHx3JGW9Lp4Sa8UMpwI
         5/6AaD1VIFMMEp5eEtO4w+rXDZZ1p7kFgThU7KGEsU4h65MeP+Ur9GNC5Qy2ya8k8uyz
         gl5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709739318; x=1710344118;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+7aPckIbaw56xMg4x5zLxwpAKi5vUALOz1YbOan0kQ=;
        b=gH5A+b9FkkS3+zCcCqsCOKqIwTlAQ06n4kpyU6bGA2mRJKpDe4WbqMXuN1ZXXiogfy
         G7faKhTfQ3GBIDkBXiW8qLjc/OVw6ZUu7XpI2oYtETPju6bJepF+mHQPViHZ4OYk5y9m
         eKiPg87ptpsF+USCoygXp7CJngRzd2TwOHA5O+eW+DdU+AsxP1lSRxFKbaPkxAAf/Bgk
         wX+WV5Ib4whECjOTogCdvDxzhVIKH2g9TcV7RAgMwYwLZ1SLRKpo8kILE/m5J7HBvXHm
         8yANLjQ3aSn/Q20KgYOL3iQYOnxgPtlDRITWko63yGYF/9n6lhJSQYUHkeP0vipwUPOS
         KD9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVMzQHlqhOYqjhPXIABkLtcepNkD0ht2QVXyoyM2/YuZjyeXR+yYJh3x6MLx8wxpa08aX+u4ce5CSdYs5+FYMffjYiIQNDzQH26jonaGA==
X-Gm-Message-State: AOJu0YyigbczkLxBbv7sXeURDu7Oxl9NjgS8QBvWtKZ2CqD0Nk2jDnBQ
	ByyRDhP3ONp8BJaoUJ5AQa1j5IsG7oexJ/FXvZDsGO48mP4JvdAIUSttGNs1nIc=
X-Google-Smtp-Source: AGHT+IE5F3k1D3gik/OwYN8x0TQzZJEWeyfDVo1rW4ITdbpkHe2CQWcwgqeqMBIIK+FUBeWV/a2ZZw==
X-Received: by 2002:a05:6e02:1c46:b0:365:fe09:6431 with SMTP id d6-20020a056e021c4600b00365fe096431mr3732415ilg.3.1709739318559;
        Wed, 06 Mar 2024 07:35:18 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id t2-20020a92cc42000000b003660612cf73sm324467ilq.49.2024.03.06.07.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 07:35:18 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Tony Battersby <tonyb@cybernetics.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, 
 Hugh Dickins <hughd@google.com>, Hannes Reinecke <hare@suse.de>, 
 Keith Busch <kbusch@kernel.org>, linux-mm <linux-mm@kvack.org>, 
 linux-block@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
 linux-kernel@vger.kernel.org
In-Reply-To: <86e592a9-98d4-4cff-a646-0c0084328356@cybernetics.com>
References: <86e592a9-98d4-4cff-a646-0c0084328356@cybernetics.com>
Subject: Re: [PATCH] block: Fix page refcounts for unaligned buffers in
 __bio_release_pages()
Message-Id: <170973931770.23995.2545307873508420124.b4-ty@kernel.dk>
Date: Wed, 06 Mar 2024 08:35:17 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Thu, 29 Feb 2024 13:08:09 -0500, Tony Battersby wrote:
> Fix an incorrect number of pages being released for buffers that do not
> start at the beginning of a page.
> 
> 

Applied, thanks!

[1/1] block: Fix page refcounts for unaligned buffers in __bio_release_pages()
      commit: 38b43539d64b2fa020b3b9a752a986769f87f7a6

Best regards,
-- 
Jens Axboe




