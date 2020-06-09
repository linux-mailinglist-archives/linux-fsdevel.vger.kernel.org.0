Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1AE1F3663
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jun 2020 10:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbgFIIts (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 04:49:48 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:52715 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728107AbgFIItn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 04:49:43 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200609084939epoutp015baef3417e596da6dd9355083a2479e0~W0-e5ZP890554305543epoutp01e
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2020 08:49:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200609084939epoutp015baef3417e596da6dd9355083a2479e0~W0-e5ZP890554305543epoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591692579;
        bh=r3XjXMonM7LT3sDPjt/O4e28bgDHoiLrfy86US4AFVI=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=NnxFiAlydb9buQn585lvYbXW2Qns14JYH+KSJyAO77LR7c/sAV6cu1SuSGKnFscYC
         eyZCu3+1TUnCcyDAteNu+NzS1dSiDBG3xugdiSytIWLDZpwlW4hmEn4wEy+Ym94+aa
         wDImGlsiWELNIhRRiOJTDbwK3xacw1FqPvp01Dlc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200609084938epcas1p3d73fd30f35577448e4e88e002160a766~W0-egi0VI0615106151epcas1p3e;
        Tue,  9 Jun 2020 08:49:38 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.161]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 49h3hd69ByzMqYlv; Tue,  9 Jun
        2020 08:49:37 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        98.32.28581.12D4FDE5; Tue,  9 Jun 2020 17:49:37 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200609084937epcas1p2631687a70054e59fede5ed773d39f3f1~W0-dNlXA00074900749epcas1p2L;
        Tue,  9 Jun 2020 08:49:37 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200609084937epsmtrp26d934b330f46a0823c14eba1072fd3e2~W0-dMuYYI0596105961epsmtrp2D;
        Tue,  9 Jun 2020 08:49:37 +0000 (GMT)
X-AuditID: b6c32a38-2e3ff70000006fa5-47-5edf4d216f0f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0F.EB.08382.12D4FDE5; Tue,  9 Jun 2020 17:49:37 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200609084937epsmtip1b76147622b8d90a2b7f8958040f6f642~W0-dASFnU1016510165epsmtip1F;
        Tue,  9 Jun 2020 08:49:37 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Tetsuhiro Kohada'" <kohada.t2@gmail.com>
Cc:     <kohada.tetsuhiro@dc.mitsubishielectric.co.jp>,
        <mori.takahiro@ab.mitsubishielectric.co.jp>,
        <motai.hirotaka@aj.mitsubishielectric.co.jp>,
        "'Namjae Jeon'" <linkinjeon@kernel.org>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20200609075329.13313-1-kohada.t2@gmail.com>
