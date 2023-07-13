Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65150751EE9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 12:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbjGMKgL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 06:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjGMKgK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 06:36:10 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B011BE3
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jul 2023 03:36:07 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230713103604euoutp01bea0fb10cdd1b49c3501a1b543ebfdd5~xZvtWBvnY2675326753euoutp01U
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jul 2023 10:36:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230713103604euoutp01bea0fb10cdd1b49c3501a1b543ebfdd5~xZvtWBvnY2675326753euoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1689244564;
        bh=s29oTsNdA6AOkv2q7awRhtrV4xQfy49uD8Iv+7noKLo=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=J3FNiRzh2iFHbOc+bqt55NPNz9PTjf3fpcVkcHIJReVXY5p8Z40+/iSRBrSwj+i5F
         pZLzVUxR1Ip37zAWXX55HuFbPVlpqA4lCK+38Yo+p30xz/dSV54Zr0UZqssMKr/3I9
         3/hKcafPJ+HpKS9r2omm523Qw7l/sM2OLClRfC7I=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230713103604eucas1p2c7e041a3db554075210f4d4a7c04a058~xZvtIIddm2639826398eucas1p2i;
        Thu, 13 Jul 2023 10:36:04 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 13.C5.42423.493DFA46; Thu, 13
        Jul 2023 11:36:04 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230713103604eucas1p227fd0734b3629e0c8a1f1175f4d083ea~xZvs1Uoq12654826548eucas1p20;
        Thu, 13 Jul 2023 10:36:04 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230713103604eusmtrp29e662ff3dacf6a3d660c130f13c99b77~xZvs0pQ7z1997719977eusmtrp2H;
        Thu, 13 Jul 2023 10:36:04 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-ed-64afd394af49
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 60.ED.10549.493DFA46; Thu, 13
        Jul 2023 11:36:04 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230713103604eusmtip1659a0783f2ce26b5c68558330b5cb864~xZvsopOEW1235012350eusmtip1X;
        Thu, 13 Jul 2023 10:36:04 +0000 (GMT)
