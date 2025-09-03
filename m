Return-Path: <linux-fsdevel+bounces-60136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A648B41A21
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 11:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9CBA5E452D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 09:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B312D2C15B0;
	Wed,  3 Sep 2025 09:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lLk/zpv2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE1723D7E0
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 09:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756892066; cv=none; b=HareyfNVFMzw8RdcKw9okNtZQmEvKU5sJ8fna0XpBraUTxrljyb/2CQDaj/E704RKUFC1HQgNM5YWCIzusicAHZXDIrPdVHpL9BLDelJeZRqQRmkFYeAZ+k7E4zZPsXqXmBSwBHT2yBS7rSNgkw5u0dXR95wlNShS5b6Gj5+X7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756892066; c=relaxed/simple;
	bh=50sQqvGWFB+AE9ZMhCtQmSeVgldluKZiJHqM6SF7gQA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tjKvcMcXeBcP8HbTtgAA3h5gu7G+283nFB9RQ/W0b2ApxD8Iiw8f0n4W0qygKTDsp3vv3xg3ibV1L5xrXQ9SyOJBV2+6Kl4xTCYIeayWFjhAcy+U4NIk/dsG79zA5LymIiRGVx02YzfcDh4MbOmQjcsuqrMehK/Wuoz/0OtTjQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lLk/zpv2; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7722f2f2aa4so5699368b3a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Sep 2025 02:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756892064; x=1757496864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0iEv0lhchMkXvwt2aBzuzLqWhAwcPWm828Slme94R64=;
        b=lLk/zpv2WEsMsY6GhBLSyjFk6LaBPwtKKx0jrJWAogVAzNJY1wBmKIO0fTNoeXAqE4
         tVhPKqqf+VlqIJOzZC+hKiy+4VD3hKoYaX+Shgvr5QHBS4ayQbocBu/pBhM3JWV40lep
         sHx6AFrLb1ciK1SXg/mQ0dA9EbbzCa2ANx5eEINg84c7CEyT0pC0DPikGwBDu7T9HvVX
         XcSvgxkzBhK7KI8ui58mE/1zCF6LuynCYV8yuGQlrBnbrF6DeU0mYUoz8Epw0hyir99J
         Uu6/42v3HR9Sh0VJdelcaItuTUFJkcikv2ZlCwhhrw0lEcmTDNm5Q6T7iHzIck4OrVG2
         Dr8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756892064; x=1757496864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0iEv0lhchMkXvwt2aBzuzLqWhAwcPWm828Slme94R64=;
        b=YH+GGBvrYqHmTa1NOIYeeJdpM7iNE2YPxF7TmhabDfPq2mBy9MDzaSt+H0W+uNRgcb
         s4M3wfNUXNIsmGYlJt3372YzY0fL56TRjYx47Ve3E3cBPai6ggdKX89QJHQ0M1hzdfLL
         0GfT3/ViFC4nC5sXLFufwhRdljjsTqhLytKza6P5wKcR3djs9KZxUTyZuaNvJeYU9Se4
         cu6+I51vnYQ/zXRMikf31SqfYAyiEfa5XFDlDmnKpJb4ja2UIduXVGf90P3zcaKXpCV/
         beN8tJF6odf0t9l6HZwB96wsgCV/Xwsi8prSDpVCIHHnU2wQCoZ5CIu8HDE0ZJC8Lfib
         RNPA==
X-Gm-Message-State: AOJu0Yy2QRF/K2WmY/dllhzmrk/pVqr/0iBxw79c6zZiZVSOX5Aggf0e
	K89XeEBYCZRlqgUgVwewQf56hPX3o6i8Gpc/m9CTE3uYAq2YBQuFNKQqh0uk0fdMzaM=
X-Gm-Gg: ASbGnctVoMVk8QumwDSgCoThxuwjavqXEvSv/uFsyV0fAhLUJDICrhr4e8o9TXqKf4x
	/+O91Jfl1Nw2tvlHi7O0nZhiYOsWD4VyW9QAqpr2UDqefdEl9z3Ck+L8D4Hq7IqFTZRBTlBuEzT
	WNR4Yczwsn2c3ZQJCT9oC4hKzGsTaNK99rmotVu/lMtOJNebNlzBj3YtKDBQBDN4htlyQiGssnZ
	c6mmR/JIPOK+IaGYh/wPzIXIB/yfxebDmdgzjBzxLZab+UkKaYKK4nP5gLhzYy2qrnf5xZsmxJg
	eAFGHsRzdhiONqU8LdX/fSYpRh5CdgfSF5SZHhiOJtiZ93Qhy+2z2DXt/Gowx5dLrhJm+/d7RmY
	q87kP9V17DlqfEC0ds8iNqZpRWzOkCI+b/Oigg8Fu5zxEbgoXCdkJ/VXkXmWJO41mDgHmk6+ydy
	bUzYlsArnoNw==
X-Google-Smtp-Source: AGHT+IEEVUX0wLwa9X8Jc/KbIJ0IaEt5bBSO8vdxxjqG1YeAQ8UXvAoQ0vuunV4K3BFPi57oILTcug==
X-Received: by 2002:aa7:88c2:0:b0:772:8694:1d5d with SMTP id d2e1a72fcca58-7728694487fmr586612b3a.29.1756892064045;
        Wed, 03 Sep 2025 02:34:24 -0700 (PDT)
Received: from H7GWF0W104.bytedance.net ([61.213.176.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a5014desm16171734b3a.92.2025.09.03.02.34.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 03 Sep 2025 02:34:23 -0700 (PDT)
From: Diangang Li <lidiangang@bytedance.com>
To: jack@suse.cz,
	amir73il@gmail.com,
	stephen.s.brennan@oracle.com,
	changfengnan@bytedance.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Diangang Li <lidiangang@bytedance.com>
Subject: [RFC 0/1] fsnotify: clear PARENT_WATCHED flags lazily for v5.4
Date: Wed,  3 Sep 2025 17:34:12 +0800
Message-ID: <20250903093413.3434-1-lidiangang@bytedance.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Amir, Jan, et al,

Commit `41f49be2e51a71` ("fsnotify: clear PARENT_WATCHED flags lazily")
has resolved the softlockup in `__fsnotify_parent` when there are millions
of negative dentries. The Linux kernel CVE team has assigned CVE-2024-47660
to this issue[1]. I noticed that the CVE patch was only backported to the
5.10 stable tree, and not to 5.4. Is there any specific reason or analysis
regarding the 5.4 branch? We have encountered this issue in our production
environments running kernel 5.4. After manually applying and deconflicting
this patch, the problem was resolved.

Any comments or suggestions regarding this backport would be appreciated.

Thanks,
Diangang

[1]: https://lore.kernel.org/all/2024100959-CVE-2024-47660-2d61@gregkh/

Amir Goldstein (1):
  fsnotify: clear PARENT_WATCHED flags lazily

 fs/notify/fsnotify.c             | 31 +++++++++++++++++++++----------
 fs/notify/fsnotify.h             |  2 +-
 fs/notify/mark.c                 | 32 +++++++++++++++++++++++++++++---
 include/linux/fsnotify_backend.h |  8 +++++---
 4 files changed, 56 insertions(+), 17 deletions(-)

-- 
2.39.5