Subject: RE: [PATCH 1/2 v2] exfat: write multiple sectors at once
Date:   Tue, 9 Jun 2020 17:49:37 +0900
Message-ID: <001401d63e3a$e7db42e0$b791c8a0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJANO7rmpsMTRXh4Qe13IRSCPANcgLXVfMjp+VO5fA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGJsWRmVeSWpSXmKPExsWy7bCmga6i7/04gws3dSx+zL3NYvHm5FQW
        i4nTljJb7Nl7ksXi8q45bBaX/39isVj2ZTKLxZZ/R1gdODy+zDnO7tE2+R+7R/OxlWweO2fd
        ZffYtKqTzaNvyypGj8+b5ALYo3JsMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU
        8hJzU22VXHwCdN0yc4CuUlIoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUGBoU6BUn
        5haX5qXrJefnWhkaGBiZAlUm5GT0tM5kKlgqUfFio08D4zXhLkZODgkBE4mLL06zdTFycQgJ
        7GCUeLn+HTOE84lR4s3pdewgVUIC3xglfh90gel4/fA/C0TRXkaJk/ffsEM4Lxkl1naeZQap
        YhPQlfj3Zz8biC0ioCdx8uR1sB3MAquYJNZP6mEFSXAKWEocfrGaCcQWFnCUOHPtI1icRUBF
        YubjlYwgNi9QzbYF01khbEGJkzOfsIDYzALyEtvfzmGGOElB4ufTZawQy6wkHn1qZIKoEZGY
        3dkG9o+EwFoOibaL95kgGlwk9nQfZISwhSVeHd/CDmFLSXx+txfoUg4gu1ri436o+R2MEi++
        20LYxhI3129gBSlhFtCUWL9LHyKsKLHz91xGiLV8Eu++9rBCTOGV6GgTgihRlei7dBjqAGmJ
        rvYP7BMYlWYheWwWksdmIXlgFsKyBYwsqxjFUguKc9NTiw0LTJDjehMjOMFqWexgnPv2g94h
        RiYOxkOMEhzMSiK81Q/uxAnxpiRWVqUW5ccXleakFh9iNAUG9URmKdHkfGCKzyuJNzQ1MjY2
        tjAxMzczNVYS5z1pdSFOSCA9sSQ1OzW1ILUIpo+Jg1OqgUkwVH1790TTt88F7hkkCDreDouL
        Lnw4p9VV98ivZUm7LnkWVDj57GK4kGBpa5Qf532s/kCgenK1TVFh9DS7i24i/7ac+B8UcyDp
        91NXzQYhhl83z31ZL73Lqu7fd8GMqMvGrCeaNhdMCfllFXV5SpHCwXq9/5VOXr/f8d9Tfb3y
        +VGVPE9lr1y58kPqHG7OMwuf+HF+apwztV3yS+FmXz1/7pkpq42ij619mVXPyT0/vMf2Ddt8
        vYstl279aG4Ifsulc2l3/7yTVS0mngcPnHjPtVCY84/55RfcrDtCOe7tyvTb0MR2ZEXRiyMR
        J9Tsv25RbObm0I5SmNGblzW7JFM3e7/ueVmem/rfK15ZK7EUZyQaajEXFScCAKobB5Q5BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsWy7bCSnK6i7/04g6bbohY/5t5msXhzciqL
        xcRpS5kt9uw9yWJxedccNovL/z+xWCz7MpnFYsu/I6wOHB5f5hxn92ib/I/do/nYSjaPnbPu
        sntsWtXJ5tG3ZRWjx+dNcgHsUVw2Kak5mWWpRfp2CVwZPa0zmQqWSlS82OjTwHhNuIuRk0NC
        wETi9cP/LF2MXBxCArsZJT61/2OBSEhLHDtxhrmLkQPIFpY4fLgYouY5o8T/05+ZQWrYBHQl
        /v3ZzwZiiwjoSZw8eZ0NpIhZYB2TxOSPbVBTuxgldq9+zgRSxSlgKXH4xWowW1jAUeLMtY+s
        IDaLgIrEzMcrGUFsXqCabQums0LYghInZz5hAbmCGWhD20awEmYBeYntb+cwQxyqIPHz6TJW
        iCOsJB59amSCqBGRmN3ZxjyBUXgWkkmzECbNQjJpFpKOBYwsqxglUwuKc9Nziw0LDPNSy/WK
        E3OLS/PS9ZLzczcxgiNNS3MH4/ZVH/QOMTJxMB5ilOBgVhLhrX5wJ06INyWxsiq1KD++qDQn
        tfgQozQHi5I4743ChXFCAumJJanZqakFqUUwWSYOTqkGpsO7rwgdyNkkVvpv5VodKfWrZtXy
        P54dyX50Z5/M9ufe+303s/7wfank7i0SeuKngrW0VOHCwtfM+tl/2f4dv/uLbWHkpnjF2/on
        N8R4eegymB522/lXsX3xSafTUz+8nPjwmPnXmnznpTt+7c2XXBmXcZ6hppZr8d2mPBmOgMKJ
        /D6RsjNklyb9LsuUPbrKu2eRXCrXK54sW/MDZu5vBbq81u5QnBOnyKOy1IOLi1V24gGhiotb
        tnesKy7+VlJe4Wy66twKux+28Um1Wubra2sNj4S0x1W4eE5frX7ELNTefH+Oc8lkl4ASmS17
        9XruOMzVMsi+c+6IArPYBkFj8yK+iTv/L5UoDI9Ye+CTEktxRqKhFnNRcSIAqcfhaiMDAAA=
