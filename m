Return-Path: <linux-fsdevel+bounces-68410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90434C5AC2A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 01:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 994FE3B9EE6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 00:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4485C215F42;
	Fri, 14 Nov 2025 00:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHkqcUcR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0833420F079
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 00:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763079905; cv=none; b=kn8/PYzEEC0xIY8hi2lqEM9zD/HDUXtCllivHP3admJkVUK//j/blITf+ffTcQDFevhJqe7n4qZYg6+JtNEwjJ6NEy3XAmiIvzQ1xEqhPUrKqOl2jbEy03xaduliFeMvS7hA7kBIjKsnRpRtaTNuKcY8lNMMe6KxtbE4OlTEiBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763079905; c=relaxed/simple;
	bh=vw+FKtjiOcF1jBdCTivAUHD3lvulejQ0pJB12Eyy5yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uzngQT3O7aKBYI6oyOkNfB+O3XCBSn4j2ZnX55Cj8/tQ+aEM4LCTVIoJV3oK5yUzm0uvrBKgS6AINLGfgVnxpeLUAK8l6FJJozW19hONbG0Il097h7xdZN8zlG3lyRq0Uaxr+CF2rno3+numIhNNlCxu6M5xfGaCg8eAp/eTSRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RHkqcUcR; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-477782a42a8so918765e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 16:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763079902; x=1763684702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KVG1YLgNpyjkbSIwgMI7KTE7qWYSZZq+m7h7F4aGjIA=;
        b=RHkqcUcRq9wjxSku2abC9k/hkZatT526IePrbGA5qiOSr1K4cGMpviiaFcqiKbZb36
         4NdBBnplYNUkFXKtWiAA+H6tY+cFELAMU4rfO7TZmxmuP2VgqJ9tVdTQBA1K42gkxjeD
         jtnTdiSlNx32KW5+a62WEBHvCsiNgeL/3RG4ZcLC7o13f3Gcd/jtqXKro+veqnjzW4AD
         MjxelCMLTDjekvyUWc83+pKE9SvPCa4AwXNNwiCKh/TjyV32zZg3yk2fTCZ5anYx9JC8
         HzZhAiK+Ay0W04rYGPetxDEKGtIEqJ2UQ4r39hAz8sLmfaauuk0isGSED6WSmONthUOu
         b6ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763079902; x=1763684702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KVG1YLgNpyjkbSIwgMI7KTE7qWYSZZq+m7h7F4aGjIA=;
        b=lejDkryEIMYRMrDShK+HEDkD7RgcADiZSimRCYfFSmX8JcRJW7hCHfqwxstOi4U0EU
         yr8BtoN6pWOKjTd99rFWLpbzx1Z9zJWLkZc9LhxxBoNOlF91SSveiP27v31hI4rz2QMF
         GsaL31xLMLkXxcDux+LwblW7me9NT95IHlDYZmHfBZLJ3nLiWN0lkoL/NtI/Fq682JtT
         mhKCzd1Xr+PU/hipyy5pDu82c5rLM4LxAn7TnrCPXUFkmffaXMJYuo4noyhcAelvnsYV
         T01265kmVhmCsLozQ9imSCsycW7k0vvOkTcYPYup299P5XX5e2Whi4BQ7RyA/deEkzqY
         FAcw==
X-Forwarded-Encrypted: i=1; AJvYcCXEQIEpllEPjWhKJz7cZvhhxKOkX7mK1IRXd6sX3IefXOHRX+kytABkig7n1EzhdKPEQSqYHgCrDizdwk/0@vger.kernel.org
X-Gm-Message-State: AOJu0YxFPx+5qYrj2Sd7ZG4PAFSJ6CBU1QheHtFmYSXKHXbq5wpdusVO
	dDS7/5QBjzS3+v4FbJI1/EX9PsLkyvxar7MAyoS/FG2HbxThP5FpcSo6
X-Gm-Gg: ASbGncvV70dbeprIDmmDGkHjcc+oH+OsYKTNr4GDEF1i9FwR/Hr7MnFESv/1+ijmrKR
	gpZ9eoYJ5gvzXLCJ50zSomzKUGgArbgpx4GyjRB6/UflcN5gT/I+S6UpcDqIdQIu4OS3dvcnbSx
	9EMeqLGbkt+2fjX3ZQo83BYYWi/qJzhUtYaDFGNwXbKd3i4pEgiC4qIjDlKe1nxgTTPzOHC4hv1
	Q2Cc0fyTC0I/0mezyhS4jnckdXTyGv0Q6ZFuIoPaGfN2JPG2zzGCKuds7UT5qkMYtWPzERCOXFK
	dBHvt15LW7JOnkSFRXgSdLx7lODoGNji08M6zb0OZHqpLuSLsCbLDY+zjI69exfpXH8+BtmwtL+
	nvKyUtEpRPFsZW0in86JY9jtUUXPdY+W6npBaxdPququzrhGkeX38GWKlHCU3Wi0T22hdwAReiu
	yJ97ImSg==
X-Google-Smtp-Source: AGHT+IG/Jtn43SJqyq/xeqztGox4OpLgLm08jPz7Zkh1bOHmy/r7tVpM2W+J+VaRSxBS86ve6JGvVg==
X-Received: by 2002:a05:600c:1910:b0:475:decc:2a0b with SMTP id 5b1f17b1804b1-4779028ca82mr3838155e9.3.1763079902209;
        Thu, 13 Nov 2025 16:25:02 -0800 (PST)
Received: from bhk ([196.239.132.233])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778c856c95sm60698225e9.7.2025.11.13.16.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 16:25:01 -0800 (PST)
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
To: syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com
Cc: frank.li@vivo.com,
	glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	slava@dubeyko.com,
	syzkaller-bugs@googlegroups.com,
	Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Subject: 
Date: Fri, 14 Nov 2025 02:24:40 +0100
Message-ID: <20251114012440.531779-1-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <69155e34.050a0220.3565dc.0019.GAE@google.com>
References: <69155e34.050a0220.3565dc.0019.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/fs/super.c b/fs/super.c
index 5bab94fb7e03..a9112b17b79f 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -484,6 +484,7 @@ void deactivate_locked_super(struct super_block *s)
 
 		put_filesystem(fs);
 		put_super(s);
+		kfree(s->s_fs_info);
 	} else {
 		super_unlock_excl(s);
 	}
-- 
2.51.2


