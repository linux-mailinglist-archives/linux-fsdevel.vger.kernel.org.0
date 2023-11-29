Return-Path: <linux-fsdevel+bounces-4155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D43207FD0FA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 09:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07249B20C07
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 08:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD30125AF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 08:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nxgS31Td"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB6719AD
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Nov 2023 22:46:31 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-53fa455cd94so4236361a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Nov 2023 22:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701240390; x=1701845190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7gmMYycPJ9Nj6UjViaTSe3GuqILx7vRiV7qJZJ/dAg0=;
        b=nxgS31TdlVG2mATVXXGy6j5/duRGbIpbg8wN4HbxU7Ux08AW6Aqm9r7GQEIOKTws02
         zuoFX4nek942P2LAUSdzAUMpg6m9yYFDLXWTZVkRhMluHu74eCgILStLb2sr7iqnWPwh
         8vISzpX4D97PDE5tQg3sZJYntpDxdombCXOzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701240390; x=1701845190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7gmMYycPJ9Nj6UjViaTSe3GuqILx7vRiV7qJZJ/dAg0=;
        b=ICL6fCp5F14guBxQZM0cRS7V395jLlF4ZFaUpBfKqGGM+TMf9g4PxJABEs6c5R98S1
         pLboTwmfQQPjZCclYZ4WSaOzDLjGkT3ES5WGGDwG36yXRzy2o19Y0xzbeIUdwBhAaET8
         VuONTBAvesyi+pQyzsqzjFJwOJmXFONIWt6U8zyEHjQAv00TzFJwb4QG3MlXaQXT/w4T
         IDj3wWWJkpWL5SMu2kS+0/+DuU1lk3bhNhOOuiTcUd+qPCkm9heOMyZtqlqwG5kWLYt/
         TJ4hrOGJYgUuQOExYIguosp5sLOxWAe0bC0mVoMS0Hzz4S/dDl1A4oZeZl1StxrfafkW
         U+ZQ==
X-Gm-Message-State: AOJu0YwUgFKg6JQKVzBsPc/kKvYNPNIfFNYyrodpsGswV1QLIaIDwuSA
	3bAJOLAc9ucQvmu5wj3mHmsp
X-Google-Smtp-Source: AGHT+IFrY1MgVqCXKlkNL3KmfWt1yHVeibG1JZN+1YZj/UGDQgYSTEtIlqrrsG59FQCnczt5X7KhYQ==
X-Received: by 2002:a05:6a20:1593:b0:18c:c37:35dc with SMTP id h19-20020a056a20159300b0018c0c3735dcmr16117270pzj.16.1701240390556;
        Tue, 28 Nov 2023 22:46:30 -0800 (PST)
Received: from yuanyao.c.googlers.com.com (0.223.81.34.bc.googleusercontent.com. [34.81.223.0])
        by smtp.gmail.com with ESMTPSA id ju12-20020a170903428c00b001bbb8d5166bsm11463203plb.123.2023.11.28.22.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 22:46:30 -0800 (PST)
From: Yuan Yao <yuanyaogoog@chromium.org>
To: bernd.schubert@fastmail.fm,
	yuanyaogoog@chromium.org
Cc: linux-fsdevel@vger.kernel.org,
	miklos@szeredi.hu,
	dsingh@ddn.com,
	hbirthelmer@ddn.com,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	bschubert@ddn.com,
	keiichiw@chromium.org,
	takayas@chromium.org
Subject: [PATCH 0/1] Adapt atomic open to fuse no_open/no_open_dir
Date: Wed, 29 Nov 2023 06:46:06 +0000
Message-ID: <20231129064607.382933-1-yuanyaogoog@chromium.org>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
In-Reply-To: <CAOJyEHaoRF7uVdJs25EaeBMbezT0DHV-Qx_6Zu+Kbdxs84BpkA@mail.gmail.com>
References: <CAOJyEHaoRF7uVdJs25EaeBMbezT0DHV-Qx_6Zu+Kbdxs84BpkA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch implements my purpose from previous mail, adapting the atomic
open to work with no_open/no_open_dir features. I tested this patch by
creating and subsequently closing 10,000 empty files using virtio-fs.
The total execution time demonstrated a reduction of around 15%
comparing to the unpatched version. Hope this patch could be integrated 
to the v11 version.

Yuan Yao (1):
  fuse: Handle no_open/no_opendir in atomic_open

 fs/fuse/dir.c | 8 ++++++++
 1 file changed, 8 insertions(+)

-- 
2.43.0.rc1.413.gea7ed67945-goog


