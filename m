Return-Path: <linux-fsdevel+bounces-7390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB469824601
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 17:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28FC1B23C8E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 16:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3F124B3D;
	Thu,  4 Jan 2024 16:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sMvkL5uQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7678A24B26;
	Thu,  4 Jan 2024 16:18:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 488C5C433C8;
	Thu,  4 Jan 2024 16:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704385130;
	bh=ewJYoc2hyR19DvQDGfOBQZQ0hLBb4+PNsv1GmyMGgR8=;
	h=Subject:From:To:Cc:Date:From;
	b=sMvkL5uQAJuNUPLmZZoTb+Wc3QuvvkIHf05t5vJzUAn2jtgekFlyZP++rwcmQmxDj
	 JnvxK1HufYqsLr5543evcIs3qKEXRkyMzWcR3Sr7Vmx4tTjhTGl0NqyYGHLyYVWvHM
	 Ibey1T3fvqe2FkRk8ZCNQJL0x4BvLFfgJY3nYa3umYLBcda9In0+TIn8b6XBN2jc6U
	 jTGopWder4uA305gRbl5woC1gI8Eeo7Hr8oLufDIajTKUf3MsjHrc401+lM5nkJdl+
	 fOCcTojRz8MswYgyHXdeKwc2FSBvX/+R5U894I2hBzqwPwRAxOgeZQy7T+v5MIsv0A
	 lMcuS36LylpQw==
Subject: [PATCH v3 0/2] fix the fallback implementation of get_name
From: Chuck Lever <cel@kernel.org>
To: jlayton@redhat.com, amir73il@gmail.com
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
 Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
 trondmy@hammerspace.com, viro@zeniv.linux.org.uk, brauner@kernel.org
Date: Thu, 04 Jan 2024 11:18:48 -0500
Message-ID: 
 <170438430288.129184.6116374966267668617.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

I've set up a testing topic branch for exportfs in my kernel.org
git repo:

 https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

branch: exportfs-next

Note that I currently don't expect 1/2 to be backported to stable.
Please speak up if you believe a stable backport of 1/2 might be
necessary.

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
 include/linux/fs.h   | 15 +++++++++++++++
 6 files changed, 19 insertions(+), 33 deletions(-)

--
Chuck Lever


