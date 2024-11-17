Return-Path: <linux-fsdevel+bounces-35041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 844339D0650
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Nov 2024 22:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A652281FD7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Nov 2024 21:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81A41DDA16;
	Sun, 17 Nov 2024 21:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ktQOITeW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329321DA60D
	for <linux-fsdevel@vger.kernel.org>; Sun, 17 Nov 2024 21:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731879143; cv=none; b=g4FVHl9R/inr9paatYF+22c0JzkU2p9bxLhB9byD19yjDLathMiAvw2EzB+9yzD4L39g5vljiyOpfdmdFv87DfiXJICnk/wQ+bQDGPiYRWpNqnK+k+UeIKORoRe4GvDYqqwBh7FLw07fpE2gCRN1P4bLX+0mV9izVfFEOpL8Nhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731879143; c=relaxed/simple;
	bh=auLBAMGSZHiKlVkZKnG1xgpLktKCy7bf3uvnYdjQUyw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u1kUozGx1LzmPLlg85d9cefxUbYtWvsKRKVwfAalLrcRe+csrAjPhKsBn0zzm3Z7L70e0/A3DjqX+iEWcRyWh/k/b+XSORMwNhzbw9OdOAa34xLKA14ZMEvABPzjJHhVWfSIbP5tfyDEv67lZvT3Zo9IYsgZBIuEL6HcraVMwSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ktQOITeW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 411A5C4CED7;
	Sun, 17 Nov 2024 21:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731879142;
	bh=auLBAMGSZHiKlVkZKnG1xgpLktKCy7bf3uvnYdjQUyw=;
	h=From:To:Cc:Subject:Date:From;
	b=ktQOITeWiAO6ZOstz30br39ce7fBKKN1HueKrEuyVfS89bQTG6f9pNLbY7Z5m30DP
	 3AsgTouvG9jGPY6sjtZhMx6/oTmWNY9x6gcZSvkZpQPTAq/TB7YgbWJPyPPGs3eknc
	 U0x3gtdVVHKkNMTg5Jadajc9af+Uov6v9HmNmtYIj40rLkoQD7ZAPBVREQqiHodiSv
	 gB5ujBZcA18+0zgcadQ3CD/Tyqu2tMGVN5rkx1D8WSHF1uyCpHE5MfUHTkpMvwrrH8
	 IyCRPoV7uCNewkAIQnOOAe3aYtO8BIS6A1IXddB3nNHDXs1CA2xrtRSukNs0wzAkNN
	 HtqM+nO5i5UhQ==
From: cel@kernel.org
To: <linux-mm@kvack.org>,
	<linux-fsdevel@vger.kernel.org>,
	Hugh Dickens <hughd@google.com>
Cc: yukuai3@huawei.com,
	yangerkun@huaweicloud.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 0/2] Improve simple directory offset wrap behavior
Date: Sun, 17 Nov 2024 16:32:04 -0500
Message-ID: <20241117213206.1636438-1-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

This series attempts to narrow some gaps in the current tmpfs
directory offset mechanism, based on misbehaviors reported by Yu
Kuai <yukuai3@huawei.com> and Yang Erkun <yangerkun@huawei.com>.

It does not fully close the window on bad behavior, as noted in
the patch description of 2/2. Perhaps discussion and review can
identify improvements that further clean up the corner cases.

The new mechanism attempts to re-use existing fields in struct
dentry rather than adding new fields, and is meant to be back
ported to LTS once it is merged upstream.

The patches currently pass xfstests, in particular generic/736.
The series has been pushed to:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/log/?h=nfsd-testing

Chuck Lever (2):
  libfs: Return ENOSPC when the directory offset range is exhausted
  libfs: Improve behavior when directory offset values wrap

 fs/libfs.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

-- 
2.47.0


