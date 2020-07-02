Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70A922122F5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jul 2020 14:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbgGBMGj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jul 2020 08:06:39 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:58734 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728858AbgGBMGi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jul 2020 08:06:38 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200702120635epoutp046abf2cb2e32e94f99696ed6b02deda93~d7g-6_c891550015500epoutp04C
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2020 12:06:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200702120635epoutp046abf2cb2e32e94f99696ed6b02deda93~d7g-6_c891550015500epoutp04C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593691595;
        bh=ZQ01gWqn3aqpWarKTn3TYpqbWtfaHSSoGKKncEGzCu4=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=Q/z6vavN3M5nFvCSBGVgFOJcUMZPzLODo7VXB0qvrdu2pTVoYsX101aOyw8TKTjgR
         nDAj9GdB8zYtJKXRYPeUK6SRWYO5S17L4Nkf2V/0u6M2ClrWIKrkKP/ZutaZt5Muuf
         3QrFgmJEljf2pId2ao2zi9p+JcxNkOTFqfFZqJwc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200702120635epcas1p38ea29b0eff57578de895d87f617c7de0~d7g-b52aa1233912339epcas1p3B;
        Thu,  2 Jul 2020 12:06:34 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.165]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 49yGzG30JqzMqYkZ; Thu,  2 Jul
        2020 12:06:34 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        0D.E0.29173.ACDCDFE5; Thu,  2 Jul 2020 21:06:34 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200702120634epcas1p384fe522bf04eea1ada307a1a6fd48c80~d7g_e9Dm11164011640epcas1p3O;
        Thu,  2 Jul 2020 12:06:34 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200702120634epsmtrp2f3008b531791cb94cad858e6dd050016~d7g_eQdoe0177401774epsmtrp2S;
        Thu,  2 Jul 2020 12:06:34 +0000 (GMT)
X-AuditID: b6c32a37-9b7ff700000071f5-89-5efdcdca4d18
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7F.E2.08382.9CDCDFE5; Thu,  2 Jul 2020 21:06:33 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200702120633epsmtip2a440295c06fabd06a88890076f89b4c6~d7g_PA_tU1657616576epsmtip26;
        Thu,  2 Jul 2020 12:06:33 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     "'Tetsuhiro Kohada'" <kohada.t2@gmail.com>
Cc:     <kohada.tetsuhiro@dc.mitsubishielectric.co.jp>,
        <mori.takahiro@ab.mitsubishielectric.co.jp>,
        <motai.hirotaka@aj.mitsubishielectric.co.jp>,
        "'Namjae Jeon'" <namjae.jeon@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20200624023041.30247-1-kohada.t2@gmail.com>
