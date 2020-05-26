Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 232731E1982
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 May 2020 04:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388479AbgEZCg6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 May 2020 22:36:58 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:51458 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388417AbgEZCg5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 May 2020 22:36:57 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200526023653epoutp0385978c08c42d169431f35a1bddc34162~Sc4A-UlbE1913119131epoutp03K
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2020 02:36:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200526023653epoutp0385978c08c42d169431f35a1bddc34162~Sc4A-UlbE1913119131epoutp03K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1590460613;
        bh=HqFaTe5NVZpXATL1Nqe7f4xt0FzgRmIzFDdvbUioCEQ=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=pM/mrUGoZnr08VOgiqeaOjmDmp1hbXYCHmML147ltYg1+QresDUg0PuDo0OgPMuL8
         68WQztLpNDdOj7ppnRa/8kS+MXZE/XTbgQD1p2egbM5kTC18KGUsdLfCnHIsNWaoJO
         oVQpx5B1oagYsEVN+MeuY1ihaiN51+hNcB9kwmjk=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200526023652epcas1p46ae28b94eab0a09936a325f58679d3e3~Sc4AhjgZz0637706377epcas1p4u;
        Tue, 26 May 2020 02:36:52 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.159]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 49WJ4z44nxzMqYlm; Tue, 26 May
        2020 02:36:51 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        9D.1A.04392.3C08CCE5; Tue, 26 May 2020 11:36:51 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200526023651epcas1p130ad5c31ea73ae06835320f72351b46a~Sc3-P2hh83184931849epcas1p1S;
        Tue, 26 May 2020 02:36:51 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200526023651epsmtrp15e42ae4d3079b7f33b6a7b6134451e3a~Sc3-PM7Uf3087530875epsmtrp1C;
        Tue, 26 May 2020 02:36:51 +0000 (GMT)
X-AuditID: b6c32a37-cabff70000001128-7a-5ecc80c3daf4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        08.1A.08382.3C08CCE5; Tue, 26 May 2020 11:36:51 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200526023651epsmtip1a26ffa8e963e4c1285c2fc89fc6fd1f6~Sc3-ELkjG1427214272epsmtip1i;
        Tue, 26 May 2020 02:36:51 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     "'Tetsuhiro Kohada'" <kohada.tetsuhiro@dc.mitsubishielectric.co.jp>
Cc:     <mori.takahiro@ab.mitsubishielectric.co.jp>,
        <motai.hirotaka@aj.mitsubishielectric.co.jp>,
        "'Namjae Jeon'" <namjae.jeon@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20200520075641.32441-1-kohada.tetsuhiro@dc.mitsubishielectric.co.jp>
