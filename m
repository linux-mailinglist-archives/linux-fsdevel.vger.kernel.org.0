Return-Path: <linux-fsdevel+bounces-61257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76458B56B30
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Sep 2025 20:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A9763B1614
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Sep 2025 18:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1932877E2;
	Sun, 14 Sep 2025 18:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WlKSpSE5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543FA635
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Sep 2025 18:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757874357; cv=none; b=bR8Edfa8Sbq0IDQPR+wle950LUmbCNNg1+vqq9iYFf6bmHkUfInmWXL5Op1zUY2EGPm8P5PNYmvmUNUdDChKTIHSeIKIDO4hGtcZzUa0QDrE/M4QGw22XIidtBV4xt833w7aXg3a4hkDwK9KITiFrLJSP9OeThJZhGEDlIV0K4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757874357; c=relaxed/simple;
	bh=Q8OJYhdHaHILYof6wv59VQL1m3rnqOtB0SjQybMVjFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tFv50eGYMr3N4lgoOyd18L3GEMsildPFoDa6IP2ReFm6WouepHNTFaBDkqgMsD0gsWf6EhaD0HqjhHKvk2fT9aDIT6RTwuSmSeYp6xR75G5Gx9Mxo/3fbWsyfpNKYqMlmI1cljV5qbSQqZJRAr0tyeRwDKOp8C10W9eaoarQVDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WlKSpSE5; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b07d4d24d09so336144066b.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Sep 2025 11:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757874354; x=1758479154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BdeKEdVn8sOmJUOLY1Vb5kmK2eriC/+AQzWZe1N7Gh8=;
        b=WlKSpSE52sQbDzvrQpkeacS/OabR2/Fma9n2iLwAj/+CS2ZjRCAfVSbUDnk0jmNHsp
         cokyjbxmD1HHv/pgAl+/e1d0MaRtGhscnTnhj2IkNy0LU+DgrGDvhHPxPdpfBYO4dr/t
         gFVttvGj2aTgISrhRRqQNW1F9O9fM07xa2xR3C4H4cXqtPIt9LnJpNgO8L0onR7/wmkI
         7vWNq13XWPi2A/s8X/6I1+GEwfPjeZF20q37waDtl6ISHc/aDihmAMmetdopvkWJYPnO
         AdfJkSFRN/28x2t1gndoWLogQZr7go3y/Qe26T8beX1viS0mZJ1cEeUugqlAV0hAdQLx
         58pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757874354; x=1758479154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BdeKEdVn8sOmJUOLY1Vb5kmK2eriC/+AQzWZe1N7Gh8=;
        b=oue4NM6AC5bLzHoglVRYNtzi/VM7cv9gtAN9UTY30fYwDAE/LnLAeEt32kG3rnR5Em
         bAfYwroPDEc3mvrXNy6BzBpK9wE2q+bLEsJ2hPwMHRNqdICAJmu8etYBg5SFL/9f1qTa
         5GpCvmn71zqYwTXHiplMSiRotnkZnU+p3kZFeMq2eh0TRmf4etamNETWa55n1h6AvWxk
         pCb3YhQFobuTXz8N4A4g+rd3bf6hBA76XdxwebSwMAhAwcmc6lj6R3SQPxHpr3tJ81uR
         8TWqgrx49BjfOPXpPKBkLvSGBhDUgnypf+gdWIYnRmOilZXGyzVrotg+sqtHo6M3G6hY
         Zqrg==
X-Forwarded-Encrypted: i=1; AJvYcCUBLhIbGkMaA4k5qIOGhOeGREkgp3EYU7jy/0ILnL5QCDQ06K78wVNf2SJhK8ySAu5XMlj9LZuYHTXUv4GD@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4jiOxE1+csZ+qHmFUsjt/Xr/YPGliYOCScOIgTzFD/whUNbyp
	R3OOpJ2afq2QJuQdQvzaq4sjGUep6zfMGyobCqbUnOuEY4rgO5MJzS6fFcnsGA==
X-Gm-Gg: ASbGncuJKaJAJO8KN8fKBgbhC9O2mJyfg+SNAAAMKOVa07daEGCPximnECxKLuAWapN
	OhUFfyEekDHP/ZJ1oZNP1VYzVvXTTUYHV4MgLdHXIFVHBNDXe0Bia4ZMqxQa4p0qwsh6JbTe/dq
	he4zdim5JTd5uDVsp83+ZYoa4H0XonmUdkvFVg2re2tEMKNpgXspiym6CcoBhc1q1+i0CoAzIB8
	A+EVxPrGif+SGks1gSqTo/9d+GWuzQjVdgJjikr6E2C4VrC15inln641jf7548jzWM1kM/2udBK
	RNFvAjbs2pRvtVgVhLP0Z187R0ZXw+RSRA2uSK4BMxoGAzPSoTbHoYRuvFuoeONbtsSHIA5xyKq
	ixyC9AkW3j5xOGc1x/II=
X-Google-Smtp-Source: AGHT+IHNeQGnC5o6ShEqS3As4wOoOe2jTDBENsE190ifmEewzRPGOVJvdBkP6T+XqYxstA19WEgAiw==
X-Received: by 2002:a17:907:3f95:b0:afe:ad18:8662 with SMTP id a640c23a62f3a-b07c35c3229mr945229366b.23.1757874354380;
        Sun, 14 Sep 2025 11:25:54 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b3129199sm780334566b.36.2025.09.14.11.25.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Sep 2025 11:25:54 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: viro@zeniv.linux.org.uk
Cc: brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: Re: [PATCH 46/52] path_umount(): constify struct path argument
Date: Sun, 14 Sep 2025 21:25:52 +0300
Message-ID: <20250914182552.1661507-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250825044355.1541941-46-viro@zeniv.linux.org.uk>
References: <20250825044355.1541941-46-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please, drop this patch.

I plan to inline path_umount into the only caller in
v2 version of my initrd removal patchset
https://lore.kernel.org/lkml/20250913003842.41944-1-safinaskar@gmail.com/
.

(path_umount is called in one place only
after initrd is removed.)

-- 
Askar Safin