Subject: RE: [PATCH v2] exfat: optimize exfat_zeroed_cluster()
Date:   Thu, 2 Jul 2020 21:06:33 +0900
Message-ID: <000001d65069$3a78c5f0$af6a51d0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQIesF+OtlZHZt+xlFHZAmUunjWjpQK9BQUgqE2IatA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNJsWRmVeSWpSXmKPExsWy7bCmvu6ps3/jDA7eF7H4Mfc2i8Wbk1NZ
        LPbsPclicXnXHDaLy/8/sVgs+zKZxeLH9HoHdo8vc46ze7RN/sfu0XxsJZvHzll32T36tqxi
        9Pi8SS6ALSrHJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNct
        MwfoFCWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgaFBgV5xYm5xaV66XnJ+rpWh
        gYGRKVBlQk7Glc+HmQo+CFVcO3SEtYGxk6+LkZNDQsBE4uycn4xdjFwcQgI7GCUuT17GCJIQ
        EvjEKNHcoAiR+MYo0X54EhtMx/zVM1ggEnsZJRb+fMMO4bxklFh85hArSBWbgK7Ekxs/mUFs
        EQE9iZMnr4N1Mws0MkmceJkNYnMKWEqsndwCVi8sYCdxu/cRC4jNIqAisXjeVjCbF6jm/oeL
        ULagxMmZT1gg5shLbH87hxniIgWJ3Z+OAs3hANplJfH0vThEiYjE7M42ZpDbJATmckg03n3N
        DFIjIeAicWSRHkSrsMSr41vYIWwpic/v9kI9WS+xe9UpFojeBkaJI48WskAkjCXmtywEm8Ms
        oCmxfpc+RFhRYufvuYwQe/kk3n3tYYVYxSvR0SYEUaIi8f3DThaYVVd+XGWawKg0C8ljs5A8
        NgvJB7MQli1gZFnFKJZaUJybnlpsWGCMHNebGMGpVMt8B+O0tx/0DjEycTAeYpTgYFYS4T1t
        8CtOiDclsbIqtSg/vqg0J7X4EKMpMKgnMkuJJucDk3leSbyhqZGxsbGFiZm5mamxkjivr9WF
        OCGB9MSS1OzU1ILUIpg+Jg5OqQamLWZzvksdFW222pak+meXq+2t7x9n80eX3zt4z/J+WcQM
        gTVOCrdUzp4I8e/4fmfWOabv7kUrDzy6bN6w7W375lc5B4wfTnF6vurdkq0v7/TO2eZQ97FR
        nmVe66s955lfBStKLnzmtLLtcqn2rJWdylMWHxTjk5WwVued1frJxbbdsNbM2iA+8FY3Z0L6
        23qjYw66GW5XBM7OsTF8P/1y6vmLBlfdL0X+UNq74CHDkTf/rz+snnzsXV/oj9RtxtPv3mhL
        8L3GcmeesGjbRbsXKdfXVE5gCe3+k7fNt/XyOYkdZ3KsVR0K5p/hX8uxcOZP8d7r5pqbTz38
        oLQ4tvBm9vsi51dicy25I+98F79ZNEuJpTgj0VCLuag4EQBzJQi5LgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphkeLIzCtJLcpLzFFi42LZdlhJXvfk2b9xBv0LTSx+zL3NYvHm5FQW
        iz17T7JYXN41h83i8v9PLBbLvkxmsfgxvd6B3ePLnOPsHm2T/7F7NB9byeaxc9Zddo++LasY
        PT5vkgtgi+KySUnNySxLLdK3S+DKuPL5MFPBB6GKa4eOsDYwdvJ1MXJySAiYSMxfPYOli5GL
        Q0hgN6PE3M4djF2MHEAJKYmD+zQhTGGJw4eLIUqeM0ocuX6KGaSXTUBX4smNn2C2iICexMmT
        19lAipgFmpkkWr80M0F0dDFKfHrVBlbFKWApsXZyCyuILSxgJ3G79xELiM0ioCKxeN5WMJsX
        qOb+h4tQtqDEyZlPWECuYAba0LaRESTMLCAvsf3tHGaIBxQkdn86ygpSIiJgJfH0vThEiYjE
        7M425gmMwrOQDJqFMGgWkkGzkHQsYGRZxSiZWlCcm55bbFhgmJdarlecmFtcmpeul5yfu4kR
        HFFamjsYt6/6oHeIkYmD8RCjBAezkgjvaYNfcUK8KYmVValF+fFFpTmpxYcYpTlYlMR5bxQu
        jBMSSE8sSc1OTS1ILYLJMnFwSjUwBYZMT69Q39J4+vkihpm3W1mNk2RvTOXmFVb9Lsm5P++Q
        U/mBUoVanvzVLqEbJBemlth7doUuU3GqXLjMdy1jcWXqyf6aa9INhS6Fa2Yen7LzXp/E9n/l
        tYpihxt1fs2MqdM5uiyU8fenH7/nrqhs72ZrncrU7H5ZiWXKh1TOe/o87iozXDhsljpvbDqV
        tlI2T01wwtLbNcc03lkquc69cNo2+HTbLvXHf/d/Xfriyt2Nh3qFbKtYZN7bXXucJLpbS37d
        eh7h8r12/uInQ77dvOP9JiRXUa9wr1tQ7vagi+tbBIOLd+kx6TqaTNp8lTX79cnijBtfwzao
        XufYreN9etlkw82832LVlFRWc15QYinOSDTUYi4qTgQAktqjpxcDAAA=
