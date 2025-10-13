Return-Path: <linux-fsdevel+bounces-63903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B675BD15D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 06:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 479321891F4C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 04:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A702314D2B7;
	Mon, 13 Oct 2025 04:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8jj0mbK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5DC34BA39
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 04:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760328916; cv=none; b=nuUb1BAtDwV/jUA46vs93dmB4HTCVdQe2YNG2L0jxzmS/On73txqo5wAwb7pY0G6PE3grghSG6PpwL3cfUD0HUgrA51JsBetH8CFXvnPKfz8mWALWiNCRmFOzM4s3ZfHizz4p5VyloLSIBKP7Tb8OJNWfPLZM3qn6Toxu7HSJXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760328916; c=relaxed/simple;
	bh=GIwQaiTj/5LG+RU8+Olm1P2KmF2g2ijoQR7LtNWSqm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zo2L6vquyiFI2wE8yy5ixn2plOt/qg9UbG/J/N8/07C9idi0vHAq7nLN/3BP4tDEsTZZ8cgrCdp59xIq97B3zexlQ01AIBs7PLGt6g3EtRYLjDSmml9ENxatfRzXafzFwr0M/uuGGIUltIYp44XbvB+lEsT7LWJHJsAY2r84Kwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8jj0mbK; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45b4d89217aso20438615e9.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 Oct 2025 21:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760328913; x=1760933713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=colkYyZbzoORxyEYRGBidVhmHrro9mfSyhDk+5cS57k=;
        b=P8jj0mbKRJce8lpHjLn6fvZkpUMoo03H6bQO2WoMsHJ7pNZkPyKFcBPeRHGgyXmZ1t
         1o4I23DBKO8ZyBp/V/CG/05Ksd6M9oS0vhoIp2Abp1cgePNPI4lMl1xA+xYVj3vpRhIN
         ZZcc7v7efLZ9oSpa+G0I8IpBoTadFXGTKWb07fvX/XjAFPTferEKgrayLBU0JtMpRPSx
         I6HhImhHVr6Z+9LUhzCEmPxkjgI1wGH/sfL5XOrSVI5FxDrtwRIr1cuHNJTdVDv+uSM8
         0zMk8Gv2w0E0MlE6aiusshkoPh4gZO0ultt08Rce5Ycmju7p8ZB4byCCmbdDv/zmVhiD
         j/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760328913; x=1760933713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=colkYyZbzoORxyEYRGBidVhmHrro9mfSyhDk+5cS57k=;
        b=gJe4lPsJ/OxIcXweiGRyDf4lh/POZ7vHuSnaRizEOEC9+vX5uoODIi+ojUiO0y0KNz
         6voisXAIEzDxHSnpk9VbBqXqdJFkoGeDUvN1Bqs3GOL/JM/nYydD/EGAkdrFw2o30SEt
         CVlbqa2moJukRxJjeQvwWmRYg5Skul06vWVKLvCP51o+wMoW7fdTQNkJ/oemSOg6P+Ai
         c3jpjXF1X3iJPVl+M0xUXmeTolm86mKv+uX26qb4sMJOKFeA0WoBN31k0in2rC3qzf+F
         mr6DMwgC867HnNVgrtmIW1EZyTiZD0wRI2LM3D+bqHJfqp8VOVSe0iWJpKFTfoepE+xr
         Vb5w==
X-Forwarded-Encrypted: i=1; AJvYcCX1Q/B8k8PcnkrK62YCmTVuSuG8BMg6hvIaGJ6CaLuOP7N9KU4rJv8Fu/wVtguQ33feF4GfjiYYVQm0aZxx@vger.kernel.org
X-Gm-Message-State: AOJu0YygoyGX5SqvgaJ+txnsJ2MrsABMMtIZ6V+YH19jmYWUM49RwA4X
	1UlIAfXrlH464dAkHCYOkhaeQj5zNew6qk0q/CKIAIVTcjfyvlOM3zWK
X-Gm-Gg: ASbGnctitzy5txkJ9rgMr22+kcKjv4D+lio5l1JZHJWrB3J4Bg4GcJUTuXvmowSbx2o
	tGFK6F23A33I8Cati/Qt3vbbB2t6goWltleEwKa0RkmPIfB4sAu1PjXcGNXezVDTbOTkbYUcj9Z
	kCGJDL4RKVh+pYyKobREcgveOwUvPHmy6uGnbO8IEoajgGbu2oy5bycSL8mqTcVAo6C4qAKRMxv
	UMlRLCwktDf7EgCSsti/leTbpUGG10pezUe3oJ9rLMET42I6VStarka2iU9fbaH5QmJiAoavjhl
	subA36usJ67Bc2BVsln9Xg1Z5c9NTdZNV4xVia2Bs4SLcKCy5bH0qHAIS9wp5ess+4+8iJkknfX
	uMCcReKWiZ0cM9RUH1XO5ZKyLdsXBFut1A8IxQ4JYuNQfcYoxm2e8mEi/1x0=
X-Google-Smtp-Source: AGHT+IECiVBvIpj/XkfavhhFkEhUHJSj2F77oaKYcZbnOL1gCKKAC8pproGszqhcGtZRZGjYUmGA5g==
X-Received: by 2002:a05:600c:4584:b0:46f:b42e:e367 with SMTP id 5b1f17b1804b1-46fb42ee40cmr83475705e9.41.1760328912477;
        Sun, 12 Oct 2025 21:15:12 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46fb49c4027sm161997725e9.17.2025.10.12.21.15.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Oct 2025 21:15:12 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: luca.boccassi@gmail.com
Cc: alx@kernel.org,
	brauner@kernel.org,
	cyphar@cyphar.com,
	linux-fsdevel@vger.kernel.org,
	linux-man@vger.kernel.org
Subject: Re: [PATCH] man/man2/move_mount.2: document EINVAL on multiple instances
Date: Mon, 13 Oct 2025 07:14:59 +0300
Message-ID: <20251013041459.148478-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAMw=ZnTuK=ZijDbhrMOXmiGjs=8i2qyQUwwtM9tcvTSP0k6H4g@mail.gmail.com>
References: <CAMw=ZnTuK=ZijDbhrMOXmiGjs=8i2qyQUwwtM9tcvTSP0k6H4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Luca Boccassi <luca.boccassi@gmail.com>:
> I don't think so. This was in a mount namespace, so it was not shared,

If it was not shared, then this seems like a bug. Please, say me
reproduction steps, I will try to fix the bug.

If you don't have reproduction steps, then, at very least, say something
like "this happens at line xxx of this big program".

Also, note that "unshare(CLONE_NEWNS)" and "unshare --mount" behave
differently: if you do "unshare(CLONE_NEWNS)", then all shared mounts
continue to be shared. But if you do "unshare --mount", then it
internally does "unshare(CLONE_NEWNS)" and then equivalent of
"mount --make-rprivate", i. e. makes all mounts inside new namespace
private.

> it was a new image, so not shared either, and '/' was not involved at

When you make a new mount under existing shared mount, it becomes shared, too.
(I just checked this.) Also, on systemd, all mounts (not only '/') are shared
by default, I just checked this, too.

-- 
Askar Safin

