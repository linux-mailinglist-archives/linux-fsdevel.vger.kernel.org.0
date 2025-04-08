Return-Path: <linux-fsdevel+bounces-45921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EF8A7F20F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 03:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 929F23AB1D6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 01:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C1721C19D;
	Tue,  8 Apr 2025 01:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Oi/a6Yeh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091142F44
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Apr 2025 01:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744074942; cv=none; b=UAM62YugB2dRX3TaJesK+vdyWrDJv233vp4+8hfByzgfSSTq2P2rOfTFCH6lRUlYYTX4pwAPpuM5bkPl9oLfmdBsJjLV2XP7tanQCjaUCGYnU1EKYZ4rs5BL+yUqZKESiGAJW2iR0ocZbSZoyLipL5FVezCbFdp9vmX4TAiraqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744074942; c=relaxed/simple;
	bh=4Ydbg4FY1mYfVmiCa+z+S8bh+QBo0t4rP9czs/8571o=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=lCmqJ9g/4i+Z0cEaQ/cV7MIU9EiR7GiQEHq2Yb6T/7rjfxYykqRirhju1ojSf6hqHDfLedcelI0y90AUscCsGn4EPVhCNlRgPaxw5XpfsBjmSwVpWGluQ/gpS5kziFCVihi7pqDRUIgCoKKHj+Q1jiRiWY/TRbtYUBZiMnzS+FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Oi/a6Yeh; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250408011537epoutp047b7f869b23e775014c1cb271a5d1510f~0MupfAWe70568805688epoutp04V
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Apr 2025 01:15:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250408011537epoutp047b7f869b23e775014c1cb271a5d1510f~0MupfAWe70568805688epoutp04V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1744074937;
	bh=l2lTAv2pu6mm09zltNGhj/3F98QYuTythNRzIzI3pBA=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=Oi/a6YehACGE8gcYT3aC9/La2/nqVqEyAqjjRbu0YP4ODhmDXSgJ6JC+TicaVxrLh
	 ZvZME2uPCcAZSG/PGPqI2lkm6VgXUHb2WTQVoKHbCi3EVyIAOydAqgIUtY8BQTrjN7
	 NkGgZ+2/UhwaG/mRq1u2WMHlvj/VeggDHkVlCMhQ=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTPS id
	20250408011537epcas1p2cb70b3ae8932d700692658a41215c1e1~0MupLLv8v0068500685epcas1p2X;
	Tue,  8 Apr 2025 01:15:37 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.248]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4ZWp6c4wcjz6B9mN; Tue,  8 Apr
	2025 01:15:36 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
	epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	37.6F.10189.7B874F76; Tue,  8 Apr 2025 10:15:35 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250408011535epcas1p2a17c09c5ebec6a6188aebea6c47a1eb0~0MunVOC6E3092830928epcas1p2A;
	Tue,  8 Apr 2025 01:15:35 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250408011535epsmtrp19a961ff66a187eafbac1a20d56bf9a51~0MunUfCyi2564025640epsmtrp1S;
	Tue,  8 Apr 2025 01:15:35 +0000 (GMT)
X-AuditID: b6c32a35-1c9cd240000027cd-cb-67f478b7c0fb
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A8.4E.08766.7B874F76; Tue,  8 Apr 2025 10:15:35 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250408011535epsmtip15ead91eaa9334918d2ff59e62f559c5f~0MunJQzvw2189721897epsmtip1h;
	Tue,  8 Apr 2025 01:15:35 +0000 (GMT)
From: "Sungjong Seo" <sj1557.seo@samsung.com>
To: "'Anthony Iliopoulos'" <ailiop@suse.com>, "'Namjae Jeon'"
	<linkinjeon@kernel.org>, "'Yuezhang Mo'" <yuezhang.mo@sony.com>