Received: from [106.110.32.65] (106.110.32.65) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Thu, 13 Jul 2023 11:36:03 +0100
Message-ID: <98e30ed3-e9b1-2869-b31e-32b099ef3865@samsung.com>
Date:   Thu, 13 Jul 2023 12:36:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.13.0
Subject: Re: [PATCH 3/7] affs: Convert data read and write to use folios
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     David Sterba <dsterba@suse.com>, <linux-fsdevel@vger.kernel.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        <ntfs3@lists.linux.dev>, Theodore Tso <tytso@mit.edu>,
        Jan Kara <jack@suse.com>, <linux-ext4@vger.kernel.org>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <20230713035512.4139457-4-willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.110.32.65]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUhTYRTGe3fv7u4G2m2mniyKVkbNtCSNW6ZYFo2gspSK/COH3pY1dWwz
        tehjYV9TMi0xl5UmlVa0cEtbNWSLrJVEn7aZYX6hs8RSk+lSc14D//u9z3kOPM/hJTHhQ24A
        mZKmZpRpUrmIEOA19cNvgy9/1CevdNYsoUv19wm6sd3Ko9+5NBy6604FokuuNxP0M7MNp6va
        H3Ho03nDPNrtKiWi+RJDpVjy6oobl3QbSpDkVMMLTFJifYdL9MbPuGSgen4sb69gXTIjTznM
        KFdEJQoOtLaMcBVdc7OK6sq5J1GnrxbxSaDCoNZgITwspCoR/CpfqkWCCR5EcGb0LsE+BhAY
        ypq5/zcuXB/G2MEdBI4vesSuT7ieu46wbELg+rrVw15UFOSa2jEP41QgaMY/8Vh9FthKOnAP
        +1IJoG83T8bwoSQw6NRwPIxR/tDUcWOSZ1OJYC9r5bG6C8EDt7cWkSRBiUFzflLmUxHQlmfh
        spZlcLrWPWVfALW9pRibfyEUOvqmuhyD18YmjqcLUMV8yBl8j7ODjTA0MDRl8oGel0Yey/Ng
        3MTmAeoodNrdGLucgyDfpCc8gWAixYUGOetZD64cB5eVvcHeO4vN4w2FNcXYRRSom3YJ3bTG
        umkVdNMqlCH8LvJnMlSpMkYVmsZkhqikqaqMNFlIUnpqNZr4VG/GXvY/Rtd6fodYEYdEVgQk
        JprttbjmQbLQK1mafYRRpu9TZsgZlRXNJXGRv1dQpC1JSMmkauYQwygY5f8ph+QHnOTs+JaZ
        53fWoC6U960e+1D9KD9+o6NrdXhR+JoKav+awfR815/s1rGrlh/Oe6ah3D5k2TmC2cqPh/sc
        1RTVNzSaI8PuXXXWdUTvWfHC+P5G5tu6Les/JfrFaF3d9jNcv/s3RzflaCsVRuRbNTOou7dA
        nJIVXCcOiI2PMDerHZErr40nJcTpxHMOLsoVBPHXfogZ35W14XujOWFtzJNVHMU2mSl/NCzC
        f+QUFET8ia/HLNHCHZrdqlHRch4i/h7uf7y9Bfk8bCuYkX2p83boifnqpyO2c/ZbwYrzpuIM
        2Qz78s0x62SKzN8/g8863QfbbrZVC6KGAiOL58VVmHsEzbwlIlx1QBoqxpQq6T9dClufwwMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsVy+t/xu7pTLq9PMXh7kN9izvo1bBbXHh9i
        t7jwo5HJ4vnyxYwWM+fdYbPYs/cki8XKx1uZLFp7frJb/P4xh82B02PzCi2PEzN+s3i82DyT
        0aPpzFFmj5mHLrB4rN9ylcXj8ya5APYoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2Pz
        WCsjUyV9O5uU1JzMstQifbsEvYyH93+xFjyXrpi6fyFrA+NT0S5GTg4JAROJvnk/mbsYuTiE
        BJYyShxtO8UOkZCR2PjlKiuELSzx51oXG0TRR0aJkx8+s0A4Oxkluq5CVPEK2El073zMDGKz
        CKhKNP6/wg4RF5Q4OfMJC4gtKhAtseHCIzBbWMBD4svLRiYQm1lAXOLWk/lgtohAgsSNBQ/Z
        IeI/GCXW/eaDWLafUaLt+zGgZg4ONgEticZOsBpOAWuJRz0HWSHqNSVat/+G6pWX2P52DjPE
        B4oSk26+h/qmVuLz32eMExhFZyE5bxaSM2YhGTULyagFjCyrGEVSS4tz03OLDfWKE3OLS/PS
        9ZLzczcxAqN827Gfm3cwznv1Ue8QIxMH4yFGCQ5mJRFelW3rUoR4UxIrq1KL8uOLSnNSiw8x
        mgLDaCKzlGhyPjDN5JXEG5oZmBqamFkamFqaGSuJ83oWdCQKCaQnlqRmp6YWpBbB9DFxcEo1
        MNlz2PlemJp7Rf3M3NNrNrKovt5iHmQy9dTl1iYLiyUm2TpHavWXrjWevebc9V1Zf8S21z1K
        +8D8N3F2tm0El9RXR5Pllgai32zVMt7dfCfmEWik9Efk+rbYR01nWlJj2b1lvJTzKucpPDrm
        4RLnxydfxuv6R9vIZbs5X5PUn0fKsp07dmg63W+9YOSgwueVIhH84QGbb3rDydJm4ZSzUx67
        xt+8pPbHUGAF3/X0c0L6YQ87w+ZpbLutmnVTq4ajY9cL/l+c+r8CJXY+f+5448/R78c7vCWi
        Wrs7J6uqvJx7ZTL/j9ANpolsj+tU96yeVpj8+aPx172vlZJlm+ruLOkSeqzdvSL59f291/cy
        K7EUZyQaajEXFScCAHq6kaR7AwAA
X-CMS-MailID: 20230713103604eucas1p227fd0734b3629e0c8a1f1175f4d083ea
X-Msg-Generator: CA
X-RootMTR: 20230713035542eucas1p2cbb80eae0876527c2ba3d5b7dc46c906
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230713035542eucas1p2cbb80eae0876527c2ba3d5b7dc46c906
References: <20230713035512.4139457-1-willy@infradead.org>
        <CGME20230713035542eucas1p2cbb80eae0876527c2ba3d5b7dc46c906@eucas1p2.samsung.com>
        <20230713035512.4139457-4-willy@infradead.org>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023-07-13 05:55, Matthew Wilcox (Oracle) wrote:
