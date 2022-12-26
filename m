Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB08D656312
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Dec 2022 15:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbiLZOWK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Dec 2022 09:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbiLZOWG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Dec 2022 09:22:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6B91140;
        Mon, 26 Dec 2022 06:22:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0F4560EB4;
        Mon, 26 Dec 2022 14:22:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F842C433D2;
        Mon, 26 Dec 2022 14:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672064525;
        bh=22S317lWg8AbLm/4T86Rzeza0QVf8ZdO+6YLdtwviT0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=E4k5OXvypcw8JKWNx6C4dSUgCG2CsGTlxUbLraGkrXVSvF8AMAD7gX7KnyZDbc3uX
         ZsNzjvKiPxDxG+oR5TopbMGilH1sUH3bokqsnBHlqzkz4AQKh7/B9WXFNeej/reQya
         dU1Mnq6X+mGX9sykpmVkUki7ScBWs84ONjlv1qoJm0t7e79xu6cZNjMWpFMdd3vkwz
         UjJRhFH5fv+TqT8wdZI5Tw/E6K/zVf0vNVX4NLda6wj+29s3ruxs9Tya/z86tEjBE+
         rwVylYF+UiX3jen7J7X3chKLADzrU7lT2hxuBJSNwCHwCwa6bpWJSQgoDQpm+LrrLt
         Mb4naxRegkZ+g==
Received: by pali.im (Postfix)
        id DED229D7; Mon, 26 Dec 2022 15:22:04 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     linux-fsdevel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, "Theodore Y . Ts'o" <tytso@mit.edu>,
        Anton Altaparmakov <anton@tuxera.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>, Dave Kleikamp <shaggy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Machek <pavel@ucw.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Kari Argillander <kari.argillander@gmail.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH v2 04/18] ntfs: Fix error processing when load_nls() fails
Date:   Mon, 26 Dec 2022 15:21:36 +0100
Message-Id: <20221226142150.13324-5-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221226142150.13324-1-pali@kernel.org>
References: <20221226142150.13324-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ensure that specified charset in iocharset= mount option is used. On error
correctly propagate error code back to the caller.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 fs/ntfs/super.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 55762abdc22a..b4f26035e750 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -94,7 +94,7 @@ static bool parse_options(ntfs_volume *vol, char *opt)
 	umode_t fmask = (umode_t)-1, dmask = (umode_t)-1;
 	int mft_zone_multiplier = -1, on_errors = -1;
 	int show_sys_files = -1, case_sensitive = -1, disable_sparse = -1;
-	struct nls_table *nls_map = NULL, *old_nls;
+	struct nls_table *nls_map = NULL;
 
 	/* I am lazy... (-8 */
 #define NTFS_GETOPT_WITH_DEFAULT(option, variable, default_value)	\
@@ -195,20 +195,12 @@ static bool parse_options(ntfs_volume *vol, char *opt)
 			if (!v || !*v)
 				goto needs_arg;
 use_utf8:
-			old_nls = nls_map;
+			unload_nls(nls_map);
 			nls_map = load_nls(v);
 			if (!nls_map) {
-				if (!old_nls) {
-					ntfs_error(vol->sb, "NLS character set "
-							"%s not found.", v);
-					return false;
-				}
-				ntfs_error(vol->sb, "NLS character set %s not "
-						"found. Using previous one %s.",
-						v, old_nls->charset);
-				nls_map = old_nls;
-			} else /* nls_map */ {
-				unload_nls(old_nls);
+				ntfs_error(vol->sb, "NLS character set "
+					   "%s not found.", v);
+				return false;
 			}
 		} else if (!strcmp(p, "utf8")) {
 			bool val = false;
-- 
2.20.1

