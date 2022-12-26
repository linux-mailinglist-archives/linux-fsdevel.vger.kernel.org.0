Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745AF65632B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Dec 2022 15:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbiLZOWo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Dec 2022 09:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiLZOWj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Dec 2022 09:22:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344736355;
        Mon, 26 Dec 2022 06:22:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9D3B60ECE;
        Mon, 26 Dec 2022 14:22:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3ACBC4339B;
        Mon, 26 Dec 2022 14:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672064531;
        bh=e4FwSq1/2Vygd9UHJiO4l6thoqlGGbMWoa45GXTb6aQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=bXPSBq/bP7mDyKk/wd7W2JTWVlPXVT2RboTFlj9iSVPG35ulA+hgbCALFNyvoXpAK
         Yzx7mAKXyDpUHW94zb7wQL8yTchXrjXuuat00MS5ai8YUUD0012uIT4a5QiKrben11
         NiCBuc4j+WeR06kzqsy28JXcIIE6y+D28+aE+zwpIREYdOSEgPGowa1iHU/YDo8dzW
         EDUPDrgHTcuWSdij1wFlpD7SH5tOX3XQmKdIqRVayV6bWYMjfxjNz2Z7B7fMS4XACc
         N5+iICo51y3MEYVCT6SMx5h1Hb+Klz6/2ZgMj20wf0bPyTD31iHliqfFx2bD/geecu
         dLKaXbfGnsmnw==
Received: by pali.im (Postfix)
        id 8CD359D7; Mon, 26 Dec 2022 15:22:10 +0100 (CET)
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
Subject: [RFC PATCH v2 09/18] hfs: Explicitly set hsb->nls_disk when hsb->nls_io is set
Date:   Mon, 26 Dec 2022 15:21:41 +0100
Message-Id: <20221226142150.13324-10-pali@kernel.org>
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

It does not make any sense to set hsb->nls_io (NLS iocharset used between
VFS and hfs driver) when hsb->nls_disk (NLS codepage used between hfs
driver and disk) is not set.

Reverse engineering driver code shown what is doing in this special case:

    When codepage was not defined but iocharset was then
    hfs driver copied 8bit character from disk directly to
    16bit unicode wchar_t type. Which means it did conversion
    from Latin1 (ISO-8859-1) to Unicode because first 256
    Unicode code points matches 8bit ISO-8859-1 codepage table.
    So when iocharset was specified and codepage not, then
    codepage used implicit value "iso8859-1".

So when hsb->nls_disk is not set and hsb->nls_io is then explicitly set
hsb->nls_disk to "iso8859-1".

Such setup is obviously incompatible with Mac OS systems as they do not
support iso8859-1 encoding for hfs. So print warning into dmesg about this
fact.

After this change hsb->nls_disk is always set, so remove code paths for
case when hsb->nls_disk was not set as they are not needed anymore.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 fs/hfs/super.c | 31 +++++++++++++++++++++++++++++++
 fs/hfs/trans.c | 38 ++++++++++++++------------------------
 2 files changed, 45 insertions(+), 24 deletions(-)

diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index 6764afa98a6f..cea19ed06bce 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -351,6 +351,37 @@ static int parse_options(char *options, struct hfs_sb_info *hsb)
 		}
 	}
 
+	if (hsb->nls_io && !hsb->nls_disk) {
+		/*
+		 * Previous version of hfs driver did something unexpected:
+		 * When codepage was not defined but iocharset was then
+		 * hfs driver copied 8bit character from disk directly to
+		 * 16bit unicode wchar_t type. Which means it did conversion
+		 * from Latin1 (ISO-8859-1) to Unicode because first 256
+		 * Unicode code points matches 8bit ISO-8859-1 codepage table.
+		 * So when iocharset was specified and codepage not, then
+		 * codepage used implicit value "iso8859-1".
+		 *
+		 * To not change this previous default behavior as some users
+		 * may depend on it, we load iso8859-1 NLS table explicitly
+		 * to simplify code and make it more reable what happens.
+		 *
+		 * In context of hfs driver it is really strange to use
+		 * ISO-8859-1 codepage table for storing data to disk, but
+		 * nothing forbids it. Just it is highly incompatible with
+		 * Mac OS systems. So via pr_warn() inform user that this
+		 * is not probably what he wants.
+		 */
+		pr_warn("iocharset was specified but codepage not, "
+			"using default codepage=iso8859-1\n");
+		pr_warn("this default codepage=iso8859-1 is incompatible with "
+			"Mac OS systems and may be changed in the future");
+		hsb->nls_disk = load_nls("iso8859-1");
+		if (!hsb->nls_disk) {
+			pr_err("unable to load iso8859-1 codepage\n");
+			return 0;
+		}
+	}
 	if (hsb->nls_disk && !hsb->nls_io) {
 		hsb->nls_io = load_nls_default();
 		if (!hsb->nls_io) {
diff --git a/fs/hfs/trans.c b/fs/hfs/trans.c
index fdb0edb8a607..dbf535d52d37 100644
--- a/fs/hfs/trans.c
+++ b/fs/hfs/trans.c
@@ -48,18 +48,13 @@ int hfs_mac2asc(struct super_block *sb, char *out, const struct hfs_name *in)
 		wchar_t ch;
 
 		while (srclen > 0) {
-			if (nls_disk) {
-				size = nls_disk->char2uni(src, srclen, &ch);
-				if (size <= 0) {
-					ch = '?';
-					size = 1;
-				}
-				src += size;
-				srclen -= size;
-			} else {
-				ch = *src++;
-				srclen--;
+			size = nls_disk->char2uni(src, srclen, &ch);
+			if (size <= 0) {
+				ch = '?';
+				size = 1;
 			}
+			src += size;
+			srclen -= size;
 			if (ch == '/')
 				ch = ':';
 			size = nls_io->uni2char(ch, dst, dstlen);
@@ -119,20 +114,15 @@ void hfs_asc2mac(struct super_block *sb, struct hfs_name *out, const struct qstr
 			srclen -= size;
 			if (ch == ':')
 				ch = '/';
-			if (nls_disk) {
-				size = nls_disk->uni2char(ch, dst, dstlen);
-				if (size < 0) {
-					if (size == -ENAMETOOLONG)
-						goto out;
-					*dst = '?';
-					size = 1;
-				}
-				dst += size;
-				dstlen -= size;
-			} else {
-				*dst++ = ch > 0xff ? '?' : ch;
-				dstlen--;
+			size = nls_disk->uni2char(ch, dst, dstlen);
+			if (size < 0) {
+				if (size == -ENAMETOOLONG)
+					goto out;
+				*dst = '?';
+				size = 1;
 			}
+			dst += size;
+			dstlen -= size;
 		}
 	} else {
 		char ch;
-- 
2.20.1

