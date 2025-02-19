Return-Path: <linux-fsdevel+bounces-42116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AEBA3C8E8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 20:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBD983BA447
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 19:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B5C215164;
	Wed, 19 Feb 2025 19:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcpvs2EK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AAB214A82;
	Wed, 19 Feb 2025 19:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739993616; cv=none; b=dI1/qSc8MuBdzhLJWQPYcgM3WKVSsK0AtgeQNTz+n4BGfmN2h12i4Z7fzm0U2F51JSp0eO8TaEJVQwyiZmhSxnPkI6+uYriCsL8Wc7Mwg4E1eJvBf+WQ5X3Wv8f1BkDrfdJ0/ZFfBKdVaDXQVV5AWjwxZg6q+Wo6AQCg680Td4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739993616; c=relaxed/simple;
	bh=GeZf4kDWRw/Af0VAE8UW473eCeB6nzQJVVunELl0mnY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ik4vhi6KxJLcon8gGz30w0f11nPdEp7d692/jSJlj0fmHn5avlMzj0b6kxBngrnj2yhKeDVB71s+lHj61hb5StC2tNPN4wx/r//Tv+rnVN7pySc1MIpUZuzwFkBrJqQKHnv1OjX3ZMtNwWvYcd6hPirj0sNiUOqOfrJn9DvpgTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kcpvs2EK; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2fcb6c42c47so267538a91.1;
        Wed, 19 Feb 2025 11:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739993614; x=1740598414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PSTRBDyjlCXG1A80Pr2C6LuOvywBhiJXPi7qtOpll3M=;
        b=kcpvs2EKNbI8ywPvCR2SjznLFmZ6VFb77f25krON2uVoqzN6dhJugNKQnpMIqCkwCG
         R1KE1tctuctH8//feipV3nTtgUwWmqQQbFLRUUiDHmqU/Sc9B5mKXwBzdClnrTx5GPq1
         D7y5Bme1fbsbb4jZcfl3m7cqq3jZlRjIhCQREBA6qsWAMEgHSB0Atnb80hAHXwRrgs4K
         nfYrlPS9srOEyeEliNqeVy+u2dqs0DVty0+vN0T8Joq6hOEv1CH4yjf/h95lL21IHgoQ
         S5bipDXIyg9QcjT+cm0dVyWOZZYOib4dglydVB7IHMUXkVHqxkUldV4tek/kdI7PA0hp
         yIRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739993614; x=1740598414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PSTRBDyjlCXG1A80Pr2C6LuOvywBhiJXPi7qtOpll3M=;
        b=Nwds90aLkf83qN4LBUY+wW4j09YIwFrXCpD3AO3nPik7RHuVDJ8yLCX27AHhZ344I5
         oIo4xpLam/mM7kLgAst3KzEXS/X3/HvlVCmEHAcVF34MiVxDXQlo2aocYsYygJcPDk/l
         tHjMfGuRXp7fm6pCxe5L59/foH1M1FthHztdixjbGrWPrZ6dCb+7lHk6DofrekoJOfnL
         d7S9XynDGNqoDmOAESF6eVrpqBwoYj8b4cDfiswwhBNAUlrv3rn5acbOUDPCRlvqcAno
         qTb/BiuqxLnXMe23bmrZFtTNJOjMru2YZTqewcLmvHd4Z3UiPGKxe1bIN72SEwgTfsxp
         gfEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVv+oj2CENSKD2vrhOqus9J/xsiWu2HWL36QlDnsVhfO+fDMvfav8F+rM9PJmHtxxsRPvYh5mAHT0SUy+TL@vger.kernel.org, AJvYcCWC69MEc7cRhiMEcIsykaXTVKvCZUUXg2M3jgDb6yyRRPlduf2amWOimglg6C6HjkYLPglWHDR94OPFu5Ws@vger.kernel.org, AJvYcCWFM3cdvgVLYi4Gcwajjb4o/LaSP3WelmdQ1GJTfwAoE39aydVuk3/44drfez2gzs7MsuenqmHeWY8YPqpvX+Lo@vger.kernel.org
X-Gm-Message-State: AOJu0Ywckl6Ez4rQjjt+nZ5XwJA+LACXLh/jfoCcQ6TMHg1tXYElJVuU
	/YcRTU652GXRE42m66+WlHo533eyxvW9X1blDAfHPVDAVyUxOuFF
X-Gm-Gg: ASbGncsvzitX8qhyIzDwzxdppPmvaTJssaLg6LYuWhwPaek8JbDkPbLbKa2Oh712/zn
	DuNfNnMx2eoeSgA476vxIweO616V5yKMCdJmiDqXlTh+0DVkh/LmYVS1VQHz3yC6anf50C8td1x
	xdL5+PYqJYpAa7JdkmDvFaaJDqN7ISviD3V+aU9WoSf0dHma3zH3f2r+VL/vrHzLeiskfQ563I7
	Pj/vf7jZPhcW//PFe2RhB67UpJ5RTEbuMLZYHg/lYetk0GeuDENKgdwsc4DjqO106vERnOvTG93
	z0nrLiqsH6TsD8c/8n6Sy+QJY+mcFs4/M5huvthOkHaYlVWDEa47qQ+T0OjlYb4IjBJgeGp1yg=
	=
X-Google-Smtp-Source: AGHT+IHTgtVoWn3jrKGALRPQNFfpnDcaIG9q9d3lBREc3fWPQIxYttYGlnxyXuJE2rxhVOnFy1zxbA==
X-Received: by 2002:a17:90b:2887:b0:2fa:1a23:c01d with SMTP id 98e67ed59e1d1-2fc40f26600mr26453316a91.21.1739993613788;
        Wed, 19 Feb 2025 11:33:33 -0800 (PST)
Received: from node0.suho-242436.threadtune-pg0.utah.cloudlab.us ([128.110.217.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf98b3305sm14193282a91.6.2025.02.19.11.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 11:33:33 -0800 (PST)
From: Sumya Hoque <sumyahoque2012@gmail.com>
To: skhan@linuxfoundation.org
Cc: Sumya Hoque <sumyahoque2012@gmail.com>,
	linux-kernel@vger.kernel.org,
	shuah@kernel.org,
	linux-fsdevel@vger.kernel.org,
	kees@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v2] selftests:sysctl:Fix minor typos in sysctl test
Date: Wed, 19 Feb 2025 19:33:01 +0000
Message-Id: <20250219193301.46563-1-sumyahoque2012@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <202502190912.CA03B56796@keescook>
References: <202502190912.CA03B56796@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Signed-off-by: Sumya Hoque <sumyahoque2012@gmail.com>
---
 tools/testing/selftests/sysctl/sysctl.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/sysctl/sysctl.sh b/tools/testing/selftests/sysctl/sysctl.sh
index 84472b436c07..323468653327 100755
--- a/tools/testing/selftests/sysctl/sysctl.sh
+++ b/tools/testing/selftests/sysctl/sysctl.sh
@@ -891,11 +891,11 @@ usage()
 	echo "    -l      List all test ID list"
 	echo " -h|--help  Help"
 	echo
-	echo "If an error every occurs execution will immediately terminate."
+	echo "If an error ever occurs execution will immediately terminate."
 	echo "If you are adding a new test try using -w <test-ID> first to"
 	echo "make sure the test passes a series of tests."
 	echo
-	echo Example uses:
+	echo Example usage:
 	echo
 	echo "$TEST_NAME.sh            -- executes all tests"
 	echo "$TEST_NAME.sh -t 0002    -- Executes test ID 0002 number of times is recomended"
-- 
2.34.1


