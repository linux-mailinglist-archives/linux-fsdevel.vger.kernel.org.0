Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D78983E3B86
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Aug 2021 18:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbhHHQ0L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Aug 2021 12:26:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:47554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231933AbhHHQZh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Aug 2021 12:25:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4E7826103B;
        Sun,  8 Aug 2021 16:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628439918;
        bh=Y0Q6rt+tDWZMBi0N4PwxXpAY8aZOyLa7NpaJo/VUL6k=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Dvu/AnbAZPEBaBQPuIZJm8QvDcGhRBm08stqQ3DK71DNbQpFCFI7FwsrM2Eyo9xZZ
         j2lP4/wkv2OB6oYYR1OJ3+BfxNwQBt0tw4umUTB4NXXrekUqFgDqVx/vWKZVTExkB/
         rpUSKnx3NBChV1HNldnKnFY+0YYUPeWwlSJOH+GwQgiRjeFBA+zqDxVZoGjD8O5kh3
         HUU5nuvDle+bkxTt2ZJRYOkDcD0KQKr6eY5NF7N6vZdZ0gZOFJvNAhrKLlEmrXMqGD
         oOKj7wYpSMJZ+dqhTq3aNoePBFFfVjZJRPdM35CrNTCq5nNlKkUx7ZOQXciYfgUbQW
         Xe9HAz3pDKlcw==
Received: by pali.im (Postfix)
        id 0FB2B13DC; Sun,  8 Aug 2021 18:25:18 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     linux-fsdevel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        Anton Altaparmakov <anton@tuxera.com>,
        Pavel Machek <pavel@ucw.cz>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        Christoph Hellwig <hch@infradead.org>
Subject: [RFC PATCH 11/20] hfs: Explicitly set hsb->nls_disk when hsb->nls_io is set
Date:   Sun,  8 Aug 2021 18:24:44 +0200
Message-Id: <20210808162453.1653-12-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210808162453.1653-1-pali@kernel.org>
References: <20210808162453.1653-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
index 12d9bae39363..86bc46746c7f 100644
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
index 39f5e343bf4d..c75682c61b06 100644
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

