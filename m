Return-Path: <linux-fsdevel+bounces-69852-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EA4C87E02
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 03:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42F403B00E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 02:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6201A30BF68;
	Wed, 26 Nov 2025 02:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MN7ScNh4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535962F60B2
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Nov 2025 02:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764125729; cv=none; b=Ys47nuGCW7pJsNx9QqO14iN7c0hHtvygoKGQ/zgKWi4m+ra7GAcgI2V6dZse7BpEWS2/FIVf/6B5+R92hqf2KjQ5focZluQuOuYLn5affAqDiyYiU9WDtekIMbwe+xiO32qAGwG8k7TrZ7OjnwKCiEhYVsCFBgiub/ALObUvtB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764125729; c=relaxed/simple;
	bh=QgtDQPuNkQZCpxtgBCVizza+HY3TwWFNRo9VOhtaSPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LMnrEBiu6BgJqJxGUlv9n0GO+jrCBUN+ozI5fT/QNmV7mnXraGgHB9He+Vmp6vOt+HCpMn9xlYEqE4uJZ8V0QWFi/XVh+rwAyzziOFGF4JzNuuYRWpuvoaLzt7C4i6kMBnopW/8bp4D4C9ecHC40jAwHJUUj7RL6YfYgQZ80HRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MN7ScNh4; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-343806688c5so5219261a91.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 18:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764125727; x=1764730527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gQaJZMvR3LXorEoSZo1lRnZb/COwwg9HrYqvFeEyjI0=;
        b=MN7ScNh4Wkupd3LXRVnORu3h8skikNavOulaJ+HURNHXxOJIFw2RPSIiUIjy4VcvDs
         BfVYQJIR4U+r/pS0m/oebiZ2FzHdaQ6b5VSgXG1J16IxBfBRKsQn/PcqI9bz8vHKyjHQ
         RyVZ8XuNa8/NqBocab6Tq81zE5S2O5EPPtOkeV0NJOGeOSrzykX61l2MADaJlwLIWZNV
         Ku7JUlJMe1SVXbdiTgmRqntGTG8fLB6lyqYvWd+1h8ROWeBemCuMNY7dHuftz6KSGvXS
         lB5g3F4ecuIv9TcDxHRGwbKJkFCVAo35Jndex17ICX7RGceVgsh3zRFTrY3Se37bAAeM
         gx3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764125727; x=1764730527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gQaJZMvR3LXorEoSZo1lRnZb/COwwg9HrYqvFeEyjI0=;
        b=RAhUNClbPnWwM12C7L7reLf0k+tAn42hcT3C+ZShTkBMYQ/Q7ujhuURROHS9KiK1rh
         g59DF0FO7IAxqRby/XsSyVxQ/7191MQqXyos28AZetcI1AyfHYuvpaR6gfHpI/8knAlZ
         UAKgDI8cxLEXG1b6MtGxekGsCqXQzCHdQjrkRL+odozxLcdcYG4afPVvwfQk32AVc1M/
         7e/GLEEvK+CO4x69WNiVERcHtXxBSnEkCtf2hsLXh51TnGzEw6vp2640Zr14WAfd4olQ
         ESSpl5TMmR8S1pybZAv+bVgxDrTvArav66Td37r7zB164Evs4pdKSolqwuIm97uetSMi
         UTSg==
X-Forwarded-Encrypted: i=1; AJvYcCUHc5w4y71JQgufr4RgzTnKoIUSxJNp4qt80wo6cfyZwhi7D8qZbCEaZtSvg38VMwa0K25K3FzHKsC0BJ8I@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj8Juc3VJsy5sKYLX8rcnyoG1RrpSk1jjBYqwBMltBxzaWhYjw
	eqvcdVEESAM2klCeQCAGQtYlaIq7cnK5BG4k22B1XZhweWEsmxlDKc3C