Cc: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<sjdev.seo@gmail.com>, <cpgs@samsung.com>, <sj1557.seo@samsung.com>
In-Reply-To: <20250407102345.50130-1-ailiop@suse.com>
Subject: RE: [PATCH] exfat: enable request merging for dir readahead
Date: Tue, 8 Apr 2025 10:15:35 +0900
Message-ID: <c2c601dba823$bb2fdf00$318f9d00$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQJdGYLaRJff6SK8rO6LplO1qtk/tgLgB8WDsn8GOKA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKJsWRmVeSWpSXmKPExsWy7bCmvu72ii/pBrMPmlr8fbiO1eLlIU2L
	idOWMlvs2XuSxeLyrjlsFlv+HWG1ePFhA5vF9TcPWR04PHbOusvusWlVJ5tH35ZVjB7tE3Yy
	e6zfcpXF4/MmuQC2qAZGm8Si5IzMslSF1Lzk/JTMvHRbpdAQN10LJYWM/OISW6VoQ0MjPUMD
	cz0jIyM9U6NYKyNTJYW8xNxUW6UKXaheJYWi5AKg2tzKYqABOal6UHG94tS8FIes/FKQJ/SK
	E3OLS/PS9ZLzc5UUyhJzSoFGKOknfGPMeP4zrWCpaMWzDcvZGxjfC3QxcnJICJhILNx+ibmL
	kYtDSGAHo8TVe//YIJxPjBKnpr6Bcr4xSmz9/oyli5EDrGVdTwBEfC+jxMcHD6GKXjJKTF3d
	xQ4yl01AV+LJjZ/MIA0iAvUSfV9CQWqYgZZKXLx5mg2khlPAVOLV1h+sILawgIvEjjudTCA2
	i4CKxOTHT1hAbF4BS4kdL74wQtiCEidnQsSZBeQltr+dwwzxg4LE7k9HweaICFhJPDrexQRR
	IyIxu7MN7DcJgaUcEjMuP4VqcJHovTqLBcIWlnh1fAs7hC0l8bK/jR2ioZtR4vjHd1BFMxgl
	lnQ4QNj2Es2tzWwgnzELaEqs36UPsYxP4t3XHlaIEl6Jho2/oWYKSpy+1s0MCTleiY42IYiw
	isT3DztZJjAqz0Ly2iwkr81C8sIshGULGFlWMYqlFhTnpqcWGxYYIsf3JkZwCtYy3cE48e0H
	vUOMTByMhxglOJiVRHgtT31KF+JNSaysSi3Kjy8qzUktPsSYDAzsicxSosn5wCyQVxJvaGZm
	aWFpZGJobGZoSFjYxNLAxMzIxMLY0thMSZx3z8en6UIC6YklqdmpqQWpRTBbmDg4pRqYrqbp
	fLPKlrjPNtl99dfp/h/nT/O6xCUove3q3O1fZJ7taErYUcRlrfO6aEvs6aMZ6e22urfmTWzm
	cX5uvfLvqQfnHHz/TtEOPqHYP/ft6gfqR5Ri6x5H6Re8kSr03eqzqDrwQu+BJQpyB1duK7vz
	PXLO3MX62Zlftu6PztSe0OqcLsHgL7b23xdGi+Wcn68/DjO/xvYjcXnXwrkP1i1eUuBybM9Z
	g5ue8935TrZLzp+zTntZnvSR2O/612Qz1HW17LacKD3yLX93Gcf76Iu6aUKCYUf7jbuOlAp7
	XlmTpfI+N/a3lcpmLvW5RVEsepeUZjqnO+0sVzh1Z2qZ4PW/5T/EjAUvXPj4aq+s/6ZlvUos
	xRmJhlrMRcWJAKg1fqN4BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupikeLIzCtJLcpLzFFi42LZdlhJTnd7xZd0g8Oz5Sz+PlzHavHykKbF
	xGlLmS327D3JYnF51xw2iy3/jrBavPiwgc3i+puHrA4cHjtn3WX32LSqk82jb8sqRo/2CTuZ
	PdZvucri8XmTXABbFJdNSmpOZllqkb5dAlfG859pBUtFK55tWM7ewPheoIuRg0NCwERiXU9A
	FyMnh5DAbkaJaYf4IMJSEgf3aUKYwhKHDxd3MXIBVTxnlLhz5yI7SDmbgK7Ekxs/mUESIgKN
	jBKnXp5nB3GYBSYwSnR9e8oI0dLGKLFzzndmkBZOAVOJV1t/sILYwgIuEjvudDKB2CwCKhKT
	Hz9hAbF5BSwldrz4wghhC0qcnAkRZxbQk1i/fg4jhC0vsf3tHLCZEgIKErs/HQWbKSJgJfHo
	eBcTRI2IxOzONuYJjMKzkIyahWTULCSjZiFpWcDIsopRMrWgODc9t9iwwDAvtVyvODG3uDQv
	XS85P3cTIzi6tDR3MG5f9UHvECMTB+MhRgkOZiURXstTn9KFeFMSK6tSi/Lji0pzUosPMUpz
	sCiJ84q/6E0REkhPLEnNTk0tSC2CyTJxcEo1MO1PcO916alp+CT5/WuJ/ZJanrlKYTnl05UO
	9Gd8XfZaJ+f4XGHLxS3FYjcTM5cUPeHc8TOmwNZFM5f11ZL9d5yZfjyf/F+Qb+q03yaTa0U7
	l6ZdaYk4Le/1Kry/THbnuaz2TXW79X7cu6cYPOtevYbo7Alqs39I5imFixW8fCyY+dZMctep
	j9YrZl9es8bj9rFXDl2Nvbl/VznZ8uf6S73/WHfYJcD4Rc1EqbZfz8PWuxstSnx+1sDk4dmT
	IgdTjnqGGDlM9jl86HGgVDJ7446VnW/UsrboXnf1/Hop7QKP4n0vg3kO/f7XONnmh33I/bNu
	tRP7bpd/dtoVkbuLpgXd/OuccEKZs3vumcNaFUosxRmJhlrMRcWJANWy9e4dAwAA
