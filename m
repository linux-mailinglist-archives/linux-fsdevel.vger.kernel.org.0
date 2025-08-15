Return-Path: <linux-fsdevel+bounces-58043-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D98FB284BA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 19:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A1187AF150
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 17:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCE9304BC9;
	Fri, 15 Aug 2025 17:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b="LSXvTUJi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C380D304BA0
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Aug 2025 17:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755277869; cv=none; b=EZQ0ejyTxLCJraV8uqYIAUt3Pcy/3Ti2+HL0nx89myrvYzCSOblp+lSw7oOU7B+IE58P2y49/LjPrGS6A41ClcPPrdbG1igPDJC8CDndrDPiohy7PXYd9WeFkv6S2tqnuWo1HVfHGkcBAX4mWAdfsFiMyTuRahbmRIxyiXkU+xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755277869; c=relaxed/simple;
	bh=4HZvWAZF07QdILcKFutV17g/5NFytQp/MNr45fSPPwY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sl9Os63frEfUwGKQ+hTN6lwrYKRPWfCdbRjbfK7Oc4iPinxzI2Phqq17saI1iO/GT16K0hvCdT+oncN52AN91WoZxCxiai9DLsEA9XB3DBaVJDjk4dSRHL2fFS8F8BoXVQiy66mFCGDC9RdXlcrHjUrxN2SYw/3Q1waRo3BfQrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com; spf=pass smtp.mailfrom=zetier.com; dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b=LSXvTUJi; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetier.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7e8704b7a3dso248342285a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Aug 2025 10:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zetier.com; s=gm; t=1755277866; x=1755882666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T2O89Zv9S18NKrgTrkfOWonDcQRK/xVnFV6RgQGjH5w=;
        b=LSXvTUJih8oI/e/FUv12Ro4gfFCL/ie11mAEY/P37H0fVuqO/djQehS+GAGOUquPPt
         DULqPILJIpa+zZ3iYev9aUD8jSVijJxtmXufo64pTjzjFiFAXhdk5I3fu3xy5KYMN8NS
         1H1eovrWabB7OCvzsCcWBNF8pMpxpzQOuCtguu3cwLAPFYuw0dEmta3o5i7QujEnSMT3
         FVZU9tZKEINe+F3Oan/6xRW6YBUWlFy60ntB4dl2nnXoFLAA1AWG94GJBerUG0XyHGch
         aTfPwn5HJsvBhlCPnHGHI/faYgr3SQbMjaMx0zXclg/4K3Fn6Ccx3fWXdafGXHS2Ug3q
         TBCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755277866; x=1755882666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T2O89Zv9S18NKrgTrkfOWonDcQRK/xVnFV6RgQGjH5w=;
        b=svCGNQhhUcY3tRQlXjPIN1ZP2+fxAl1TLAH6EKBrHiuIxe+Fk0FOzKXZlEPp2lLuYo
         YDkzyEoCZ1sfOwmhD0L0T6Lge1RglFYFJ913PaOWGnF7lD/29bl/g8/b7d6ey8pe6VT4
         8eWIugBYFbsm7MN0/WQWwuDfPT17MXQuVrG/OXTrKKI549l3EU3jePH2VnLEH99oJUyb
         XFBVNoprCsOs8A4D1ivJbK3CGDprirSriogdShe2tt7wimgirUN1vn60IYEYzR7KryQu
         OZ4P5Rb7foTCf/9/Vpr0VXtrLgYooHiCGbQAJZE3hURWyik8yR1yaP+yyMSdRPlXPA7n
         6gdg==
X-Forwarded-Encrypted: i=1; AJvYcCWYnMlBaE2ryKZ2Tkq4CewfLxnMyYmRGyLPXLBj7VSx6ISh6qw1+rcxAAnmTX4crYFxUEZf6keXehykYs6x@vger.kernel.org
X-Gm-Message-State: AOJu0YwLD8Q0Vk8BIMzD5ojY2uZYhqI9eBtXGIG02ATiHg2V1iXHuymm
	qQx6z5R6aDXuQA4S+YJ59OmOW7YKdoDnLIc120NSykiMAzeHVbbB9qrMDSnUNG4mMFA=
X-Gm-Gg: ASbGncv1CaSsQtiTFvFkfp3vgN5u3NBn4rkN45j1Nfmc6XGByZYHUwdFdFmpS7Wb66Z
	bE4dVN0f6jy5TVT8grqTNl3ae0VQ6grg6aLOwCUlcSbaf+IDVyw3WaOzlDkVggmwOcmdpBERl/h
	hae2ZbG3KPiVTkEULu1lcPbsngD1U95FPecWx1aotZcfTKHVq8t544WMIKd5G2R88M+7j14dg+6
	WAGQShQqDM0yA6o4KkflNlIjTgO0XRdhHdi0wdSQGsAsU7WT78pESkjZd/IYzRd03NNdUe8FLuh
	/6uPKeuXzLBjaibGqg99/Qw0UZZG8IGFxcnV2cPUKSgoeGsT8zoXVgQpaEiEH4XXnYi3Zwmlfk5
	D5pH0wnMp+BgmUhyeipDfpCId64GnPtn3E3nGxg==
X-Google-Smtp-Source: AGHT+IE1qwoo21Lj7SAsZna8oIYdgZg/fuhK6Zw4I5IO8vhRUjpgFxAFqTwYNfEozZCGITzVt4qWlg==
X-Received: by 2002:a05:620a:f12:b0:7e8:5ac9:7d53 with SMTP id af79cd13be357-7e87e07d13dmr314529285a.43.1755277865505;
        Fri, 15 Aug 2025 10:11:05 -0700 (PDT)
Received: from ethanf.zetier.com ([65.222.209.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e192d8esm137659985a.41.2025.08.15.10.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 10:11:05 -0700 (PDT)
From: Ethan Ferguson <ethan.ferguson@zetier.com>
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com
Cc: yuezhang.mo@sony.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Ferguson <ethan.ferguson@zetier.com>
Subject: [PATCH 0/1] exfat: Add support for FS_IOC_{GET,SET}FSLABEL
Date: Fri, 15 Aug 2025 13:10:55 -0400
Message-Id: <20250815171056.103751-1-ethan.ferguson@zetier.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for reading / writing to the exfat volume label from the
FS_IOC_GETFSLABEL and FS_IOC_SETFSLABEL ioctls

Ethan Ferguson (1):
  exfat: Add support for FS_IOC_{GET,SET}FSLABEL

 fs/exfat/exfat_fs.h  |  2 +
 fs/exfat/exfat_raw.h |  6 +++
 fs/exfat/file.c      | 56 +++++++++++++++++++++++++
 fs/exfat/super.c     | 99 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 163 insertions(+)

base-commit: 37816488247ddddbc3de113c78c83572274b1e2e
-- 
2.34.1


