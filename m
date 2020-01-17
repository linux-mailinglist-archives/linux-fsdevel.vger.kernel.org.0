Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4CC3140974
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2020 13:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgAQMFP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jan 2020 07:05:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:40622 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbgAQMFP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jan 2020 07:05:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DCCC3B2E2;
        Fri, 17 Jan 2020 12:05:13 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C1AEA1E0D53; Fri, 17 Jan 2020 13:05:11 +0100 (CET)
Date:   Fri, 17 Jan 2020 13:05:11 +0100
From:   Jan Kara <jack@suse.cz>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: udf: Suspicious values in udf_statfs()
Message-ID: <20200117120511.GI17141@quack2.suse.cz>
References: <20200112162311.khkvcu2u6y4gbbr7@pali>
 <20200113120851.GG23642@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="QTprm0S8XgL7H0Dt"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200113120851.GG23642@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--QTprm0S8XgL7H0Dt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon 13-01-20 13:08:51, Jan Kara wrote:
> Hello,
> 
> On Sun 12-01-20 17:23:11, Pali Rohár wrote:
> > I looked at udf_statfs() implementation and I see there two things which
> > are probably incorrect:
> > 
> > First one:
> > 
> > 	buf->f_blocks = sbi->s_partmaps[sbi->s_partition].s_partition_len;
> > 
> > If sbi->s_partition points to Metadata partition then reported number
> > of blocks seems to be incorrect. Similar like in udf_count_free().
> 
> Oh, right. This needs similar treatment like udf_count_free(). I'll fix it.
> Thanks for spotting.

Patch for this is attached.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--QTprm0S8XgL7H0Dt
Content-Type: text/x-patch; charset=iso-8859-1
Content-Disposition: attachment; filename="0001-udf-Handle-metadata-partition-better-for-statfs-2.patch"
Content-Transfer-Encoding: 8bit

From 2e831a1fb4fa4a6843e154edb1d9e80a1c610803 Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Fri, 17 Jan 2020 12:41:39 +0100
Subject: [PATCH] udf: Handle metadata partition better for statfs(2)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When the filesystem uses Metadata partition, we need to look at the
underlying partition to get real total number of blocks in the
filesystem. Do the necessary remapping in udf_statfs().

Reported-by: Pali Rohár <pali.rohar@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/super.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/udf/super.c b/fs/udf/super.c
index f747bf72edbe..3bb9793db3aa 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -2395,11 +2395,17 @@ static int udf_statfs(struct dentry *dentry, struct kstatfs *buf)
 	struct udf_sb_info *sbi = UDF_SB(sb);
 	struct logicalVolIntegrityDescImpUse *lvidiu;
 	u64 id = huge_encode_dev(sb->s_bdev->bd_dev);
+	unsigned int part = sbi->s_partition;
+	int ptype = sbi->s_partmaps[part].s_partition_type;
 
+	if (ptype == UDF_METADATA_MAP25) {
+		part = sbi->s_partmaps[part].s_type_specific.s_metadata.
+							s_phys_partition_ref;
+	}
 	lvidiu = udf_sb_lvidiu(sb);
 	buf->f_type = UDF_SUPER_MAGIC;
 	buf->f_bsize = sb->s_blocksize;
-	buf->f_blocks = sbi->s_partmaps[sbi->s_partition].s_partition_len;
+	buf->f_blocks = sbi->s_partmaps[part].s_partition_len;
 	buf->f_bfree = udf_count_free(sb);
 	buf->f_bavail = buf->f_bfree;
 	/*
-- 
2.16.4


--QTprm0S8XgL7H0Dt--
