Return-Path: <linux-fsdevel+bounces-36554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0DE9E5AF1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 17:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3692B165DA6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 16:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753A722578C;
	Thu,  5 Dec 2024 16:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="cgoZb4ik"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D22224AFF;
	Thu,  5 Dec 2024 16:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733415001; cv=none; b=n06TPWwFFZoJ1fbMuTKUnr4A+r5joYIPi5I0antDcXW/VUlsK/fmLeAeck4ggiZ029+7/d4Ln5evC77EjePYkYnRHb1jMNXtrWZix7nLzu4EGe8uIGBw8wD5RCZuK6WoeG3udcKOL4fA0kZwhdG2+J18N8aSsd/HtV0SgclB1ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733415001; c=relaxed/simple;
	bh=hbIfZjMj4h3uXN3gl7MAeKG3rc5yigBi+Wny/WuUSJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dqpNwpDEDBrFNPpmA6VAmLP6sbX4jCpGRHZpTfT/8OPH/9gd28fx3qZslcrmtavBZkDSsGIzlrF7FzmecxNRtw+zBMoMEMD46vMnAFcym/xqkil4l0p6QZCaeXDcF6bVtxgfuNG3axGnRa96i2sWqFQZPj3h7nAWhmw7J1f5iZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=cgoZb4ik; arc=none smtp.client-ip=84.16.66.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:1])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Y3zqn1YnkzsvB;
	Thu,  5 Dec 2024 17:09:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1733414997;
	bh=eagq1eHZLSX+a8YTmNs769Rc9572rghldm9U8dLwCRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cgoZb4ikCgvdxtvFokaW437+RCeYwdWHNNIu5Od+bp/6eJ7w1Gc3r9n5ugZ+7D7l9
	 xhvm5qIGig5Ir+mRcLC6FVyxtcSKZeFm6FdIRc7P5rq1lCSQxK1oIpXEaXSzmwyxox
	 f0T2YSctMvA8B0Vm/9Ur53y0DH923Wykydb5nr6M=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Y3zqm0gYfzfsG;
	Thu,  5 Dec 2024 17:09:56 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Paul Moore <paul@paul-moore.com>,
	Serge Hallyn <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
	Alejandro Colomar <alx@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Christian Heimes <christian@python.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	Elliott Hughes <enh@google.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Eric Chiang <ericchiang@google.com>,
	Fan Wu <wufan@linux.microsoft.com>,
	Florian Weimer <fweimer@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	James Morris <jamorris@linux.microsoft.com>,
	Jan Kara <jack@suse.cz>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jordan R Abrahams <ajordanr@google.com>,
	Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Luca Boccassi <bluca@debian.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Matthew Wilcox <willy@infradead.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Scott Shell <scottsh@microsoft.com>,
	Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Steve Dower <steve.dower@python.org>,
	Steve Grubb <sgrubb@redhat.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
	Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
	Xiaoming Ni <nixiaoming@huawei.com>,
	Yin Fengwei <fengwei.yin@intel.com>,
	kernel-hardening@lists.openwall.com,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>
Subject: [PATCH v22 6/8] selftests: ktap_helpers: Fix uninitialized variable
Date: Thu,  5 Dec 2024 17:09:23 +0100
Message-ID: <20241205160925.230119-7-mic@digikod.net>
In-Reply-To: <20241205160925.230119-1-mic@digikod.net>
References: <20241205160925.230119-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

__ktap_test() may be called without the optional third argument which is
an issue for scripts using `set -u` to detect uninitialized variables
and potential bugs.

Fix this optional "directive" argument by either using the third
argument or an empty string.

This is required for the next commit to properly test script execution
control.

Cc: Kees Cook <kees@kernel.org>
Cc: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Fixes: 14571ab1ad21 ("kselftest: Add new test for detecting unprobed Devicetree devices")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20241205160925.230119-7-mic@digikod.net
---

Also sent as a standalone patch:
https://lore.kernel.org/r/20241127160342.31472-1-mic@digikod.net
---
 tools/testing/selftests/kselftest/ktap_helpers.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest/ktap_helpers.sh b/tools/testing/selftests/kselftest/ktap_helpers.sh
index 79a125eb24c2..14e7f3ec3f84 100644
--- a/tools/testing/selftests/kselftest/ktap_helpers.sh
+++ b/tools/testing/selftests/kselftest/ktap_helpers.sh
@@ -40,7 +40,7 @@ ktap_skip_all() {
 __ktap_test() {
 	result="$1"
 	description="$2"
-	directive="$3" # optional
+	directive="${3:-}" # optional
 
 	local directive_str=
 	[ ! -z "$directive" ] && directive_str="# $directive"
-- 
2.47.1


