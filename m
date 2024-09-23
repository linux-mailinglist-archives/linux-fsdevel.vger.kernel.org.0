Return-Path: <linux-fsdevel+bounces-29881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6562397EFC2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 19:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E19F81F22109
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 17:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D115919F12E;
	Mon, 23 Sep 2024 17:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8IKNZCG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D695A19E969
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2024 17:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727111615; cv=none; b=qLP5vmzxWE19KT8a1zhZuwMG3IhQMhz+zZbNZynobofyGZ1irJgsN7xIhOUidG3xHFivb4rvvOXa8E4si05m1dQiMGnB8TzCmggQiGItAS/AExefxP9nRaEvABfLoK9fHD3n0Edj9qTC5OmOUOWzpOQCD77oJPUzQsbnMHJxbf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727111615; c=relaxed/simple;
	bh=B8DnwQ6H1iSqQLoFKsqfQL+MK5rp+L7lVCz8JBUg/cs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IqsvDeLLbU44Co8zbtRwCVU/Pp+AsB+Z1a9aeCwEHFn0vVJI9EfiYhc3gXogT/sKpyLPHo8ibrtLQlpz+DoxBAb+0wBP+ODN56LRpzk3YmxCYs/qwmmJUlsInQeha+mr3Lh6dw456bD5Ukcme42fiZLWHolbWZ59wXA0Ewc7vE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8IKNZCG; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6ddcd0b4c59so40462187b3.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2024 10:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727111613; x=1727716413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/U3JamllshLtNgIs5ThgvHSRiGaGHqXTGysWlx1mHI=;
        b=L8IKNZCGMQ6WCpitQi82KUf5h8Tni10tgOo1gbDo1OtU03+7huJTmux5oCbXvFAI9a
         P3rHDiseq9b1P0PT4Q9xij5EW7q01HfyJkPqpSThhOjXPcXB4vlE+Fg5UMYElQFDj8zI
         3uuRL0+qErkOZPG43f7iEIVpqXLVlrh3WPTNe1GrRe0O78mF6G9RPQZMh5dsRZepZNiE
         4nzQOkvkuOizuRfavNOyVkoc4MIEqtYPp+uea6IhMF2Xq8IdASH4t5oeIe3uojbmzBjS
         QQsOA9mlN0OfDgssTxbgX2UJx6qdHUPFHI2Zkf43dn+H2GzL2IF0k4RAA6HcFwafts8E
         qS5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727111613; x=1727716413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y/U3JamllshLtNgIs5ThgvHSRiGaGHqXTGysWlx1mHI=;
        b=fiCkfqdU+pfjzq9dSEU0XvoNKa9UrX1GQW8Q0OqsxzVStpea09QzuQxErbTTvkoWHS
         J+53pzhIkcppQvTsDI/L6/fzNdZRBj2DlZlNrETF/gNqeSf4pQs8OA4btNEjuoPdji18
         oV2Mh41oFD5BKnukEM7FecyajAwhrRm9mXwafU37R1BOjp7Kjl2LvFJXy6CVnSfDMnLY
         6vgfiIIoedwUI8ZnyPu+gMqt9dV3jVHpmJwf/zkkdI4ETDN8OLDFfc+qEjtA5xxZ5r8B
         7L0YyQ8MWza7GdE5f8n9MrDybnD7CdJIbCtfIcT7PkHuZSPjj7j+j6x67fPpZ90Pv+yW
         0KSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnHCTeUWfl24hyKD4N+3v7O9h470ZSDxgGZPksD0iYhGIFmVbB9Rf1YR3Jwa8WLUVmrz+qO3GCyEXmooSW@vger.kernel.org
X-Gm-Message-State: AOJu0YwvFP1SIlp0pn/SPbmEi5qJ8pU7EDDvLkLz1oarFE0WF8NX+TLT
	qSXliXFidP+uGl84qgrw14FKB7fkIeM7pbUWT9TLUL+025wU33S+
X-Google-Smtp-Source: AGHT+IFaMZLTJmZ5vcUxZwfYE/sqVJPsSGsuaOqHcqtvEMmjiSP0v+owKseWTS/j165kLqxRsZQteg==
X-Received: by 2002:a05:690c:4610:b0:6dd:d85a:15e3 with SMTP id 00721157ae682-6dfef001cd8mr80700037b3.37.1727111612738;
        Mon, 23 Sep 2024 10:13:32 -0700 (PDT)
Received: from localhost (fwdproxy-nha-114.fbsv.net. [2a03:2880:25ff:72::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ddb7c96b50sm33316987b3.122.2024.09.23.10.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 10:13:32 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	sweettea-kernel@dorminy.me,
	jefflexu@linux.alibaba.com,
	kernel-team@meta.com
Subject: [PATCH v3 0/1]  fuse: dynamically configure max pages limit through sysctl
Date: Mon, 23 Sep 2024 10:13:10 -0700
Message-ID: <20240923171311.1561917-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The motivation behind this patch is to increase the max buffer size allowed
for a write request. Currently, this is gated by FUSE_MAX_MAX_PAGES which is
statically set to 256 pages. As such, this limits the buffer size on a write
request to 1 MiB on a 4k-page system. Perf improvements have been seen [1] with
larger write buffer size limits.

This patch adds a sysctl for allowing system administrators to dynamically
configure the max number of pages that can be used for servicing requests in
FUSE. The default value is the original limit (256 pages).

[1] https://lore.kernel.org/linux-fsdevel/20240124070512.52207-1-jefflexu@linux.alibaba.com/T/#u

v2 -> v3:
* Gate sysctl.o behind CONFIG_SYSCTL in Makefile (kernel test robot)
* Reword commit message

v2:
https://lore.kernel.org/linux-fsdevel/20240702014627.4068146-1-joannelkoong@gmail.com/
https://lore.kernel.org/linux-fsdevel/20240905174541.392785-1-joannelkoong@gmail.com/
v1 -> v2:
* Rename fuse_max_max_pages to fuse_max_pages_limit internally
* Rename /proc/sys/fs/fuse/fuse_max_max_pages to
  /proc/sys/fs/fuse/max_pages_limit
* Restrict fuse max_pages_limit sysctl values to between 1 and 65535
  (inclusive)

v1: https://lore.kernel.org/linux-fsdevel/20240628001355.243805-1-joannelkoong@gmail.com/

Joanne Koong (1):
  fuse: Enable dynamic configuration of fuse max pages limit
    (FUSE_MAX_MAX_PAGES)

 Documentation/admin-guide/sysctl/fs.rst | 10 +++++++
 fs/fuse/Makefile                        |  1 +
 fs/fuse/fuse_i.h                        | 14 +++++++--
 fs/fuse/inode.c                         | 11 ++++++-
 fs/fuse/ioctl.c                         |  4 ++-
 fs/fuse/sysctl.c                        | 40 +++++++++++++++++++++++++
 6 files changed, 75 insertions(+), 5 deletions(-)
 create mode 100644 fs/fuse/sysctl.c

-- 
2.43.5