Subject: RE: [PATCH] exfat: optimize dir-cache
Date:   Tue, 26 May 2020 11:36:50 +0900
Message-ID: <055a01d63306$82b13440$88139cc0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQKbEd8GOCYeHYQBe/Vm0kX/gmqw5wMD/7F2pxe1QEA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA01SWUwTURTN6wzDQKwZStUrJtpO5ANIa4dSOhpwX6oSQ9QvPsAJTGi1m51C
        cImimKq4S3CpgGAiRjTRGMImEANRUnFBQSDuQUKCCkGKiIBi24HI37n3nvPOPe89EpPdICJI
        k9XJO6ycmSZC8armKJWqOfdZqqbarWS/ewpxtr7Bg7PtdUUE2z41jLPlIwU4O3b58GrCMFLU
        EmxwFfwNNuQ9uU0YzlZWIIP3weLkoBRzgpHnMniHgrem2zJM1sxEeuuOtHVpungNo2KWs3pa
        YeUsfCK9PilZtdFk9i1AK7I5c5avlcwJAr1sZYLDluXkFUab4EykeXuG2c5o7GqBswhZ1kx1
        us2ygtFoYnU+5i6zsbu2Kdjerc95N3VEkov6YvJRCAlUHBRfrkf5KJSUUTUI8qpHMbEYRvC+
        8c50MYqgoOpx0IzkRXMVIQ4aEORfvzqt70fQ8e17gEVQKujt/o35sZzaBDVlj3A/CaNeIsit
        P477ByHUdrjbVoT8OJxSw4/Rfokf41QkTAyeD4il1HJ4W3FLIuIw8FztDWgxaglUDxRh4koK
        eDgsrienVoB7tIwQOXK4dtIVyABUIQnuPz+QKFgPrZUNwSIOh68tldM4AvrPuaZxHoKzHzaL
        4mMIKmqOEuJAC8Ner+8g0ucQBffqloltJdROFCPReC4M/jwd5KcAJYUTLplIWQq/hmrxGauO
        sTeS84h2z4rmnhXNPSuC+79ZKcIr0HzeLlgyeYGxa2e/9wMU+J/R+hp0/0VSE6JIRM+Rsndb
        U2VBXLawz9KEgMRouXTtc19LmsHt2887bGmOLDMvNCGd7+YvYBHz0m2+3251pjG6WK1Wy8bF
        6+N1WnqBtLDLnCqjMjknv4fn7bxjRichQyJykfGAtydFGX98IKwudqXB9Xr3pVODfZMbTCln
        nh6rv9U4d86XyLbOnJKJ9FUn9UomhnFLJsvVV2weFPcq+9zAePMW+c4Utq2vdIjqWdi19yKj
        HIm++XHRwbChQ2Pqz9vWTLR6vDDSOI4eb9hcXLX2/p5Pleo18s6jjDO0saUkx3SRxgUjx0Rj
        DoH7B+BoBdi1AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFLMWRmVeSWpSXmKPExsWy7bCSnO7hhjNxBj8us1m8OTmVxWLP3pMs
        Fpd3zWGzuPz/E4vFsi+TWSx+TK93YPP4Muc4u0fb5H/sHs3HVrJ59G1ZxejxeZNcAGsUl01K
        ak5mWWqRvl0CV8aNnYfYC26YV9z+38jUwPhMu4uRk0NCwETi3OFtbF2MXBxCArsZJfbtWc3c
        xcgBlJCSOLhPE8IUljh8uBikXEjgOaPEy2tlIDabgK7Ekxs/mUFsEQF3iR0LD7CAjGEWuMgo
        sW3/c1aImYsZJaYumgFWxSkQJLHmwhxGEFtYQE/i47eXTCA2i4CqxO93E8BqeAUsJW6tWs4E
        YQtKnJz5hAXkCGag+raNYK3MAvIS29/OYYa4X0Fi96ejrBBHWEnM+raQDaJGRGJ2ZxvzBEbh
        WUgmzUKYNAvJpFlIOhYwsqxilEwtKM5Nzy02LDDMSy3XK07MLS7NS9dLzs/dxAiOHi3NHYzb
        V33QO8TIxMF4iFGCg1lJhNfp7Ok4Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rw3ChfGCQmkJ5ak
        ZqemFqQWwWSZODilGpg8U+p6zO6lXsk8oxf2XVa0SffGv6XVHd6Teezce6JKQ1L2v7x34OGL
        yC3y8bPm7ug3k3kyecsS957kx2+DqvYfib9rOEW5lLuuiFeLk80l77y9+u6UZoHKbdznfdR/
        dW2ZsZXRYrKI1cTlyQemrl3lcyApMLbzxjb2Y3dVPNepfz545QefnVtpZ3b0tDLpA3d4j9xZ
        M6EjZuEH98f+X01ZUpKVe/6wGyhrVzao5RzXCHm82fY13yleuYSQ2Q4l5yd4fq8/dUPlbOb3
        ltnb/ooeP/rnwL8va7W0N57eeqzNRP2yfN88kxMPqu2/hbWInJVgTRKLfnRgZ+t9P2vpggyR
        TvMLC69GmyfprLgtLajEUpyRaKjFXFScCACfqoQYDQMAAA==
X-CMS-MailID: 20200526023651epcas1p130ad5c31ea73ae06835320f72351b46a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200520075735epcas1p269372d222e25f3fd51b7979f5b7cdc61
References: <CGME20200520075735epcas1p269372d222e25f3fd51b7979f5b7cdc61@epcas1p2.samsung.com>
        <20200520075641.32441-1-kohada.tetsuhiro@dc.mitsubishielectric.co.jp>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Optimize directory access based on exfat_entry_set_cache.
