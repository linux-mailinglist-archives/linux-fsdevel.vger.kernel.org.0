Return-Path: <linux-fsdevel+bounces-69115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C6474C6FCF2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 16:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AA0AC4EB1DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 15:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F312C2F5A13;
	Wed, 19 Nov 2025 15:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OTDeeA9v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF2E2E8881;
	Wed, 19 Nov 2025 15:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763566999; cv=none; b=LwWHUncFfIBZBv5ZJc0apIvXZvvnyXEJbydByms3n105eCx1aM1pslv/o/DQxP642ZQblE9PEuX9X7Mi6APM5pRE0r4vPuhZioSH7m/ez0/mr4D6mX7ChP9r7CV7zfWpvNTOmkmqj3arVNsNPk49+LVf+leqyEwSbeaxv2DcK/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763566999; c=relaxed/simple;
	bh=mvasbVVmomAazEvpFHNxRIYCxvJpoXa10PgqdP8z3Z8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NLUQXA4GErG71XiIa+Wb3wQhofahWdx1vTVTWYg+c/zRSmgcsl5R0QsjI9mQYzFQlv8eMO2V168Yd1bvZFnNyO2WIla4aGAgRbbNdeL2aGeYI0CQbPUSc3ODHB8zypnS96wx0Y3Lt8dCb8v6uqNtmKMBKX3Wpeyy/HNilin6Oz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OTDeeA9v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B1C2C4CEF5;
	Wed, 19 Nov 2025 15:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763566998;
	bh=mvasbVVmomAazEvpFHNxRIYCxvJpoXa10PgqdP8z3Z8=;
	h=From:Subject:Date:To:Cc:From;
	b=OTDeeA9vQKnh5uxllbDPT1RRSAImMzB0ayWmHYuA4OpVQS3+WbA+331kk/puFeTNk
	 7BWRpMi9aBKk/rcks2iS7H5Re6tc7/i4Y0q2LISV1t/smFOqb5hamkOGGe4CrflLpR
	 O+8QyhRX7kfHxAdAwV1azsGes29lkFd0gE+SH8qdcYTNoP4TM+arRQwc5r/f7bb21J
	 PFiXBemB3pYXqt2VTUv2/4LfadjGhU5lHx4Lk4clpBhNZrJoH4ovUS+UDOhewufVzy
	 5gyq8RRKgpQ4BkZ4Hz2lsnzQeyOSRoLYJJ6685zFtYSBQnbLCgYXuxg1S0B0gLDzZy
	 PBEttHWgwSSMQ==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH fstests v2 0/3] fstests: new testcases for delegation
 support
Date: Wed, 19 Nov 2025 10:43:02 -0500
Message-Id: <20251119-dir-deleg-v2-0-f952ba272384@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NwQqDMBBEf0X23JQkNS301P8QD1Yncalo2RVpE
 f+9IefO7THDm50UwlC6VzsJNlZe5gz+VFE/dnOC4SEzeeuDyzEDixkwIZkYbbDu0nehtpT3b0H
 kT3E1FHWFrkptLkbWdZFv+dhcqf/oNmcy1rcr7LN3QHi8IDOm8yKJ2uM4fi4cevasAAAA
X-Change-ID: 20251111-dir-deleg-ff05013ca540
To: fstests@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1462; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=mvasbVVmomAazEvpFHNxRIYCxvJpoXa10PgqdP8z3Z8=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpHeWR7+v6ZOiwpTFaG4XoKK47DZq/icNHiI+Vn
 aH8g46793yJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaR3lkQAKCRAADmhBGVaC
 FXfjD/9kxhHF06z++XPNgSuUNVuE+MHGiA1ZQ81YaUFUzBb/p4mAAcSSXIIsHMEsGoh7jcIWIDN
 J9YW/yhR9+b9NMXJMSr9VvJ7eern+vteRO/yBBhvAFkVzTwMMzCJ+uaCEOfxYrSGxzc341wVnby
 DbYBlP5IjeT1FIXOMeO6SunOuRaRpAXMC9vcvoUwOz77YjAmccyGDhyeenzTYOrz85fGQb1rBhS
 9zFfCVMftUE0Qwu+tbeGY1WnBPjWaWO7ixMoYg2RC7WYAnKelEOpZq2FsZcJsXFfxqjsG59BuZE
 Tm3N3cLCnGHLmzuJJwQkiAtE5f/DUPDKHBGenFTQKti1pCak5xk8HBJOw+7XXin6brvkWW/TD+R
 K+TJ2Rad+1HA0vLumzzCy7X4DGNmAG5lwKRaf17J0bXCupVYdCj/Omv7qF8q1oc1QT/RAQd78Fk
 nnIa2HOkcYj4PoLl7LhhwIQ42k7wjMU7S+8LAOlabFAkK0gI4YP3gPvF73sYdtmjjEmNhJ/kVek
 ANPh96lxXrHRAk8W1kX+GSvJAAZvXztNz5YOblOnOd8JKy1cZiJF5TTMZaryagHOZQvrN8+cXhW
 sjqRSI6pAyzT2ISgJYfdLx/N7MqBBfl2/mvX47G2Kdb6iehAAHqnM1XsgXJ8gQHRkZvUFWjMtRG
 6BskWTkRckpw1Yg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

This version of the patchset does a bit of cleanup first, adds a
directory delegation test and then a set of tests for file delegations.

Christian has taken the initial directory delegation series into his
vfs-6.19.directory.delegations branch [1]. There is a follow-on set of
patches to fix some bugs as well [2].

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=vfs-6.19.directory.delegations
[2]: https://lore.kernel.org/linux-fsdevel/20251119-dir-deleg-ro-v8-0-81b6cf5485c6@kernel.org/

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v2:
- Add tests for file delegations
- Clean up after testing whether leases are supported
- Link to v1: https://lore.kernel.org/r/20251111-dir-deleg-v1-1-d476e0bc1ee5@kernel.org

---
Jeff Layton (3):
      common/rc: clean up after the _require_test_fcntl_setlease() test
      generic: add test for directory delegations
      generic: add tests for file delegations

 common/locktest       |  19 +-
 common/rc             |  11 +
 src/locktest.c        | 621 +++++++++++++++++++++++++++++++++++++++++++++++++-
 tests/generic/998     |  22 ++
 tests/generic/998.out |   2 +
 tests/generic/999     |  22 ++
 tests/generic/999.out |   2 +
 7 files changed, 684 insertions(+), 15 deletions(-)
---
base-commit: 5b75444bc9123f261e0aa95f72328af4c827786a
change-id: 20251111-dir-deleg-ff05013ca540

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


