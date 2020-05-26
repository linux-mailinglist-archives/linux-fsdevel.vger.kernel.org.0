Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 360241E3207
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 May 2020 00:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391037AbgEZWGh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 May 2020 18:06:37 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53238 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389342AbgEZWGg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 May 2020 18:06:36 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04QM26Ra180054;
        Tue, 26 May 2020 22:06:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=RwI6eQ2bbknJ1r4XNGglP0jMsY6x/X/sOPh2/0y8Kzg=;
 b=Mnmh8AbVLi4wo6YwvLkhJuvQYH5+E5BdCzvER1Yn71YCKszo3UZDeYCw5AWk2vxl9yLW
 K7cR4yMXSXUi6p+aPuEE3pEMVl4nB3NfUL4j3RPupZh9jhhwvU1kxYiZ6czF4J54dIzh
 v9UPafW7bXEfxokJCBqvUxipgsLCTnuYMkIVy6iymjrA98w37Kh+WRJIjLBC8BRCrMKS
 IP8fpVRa6kJrm4WRCgHSry+yXqpHlJJ8D0NMujL4sKz+YWeVkedx3IJ2PcLwosXmGinQ
 Wod+knJCysGjE3Z9B7jwh13bkHuIeIAxEJ9hPN6krwSWqe/UA7K2F6pNk9ujPUYLkVPy 5A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 318xe1cc7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 May 2020 22:06:07 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04QLxXVN137341;
        Tue, 26 May 2020 22:06:06 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 317j5pq0x4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 May 2020 22:06:06 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04QM5x9T002437;
        Tue, 26 May 2020 22:05:59 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 26 May 2020 15:05:59 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v4 36/36] mm: Align THP mappings for non-DAX
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20200515131656.12890-37-willy@infradead.org>
Date:   Tue, 26 May 2020 16:05:58 -0600
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B06C1160-D40B-4D38-8ECF-F8BDE80F6DC0@oracle.com>
References: <20200515131656.12890-1-willy@infradead.org>
 <20200515131656.12890-37-willy@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9633 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005260169
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9633 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 cotscore=-2147483648 mlxscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1011 impostorscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005260169
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thinking about this, if the intent is to make THP usable for any
greater than PAGESIZE page size, this routine should probably go back
to taking a size or perhaps order parameter so it could be called to
align addresses accordingly rather than hard code PMD_SIZE.


> On May 15, 2020, at 7:16 AM, Matthew Wilcox <willy@infradead.org> =
wrote:
>=20
> From: William Kucharski <william.kucharski@oracle.com>
>=20
> When we have the opportunity to use transparent huge pages to map a
> file, we want to follow the same rules as DAX.
>=20
> Signed-off-by: William Kucharski <william.kucharski@oracle.com>
> [Inline __thp_get_unmapped_area() into thp_get_unmapped_area()]
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
> mm/huge_memory.c | 40 +++++++++++++---------------------------
> 1 file changed, 13 insertions(+), 27 deletions(-)
>=20
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 15a86b06befc..e78686b628ae 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -535,30 +535,30 @@ bool is_transparent_hugepage(struct page *page)
> }
> EXPORT_SYMBOL_GPL(is_transparent_hugepage);
>=20
> -static unsigned long __thp_get_unmapped_area(struct file *filp,
> -		unsigned long addr, unsigned long len,
> -		loff_t off, unsigned long flags, unsigned long size)
> +unsigned long thp_get_unmapped_area(struct file *filp, unsigned long =
addr,
> +		unsigned long len, unsigned long pgoff, unsigned long =
flags)
> {
> +	loff_t off =3D (loff_t)pgoff << PAGE_SHIFT;
> 	loff_t off_end =3D off + len;
> -	loff_t off_align =3D round_up(off, size);
> +	loff_t off_align =3D round_up(off, PMD_SIZE);
> 	unsigned long len_pad, ret;
>=20
> -	if (off_end <=3D off_align || (off_end - off_align) < size)
> -		return 0;
> +	if (off_end <=3D off_align || (off_end - off_align) < PMD_SIZE)
> +		goto regular;
>=20
> -	len_pad =3D len + size;
> +	len_pad =3D len + PMD_SIZE;
> 	if (len_pad < len || (off + len_pad) < off)
> -		return 0;
> +		goto regular;
>=20
> 	ret =3D current->mm->get_unmapped_area(filp, addr, len_pad,
> 					      off >> PAGE_SHIFT, flags);
>=20
> 	/*
> -	 * The failure might be due to length padding. The caller will =
retry
> -	 * without the padding.
> +	 * The failure might be due to length padding.  Retry without
> +	 * the padding.
> 	 */
> 	if (IS_ERR_VALUE(ret))
> -		return 0;
> +		goto regular;
>=20
> 	/*
> 	 * Do not try to align to THP boundary if allocation at the =
address
> @@ -567,23 +567,9 @@ static unsigned long =
__thp_get_unmapped_area(struct file *filp,
> 	if (ret =3D=3D addr)
> 		return addr;
>=20
> -	ret +=3D (off - ret) & (size - 1);
> +	ret +=3D (off - ret) & (PMD_SIZE - 1);
> 	return ret;
> -}
> -
> -unsigned long thp_get_unmapped_area(struct file *filp, unsigned long =
addr,
> -		unsigned long len, unsigned long pgoff, unsigned long =
flags)
> -{
> -	unsigned long ret;
> -	loff_t off =3D (loff_t)pgoff << PAGE_SHIFT;
> -
> -	if (!IS_DAX(filp->f_mapping->host) || =
!IS_ENABLED(CONFIG_FS_DAX_PMD))
> -		goto out;
> -
> -	ret =3D __thp_get_unmapped_area(filp, addr, len, off, flags, =
PMD_SIZE);
> -	if (ret)
> -		return ret;
> -out:
> +regular:
> 	return current->mm->get_unmapped_area(filp, addr, len, pgoff, =
flags);
> }
> EXPORT_SYMBOL_GPL(thp_get_unmapped_area);
> --=20
> 2.26.2
>=20

