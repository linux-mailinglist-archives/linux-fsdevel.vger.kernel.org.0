Return-Path: <linux-fsdevel+bounces-34949-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E105B9CF06A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 16:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A00F1F2347E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 15:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025FD1E25EE;
	Fri, 15 Nov 2024 15:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AzcgDJkp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6711E2315;
	Fri, 15 Nov 2024 15:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731684964; cv=none; b=Y67EUIVGq+XCZofwwn5C1xM2yGJ1Ulv6RvaDnckvJkYP/r4CgscEPQaqTX1DuD08Nx7ihPKFd7Lp1WFG/V4eJZUlqCmLHxLbv1nZpwAjZA761Kb16q5oj2LvMcBHX94UOCt5EMJYvmrz7gV2qpcBg+DR7PDcAvJU4MT0bX+dcEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731684964; c=relaxed/simple;
	bh=UIz/7wgCTYHuotgnuBv5q/lZMwI6XVc4LpUgzNg/FzQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JHH9ATR6tskf3uw08v2SpHU1f9Cv9+/1FtNbgZZcn8ctdAja2TYTEreLbkmaPdjUM7mUmN2EkuKiOs6Rq4m/f4DVeREJgOMN5C6Ug+wn2odnUCnB6bU9BQfJ5fXHrmj7bLMH+Aq50BL8jSPp8Qptp8uvigZp+aEsEEPKGcek+H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AzcgDJkp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD37C4AF13;
	Fri, 15 Nov 2024 15:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731684963;
	bh=UIz/7wgCTYHuotgnuBv5q/lZMwI6XVc4LpUgzNg/FzQ=;
	h=From:Subject:Date:To:Cc:From;
	b=AzcgDJkpUGGd13jctGgjWg3XG2CS/BmohjMqWV53dknmJkI4Ga9ftG5STPdAHyNG2
	 4wmi5P2uj0LoM0q2h0cQt8Blo/e5+MLBXa8l/AUX1gGqK0Lg6YH6cQLEkLB/Qe5JIA
	 CaKpznp4PfGFzyvRVgJatx0KXYFOjA/WEeFd3Jzldw6P7TpMZlNpUx5hwpugYNDBz9
	 cOFQspb9/oaafxuR/Nh0WqYN7lbgs2UcWYeD8ZQ3u5qjrbrP8AdUzwQjwF6kOjYmIF
	 UAuuWNxswPvMsowEsNch+D+Z8kwqWxzL9L6dO13TZZRSZSn7iQBh8lSCarLsY8oVAS
	 nH7QhuAI4Y6jA==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v2 0/2] fs: listmount()/statmount() fix and sample program
Date: Fri, 15 Nov 2024 10:35:51 -0500
Message-Id: <20241115-statmount-v2-0-cd29aeff9cbb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFdqN2cC/23MQQ6CMBCF4auQWVvTGUkorryHYQFlhEZtybQ2G
 sLdraxd/i8v3wqRxXGEc7WCcHbRBV+CDhXYufcTKzeWBtJUIyKpmPr0DC+fVNMYbQar6aQJyn8
 Rvrn3bl270rOLKchnpzP+1n9KRoVqbI1uta2tGfhyZ/H8OAaZoNu27QuQL0HUowAAAA==
X-Change-ID: 20241112-statmount-77808bc02302
To: Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>, 
 Amir Goldstein <amir73il@gmail.com>, Paul Moore <paul@paul-moore.com>, 
 Karel Zak <kzak@redhat.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1657; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=UIz/7wgCTYHuotgnuBv5q/lZMwI6XVc4LpUgzNg/FzQ=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnN2piwqq2Biywd/Eutsg9jis2+CgEbToA1krzI
 It2G9Q4HeSJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZzdqYgAKCRAADmhBGVaC
 FVTtEACHDCyZyM5kBlAmsa8aWHt9aLdMl4L1+xmiM/pN+28GG/GAfzmNlVI8EkBqtiljcHigtPy
 35zr/r5enhNnOyqLt66QIsTlsWZO8t8P+UodkX/IkWNnRbbfGX8rU9bEeQYEODcB88CqtL5z8Ti
 ckXzY5YcozuUmPPivKLz8NVpwg4TKAjTUv3RVllAPrevI3rM/QGQuJI88s5PrccLwwV95pCVuI3
 hvqdT1Y9Gd6IysBFe4bAhBFKdCwzbZnVkrlLoAewXaMw5SPTVNrXJFyruPd3R1KEn41nx/17S1W
 dBwEUo3Du1CPRXQHWOEnyg5PeNu8cTj44B1sfCE3uscL8xZMKk3yOKqG6Os8D/iD9Z2XxnvGHmS
 1mkOgJts+X1yCz6AnZzmEmivi6Yhz2R5OIY7ESKvi+aHUCLcTbKMi62p3+9N+cytYw46oLsRKYa
 /1fdssN18hskXwIoIqQYiXRH0cia7r6vGXI1Uis375ftaC306/B3r1CIPhy/dUZeIWjXaLbymXl
 3VTK5KGwFI1R1TIJZL1N1PBmJ1XgFJJkrILQ/kLmgqNgDFLQ/6tBoxCssmYRRGPQBUHYyvZJwrZ
 F9zpDwk452r6whP1Oh7gGHN0csQA4zjr6MXvONfNXb+2yU/nsJtVP1s7SAn3G/PtPw3VLOOyfUX
 4q7Odie7CH2Gwew==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

We had some recent queries internally asking how to use the new
statmount() and listmount() interfaces. I was doing some other work in
this area, so I whipped up this tool.

My hope is that this will represent something of a "rosetta stone" for
how to translate between mountinfo and statmount(), and an example for
other people looking to use the new interfaces.

It may also be possible to use this as the basis for a listmount() and
statmount() testcase. We can call this program, and compare its output
to the mountinfo file.

The second patch adds security mount options to the existing mnt_opts in
the statmount() interface, which I think is the final missing piece
here. The alternative to doing that would be to add a new string field
for that, but I'm not sure that's worthwhile.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v2:
- fixed off-by-one bug in listmount last_mnt_id handling
- patch to add the security mount options to statmount()
- Link to v1: https://lore.kernel.org/r/20241112-statmount-v1-1-d98090c4c8be@kernel.org

---
Jeff Layton (2):
      samples: add a mountinfo program to demonstrate statmount()/listmount()
      fs: prepend statmount.mnt_opts string with security_sb_mnt_opts()

 fs/namespace.c          |   4 +
 samples/vfs/.gitignore  |   1 +
 samples/vfs/Makefile    |   2 +-
 samples/vfs/mountinfo.c | 271 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 277 insertions(+), 1 deletion(-)
---
base-commit: 4be4eaeb1a60a7d52e66123f2f52f2da017c9881
change-id: 20241112-statmount-77808bc02302

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


