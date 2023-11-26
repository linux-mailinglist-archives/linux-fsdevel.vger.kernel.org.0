Return-Path: <linux-fsdevel+bounces-3839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2407F91FF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Nov 2023 10:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3F1CB20D83
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Nov 2023 09:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C92563C1;
	Sun, 26 Nov 2023 09:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTTgk7Ld"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8157620FA
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 Nov 2023 09:32:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71729C433C8;
	Sun, 26 Nov 2023 09:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700991122;
	bh=kzOm4T5DQRo3m3khJBJM7ZAsL5ba6KTOOYLrNx3WQG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KTTgk7LdnbjjwX5DMNrhsOggctOhsICRJgnqjc/ZdxFRnRJdQh3OuxaDCsANiVY8n
	 +kKgW5FZ5AH/qKvKEW0wsZc9flinUOnEsvjOZ6eHnY8P3QLMgrlyyhGMilsVSeC1qT
	 Q4d/afmq6k+jV2/qAiN27QjXlvdAhBRl1D22/X835cS4Mum/ifmJPgS0+aZV50TK0i
	 3gFVzHUe8IjpdPEVljJUyh7m78SsHvchux5TDV1rXcmzC0VL1N42q0ENhovuRxPIgT
	 oRGucTxT1mM6pIcOGAkyG8oCYqzDzTkDGpXgQ5cwWADTlbTaPB5KvXIzzEuqBsNaWW
	 nv1ia+TYnVXHg==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH] simpler way to get benefits of "vfs: shave work on failed file open"
Date: Sun, 26 Nov 2023 10:31:22 +0100
Message-ID: <20231126-nachrangig-ziegen-76265f8c798b@brauner>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231126020834.GC38156@ZenIV>
References: <20231126020834.GC38156@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2075; i=brauner@kernel.org; h=from:subject:message-id; bh=qsHy75k1WyUXlb1IotrXC2AksfKKSZAp1O0ixUvT0SM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQmC2S+WrOUla/XfMnp/5UPN63b/uPHDq9NT5o0c5wXr c9xeGgQ0lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRhJsM/0sb+zZO4b00bTKX XLvMkenlFT0bd85YdPNZ4gE5k8MZMb8YGQ48PBs+Nd9Y90t2h8vtpg8sZo0/u8qf3pppp9z8/38 CMxcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sun, 26 Nov 2023 02:08:34 +0000, Al Viro wrote:
> IMO 93faf426e3cc "vfs: shave work on failed file open" had gone overboard -
> avoiding an RCU delay in that particular case is fine, but it's done on
> the wrong level.  A file that has never gotten FMODE_OPENED will never
> have RCU-accessed references, its final fput() is equivalent to file_free()
> and if it doesn't have FMODE_BACKING either, it can be done from any context
> and won't need task_work treatment.
> 
> [...]

Fwiw, you had a typo in their so I folded the fixup below into it and
tweaked the commit message. The cleanup is good.

diff --git a/fs/file_table.c b/fs/file_table.c
index 7bcfa169dd45..6deac386486d 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -433,8 +433,8 @@ void fput(struct file *file)
        if (atomic_long_dec_and_test(&file->f_count)) {
                struct task_struct *task = current;

-               if (unlikely(!(f->f_mode & (FMODE_BACKING | FMODE_OPENED)))) {
-                       file_free(f);
+               if (unlikely(!(file->f_mode & (FMODE_BACKING | FMODE_OPENED)))) {
+                       file_free(file);
                        return;
                }
                if (likely(!in_interrupt() && !(task->flags & PF_KTHREAD))) {

---

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] file: massage cleanup of files that failed to open
      https://git.kernel.org/vfs/vfs/c/4d6fdbf44ad8

