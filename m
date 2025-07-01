Return-Path: <linux-fsdevel+bounces-53447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B01AEF200
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 10:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C07C17AEFC3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 08:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A0926C39D;
	Tue,  1 Jul 2025 08:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEahNi76"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABD822259D;
	Tue,  1 Jul 2025 08:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751360238; cv=none; b=FXVY+EsHoCljH+CDNg2koalBggvQkpu/VT49xn58uKod9Aa92VBBGX7ND6/a2cLdi4DX/CVmRclUJGMszasDXiqlMChSz1keFL3Chy0G6JuKEcuB9jn1SJxJ69KQe5/2KX1t7EYAshro8XozqaUmNQ5ksng3Oh0eRKLpvytfnkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751360238; c=relaxed/simple;
	bh=4SwDv1lBWtZq4b3iXzi192DtKqn0vm08JtS+5Pq6gkE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XjAbXxgyiix8E0m9wTLDw7NKQ9uQWz9JChav0gSNsfWav4bbVorAPmmtDziQ9jYxKg3wkx2aKdPLsdZ9RHBroQ7nEDMMWGokufQrGylrb2YW27YZKKnN2aP7SlDwXQTA+h4ZhVVmpTfPqExaYwH2OHzilAf4MaOCMIz0j3tLZN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEahNi76; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9B17C4CEEE;
	Tue,  1 Jul 2025 08:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751360237;
	bh=4SwDv1lBWtZq4b3iXzi192DtKqn0vm08JtS+5Pq6gkE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OEahNi7642nIp4UnaCb8lSgGAGeZUhZA0hiFBNsMu0en7mCQ4uCgta4ZflICPYR7N
	 uzpl2QSbTzOs8GpQIthBa4jYQsUU2w1Rhg68YCDToC9yX0SI5nHGnuzdfy74srHeTl
	 N8INFIBiWUifdP7Mnfit1GhTljpIjg4/8/iX/bvtlAEJ9eVRf7oGEp9jrQzMN+NzXk
	 wPxkCwfg2n/QjTC7e3/HTvMAl8Jbh5jVEznP9AwpZchMrKAb7AoFFXBJc5F23aZY3G
	 qWnFvrNMlGAnCdqnb2pSUdQ+NAyBHCgopW3xsWY6wo90WXT95ORAISFSzgnpvPs9Us
	 CKgXDmjM9+Sjg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EBCC8303C;
	Tue,  1 Jul 2025 08:57:17 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Tue, 01 Jul 2025 10:56:43 +0200
Subject: [PATCH 2/6] docs: Use skiplist when checking sysctl admin-guide
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-jag-sysctldoc-v1-2-936912553f58@kernel.org>
References: <20250701-jag-sysctldoc-v1-0-936912553f58@kernel.org>
In-Reply-To: <20250701-jag-sysctldoc-v1-0-936912553f58@kernel.org>
To: Kees Cook <kees@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1565;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=4SwDv1lBWtZq4b3iXzi192DtKqn0vm08JtS+5Pq6gkE=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGhjouk395j9INJu6XGoPtLhnYLVRImz/idRJ
 Bw1XhnQJa7A9IkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJoY6LpAAoJELqXzVK3
 lkFPByAL/AhVuluFhQDaN1/+hYluKuL1g+JPOvAP4y4xv+4ypZ8F5drM1GN4DF5TmyoRLxXOSte
 Hk+Owhk8bCsbQqMwaFhnSyAoEP0OgJFGOClUi+dqj8sVzOrrGVn26h9cXIHZitUYwb1THgZY6b3
 Xn1k+BKUbkBU+jC34bUPBsHU5ikcShW6sVXGUTedVUutMDzCRknCEcEWDMPRIYtiboRU/FFY9cD
 cgNpkgw/IM3udgid7ijUOoYclmWebEdkcp3wJq0Aq/UVB2wJk0LXUQMomqlk6TeeulnBOOoS+6L
 u+h4pQ44Rw2zBEDS96IOrpN0RwHGaqVFVwzxj2GGQyxqk/BwxDjll1F3HcOpjhIHFC6M3ZsI89l
 6aykS9jwuHMXaAk1aycsIZHgJhkWvSQqyEiN6IEQ46wObE4ygQTjlcHFlqDjmOUxXr4G99RdwLx
 liuj2ppd7SGWMIkl0sOX3OW/3VdiPiZ/D/m+INYc5s50dxN6A8LQlzXDgcJbGtaptV28509kBi3
 WU=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Use a skiplist to "skip" the titles in the guide documentation
(Documentation/admin-guide/sysctl/*) that are not sysctls. This will
give a more accurate account of what sysctl are miss-documented.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 scripts/check-sysctl-docs | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/scripts/check-sysctl-docs b/scripts/check-sysctl-docs
index 178dcf2888ffd21845e8464fc2595052c02ff4a3..568197cb1c0a84147785f05aabbbc6ab9dd896bc 100755
--- a/scripts/check-sysctl-docs
+++ b/scripts/check-sysctl-docs
@@ -17,6 +17,18 @@ BEGIN {
 	print "Please specify the table to look for using the table variable" > "/dev/stderr"
 	exit 1
     }
+
+	# Documentation title skiplist
+	skiplist[0] = "^Documentation for"
+	skiplist[1] = "Network core options$"
+	skiplist[2] = "POSIX message queues filesystem$"
+	skiplist[3] = "Configuration options"
+	skiplist[4] = ". /proc/sys/fs"
+	skiplist[5] = "^Introduction$"
+	skiplist[6] = "^seccomp$"
+	skiplist[7] = "^pty$"
+	skiplist[8] = "^firmware_config$"
+	skiplist[9] = "^random$"
 }
 
 # The following globals are used:
@@ -53,10 +65,11 @@ function printentry(entry) {
 
 # Stage 1: build the list of documented entries
 FNR == NR && /^=+$/ {
-    if (prevline ~ /Documentation for/) {
-	# This is the main title
-	next
-    }
+	for (i in skiplist) {
+		if (prevline ~ skiplist[i]) {
+			next
+		}
+	}
 
     # The previous line is a section title, parse it
     $0 = prevline

-- 
2.47.2



