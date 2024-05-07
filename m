Return-Path: <linux-fsdevel+bounces-18881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1599C8BDD8D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 10:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8DDE1F252C3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 08:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FAAE14D458;
	Tue,  7 May 2024 08:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6JeRMxe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A70114D2B6;
	Tue,  7 May 2024 08:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715072155; cv=none; b=r7NKPOj8/KLde24CHTawEj3mhtQg+X9CeSaJl33qS9NdCMLfj2ERaykUOAYXb9zrbItHF4oR3JpPgI0Vs99PUMgvW9/L0tJDxHcyKaC9mLKlMentEEBkzBGd/y0lEa9r5kI746bzk5hAP9n4zgWiTBamwViV8DTfL1vQXhozd6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715072155; c=relaxed/simple;
	bh=k0TlOH0CwcqcFUouuxHPCKMSASbj/4kOwsIES7h/HlU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EQEFCh3EXgfoVfmJ6jNJUY9vk6OKBhi9ph8QTZogFAMSZLiDsNfCqYZDXOp8SEHtcKqYuO/aKaTuyOY9hFC22f73ZMXnrlCdKrjOyJwyi5XR5LSuNNbYX1Eb4KP4rPYlp0NpiJuZm0FzLHyjviakli/8nEtZauuwVqzZqLdacBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i6JeRMxe; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5c229dabbb6so1763614a12.0;
        Tue, 07 May 2024 01:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715072152; x=1715676952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1Fimb9lb6VpgTgHR6cAZaOkhqFKoxrpnSn/tyF6vHlE=;
        b=i6JeRMxeim6U9ev8N/8pTX0H+I8XHymmqgiX+zQkphXNPoANcZyWW2t/FlYBhIpoJi
         SpAfdMui+yNxa6bQTrZIDKfGwmbR9tasBdxaDx7veMMF0F5OX5mKsndQGN+SM1evH8SJ
         lhie5sSL5vRH4g3hY8lvuJM1jKcTRSeLPur/nFFTNz17ELAy+MbtbREcLTIcECvNsruy
         bTMLwG3YgMZp5Wuv5DlnHJ6OLGv7nNiYPhFZcIDjELO8QP6gOOQWBIEkyKqDupFr57c8
         AcNmJ7zpWT92JiDVO894fQgznHPBCBPp558SL3xPaMgxE+UcA48YHR8zWfLVY3GPpWxk
         jRgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715072152; x=1715676952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Fimb9lb6VpgTgHR6cAZaOkhqFKoxrpnSn/tyF6vHlE=;
        b=Vn6zn4rlIiujuQy2zaAcMyMzN/xySaIelmGWCgEemST6x1LMyMfDyJqfnPN7Zq1jTm
         CQAAKCXvNEpBPQCgfqCWBWqVkIPq8S8bt4d0UgCO467zCqLemXvFfC/Zu8gJh7jHcunm
         avgiU99bZg+UYsM7u+Z6y7veNrRq3q+b6qM7Ol8MOZz+KFRoP9/EX0halA9PlrK7Tb+v
         9zlD+9GC2tfzIqDUxDVeJ5P8x3hwVx6zTsFHHbn/EHmuAZNEpCKfCqCiHli1iMCUF8P8
         wSnHAoM9ybgeck4rJrLS6g1dgh/opeMRQ6KrJsfplvrE9J/+vkjg/NFGn1c6FusfAHyF
         pdbA==
X-Forwarded-Encrypted: i=1; AJvYcCUKLLkK65/JuqtBELjbuxbtm0t0dGfRGrCgiLrdCVta1vMOFi9uzIIOCulQ9GDw0Cm1QRR4knw80B0UE1+SlfsbuXTXkWD/TH8yiiDjlQ==
X-Gm-Message-State: AOJu0YyDX5l9sKp3Bg0tfp8Y9BcG+PsYeH+6eM6ipfZhbGLUAdVm/zo4
	ciHvlOopzSG9zQ60aFA+ulvy1kALIxiaYsoEt3Q11Q5CnpzRFUwzQaSTLhZV
X-Google-Smtp-Source: AGHT+IEtepl5bgKBROThFRYk/jAHV30JpIOZQW1AS41J1C+JWr8UYu4k6tLMmgLiyWRZHaj99PK0UA==
X-Received: by 2002:a05:6a20:320c:b0:1a7:6262:1dd1 with SMTP id hl12-20020a056a20320c00b001a762621dd1mr10311695pzc.51.1715072152538;
        Tue, 07 May 2024 01:55:52 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([171.76.81.176])
        by smtp.gmail.com with ESMTPSA id kg3-20020a170903060300b001ed53267795sm7262030plb.152.2024.05.07.01.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 01:55:52 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-xfs@vger.kernel.org
Cc: linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCHv2 0/2] iomap: Optimize read_folio
Date: Tue,  7 May 2024 14:25:41 +0530
Message-ID: <cover.1715067055.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Please find these two patches which were identified while working on ext2
buffered-io conversion to iomap. One of them is a bug fix and the other one
optimizes the read_folio path. More details can be found in individual
commit messages.

[v1]: https://lore.kernel.org/all/cover.1714046808.git.ritesh.list@gmail.com/

Ritesh Harjani (IBM) (2):
  iomap: Fix iomap_adjust_read_range for plen calculation
  iomap: Optimize iomap_read_folio

 fs/iomap/buffered-io.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

--
2.44.0


