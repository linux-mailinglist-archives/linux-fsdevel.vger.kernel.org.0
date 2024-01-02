Return-Path: <linux-fsdevel+bounces-7119-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D315821D4C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 15:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E56C7283A9C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 14:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB13510785;
	Tue,  2 Jan 2024 14:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jBAKOIba"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F51156DB
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jan 2024 14:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3367f8f8cb0so9675966f8f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jan 2024 06:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704204227; x=1704809027; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GeJuJizoWeAs29loa6MRIjI0gunccegFhfT3lI/DWIs=;
        b=jBAKOIba/xIr+7nD78XhYRVDqnsegy2GBhdvfeFgQsHKgF2I974MshoM8DtnyAFOIu
         KU8JsFE1Q9CmjjiLpLFZ0AzfC5oibDyIsvgN2MvLuGSDqLO+SR5xX1sAbgYLFOhkACE7
         IsQb5ZfeX7C9jTzARBmmNWP74Lgt1YQl7wTwlqvK0NfRGKK2oJtF6EzfciDD6XexbNsh
         tpgh4KhH7EXfIFcHx3Z2TOi1Q7fTZqBmPeTatbwIwijtYpC2Z44uBuZ2XYwQhjKrZo4g
         ujyMKcMjs4jwiTShNM1KrRSXE2if/ODf+vXiN/lEKthv1dGgzE5kxwCgnsyfJNlefz7o
         PDEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704204227; x=1704809027;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GeJuJizoWeAs29loa6MRIjI0gunccegFhfT3lI/DWIs=;
        b=KeaOjDW3azpgqvnIcatMYa7a+a7w/smBmtmK1U12W3wFQrWN0kxz5wZn5YObpnFMgG
         oZw37As7iJCxB2WsFK8AhglwruvvYuZhfTUsi39X4tVLGjLOo4v+2TKmhJ/Jd3MlsMI7
         68iqQYWiuRZ9z8ZvZ44ndwCXTNESQyLFK4dDQT3eiPdlyCfcRRYzsriMYIlM+9o2DcW7
         maCQ4F5bgYYK7lWFrwvJvya6OG8Sdix8xRbwndIzlwelWVHPHmC0+SM5hBB56RMeKLkG
         3NiAjlzKyDitwy3QCletSWISpBZ3S0/0lTVuma7FndzLS4Gvev+jpLZDOdivWHVtp3M2
         ZgqA==
X-Gm-Message-State: AOJu0Yywt9FRlTqchSGSDh2MpPUN0nvTv+w4784kwpnXE5bXOBpqJ+xo
	0nvmrz7ED6kLzGn0Ta34Ip0XQfPmMcA16w==
X-Google-Smtp-Source: AGHT+IE/lxBI2psr/eyrLZFMSVyOi8+3ecJpLXDxAYrw3nUMQDDIqSUNcdGH6FQb1H0HxA0PUgdCHw==
X-Received: by 2002:a5d:5145:0:b0:336:7f03:4af with SMTP id u5-20020a5d5145000000b003367f0304afmr10379008wrt.123.1704204226988;
        Tue, 02 Jan 2024 06:03:46 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id q17-20020adfcd91000000b003362d0eefd3sm28380018wrj.20.2024.01.02.06.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 06:03:46 -0800 (PST)
Date: Tue, 2 Jan 2024 16:29:12 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Edward Adam Davis <eadavis@qq.com>,
	syzbot+553d90297e6d2f50dbc7@syzkaller.appspotmail.com
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, shaggy@kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] jfs: fix array-index-out-of-bounds in diNewExt
Message-ID: <828db1e9-9b98-4797-bd23-08fbae1260d3@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_B86ECD2ECECC92A7ED86EF92D0064A499206@qq.com>

