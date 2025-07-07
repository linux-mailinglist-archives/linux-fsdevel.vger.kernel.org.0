Return-Path: <linux-fsdevel+bounces-54146-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20863AFB9A0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 19:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B1BD3B004E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 17:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6608A2E7F37;
	Mon,  7 Jul 2025 17:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMvWNarp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AAB1DB34B
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Jul 2025 17:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751908032; cv=none; b=fxnXx4s/jSF/kn2o2E9QyqzgYZIy5fER48mej2KXL2OZJP8JxW+pY9ABlcFOTjvMn6VMrj+tilGWsnokDcw54QNmnizWUNaanEFuvKsTEl7Jry7OsLXmTG4p/UxRO9p4T2nfJZyIIMj6ExvlA/alRqU8cCXns9ou2WRhVjUI3kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751908032; c=relaxed/simple;
	bh=jCYoLzyDJbu5TvEmd4QNWRGSm2ZvOifjrifyfou7Om4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CRe6Ls5bEpDZONQO0Ju1haKnsEuNe+YHWaOpWtnFQR2xxtIRNvCu2j2xdhrL2ODRl1dLG0zXsd3R3RtxNXj7E+gzdESrQZ5oc9wBcDIGN5N3TI0HJTutcZXWndEFdgxRAz94+HdHro7t2eHQtfie9ovW9DIBmyzMVAT4H8YfZ6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SMvWNarp; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-60c4f796446so5041231a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Jul 2025 10:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751908029; x=1752512829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aP4e1Ey5I0oRyEbxEm5QvMWPHFDlRK3RqqzDnS66FyQ=;
        b=SMvWNarpKuVQyC3mIQW74DwA3q+bk48Wwb0sYdtFBGS088Qgh0mdJExCH/lYQjXN28
         /Q2/kkMYrInaRoajJLPxKHuBukeN0x7EderFgSHwfRqVZ10ZdTIEzQ7QdqF91OudjVQr
         FrYW1JPllEOB50lAMhxhqFD/nmOHNTlANWFrKf8HahY5K2fnsouRPwVvDADa22jWvDIx
         z0mv6/2e7N1eo1LuTWbC4z/IWsuoTPhDNkTSO/oq0II3bD8xlV+f/5CB79sw9n6JBHcG
         +37PRDm6psgjISo/2joC3clg78TpEHCsuSITxrQdEHFFSsek3jNtk4FSx26SV2x067E/
         BJjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751908029; x=1752512829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aP4e1Ey5I0oRyEbxEm5QvMWPHFDlRK3RqqzDnS66FyQ=;
        b=ZS7Bb9Z/rz7bZj9py4skUVwcQjunBhgsYMb7BjthCRS+H166XGcEmjB6a94XivcDJS
         hVJ8KjPnlZ9A1vhdLQgxWU43M5iNXmoO6YFri8m1dk6g+juwNF6Muw6HhA31tUhypPt1
         lhxX72QPB3cACYFE3X3/2/Xn+gMIAW6v4xgNNXB575mnSFSzRJFjZJoVvxf6GxscycQV
         CVq4bhIyVCw2KDRVNGBk+d7GZlBK3DzkDRS+utARtzc78UU24b6P9aUfpp5WYzJFHguh
         L1xKjlpJhAYzc/3QnUuBZfKX265dRfO7pOfaztKkaME5/38+SxTZBaIkIqfsFsqQaJPC
         VGQw==
X-Forwarded-Encrypted: i=1; AJvYcCXCqG0voQiCzZZ6AePpwUgFo8cznAQZfR2atuYFji/9ZnxulyogSe3kDvtSdiJ0vtuKTWMXG6ozrBBRL4F5@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmv3LZV3ERNnbEq7Mtw0BsHMSHE7Q0vRe4sL+VPTcXLsaZMVcz
	vFPZz6kvcwF35lH28YL5vrxqQUO3ruX8VSKixQ/PMDP/OV1A5YdbjTZt
X-Gm-Gg: ASbGncsa7uAqbr6qCCyuIOjOhC8f8pFeWK5m8yrdVX47M5HA1lbWRdV0Ml4UFgwI0j2
	AvvYpC2yTD81mt/OgPr1y5qt7uBV8Guw9Kq+Yfv2djZ5BTrnNjyRuaodnaDOaJIvH//jYZORWvr
	lmN5xo01RvXQpzXE5N8b+cOGx8XmOYfTuOciTZwcHR626cOBaObHVUBY9Vf2YCyuwLXSauT5FMO
	gxGElwL/JBWks8joLAFJAgpkwE2qtoxhGzLXaMz8vjD91tQWgaxFrV70ljHb/5hT+Z0qFowlGeT
	zhaA//eVpZKshCazE7AUwuoRtLVdeE7LuUmjWrK6Pg1MsPEa0/e8c43DsBqk9VgQHb4B4kyeupk
	uxoeyLmPR8lZqaFd7Fxaz9PPBUN0LxL8vu/u1iJ9If8MDG9XUPRHh
X-Google-Smtp-Source: AGHT+IFuUTQwM5hvExA53U1qYJAUBl43XX8BU6fAykbHnKHr2Tb0DnDGPKHwqhrpLVTu7sP75z49/g==
X-Received: by 2002:a05:6402:2354:b0:60c:52aa:d685 with SMTP id 4fb4d7f45d1cf-610474f3560mr391838a12.28.1751908029054;
        Mon, 07 Jul 2025 10:07:09 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60ff11c3e83sm4251234a12.66.2025.07.07.10.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 10:07:08 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/2] More fsnotify hook optimizations
Date: Mon,  7 Jul 2025 19:07:02 +0200
Message-ID: <20250707170704.303772-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jan,

Even since we did the FMODE_NONOTIFY optimization, it really bothered me
that we do not optimize out FAN_ACCESS_PERM, which I consider to be
unused baggage of the legacy API.

I finally figured out a way to get rid of this unneeded overhead of
all the read APIs.

Along the way, also added a trivial optimization for non-applicable
FAN_ACCESS_PERM on readdir and prepared the code towards adding
pre-dir-content events.

This passes the LTP tests, but please take a good look to see if I
missed anything.

Thanks,
Amir.

Amir Goldstein (2):
  fsnotify: merge file_set_fsnotify_mode_from_watchers() with open perm
    hook
  fsnotify: optimize FMODE_NONOTIFY_PERM for the common cases

 fs/file_table.c                  |  2 +-
 fs/notify/fsnotify.c             | 97 +++++++++++++++++++++-----------
 fs/open.c                        |  6 +-
 include/linux/fs.h               |  6 +-
 include/linux/fsnotify.h         | 35 ++----------
 include/linux/fsnotify_backend.h |  6 +-
 6 files changed, 80 insertions(+), 72 deletions(-)

-- 
2.43.0


