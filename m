Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9551776933E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 12:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjGaKhV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 06:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbjGaKhU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:37:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE5A116;
        Mon, 31 Jul 2023 03:37:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5254161010;
        Mon, 31 Jul 2023 10:37:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D215C433CA;
        Mon, 31 Jul 2023 10:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690799838;
        bh=lJ7MT4bJu2hu3urRd/Dbw246g9KASNJ/qHtB4F8RXmQ=;
        h=From:Date:Subject:To:Cc:From;
        b=tISq/f6v43e3jjDYLST9tQBKzSkvT6rZZX3CIh1tQsKXQETYs2Psdq/oJn4Izx3aC
         HAYS2xyqB06hectAasWILRxyX+QHk0UiUgtrDeAuGGEfhu/0msy5/aejrGTVY31ol+
         mwzM3KrpBPVURfkrtIo+PSLHnU6DZAyObGrEAyOgEqY8EwvhPLP3wYOHxlFGz0rdHF
         T+kUuyvD/fNsKNd0w+h53JaBkW3Zpr1YfhTTM208nBRVfGsPoDlN4rrmR1gBnqF6+d
         41oyrnIbjJ4fEoRS3DyR2emCuu17pMZpzVEoG9xmbxJgMSMNZExo+j6jMx5ysQycPz
         AOKC0n9sty0Tw==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Mon, 31 Jul 2023 06:37:10 -0400
Subject: [PATCH] fs: fix request_mask variable in generic_fillattr
 kerneldoc comment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230731-mgctime-v1-1-1aa1177841ed@kernel.org>
X-B4-Tracking: v=1; b=H4sIANWOx2QC/2XMQQ7CIBCF4as0sxYzoER05T1MFxamdKIFAw3RN
 Nxd7Nbl//LyrZApMWW4dCskKpw5hhZy14Gd7sGTYNcaFKoDnpQRs7cLzyQ0IVkkcx7wCO39SjT
 ye5NufeuJ8xLTZ4OL/K3/RpFCCj2gc1a7EQ1dH5QCPfcxeehrrV9rABDUnwAAAA==
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1213; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=lJ7MT4bJu2hu3urRd/Dbw246g9KASNJ/qHtB4F8RXmQ=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBkx47dZqxZqKAsq3dR+RDaPXQoZW/P0bPFs17zP
 d2ivCmQ1tCJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZMeO3QAKCRAADmhBGVaC
 FWrZD/9JHoNFKPIdUfkqOjNKpk3LAuraEW3w9gUJAJ4IxkHaIMNpRot4fn6p9Mp9bRY1rmnhuh1
 L45oSgbZLDlqbPf+ZghDl/m0+CcG6UsUErh6s7yOleaHpuocb30axGZ09rt8JAym9QgtjJWL4s2
 wNXb+Dc56xcrgY78bqmMKrWaqmEB/JvaR+n9DrjCtvyXph9qWLouE0/cafQ0KA03KZJGYsrZBzU
 aQFSGpghriTxu7Ii3APqsIrdVOeU+tSbQJyXsu3YxW0onx7ShrTp5tJ2n7xC3mqYl6A0ON/pK6j
 if3Gk4B2/UCIQOerikNCyC/UuRexDeagtpqIv0ja7UD4eimz0/cNo4FzVSzbQdVzUSxjnt8HHeG
 YcKxJ1tA6mIbgfJs2IBUrfdSc6/YX/Sr7YIJ3j5rGM5SLteMnLdK62qhi7pOAJqXjYs/p0Ees/N
 3yHP5yUlyXLPOx34pfzFGJGepWNx1eECtrSNrU5y83Pz8pZvjCq2ss2+VzE8h/RAPIle9s9NMen
 fAfT+nk/TE6Xqb9T2iVefakxwtvv2dZAI5VzKCRYVWw5EITqyTQEBbDbn1TGinCTfBNWOiDeCwN
 3lxeIT5v6fy3yHriVftzOcu1I9G+qFxLg3DOQcYNc+3yF0cjGOHBlIoj1CTnyCwwJ6wPpmbJQOl
 jEm7ZbfSq3Hl9Zg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

req_mask -> request_mask

Fixes: 0a6ab6dc6958 ("fs: pass the request_mask to generic_fillattr")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/stat.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/stat.c b/fs/stat.c
index 51effd1c2bc2..592b62d577b6 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -59,10 +59,10 @@ EXPORT_SYMBOL(fill_mg_cmtime);
 
 /**
  * generic_fillattr - Fill in the basic attributes from the inode struct
- * @idmap:	idmap of the mount the inode was found from
- * @req_mask	statx request_mask
- * @inode:	Inode to use as the source
- * @stat:	Where to fill in the attributes
+ * @idmap:		idmap of the mount the inode was found from
+ * @request_mask	statx request_mask
+ * @inode:		Inode to use as the source
+ * @stat:		Where to fill in the attributes
  *
  * Fill in the basic attributes in the kstat structure from data that's to be
  * found on the VFS inode structure.  This is the default if no getattr inode

---
base-commit: dec705a2d44a306ca3502dd34ccfe8d8ffd79537
change-id: 20230728-mgctime-5e0ec0e89b04

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>

