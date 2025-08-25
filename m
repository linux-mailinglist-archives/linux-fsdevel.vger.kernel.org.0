Return-Path: <linux-fsdevel+bounces-59026-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B414CB33F73
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 14:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BD4717381F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 12:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D1F145B27;
	Mon, 25 Aug 2025 12:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhxMpZmO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72591128819
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 12:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756125084; cv=none; b=CkuB37ZauZZ+hoCewUPrmf1kd5J1XPudb1Tad0YAixSD83PWg7rNm7e8PGLzvQRf/TupfmYJ0V+lFcRjapK3nbPndyva8pz2E1OpC/gZ+0GeKchHMbgvaVFbheKtpWh7Ahe2bZbKOq/J89GNwxGHQPSk5R6AMsQ//zwij11bwgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756125084; c=relaxed/simple;
	bh=wVVLrmqKFU3LYjQ9d15y2PlJLBkIQlVTFJeYp3vFmPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VlXh8YA1+iiMJzZLr5zpgFqRbKQfOrRB0LOtNVfX1zhKXv4qVbLPF8kcQXJDQvUceuVSbN+OW6H2OC14qoKBVX7btOSslMy4/4cy2rJtCG6jQNgvJGW7BQU2kj5jm41WFzKM6w8lh5IHdkzwd65HnYnDzS2xzMfCf0CKhMjIw/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WhxMpZmO; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-61c4f73cf20so2840579a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 05:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756125070; x=1756729870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5s7G4Bn2nGadTN2UOnNJNqvq+zGJDF7Vs5sflNPnLNc=;
        b=WhxMpZmO9bu2G+bzAtG/+YPOWqlmt8rQ1O9troqZ5W+xq3M6xgsT9Tz6JpFr7u+t3I
         XEk1CuQXHCx29+R1FbP1cIuuyi8Ag9yh+w2CT7b4eBY63x0Fwbm3VNj0lllcEF3bmQrx
         tzTaghJ9C5EtyN5XdYzqUC+3aAHa0KhHmy0MTJNqjXt9+DjMDIzbGfPG2jKWEbeiR0Mh
         DM0P9vYoNfVObvnNiOnPUXfL6nAf7EoGzB32IjDy1CMIPAvQcmjoZfFTNZqOGCTmnZam
         wp3Ak6ksqb+4eFqA4cswV+EX/vlTAr1VL0cTD/JonKafnPBL2q5tUjrCTmOwMvVgdZL/
         8x9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756125070; x=1756729870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5s7G4Bn2nGadTN2UOnNJNqvq+zGJDF7Vs5sflNPnLNc=;
        b=FBGZ+PFQ9mFVq7egcWHHIssFqcLKthFd1rBSwN08AiCbNFgVb+NwbCSry/SqGMYt+1
         EmODG01QzcdWmotNXr6L2Z1lnG4DRwGkAkH4erBdrxXydnm3xf9D7uSgWei1Magr86zu
         VcUz+O9UQ8IudVptt3GC9p1Nud5XWR9g9NSVNNbMfRTHEIjKvaJlDvjDJyqgcuK54b0s
         PhQA1PbtOLPC2VhGFBevWYcOaYzzmrT+3/+KR8JhBqGZhub4IB1IicJ0E+QVY2g8FccA
         OSsT/l4PdoP4/ZOXM0yLJtabFOH0jbM+UN0cH8tt26Hn382c1uyM4S3X1Zx6pDnJGZpE
         dT3Q==
X-Forwarded-Encrypted: i=1; AJvYcCW4Ncyld4M4yZn8xaErpCvPviZZUthLFKzQUGUkgfITFVYTBnj+CNjwmF+X9WIDsUlTGWJa4tgHlA19qoWI@vger.kernel.org
X-Gm-Message-State: AOJu0YxTZwDlNeyjnkidkSGd/W/YSGoaCzD3VOZHCPvluelS8rr+81PM
	y4yYfLs2CPalNxZENUoOJ0ZecrAGQ5Y1mGx4hDEYjr0snK+Xy/Uyya29
X-Gm-Gg: ASbGncuht0HvEvcMWxxDivG/1Tuo5UE/Varw3Y1FeEaA1SJ3YY848z2V0P/31lTcfmX
	/0Uo4wbci68zTtuI7ry9CyhEonnWKQKf0eCeBqUlHEsot/EOHWAe6yAR/ogHgF63zz+EwpmnFay
	unLLEHYLviMPiTeVZZxljJptlRmp9ebCIQe0n7soPmssQM6kaKZ7Dxlqttv5kUbk5RL+GKVx+xu
	soCT77E2olmRtnJ240thU13FMfV25NTlzeF0eavlWrp8N0a4WCUZn2u1QOik4dTRdnBwaEuTtK0
	1dlRTvMEKI5hYeU+6sy0jy1PEKzNXUSiF6E3qQXg2x0X7rILRROSv5I4PXrkSmBzvQDE2k56n1W
	aoGq3cd1xKtrXSo9hYCEQsA6MJB1t3wed0sJa/GmPxkjYOLA=
X-Google-Smtp-Source: AGHT+IFqGDuv5pdn6DCCtSjCm3NxD5tDY09pFZ6WRin5QiKX5pWpMs4veCWmndAAczqDQkuuHoFAAw==
X-Received: by 2002:a05:6402:4548:b0:61c:30cf:885a with SMTP id 4fb4d7f45d1cf-61c30cf8d23mr6362908a12.7.1756125069985;
        Mon, 25 Aug 2025 05:31:09 -0700 (PDT)
Received: from meh.lonk-hake.ts.net ([37.30.10.60])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61c312a57e6sm4900740a12.14.2025.08.25.05.31.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 25 Aug 2025 05:31:09 -0700 (PDT)
From: "=?UTF-8?q?=C5=81ukasz=20P=2E=20Michalik?=" <lpmichalik@gmail.com>
X-Google-Original-From: =?UTF-8?q?=C5=81ukasz=20P=2E=20Michalik?= <l.michalik@livechat.com>
To: wangzijie1@honor.com
Cc: adobriyan@gmail.com,
	akpm@linux-foundation.org,
	ast@kernel.org,
	kirill.shutemov@linux.intel.com,
	linux-fsdevel@vger.kernel.org,
	rick.p.edgecombe@intel.com,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH] proc: use the same treatment to check proc_lseek as ones for proc_read_iter et.al.
Date: Mon, 25 Aug 2025 14:30:52 +0200
Message-ID: <20250825123107.61980-1-l.michalik@livechat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250607021353.1127963-1-wangzijie1@honor.com>
References: <20250607021353.1127963-1-wangzijie1@honor.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=./reply
Content-Transfer-Encoding: 8bit

Hello!

This change makes /proc/net/dev a non-seekable file.  There is
software that depends on it to be seekable (1), surprisingly some
other files in /proc still work fine after this change.

Minimal C testcase:
==
#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>

int main() {
	int fd = open("/proc/net/dev", 0);
	off_t o = lseek(fd, 0, SEEK_SET);
	if (o == -1) {
		perror("lseek");
	}
}
==

1) https://github.com/scottchiefbaker/dool/issues/111

--
ŁPM

