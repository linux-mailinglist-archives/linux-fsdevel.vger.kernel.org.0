Return-Path: <linux-fsdevel+bounces-46331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B106A870D1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Apr 2025 07:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70AAE189CFF0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Apr 2025 05:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0D8142E86;
	Sun, 13 Apr 2025 05:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HB0Khink"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EDC2F32
	for <linux-fsdevel@vger.kernel.org>; Sun, 13 Apr 2025 05:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744521517; cv=none; b=dRYTAXqJ1X+wSqwRJRzlJU5OXLdwDS69G2m7Vn9cDL/FOqV3JTtdbcgc4cgIpRREnCNzl8DxXOiMZIKaVgtDU5MdWkeJYBn/of2opCKL9FjPjMFL1ENxIdhWckoa9beb0rcVTyam131b8oHuPtOYfkDzEnGNDP2Qs3Jg+uxx7VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744521517; c=relaxed/simple;
	bh=ul0F+G0MZGXrh7V14/BS5xOsB5oE2rB7sZxEisfdO24=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=DTG4McZWhkX2vgU0cJ/DJKCocFQw2pbmke8T9vf/2Cg9r5QQM1Hy+6WVh1sgsk/vCAJMF25K3OojJloeFdhhYobvzby4RpBbvDihaOxXaGO2jvcYbSwnHDcToQNMJFrPZDx22EjaJ9P1Xzywg7PUZdMUSHejMVAxeXZ12WikeT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=HB0Khink; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250413051826epoutp024fb7cdbf48e1d1d07f29aba4ea36939d~1yREsucUg2223122231epoutp02A
	for <linux-fsdevel@vger.kernel.org>; Sun, 13 Apr 2025 05:18:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250413051826epoutp024fb7cdbf48e1d1d07f29aba4ea36939d~1yREsucUg2223122231epoutp02A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1744521506;
	bh=jxxyLxSTLaDN/k8Gf2lku75F96gcuhKq04/TioKq650=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=HB0KhinkTNCynzeESUps/MWFFqJnhQqYh489a8KvJCsW5CwDn273Mom+FFzZ9WTD0
	 /Rqnp7crHVDqSqNWQ+JI9drZIEKb2nc2RD5xTjfcz/dFs01WT1S9jYdIt7fb51kM21
	 mQETxPn00w0gAbu+93HavdqvZuKiJFv9CPuSJplo=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTPS id
	20250413051825epcas1p4d6986037deefe4d4966020b3cd403cda~1yRELD4iG3093630936epcas1p4H;
	Sun, 13 Apr 2025 05:18:25 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.240]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4ZZzGT2K0sz6B9m5; Sun, 13 Apr
	2025 05:18:25 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
	epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
	27.88.10202.1294BF76; Sun, 13 Apr 2025 14:18:25 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250413051824epcas1p12aa5311d9439ba791f71cd602e11d1ca~1yRDcatw_2872628726epcas1p1s;
	Sun, 13 Apr 2025 05:18:24 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250413051824epsmtrp1b71e365030b816c2bdd47ca72104cd16~1yRDbzfBp2024220242epsmtrp1z;
	Sun, 13 Apr 2025 05:18:24 +0000 (GMT)
X-AuditID: b6c32a37-f5feb700000027da-1d-67fb49218969
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	7A.FD.07818.0294BF76; Sun, 13 Apr 2025 14:18:24 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250413051824epsmtip135ff1bd3acd1c4867bfd3386648d242b~1yRDORB9q3086930869epsmtip1S;
	Sun, 13 Apr 2025 05:18:24 +0000 (GMT)
From: "Sungjong Seo" <sj1557.seo@samsung.com>
To: <Yuezhang.Mo@sony.com>, <linkinjeon@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>, <sj1557.seo@samsung.com>,
	<sjdev.seo@gmail.com>, <cpgs@samsung.com>
