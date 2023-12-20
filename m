Return-Path: <linux-fsdevel+bounces-6559-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D739B819812
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 06:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76AD81F25BE4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 05:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB5EFC04;
	Wed, 20 Dec 2023 05:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="VUURBVFN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFB0FBE1;
	Wed, 20 Dec 2023 05:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aTxmIqx/EoO7e4qwLoDzfnPzeeP6f7RKMsj+EAXwCHw=; b=VUURBVFNhoRoFNjjPWTrrTYZbW
	AB2yGrBEFYB/GI8AwFJyn1tXiF2BhV2WFNoZB937NoPsei5LH2J+qrAPVsHgm2lU3wyeWUIsomBni
	sbQCvyMwY4Zzx5vYhyG5I+ajcAzabRqzZ9PhDUYrgibJ8k3krKi+doUN+4dTc1iTQVPKabst8io9E
	PtOKI/0vjbtp0KDSJdQqi78pXdMuWRc0sCHb2z2x8JcJ5G+O3RGfAW0SUjhdVkV2pSljyj15ZY+Dt
	yvXXVz1AncI7vi18pnNFH/ZZ5g72l4Dzcm0xr19IWvMLe3Dd2MJsMPJXJvxe392BYC8BIBmJZnfYW
	8s07tEOg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rFp4h-00HJ4N-03;
	Wed, 20 Dec 2023 05:24:55 +0000
Date: Wed, 20 Dec 2023 05:24:54 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: [PATCH 12/22] ext4_add_entry(): ->d_name.len is never 0
Message-ID: <20231220052454.GK1674809@ZenIV>
References: <20231220051348.GY1674809@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220051348.GY1674809@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

That bogosity goes back to the initial merge of ext3.  Once upon a time
ext2 used to have a similar check; that got taken out during the switch
to page cache (June 2001).  ext3 got merged into mainline 5 months later,
still using buffer cache for directories; removal of the pointless check
in ext2 should've been done as a separate patch, but it hadn't been,
so that thing got missed...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ext4/namei.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index d252935f9c8a..fa8b8dd841b5 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2388,8 +2388,6 @@ static int ext4_add_entry(handle_t *handle, struct dentry *dentry,
 
 	sb = dir->i_sb;
 	blocksize = sb->s_blocksize;
-	if (!dentry->d_name.len)
-		return -EINVAL;
 
 	if (fscrypt_is_nokey_name(dentry))
 		return -ENOKEY;
-- 
2.39.2


