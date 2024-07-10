Return-Path: <linux-fsdevel+bounces-23524-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 268C992DC24
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 00:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7BAA1C20CB2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 22:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7751F14BF8F;
	Wed, 10 Jul 2024 22:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/z9Zref"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC121411ED;
	Wed, 10 Jul 2024 22:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720652231; cv=none; b=WzotpX10NGds/AwoIT79sAsRu+2K5sZ9VnU3xYM0muIsJ7pfjYzcwlYK+nPjcjhTBPWjtI9GOCJi7LJSVQJuxLcMp4hxXlTVCrIUY1rcMhd5t/RvzBfavehjKze07FRZRycd6GVL4QTcF4VouJueyNXDs4F7aHvRWwq/AmSbHIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720652231; c=relaxed/simple;
	bh=VeZ0jAlaOsuBLB4942xy+6Tdi45diUS3vYZtSDLxNj4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pSbam9BPbGIaegrl26H+drZNLiRCsvfxDJ2Q2wsTqR9ArGv63x3f8N7GQpMvkawMpzK961AhjfWSz1tyngBW8ES7QNjj6SJENL5SvmYAdvl8S4tgqVP6tUYX+SBYbCYh5tUroIV8mk9aHFTGoAVLsBSvEEan4U7JCmU7Dhxkyyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/z9Zref; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 638E2C32781;
	Wed, 10 Jul 2024 22:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720652231;
	bh=VeZ0jAlaOsuBLB4942xy+6Tdi45diUS3vYZtSDLxNj4=;
	h=From:To:Cc:Subject:Date:From;
	b=I/z9ZrefHG6DopScp1g3VYpy8Ybu/7Z8w9LDsvHKRnQ0XX3+gzpvwTJTSrzzBwsHN
	 26ZWRDvFGaKjjOkzqQfML6uwBgd6g4SH9elf0VpMiyQI94Ij8szfTiDY1arbG/t5q2
	 rLbKeMN+YAOg6jv+83g50lUKD73E8VVJOHqCCG40hxHCG/uHwqYciBJAEIiFgGnz1D
	 zcX3GCXZQF/Rb2nLi7d7Iwml8qV0YrkYdK2Fg5cKtW/dFP3Q0D+9HcYUvi2ulkOCol
	 JtC9IzU7LZTVeImnIalb0iFAUch5VTFevAh+gzDbbmBlyeauO8sH3EkXlIHPfIE5ZN
	 P/rbWZmKti2vg==
From: Kees Cook <kees@kernel.org>
To: David Sterba <dsterba@suse.com>
Cc: Kees Cook <kees@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] fs/affs: struct affs_head: Replace 1-element array with flexible array
Date: Wed, 10 Jul 2024 15:57:09 -0700
Message-Id: <20240710225709.work.175-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=834; i=kees@kernel.org; h=from:subject:message-id; bh=VeZ0jAlaOsuBLB4942xy+6Tdi45diUS3vYZtSDLxNj4=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmjxHF5Ez54HZBFkF2f/07ZPqU5USXhLL8SAxk/ 0rxhGyYZD+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZo8RxQAKCRCJcvTf3G3A Jtf8D/43Y6ayx7bY9+1DmlCjUHDtsXceewBTMcCCXX36yi3ToaLh5FtBCQbCC3lSbhbH8U1Pi7d rVkYmNNoryQutUY0wXwHICfZYs+DrDC8ovpJpE/rMJqCxdMNvNo76YXELXh0nZVSOU+Yko0SGfm vuCLHskl9Yut2kfqXRO6jSTflXdQL+6YUURFzfrcjca2FPv64X/+MvpDkuLcES4HGW3ynUE5LYs i5ABgAJ03L9s6grl1mS/8EK85IAZOgKsPAN9NEOHj6f4EY8hS9GEHFZJoxuPz+CC44BiW1wZl/d DJysOkVdk1l4ZGTYF1WvjWlfJq7wmsJIvpBwxa77T7H+FYEjAPeoHMMvSRr2Iba7ZZbiPdrHd5d 6lg7PqLTu1T2rNnL5CfesfN8SmizMCo/2EHtXh/GXPTmpSNYLzkyWZgR66OeB6/i2/gpi6H7l/L lNaJ11tEGkNN+GDXRh65y6/eKJZD8F5aVP3iNp28pWgQiDBcMgXtpTGml9rzabxo1JsB0QouxwT pGGwB73bZVkrSYdxT/r9Qi94u0FDQrZ6J1Zm/rdwvRfAUKDWcna1fu/ZBNGj1D+rwZ/0K8I0LD0 yuFOUbIV5xwQrP3GthdDiP6KG8SlSsqHznC4u2JqKTj48J5y6l4JnPw/8tCivN1Mh/JK9u3uidr tg2xhxFWWI7ydn
 Q==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

AFFS uses struct affs_head's "table" array as a flexible array. Switch
this to a proper flexible array[1]. There are no sizeof() uses; struct
affs_head is only ever uses via direct casts. No binary output
differences were found after this change.

Link: https://github.com/KSPP/linux/issues/79 [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: David Sterba <dsterba@suse.com>
Cc: linux-fsdevel@vger.kernel.org
---
 fs/affs/amigaffs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/affs/amigaffs.h b/fs/affs/amigaffs.h
index 5509fbc98bc0..09dc23a644df 100644
--- a/fs/affs/amigaffs.h
+++ b/fs/affs/amigaffs.h
@@ -80,7 +80,7 @@ struct affs_head {
 	__be32 spare1;
 	__be32 first_data;
 	__be32 checksum;
-	__be32 table[1];
+	__be32 table[];
 };
 
 struct affs_tail {
-- 
2.34.1


