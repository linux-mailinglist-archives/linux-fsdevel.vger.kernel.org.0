Return-Path: <linux-fsdevel+bounces-14825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34394880268
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 17:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA8A7B21AC3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 16:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0F98BFC;
	Tue, 19 Mar 2024 16:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3VV3E+E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B729313ACC;
	Tue, 19 Mar 2024 16:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710866088; cv=none; b=Bd81Pu7CEdJVHVZRCNghocgV0byb3/hBtfwpu9JZ9geO5ATxt9L5skkDqB6JZPGAWJlNdDwCi9hIkyPpCg6arJ3/pkYAs8MIR08h/S5xR13rsXDEeL/8LHV3CwNuBBHfTrfzOIfXcbMCVChSU3oJNNaSc2Nngtb/Xjs1ylJiOVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710866088; c=relaxed/simple;
	bh=sWcrpcQ7SA215oarYW2cTrDgksU/Injyvl3jW9oqqF0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lbrCkkV+3LCPTZQSODep+SpWdUmVF8SwrF7YhSgh2co5jABgF/7RjWpP6FWeQXxPgj64emP5rWN+BC7NYsnzl8+8Bsc0Qs0WBkffLdbacId7Up8+EN8Py6I5ZwF9JTaK4UvT370o9qEVMki2r60COqoQMzZ0gWl2UyFH3kn75Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3VV3E+E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DEB3C433F1;
	Tue, 19 Mar 2024 16:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710866088;
	bh=sWcrpcQ7SA215oarYW2cTrDgksU/Injyvl3jW9oqqF0=;
	h=From:Date:Subject:To:Cc:From;
	b=B3VV3E+E6rCPFhQr++KfCfRo/HbfUXQUEe05clvlMeoH3yJDRhSM+lJmtDAFOSwh/
	 OgbWM5px5egmIZb6whE/3aO+HFflY8Oqecy7VgvBNGZEtZNNsvoNiZDYsv97Chweu7
	 nZZkpMi0VrLuG+/ZvyaM3/tBj3b6I5vFjY5Ts97sKZ10Azu6vMvyorOUeSng8I5F4o
	 Ndzq/o6DbfYrIbOkprxWcFCMOIuJNNLuyw0Fhtzq/PI70daie79wsLPkHkTW5XLHKy
	 AZl1yQs3tGAkq8ziok0IpW3JB9itZd02Rin5iVh5h5zYqUhJ8A0qtAlivVAqT2OehQ
	 wABmUmUbCWlrw==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 19 Mar 2024 12:34:45 -0400
Subject: [PATCH] 9p: explicitly deny setlease attempts
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-setlease-v1-1-8532bdd2b74a@kernel.org>
X-B4-Tracking: v=1; b=H4sIAKS++WUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDY0NL3eLUkpzUxOJU3eRUY8O0JAtzc/MkAyWg8oKi1LTMCrBR0bG1tQA
 swUHSWgAAAA==
To: Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1165; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=sWcrpcQ7SA215oarYW2cTrDgksU/Injyvl3jW9oqqF0=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBl+b6nqBqEx9lnOPjWB/2aQcCJxobhEnUDWaCQR
 wzZHtSfQZuJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZfm+pwAKCRAADmhBGVaC
 FaJqEAC9PNA8wJ0oiNV1JvvkQYYnoDcC8XMd5mxTHnh7uIfiXtH5ZwGDuZDlKkkeqkb3o+25Yhb
 7ZiICO3zhHg+l/uiXKGpQH4cr3f/W50lMxe/qHGW9qKCE+BoXKpdl07FLYGxr6k6UlDKjhsq9hh
 STultKHcg3elPBdG07knAoDDZROLb/2gayvaKYk6uUypR+4aGbgsN+CsXDUUARJ/bdvhMouTN9f
 L+bKRu4hEbDToxNE/kh36921HT6Jw8yTvA9FMwH6kOYiJCfjMeiSYWribW9K00+fn9XtqlMZpRT
 Bt5KwAJvYWl2TJN0BjICxQjC9Ydygt77doc567ZrJ6PRsCs2xoa4VNxw9RTg0ffbZQFMeK3hO8d
 4G0cHVY5aP4LztoZLJCjL+ul+B9D2Yy4Eq3UnFZFsEMdusjZsH6Fqb+cNTxq4yefMRD98zhgzDM
 V8WwUNFgFMtwglw+DNeMgtoyHttlTy2CooYyqFqCgMWnyW17cpaPajKzF/ILCNex7jC6c/6cMDR
 Xzzy75Eq2E04zK4g3TR0Rvng/re9SbC9yERqtQK5y4b2+XtArJBpm4Xccwe5L/LmWktUJb+bo0r
 nGuMFqWiM1uH2GIjCaLw1GKwramMF0jxqZ+b4mbWYZ4f4GsRpR7kjYPTqude2D1N7n4XjFPv4bE
 lNb0Q5QUxjZKUzA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

9p is a remote network protocol, and it doesn't support asynchronous
notifications from the server. Ensure that we don't hand out any leases
since we can't guarantee they'll be broken when a file's contents
change.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/9p/vfs_file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index abdbbaee5184..348cc90bf9c5 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -520,6 +520,7 @@ const struct file_operations v9fs_file_operations = {
 	.splice_read = v9fs_file_splice_read,
 	.splice_write = iter_file_splice_write,
 	.fsync = v9fs_file_fsync,
+	.setlease = simple_nosetlease,
 };
 
 const struct file_operations v9fs_file_operations_dotl = {
@@ -534,4 +535,5 @@ const struct file_operations v9fs_file_operations_dotl = {
 	.splice_read = v9fs_file_splice_read,
 	.splice_write = iter_file_splice_write,
 	.fsync = v9fs_file_fsync_dotl,
+	.setlease = simple_nosetlease,
 };

---
base-commit: 0a7b0acecea273c8816f4f5b0e189989470404cf
change-id: 20240319-setlease-ce31fb8777b0

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


