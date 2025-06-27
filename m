Return-Path: <linux-fsdevel+bounces-53162-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DE4AEB2E5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 11:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C14417A7E24
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 09:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9D42957C1;
	Fri, 27 Jun 2025 09:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VdHrMVMZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F0A293B55;
	Fri, 27 Jun 2025 09:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751016589; cv=none; b=Y8OUKe3QnqpOi3PgAtJ5ORdKhdf3OrlgMXUeRgLnL3TgGacZc1IgVlX1Yn09yXVaB8U6UkGQL/AT1BszYw0JIpbdBmThwKeUVlxTY10AaC6jmRYPiNwUB878YfKckaYGfSxwoAg6hWpcsNcQ0iwiTFM3+ui7w+NEuByNQ1y/1OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751016589; c=relaxed/simple;
	bh=gbtN9iAolEaCiV9gpV7aHOW/rR2hqsOZc9r1CtdycQU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KSDIUHxdqIDA42kRqUUFYuqLA+T5F/UpG0VqGJ7Wbbo0KkyQsnxX/acS2neEpd+OYDcrPoYebQUKG4R1vpquOALctAejS1CZU/yTmjSwLHCKGOLTmcouT5BQ/cQD6pYnM9c4PMH5tWwzM3fRWxGlQPmZ3q8nn0GH6o8KTXiSSGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VdHrMVMZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7062DC4CEED;
	Fri, 27 Jun 2025 09:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751016589;
	bh=gbtN9iAolEaCiV9gpV7aHOW/rR2hqsOZc9r1CtdycQU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VdHrMVMZNj2q1T/GCDuFbhBdWasXcCg9h5dAFgwFgXKYG7vvsgJ93V9HItbeU6GFV
	 jgNp34gDziptbHlu7qQlAKssvzLKU5J6VgpjGZFk2FknaXM3cFmr6qLMgxZPs3HSWx
	 lHUqhlzVpgL7CcPPNOMt/H5KZqpMKS088BeomHvP/ElvxVxm0PtEuNnvLl/IXDbh5D
	 UHDW1WajuQPlEIBx+aR8mm8FPAr70q2KNtkmsYEqNZX8FT8gBrXbgb65L7SULVdEj4
	 +KeQwi+5J3tt4hrZLQKxUR1tDqou7K4gnfbFu+bI08jEVV6vtwoQfDqenwlP8p2CNU
	 3fC2HlRaXVc2A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51044C77B7F;
	Fri, 27 Jun 2025 09:29:49 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Fri, 27 Jun 2025 11:27:25 +0200
Subject: [PATCH 1/5] sysctl: Nixify sysctl.sh
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-jag-sysctl-v1-1-20dd9801420b@kernel.org>
References: <20250627-jag-sysctl-v1-0-20dd9801420b@kernel.org>
In-Reply-To: <20250627-jag-sysctl-v1-0-20dd9801420b@kernel.org>
To: Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=810;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=gbtN9iAolEaCiV9gpV7aHOW/rR2hqsOZc9r1CtdycQU=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGheZInuFzY4h7evnT6lmDFOI2joCl1dQ00cb
 CXzz3XyO4K8gIkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJoXmSJAAoJELqXzVK3
 lkFPYfEL/3OwRZjo77JjVR/Y+FsoxCGJ5utRTtsTviWHC8mqOOQj1GQnMPiVSPSr35YmqOy4kCE
 ox34cAygccgUrVCcCN7x+yUtHukR1qN1qq8k3kEIZzg0YMH4harhadcGHG6eF+LbIjh7aU5YEUI
 MyZf0ALMLyO0gSwm5aEhLCOBXKL/xnrbXS6OBUqU63tqUMR3nZ9kxtdHFkIfVAU/DA6erq+zmE4
 RA7VCBCmRi3NrJ+2wxlr5hWccTJ8vgGLEYRZTLxBJL0LO4nxIzS6KCSPxwUJvSuC9ZHU8vUsnp+
 MtwKJx1XvJilir8o7t73aiHcIxDp15AGFtMP5Mu7j5Hd+Ew6f9f82JtE+lIlqwPrMksU5gCaSgh
 Yww3u/HqZY/qcD5CaN+kC7wxhSuj867+Ansb2AMFJDjNzhQTfawZoVGYMJo5NocFDXOGkaVqL35
 SWUriiBUrlUIjokINruOHPF3MAkTownu8HiyzYVhMHEYadFTtl3H89c3md4CT7nA5ZWlqcPBfh5
 Pk=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Use "#!/usr/bin/env bash" instead of "#!/bin/bash". Needed for testing
in nix environments as they only provide /usr/bin/env at the standard
location.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 tools/testing/selftests/sysctl/sysctl.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/sysctl/sysctl.sh b/tools/testing/selftests/sysctl/sysctl.sh
index a10350c8a46e42691f4f89763bc3e2d3dc270097..b2d8bd9026a721e96c26be20069f7f87b06a5cf7 100755
--- a/tools/testing/selftests/sysctl/sysctl.sh
+++ b/tools/testing/selftests/sysctl/sysctl.sh
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/usr/bin/env bash
 # SPDX-License-Identifier: GPL-2.0-or-later OR copyleft-next-0.3.1
 # Copyright (C) 2017 Luis R. Rodriguez <mcgrof@kernel.org>
 

-- 
2.47.2



