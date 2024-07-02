Return-Path: <linux-fsdevel+bounces-22983-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 426DD924BB1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 00:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 491A9B24313
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 22:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21928155A30;
	Tue,  2 Jul 2024 22:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHxIllVL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC9112FF8F;
	Tue,  2 Jul 2024 22:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719960300; cv=none; b=myFom1WLPg/h1ioFCICZp43hT1RCQf6raskBDf7NEvNf0e9vX52538sl56Cv/QM+f1Iney162Gu3QYixMhu8iPV1tESZi1sn3gBBDOatLQRF59xDXIGpJVelgK9lr3iksSZW2U3oRlTdn5dRY7lCnQ5yny1hBp+vYi7y2ToWS6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719960300; c=relaxed/simple;
	bh=N9gkNN597b9sR0qa3FEqcM+w+j2TQMy5ad+/Ia1JOuA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nWegRaC3OsWnFhsJUEBmMZppWyCVw8d4cDJJqCdQgbWyoQg10IrHYXsGZuB3rgONBXXiaF1kSl5kLyc0dzeqwRO2s86n0iIhsbi56L3OMjs+ZkX9ltsJMyEzobTYMAs5tzWuesNqgK/m9bHtGX40FJX4Mffk1/DBM9LPWEjCl7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHxIllVL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A56C116B1;
	Tue,  2 Jul 2024 22:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719960300;
	bh=N9gkNN597b9sR0qa3FEqcM+w+j2TQMy5ad+/Ia1JOuA=;
	h=From:Date:Subject:To:Cc:From;
	b=fHxIllVLyhXeUzrrqgBSxZaqdLY4X/Ny3uM6gnugxlqFmhRRW+L6yAtk4aSb/jusO
	 sUEOi3jp4fSqxFEm/7DSadrIGxOva0mgShM2tGwFNIjqs1rN519+FSx/TAuOAD6hCh
	 +MO9xXKwOOm3+meX6HGfNkTkmRHty+Ya9yu5hbkStr1kUL3EmjE70fgOUd26hoyZOw
	 Oq6KnwDL4N3etWPQ9Uyf6y3ngGQ6yMybAvJgjiHMRlw2KE+zUEwped5FXWqNy0i37r
	 YSt8feEeKdibzUVJNEIFRHgCgvoYHIaywre0ZO/J57PdPF77eCWPXAnOaF2LKVwTAo
	 qbPR3xWaR6QTQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 02 Jul 2024 18:44:48 -0400
Subject: [PATCH] filelock: fix potential use-after-free in posix_lock_inode
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240702-filelock-6-10-v1-1-96e766aadc98@kernel.org>
X-B4-Tracking: v=1; b=H4sIAN+ChGYC/x3MQQqAIBBA0avIrBuY1Aq6SrQQG2soKhQiEO+et
 HyL/zMkjsIJRpUh8iNJrrOibRT4zZ0royzVoElbGkhjkIOPy+/YY0togiPyzgbuDNTmjhzk/X/
 TXMoH6WIooV8AAAA=
To: Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 =?utf-8?q?Light_Hsieh_=28=E8=AC=9D=E6=98=8E=E7=87=88=29?= <Light.Hsieh@mediatek.com>, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1398; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=N9gkNN597b9sR0qa3FEqcM+w+j2TQMy5ad+/Ia1JOuA=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmhILqZlQ+jSGuftugdfRgVXDYEoT/mrJY9prPk
 nxSHoES/ICJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZoSC6gAKCRAADmhBGVaC
 FU1sEACqh3qt+ZjTufAOay8j1Wmhc3HGHy7QZd/s81V9UE/vLuINRtRe3ZthoaMhHZP0VGkkqf8
 7G0hyIjvJTRedRVBSSMdMRKzNq1QvsIlNWWP/KSRUAfF3jlUSlql5PzS3nC2FIpaP3KT9h+KWG6
 a65s+/AL1gWte8ADd6CBhU9lo6gOFh51KP3nwJa1+axZHtO4uTzMLBzY/1HUV8W/l3oxZmzKU5J
 hqwaNIGlv64CDr/pY7XGqDYjFN0e16D6q9lNeBI6UdKk1zj9HLtRKKeFXyFXnmfiBCd/iwrudeJ
 PLtHACyGDG5oohrdXFut5zDhJBiYb0oNITnpBkcf/lj+7zwdxQG7zXEDb/7fIOYHs/CFXFENI0o
 QvXQ3CYbSaEjXICClQ26OFW4M4KTD31DlMosoLUz/e9JAlwFkBGJuKt4UbUbLIBu9htT4SOU3Mh
 tmCeDN9cAW8BMxvI9L5JJ/nTx6m0GyAG5qUexbAdpWvCke4rD8oc+0ToE5zi2DpoFmAB7U0fff6
 Ek4/rqJCyoLfDoC0/ArjRuErm3mVJtDS4pDixLbkjtY+NJLno3hbCHGuya2OiQfQnsMMm4Fxca6
 FdHNRQlYxkQqefOPO/ZhKUcStv/BcDBm2aCKAOuE3bSiW1w1e3VrGAezwgHvPXgMdDdzgFpE5hf
 pffpExgn/VgI2ng==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Light Hsieh reported a KASAN UAF warning in trace_posix_lock_inode().
The request pointer had been changed earlier to point to a lock entry
that was added to the inode's list. However, before the tracepoint could
fire, another task raced in and freed that lock.

Fix this by moving the tracepoint inside the spinlock, which should
ensure that this doesn't happen.

Fixes: 74f6f5912693 ("locks: fix KASAN: use-after-free in trace_event_raw_event_filelock_lock")
Link: https://lore.kernel.org/linux-fsdevel/724ffb0a2962e912ea62bb0515deadf39c325112.camel@kernel.org/
Reported-by: Light Hsieh (謝明燈) <Light.Hsieh@mediatek.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/locks.c b/fs/locks.c
index c360d1992d21..bdd94c32256f 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1367,9 +1367,9 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 		locks_wake_up_blocks(&left->c);
 	}
  out:
+	trace_posix_lock_inode(inode, request, error);
 	spin_unlock(&ctx->flc_lock);
 	percpu_up_read(&file_rwsem);
-	trace_posix_lock_inode(inode, request, error);
 	/*
 	 * Free any unused locks.
 	 */

---
base-commit: e9d22f7a6655941fc8b2b942ed354ec780936b3e
change-id: 20240702-filelock-6-10-3fa00ca4fe53

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