> We still need to convert to/from folios in write_begin & write_end
> to fit the API, but this removes a lot of calls to old page-based
> functions, removing many hidden calls to compound_head().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good to me except one minor nit!

Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>

> @@ -624,25 +623,23 @@ affs_extent_file_ofs(struct inode *inode, u32 newsize)
>  	return PTR_ERR(bh);
>  }
>  
> -static int
> -affs_read_folio_ofs(struct file *file, struct folio *folio)
> +static int affs_read_folio_ofs(struct file *file, struct folio *folio)
>  {
> -	struct page *page = &folio->page;
> -	struct inode *inode = page->mapping->host;
> -	u32 to;
> +	struct inode *inode = folio->mapping->host;
> +	size_t to;
>  	int err;
>  
> -	pr_debug("%s(%lu, %ld)\n", __func__, inode->i_ino, page->index);
> -	to = PAGE_SIZE;
> -	if (((page->index + 1) << PAGE_SHIFT) > inode->i_size) {
> -		to = inode->i_size & ~PAGE_MASK;
> -		memset(page_address(page) + to, 0, PAGE_SIZE - to);
> +	pr_debug("%s(%lu, %ld)\n", __func__, inode->i_ino, folio->index);
> +	to = folio_size(folio);
> +	if (folio_pos(folio) + to > inode->i_size) {
> +		to = inode->i_size - folio_pos(folio);
> +		folio_zero_segment(folio, to, folio_size(folio));

This change makes the code more readable!

>  	}
>  
> -	err = affs_do_readpage_ofs(page, to, 0);
> +	err = affs_do_read_folio_ofs(folio, to, 0);
>  	if (!err)
> @@ -688,6 +686,7 @@ static int affs_write_end_ofs(struct file *file, struct address_space *mapping,
>  				loff_t pos, unsigned len, unsigned copied,
>  				struct page *page, void *fsdata)
>  {
> +	struct folio *folio = page_folio(page);
>  	struct inode *inode = mapping->host;
>  	struct super_block *sb = inode->i_sb;
>  	struct buffer_head *bh, *prev_bh;
> @@ -701,18 +700,18 @@ static int affs_write_end_ofs(struct file *file, struct address_space *mapping,
>  	to = from + len;
>  	/*
>  	 * XXX: not sure if this can handle short copies (len < copied), but
> -	 * we don't have to, because the page should always be uptodate here,
> +	 * we don't have to, because the folio should always be uptodate here,
>  	 * due to write_begin.
>  	 */
>  
>  	pr_debug("%s(%lu, %llu, %llu)\n", __func__, inode->i_ino, pos,
>  		 pos + len);
>  	bsize = AFFS_SB(sb)->s_data_blksize;
> -	data = page_address(page);
> +	data = folio_address(folio);
>  
>  	bh = NULL;
>  	written = 0;
> -	tmp = (page->index << PAGE_SHIFT) + from;
> +	tmp = (folio->index << PAGE_SHIFT) + from;

Can this be made to:

tmp = folio_pos(folio) + from;

Similar to what is being done in affs_do_read_folio_ofs()

>  	bidx = tmp / bsize;
>  	boff = tmp % bsize;
>  	if (boff) {
> @@ -804,11 +803,11 @@ static int affs_write_end_ofs(struct file *file, struct address_space *mapping,
>  		from += tmp;
>  		bidx++;
>  	}
> -	SetPageUptodate(page);
> +	folio_mark_uptodate(folio);
>  
>  done:
>  	affs_brelse(bh);
> -	tmp = (page->index << PAGE_SHIFT) + from;
> +	tmp = (folio->index << PAGE_SHIFT) + from;

Same as the previous comment.

>  	if (tmp > inode->i_size)
>  		inode->i_size = AFFS_I(inode)->mmu_private = tmp;
>  
> @@ -819,8 +818,8 @@ static int affs_write_end_ofs(struct file *file, struct address_space *mapping,
>  	}
>  
>  err_first_bh:
> -	unlock_page(page);
> -	put_page(page);
> +	folio_unlock(folio);
> +	folio_put(folio);
>  
>  	return written;
>  
