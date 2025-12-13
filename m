Return-Path: <linux-fsdevel+bounces-71244-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A98CCBA6E0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Dec 2025 08:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB32C300A295
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Dec 2025 07:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74133FCC;
	Sat, 13 Dec 2025 07:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyRuyN0n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6EC126BF1
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Dec 2025 07:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765612373; cv=none; b=jFKpkL9BWRLdFDNdNeJQQcTiNctrGznh7FsB3hjUFqiyWJuih6and5+faBm8vwC/Zvyq2+8vvMdISLcRDMHRk42/HkghzfBADkuLIx7qHjtrYF7pc+dTzi+I9EZgk6v/YZfyPdwnsYAWcVedk2IpEQ58OcCKWpFtUZi+59AovgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765612373; c=relaxed/simple;
	bh=blQ0dFBxPxBJ0xPaI1fuKF80stJgtlWWkahEZdpvlgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Onjrt9vQg8KgnPJpIe3tdjeKNRjhLvkWKqLaOH5DyVxWEADYQ99DLlaef7d14Z5uC/sfQUIz0WyK+s6UsizQ6aIbfDNnwdBrmgCnlOBNyBcIZhoqOoSMxrAcNgaCDZDPV321p3KEnXAusdbIfDy09eiUlz76zzwDRI5a6s2/uM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QyRuyN0n; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5957db5bdedso2447404e87.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Dec 2025 23:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765612370; x=1766217170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RX1eqZdD+QdTK0VLe9sMoHAFi5N2Je1usLLZsuCNaCI=;
        b=QyRuyN0n41j8ypeLKiZk1+0f8UzNsxs/lISeIpX1PwVoNPo7GC5y3QWArrbhB1kSTp
         IUmCMD4gaLMfZ04Wh+B5jh43iLVLYllF6yHOpSMsJiu0hmpzf5XTyDj3TsogPFpZkYRK
         ciL/LDxHtNfcGRl4zK+/pq8S49mxtPKBnbCdjWXfBaQRTDLmzTko76zfWiR06oRU9Dgr
         Fq2MMk/h+gU3F0UCS7vCSgjOnS+2KqQ3ukfX8VpK4RSWCcL9rCgqhZeek8lcRMluAOw3
         CAzATwKHsgyJILly6OI9iwNI81GLPxt9MBacFPcE3XrGUreVEghxbx7NNDXkpQ1qJ7pZ
         NxyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765612370; x=1766217170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RX1eqZdD+QdTK0VLe9sMoHAFi5N2Je1usLLZsuCNaCI=;
        b=J5HLahAzHRwjV5s2kK60OKBSIKsn5GS5UB29bHoQTdJ1zmjy5KLhcnO4AJDDgV/O3G
         Flkvv/Sje6CnzijxCEXG1bSWjJ0c+P0lETzq4J1Ha8Oqs1frKSbVN7wJVpsENUG4Ty3Q
         YVDbSDwAoCJ6zzqzDlc7k36UNZdj/aQ3iOpEdlAAyHl7xUZQgddCGeQCR2xokBMDeo8Z
         agtCxwKK+sbtcAhWv+iU5sDqQDYhqS0+55MkOxMs+H2Q6O+KKBLDBifgt4I4Iq8QaQr5
         i3SHOYfq+hxRKoY1hFQd4gQgLqg4Ax/4CZ+wZuCczwMklF+6SzOWQDdDPM0EHG185P2h
         tZow==
X-Forwarded-Encrypted: i=1; AJvYcCWjFz8hB3LCVixlFmvNs9FLFUPL0YEDQNv5hnwl6rFH9MnZVBhlbMAiwk2A6LsPVO0tTQSDY6Ds53RtE1PA@vger.kernel.org
X-Gm-Message-State: AOJu0YxjfA//DXV9M+ZaR9NEiTHrGQjqfgG30tkSTLmILvZfwfxnB4UD
	q30fIMxOKDdZTaxHqgsP2ECtKUoMrXYiz06TCfdKYEC7+RCjeo1z4Ej+
X-Gm-Gg: AY/fxX7TexOdfHPgAPqh273Lp8/rTK68RpXO0wiuDGpl+Wg5C0A+zXdtTgV3Cp2UDSm
	Y2OUS87ycw/bAPuKjDEaSZwHwoFb/As2VtqTmfEdd9HilBNFVEdzyY4ejv67296170DCBQW2dLl
	YD/uIzCKlzZhohiWBZHvlAyZWJSnF2ThhgLf/IdkLmFKx80qp1oUDg7OOAQ9vQKrngQU95aDgum
	emIWAPKRPrXSrlX81m8lieAmnm8SYQZ3yUHSJ2ZHvPAivlErt8R8QU54f0HuVXejah7hk/tqxJJ
	xY5zRrz5roHLaiNGkrq7PE/7L18Lm4sTpc6ECkZYewitZFc2M78D05orKpJe2Ma0DWTkwBlZLmY
	3v10kG9li9jN60MoEiFo7OMwGYYNIaUo04flvPJTO8fJ1F6NjibycsovMIPBaDd2wDnN4ZwLDPI
	KtOJ3IKWxk
X-Google-Smtp-Source: AGHT+IGLUTBvJyYmnDp7a3kK5YSVbxFWtC2bfhu9Ek7QMpiXrPdlK9l+BGA8MOzZApXTp+I0lS0nMA==
X-Received: by 2002:a05:6512:1154:b0:598:8f92:c33f with SMTP id 2adb3069b0e04-598faa81508mr1747835e87.51.1765612369308;
        Fri, 12 Dec 2025 23:52:49 -0800 (PST)
Received: from localhost ([194.190.17.114])
        by smtp.gmail.com with UTF8SMTPSA id 38308e7fff4ca-37fdebe5e71sm4485881fa.1.2025.12.12.23.52.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Dec 2025 23:52:48 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: joannelkoong@gmail.com
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	bschubert@ddn.com,
	csander@purestorage.com,
	io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	miklos@szeredi.hu,
	xiaobing.li@samsung.com
Subject: Re: [PATCH v1 30/30] docs: fuse: add io-uring bufring and zero-copy documentation
Date: Sat, 13 Dec 2025 10:52:46 +0300
Message-ID: <20251213075246.164290-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251203003526.2889477-31-joannelkoong@gmail.com>
References: <20251203003526.2889477-31-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Joanne Koong <joannelkoong@gmail.com>:
> +  virtual addresses for evey server-kernel interaction

I think you meant "every"

-- 
Askar Safin

