Return-Path: <linux-fsdevel+bounces-62349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EABB8E961
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 01:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A968189C13B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Sep 2025 23:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C5D28CF50;
	Sun, 21 Sep 2025 23:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpBxzyam"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0FA242D90
	for <linux-fsdevel@vger.kernel.org>; Sun, 21 Sep 2025 23:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758496112; cv=none; b=tKU0DduzQ3TEAOFpE3wZd/9Zmm0unURYfrF8noVNyLgB3sw+QMwsvqvJhf7VnE0UpngqXtGltCGgaolzMsndoPSoJHoFcu1O0YCsAtXD1S8ImlXEncLIfoHI0Fzaq1Grc870ox+AVRDEhAvvg+a0GnNI2S6LqI16KW/0e6CVCHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758496112; c=relaxed/simple;
	bh=kp7sTRbvQCXDyuEv7lCMhx18j8NoJQstWz5bEdlO6i0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=myln1Ka3iZZPsmU7dIKMSHTnFIC1xXkV/az90SL8Pm0MmT/wjOaEbwApENcy/KIqHuptcbk6IZR7kVWBwloKsu5ZXNEiJt9DZGJXxPTlDmZ4iFjroFnVHAFB768Qv7d/76IG8jZn0k7KS9cIWeaENYEOnaFmG9ZCGa4EjAF79Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TpBxzyam; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-afcb7322da8so706558066b.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 Sep 2025 16:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758496109; x=1759100909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6tuSy0V0l07vFSFy9Q6h9CIcImr/SidadizJrDYoMvw=;
        b=TpBxzyamd3UoBsYuC7Kxvt8fyDLb5JWbAeYqjsLW+uE1kscQ8YDM0fE39a+IZJDj4p
         6FvQ6J3Y9eySk9poPZpSf5HrlBLc7dNhHUKSdTp8xGK/btqZtp8G55HthLKgzS3ivoJj
         CzHvMqA5TGUHWXoUCxHUAo7gse9eaK607GuXpAJ9SQijVj9/jvG8RbYJOe1v71Yrc+0s
         /VUNWWm8Pvn/qO7nNYSnXwK77iVE04NvWL/q5uJlMBRDVx8CA/t/StpdpYT2Wr1iuaGV
         W3fpq3NRoVVvKT5BzBBS2z/Nyj0SOCRRJ21eckXkrz59rmoZQdEjRDqadKWlgOkQg8ny
         lpgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758496109; x=1759100909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6tuSy0V0l07vFSFy9Q6h9CIcImr/SidadizJrDYoMvw=;
        b=IsyvaAC5/jtD/uqNlTPT8UzaIxcugfdaAJZvyj0VCxCZR0ut5KaEw+oo57H2Pl8YTs
         2PlFEyEpNjLzy7Q5v5DMvH0c0UiTRW3nUF5wZRgAm/nAYs4g+ueGEmjeL1zr+l1pXhOR
         /AGaQWGS7T7m1Yd51gEubRyhEpvskfQ5C9kSefPRSL5BHeI0kFos6wrPCPB1COMdlWCe
         qy12Rok4CWABgq8gwCepecJLm4lS6oGiXT4NY/xSTfxLaPpUgrn7KIn5OyYPQNhGL6yV
         DecTYkboF/PgyVzlZdstqyP7oq/RGWprgXsCKc6fwwOzuCZsdKsrSv5EyMHztP4i8WvE
         SKjg==
X-Forwarded-Encrypted: i=1; AJvYcCXrie57547UTJ3siI/lrq2x1Zb+9KdLrrnm4sU++TmdlK0z6mjOEp25bDc7oyFUIE6nOkGrPwydxwfXA/Ea@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0dzLK8zaIlXdjLGJUis+r/NxN288slsjVD8U5vBvXlIydH9Y5
	kzuYHGU3RSgYwzgsF7IsErd2f0Pe1VYOJA9eNZGu10ktvj7eCmtlSvkZ
X-Gm-Gg: ASbGncuJBt57wmDsVDHtNgTo6PqvJcFoN0gFedmCkShQqfWrpdiJzmzzHPx4it17zLn
	V4lCGnZHz1xchN5THvCuUKnDNTc5KcgF7x47Jn5WxLJwPTUo5e7GfCT+ofBYRoL6kYdR0uESdtR
	AOgdnVF5t98qmLyUgCa7Te2d9ewL3YgRq3knLg/OvKJp+NaGhIP7o+dVKRK1QU/3375MOSK8rce
	E2ScsfrnSk+c14xZu8vpNPGUlljUN+ikxosyXphuqLJnfGbt8LiSQ4vnt5Q/e780qMCCrbVTJWb
	M2RShmSXBIC9O+DGwmAH0/ytK2GKsftFJra2+Zzex6V1WrVOUjEwCrGCMcISJvZ6MhCKgFb1sAA
	iHyLraT1E1xODVkw05w8=
X-Google-Smtp-Source: AGHT+IGaYL0rZYaG01O9JWNyxpX9QMFT7dX6PEZPc8o/39RX71pF0AyzIyHiFTeTuo7PDhxHHUV32g==
X-Received: by 2002:a17:906:6a19:b0:b2c:b12f:429b with SMTP id a640c23a62f3a-b2cb12f63f9mr126937766b.62.1758496108686;
        Sun, 21 Sep 2025 16:08:28 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b1fcfe88badsm941730566b.52.2025.09.21.16.08.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Sep 2025 16:08:28 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: cyphar@cyphar.com
Cc: alx@kernel.org,
	brauner@kernel.org,
	dhowells@redhat.com,
	g.branden.robinson@gmail.com,
	jack@suse.cz,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-man@vger.kernel.org,
	mtk.manpages@gmail.com,
	safinaskar@zohomail.com,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v4 05/10] man/man2/fsmount.2: document "new" mount API
Date: Mon, 22 Sep 2025 02:08:18 +0300
Message-ID: <20250921230824.92612-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250919-new-mount-api-v4-5-1261201ab562@cyphar.com>
References: <20250919-new-mount-api-v4-5-1261201ab562@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> Note that the unmount operation on close(2) is lazy—akin to calling umount2(2) with MOUNT_DETACH

MNT_DETACH, not MOUNT_DETACH

-- 
Askar Safin