>  - Hold bh instead of copied d-entry.
>  - Modify bh->data directly instead of the copied d-entry.
>  - Write back the retained bh instead of rescanning the d-entry-set.
> And
>  - Remove unused cache related definitions.
> 
> Signed-off-by: Tetsuhiro Kohada
> <kohada.tetsuhiro@dc.mitsubishielectric.co.jp>
> ---
>  fs/exfat/dir.c      | 197 +++++++++++++++++---------------------------
>  fs/exfat/exfat_fs.h |  27 +++---
>  fs/exfat/file.c     |  15 ++--
>  fs/exfat/inode.c    |  53 +++++-------
>  fs/exfat/namei.c    |  14 ++--
>  5 files changed, 124 insertions(+), 182 deletions(-)
[snip]
> 
> -	es->entries[0].dentry.file.checksum = cpu_to_le16(chksum);
> +void exfat_free_dentry_set(struct exfat_entry_set_cache *es, int sync)
> +{
> +	int i;
> 
> -	while (num_entries) {
> -		/* write per sector base */
> -		remaining_byte_in_sector = (1 << sb->s_blocksize_bits) -
off;
> -		copy_entries = min_t(int,
> -			EXFAT_B_TO_DEN(remaining_byte_in_sector),
> -			num_entries);
> -		bh = sb_bread(sb, sec);
> -		if (!bh)
> -			goto err_out;
> -		memcpy(bh->b_data + off,
> -			(unsigned char *)&es->entries[0] + buf_off,
> -			EXFAT_DEN_TO_B(copy_entries));
> -		exfat_update_bh(sb, bh, sync);
> -		brelse(bh);
> -		num_entries -= copy_entries;
> -
> -		if (num_entries) {
> -			/* get next sector */
> -			if (exfat_is_last_sector_in_cluster(sbi, sec)) {
> -				clu = exfat_sector_to_cluster(sbi, sec);
> -				if (es->alloc_flag == ALLOC_NO_FAT_CHAIN)
> -					clu++;
> -				else if (exfat_get_next_cluster(sb, &clu))
> -					goto err_out;
> -				sec = exfat_cluster_to_sector(sbi, clu);
> -			} else {
> -				sec++;
> -			}
> -			off = 0;
> -			buf_off += EXFAT_DEN_TO_B(copy_entries);
> -		}
> +	for (i = 0; i < es->num_bh; i++) {
> +		if (es->modified)
> +			exfat_update_bh(es->sb, es->bh[i], sync);

Overall, it looks good to me.
However, if "sync" is set, it looks better to return the result of
exfat_update_bh().
Of course, a tiny modification for exfat_update_bh() is also required.

> +		brelse(es->bh[i]);
>  	}
> -
> -	return 0;
> -err_out:
> -	return -EIO;
> +	kfree(es);
>  }
> 
>  static int exfat_walk_fat_chain(struct super_block *sb, @@ -820,34
> +786,40 @@ static bool exfat_validate_entry(unsigned int type,
>  	}
>  }
> 
> +struct exfat_dentry *exfat_get_dentry_cached(
> +	struct exfat_entry_set_cache *es, int num) {
> +	int off = es->start_off + num * DENTRY_SIZE;
> +	struct buffer_head *bh = es->bh[EXFAT_B_TO_BLK(off, es->sb)];
> +	char *p = bh->b_data + EXFAT_BLK_OFFSET(off, es->sb);

In order to prevent illegal accesses to bh and dentries, it would be better
to check validation for num and bh.

> +
> +	return (struct exfat_dentry *)p;
> +}
> +
>  /*
>   * Returns a set of dentries for a file or dir.
>   *
> - * Note that this is a copy (dump) of dentries so that user should
> - * call write_entry_set() to apply changes made in this entry set
> - * to the real device.
> + * Note It provides a direct pointer to bh->data via
> exfat_get_dentry_cached().
> + * User should call exfat_get_dentry_set() after setting 'modified' to
> + apply
> + * changes made in this entry set to the real device.
>   *
>   * in:
[snip]
>  	/* check if the given file ID is opened */ @@ -153,12 +151,15 @@
> int __exfat_truncate(struct inode *inode, loff_t new_size)
>  	/* update the directory entry */
>  	if (!evict) {
>  		struct timespec64 ts;
> +		struct exfat_dentry *ep, *ep2;
> +		struct exfat_entry_set_cache *es;
> 
>  		es = exfat_get_dentry_set(sb, &(ei->dir), ei->entry,
> -				ES_ALL_ENTRIES, &ep);
> +				ES_ALL_ENTRIES);
>  		if (!es)
>  			return -EIO;
> -		ep2 = ep + 1;
> +		ep = exfat_get_dentry_cached(es, 0);
> +		ep2 = exfat_get_dentry_cached(es, 1);
> 
>  		ts = current_time(inode);
>  		exfat_set_entry_time(sbi, &ts,
> @@ -185,10 +186,8 @@ int __exfat_truncate(struct inode *inode, loff_t
> new_size)
>  			ep2->dentry.stream.start_clu = EXFAT_FREE_CLUSTER;
>  		}
> 
> -		if (exfat_update_dir_chksum_with_entry_set(sb, es,
> -		    inode_needs_sync(inode)))
> -			return -EIO;
> -		kfree(es);
> +		exfat_update_dir_chksum_with_entry_set(es);
> +		exfat_free_dentry_set(es, inode_needs_sync(inode));

It would be better to return the result of exfat_free_dentry_set().

>  	}
> 
>  	/* cut off from the FAT chain */
> diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c index
> 3f367d081cd6..ef7cf7a6d187 100644
> --- a/fs/exfat/inode.c
> +++ b/fs/exfat/inode.c
> @@ -19,7 +19,6 @@
> 
>  static int __exfat_write_inode(struct inode *inode, int sync)  {
> -	int ret = -EIO;
>  	unsigned long long on_disk_size;
>  	struct exfat_dentry *ep, *ep2;
>  	struct exfat_entry_set_cache *es = NULL; @@ -43,11 +42,11 @@ static
> int __exfat_write_inode(struct inode *inode, int sync)
>  	exfat_set_vol_flags(sb, VOL_DIRTY);
> 
>  	/* get the directory entry of given file or directory */
> -	es = exfat_get_dentry_set(sb, &(ei->dir), ei->entry, ES_ALL_ENTRIES,
> -		&ep);
> +	es = exfat_get_dentry_set(sb, &(ei->dir), ei->entry,
> ES_ALL_ENTRIES);
>  	if (!es)
>  		return -EIO;
> -	ep2 = ep + 1;
> +	ep = exfat_get_dentry_cached(es, 0);
> +	ep2 = exfat_get_dentry_cached(es, 1);
> 
>  	ep->dentry.file.attr = cpu_to_le16(exfat_make_attr(inode));
> 
> @@ -77,9 +76,9 @@ static int __exfat_write_inode(struct inode *inode, int
> sync)
>  	ep2->dentry.stream.valid_size = cpu_to_le64(on_disk_size);
>  	ep2->dentry.stream.size = ep2->dentry.stream.valid_size;
> 
> -	ret = exfat_update_dir_chksum_with_entry_set(sb, es, sync);
> -	kfree(es);
> -	return ret;
> +	exfat_update_dir_chksum_with_entry_set(es);
> +	exfat_free_dentry_set(es, sync);

Ditto

> +	return 0;
>  }
> 
>  int exfat_write_inode(struct inode *inode, struct writeback_control *wbc)
> @@ -110,8 +109,6 @@ static int exfat_map_cluster(struct inode *inode,
> unsigned int clu_offset,
>  	int ret, modified = false;
>  	unsigned int last_clu;
>  	struct exfat_chain new_clu;
> -	struct exfat_dentry *ep;
> -	struct exfat_entry_set_cache *es = NULL;
>  	struct super_block *sb = inode->i_sb;
>  	struct exfat_sb_info *sbi = EXFAT_SB(sb);
>  	struct exfat_inode_info *ei = EXFAT_I(inode); @@ -222,34 +219,28 @@
> static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
>  		num_clusters += num_to_be_allocated;
>  		*clu = new_clu.dir;
> 
[snip]
> -
> -			if (exfat_update_dir_chksum_with_entry_set(sb, es,
> -			    inode_needs_sync(inode)))
> -				return -EIO;
> -			kfree(es);
> +			ep->dentry.stream.flags = ei->flags;
> +			ep->dentry.stream.start_clu =
> +				cpu_to_le32(ei->start_clu);
> +			ep->dentry.stream.valid_size =
> +				cpu_to_le64(i_size_read(inode));
> +			ep->dentry.stream.size =
> +				ep->dentry.stream.valid_size;
> +
> +			exfat_update_dir_chksum_with_entry_set(es);
> +			exfat_free_dentry_set(es, inode_needs_sync(inode));

Ditto

> 
>  		} /* end of if != DIR_DELETED */
> 
[snip]
> --
> 2.25.0