X-CMS-MailID: 20200702120634epcas1p384fe522bf04eea1ada307a1a6fd48c80
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200624023050epcas1p1f794fee8957367322d27f828aead2ebc
References: <CGME20200624023050epcas1p1f794fee8957367322d27f828aead2ebc@epcas1p1.samsung.com>
        <20200624023041.30247-1-kohada.t2@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Replace part of exfat_zeroed_cluster() with exfat_update_bhs().
> And remove exfat_sync_bhs().
> 
> Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>

Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>

Looks good. Thanks.

> ---
> Changes in v2
>  - Rebase to latest exfat-dev
> 
>  fs/exfat/fatent.c | 53 +++++++++--------------------------------------
>  1 file changed, 10 insertions(+), 43 deletions(-)
> 
> diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c index
> 82ee8246c080..c3c9afee7418 100644
> --- a/fs/exfat/fatent.c
> +++ b/fs/exfat/fatent.c
> @@ -229,21 +229,6 @@ int exfat_find_last_cluster(struct super_block *sb,
> struct exfat_chain *p_chain,
>  	return 0;
>  }
> 
> -static inline int exfat_sync_bhs(struct buffer_head **bhs, int nr_bhs) -{
> -	int i, err = 0;
> -
> -	for (i = 0; i < nr_bhs; i++)
> -		write_dirty_buffer(bhs[i], 0);
> -
> -	for (i = 0; i < nr_bhs; i++) {
> -		wait_on_buffer(bhs[i]);
> -		if (!err && !buffer_uptodate(bhs[i]))
> -			err = -EIO;
> -	}
> -	return err;
> -}
> -
>  int exfat_zeroed_cluster(struct inode *dir, unsigned int clu)  {
>  	struct super_block *sb = dir->i_sb;
> @@ -265,41 +250,23 @@ int exfat_zeroed_cluster(struct inode *dir, unsigned
> int clu)
>  	}
> 
>  	/* Zeroing the unused blocks on this cluster */
> -	n = 0;
>  	while (blknr < last_blknr) {
> -		bhs[n] = sb_getblk(sb, blknr);
> -		if (!bhs[n]) {
> -			err = -ENOMEM;
> -			goto release_bhs;
> -		}
> -		memset(bhs[n]->b_data, 0, sb->s_blocksize);
> -		exfat_update_bh(bhs[n], 0);
> -
> -		n++;
> -		blknr++;
> -
> -		if (n == nr_bhs) {
> -			if (IS_DIRSYNC(dir)) {
> -				err = exfat_sync_bhs(bhs, n);
> -				if (err)
> -					goto release_bhs;
> +		for (n = 0; n < nr_bhs && blknr < last_blknr; n++, blknr++)
> {
> +			bhs[n] = sb_getblk(sb, blknr);
> +			if (!bhs[n]) {
> +				err = -ENOMEM;
> +				goto release_bhs;
>  			}
> -
> -			for (i = 0; i < n; i++)
> -				brelse(bhs[i]);
> -			n = 0;
> +			memset(bhs[n]->b_data, 0, sb->s_blocksize);
>  		}
> -	}
> 
> -	if (IS_DIRSYNC(dir)) {
> -		err = exfat_sync_bhs(bhs, n);
> +		err = exfat_update_bhs(bhs, n, IS_DIRSYNC(dir));
>  		if (err)
>  			goto release_bhs;
> -	}
> -
> -	for (i = 0; i < n; i++)
> -		brelse(bhs[i]);
> 
> +		for (i = 0; i < n; i++)
> +			brelse(bhs[i]);
> +	}
>  	return 0;
> 
>  release_bhs:
> --
> 2.25.1


