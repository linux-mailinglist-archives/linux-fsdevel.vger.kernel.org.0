Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9BE358AD2A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Aug 2022 17:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240760AbiHEPm6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Aug 2022 11:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiHEPm5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Aug 2022 11:42:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD46B27B0B;
        Fri,  5 Aug 2022 08:42:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48C99615C6;
        Fri,  5 Aug 2022 15:42:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF05EC4347C;
        Fri,  5 Aug 2022 15:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659714175;
        bh=xdSHWCs9h2K8wnnw4cbgM7/350sCkbahN/3I64zs7hI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KjSFSRsguTf+NTNBYo/0tq72++hnEeBhvVLCv3OzQlJN4jdRnozFGO3Q/SbFUWn7l
         DVJgWvAJXh5tFs3FijdltTqcvKHIPMBkRLiEIPFCcv4FqGZ0P1omKuuvhKQjvzlB1y
         LtEkB9GP+z7wQlB2WzlC4EF5lvTt4XZnG0DGA+ZLlwfkocNnZUIteYtwpgIgSv97sp
         gth4khhEYzPMOwIxzp7cQtaskiSlts9SYPJd53kE4m6KN07vqXZeFDrVFjMm7vJzhD
         bl9ZR+dKFELzpoOjEmhhzVb1DIf9Y94Am1QX+7OO3MVSGg1GHzpxJnbDS9b8NQAEe7
         9Qqx+XyCjA9jQ==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH v9 01/27] kallsyms: use `sizeof` instead of hardcoded size
Date:   Fri,  5 Aug 2022 17:41:46 +0200
Message-Id: <20220805154231.31257-2-ojeda@kernel.org>
In-Reply-To: <20220805154231.31257-1-ojeda@kernel.org>
References: <20220805154231.31257-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Boqun Feng <boqun.feng@gmail.com>

This removes one place where the `500` constant is hardcoded.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 scripts/kallsyms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index f18e6dfc68c5..52f5488c61bc 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -206,7 +206,7 @@ static struct sym_entry *read_symbol(FILE *in)
 
 	rc = fscanf(in, "%llx %c %499s\n", &addr, &type, name);
 	if (rc != 3) {
-		if (rc != EOF && fgets(name, 500, in) == NULL)
+		if (rc != EOF && fgets(name, sizeof(name), in) == NULL)
 			fprintf(stderr, "Read error or end of file.\n");
 		return NULL;
 	}
-- 
2.37.1

