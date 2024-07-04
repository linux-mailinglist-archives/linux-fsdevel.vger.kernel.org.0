Return-Path: <linux-fsdevel+bounces-23129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F009277C1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 16:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF8921F274AB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 14:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC3A1AEFF9;
	Thu,  4 Jul 2024 14:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VxSYCyp+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E239F1AE850
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jul 2024 14:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720101927; cv=none; b=LCSYO8qv9iHfTw9VDSgNhPu1Rf25NQl9724h1onR52Wst0MbfOr+VlSAf4qya9s8IXTHMCJ+mQjmHHxXDptToUCaj2S9txpj0I6djlSZ+4gFoB7ix75oUT4GvNI+qJQ446NvrlUehG9Bb6UnfK+xSZNJ17xtRcVqbvvKkcSRK90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720101927; c=relaxed/simple;
	bh=nT+rTBnl+HSl4DwG+DFLS3z8vwGzIsSiEg7GOm/JOpw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gTFcb2kmJyCeoG5iDb3tFCGW05KR4muG5KkP63/A80//eA86A2CKIKHYyw+Syz/SVqZqR+yS+hILeJ7Nd0pnGJbkxSH9c8femvQAn6Y7UBO1+lOelE2H/JHPnlLrgbqkhqHX7XQEp1S8EaPE8qrhQvjHJyFTjmJQSi86QVH1/SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VxSYCyp+; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-645eb1025b5so12351767b3.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jul 2024 07:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720101925; x=1720706725; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nT+rTBnl+HSl4DwG+DFLS3z8vwGzIsSiEg7GOm/JOpw=;
        b=VxSYCyp+5aPScQeE8OnbJvYcUvekY/PO0Ss9nqYUklx8bs7+M77E3qAlwVuBc3RVUl
         BNyQjQ9+VdeZaBJPQsjvHvPs633hZw1cxdzXFtAaifXcHo+wRPh/oE3WYIM4foVY9HVH
         Am74hlPlASnY3sJ6O4I/lW0E5K3LJh9J2SB3qCclKI3bs8o3zCmgsQzMd8EDK7ZKNByG
         hqviJwUIzJ5mbzWDPazDBXUrilQ2jyDIHsBc44bmRSYEyYjpLKCRAThenVv3NKva0jLU
         yTGqQlFg87amBG+fOIHvCN07LJwfzKXTvxMK6ECYB3y+F6moWVrbvYj/2g0ZdsV9qsj6
         w01A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720101925; x=1720706725;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nT+rTBnl+HSl4DwG+DFLS3z8vwGzIsSiEg7GOm/JOpw=;
        b=J7arZo2PC0qJCFuBkxjh1ProNqhgAmpCEPBm++QaSrZ4T2hHmLOQ4EESebg8qXV52R
         syVRdqaHiGKYmWTMYsnxa6xcCgEbxQ2Jz/wJBHW/OPQbtAvGBkyXZeUkr4jhJH5p05FN
         quRjzauTYWAQJeDWQ93htqiDmsHrrWKxV5++OKsCKOc2WEjbvFUXxNW+hwEyS7tU/Zza
         TUhw43/YpLaZfGh/XaGU/AQr7tUbBkQ6zCkyEdc3allujURhmjpaKKwRWPQbu3GfhsLd
         tnj7RMdm7zOY5zgZbUuBM9budIE70xUdqM37FLmK6D7o50HEKr22QW3DIWQ+L0MUa4+W
         X6vg==
X-Forwarded-Encrypted: i=1; AJvYcCWApxx9NsAkg3fYzrAUpU7C/4WkmP+IF9QuiykdsYeJbrKg/+2sdRbEOAvaK0asvMFm0kXiVyjLBCgWFNSvjmOPL7txkWM3LTOKR59lpQ==
X-Gm-Message-State: AOJu0YwTQkpS3aQ/mg87HtnALm8oQJevHiaaUjoYdy+6HR6wDcMMzvGi
	3ZQ86zmF7xPFcA9gRK6PCPzGzRpFEQg7xC3v1uRwb7AGqwA3TtfyOHpCYcQCkoULnxFMy7soZfk
	eOCctHg==
X-Google-Smtp-Source: AGHT+IEUTx9gA7idJniZJ43DFyy9iaha2T2C5xdXkzxMT+Hu+WTsx0gWO2mYAGlalubEcYYltx3s+A5MabGu
X-Received: from dvyukov-desk.muc.corp.google.com ([2a00:79e0:9c:201:ef38:74e6:67b5:dcc0])
 (user=dvyukov job=sendgmr) by 2002:a05:6902:100b:b0:dff:396c:c457 with SMTP
 id 3f1490d57ef6-e03c195ece8mr3031276.3.1720101924876; Thu, 04 Jul 2024
 07:05:24 -0700 (PDT)
Date: Thu,  4 Jul 2024 16:05:20 +0200
In-Reply-To: <20230926102454.992535-2-twuufnxlz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230926102454.992535-2-twuufnxlz@gmail.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240704140520.1178714-1-dvyukov@google.com>
Subject: Re: [PATCH] fs/hfsplus: expand s_vhdr_buf size to avoid slab oob
From: Dmitry Vyukov <dvyukov@google.com>
To: twuufnxlz@gmail.com
Cc: akpm@linux-foundation.org, hughd@google.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzbot+4a2376bc62e59406c414@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hi Edward,

Was this patch lost? I don't see it merged anywhere.
This bug is still present in most kernels out there.