X-Gm-Gg: ASbGnct8rMRs04wo42FcPFl2QCXi6TXZ84Rv51QlZIlcRDOYtYBO0JsjxeJ1rlicfHn
	qDpz8TKWLXfwroaTeTUWnMNk5zQ/cUZK1w7eAvSuv433p98UHs681PeamWEUIY3z1f0LG6pp01R
	nj/GgjvBBwVFVMn0asK0BmujLM/1l0eKTa1jx5kMuRicD2iSh8iVQqtl7CRBjxcG6dS+eMywl1g
	0AlDZhbEpy23kZXK1mNutd3QShB6ziNcHWYTwh5I45OaOtVBQd9zF/jPA5N4s4W7OVx40jCFREI
	QN9CAXCjvMqlsX7pU85zQmc/poYWw42sq22ZtCgNzmIqwHznthRtdyNp9BgimDPhqxdRmka37+m
	J9eqtQ1n4u8+WEGQyEg7sDXFBK7E6FB0g8rGivh7VQaIs7qCuCZu8dlePwFIOiXPr+YfCqOz/hR
	9cGJGsUcnuaQg=
X-Google-Smtp-Source: AGHT+IGoKsSn88yOaV8yW3ELgtKTGKK8nyHanpYEmJrEQrWciON7o6VHAzT+5lGJU1vlSoSNPWQHuQ==
X-Received: by 2002:a17:90b:4c4f:b0:343:edb0:1012 with SMTP id 98e67ed59e1d1-3475ed508e8mr4841309a91.21.1764125727501;
        Tue, 25 Nov 2025 18:55:27 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3476a54a5a8sm811261a91.4.2025.11.25.18.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 18:55:26 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id C9684476D833; Wed, 26 Nov 2025 09:55:24 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux AFS <linux-afs@lists.infradead.org>,
	Linux Filesystems Development <linux-fsdevel@vger.kernel.org>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Daniel Palmer <daniel.palmer@sony.com>
Subject: [PATCH 3/5] Documentation: dax: Demote "Enabling DAX on xfs and ext4" subsections
Date: Wed, 26 Nov 2025 09:55:09 +0700
Message-ID: <20251126025511.25188-4-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251126025511.25188-1-bagasdotme@gmail.com>
References: <20251126025511.25188-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1131; i=bagasdotme@gmail.com; h=from:subject; bh=QgtDQPuNkQZCpxtgBCVizza+HY3TwWFNRo9VOhtaSPM=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJlq2SujJomzx8ZkP3v8bfpuZsO5ErrleWvndBrMirJ6l hmisndbRykLgxgXg6yYIsukRL6m07uMRC60r3WEmcPKBDKEgYtTACayvJ3hn8XH8pzuxMzyrTpB cT/4JE4zqs30N94Y9+/RJLeoys314gz//Xh/mrb8+pviIle/3mmWvWENo9OF68evPXE9f61nZ/8 vLgA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Subsections of "Enabling DAX on xfs and ext4" section (both "Summary"
and "Details") are marked up as section heading instead, which makes
their way to filesystems toctree entry. Demote them.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/filesystems/dax.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/dax.rst b/Documentation/filesystems/dax.rst
index e0631d5f6251d4..f9243d45ce1280 100644
--- a/Documentation/filesystems/dax.rst
+++ b/Documentation/filesystems/dax.rst
@@ -38,7 +38,7 @@ Enabling DAX on xfs and ext4
 ----------------------------
 
 Summary
--------
+~~~~~~~
 
  1. There exists an in-kernel file access mode flag `S_DAX` that corresponds to
     the statx flag `STATX_ATTR_DAX`.  See the manpage for statx(2) for details
@@ -95,7 +95,7 @@ Summary
 
 
 Details
--------
+~~~~~~~
 
 There are 2 per-file dax flags.  One is a persistent inode setting (`FS_XFLAG_DAX`)
 and the other is a volatile flag indicating the active state of the feature
-- 
An old man doll... just what I always wanted! - Clara


