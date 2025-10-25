Return-Path: <linux-fsdevel+bounces-65634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCBBC09C89
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 18:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 016BE580D81
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 16:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED9430B522;
	Sat, 25 Oct 2025 16:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BsmtDUEl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB14308F23
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Oct 2025 16:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761410438; cv=none; b=PzpfspqfddUeZcNvcStMymsW/ZipOXW/YF2Y+JGbIMUgtc8u106KJuiZHab9T/vOFUnwY5CGKkP5EAQ1jh8dXeHU0RXpdC+HVTJ/CsTR5+kazNKCxv7SN5N82hvt5QorJg1uwDR7FUS9bfeJDKen3fjB8r6YH+56Ydwjklalox4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761410438; c=relaxed/simple;
	bh=zAr2NN3Jns2OMOMJhebylpaZ7+Fr+NR7SMgQK33hi4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iamsdceQpUE1xjXXiTfjEbacwL8v/UCU23j/VJdVX/TBSm0kQkgePahOxPMfk2LtkC8zBlBT12h9eKQ1nPc1/3CB9f0PnQCsFc/SS+77r3RH/45nt4h6dFKLD/8RYhsLjBFHAFcnvlie7Ahg++dFhPkpsuqk/zzKC16EAmKSGkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BsmtDUEl; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4e89c433c00so35516771cf.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Oct 2025 09:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761410435; x=1762015235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FdGq6o03y1IFQKw38Yd5zNXdE2p5YkP/ZYXUEcu9OkE=;
        b=BsmtDUElEEHd7wsJHh8jVIKKqXTIIb0JCzAZ7T1NHZJtkr4OUMtnb2U7NW30yvJSP+
         Okeg2HgeZc8I+qUbWfcOvzLUkWYDIHOb5oFSJzOhmgRTjATGWoq68gw2LJtTswHzkBPY
         GlwlGcF2hQlfiUcSjS3pN6lnSbRHT6FtMnX+hDkA4B7h4YuJ4EaRWH+TsznlSyiDpIw6
         9GHIbLgZB3oCA55AOsiU3RnCWfemfhxBy0Bxcd/WjagLptzDZjLhi7ppR3XRv9bN4m7V
         HR199Zfw37czgFaP0nZMH+P6Bjp9Mxqe1yiAYTpF1z7mXJvlTLMbzw66QFfRhV6KqYeu
         HvCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761410435; x=1762015235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FdGq6o03y1IFQKw38Yd5zNXdE2p5YkP/ZYXUEcu9OkE=;
        b=ucqXnsu3bcx+db5Lh8rWlxx07gxbAK31ADsta5B3+bTTmR60mTmfXvA5rs1Zr37BzG
         hwL/Mlkj6X1maB+VWYCa+r3CmPKlqcBfgQ22xHfAOA+HyuIH+RZT87dFrhvvwFnS9kSl
         Lhj1yt0HENn+Q2wBZSsDAF2bc316trxFqvUcVqpZlylK3xNgPbS5+8Fw2UOx3IDM6wQR
         7TU/O07I9Lh2oxX+cFhNnn5C9zi5fgNzHiEUqbXn2BGbBeJuUntiX2YpwKNauYZIg0Ps
         qCNXg9iaQ0elo+fB9RLUG57XV9XC0zjL2IdB4kvq54iMN+raLDSxmc0PJrTFxr5iFnNK
         DPVg==
X-Forwarded-Encrypted: i=1; AJvYcCXBEkqa3/hrGE7YnYrvomkF5TcNCuc6aE+GzK/5y/wE71wBD/W2P2TKtAG70Y19jIR25UqEYNDiRMY9gavA@vger.kernel.org
X-Gm-Message-State: AOJu0YwODduwHGqgY9OU+4ESBepG2IA1Z2eFCmn/hGhXbJLRWngipSy4
	XRzbJphSPIPE5MpZYavH5nyd3mCWOScG6Hrryia+K3w+jCxOUNqmL1r2
X-Gm-Gg: ASbGncvtROY98Cd5PCt/O2TqAtLitg+1UXQimq6PMzkxBarsYS6l6v5mXoWkagouWAs
	OmZKknRlia7csbcAQND4rRtQuQMfOvgbUjhE68R/6w0AZyNTQRa31UXuq8ia7sTpf/I0htx2Uoz
	fWtbP4Ky1sJ4MHZ8XKRgJxtNITdflOyd+fMU4M08IdpG2PZh6l/liHIXu/Sx1HHiXQPix8OKtCl
	dfxX9GDFzoZBiPzsMLCwcW8wXjo08Ip7QR8Gy5Clpj6f8dEwLqcL803X5eawn41BBkfs6BDfGDi
	aPFk48Cd8AfEfxQ5FX3UoP8dRHmZiC0lR7sXEqzmg98G+aTrAURrDw/z4wVv9h0oBYxzWxKrhxC
	LZ/UBThq/nAGqgpXh43p77hEBAyOIpBFdVAQUwPb80fMHEdBOUUnEYUiKR8E6+fJSqEqWsqZdny
	p4BqlmJIs=
X-Google-Smtp-Source: AGHT+IHB7MFietozAVdiQPNgtEHZprXNbg0Ck/iHgJxOsJrH00g2y91+bZyBuwOOlRMQWPVBX5Z1jA==
X-Received: by 2002:a05:622a:1a97:b0:4ec:a568:7b1c with SMTP id d75a77b69052e-4eca5688377mr14668911cf.21.1761410434693;
        Sat, 25 Oct 2025 09:40:34 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eba3e193bdsm14687091cf.10.2025.10.25.09.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 09:40:33 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 03/21] select: rename BITS() to FDS_BITS()
Date: Sat, 25 Oct 2025 12:40:02 -0400
Message-ID: <20251025164023.308884-4-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251025164023.308884-1-yury.norov@gmail.com>
References: <20251025164023.308884-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for adding generic BITS() macro, rename the local one.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 fs/select.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index 082cf60c7e23..ad5bfb4907ea 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -412,7 +412,7 @@ void zero_fd_set(unsigned long nr, unsigned long *fdset)
 #define FDS_OUT(fds, n)		(fds->out + n)
 #define FDS_EX(fds, n)		(fds->ex + n)
 
-#define BITS(fds, n)	(*FDS_IN(fds, n)|*FDS_OUT(fds, n)|*FDS_EX(fds, n))
+#define FDS_BITS(fds, n)	(*FDS_IN(fds, n)|*FDS_OUT(fds, n)|*FDS_EX(fds, n))
 
 static int max_select_fd(unsigned long n, fd_set_bits *fds)
 {
@@ -428,7 +428,7 @@ static int max_select_fd(unsigned long n, fd_set_bits *fds)
 	open_fds = fdt->open_fds + n;
 	max = 0;
 	if (set) {
-		set &= BITS(fds, n);
+		set &= FDS_BITS(fds, n);
 		if (set) {
 			if (!(set & ~*open_fds))
 				goto get_max;
@@ -438,7 +438,7 @@ static int max_select_fd(unsigned long n, fd_set_bits *fds)
 	while (n) {
 		open_fds--;
 		n--;
-		set = BITS(fds, n);
+		set = FDS_BITS(fds, n);
 		if (!set)
 			continue;
 		if (set & ~*open_fds)
-- 
2.43.0


