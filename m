Return-Path: <linux-fsdevel+bounces-70565-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A2727C9F9A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 16:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 20E8D3006E36
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 15:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4088731812E;
	Wed,  3 Dec 2025 15:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SvxJvT/E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804DA3168E8;
	Wed,  3 Dec 2025 15:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764776605; cv=none; b=sMfvt2JZzwym43sykVg2HL/dcSTUEMima/5Ut1bYzWOkofa9o8B7NAf90KUbYkPnh2UJiFpsJRUOUlkP6CkLyIlu9PD4uZ6T/CSsoyIA6am4xvQy8YV4i2ApomQAXfIt+69c/4hFJkt+eQwFWjqC9LUvUR+gU+l9yp7Mw2qANzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764776605; c=relaxed/simple;
	bh=xUUFN25vdNbdu2trCW7X7Rfr5nSpd90Zw9B852J2q60=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YmPJUYhIIu6U2r3Sye02Bu/2AyvFgBMQRBd3RzyhdZT7LBaRPN0JZwvMKAaBVfXmV9E26bm5et1r7X7FliPbncHCLQu39N9IkYnwVImcws4D8tvuLEl3js9Jg1t59aURaT1INj445KFm7m/tktvl5vNcpjvxejzUn0g3fzZJq08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SvxJvT/E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DDC7C16AAE;
	Wed,  3 Dec 2025 15:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764776605;
	bh=xUUFN25vdNbdu2trCW7X7Rfr5nSpd90Zw9B852J2q60=;
	h=From:Subject:Date:To:Cc:From;
	b=SvxJvT/EE4avVzD15h0OlYeuPUqlW5afvHlGejR14vthQPNshFBGEWqYY6BSIE1i2
	 RQ5jRGCEzTwFYlZ631UqszozWHoFpt3v2lUbGEnR9Usy5ZDmakxUejm7lf75cZ+aoF
	 u+/m31JvDMpqfY58iEx7aTdoSFafg3ROEodwtrPUxcia6tCxUZF+njtd+hKK52XdJF
	 3oIxGImHwbLP/wj256MKz7lJusJ3I/gl0ZVog64DamydJBdF8AYz5mC6kqbQGjFnU3
	 qNTTrRNVt6Pwf31MYVQmPaXQ3TZfByNDCHnnYFTPrvV/haE/RGouZgJjw9trfyKt5+
	 S/Rsb1flMEKmA==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH fstests v3 0/3] generic: new testcases for delegation
 support
Date: Wed, 03 Dec 2025 10:43:06 -0500
Message-Id: <20251203-dir-deleg-v3-0-be55fbf2ad53@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NywqDMBBFf0Vm3SnJaGrtqv9RuvAx0aGikkhoE
 f+9ISsLnd3h3nNnA89O2MMt28BxEC/zFCE/ZdAO9dQzShcZSJHR8bAThx2P3KO1yiidt7UpFMT
 +4tjKO209wPqV/erhGYNB/Dq7T/oRdIr/zAWNEYvywqppNbO5v9hNPJ5n16eZQEe1OqqECm1lq
 KmppPxa/Kj7vn8Br3JMKOcAAAA=
X-Change-ID: 20251111-dir-deleg-ff05013ca540
To: fstests@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, Zorro Lang <zlang@redhat.com>, 
 Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1695; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=xUUFN25vdNbdu2trCW7X7Rfr5nSpd90Zw9B852J2q60=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpMFqbeQd572/vq7b4VdMUKbu1BgiGs3ENZBN7U
 Xqnw2NoMeeJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaTBamwAKCRAADmhBGVaC
 Fa/9EADEsXLioJmyUudk0dvmzBZwFcMmMljkQTdMEi5KxnmMK2/V0Wc6DjnDyEL5pIQQl7HSlP2
 qLpdP/6Qn2iKyVpO0cVMTEPqNvndtKkWr9hgNROKGkiNzM6+mW5S7JCBvpRVGpB+iyvE8U/pmoa
 C2CvMzlzMjYO2a/XT3Hhhgl7+0X9fbbxtiFtMfasYrONUw8T+RRPWhP5ZE3oAwuv16RJlmOb8Dd
 aXbHRGnHsniSThE+C0tDYf2UvWqB/MrrxjC2HKm2ha8iw4M0RFeVyLuL7DfgNGalZtJb3aQcqDH
 gxWy5KMt9C3VnWtR+MUPcGLnwEy0H2bo7kJIV5ZOZoOhUHaYJCasOyXLcBGqt2Sf+EpbNvpmWYY
 8CXOwWFEPTe1bTQ9lEcce4jOEBOa7A8HU481/XDE/8WQutOJAQxC40zmpkaNjH5BcAHHqy7AoMN
 eTUFQ5EQcdR493HEunp4JcMMsPcDg6/+vzhXGVRdARpwgQqxfMErWrcX6XrWTHW7nALKpzVVGlH
 5oX0LzwvdPhhOFgu2KW5H4CY9J9CrWNxdMccf9vDQ/QT0pqzjjm4iFUME4j2pDtBRjX54qct+Fp
 LglySbhfijnuJuvA/YeBIk8+z/3/k/xUEmjWQ67Q3iMivmjp43Pjdb6aOicAPGkxJW+1mV0Ahom
 G2zMSZ2A+w7aOCQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

The main difference from the last set are just changes to address
Zorro's review comments.

Support for delegations has been merged into mainline, but there is
still an outstanding bugfix [1] that will need to be merged before the
file delegation test passes properly.

To: fstests@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: Zorro Lang <zlang@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>
Signed-off-by: Jeff Layton <jlayton@kernel.org>

[1]: https://lore.kernel.org/linux-fsdevel/20251201-dir-deleg-ro-v1-0-2e32cf2df9b7@kernel.org/

---
Changes in v3:
- Clean up per Zorro's comments
- Use ./new to generate boilerplate test scripts
- Add both tests to "locks" and "quick" groups
- Link to v2: https://lore.kernel.org/r/20251119-dir-deleg-v2-0-f952ba272384@kernel.org

Changes in v2:
- Add tests for file delegations
- Clean up after testing whether leases are supported
- Link to v1: https://lore.kernel.org/r/20251111-dir-deleg-v1-1-d476e0bc1ee5@kernel.org

---
Jeff Layton (3):
      common/rc: clean up after the _require_test_fcntl_setlease() test
      generic: add tests for directory delegations
      generic: add tests for file delegations

 common/locktest       |  19 +-
 common/rc             |  11 +
 src/locktest.c        | 621 +++++++++++++++++++++++++++++++++++++++++++++++++-
 tests/generic/783     |  19 ++
 tests/generic/783.out |   2 +
 tests/generic/784     |  20 ++
 tests/generic/784.out |   2 +
 7 files changed, 679 insertions(+), 15 deletions(-)
---
base-commit: 5b75444bc9123f261e0aa95f72328af4c827786a
change-id: 20251111-dir-deleg-ff05013ca540

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


