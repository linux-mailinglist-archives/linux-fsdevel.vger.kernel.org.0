Return-Path: <linux-fsdevel+bounces-72509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A81CF8D17
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 15:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 071133029555
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 14:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCE73148A8;
	Tue,  6 Jan 2026 14:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRkPjPvO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E1F29B8E5;
	Tue,  6 Jan 2026 14:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767710332; cv=none; b=AvazSoAflBuqvAxj10XyNSqXRK1Ph6LAxgrXQPspvJhbxVxOvTrvhpKPkqgPeZKkgxN7X77AKR0seE/CT/X2W9YQ6h4yL56MS+h3MDJufcjxuHs/yVQ9aXfWXJzAxE44f+rHOkRE6a+keuVj6rl5XulluMLcrJN569IE/pB4VrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767710332; c=relaxed/simple;
	bh=utM/SH6WSmMvug29RHcjE7Dcm79LOVBUQzbeMq+EFpc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tK2ZVUaiHF8z+53Cfq+gNUgudE4sjYZnP+sKt/ogIZtALOV4V67eQjkS7kIbWXWnDbyHOLa5KZk8gGG6vagPMajQfSXJenGqoHgKp+k7TDRz3xanI+QI6kkid5kUCMXIxdVFeD1MwCG4X6v4tVTdXxnik2VNMTytBqQPuQz9r18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kRkPjPvO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BBDFC16AAE;
	Tue,  6 Jan 2026 14:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767710331;
	bh=utM/SH6WSmMvug29RHcjE7Dcm79LOVBUQzbeMq+EFpc=;
	h=From:Date:Subject:To:Cc:From;
	b=kRkPjPvOSiGhUY3sY6I1gaIY8DhWjilzgvFGxMCTxtz7qiXHtIig/mgmjjLlQIXCp
	 NudlOoAYKPJu4375rXnCWj+9BdhBrHSXGErR2P4LIAt6HcLFKGCnOhYVk+qRPNZfEz
	 Kreh89TsMrl/L4tnVKIyCTtYvATcHPRxknvLJ9Jh5V/NK3Qg9J3nUJDJfPJ++1GRYF
	 S843F4bGGpMGpOgt9u7SAWAakJiqE9kGodASZ86fO4PY0tO2S1Xo8z7usexwMj9/+D
	 vig8HA70PVTebCjF1QYsXVecyOrjYA72ZLcYlBDi+sVY/mDCsfzvPfThCqyaGclNC5
	 lL2jbzlk1Wr5g==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 06 Jan 2026 09:38:22 -0500
Subject: [PATCH] acct(2): begin the deprecation of legacy BSD process
 accounting
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-bsd-acct-v1-1-d15564b52c83@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQwMz3aTiFN3E5OQS3WQzg6RUi1SzxFQzIyWg8oKi1LTMCrBR0bG1tQD
 qLsiRWgAAAA==
X-Change-ID: 20260106-bsd-acct-c60be8e6ae62
To: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Al Viro <viro@zeniv.linux.org.uk>
Cc: Amir Goldstein <amir73il@gmail.com>, 
 Jani Nikula <jani.nikula@intel.com>, Wei Liu <wei.liu@kernel.org>, 
 Joel Granados <joel.granados@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2057; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=utM/SH6WSmMvug29RHcjE7Dcm79LOVBUQzbeMq+EFpc=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpXR56ANCs8KTdMlk4G7/sBBI8YKI9+zToTxjoG
 WPcN56MZ8iJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaV0eegAKCRAADmhBGVaC
 FaLfD/0cBPMf70mzqJ2M3o7r40L3NY/VTSAMVZ0WA8BMlxv5Kb+FX0DfVejrE+2luxv7DXzi3q5
 o0WZIj8xyGejOz5VyhaXD5RAQPNk0y91Inv5YwXUVOzJMQ/gGhgSP0lHU7NiJgDCXbXr2K8N+ks
 enrGyS2QryaUmqkCciYysXEbtFUZekQRpwhDKOmrZgaXw/6FpwycYhlsUtSi7SLN6sAplrAH/xk
 AMy8oJCz3sIBIfZlBh9Y1Rop+A/VxEHEfRf71JyvZgXsaY6Bjczf3+DSYOQL2G0bDDyAtp9k/i5
 VdO1CUOolFuPIuZTcSoLMlEPYIauZN5yGFrfHGbeSTTEAeiE4QanZgIImNLTn93Frv+vH3YyZQx
 OvRvbqLAGAtaXG8RBblJh2DsNqjFZUuFNVYR+njABWT9h4FLA8NJJYmigeODnYw20CyJKq6apXm
 gyH6VC1KN4XWep36juHnBLNvYENmb0MVFMuPSXztkldtEIzB0ciOAw+MuGw7DdgVJsp4YrzuNwf
 BKHb++fbDXK7Py5vr2n9SnOmyU6lPwRfu5LNydL4EE9JbjKmmjWN3F1maA493H9Py/wKwSxHTmS
 eJv69btUABBiYA/L7hQpTfpLnKOT8vftML8DZKWikWpR1pij8nL1gS/MKbZ5rvNmtP7NwcHBziT
 1NSyl2JzzSb2nNQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

As Christian points out [1], even though it's privileged, this interface
has a lot of footguns. There are better options these days (e.g. eBPF),
so it would be good to start discouraging its use and mark it as
deprecated.

[1]: https://lore.kernel.org/linux-fsdevel/20250212-giert-spannend-8893f1eaba7d@brauner/

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
I meant to send this months ago, but never got around to it. Let's at
least mark this as deprecated and see who complains. We could also
consider adding a pr_warn_once() that fires the first time someone calls
acct(2) if we want to kill this in a more near-term timeframe.
---
 init/Kconfig | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index fa79feb8fe57bb01d8ce8f35e33535709b57d452..160c1c4ef253593d62650cd5a53f3421bc9372d3 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -624,8 +624,9 @@ config SCHED_HW_PRESSURE
 	  arch_update_hw_pressure() and arch_scale_thermal_pressure().
 
 config BSD_PROCESS_ACCT
-	bool "BSD Process Accounting"
+	bool "BSD Process Accounting (DEPRECATED)"
 	depends on MULTIUSER
+	default n
 	help
 	  If you say Y here, a user level program will be able to instruct the
 	  kernel (via a special system call) to write process accounting
@@ -635,7 +636,9 @@ config BSD_PROCESS_ACCT
 	  command name, memory usage, controlling terminal etc. (the complete
 	  list is in the struct acct in <file:include/linux/acct.h>).  It is
 	  up to the user level program to do useful things with this
-	  information.  This is generally a good idea, so say Y.
+	  information.  This mechanism is antiquated and has significant
+	  scalability issues.  You probably want to use eBPF instead.  Say
+	  N unless you really need this.
 
 config BSD_PROCESS_ACCT_V3
 	bool "BSD Process Accounting version 3 file format"

---
base-commit: 7f98ab9da046865d57c102fd3ca9669a29845f67
change-id: 20260106-bsd-acct-c60be8e6ae62

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


