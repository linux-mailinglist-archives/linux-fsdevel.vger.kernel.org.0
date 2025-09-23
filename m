Return-Path: <linux-fsdevel+bounces-62480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B40FB94871
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 08:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0561A7B0527
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 06:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A4C30EF88;
	Tue, 23 Sep 2025 06:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="pQNuksgV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812C830E829
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Sep 2025 06:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758608168; cv=none; b=Scw3iYEibG0bDZhud8lHLep8P+3d9X2AIBJu7+MOU6mTVLjqk0l61txGleCka1bvLj+gSLbhK8z4UI5VRvyUaiJ47Zbr9FrDtQl2c10FsjBFsBTYeq2gpBGO2ZwtWa3x4ARUpL7VrNBljhdF+5XpA+VYMna/sSB/XVackmnDWsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758608168; c=relaxed/simple;
	bh=hD3OyQ5pf25nKvDX44eZPgzgzaCMLNBDyqZl+ZVGAdQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hI8TJqUZsUINinJwPtkkgAKfXPIbTQwkdOvGDQ+d+0nenAIm5His+V9ttpZPPtwVEpcOsgvByadEoYhIV8rxWV3YaamJ9xnGXLj3us0bfTHSPcM2cr08Fs+aurffwt9iOJ6cqQl/FH2ffZxIHIGP1x+9Ndk0hUBLD65qH+ED8NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=pQNuksgV; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-77f2a62e44dso2991169b3a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 23:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1758608165; x=1759212965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SqB+MBmWbGWhXPKkNDOEdyh6sNxW8IJTQY+jeJPWHj8=;
        b=pQNuksgV6XfvkPUrE68/laDXSvCRDVjQznG/iTdXDBXW3S7Xrj/2y16BfBMTSQx1pn
         bpKUEMbiebfFjhRo5j8VGy9vzfiJshHArWmV5/ESISGfTYDQu9ZSMz7NKg3vn9DSAuRE
         0WjV7EVgCvMeRT0CSla5eBAGrhEh9/StXm0+T9r3IIJJ9dIoffMduRGBLyeqULEuVtal
         WP0zUUABx6UeTAuxU5eMEZj9IxsWvrJrSDUKr93k3fogPGcopdMDaaTFozwE2ZrjBKmD
         9Yhq6ac61RWCylPbdyS/iRwhq+0mIKQfCzj0B2De49Oa0pe2dMVMr/6UUgVjnKW4cfOh
         fDxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758608165; x=1759212965;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SqB+MBmWbGWhXPKkNDOEdyh6sNxW8IJTQY+jeJPWHj8=;
        b=iaTnjcA2g7to6zVwdlT7m0N/pgv+VvhBBxdBxltYlYWhIiGNXvoAcxGQXjBPEMrjM/
         4x+cjnFHrvVFLmA//D6lmazPENTdotmkxYg4FdeIMPWt0mNcp/7UoLOuT1uZL/ZdcspZ
         FtA3bfYeWhUOEjzi6hE/Qzmmxa+Yc3pTQ4jdBS5oNfclY7MnPdW62PRBVlcWLZ+hB3RR
         2o5H5oDtM7p6OkuyoZAbQRi0mLhmzgdppjHySmYfKA/1i1+o+2DRCT6i+VnTqi1PpUCy
         hRVIHhjRpL0VMuv534Qp/IfF7sLjTm6VXAZEJoRBVynV40Ogs1hwqpknDaoRBCWmXErE
         H0VQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSunsdqbmc5tL0PsoT17HMOj/8HUVCrdtyjzw3oCqxp9fqIRJz2L2CmMwXG/NEuOTa55aDj3qHIwYZUEwi@vger.kernel.org
X-Gm-Message-State: AOJu0YwB0sU9jSnFZve2OT13M8BdVHoRRs1+PKrHYI6++7ZrUPsnFBpd
	gYdThg3AIZq+2uHf8Tgw8RB/TMJ2o3eta8PMrfyD/SpB03mD9mBHOdIPOWRAoeSLK8E=
X-Gm-Gg: ASbGncv+cndD7IRJdctFGsdD744ZFf6ncd4WWneX/oSfbvJTh4CnPrP0m6peWqMx/J+
	/5X8luaMAmG+hRZJQ+UDr9ot/xjICr/h0hUwFyaPWWnr1lpV9bC88NVjCLtilzMy0xWMbwEqCly
	WoyQQMogOjnOX3Eyb6pYXzJ/UCpn/dMiY4IITOllPLW3efY8T61ITm3XKjFCDRYLvVn7y5T60zu
	NwhlyJhbLQFgdNxK6ls4xVVTDKsAO2SbeoYIg4i1PaSmQ3pTK/sUk3RAj2ZXHo6qtelx0Q38APy
	CjR8Up4vZzkF23WRLFdmJWgKSa8iKtFE21FjXMBCkvOMNMikJhQrt7Av4YrGDFK5q0mdgbhf8GN
	LXb9LPjKPtOr31F36zw==
X-Google-Smtp-Source: AGHT+IHuGnb8PBfUENdPuGyGvLbbla7V1vgnkQ+GzlyH7sUUWYMzzRFQlMWMmSJwfIFZawKhZl2ScQ==
X-Received: by 2002:a05:6a00:4fd4:b0:77f:169d:7f62 with SMTP id d2e1a72fcca58-77f538ea09bmr2180704b3a.14.1758608165503;
        Mon, 22 Sep 2025 23:16:05 -0700 (PDT)
Received: from [127.0.0.1] ([178.208.16.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfc24739fsm14285188b3a.28.2025.09.22.23.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 23:16:03 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, Chris Mason <clm@fb.com>, 
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
 Miklos Szeredi <miklos@szeredi.hu>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org
In-Reply-To: <20250922170234.2269956-1-csander@purestorage.com>
References: <20250922170234.2269956-1-csander@purestorage.com>
Subject: Re: [PATCH] io_uring/cmd: drop unused res2 param from
 io_uring_cmd_done()
Message-Id: <175860816137.146699.7149828855280856823.b4-ty@kernel.dk>
Date: Tue, 23 Sep 2025 00:16:01 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Mon, 22 Sep 2025 11:02:31 -0600, Caleb Sander Mateos wrote:
> Commit 79525b51acc1 ("io_uring: fix nvme's 32b cqes on mixed cq") split
> out a separate io_uring_cmd_done32() helper for ->uring_cmd()
> implementations that return 32-byte CQEs. The res2 value passed to
> io_uring_cmd_done() is now unused because __io_uring_cmd_done() ignores
> it when is_cqe32 is passed as false. So drop the parameter from
> io_uring_cmd_done() to simplify the callers and clarify that it's not
> possible to return an extra value beyond the 32-bit CQE result.
> 
> [...]

Applied, thanks!

[1/1] io_uring/cmd: drop unused res2 param from io_uring_cmd_done()
      commit: ef9f603fd3d4b7937f2cdbce40e47df0a54b2a55

Best regards,
-- 
Jens Axboe




