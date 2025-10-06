Return-Path: <linux-fsdevel+bounces-63463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0E7BBDB21
	for <lists+linux-fsdevel@lfdr.de>; Mon, 06 Oct 2025 12:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 17E3C4EB300
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Oct 2025 10:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FF3243954;
	Mon,  6 Oct 2025 10:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JiOpXpLX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF76723BD1A;
	Mon,  6 Oct 2025 10:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759746695; cv=none; b=EBRtJ8cbyfY4J5gfyIyF2bCkUyt5AYRFk/8vkB3lHvT1cDm4DbEaQmUKeqzCTHNW5WIzMmR3alxcesF0P2KmcQ6EANo47vTCAgJhEL2U4UPtqMiBoFaggNzI0GgzqENGYbBjjqv3/18UBqvOzUL/0ynCSbq3r2AjFisqd1k4yr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759746695; c=relaxed/simple;
	bh=cG36zcMsqBxk2WJ2EVZoOITToowjiuE8hiD3wFiNkKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WNUPYoQhwg2WKwqhDpmnFAgQ67AuhIz/FhSJgBGTBB7u8SNUnGBZWo46lB94nxw/d17BepGY8LKOpb7RF6CAMQ1CgooMxCQhvrnqz4LADMlqo4/AXFy2RFP/GOyroqiBpEOT/iOYhcXNUeAjeR7ArgzoEUjzvJcP+jH3TP3eI28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JiOpXpLX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF7AC4CEF5;
	Mon,  6 Oct 2025 10:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759746695;
	bh=cG36zcMsqBxk2WJ2EVZoOITToowjiuE8hiD3wFiNkKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JiOpXpLX1LOti/71X2UY6glPDDySKuuiLbKds+cJJHu0B1lKcZpieTyywhNJwGyE3
	 eXIQGEKdFFgQ955uRo8h9VPQr+NGSUISfwLhN7OpNU8QxYJebWD2rKAB2lWg30g1Ri
	 P21jCrkS0KGwVUGnoD6kECgMatJl7mnewiAo9TVuIfBiuY06ihWPPbrcGBXoDQhgy7
	 aJ2iIL5m4R+10hJD19JsyvaasBoEOSGFgBSLO7jUKzHX7s6kB23SaNYfwZEqp1qY5R
	 w4tWBg5qfQz6MgAlnVxmZ7nlZnn5JiNCz238vF5GWTJDh78sUjIbFVH/ADKbnJLcfB
	 hfDxUZ3MbpfNQ==
From: Christian Brauner <brauner@kernel.org>
To: Julian Sun <sunjunchao@bytedance.com>
Cc: Christian Brauner <brauner@kernel.org>,
	clm@fb.com,
	dsterba@suse.com,
	xiubli@redhat.com,
	idryomov@gmail.com,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jaegeuk@kernel.org,
	chao@kernel.org,
	willy@infradead.org,
	jack@suse.cz,
	agruenba@redhat.com,
	linux-fsdevel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-ext4@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] fs: Make wbc_to_tag() inline and use it in fs.
Date: Mon,  6 Oct 2025 12:30:44 +0200
Message-ID: <20251006-exhumieren-staub-bbd9b043162d@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250929111349.448324-1-sunjunchao@bytedance.com>
References: <20250929111349.448324-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2176; i=brauner@kernel.org; h=from:subject:message-id; bh=cG36zcMsqBxk2WJ2EVZoOITToowjiuE8hiD3wFiNkKw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ8nlX/0Jvr3gGB1U+cVD/bOZmZhZ/Zqn9B+WvB+U6zF KZpPi+Pd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwk+jAjw8qd51l/at8+xuU3 e0Hd3EPTu6JebI0xStikH9h9cJnw8ScM/2z/sHCHmyuJGqS7vu+vmb3+6kYehrkssi19t6seP1d 04gEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 29 Sep 2025 19:13:49 +0800, Julian Sun wrote:
> The logic in wbc_to_tag() is widely used in file systems, so modify this
> function to be inline and use it in file systems.
> 
> This patch has only passed compilation tests, but it should be fine.
> 
> 

Folding:

diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index dde77d13a200..1e60d463f226 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -196,6 +196,13 @@ static inline void wait_on_inode(struct inode *inode)
                       !(READ_ONCE(inode->i_state) & I_NEW));
 }

+static inline xa_mark_t wbc_to_tag(struct writeback_control *wbc)
+{
+       if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
+               return PAGECACHE_TAG_TOWRITE;
+       return PAGECACHE_TAG_DIRTY;
+}
+
 #ifdef CONFIG_CGROUP_WRITEBACK

 #include <linux/cgroup.h>
@@ -240,13 +247,6 @@ static inline void inode_detach_wb(struct inode *inode)
        }
 }

-static inline xa_mark_t wbc_to_tag(struct writeback_control *wbc)
-{
-       if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
-               return PAGECACHE_TAG_TOWRITE;
-       return PAGECACHE_TAG_DIRTY;
-}
-
 void wbc_attach_fdatawrite_inode(struct writeback_control *wbc,
                struct inode *inode);

since wbc_to_tag() cannot be conditional on cgroup writeback.

---

Applied to the vfs-6.19.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.19.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.19.misc

[1/1] fs: Make wbc_to_tag() inline and use it in fs.
      https://git.kernel.org/vfs/vfs/c/48b6926673f7

