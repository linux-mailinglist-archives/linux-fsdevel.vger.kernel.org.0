Return-Path: <linux-fsdevel+bounces-10988-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CF784FA01
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 17:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C686AB23938
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 16:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E9C84A35;
	Fri,  9 Feb 2024 16:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="VoZypl58"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879FB83CA2
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 16:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707497196; cv=none; b=pej7/oXzNzvI3JgKNHOzVlbl6JqT+W/AXJYC1k4tb1oZs3aPUw5lkPOVU8b1GcNTmF7Qxp6AnLsFSUrAT2UpMqk+Iib3HPsK2G/52gB7ineFPKRkKZJBYtTduHWkQDC6MfVAXywVGPaTmBAfPU5LYM1cOJVFLa4rNjo05vW53Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707497196; c=relaxed/simple;
	bh=aMoYoR9g55AaLeVo9SY8jJROmLnxcwP3+F1g3wH2V2s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NpDYId6ohF6nF2q2HWnlQsoTt9H/bfWB/o3LWsalFRo5CuJrmFWw3Lp2NZxhOxPOVqCOmToyM9XJrAN1eL1uhuZWfZH0gjRY3yRl2Oo6lxBww8p+EDRVg7XKJTQEfJ6AT/XW5a580R4YOoi2L9G0NnbAtvOEjwRLWk/p9E1Mo9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=VoZypl58; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-363acc3bbd8so473115ab.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Feb 2024 08:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1707497191; x=1708101991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Bk3lXdWdssF56AafgWiOY8EEPqiJtfg/ku6dTvlXx0=;
        b=VoZypl58goZxJ/s3qVAPjoEfp1esHUmxHSWUk6uVXpN6tLQTHv8VyWxvhtvnPmCyJZ
         82end2yHxyi11P+a/XVOC/uJpU5elcJa/sosiy7f6p+U9fJwS+m81UB0A8D93BwmcP1z
         zVvsujeyWAotqyfY9nhNYeSz1f96rvdiJEDNTdHTdSZ8YSvl/urUORno47Y/qHEu7FhF
         HZNGGBF36OYgCdHdRf/oACqi9664yP8cCSAzWS3Gj121aVV6IPNa7J40LTL02fs+yx3B
         K62mfW1/NTLPlciJyDNqR+oZMtWpCEO22xkPgH1t+1Hhj/knVyv+5+09FAmIALxoMU2J
         zrrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707497191; x=1708101991;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Bk3lXdWdssF56AafgWiOY8EEPqiJtfg/ku6dTvlXx0=;
        b=IceokyNM/iPUBssi6w3DsHgIw1urL/Eu0FDepFtAMyr300RXFY2nRHzj2eSQXrW17D
         C8Tn1cTtPd1F9zZNvfYQx3VAqMjlJqyzJPpCfpEXB+ursMBYP4bhsw6sgGgCq2ALgYN3
         zgfyuJAscKDpLZcoQWHENWw/ltfBp8SksIpCbj31WmVgCAt+FVswqzMEfGi2dD0D1jjL
         Yv6mfVuOcdIlLPUxNxC/Fk7bUlrmiOs8+DUNDRKpDu5TWiunxWWopHRhBuQwAbP63fAv
         d2cB8jq2X+3RjfEyeApSLytCKWLTBJPA+ZA5mBOpIQLB3NNgvWn51iO8VYBIvCIXmj3J
         Khfw==
X-Forwarded-Encrypted: i=1; AJvYcCUbuY+D6xIrCoaZSXz3+CdJnDqLB9jSUp33Kcpw+axqy+Wo3sh4UJhMiExVzP5AZVDF1qjerKppIvRhBKk2y4Ez+XNg3uZEUVDF+2Z1zg==
X-Gm-Message-State: AOJu0YwvLomxysx/WUj/mlAjz0BKDLpWf15OiofdYdxqUcmIrYuWmUVf
	rfBkP8QtUEplMY2ffb2yIjaB++ZlYXo8o2KJdbr7TJTDg/S7t9etf0lDiCk3TxS81GB30916oIA
	gYcE=
X-Google-Smtp-Source: AGHT+IF6KMyUQlSpXVnL5nXkIR4nChS6NBUQlTJeIWKJrcsyklo83lMphVGTAdaTQZOpeSidn/HpMg==
X-Received: by 2002:a05:6e02:1d99:b0:363:c82e:57d9 with SMTP id h25-20020a056e021d9900b00363c82e57d9mr2500117ila.3.1707497191257;
        Fri, 09 Feb 2024 08:46:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWJMIZMvr8B0jVeCz3hmgZ0EiIU6T7xB0RAkxgn9deHQnDVRxvqzSa2p4oeiHrSkrLZtH8OqNDPqYkVAhEbRqqbhwgW3SkcKTiZFYk/7j6FV3TNlsgV6bFAClumGqvEnlOl
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id y2-20020a056e021be200b00363ca35b55dsm188716ilv.3.2024.02.09.08.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 08:46:29 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Tony Solomonik <tony.solomonik@gmail.com>
Cc: willy@infradead.org, linux-fsdevel@vger.kernel.org, brauner@kernel.org
In-Reply-To: <20240202121724.17461-1-tony.solomonik@gmail.com>
References: <20240124083301.8661-1-tony.solomonik@gmail.com>
 <20240202121724.17461-1-tony.solomonik@gmail.com>
Subject: Re: [PATCH v9 0/2] io_uring: add support for ftruncate
Message-Id: <170749718943.1657287.1724106194346542608.b4-ty@kernel.dk>
Date: Fri, 09 Feb 2024 09:46:29 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Fri, 02 Feb 2024 14:17:22 +0200, Tony Solomonik wrote:
> This patch adds support for doing truncate through io_uring, eliminating
> the need for applications to roll their own thread pool or offload
> mechanism to be able to do non-blocking truncates.
> 
> Tony Solomonik (2):
>   Add do_ftruncate that truncates a struct file
>   io_uring: add support for ftruncate
> 
> [...]

Applied, thanks!

[1/2] Add do_ftruncate that truncates a struct file
      (no commit info)
[2/2] io_uring: add support for ftruncate
      (no commit info)

Best regards,
-- 
Jens Axboe




