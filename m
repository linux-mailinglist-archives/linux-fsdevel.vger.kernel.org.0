Return-Path: <linux-fsdevel+bounces-22803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEBB91CB32
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jun 2024 07:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEFE51C2258C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jun 2024 05:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D407A22F1E;
	Sat, 29 Jun 2024 05:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYIq8xGF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067E52574B;
	Sat, 29 Jun 2024 05:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719637728; cv=none; b=thkQ5Y27X86UUn5X1L/bR/MPArB6JW0gLlLvxkU2frO0bVXAvXsK1Q3iA7yBNbfkBm+gfgyjuzrzkGhDS5KF0mJ2um8ORhWn970kLTr+fxoKkpQSRLeHy4SfbCZhrbaN1iLmTQqEZiiygSIwejYiG84R9rqoc+IiYNbDmebK+ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719637728; c=relaxed/simple;
	bh=UKw3yZsiEJ3sQagyK7bPffVFQ+WL5759UwplEQoQte8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=edisJUe23/JvROyBwDr1zCSgJjNs1oSKrDJJ8ZMoIuqbKhXzOdabO8OXTXzDtRpgEDUsZvjtuN3tRNV8mtNZ4kz7HLFc9iJ8qa8V7Q6JCBSs7XdTZIixqiUCMVwJNBnFOs67ap05rB92L2UvQqrUE5UlFVDig0km0qwse3FL+C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYIq8xGF; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3737dc4a669so5508135ab.0;
        Fri, 28 Jun 2024 22:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719637726; x=1720242526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKw3yZsiEJ3sQagyK7bPffVFQ+WL5759UwplEQoQte8=;
        b=YYIq8xGFw5BGSGcmcjqy8jwaYdR+gYPgeAUm63Exjl9s7lRVnvA3KdtOLUg75kqQOc
         SAB3IDM7/kbli5jtlouDlw0Fv5jciaGY0OiDwayT8S6xbuElHPUkv40exxfUTXRLCBBM
         vGIF8fGswSL2CADJKCwgT1CJ57wjUZCFQr6ljeDTHJSQVS654n4SLF5pjuYKA0mumn6j
         2vkZaZBuNrGGJz4UxPTM7McPVJhy/XOkpbgjFvY4YYdctWhQ5a9fClgnbf0dcZ8ngGcn
         vU+cbZL2/jSCGiCUL+zgjNNXtzC8iXD9ftIZxMerGo8a8Mr2YAs9WY7t8j5h1QYdfWOb
         R0ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719637726; x=1720242526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UKw3yZsiEJ3sQagyK7bPffVFQ+WL5759UwplEQoQte8=;
        b=jkWAsapQm+c5sIyZuWt+Ru78bx7744mFI8ryXNfzE3TKNT6a3shlMFQ+nmudL1PP6F
         znJTGz+TkDUuOlL56I7874YrMJcnGL3sBXwHpGmvETdE+81bat5nvKYUOZoIpZ949Y4m
         roncDPdcEhPnS3EbAoOLF1pdG4AgBacPna7Qsh4EYBGp/9ZTBR/xzdtxNrLE0aiuF5P5
         qDXYbQ8hVAijyDYgByEBCA0YAF6zJzu7Y7VByQMM9U3TObPtvXPVMKU4+5+8D44LfTm4
         EFl9ZpiwPR8TieAJBr26QLFHkUBOS9+h691nQz+wuZ9TUjNXOPfFA4n3LXUZjakhDIiK
         RC5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVctRtrWdcl9bRQZKL4pyVmOGjWZSoha5kHwegJPgaBoesODPPmFdTK7Hx5vdgAjcz6rf7LMlOG/JGaLMsG9rgAYNP1JuCgiZgLrSodRzQ45+3JOi/ULYjzjoDda+8B3NpwPEzHuF8sWFt7sPMOWh3BdZZRyCuuivj8LktKcill0sztbQgVCTASE4IxEw==
X-Gm-Message-State: AOJu0YyA1+7xR3UWBC+RnCvlZT/4afKvBc/o+Hx+Dp0zi84+lKfyPb49
	SNWqheQY8pq4DXlCoKMZuX2Pe1Ag2VRJWjGw6Pjjy19YPdUSlkap
X-Google-Smtp-Source: AGHT+IFzCIIbJbprV53JWa5jq90gCbhKWFPEXv58H+Z69M6U7EP3n/zD55Xyy/rA6+Ph24LIy6+88A==
X-Received: by 2002:a05:6e02:1a84:b0:376:410b:ae67 with SMTP id e9e14a558f8ab-37cd1c78523mr1771085ab.16.1719637726152;
        Fri, 28 Jun 2024 22:08:46 -0700 (PDT)
Received: from dev0.. ([49.47.68.167])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70802b495a1sm2552236b3a.92.2024.06.28.22.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 22:08:45 -0700 (PDT)
From: Abhinav Jain <jain.abhinav177@gmail.com>
To: akpm@linux-foundation.org
Cc: jain.abhinav177@gmail.com,
	javier.carrasco.cruz@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH] selftests/proc: fix unused result warning during test compilation
Date: Sat, 29 Jun 2024 05:08:39 +0000
Message-Id: <20240629050839.990471-1-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240628133014.111d3a0690033f9fcb2bc57d@linux-foundation.org>
References: <20240628133014.111d3a0690033f9fcb2bc57d@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 28 Jun 2024 13:30:14 -0700, Andrew Morton wrote:
> Well, it's all inside `if (0)', so just remove it.

Removed and shared v2 version of the patch here:
https://lore.kernel.org/all/20240629050449.990451-1-jain.abhinav177@gmail.com/

Please review. Thanks.

