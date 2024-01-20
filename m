Return-Path: <linux-fsdevel+bounces-8352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D14FD8334EB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jan 2024 14:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D7BEB221E5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jan 2024 13:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51F7FBEF;
	Sat, 20 Jan 2024 13:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UyTJ8VaO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF14DF78;
	Sat, 20 Jan 2024 13:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705759063; cv=none; b=m1uaSDn+Ce4bMEpUVi+xuL47ySPmPhSaAU48+lr07XVbajSynS3eX3V7hh707Yus53G9r9wl6FTXhPhURrSNKhVjCkATyoLpCI1nZxYPtWadu+Dpw4DQrCADnwPlJudpAEZMPQJI2oT6W033k28Rn+yRPs3ABrdg30YL1rRmSS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705759063; c=relaxed/simple;
	bh=v8Lnf4rk234neQ76czGGnpCDiok0Rpu68BTewVXYpmA=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=BvB5TwNoywpj/L7NJY4tjDSggiXVdrft94nQMsUQjQu8ywjFQXyfWx9xWaxeONPdY7e1K2Le1n3QZVb8jRcRRGb+khAdToNXqt9+lyPgUTGgKpQd8/vFXNw+ubI+XO2ARK6+9ln3maJ2Wr55d9A3nYTo3rFoEs3qf3jF45y2lPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UyTJ8VaO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E48F0C433F1;
	Sat, 20 Jan 2024 13:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705759062;
	bh=v8Lnf4rk234neQ76czGGnpCDiok0Rpu68BTewVXYpmA=;
	h=Subject:From:To:Cc:Date:From;
	b=UyTJ8VaOsGwJWwBQLIkCaFBoiPD3e1zVFaHvwYOIBVr/h5lYBm3vpM4BYre7OwxJk
	 p5e5pdIbRVz/kZt23U90TNU1Oi6IhTAa5YoDcvOKktbA9qpJlxaRb7IF2D/ZPOAZOx
	 Gd29U0ZSkBgZPIyYhX9/U43mr4l/9MecVZ+QF7BmvFe/idXFIwA7uJC0zU+PDXaEfR
	 D8K6jG7olN3S8ohccn51/cD9QQ9MZu4EWmkusnkXnAJFc0vzyoY+LZW/QfmgPDInEJ
	 Z1TGPV4p+EVYffqkjnPvirWV3ogRHqfmxdCMa+V8rezP2ZSsKy8ik1weRc9kZcXb/2
	 uduvXH+pHlYcg==
Subject: [PATCH v5 0/2] fix the fallback implementation of get_name
From: Chuck Lever <cel@kernel.org>
To: jlayton@redhat.com, amir73il@gmail.com
Cc: trondmy@hammerspace.com, linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org
Date: Sat, 20 Jan 2024 08:57:40 -0500
Message-ID: 
 <170575895658.22911.11462120546862746092.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Last call.

Topic branch for fs/exportfs:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
branch: exportfs-next

Changes since v4:
- Make it easier to backport 1/2
- Replace "len < 2" with "len == 1" for clarity

Changes since v3:
- is_dot_dotdot() now checks that the file name length > 0

Changes since v2:
- Capture the open-coded "is_dot_dotdot" implementation in
 lookup_one_common()

Changes since v1:
- Fixes: was dropped from 1/2
- Added a patch to hoist is_dot_dotdot() into linux/fs.h

---

Chuck Lever (1):
      fs: Create a generic is_dot_dotdot() utility

Trond Myklebust (1):
      exportfs: fix the fallback implementation of the get_name export operation


 fs/crypto/fname.c    |  8 +-------
 fs/ecryptfs/crypto.c | 10 ----------
 fs/exportfs/expfs.c  |  2 +-
 fs/f2fs/f2fs.h       | 11 -----------
 fs/namei.c           |  6 ++----
 include/linux/fs.h   | 11 +++++++++++
 6 files changed, 15 insertions(+), 33 deletions(-)

--
Chuck Lever


