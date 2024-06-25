Return-Path: <linux-fsdevel+bounces-22400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7DC916C44
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 17:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7AF11F2C45E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 15:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F99F1849C1;
	Tue, 25 Jun 2024 15:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tavxR+nK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B3517107C;
	Tue, 25 Jun 2024 15:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719327849; cv=none; b=qWtBu3/K2qcTWXd0NMkLetjJ/RrpBOKxMerXlnimBh/22yzYr873bP5ksQzME3TK1JjHfYX0rGNe4jHlqvQxegIXaUoakD35z+gDCAWMqOJT4zo2eglh8XLs2e7GC61ynVqjKJHzsnrJm800uV2m0Hu3n0nZW/WIhN9s0Iwx94Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719327849; c=relaxed/simple;
	bh=b9Gx7QUiEPIAdR9RNFo057BasR3/TeEIE9B40jmDJ/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HQ/bLY6t7JywL8YVu+AETVCQeaO7vusqiCcikTgVJI3ejVxd4SlK7o4v4G5HKx6V4rRBrwuLkGrVvwO1QIrSmBFdnjtjcqGF3anNhuhu0pUI38EuKYhW5dbNQ4cfoCW20Hb4oXViK/55WGsBphlXOAHndhAo0ZbgjeFGVeFYeX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tavxR+nK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1362BC32781;
	Tue, 25 Jun 2024 15:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719327849;
	bh=b9Gx7QUiEPIAdR9RNFo057BasR3/TeEIE9B40jmDJ/c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tavxR+nKLIiH02ssJeoEROBXmOsCstTILDhWkKXxGu60OsgiMLuDIKVo0pL6GtCmE
	 igPSP6RIQSQWfikzRMGnE1Kg/67CHxNork4mRYKI3D96sfMbYWvsSFQl3IOmRa/Sf4
	 mRBbETLNbBhApzSodjPWF64W2dhM+zeIMkgpyuJ/OGB/QVYcC8rdr+Gm2ZH2a9dTQO
	 +ie8cUyHrEBDEw9rUgJ52SuTROV/Atv37rarClR6qcQhAf0oPjoMDxiJZAhnY63WRF
	 10koRgwnGojMJHrP7lJKHTgsKkLjfX59wpBQd7C+FiFvMud/7otZgv4IbZEzQvVpJG
	 zIHRIuySEFbYA==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 25 Jun 2024 15:57:57 +0100
Subject: [PATCH v9 29/39] selftests/clone3: Enable arm64 shadow stack
 testing
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240625-arm64-gcs-v9-29-0f634469b8f0@kernel.org>
References: <20240625-arm64-gcs-v9-0-0f634469b8f0@kernel.org>
In-Reply-To: <20240625-arm64-gcs-v9-0-0f634469b8f0@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Morton <akpm@linux-foundation.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Oleg Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, 
 Shuah Khan <shuah@kernel.org>, 
 "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>, 
 Deepak Gupta <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>, 
 Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Kees Cook <kees@kernel.org>
Cc: "H.J. Lu" <hjl.tools@gmail.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Florian Weimer <fweimer@redhat.com>, Christian Brauner <brauner@kernel.org>, 
 Thiago Jung Bauermann <thiago.bauermann@linaro.org>, 
 Ross Burton <ross.burton@arm.com>, linux-arm-kernel@lists.infradead.org, 
 linux-doc@vger.kernel.org, kvmarm@lists.linux.dev, 
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.14-dev-d4707
X-Developer-Signature: v=1; a=openpgp-sha256; l=1471; i=broonie@kernel.org;
 h=from:subject:message-id; bh=b9Gx7QUiEPIAdR9RNFo057BasR3/TeEIE9B40jmDJ/c=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmetuJPYum8zU2drU0QkG0Oevd9R7hfLQlztVXJmOP
 AMNcKOSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZnrbiQAKCRAk1otyXVSH0BxTB/
 9RAJG8vNMCnKeW0ZaJ2eAuj74/NV9s5bUsk5CVhSS9OmMa/aJ+gGWY94HaF0LO0M1jlnry4Je6LXUz
 N04y86o4L+9c3XkvE+GTl1jJ/1Gkna5RVE2LXbIbT8mRZiwGQSJdDveYSoa2Bj37DHov5V1RP25uMZ
 wGWAuPensfQp/ZFhSyZUpW4mSTgmdApUyOm6005OB6HsSqlcTKdRwjD6o7DEhh+iNAcTBm4+UR8ROm
 936rXsxL2yXXYX24fQXH0f8hiOJNgnDfmeHYMdbPZxh/xgFapx45UVH2J4t9am/rGr4blvsGhgPbUV
 BEAqQPu/bmkwHrSC+EwrYkGwBWaNjY
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

In order to test shadow stack support in clone3() the clone3() selftests
need to have a fully inline clone3() call, provide one for arm64.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/clone3/clone3_selftests.h | 26 +++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/testing/selftests/clone3/clone3_selftests.h b/tools/testing/selftests/clone3/clone3_selftests.h
index 38d82934668a..e32915085333 100644
--- a/tools/testing/selftests/clone3/clone3_selftests.h
+++ b/tools/testing/selftests/clone3/clone3_selftests.h
@@ -69,6 +69,32 @@ static pid_t __always_inline sys_clone3(struct __clone_args *args, size_t size)
 
 	return ret;
 }
+#elif defined(__aarch64__)
+static pid_t __always_inline sys_clone3(struct __clone_args *args, size_t size)
+{
+	register long _num  __asm__ ("x8") = __NR_clone3;
+	register long _args __asm__ ("x0") = (long)(args);
+	register long _size __asm__ ("x1") = (long)(size);
+	register long arg2 __asm__ ("x2") = 0;
+	register long arg3 __asm__ ("x3") = 0;
+	register long arg4 __asm__ ("x4") = 0;
+
+	__asm__ volatile (
+		"svc #0\n"
+		: "=r"(_args)
+		: "r"(_args), "r"(_size),
+		  "r"(_num), "r"(arg2),
+		  "r"(arg3), "r"(arg4)
+		: "memory", "cc"
+	);
+
+	if ((int)_args < 0) {
+		errno = -((int)_args);
+		return -1;
+	}
+
+	return _args;
+}
 #else
 static pid_t sys_clone3(struct __clone_args *args, size_t size)
 {

-- 
2.39.2


