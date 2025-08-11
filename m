Return-Path: <linux-fsdevel+bounces-57258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0BFB2007A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 09:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C95F3B6C34
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 07:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27AC72DA75B;
	Mon, 11 Aug 2025 07:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHBr8vYO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789B0AD23;
	Mon, 11 Aug 2025 07:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754897957; cv=none; b=f4qIngeglYNeOsHsq50qLiTPWpZwj4mxJMu+g+LTHuidNd50u+qQ8mhSILMfdIa/KCqhGc4JVXTtbsGdhUVntzDWX5wL2rgBbpY0Mv5FZSNNYBYMT5zW06fSSmAFVo5l95v0wDFa7nOpypNGS4Po3GbEYTKeLre+0tSZJhfZgLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754897957; c=relaxed/simple;
	bh=ipGMq/vUm0CtgMWRd44Gtz/SgcI6pGWNAOXKFk5bLTA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ooikUyG/fXd8t04Kn03J9QmPLO1Y26iYlJPLgcileeuR7P0Ed1TIEE/gqpLpJxYqd57Q/FWSoqwSUzPw4uCF1alCF7v/iQPfwBG/n8IHI8YreHjpdgUIqRlrQCoXK+sJV0WsUZNuNLE4yHAGpF457zU1aajrErORQsXVw7x7Lag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHBr8vYO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0D769C4CEED;
	Mon, 11 Aug 2025 07:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754897957;
	bh=ipGMq/vUm0CtgMWRd44Gtz/SgcI6pGWNAOXKFk5bLTA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=dHBr8vYOzOLBYeM4qWtjWdeo5hXwQXTMEvC7rHZyryICKNaGgqocXyZE2PkTFd02o
	 pbpyxwKklwksDFeBqQ3/jJG7EcR6buZ7QB16bbNrw6cRPJab3Pg+gSqYzGFLcQQDNv
	 kRnvPVyKsGYDdWMsSLXtcuP5LKVI5JWd79KN9cLUpUMKEQjJAAocc6eCzQ4M+rlsEE
	 LP5pGFsLYM7n8XlAztgXQZfKA8iUJTCsO7i+y+HDcokDZRxoie+scUDgmirO5q7MbO
	 BS2A2sZUVSZMAh3yC0KF4hdn/ALbTerFEbLxHYZXQp98D31YUGRVJjoD2ol5d6r57v
	 bTAWwH/z0gcTg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009E5CA0EC0;
	Mon, 11 Aug 2025 07:39:17 +0000 (UTC)
From: Dominique Martinet via B4 Relay <devnull+asmadeus.codewreck.org@kernel.org>
Subject: [PATCH 0/2] iterate_folioq bug when offset==size (Was:
 [REGRESSION] 9pfs issues on 6.12-rc1)
Date: Mon, 11 Aug 2025 16:39:04 +0900
Message-Id: <20250811-iot_iter_folio-v1-0-d9c223adf93c@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABiemWgC/x3MQQqAIBBA0avIrBM0iqyrREjlWAOhoRKBePek5
 Vv8nyFiIIwwsQwBH4rkXYVsGOzn6g7kZKqhFW0vlJScfNKUMGjrL/JcboPqRquURQM1ugNaev/
 hvJTyATwG9KNgAAAA
X-Change-ID: 20250811-iot_iter_folio-1b7849f88fed
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: Maximilian Bosch <maximilian@mbosch.me>, Ryan Lahfa <ryan@lahfa.xyz>, 
 Christian Theune <ct@flyingcircus.io>, Arnout Engelen <arnout@bzzt.net>, 
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Dominique Martinet <asmadeus@codewreck.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15-dev-7be4f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1234;
 i=asmadeus@codewreck.org; h=from:subject:message-id;
 bh=ipGMq/vUm0CtgMWRd44Gtz/SgcI6pGWNAOXKFk5bLTA=;
 b=owEBbQKS/ZANAwAKAatOm+xqmOZwAcsmYgBomZ4hs5Cp30hXcHbfl4l0JlgzG35PORBEfIRMI
 LewI8aNKVGJAjMEAAEKAB0WIQT8g9txgG5a3TOhiE6rTpvsapjmcAUCaJmeIQAKCRCrTpvsapjm
 cOhkD/wNlX4zh1L+5pTsjOFXHjNsMe1txBnzozO2Or1c2qrE4UOFnjzyEYO6Lpk3st80K79GqZB
 FEhktLF0zrjIKbPexnvuhlEHqEpqQyHfQRfruC6FAgWX9BPIHolbuzw2YRgkqQ+4gpVIA8CWvrT
 4d9D7+1miPzj0p+vqHVtqb4naANkMoPEjdcikIIsYPZIoVFGhFrs6eb+x86MlbzoMCZdMI7dhSC
 zJqAJL1k7F0F0UYAJg/LXlcZLSVqanZOfXapZ+Rd13VcN/rJOleJX7ucIahdqJgIFsPbt5VNvH4
 2h81vEUr9aCu0iu6GkHA06QOHdjdxdUC9Eb55yie9jyKBbxvgm14lcsl63SqkJ65BSqa5wTH4Zb
 xZpewpcMeKqq4FksdlFbnqZrA3jIwtx5zLCzOyIRyfUuV95WT+LkW2kbXQN4FwEG89/PSH4qzM2
 ITl9eEzjNHD3dTQe3UyB6jZqgTUcE+06cJbQkAWdwzIOmGKHTInV8BbeqZFIvRLjpQU1ju9WdRX
 fI2rVzPb6PIquM7+l0A7sbeunEBAzPBgG+1ZyIl0eTKexPomedZK7xSqQGSOANl8WMbx/amUj6V
 7bTbHBInmALTG6nvgTPrFt9Wup7iPFVdxdHxNKVT3Rf0Ro/mnrGYMo/v34WlYkMXjpa2m75Qw3V
 7BE1Y9iD6woOWCw==
X-Developer-Key: i=asmadeus@codewreck.org; a=openpgp;
 fpr=B894379F662089525B3FB1B9333F1F391BBBB00A
X-Endpoint-Received: by B4 Relay for asmadeus@codewreck.org/default with
 auth_id=435
X-Original-From: Dominique Martinet <asmadeus@codewreck.org>
Reply-To: asmadeus@codewreck.org

So we've had this regression in 9p for.. almost a year, which is way too
long, but there was no "easy" reproducer until yesterday (thank you
again!!)

It turned out to be a bug with iov_iter on folios,
iov_iter_get_pages_alloc2() would advance the iov_iter correctly up to
the end edge of a folio and the later copy_to_iter() fails on the
iterate_folioq() bug.

Happy to consider alternative ways of fixing this, now there's a
reproducer it's all much clearer; for the bug to be visible we basically
need to make and IO with non-contiguous folios in the iov_iter which is
not obvious to test with synthetic VMs, with size that triggers a
zero-copy read followed by a non-zero-copy read.

Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
Dominique Martinet (2):
      iov_iter: iterate_folioq: fix handling of offset >= folio size
      iov_iter: iov_folioq_get_pages: don't leave empty slot behind

 include/linux/iov_iter.h | 3 +++
 lib/iov_iter.c           | 6 +++---
 2 files changed, 6 insertions(+), 3 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250811-iot_iter_folio-1b7849f88fed

Best regards,
-- 
Dominique Martinet <asmadeus@codewreck.org>



