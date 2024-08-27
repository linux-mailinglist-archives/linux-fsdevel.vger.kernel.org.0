Return-Path: <linux-fsdevel+bounces-27472-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3882961A5E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 01:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1159C1C22F87
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 23:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84AF1BF331;
	Tue, 27 Aug 2024 23:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFY6UqET"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A9519DF66;
	Tue, 27 Aug 2024 23:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724800510; cv=none; b=sBTb0FtiXvYDJ6C+KmK2NIim19V9u6hqhx8YpFN7qkk8Poz6rhZbebrvOmQjXnrA+N36UcD7772GW0h/IwPleXOWT9eRFCKp9I+BgFHdDTtBN2w/5tANSeTAGF0byZTKfhq3gKUfX/VEuf5j0crix8nOs6h7Tdk0MxeoazY30Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724800510; c=relaxed/simple;
	bh=OLsfW6fvwwy8Dz9CLI7k9MJrb2Yd+U5ZRIOjzC6OmmU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ATQw0wirYlZjuD6v1LUkKTGMIUt7JJ6C/i1nyHPpFQFoUijDb1xS59id4YxExcuDQXWNtYTg+vExc/6qsDatz5hIwIv4dFwMDFEgaP1ekkQ7cya/p1k+OP66q0+Ecl+lfMgQfBcGrJb2sD1gu9VYucLL/h+KiLcZEKxwmjPviPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFY6UqET; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04113C4AF10;
	Tue, 27 Aug 2024 23:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724800509;
	bh=OLsfW6fvwwy8Dz9CLI7k9MJrb2Yd+U5ZRIOjzC6OmmU=;
	h=From:Date:Subject:To:Cc:From;
	b=TFY6UqET2jHW3ySVqDhEZpJzR66XB3sJupscP3rEtROgdVefIKZF1xc/SfVlHKVNA
	 kvI6Jv8XUNBT2fk2Uu1/8cPadOxpSTbVL7PyhPBq8bg9C9/zRSszjHtxYs43eKv6/A
	 p/ZPDsQ1xtYNGdaHMNN+VRfmNtLdmfqp8mlTW39gez5uutvUeb1wkbsrnwThzQh3f/
	 Zf1+WlgAGpez9f1E2NbO95nx7uddQfXDRZnLMmo3G7Ea/3g0sbfcuZIiiHfhcg2EUd
	 RQk03FwrVLPWqO9mqWGZhuIFhxlyaN5NyV8R4KGR4rP3ydLIB9T1lJisYCsPVwyP0A
	 d3M7GKKUkEhNg==
From: Nathan Chancellor <nathan@kernel.org>
Date: Tue, 27 Aug 2024 16:15:05 -0700
Subject: [PATCH] xfs: Fix format specifier for max_folio_size in
 xfs_fs_fill_super()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240827-xfs-fix-wformat-bs-gt-ps-v1-1-aec6717609e0@kernel.org>
X-B4-Tracking: v=1; b=H4sIAPhdzmYC/x2MSQqAMAwAvyI5G7BV3L4iHmpNNQetNEUF8e8Wj
 wMz84BQYBLoswcCnSzs9wQqz8CuZl8IeU4MutBV0eoGbyfo+MbL+bCZiJPgEvEQ7OrGlcYoqyo
 NKT8CJe9fD+P7ftdr63NqAAAA
To: Christian Brauner <brauner@kernel.org>
Cc: Chandan Babu R <chandan.babu@oracle.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Pankaj Raghav <p.raghav@samsung.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Dave Chinner <dchinner@redhat.com>, 
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2458; i=nathan@kernel.org;
 h=from:subject:message-id; bh=OLsfW6fvwwy8Dz9CLI7k9MJrb2Yd+U5ZRIOjzC6OmmU=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDGnnYv9s2PmAqbtcZ97m+919PNYzbW88KWd5eLrNVq3+x
 CRNJruCjlIWBjEuBlkxRZbqx6rHDQ3nnGW8cWoSzBxWJpAhDFycAjCRxjaGX0xiz8s/VAgtig3O
 r+d6cfOKtGn88uAd4TZeh3hWfJef+4Phr2i6Q+LqhyG/VZMF7Pemf9ri6CjrZHtN4bqti5lOT/J
 kZgA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

When building for a 32-bit architecture, where 'size_t' is 'unsigned
int', there is a warning due to use of '%ld', the specifier for a 'long
int':

  In file included from fs/xfs/xfs_linux.h:82,
                   from fs/xfs/xfs.h:26,
                   from fs/xfs/xfs_super.c:7:
  fs/xfs/xfs_super.c: In function 'xfs_fs_fill_super':
  fs/xfs/xfs_super.c:1654:1: error: format '%ld' expects argument of type 'long int', but argument 5 has type 'size_t' {aka 'unsigned int'} [-Werror=format=]
   1654 | "block size (%u bytes) not supported; Only block size (%ld) or less is supported",
        | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1655 |                                 mp->m_sb.sb_blocksize, max_folio_size);
        |                                                        ~~~~~~~~~~~~~~
        |                                                        |
        |                                                        size_t {aka unsigned int}
  ...
  fs/xfs/xfs_super.c:1654:58: note: format string is defined here
   1654 | "block size (%u bytes) not supported; Only block size (%ld) or less is supported",
        |                                                        ~~^
        |                                                          |
        |                                                          long int
        |                                                        %d

Use the proper 'size_t' specifier, '%zu', to resolve the warning.

Fixes: 0ab3ca31b012 ("xfs: enable block size larger than page size support")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 fs/xfs/xfs_super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 242271298a33..e8cc7900911e 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1651,7 +1651,7 @@ xfs_fs_fill_super(
 
 		if (mp->m_sb.sb_blocksize > max_folio_size) {
 			xfs_warn(mp,
-"block size (%u bytes) not supported; Only block size (%ld) or less is supported",
+"block size (%u bytes) not supported; Only block size (%zu) or less is supported",
 				mp->m_sb.sb_blocksize, max_folio_size);
 			error = -ENOSYS;
 			goto out_free_sb;

---
base-commit: f143d1a48d6ecce12f5bced0d18a10a0294726b5
change-id: 20240827-xfs-fix-wformat-bs-gt-ps-967f3aa1c142

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