In-Reply-To: <PUZPR04MB63168406D20B7CF3B287812281B72@PUZPR04MB6316.apcprd04.prod.outlook.com>
Subject: RE: [PATCH v1] exfat: do not clear volume dirty flag during sync
Date: Sun, 13 Apr 2025 14:18:24 +0900
Message-ID: <12bf001dbac33$7b378fb0$71a6af10$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQMttRtk+TDXeSz+m0TFvc+bKFlw/QIyCKQCsOtrijA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGJsWRmVeSWpSXmKPExsWy7bCmga6i5+90g/eHuC1eHtK0mDhtKbPF
	nr0nWSy2/DvCavHiwwY2i+tvHrI6sHnsnHWX3WPTqk42j74tqxg92ifsZPb4vEkugDWqgdEm
	sSg5I7MsVSE1Lzk/JTMv3VYpNMRN10JJISO/uMRWKdrQ0EjP0MBcz8jISM/UKNbKyFRJIS8x
	N9VWqUIXqldJoSi5AKg2t7IYaEBOqh5UXK84NS/FISu/FORqveLE3OLSvHS95PxcJYWyxJxS
	oBFK+gnfGDO+HUwomCpTMWPuZNYGxjNiXYycHBICJhKrdn5j6WLk4hAS2MEoMfPtQijnE6PE
	tps3WCGcb4wSk55cY4NpWdf0EMwWEtjLKLFytyNE0UtGiS0tj5hAEmwCuhJPbvxkBrFFBIwl
	+rfOYgWxmQWyJI7snMwIYnMKxEr8enMErF5YwFPi8PQnYENZBFQl1m9oYwexeQWsJN5Mn8QE
	YQtKnJz5hAVijrzE9rdzmCEOUpDY/ekoK8QuK4m56+4wQtSISMzubGMGOU5CoJdDYtXF6awQ
	DS4S7089gWoWlnh1fAs7hC0l8bIfZDFIQzejxPGP71ggEjMYJZZ0OEDY9hLNrc1Al3IAbdCU
	WL9LH2IZn8S7rz1Q83klGjb+hpopKHH6WjczSDlIvKNNCCKsIvH9w06WCYzKs5C8NgvJa7OQ
	vDALYdkCRpZVjGKpBcW56anFhgXGyPG9iRGcZLXMdzBOe/tB7xAjEwfjIUYJDmYlEV4u51/p
	QrwpiZVVqUX58UWlOanFhxiTgYE9kVlKNDkfmObzSuINzcwsLSyNTAyNzQwNCQubWBqYmBmZ
	WBhbGpspifPu+fg0XUggPbEkNTs1tSC1CGYLEwenVANTebuwsdfdeyknJybsLfM0nG5RmHDf
	yejfircPguadOWzhdSWqcdGpA+UKWTuP5RhN4fv0WVtmv17VpEdZBatef7+5V0V0ztO10xMy
	F7TOK1edMSNxGaPU0YtFp6btDDvAnX6NrXpSb3a+rM0X1WUKEm3Gs1m4/izcefzwvpmVfz2O
	mLU5Ma+84HP6rHnEuRY51lNJt1U2phbaXeBcuifmiCajx+XZiieeOyzJUPFtc160gT316gcj
	r6Mmrzt9M6Qaymz+vnnVXLV3Z+fix90N/L6+jM4ORyTy7IU9uPoeGvl1B+oWJr2Wj086JtC4
	spKjY++2zq67mnY9In2Fzzo/nlEss4pMaRdp6lh94YUSS3FGoqEWc1FxIgBz5cEIaQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFLMWRmVeSWpSXmKPExsWy7bCSnK6C5+90g3+XDS1eHtK0mDhtKbPF
	nr0nWSy2/DvCavHiwwY2i+tvHrI6sHnsnHWX3WPTqk42j74tqxg92ifsZPb4vEkugDWKyyYl
	NSezLLVI3y6BK+PbwYSCqTIVM+ZOZm1gPCPWxcjJISFgIrGu6SFbFyMXh5DAbkaJvubNzF2M
	HEAJKYmD+zQhTGGJw4eLQcqFBJ4zSlx8UA9iswnoSjy58ZMZxBYRMJX4cvkEG4jNLJAnMfvh
	O3aIkesYJQ5Pnc4EkuAUiJX49eYImC0s4ClxePoTsAYWAVWJ9Rva2EFsXgEriTfTJzFB2IIS
	J2c+YYEYqiexfv0cRghbXmL72znMEPcrSOz+dJQV4ggribnr7kDViEjM7mxjnsAoPAvJqFlI
	Rs1CMmoWkpYFjCyrGCVTC4pz03OTDQsM81LL9YoTc4tL89L1kvNzNzGCo0dLYwfju29N+ocY
	mTgYDzFKcDArifByOf9KF+JNSaysSi3Kjy8qzUktPsQozcGiJM670jAiXUggPbEkNTs1tSC1
	CCbLxMEp1cDUO3X6mT0cWyvdf++3+FX0YOHls1kyK2WZSo5VbG23ZPL3fDNZ71by31k7Nr/Y
	UvPFuWTdX9lDylPuz7qmFjLjq4aH5JU5ZzZ9e+ssuXzZxbcr+W43bTgg1/ZTxTjliaZBfLSZ
	QECUxEXFW0Hqf5fxLLeOOFN46tQ2w8eGSgev/VT9aOH2dOGXkoCJ/UeU5Y/bxUy4fsJDWvV4
	Ubxk0h6OGce8nwpPb5dQ+/tT9qpfcm5adNX/jkrDOj4JYd03R8TWmGe0veZoT6t61Mp8Zwbz
	fOZZ3/32ajd2Po1LPNUbV38pt2ee8ZvwO9JTTOZeMpr6qe+k8JpG16sRX2fU8hpWz7OYbMoe
	tqfKkW9qUamIEktxRqKhFnNRcSIAgjn8zQ0DAAA=
