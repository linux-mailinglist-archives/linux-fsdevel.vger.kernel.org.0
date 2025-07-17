Return-Path: <linux-fsdevel+bounces-55396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3BEB0989A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49D9A1893305
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2067A4503B;
	Thu, 17 Jul 2025 23:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JG/LC4fH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6F721018A;
	Thu, 17 Jul 2025 23:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752796064; cv=none; b=kHNSyj3H5JqMJ3Sdlia0VroQhDqTjWpjngTRpvXggNrngxcu0GM2+zPqaizZ90dDzMVp0yqbOEAy3CsRjl7C/uCet1vfiF8r5zfJqkB1CreuvqorOGAeYLrY/3jLT4bzYxwL9jryqKLniUK5pfjyO1l42nH94auZlv9bsDeaLwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752796064; c=relaxed/simple;
	bh=zftvLfLay+G5BZ6KUBJMOoHsi88pG8fVeiuvEyUVh6o=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dY/yDFQjfmBWZei1IqZ+BgnjunlkMvccrMQrNEBtaSBsdTjALlM7Y57cQc4floyJNmvbfIXM8VIVF345/1a4xhrR7a3M3Gd0qR7BZchYSSu+KZ8jr7fgbAAShPpYF0Qe9yENVZ4cnkSj5xn352NH3tSAo2eBn/XnnG4Jy8tu24g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JG/LC4fH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5374BC4CEE3;
	Thu, 17 Jul 2025 23:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752796064;
	bh=zftvLfLay+G5BZ6KUBJMOoHsi88pG8fVeiuvEyUVh6o=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=JG/LC4fHHl3g8kgx5w3xx/SK6c1Y9ngGub44HG9Enp+97Nea2I3xbsZS7hCmBwb1U
	 ixxhw59KwqmyZMYjmNUhEhJYfvxmKsA1LMXLiQL2OkLwwXME8Ovolmthpg2drtsurL
	 MQpXtmzyV8btM2cqckubwnk3lM4BSmdPphLn2HIAdRKDGcRzvxJV4JofeNYEn2UNjT
	 H3209/0VDicoAU1TGvkT3wzBup1LosiSBjzcnE8jJhGl9ECuQW4ksgLdMUb+iuceaK
	 xWr77r9CCGOF47DRFDGYHKYVjo3tCT1sEcDVHa79WKQxU5Vj+hjRsEazoUqMz5Tctl
	 jccRiAiGzLWyA==
Date: Thu, 17 Jul 2025 16:47:43 -0700
Subject: [PATCH 09/10] fuse2fs: skip the gdt write in op_destroy if syncfs is
 working
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: joannelkoong@gmail.com, miklos@szeredi.hu, John@groves.net,
 linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, linux-ext4@vger.kernel.org,
 neal@gompa.dev
Message-ID: <175279461882.716436.17411002969175844004.stgit@frogsfrogsfrogs>
In-Reply-To: <175279461680.716436.11923939115339176158.stgit@frogsfrogsfrogs>
References: <175279461680.716436.11923939115339176158.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

As an umount-time performance enhancement, don't bother to write the
group descriptor tables in op_destroy if we know that op_syncfs will do
it for us.  That only happens if iomap is enabled.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 66baca72ad49d1..3bded0fdd21e2a 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -263,6 +263,7 @@ struct fuse2fs {
 	uint8_t noblkdev;
 	uint8_t can_hardlink;
 	uint8_t iomap_passthrough_options;
+	uint8_t write_gdt_on_destroy;
 
 	enum fuse2fs_opstate opstate;
 	int blocklog;
@@ -1212,9 +1213,11 @@ static void op_destroy(void *p EXT2FS_ATTR((unused)))
 		if (fs->super->s_error_count)
 			fs->super->s_state |= EXT2_ERROR_FS;
 		ext2fs_mark_super_dirty(fs);
-		err = ext2fs_set_gdt_csum(fs);
-		if (err)
-			translate_error(fs, 0, err);
+		if (ff->write_gdt_on_destroy) {
+			err = ext2fs_set_gdt_csum(fs);
+			if (err)
+				translate_error(fs, 0, err);
+		}
 
 		err = ext2fs_flush2(fs, 0);
 		if (err)
@@ -5129,6 +5132,15 @@ static int op_syncfs(const char *path)
 		}
 	}
 
+	/*
+	 * When iomap is enabled, the kernel will call syncfs right before
+	 * calling the destroy method.  If any syncfs succeeds, then we know
+	 * that there will be a last syncfs and that it will write the GDT, so
+	 * destroy doesn't need to waste time doing that.
+	 */
+	if (fuse2fs_iomap_enabled(ff))
+		ff->write_gdt_on_destroy = 0;
+
 out_unlock:
 	fuse2fs_finish(ff, ret);
 	return ret;
@@ -6631,6 +6643,7 @@ int main(int argc, char *argv[])
 		.iomap_dev = FUSE_IOMAP_DEV_NULL,
 #endif
 		.can_hardlink = 1,
+		.write_gdt_on_destroy = 1,
 	};
 	errcode_t err;
 	FILE *orig_stderr = stderr;


