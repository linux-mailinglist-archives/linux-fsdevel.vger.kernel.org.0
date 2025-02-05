Return-Path: <linux-fsdevel+bounces-40955-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67033A29932
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 19:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5543C1881C41
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 18:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5AD1FDA9B;
	Wed,  5 Feb 2025 18:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oxwm6QIP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E12C13D897;
	Wed,  5 Feb 2025 18:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738780732; cv=none; b=NJawbfrExir9YmErhzcPQj4c3bW4PJIZm9pVhUhsrLXpoybJRE89KMgtv2j4G7msjp81NDGtOAkMYFBDkzKzQSUgdR3kmPBg+RPjgZXb2NqHDmVXWlpT29PG794gpM1dAjFO9YPl+rxWWUxcn/a04tnpY49HsqWTzGiNKu+im7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738780732; c=relaxed/simple;
	bh=f9ROLG2QKQLWXnU3odIaidQW0pGPTI8WIjXMz1M6K4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fk3warg2XB0LwiJqS4gjXNDeBZzYQJseveol3ZwU1TFIwsRiCbySGAzptcH6MCV0QpDlHoTvNxBer1HYzDnKgacEvxEwXISsxJAFaOh341zUbNqn0Xxi9PAYC+9vMTtlMlKFH4JXHCONz4x8lFdYhoEG5vlZH5WGKxpDSj20P6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oxwm6QIP; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5dca4521b95so300014a12.0;
        Wed, 05 Feb 2025 10:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738780729; x=1739385529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oe4Hgq2X7UqOIQhDFX0I2MZs9E9kRDdtScl1pJ0G+fY=;
        b=Oxwm6QIPbX8bO/wFTBj4K5N0oMd5vWKiibEBhhVeb5X6vtiqO+aeCdk7+pMXu10eKO
         j3tG/BiKwQVQ8XcBJYDsqLbagfJlrgeMr9y+nXyM9gn3vuPYQyN6g/rAuddBS1BgLUKU
         4KY8fP+c1yiUUMTs8CVZ9KHPjdKJTj7TX2yZu1QjkjG8PrKD/QnThbY3cgr3Bn9eqNSi
         hgYYs6tkkJ2r6gBsorc8JiY5zlBNOC7vac2zLIIsQYIXv9kCjUJz3/zCjLpwxLmT6tyj
         Sfh2LAkk+9eMQkpu2OnTkzPGZvQb6UjQiiQcQY71irtLvwD06EjCiU29xPrwpLq5sX1z
         zdBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738780729; x=1739385529;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oe4Hgq2X7UqOIQhDFX0I2MZs9E9kRDdtScl1pJ0G+fY=;
        b=v2ErtYWym8LBYiKTPzo+pmwkPl5CM2d/9A796mjSliDQcbjTHUubqxDsRlxJMC28PO
         m4g6GHqOyDsI6SVKF5ITiPE1X0dKO3CruYRveI/JYDdb3RfwTVbkrxenzDu7nFvIek9U
         a3rtoFrhuMQ1ZeyxKv3bRN91XeFbs9EChf/+ObnhIQhGplB2xEpCbIVjinaB+US0Azfi
         0q7F3S/ry+FHyx9otpt8CV9LiSe6j2Rx2sJKBSA460GwxIfnvylOizXQtImOGtpB5e0J
         I3uTLScftOm6K9D7z1wjHUzb2pkEY4tOsb+ONQJE9zFVh6/GfCBeunAQcsEU4TXBFoNh
         xZqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWG4gvU33pLz1xjV7E88OFEQqVkVRdZ5gQZatShSXps3X+Nwx69BgRNJrz4/ZacfaLYprWGd6+MdG5nqCc@vger.kernel.org, AJvYcCV3Q6OdL/ThoQh8hc9rXyUJ0s4d3LXzpJhKHNJeJaIxHaqx+DHgLcZmvkrhNXenDhBe+T37Ll+ym5QBfzeZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyZHLoi30iIFIozagnDU94K5Yz7tuX00NDAfXGQkQ47cOm/ChFn
	qKYDKn7RJpiUElWgVadxSG9JkSU70pC4bt3P0yngZYADEDgFBwBk
X-Gm-Gg: ASbGncvETnTcYR0LuMaNnYyDw3WESP1EbvzyomdqXFaXcp8Ts9529qOhJsR/0yUyYgn
	DlwPlgtFnEJHIj3Do4CPjPUptFixbaQcviOFjiOHe+qyivzrt5GjwaT1ySoiin90z+3/PyURxXn
	Mq7azRfm3l9glxcp0vn85am3LNDYcUcgxGAQqW7iLm5LyHTMY15jw9e4htWSwfWtlbtTertRb+L
	YvUh9JvoUHihl/G5X9kDy2erR01S2Jf5EjyGiMk8fXa3AB5xZ0+gwrIfvV6bX5BmEN4P5t1fw5V
	MjpViryYZOeYhkaWoR2l+/vpl9kNrWc=
X-Google-Smtp-Source: AGHT+IGYj6dkAR+H2mnM0TozijLBZkqyxCQtgDvAH7Nxt3SJFbrO5ZDdRDpm/uEyvGmvMJ/RTjxtvg==
X-Received: by 2002:a17:907:3ea3:b0:aa6:84c3:70e2 with SMTP id a640c23a62f3a-ab75e23d8f0mr394454966b.20.1738780729061;
        Wed, 05 Feb 2025 10:38:49 -0800 (PST)
Received: from f.. (cst-prg-95-94.cust.vodafone.cz. [46.135.95.94])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e47d0fa3sm1134082266b.47.2025.02.05.10.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 10:38:47 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 0/3] CONFIG_VFS_DEBUG at last
Date: Wed,  5 Feb 2025 19:38:36 +0100
Message-ID: <20250205183839.395081-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds a super basic version just to get the mechanism going and
adds sample usage.

The macro set is incomplete (e.g., lack of locking macros) and
dump_inode routine fails to dump any state yet, to be implemented(tm).

I think despite the primitive state this is complete enough to start
sprinkling warns as necessary.

Mateusz Guzik (3):
  vfs: add initial support for CONFIG_VFS_DEBUG
  vfs: catch invalid modes in may_open
  vfs: use the new debug macros in inode_set_cached_link()

 fs/namei.c               |  2 ++
 include/linux/fs.h       | 16 +++----------
 include/linux/vfsdebug.h | 50 ++++++++++++++++++++++++++++++++++++++++
 lib/Kconfig.debug        |  9 ++++++++
 4 files changed, 64 insertions(+), 13 deletions(-)
 create mode 100644 include/linux/vfsdebug.h

-- 
2.43.0