X-CMS-MailID: 20200609084937epcas1p2631687a70054e59fede5ed773d39f3f1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200609075406epcas1p38bc47a52172f47af12d79275a751b4d9
References: <CGME20200609075406epcas1p38bc47a52172f47af12d79275a751b4d9@epcas1p3.samsung.com>
        <20200609075329.13313-1-kohada.t2@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Write multiple sectors at once when updating dir-entries.
> Add exfat_update_bhs() for that. It wait for write completion once instead of sector by sector.
> It's only effective if sync enabled.
> 
> Suggested-by: Namjae Jeon <linkinjeon@kernel.org>
> Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
> ---
> Changes in v2:
>  - Split into 'write multiple sectors at once'
>    and 'add error check when updating dir-entries'
> 
>  fs/exfat/dir.c      | 12 +++++++-----
>  fs/exfat/exfat_fs.h |  1 +
>  fs/exfat/misc.c     | 19 +++++++++++++++++++
>  3 files changed, 27 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c index de43534aa299..495884ccb352 100644
> --- a/fs/exfat/dir.c
> +++ b/fs/exfat/dir.c
> @@ -604,13 +604,15 @@ void exfat_update_dir_chksum_with_entry_set(struct exfat_entry_set_cache *es)
> 
>  void exfat_free_dentry_set(struct exfat_entry_set_cache *es, int sync)  {
> -	int i;
> +	int i, err = 0;
> 
> -	for (i = 0; i < es->num_bh; i++) {
> -		if (es->modified)
> -			exfat_update_bh(es->sb, es->bh[i], sync);
> -		brelse(es->bh[i]);
> +	if (es->modified) {
> +		set_bit(EXFAT_SB_DIRTY, &EXFAT_SB(es->sb)->s_state);
I pointed out that setting EXFAT_SB_DIRTY can be merged into exfat_update_bhs() on previous thread.
Is it unnecessary?
> +		err = exfat_update_bhs(es->bh, es->num_bh, sync);
>  	}
> +
> +	for (i = 0; i < es->num_bh; i++)
> +		err ? bforget(es->bh[i]):brelse(es->bh[i]);
>  	kfree(es);
>  }
> 
> diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h index 595f3117f492..935954da2e54 100644
> --- a/fs/exfat/exfat_fs.h
> +++ b/fs/exfat/exfat_fs.h
> @@ -515,6 +515,7 @@ void exfat_set_entry_time(struct exfat_sb_info *sbi, struct timespec64 *ts,
>  u16 exfat_calc_chksum16(void *data, int len, u16 chksum, int type);
>  u32 exfat_calc_chksum32(void *data, int len, u32 chksum, int type);  void exfat_update_bh(struct
> super_block *sb, struct buffer_head *bh, int sync);
> +int exfat_update_bhs(struct buffer_head **bhs, int nr_bhs, int sync);
>  void exfat_chain_set(struct exfat_chain *ec, unsigned int dir,
>  		unsigned int size, unsigned char flags);  void exfat_chain_dup(struct exfat_chain *dup,
> struct exfat_chain *ec); diff --git a/fs/exfat/misc.c b/fs/exfat/misc.c index
> 17d41f3d3709..dc34968e99d3 100644
> --- a/fs/exfat/misc.c
> +++ b/fs/exfat/misc.c
> @@ -173,6 +173,25 @@ void exfat_update_bh(struct super_block *sb, struct buffer_head *bh, int sync)
>  		sync_dirty_buffer(bh);
>  }
> 
> +int exfat_update_bhs(struct buffer_head **bhs, int nr_bhs, int sync) {
> +	int i, err = 0;
> +
> +	for (i = 0; i < nr_bhs; i++) {
> +		set_buffer_uptodate(bhs[i]);
> +		mark_buffer_dirty(bhs[i]);
> +		if (sync)
> +			write_dirty_buffer(bhs[i], 0);
> +	}
> +
> +	for (i = 0; i < nr_bhs && sync; i++) {
> +		wait_on_buffer(bhs[i]);
> +		if (!buffer_uptodate(bhs[i]))
> +			err = -EIO;
> +	}
> +	return err;
> +}
> +
>  void exfat_chain_set(struct exfat_chain *ec, unsigned int dir,
>  		unsigned int size, unsigned char flags)  {
> --
> 2.25.1


