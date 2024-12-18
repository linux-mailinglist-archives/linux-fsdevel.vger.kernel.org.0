Return-Path: <linux-fsdevel+bounces-37736-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 577A89F684D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 15:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 214887A39B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 14:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEBE1F8AD2;
	Wed, 18 Dec 2024 14:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="dOtCxDfK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10C21F543E
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2024 14:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734531765; cv=none; b=SJkVWiFRBpHHEZA+DrhOvchGCusOlq/6LdtpN3AmL/dF5nmb0eVrAe8xc55WN9mJBPjcIkeK0lBX18UgECLMtYCPQPlGSz7tdI0RHeFFqh6F1yksFFK144IyDMorKgek2OTMidXLjKqBoTaZ3ih8yKsVf7KMHMI6JQUo3MoK4g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734531765; c=relaxed/simple;
	bh=2cCO4TPIhqj1S568UCAXFktOpIrfcOCGMJSHp79/37E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MFDUwULC5Bq0eBZoKbPs24Jl8k/Vv8RNgdhFEmQcBkpvwDqLlOMELmb2JqpyYvTwDJ73Mn9zYvPL256/j7lEKQ5oTlUZg6SrVc9sItHXepZiyM9+nE+q4ZOUzh+57Lst3XASQhVekiCImvUTshuX/JZj+GqmUi8D8GN9OmAO99M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=dOtCxDfK; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-844e06e5d11so189149239f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2024 06:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734531762; x=1735136562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fwaa/EgDeMA9up2TWsDbHlLa7APuFdygjy4wgwg8iAg=;
        b=dOtCxDfKkX88TBwkr+XbWIlWzsNj+EkvhG1K5cyk1ECaSGesImJfMAhwgBmImiyE+e
         H4+66NEzR5FabKlCuDbvTwvw7kA5CWQ39wp3GRAGfTMZ1uoFqYW5zdZ3YwhHymID0ptf
         ORZ7YfclziZSVUvf2x+M0xpJpU+SCEfMY1ASBmXnBzCzSchRb6O/XIyCjqhpq1rtlbPe
         G6KnFg/KKhrY/CS0OMtPndDtvrtl9etQWXbSmATI0g4rXFhfLYr3Za72Q0iJUBRcUwRM
         AYEh9urz5wqvH/PJbFz2coNjv1AlINA8mISLK3Kr/VavabotFu3z3yU/DcssuLQOBpxo
         TEmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734531762; x=1735136562;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fwaa/EgDeMA9up2TWsDbHlLa7APuFdygjy4wgwg8iAg=;
        b=wOYannQQFN2HSdBPQpayycj0FuGIANnPoFQbYW0EuuqHJnQD6Rjvp+X7ZZ5VWAwFB+
         yu8Euv93lRjCteCNmvjSohF88ipYWM+0CLH2+pno6ZXBfM6wqLPavc1JWw2d0KqsSLkN
         ESB6KlW/znNQAO65Cl94WetOcJws8Tw8nEmU9aEPqc2saD2PLpvKIgzI/oR71OxuRBEo
         r8MN+Br0bfVFWMIfZjdFzEgFBOTmK6M2SSkW/EI9xJbVgEqF02yvu4WUYAdwrlERGbKN
         yKov3jU5b/5m+ajs46dqb3uA71diICxbaUN9muN3qLzFRpVZl/MjI3V42iHuMHXkr91h
         Kd3A==
X-Forwarded-Encrypted: i=1; AJvYcCXKyS3wrunEb9mAlTG4dGFA6jA0nT/6bUzhXnCndKvq9oIeC1FHIOGvPREpFjSdqZwuA3sl2Fx4+HA/b+4N@vger.kernel.org
X-Gm-Message-State: AOJu0YyL2HcLioKkUb8Y/IcEogzbqYEaCSSqM1EgU5QlIOLlr21QSyyc
	7gYDAZF1r5Ii6XjXv0nCUWeBCNYe7a+dz+ZJsngGy9EixxGCdFABXHiHXJKpwMc=
X-Gm-Gg: ASbGnctF8NrAbrzDOJuSvaitJKnhrr/LzY2CvMhGEfT9j/V+4Bb1egqJ2E4iQHulVsB
	y9D/KOciipQkfHfpUQyriv0OPyZ6j//0Ow6/8/9eQGG9gkUbwTU+hCCLpx/gY7BfnFcCusBWg96
	lmC0tp25yt1rNAmp703YM4IvyYscf2kcvlZeoemx5SUfOGAQIBlmg7CWFp54oKH9nRHCSW7VM5M
	yBYFQMsJM0XR+DduB+YSRQsxaIJCVOB726/xcG/2AYt4e4=
X-Google-Smtp-Source: AGHT+IG89IFUUyc3IF//BxitryJKyat/xuxYfF6x/T3Q0v8wGvopf45eNMGXg+AVFNkeeO+fDQ1W/A==
X-Received: by 2002:a05:6602:14d1:b0:847:51e2:eac with SMTP id ca18e2360f4ac-8475855c0b2mr288106139f.7.1734531762581;
        Wed, 18 Dec 2024 06:22:42 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-844f62583ebsm231384539f.11.2024.12.18.06.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 06:22:41 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: hch@lst.de, hare@suse.de, kbusch@kernel.org, sagi@grimberg.me, 
 linux-nvme@lists.infradead.org, willy@infradead.org, dave@stgolabs.net, 
 david@fromorbit.com, djwong@kernel.org, 
 Luis Chamberlain <mcgrof@kernel.org>
Cc: john.g.garry@oracle.com, ritesh.list@gmail.com, 
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-mm@kvack.org, linux-block@vger.kernel.org, gost.dev@samsung.com, 
 p.raghav@samsung.com, da.gomez@samsung.com, kernel@pankajraghav.com
In-Reply-To: <20241218020212.3657139-1-mcgrof@kernel.org>
References: <20241218020212.3657139-1-mcgrof@kernel.org>
Subject: Re: [PATCH 0/2] block size limit cleanups
Message-Id: <173453176105.594208.15853494245370355166.b4-ty@kernel.dk>
Date: Wed, 18 Dec 2024 07:22:41 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-86319


On Tue, 17 Dec 2024 18:02:10 -0800, Luis Chamberlain wrote:
> This spins off two change which introduces no functional changes from the
> bs > ps block device patch series [0]. These are just cleanups.
> 
> [0] https://lkml.kernel.org/r/20241214031050.1337920-1-mcgrof@kernel.org
> 
> Luis Chamberlain (2):
>   block/bdev: use helper for max block size check
>   nvme: use blk_validate_block_size() for max LBA check
> 
> [...]

Applied, thanks!

[1/2] block/bdev: use helper for max block size check
      commit: 26fff8a4432ffd03409346b7dae1e1a2c5318b7c
[2/2] nvme: use blk_validate_block_size() for max LBA check
      commit: 51588b1b77b65cd0fb3440f78f37bef7178a2715

Best regards,
-- 
Jens Axboe




