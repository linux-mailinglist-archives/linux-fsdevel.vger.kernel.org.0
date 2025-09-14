Return-Path: <linux-fsdevel+bounces-61256-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F134B56AFB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Sep 2025 20:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2EDB16F189
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Sep 2025 18:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF812DE6F9;
	Sun, 14 Sep 2025 18:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4l61iDq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647B32040AB
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Sep 2025 18:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757873121; cv=none; b=rT4+TCdo+MacAFTBTialA/E+fjhNdkR9fsnuJNOgi3SpzfHtyUV9yig7Exb+96HQnHiMRtT5Uyj4Kd8o44DjARUIik9R4BpQvC5+/Q57dwcaPbnHlSeyTsZ/7ldzvdpUzlLIkkuwmkuNeHyITsRFdpEUxeVBs4/D9euN2gI0wCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757873121; c=relaxed/simple;
	bh=U/oSZwJ6hXUZO7BXYjUpX9PpBgB1UmE/oYFBn6YfwD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HGikIzOE+6eShk30jH9bsiCvBCzVPShX9+6ac+d978Q2bDt7UqBUrrBo9uUIXcaZff3PpjVieQo24iitN0+6Dv9dwm/1pS2HifkXF+o4I/+ivlQYseGS+0TwHaRh2hLacJ+/AW9G4tMrY/oWXfuYtkU6n0O/E3YgL0ajqDm8Raw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4l61iDq; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b07c2908f3eso372192466b.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Sep 2025 11:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757873117; x=1758477917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4KN1lZ+2zq79cOp7ZHM2rwumR146D9sFEX36wlxfX34=;
        b=D4l61iDqujyd+oYaOsEP8qgqe4daQr3cKNlUD4AvDp3nV0lY2M1hs+YDNzjiSh/pKg
         1p2aV2JkQdT/xWs93jXafOSqY9BOOekgvNHRRZk3QgkCRrvby8YFNXEkpKWRUTizW06D
         reIiROITB1OPH5awW/z3j1CxlYvPVkIQH4C61k2EkSvUICrw4eWBGTjzcO0VndrV0CDP
         JE188cAqRL0K2aOpHk0Z3K+nhIT6BZNgjDxlBXPiZGVkimib197Kbs3FUj1WOTLGFwFV
         gT7WXOMbI1oZXrY/t+zVwDya50mPs6Q+3SjLMYxP6uypTDtkYq9iqq4IKEBDARDxuLTu
         r/Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757873117; x=1758477917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4KN1lZ+2zq79cOp7ZHM2rwumR146D9sFEX36wlxfX34=;
        b=tEs3sEiMeF2PcBk6rLIrV5g/JVYprKo6ejBApIyhh3nXn9qzuBqEjGys9AkzUfwUc7
         Px63zUuExiUqoo23Z6N5X84w1H5zr2AAM51MjH9Chg18sQhnjf1JLOyMAEM4WE/OcrHZ
         YA4AEf9fEKypR9u0L3JsH/wDh1vBi3mmvfOY8fm/zL2tYXNHFCYDXBdPgLwxovzYPg/D
         syOlQ04JgoadY6TQLs9fOF6F3OuVoLse/UniiCXsu2ys7xztgpwmo2HrsoiTJpc25cI+
         gVUiFyCPgYGvIJM3ywc0QHstYmSI+KtAlRH8AjqvwAzKotzgFquzWvo4rgfFSDFv7F9j
         Bo9A==
X-Forwarded-Encrypted: i=1; AJvYcCW9Ec0v53gN9cCW8kTjlANjzWwPGvWGC1Q+4Vp8NJKUmU+wgODt67qNu8Eg9YYTTh6rVibFY1uwTS7PAnkA@vger.kernel.org
X-Gm-Message-State: AOJu0YzlnrhUZm1Xhk0Xn1j4YkotKo8Hlm/BkGpaggDigJ6RC1nEpzMm
	OmF/52ytjknqMePK08qHUzbIY9LJB+BpeuCrzyJlIK/ZpQjRnkgP7o/+
X-Gm-Gg: ASbGnctC8aJamOHM1ysbVdcdmR0UcE1k3z3yzA+36Ststdicnu0Nrjh73yhW8tnHo9g
	21pWDvN/FazRjBKcwskr/j9Xr8hDIAwdOgcCTQzsBTQvuDYfOQKzpb6Gyv8Vk3kpzhmfZcTUl8N
	y6QyMFw0ILKCplca/7Zp60cbjYuttqevzGI75jTKBAde76HJv2whoHrJ6MnxorfM4XBE3qUfeIn
	z8O2gGnZBVUgj2I89+s3MDjFGuiio/nkkZR8NBdkzfnNI2h52AMa5FwVesYrQOl++GgUVdrnvUu
	1ap60jVb0d2zd3rlo+T3H0w8nRaTvFsZ0MCC1R2ggbNJj2oJB0V8N15IXCXUz69RSxZTXhE8Bv8
	jr10uB1DmwDoGqONOYO4=
X-Google-Smtp-Source: AGHT+IFkMyymMTbmjIVjk2mrOuil/EgfPYT6sn+w0/OHZs5G4QDk4E2t8ponRzmEDowdEHWkiQCRcQ==
X-Received: by 2002:a17:907:962a:b0:afe:90d2:b952 with SMTP id a640c23a62f3a-b07c3512afamr889531366b.29.1757873116332;
        Sun, 14 Sep 2025 11:05:16 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b32dd408sm781141966b.59.2025.09.14.11.05.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Sep 2025 11:05:15 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: thorsten.blum@linux.dev
Cc: brauner@kernel.org,
	hch@lst.de,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH] initrd: Remove unused parameter 'pos' from identify_ramdisk_image()
Date: Sun, 14 Sep 2025 21:05:13 +0300
Message-ID: <20250914180513.1649962-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250913143300.1796122-3-thorsten.blum@linux.dev>
References: <20250913143300.1796122-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please, drop your initrd-related patches.

I recently sent patchset, which simply removes initrd support:

https://lore.kernel.org/lkml/20250913003842.41944-1-safinaskar@gmail.com/

-- 
Askar Safin

