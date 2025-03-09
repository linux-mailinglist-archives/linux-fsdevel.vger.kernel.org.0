Return-Path: <linux-fsdevel+bounces-43539-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F067FA583DB
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Mar 2025 12:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BFB118954DC
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Mar 2025 11:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BF11C5F1B;
	Sun,  9 Mar 2025 11:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5GXvSUa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72FE19CD01
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Mar 2025 11:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741521137; cv=none; b=t8k5mRbZSJ87jYO25HKfhE1nq1ewNzkmh/qw1DNNbUhAxasVUpUt20IpVpFE1SUexq1xZ5nVcZGIHaKgHoKsnYs0g6svX1vqQ6nwPaZZzTTeyqMxAcexuTIUvcnAAdNEYGS9Y22OB3LxGsFapspKf7GinlniHFnI8XqbgmzOeik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741521137; c=relaxed/simple;
	bh=auW4/vyrmRaTwgDFEhQAgI2qQvs5YQKtpwch4SGBxqA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TZiJ2KQyb9fCAyB6ZH5YzHlGAO2R48ONDfLaUziiyAGAnPIr6pHO1XEBL/zoQawTD1W1Lk6z3aaD1GTshnad2yE0qCZc6KWYWjNp53VI7WVe8t/E33bEVXFdDih2bZTG5DzbA5JLYCHRwVQzoeyoaxMUGiaIzT/OGcIeb/abNmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A5GXvSUa; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e5e0caa151so4317241a12.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Mar 2025 04:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741521134; x=1742125934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8PrBWp09QEcMXaVikQSNNgnzSpcNIQXnn5zM8eS/iww=;
        b=A5GXvSUaSnnitWq7GlqGnEZRN3h7nsKc0eAXoI/IuPqwlN4xNURWBvy2JZdJpLt+SA
         v8oYNOMsf/eXo0ZtFhd45Drb1YKt9JZci5qL7pi6QcAUKFhFhBCGtogXN8vdbxpO5RyB
         UpGEh8342a25xLDeZenIo8HPf18fhOFOYufjyy4VwwLq7cAKW7ad8WCepHH6cLGugHkl
         ZUs4wNzaMvGSVCDmDLtbJB/nWtoek+rcT8H7PyBXVm0CeAoqzBimiqbV8Cea2W/A0UJB
         dZexI7mT/Ljc/7X/i4MTmOugGE6eXEm+M3dyCdhcYOjHvsnr5ul9Nd/z1pal9AtnDgrr
         t8bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741521134; x=1742125934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8PrBWp09QEcMXaVikQSNNgnzSpcNIQXnn5zM8eS/iww=;
        b=v+LU9Ev49MlHfVHuD7MYeLlkL9Ywfdya+HminvBMwZ35og5mOLWMlndE3mwFjlEA5+
         POLg0X8gluy+VJJHbNqsnTHgA1mmcc87YBpMf59d04kLV+Hhjo0B+7y0KTws2FQhGse1
         2dmYdCErXeGRoQhcJZRfPNz+xPUOgPJq+h1+b0OnQ+HlBem6RAwOIDZx817KxAXb1W1K
         LWF1mVHYEdwUjONhZR8x+/2tiOi3MPRCl8iWb4RKM4FK8GJAwM9D7n23stUG+6u+ZAUR
         mUbzqIAYLUnWBNHcpZN0SI2rY4Q3aaiTXvwFpm8GesfxEmkUsky0yixgoU8u6XxQQ+vt
         Pjyw==
X-Forwarded-Encrypted: i=1; AJvYcCXV5BgXVB80qImmiVir6qUnPu6K2mB0Kd9Gx62LPWxkvrwtKmADsORt9WXMNBXhJqPgvaD5IX5VguHv5Brr@vger.kernel.org
X-Gm-Message-State: AOJu0Yw80LPF+E5R47FbR+5MQwwjX9Jk8xonPUKXv0zvUfW+y0plEKYo
	e9e02R0oDk+MJm3z2CTwLEWdNFKe2E9szSOeP8j260Rs/KA66Cxwtzw5dVn1
X-Gm-Gg: ASbGncs3LMPN+Rq44g4A95TicbDPV6opQH877Z7GDOUemTFN7aJOU58REInHlRXmzCt
	+VPN2NL1XcOZ9s7Z2eNFrlFdPNqTLyDrWLYdn665luHTNNnO4nXWYZKEUkBiEAJtwn045ghfpbU
	kJ/rrEjEs/uqxrU/ojSTP0JqILMHvoFrNl7G+i37jRU7S3xn2HPFAQXDjaTc8yCvQnGzQGYFIaX
	shDAa8CLDBIgNhA8KCG2RWtnZexOCxICWgGesoKRbRXXZgY4iW4AMCY4Ny9oX5Vq8v2OB2JqaLx
	gqWf5waAcLyB6ahR/R/LvNc2wJrSsV2rdqHvgfmQAT8wMgfevtfKartwxkg2S/K35924sQ1cxkF
	7JA9UZL1JQnWGA/QpvM+kx6oIrJqhS39OM4asJMwFkw==
X-Google-Smtp-Source: AGHT+IEQmKNaEJTpKZ/Mu0Q7fA2mt7BK4EeZfrlErqUEMeGjsQ6LkYasZAbNLLJeR7Db8XwgQRbF2A==
X-Received: by 2002:a05:6402:518a:b0:5d9:82bc:ad06 with SMTP id 4fb4d7f45d1cf-5e5e22bf16amr11911424a12.3.1741521133652;
        Sun, 09 Mar 2025 04:52:13 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c74aaff1sm5270273a12.47.2025.03.09.04.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 04:52:13 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/2] Fix for potential deadlock in pre-content event
Date: Sun,  9 Mar 2025 12:52:05 +0100
Message-Id: <20250309115207.908112-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jan,

Please consider this fix for the lockdep issue reported by syzbot.

Thanks,
Amir.

Amir Goldstein (2):
  fsnotify: remove check if file is actually being watched for
    pre-content events on open
  fsnotify: avoid pre-content events when faulting in user pages

 fs/notify/fsnotify.c | 29 ++++-------------------------
 include/linux/fs.h   | 18 +++++++++++++++++-
 2 files changed, 21 insertions(+), 26 deletions(-)

-- 
2.34.1