X-CMS-MailID: 20250408011535epcas1p2a17c09c5ebec6a6188aebea6c47a1eb0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-CPGSPASS: Y
X-ArchiveUser: EV
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250407102359epcas1p1dd23affd903c1ece78ddbfe85d39034e
References: <CGME20250407102359epcas1p1dd23affd903c1ece78ddbfe85d39034e@epcas1p1.samsung.com>
	<20250407102345.50130-1-ailiop@suse.com>

Hi, Anthony

> Directory listings that need to access the inode metadata (e.g. via
> statx to obtain the file types) of large filesystems with lots of
> metadata that aren't yet in dcache, will take a long time due to the
> directory readahead submitting one io request at a time which although
> targeting sequential disk sectors (up to EXFAT_MAX_RA_SIZE) are not
> merged at the block layer.
> 
> Add plugging around sb_breadahead so that the requests can be batched
> and submitted jointly to the block layer where they can be merged by the
> io schedulers, instead of having each request individually submitted to
> the hardware queues.
> 
> This significantly improves the throughput of directory listings as it
> also minimizes the number of io completions and related handling from
> the device driver side.

Good approach. However, this attempt was in the past Samsung code,
and there was a problem that the latency of directory-related operations
became longer when ra_count is large (maybe, MAX_RA_SIZE).
In the most recent code, blk_flush_plug is being done in units of
pages as follows.

```
blk_start_plug(&plug);
for (i = 0; i < ra_count; i++) {
        if (i && !(i & (sects_per_page - 1)))
                blk_flush_plug(&plug, false);
        sb_breadahead(sb, sec + i);
}
blk_finish_plug(&plug);
```

However, since blk_flush_plug is not exported, it can no longer be used in
module build. It seems that blk_flush_plug needs to be exported or
improved to repeat blk_start_plug and blk_finish_plug in units of pages.

After changing to plug by page unit, could you also compare the throughput?

Thanks

> 
> Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
> ---
>  fs/exfat/dir.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
> index 3103b932b674..a46ab2690b4d 100644
> --- a/fs/exfat/dir.c
> +++ b/fs/exfat/dir.c
> @@ -621,6 +621,7 @@ static int exfat_dir_readahead(struct super_block *sb,
> sector_t sec)
>  {
>  	struct exfat_sb_info *sbi = EXFAT_SB(sb);
>  	struct buffer_head *bh;
> +	struct blk_plug plug;
>  	unsigned int max_ra_count = EXFAT_MAX_RA_SIZE >> sb-
> >s_blocksize_bits;
>  	unsigned int page_ra_count = PAGE_SIZE >> sb->s_blocksize_bits;
>  	unsigned int adj_ra_count = max(sbi->sect_per_clus, page_ra_count);
> @@ -644,8 +645,10 @@ static int exfat_dir_readahead(struct super_block
*sb,
> sector_t sec)
>  	if (!bh || !buffer_uptodate(bh)) {
>  		unsigned int i;
> 
> +		blk_start_plug(&plug);
>  		for (i = 0; i < ra_count; i++)
>  			sb_breadahead(sb, (sector_t)(sec + i));
> +		blk_finish_plug(&plug);
>  	}
>  	brelse(bh);
>  	return 0;
> --
> 2.49.0



