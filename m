Return-Path: <linux-fsdevel+bounces-34952-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCD69CF09C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 16:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 629F6291CD5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 15:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970ED1D934D;
	Fri, 15 Nov 2024 15:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="m4820q7J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649B31D90BD
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 15:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731685436; cv=none; b=ruIvNoSXVDTSS0wz+eszDIoNuoBp66DS7j1Mpb5r/gGg60kCyZf9L3sCZnjwT1NT93dTTGly91gmK1skKFiUFo0E7VzikZwX6oT7G4L7uOu27WH+Ci1UHwghCTnRiCfK49fP/2F7bqq9P3E6TaOB+78WtOtvNMrJFCRyDsad1eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731685436; c=relaxed/simple;
	bh=2vXnHLGXI1nqsq4g2fvZanDqWRJ0aXZ76QxPPC06v7I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dTr/LrNokn5E2FW6dG9g0/Bn9rfWfc/oBO/KVSA9ghoYOJEppPqUk/hssHyD9tQzLAOmCtjbI6t43RQZwUACdjxC2wEHLuozClEavz/bl28/UQHanwMoNhLFVmYxzoIftVXziXEGfzHwn6wmn98feCPoZASL0xaIppEvxJ2QJr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=m4820q7J; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3e5f9712991so1008567b6e.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 07:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731685433; x=1732290233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6Q0wdk4ZkvBe0nUUQrCV7YJHywsuhUgJ4bITCNssrc=;
        b=m4820q7JttycVf4rDZM3hPZWHKgZk4NS1mjtFbnKsj6uBDzJidASvMlCStoAq6korm
         7gaILqtNWBKJkkYICR0/8+AtI7aJBO2MA1B/5+bg6Rt8om66UVuWDF8IVYZZmV+ViyH2
         bN00J8rYTdn2dCHfUmQ8OFoCVKNQY/hOsTwtH3J83lAoXF3Rzc2kQNMVlybWb5Q313r1
         d/4XvjRW2ec6iQQw67j/zcK+fAFQl6K0G4JlojMn3bD1NsdLh1vm3UBDmOq79E/7SDgI
         639nK9Ed83YCSNB08YSvMJiAjK/ssRKdcWpMsTEK8XYF3DXZ67vER5TkHfSKNHiWeElK
         ec1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731685433; x=1732290233;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u6Q0wdk4ZkvBe0nUUQrCV7YJHywsuhUgJ4bITCNssrc=;
        b=fmpTDihY7rwufG0IWUU/bJRHVJK/fw7OfcXvkq8pqfwgbI93+AS5SHJcdt9QhFXBCz
         Ln+iS42Tx3WA9yKifR1Nh19ZZd6FFvrU0/f8jKUUSMiYyJtYwRypKlgh6p2t0vZ9B+Ig
         6P37tsR0WuBBUwB5HTJx2tTUaC7nyiNM3r8k8ieU6yRAbXrKY52/nKzbabueLwRoaiGe
         N/drHifuEcxzEuayoFZygBrl+UCN+EMRF7/EhJuNvp2zNsi72LG6+fMNxdnTKmeTtf/U
         JxpbZorfPW3m++yvjIm3qfl5LyouiXIBf+c7opflcfM/m53KyKT3D/mNxMsNO0wVwK45
         XKUw==
X-Gm-Message-State: AOJu0YxSqEPfInwNF05K9EbUWckIpX7mqOuLdoIA82Gc3lhw+EDBHzQj
	avjXi08iDyh+Vm6h+aPeUlP1izg7ErayTVuU7Wepcf2gYnW32ojDcdYQMwWFKso=
X-Google-Smtp-Source: AGHT+IHoKx0DNEOlKpWzoQy2ROeqpBYo8WbCoTYJ6+Hw2EASga/6br7UpMDnvxf+cXpuyIDRatPwSA==
X-Received: by 2002:a05:6808:1a22:b0:3e6:3a82:f790 with SMTP id 5614622812f47-3e7bc7b0b26mr3470295b6e.6.1731685433461;
        Fri, 15 Nov 2024 07:43:53 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e7bcd82997sm563072b6e.34.2024.11.15.07.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 07:43:52 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
In-Reply-To: <20241115034902.GP3387508@ZenIV>
References: <20241115034902.GP3387508@ZenIV>
Subject: Re: [PATCH] switch io_msg_ring() to CLASS(fd)
Message-Id: <173168543269.2491301.6332603954754033870.b4-ty@kernel.dk>
Date: Fri, 15 Nov 2024 08:43:52 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 15 Nov 2024 03:49:02 +0000, Al Viro wrote:
> 	Trivial conversion, on top of for-6.13/io_uring.
> No point backmerging and doing that in #work.fd, seeing that
> it's independent from anything in there...
> 
> 

Applied, thanks!

[1/1] switch io_msg_ring() to CLASS(fd)
      commit: ffd58b00769a9cfee6a110231eb7d1fa70fe64b9

Best regards,
-- 
Jens Axboe




