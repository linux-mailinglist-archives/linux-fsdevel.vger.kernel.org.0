Return-Path: <linux-fsdevel+bounces-70627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CC1CA2974
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 08:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2842C3005C71
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 07:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4965C26B2D3;
	Thu,  4 Dec 2025 07:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIYU4Drp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67AA136351
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Dec 2025 07:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764831932; cv=none; b=TObLJNZwTY98t0Jo8Y2K1/JEbGw5H2oyCXiZKyrumKBxV8UBx+5QqmXobzZvGnMf5rU+gr5Sal8bOaYEKZhTE+OSO/PJ//7lflehhUsj7xoKi7pItjrF4D/gX7ttl3/IwD8LEXjF75yqMW77YTU2ucIQtgq0w7OuEfbV2Z2IDek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764831932; c=relaxed/simple;
	bh=fu9LIGU3B08cLYG+ac6xYeo0sy7rDicNFrIH0Yn7Rkw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=rIT1Ejx3LZmuvgzT56WqY8oFHxi8DqrJxTfDX93z11j6HpFZTiyBSDu/BsoZiW/bWKpaPaQz0an1HOriuKELmwOsGRynzqdfgNQDLEopcOwHJv10UW2+uHalCxu/66y7CeUNjmj9hx9jfwX7zul9tuKAWx8nNDi9c0SxcX7hJKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AIYU4Drp; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8b2d7c38352so189219785a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Dec 2025 23:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764831926; x=1765436726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fu9LIGU3B08cLYG+ac6xYeo0sy7rDicNFrIH0Yn7Rkw=;
        b=AIYU4DrpKs0w2lO93vgtUY0VSAtCJCMldtmSJGvALj1IfbcXoUlM9exuF9ry087nyf
         tg2pz68ztcQQgrh2urG7kvunHJXD/HTJz++7Txr2ajo9PeCsKsvHhM66rcYFErzQJDFT
         znZfW0SIuZiPOIGmrTSbXUbiRKsSc1kWPNETHaOx61ZsjygWKHxEbnTicOqCHv0QIA9i
         64ca34JJZWG8L/yGRkdPBIflMZYfjsYKVGRzPEiy81pXYrWarHMdzspzBS9KXKhEKdYp
         c55Kq8NBSatRZG23+BZzffeuyf7fKEpcegbG2qq7fep7oak2+iHwS7mUhs+7Bq5GjkBH
         guvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764831926; x=1765436726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fu9LIGU3B08cLYG+ac6xYeo0sy7rDicNFrIH0Yn7Rkw=;
        b=bv8s/aaMPRXbuv59yjlc9/pWIhIyNFeHhyEl2SXtkF5wePojojevCeUriKghBTfcl+
         dtThEsPFEDiDf+MhhIvlc6w9qApDrBZZupoLy4+9jpiQlLzN72O8B9qjjGTKhmKYL4RQ
         ituozXEE5mc4kKfe/tUYO9uqS965+T7+WlbyUFHCQC2ptMhRNGrCKcPD27vyud/VKEaJ
         Fg4FqyhqqWm+Pzwzbe2pqV3wTq2vp7MqrSlT8UyQwomHgifEARPU9r9/G6QA8Uws1ysR
         VVy7oN7M65sbCgzl/pqPVyLUNfb3K8Lb0rC7qvfIrnaN8KTFY3Lwc71dxyT0r1h10vgL
         Dzyw==
X-Forwarded-Encrypted: i=1; AJvYcCX34DMiDn7a3He/nKZdYcgOCQXdVbe9JmVlSi9LYjjjsGZHdM4EzbTa6UNAAJnBMN1Ytd9zvZ6/Z/cC0mGf@vger.kernel.org
X-Gm-Message-State: AOJu0YzSnIJzMkItMICYMKegKVuAEyla65UPEQvRPnh4DFKxdivH5N8y
	0wQBHSYPyXwMXOa3RTzn3RnbiP1tpy4Sd1VNnS5OM2c4NQw3xokrTwcEDZrRJNJsAU4aRq39Hy8
	TRnL9ZlAz7EYLVI2i1I9sr/KYkYfedxg=
X-Gm-Gg: ASbGncu69kvL2GOBMv2qsnrubJER2MPM5B4aQjB6z2QMjFBi2deyfQKtTQJ0sIoPM8W
	1m5jc9RvDgtOjGKvZ6jnwNBh/6tpYM5n+Nx62o/qFUWZXBYogHM7Vpq83vREHZgAxWm6fN9tj7B
	QHR9xybFV9gxn27QDnWbjMDa/SRuGzI+WZtXOQGIxk5YYKX4jGRDLFmEChPXPu+1WhyNtJguQqp
	DWA2uFFDjZTBd+eGOuBd/r5VRJN5pNVeihAdYeSM+9joWiYxItj1s7NkYA0YCGA2unVyU8lrw==
X-Google-Smtp-Source: AGHT+IFN9yCbbBcT2o5lccVyUHEr56YUyzEAVycYDoBY/C9fBgTzjKqlFTt5KCPmqkIZBRqB0rl9FsfG1JsNBjsMyeA=
X-Received: by 2002:a05:620a:2942:b0:8a2:bff5:40e3 with SMTP id
 af79cd13be357-8b6158c0350mr302674285a.38.1764831926001; Wed, 03 Dec 2025
 23:05:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: yao xiao <xiangyaof4free@gmail.com>
Date: Thu, 4 Dec 2025 15:05:14 +0800
X-Gm-Features: AWmQ_blMhwpT3N7Az2ej8zsPRR15quptQ1bKSDmbDWbz3LNHDAVeIlQgS7p5Wrc
Message-ID: <CACpam_YTgPkbgh_hHohOmRebJP-J+c8_GKFv6shChddTNk_iDQ@mail.gmail.com>
Subject: =?UTF-8?Q?=5BPATCH_v2=5D_f2fs=3A_add_overflow=2Funderflow_checks_to_up?=
	=?UTF-8?Q?date=5Fsit=5Fentry=E2=80=94_please_ignore?=
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

After re-examining the update_sit_entry() logic and its callers,
I realized that my assumption in the v2 patch was incorrect.

The value of del is strictly bounded in all valid call paths
(either =C2=B11 or -blocks_per_seg), and valid_blocks is already limited
by f2fs_usable_blks_in_seg().
Therefore the arithmetic cannot overflow before the existing
f2fs_bug_on() range check is executed.

As a result, the overflow/underflow checks introduced in my patch are
unnecessary.
Please ignore this patch.

Sorry for the noise, and thank you for your time.

Best regards,
Yao Xiao