Hi Edward,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Edward-Adam-Davis/jfs-fix-array-index-out-of-bounds-in-diNewExt/20231212-095530
base:   https://github.com/kleikamp/linux-shaggy jfs-next
patch link:    https://lore.kernel.org/r/tencent_B86ECD2ECECC92A7ED86EF92D0064A499206%40qq.com
patch subject: [PATCH] jfs: fix array-index-out-of-bounds in diNewExt
config: i386-randconfig-141-20231212 (https://download.01.org/0day-ci/archive/20231214/202312142348.6HRZtXTB-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce: (https://download.01.org/0day-ci/archive/20231214/202312142348.6HRZtXTB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202312142348.6HRZtXTB-lkp@intel.com/

New smatch warnings:
fs/jfs/jfs_imap.c:2213 diNewExt() error: buffer overflow 'imap->im_imap.in_agctl' 128 <= 128

Old smatch warnings:
fs/jfs/jfs_imap.c:2229 diNewExt() error: buffer overflow 'imap->im_imap.in_agctl' 128 <= 128
fs/jfs/jfs_imap.c:2304 diNewExt() error: buffer overflow 'imap->im_imap.in_agctl' 128 <= 128
fs/jfs/jfs_imap.c:2318 diNewExt() error: buffer overflow 'imap->im_imap.in_agctl' 128 <= 128
fs/jfs/jfs_imap.c:2330 diNewExt() error: buffer overflow 'imap->im_imap.in_agctl' 128 <= 128
fs/jfs/jfs_imap.c:2332 diNewExt() error: buffer overflow 'imap->im_imap.in_agctl' 128 <= 128
fs/jfs/jfs_imap.c:2363 diNewExt() error: buffer overflow 'imap->im_imap.in_agctl' 128 <= 128
fs/jfs/jfs_imap.c:2364 diNewExt() error: buffer overflow 'imap->im_imap.in_agctl' 128 <= 128

vim +2213 fs/jfs/jfs_imap.c

^1da177e4c3f41 Linus Torvalds    2005-04-16  2152  static int diNewExt(struct inomap * imap, struct iag * iagp, int extno)
^1da177e4c3f41 Linus Torvalds    2005-04-16  2153  {
^1da177e4c3f41 Linus Torvalds    2005-04-16  2154  	int agno, iagno, fwd, back, freei = 0, sword, rc;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2155  	struct iag *aiagp = NULL, *biagp = NULL, *ciagp = NULL;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2156  	struct metapage *amp, *bmp, *cmp, *dmp;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2157  	struct inode *ipimap;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2158  	s64 blkno, hint;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2159  	int i, j;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2160  	u32 mask;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2161  	ino_t ino;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2162  	struct dinode *dp;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2163  	struct jfs_sb_info *sbi;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2164  
^1da177e4c3f41 Linus Torvalds    2005-04-16  2165  	/* better have free extents.
^1da177e4c3f41 Linus Torvalds    2005-04-16  2166  	 */
^1da177e4c3f41 Linus Torvalds    2005-04-16  2167  	if (!iagp->nfreeexts) {
eb8630d7d2fd13 Joe Perches       2013-06-04  2168  		jfs_error(imap->im_ipimap->i_sb, "no free extents\n");
^1da177e4c3f41 Linus Torvalds    2005-04-16  2169  		return -EIO;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2170  	}
^1da177e4c3f41 Linus Torvalds    2005-04-16  2171  
^1da177e4c3f41 Linus Torvalds    2005-04-16  2172  	/* get the inode map inode.
^1da177e4c3f41 Linus Torvalds    2005-04-16  2173  	 */
^1da177e4c3f41 Linus Torvalds    2005-04-16  2174  	ipimap = imap->im_ipimap;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2175  	sbi = JFS_SBI(ipimap->i_sb);
^1da177e4c3f41 Linus Torvalds    2005-04-16  2176  
^1da177e4c3f41 Linus Torvalds    2005-04-16  2177  	amp = bmp = cmp = NULL;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2178  
^1da177e4c3f41 Linus Torvalds    2005-04-16  2179  	/* get the ag and iag numbers for this iag.
^1da177e4c3f41 Linus Torvalds    2005-04-16  2180  	 */
^1da177e4c3f41 Linus Torvalds    2005-04-16  2181  	agno = BLKTOAG(le64_to_cpu(iagp->agstart), sbi);
f93b91b82fcf16 Edward Adam Davis 2023-12-12  2182  	if (agno > MAXAG || agno < 0)

The commit introduces this agno > MAXAG comparison.  But Smatch says
that it should be agno >= MAXAG.

f93b91b82fcf16 Edward Adam Davis 2023-12-12  2183  		return -EIO;
f93b91b82fcf16 Edward Adam Davis 2023-12-12  2184  
^1da177e4c3f41 Linus Torvalds    2005-04-16  2185  	iagno = le32_to_cpu(iagp->iagnum);
^1da177e4c3f41 Linus Torvalds    2005-04-16  2186  
^1da177e4c3f41 Linus Torvalds    2005-04-16  2187  	/* check if this is the last free extent within the
^1da177e4c3f41 Linus Torvalds    2005-04-16  2188  	 * iag.  if so, the iag must be removed from the ag
25985edcedea63 Lucas De Marchi   2011-03-30  2189  	 * free extent list, so get the iags preceding and
^1da177e4c3f41 Linus Torvalds    2005-04-16  2190  	 * following the iag on this list.
^1da177e4c3f41 Linus Torvalds    2005-04-16  2191  	 */
^1da177e4c3f41 Linus Torvalds    2005-04-16  2192  	if (iagp->nfreeexts == cpu_to_le32(1)) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  2193  		if ((fwd = le32_to_cpu(iagp->extfreefwd)) >= 0) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  2194  			if ((rc = diIAGRead(imap, fwd, &amp)))
^1da177e4c3f41 Linus Torvalds    2005-04-16  2195  				return (rc);
^1da177e4c3f41 Linus Torvalds    2005-04-16  2196  			aiagp = (struct iag *) amp->data;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2197  		}
^1da177e4c3f41 Linus Torvalds    2005-04-16  2198  
^1da177e4c3f41 Linus Torvalds    2005-04-16  2199  		if ((back = le32_to_cpu(iagp->extfreeback)) >= 0) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  2200  			if ((rc = diIAGRead(imap, back, &bmp)))
^1da177e4c3f41 Linus Torvalds    2005-04-16  2201  				goto error_out;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2202  			biagp = (struct iag *) bmp->data;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2203  		}
^1da177e4c3f41 Linus Torvalds    2005-04-16  2204  	} else {
^1da177e4c3f41 Linus Torvalds    2005-04-16  2205  		/* the iag has free extents.  if all extents are free
^1da177e4c3f41 Linus Torvalds    2005-04-16  2206  		 * (as is the case for a newly allocated iag), the iag
^1da177e4c3f41 Linus Torvalds    2005-04-16  2207  		 * must be added to the ag free extent list, so get
^1da177e4c3f41 Linus Torvalds    2005-04-16  2208  		 * the iag at the head of the list in preparation for
^1da177e4c3f41 Linus Torvalds    2005-04-16  2209  		 * adding this iag to this list.
^1da177e4c3f41 Linus Torvalds    2005-04-16  2210  		 */
^1da177e4c3f41 Linus Torvalds    2005-04-16  2211  		fwd = back = -1;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2212  		if (iagp->nfreeexts == cpu_to_le32(EXTSPERIAG)) {
^1da177e4c3f41 Linus Torvalds    2005-04-16 @2213  			if ((fwd = imap->im_agctl[agno].extfree) >= 0) {

If agno == MAXAG then we're out of bounds here.

^1da177e4c3f41 Linus Torvalds    2005-04-16  2214  				if ((rc = diIAGRead(imap, fwd, &amp)))
^1da177e4c3f41 Linus Torvalds    2005-04-16  2215  					goto error_out;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2216  				aiagp = (struct iag *) amp->data;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2217  			}
^1da177e4c3f41 Linus Torvalds    2005-04-16  2218  		}
^1da177e4c3f41 Linus Torvalds    2005-04-16  2219  	}
^1da177e4c3f41 Linus Torvalds    2005-04-16  2220  
^1da177e4c3f41 Linus Torvalds    2005-04-16  2221  	/* check if the iag has no free inodes.  if so, the iag

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