X-CMS-MailID: 20250413051824epcas1p12aa5311d9439ba791f71cd602e11d1ca
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-CPGSPASS: Y
X-ArchiveUser: EV
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250410094112epcas1p42245e765dbdc61c0c9da40884386bbf9
References: <CGME20250410094112epcas1p42245e765dbdc61c0c9da40884386bbf9@epcas1p4.samsung.com>
	<PUZPR04MB63168406D20B7CF3B287812281B72@PUZPR04MB6316.apcprd04.prod.outlook.com>

Hi, Yuezhang,
> xfstests generic/482 tests the file system consistency after each
> FUA operation. It fails when run on exfat.
> 
> exFAT clears the volume dirty flag with a FUA operation during sync.
> Since s_lock is not held when data is being written to a file, sync
> can be executed at the same time. When data is being written to a
> file, the FAT chain is updated first, and then the file size is
> updated. If sync is executed between updating them, the length of the
> FAT chain may be inconsistent with the file size.
> 
> To avoid the situation where the file system is inconsistent but the
> volume dirty flag is cleared, this commit moves the clearing of the
> volume dirty flag from exfat_fs_sync() to exfat_put_super(), so that
> the volume dirty flag is not cleared until unmounting. After the
> move, there is no additional action during sync, so exfat_fs_sync()
> can be deleted.

It doesn't seem like FUA is the core issue. To set the volume to a clear
state in sync_filesystem, it might be possible to block the writer_iter,
mkwrite, and truncate operations.

However, as of now, it seems that moving to put_super is the simplest
and most reliable method, and FAT-fs is currently operating in that manner.

However, it seems that a modification is also needed to keep the state
dirty if it is already dirty at the time of mount, as in the FAT-fs below.
commit b88a105802e9 ("fat: mark fs as dirty on mount and clean on umount")

Could you send additional patches along with this patch as a series?

> 
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> ---
>  fs/exfat/super.c | 30 +++++++-----------------------
>  1 file changed, 7 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/exfat/super.c b/fs/exfat/super.c
> index 8465033a6cf0..7ed858937d45 100644
> --- a/fs/exfat/super.c
> +++ b/fs/exfat/super.c
> @@ -36,31 +36,12 @@ static void exfat_put_super(struct super_block *sb)
>  	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> 
>  	mutex_lock(&sbi->s_lock);
> +	exfat_clear_volume_dirty(sb);
>  	exfat_free_bitmap(sbi);
>  	brelse(sbi->boot_bh);
>  	mutex_unlock(&sbi->s_lock);
>  }
> 
> -static int exfat_sync_fs(struct super_block *sb, int wait)
> -{
> -	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> -	int err = 0;
> -
> -	if (unlikely(exfat_forced_shutdown(sb)))
> -		return 0;
> -
> -	if (!wait)
> -		return 0;
> -
> -	/* If there are some dirty buffers in the bdev inode */
> -	mutex_lock(&sbi->s_lock);
> -	sync_blockdev(sb->s_bdev);
> -	if (exfat_clear_volume_dirty(sb))
> -		err = -EIO;
> -	mutex_unlock(&sbi->s_lock);
> -	return err;
> -}
> -
>  static int exfat_statfs(struct dentry *dentry, struct kstatfs *buf)
>  {
>  	struct super_block *sb = dentry->d_sb;
> @@ -219,7 +200,6 @@ static const struct super_operations exfat_sops = {
>  	.write_inode	= exfat_write_inode,
>  	.evict_inode	= exfat_evict_inode,
>  	.put_super	= exfat_put_super,
> -	.sync_fs	= exfat_sync_fs,
>  	.statfs		= exfat_statfs,
>  	.show_options	= exfat_show_options,
>  	.shutdown	= exfat_shutdown,
> @@ -751,10 +731,14 @@ static void exfat_free(struct fs_context *fc)
> 
>  static int exfat_reconfigure(struct fs_context *fc)
>  {
> +	struct super_block *sb = fc->root->d_sb;
>  	fc->sb_flags |= SB_NODIRATIME;
> 
> -	/* volume flag will be updated in exfat_sync_fs */
> -	sync_filesystem(fc->root->d_sb);
> +	sync_filesystem(sb);
> +	mutex_lock(&EXFAT_SB(sb)->s_lock);
> +	exfat_clear_volume_dirty(sb);
> +	mutex_unlock(&EXFAT_SB(sb)->s_lock);
> +
>  	return 0;
>  }
> 
> --
> 2.43.0


