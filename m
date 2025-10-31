Return-Path: <linux-fsdevel+bounces-66632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D79BAC26FC7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 22:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31C17420EF1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 21:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DD82F12CF;
	Fri, 31 Oct 2025 21:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNAxWIVs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0611E2F068A
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Oct 2025 21:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761945197; cv=none; b=SG06ZvuWcrwVQTblN/7VvDOJymvCwrizQ38vqqV4LlxB/eCxCm6VZpSLcPj3bschbmohLzkvOd+0105/n+WCvly2I/UcaW+t6lcyD1lSLZEqg91DiKycZ1klsguYiDE828sJVGKQfW/jS5KajFgknwbYy1dfomiuQf8UZtyiPtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761945197; c=relaxed/simple;
	bh=brVsdDlZphgTIjiEPnKsVVmZWFrsXZZ2F2YOYo0xe54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KQuBk0gP5cKLAP0A8rcSIK352SKstP7EMW3SDy6DfYRENJWQRxkrNoJEl5DgQvjStDLkyBZ6MkZI0oefNu3ranPRYzh7xhwit9V3zcetKhjqxDQocXtYfWZ+wbX7STkizTO7Ribn2FNXeBYZQy01IaZtY5dLTBI4EPZCf66+jxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TNAxWIVs; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-63f8a31d126so2247123d50.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Oct 2025 14:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761945195; x=1762549995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uSD/lVmenYFs/3KOi2SCw983pRt+xNFyn0MmMCBTTDY=;
        b=TNAxWIVsnkMlSXa31HaaMgZWCLo1Yk9imWsphzWuuiazYcEPHG9sYByOOrKcMruNih
         IyKdIMGKvoeM6LC94bjr5DhkclF+anqiLMNX0ic+iRffORqvIt3YpYVj2iuY0CBrTqCt
         0C9S3RaXA0KDOBerUFymcjBKQUaWNNZ91uUKvp6hvIlQ3CBRO0ldOo5NG7ulC7Vxs0HB
         FH4/93WOIchlyBR4GZincua43gh4V4FfEeMqpftgLZgEnSkZWekvWVveiA4osEiJpJSi
         ZgQMKC/sKHXIPRn8+GvwQa+55sLA84TVnx1PlYKjrQMqOIkPN/moNxlheKrTZCvS/F3r
         HUZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761945195; x=1762549995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uSD/lVmenYFs/3KOi2SCw983pRt+xNFyn0MmMCBTTDY=;
        b=ONTwhxDcs93PlQMnRVD/66dYrlNXd5hGT3phOAQufbrzGuYaD6hqnmSWgHf9OmDZEa
         TJjLlRHGJCNhv4914xnJtigDt6+pza+hqExaWq+qLpJ3tyCO9D1QtxxAgwJKG47xe87D
         jBfIVMzAL9FECmMy6/Fa6C8rEXiwXjkcdsE305aktY0XmOWU1ElIXk5ZcpRovCwDSvlh
         I/6YWWEmgg3Dl1TDy6QeHM/mqC71obdNddVAp/c1myA5g2pUuU5DYD/QFhPXBLoWDA4X
         rM42O8pFNQq7xx7W5woYlm50/82Ka0uoPIjIM9tf/W77eSTHPFmgImLLZNRptkEdyVW8
         h/+w==
X-Forwarded-Encrypted: i=1; AJvYcCW9y4JDwFuz2dVumNu7DNlzMrsIlyOEbL4IGT8c9ot2EtWjtQQgQQfrTMXFqohhxGdjk6YWaiV5yjfxEw1j@vger.kernel.org
X-Gm-Message-State: AOJu0YwXzM140uvw221KUDOzIJEC9N0UBPVC5kDPbRVklqC43g07BWQ0
	p0xg14JvQorB1OAvsK2Q/PYBZzdaL9vdkigP+LTNqJv3HDy05FrZeR6x
X-Gm-Gg: ASbGncuosrLlKO3reypHCrFGabxQuegrW4l7zVjhAj9T4JsaOp4OBurMC2gTAWXJWX0
	6O0cOFd42f2usl5ke0aXTZTi9Klc3WZ34JegLCUAcCBF7J1Boe+54uFtzhtH+t7RbTJP9x743DJ
	fReLPD0ycqjJeG+i7xn+cZ17DOK4m67sOi4Z/0H2fS8Jle0jZQtVtJPi6Y3BwGlcQOeNQ2QfZD8
	FFRLcLoYYHOMme0w/xsv8eQgYp+GKRgAaFec5hRu0EcykOXks9iAKlHlOQu3N7GkaQeNYu57GuY
	0sLkS7Hh9BnrTjctPRJIOZr/JoYK7oRfScrdsrhbhGAyF1dR2JTFLTWq0YqbMEPSLPXtlh1w/V4
	XPT2TZPyXhAWI9WuL70QwFeG4pxyiftAY70y3ZJ7mYk2vYQrodRx7DH70Al813qKPtbKj6ymJn7
	MzQgkYlF7xegf0LiptNLLVwlvEAWgY8A==
X-Google-Smtp-Source: AGHT+IG9rOGt5XNomHWVXmZGaO8Pl7NCXLTEbkflf5oYlYwv/I8LRbO9SIwlfz0K099PQ6rWCaEHQA==
X-Received: by 2002:a05:690e:4297:20b0:63e:d6c:a832 with SMTP id 956f58d0204a3-63f9223f40amr3483923d50.13.1761945194818;
        Fri, 31 Oct 2025 14:13:14 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:4a::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7864bc9490asm8728767b3.13.2025.10.31.14.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 14:13:14 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: bfoster@redhat.com,
	hch@infradead.org,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 0/1] vfs-6.19.iomap commit 51311f045375 fixup
Date: Fri, 31 Oct 2025 14:13:08 -0700
Message-ID: <20251031211309.1774819-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes the race that was reported by Brian in [1]. This fix was locally
verified by running the repro (running generic/051 in a loop on an xfs
filesystem with 1k block size).

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/20250926002609.1302233-1-joannelkoong@gmail.com/T/#t 

Changelog:
v3 -> v4:
* Drop rename patch
* Improve comment wording about why a bias is needed

v2 -> v3:
* Fix the race by adding a bias instead of returning from iomap_read_end()
early.

v3: https://lore.kernel.org/linux-fsdevel/20251028181133.1285219-1-joannelkoong@gmail.com/
v2: https://lore.kernel.org/linux-fsdevel/20251027181245.2657535-1-joannelkoong@gmail.com/
v1: https://lore.kernel.org/linux-fsdevel/20251024215008.3844068-1-joannelkoong@gmail.com/#t

Joanne Koong (1):
  iomap: fix race when reading in all bytes of a folio

 fs/iomap/buffered-io.c | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

-- 
2.47.3


