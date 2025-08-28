Return-Path: <linux-fsdevel+bounces-59522-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE413B3ABC0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 22:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2AB5566E34
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 20:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9882D0C91;
	Thu, 28 Aug 2025 20:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b="KiP5QtKz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B90288505
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 20:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756413451; cv=none; b=agT0gV3i8lJ1rYXphYBfTc8zrCo6ojWhL1huiQUxtS/u5SIn5W/WikwVy5OmLM+88BCQDM9rhanm2jag09JzzYo/vvA1yC//U3Yg82a+ZtSvwUozz7xQOq44XEV6myt3dRAuT/84+f+SmtJVpaumRC3fkN8bxiR+3G3eChPiFNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756413451; c=relaxed/simple;
	bh=eKyn8NXO5NCJnrd2nhmwYnVO8Mdw8+5kx8vCPpQpD2k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rKQn1pWw7sYp2Ytb6OQLLUjG5Hht/G90Zh0e0gVlO8Swvjy3D5MUpkvXGCn51iiMXp0If8zH62bruaiV2TSsLNtI7pW1Hfk+25estx7QAQMblk+L09XsJ5jtidNfBJV0bK6kxFzvD3Pp1A0Dw8GAyaQTbPtQnpkaSZnKd9hRxQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com; spf=pass smtp.mailfrom=zetier.com; dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b=KiP5QtKz; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetier.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7f0481658ceso147411085a.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 13:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zetier.com; s=gm; t=1756413448; x=1757018248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+mH1moQqYEsSGxE3+UVMXsVz3NSOmj4LqAu+NnOGgb0=;
        b=KiP5QtKzCWkDmk7dSjMCF/anWbUhHIjXx9ueuJNFrmy0kAa6T3iatRlpstFbJWvqCL
         FOdUvwh2my5kxFG1qxqDQdnt+pcwNPEkqlTX+HQUqjaPS4pA0eA5M7dOhC8LJRq0VUcH
         14aJ+kUfX2JQJlDAEmsTLwWiS6eezvnTC2jqqY867x+3rCXFkmbUaZ3g89wlKUYg6n7j
         yXylh0fK61erDuZQ/zCt52Gx49bQ2WA29MVSmkayyNfG/U15XfhoaxRGLt03XkLVx4rO
         O+RASLj5wmCNjwkAf4Q9u4XHMspIeFnFp3/25rgTaYBOSXafV07xv6ar0ER1Agti8hsf
         94yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756413448; x=1757018248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+mH1moQqYEsSGxE3+UVMXsVz3NSOmj4LqAu+NnOGgb0=;
        b=fgh/yFfrnzs0t9DfGArWrk+/DYthAN5rb2KI/2C7bqdDg7lOx/S1rlRzBWH3EcapQ0
         sINFSUp/fPjrTwxmCAuFeqFUNdB4DInlioUXQka9BcqD+gs9xYbhdvRedKNlfi1Z/Bfk
         oAi82srTaWEUzEt8FZ8OdNjkfBcasjOho5Uy4XnSnPMcMez08/ciyyn5waiVpTSTS8e5
         W6/pRAD+TYrg4f1SknGHrfrm5vctDtWU4PXnslqNXbS2u1RE8uD55l6fS0cCSE/YIz20
         pztr3SPf3qKW2CB/ib6R3bS1JZmQV4/3Bzm0XJgtSGDz8Di+UQTwA6PL78hdugn36Jsx
         V6Bw==
X-Forwarded-Encrypted: i=1; AJvYcCWgu8hGp8CokTQxTG0bajghmP8ye+14zyzqUeuWLviF4j5KIG2t+jef0E//ODAlzk1/DSNB6niWe09xShme@vger.kernel.org
X-Gm-Message-State: AOJu0Yys0MbmzAUT2hru9a/UDpy8l6v/O80i7OBHHN83eHnGBPLB+uS+
	ixueLI0ENVXBA+vdWmZk2pixsyOVvNSaflUyltjYBcgztRMq/K/3TeBiO6ToUnf2+oQ=
X-Gm-Gg: ASbGnct4t76dbBpQAL18hhqFRq+5ixe8yc8DLOyNs+82Wa0aYAcId8/3xGSxxlQxM8P
	gd0uhFlBXG0Cmc+Bd4FyNX+SNp1ANRq7WQtVJckrxfFP3zZjMm+6yKy9i70D7vC3Nutfmrmc9s/
	9B1scT3Fb773rVS5JI//Vr2aAz95CTuyKR0/ethaM7Smmfzl7IolS/MBrp2+UN/FN4w42UyG+Ed
	HZZlJmEX1Bcu1NDnA5O3Oh0x7OqVkZiholDTjqwjof+33iGZCl2A/5tWSP0oFeSEn6tOFBGW3Tu
	i4GMdNIRkBjEBQX/tNX3APHkGA0iOAUiYqoFi/vd7C+i2QVjFVKhv3SIOXdImfosfWiTSMAj9VP
	8LxMawEBO8arRi12hR7y39X91Hp6dPcpu8cL10W5pbeTeMF6J0OB4+/fbWoE=
X-Google-Smtp-Source: AGHT+IERVxha56qApbTM7KtcTfottUjnLoIFBt+FYBzEzeioMpqY/O4nfcNXgi1nY45nfmgmpUTZIw==
X-Received: by 2002:a05:620a:40cc:b0:7fb:423d:57ad with SMTP id af79cd13be357-7fb425bde6cmr282181785a.47.1756413447643;
        Thu, 28 Aug 2025 13:37:27 -0700 (PDT)
Received: from ethanf.zetier.com ([65.222.209.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7fc153de18asm45879585a.54.2025.08.28.13.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 13:37:27 -0700 (PDT)
From: Ethan Ferguson <ethan.ferguson@zetier.com>
To: almaz.alexandrovich@paragon-software.com
Cc: ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Ferguson <ethan.ferguson@zetier.com>
Subject: [PATCH 1/3] ntfs3: transition magic number to shared constant
Date: Thu, 28 Aug 2025 16:37:14 -0400
Message-Id: <20250828203716.468564-2-ethan.ferguson@zetier.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828203716.468564-1-ethan.ferguson@zetier.com>
References: <20250828203716.468564-1-ethan.ferguson@zetier.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the common FSLABEL_MAX constant instead of a hardcoded magic
constant of 256.

Signed-off-by: Ethan Ferguson <ethan.ferguson@zetier.com>

---
 fs/ntfs3/ntfs_fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 1296e6fcc779..630128716ea7 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -280,7 +280,7 @@ struct ntfs_sb_info {
 		__le16 flags; // Cached current VOLUME_INFO::flags, VOLUME_FLAG_DIRTY.
 		u8 major_ver;
 		u8 minor_ver;
-		char label[256];
+		char label[FSLABEL_MAX];
 		bool real_dirty; // Real fs state.
 	} volume;
 
-- 
2.34.1


