Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D43E433F50F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Mar 2021 17:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbhCQQHc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Mar 2021 12:07:32 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:46556 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbhCQQH2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Mar 2021 12:07:28 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210317160726epoutp024d8559d3b327742f7d4659352347b0fe~tLO8Ec8KS1913019130epoutp02Q
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Mar 2021 16:07:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210317160726epoutp024d8559d3b327742f7d4659352347b0fe~tLO8Ec8KS1913019130epoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1615997246;
        bh=n0zZRnd8T3hVPp1YnknG772g+7440/OcsOH+e0Yx5wA=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=j+GCg7sqdKZlQpXqUVyvtBFuzdj5gfGnde1c8IBHnSHHl6kMYomr5JpJ6GPpV4q4J
         8ANgS+6RzwGX9uS2nNjnXZNsPwrxihFG3ih3EOaSR2cvLS8twan/6NcavGWXQNHDU9
         1FyS90j9wLznJQfGNjEljuk4Rwymd3RY31rIoCH8=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210317160725epcas1p2c7d4d0353af586049e4cc26237190738~tLO7fv7B22508125081epcas1p2f;
        Wed, 17 Mar 2021 16:07:25 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.163]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4F0w623TzFz4x9Pt; Wed, 17 Mar
        2021 16:07:22 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        7D.E3.02418.A3922506; Thu, 18 Mar 2021 01:07:22 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210317160721epcas1p4f5e3f89765a74d6d52ea925e51546b9b~tLO3eqeks1413614136epcas1p45;
        Wed, 17 Mar 2021 16:07:21 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210317160721epsmtrp1432314af89509bf0c9ca2c68118fc625~tLO3eAw-K2051720517epsmtrp1B;
        Wed, 17 Mar 2021 16:07:21 +0000 (GMT)
X-AuditID: b6c32a35-c23ff70000010972-30-6052293a3f1d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        00.96.13470.93922506; Thu, 18 Mar 2021 01:07:21 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20210317160721epsmtip17c229866a97efb3e78b50eef1aa609e4~tLO3OvlB90869308693epsmtip1O;
        Wed, 17 Mar 2021 16:07:21 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     "'Hyeongseok Kim'" <hyeongseok@gmail.com>,
        <namjae.jeon@samsung.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <sj1557.seo@samsung.com>
In-Reply-To: <20210315043316.54508-1-hyeongseok@gmail.com>
Subject: RE: [PATCH] exfat: speed up iterate/lookup by fixing start point of
 traversing fat chain
Date:   Thu, 18 Mar 2021 01:07:21 +0900
Message-ID: <a64901d71b47$9cacb070$d6061150$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQMRXeWm1FdVqcQKkWlBKzzAsqBg6wFwmgHlqAg8K+A=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphk+LIzCtJLcpLzFFi42LZdlhTX9dKMyjBoHu1pMXfiZ+YLPbsPcli
        cXnXHDaLH9PrLbb8O8LqwOqxc9Zddo++LasYPT5vkgtgjsqxyUhNTEktUkjNS85PycxLt1Xy
        Do53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAHaqKRQlphTChQKSCwuVtK3synKLy1JVcjI
        Ly6xVUotSMkpMDQo0CtOzC0uzUvXS87PtTI0MDAyBapMyMlY9+I+Y8E5yYoZ894zNjDeFe5i
        5OSQEDCReN2yhKmLkYtDSGAHo8SDb1PYIZxPjBLX3i5jhnC+MUo8OjOTEaZle8c2qKq9jBKL
        +u6xQTgvGSU23b7DDlLFJqAr8eTGT2YQW0TAQ+Jx0zEmEJtZIF5i97Q+sEmcAlYSJ1YsYgOx
        hQWSJXp2r2AFsVkEVCWWd08Eq+EVsJR4seMHlC0ocXLmExaIOfIS29/OYYa4SEFi96ejrBC7
        rCR+Lm1mhKgRkZjd2Qb2goTAV3aJje/us0I0uEhsmvqFCcIWlnh1fAs7hC0l8bK/Dcqul/g/
        fy07RHMLo8TDT9uAGjiAHHuJ95csQExmAU2J9bv0IcoVJXb+ngu1l0/i3dceVohqXomONiGI
        EhWJ7x92ssBsuvLjKtMERqVZSD6bheSzWUg+mIWwbAEjyypGsdSC4tz01GLDAkPk2N7ECE6O
        WqY7GCe+/aB3iJGJg/EQowQHs5IIr2leQIIQb0piZVVqUX58UWlOavEhRlNgWE9klhJNzgem
        57ySeENTI2NjYwsTM3MzU2Mlcd4kgwfxQgLpiSWp2ampBalFMH1MHJxSDUzy1w/fSLiWXbk0
        oz361N5PZUHc/7rYmTI4ksqebAq88urmxcAtMXwyr/3ntYZOb3gSwb6bs1E+Tuw3m2qtj8zV
        swt5K7puslw/K3qFx9yn9znzXk/JmwwJHOxNS0r4jPr31HdbiS7VWlnSLjKJY4rztXXSgZVm
        tbynja765e68UOYpcPtHp/uUk1xykZFnrjgoLyqInb//cI/NX1dz71BZiV2Xru9ifOG1avWl
        P2rbwu88OyCb/54n8oDj2j9XGU59mHglnalHde07rS9/r84/XFL5s9wnc+H/VU/158ecLz0g
        cvNrQJQ+myXn1jXbE+1OZwrIWDM+z5osIGnarHFqtjZff7jhi2mzzziLVCqxFGckGmoxFxUn
        AgDdf6iuFwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsWy7bCSnK6lZlCCwZfPAhZ/J35istiz9ySL
        xeVdc9gsfkyvt9jy7wirA6vHzll32T36tqxi9Pi8SS6AOYrLJiU1J7MstUjfLoErY92L+4wF
        5yQrZsx7z9jAeFe4i5GTQ0LARGJ7xzb2LkYuDiGB3YwSM5ZuBnI4gBJSEgf3aUKYwhKHDxeD
        lAsJPGeUWHPJFsRmE9CVeHLjJzOILSLgJbG/6TU7iM0skCjR/OUSE0R9N6PE27emIDangJXE
        iRWL2EBsYaCaA/dbwWpYBFQllndPZASxeQUsJV7s+AFlC0qcnPmEBeQEZgE9ibaNjBDj5SW2
        v53DDHG9gsTuT0dZIU6wkvi5tBmqRkRidmcb8wRG4VlIJs1CmDQLyaRZSDoWMLKsYpRMLSjO
        Tc8tNiwwzEst1ytOzC0uzUvXS87P3cQIjg0tzR2M21d90DvEyMTBeIhRgoNZSYTXNC8gQYg3
        JbGyKrUoP76oNCe1+BCjNAeLkjjvha6T8UIC6YklqdmpqQWpRTBZJg5OqQamNY7/vN/NEnj6
        6vdkZyGGTNfrjqLyk/p4lRocj1+w/sea/CG4Mu9Zwd1nj02LrP5WLl21Qai6U+TDk0zNQ3xu
        oRxsWrdzpWcIf56l4niWd6rhnadmYbdWVAgXWX9bIcindvGvoMwFeztbNsHnjXvWmJ47KnS7
        Xf7al3mfBWrcvrUsbTk1SdG6evk10bPmEVnsu72DGs8YL1pknbo5njFcLz+t+P/FxUtVatd9
        VOCY3fFgtmvkc8boiw/Ec5Ye22L8Zs0ZWxuzqlIv98JFXNlaXcy92vMWWV9lXnzawuaTh4us
        xYr0Y+kLPpbNYD41mdF18oZUhS05L5p1HvFUXTvw0mVDdrxORNGdo77v2C8psRRnJBpqMRcV
        JwIAHlxmLvwCAAA=
X-CMS-MailID: 20210317160721epcas1p4f5e3f89765a74d6d52ea925e51546b9b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210315043335epcas1p2bf257806e9ba1c2a492739a6424a2b44
References: <CGME20210315043335epcas1p2bf257806e9ba1c2a492739a6424a2b44@epcas1p2.samsung.com>
        <20210315043316.54508-1-hyeongseok@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> When directory iterate and lookup is called, there is a buggy rewinding of
> start point for traversing fat chain to the directory entry's first
> cluster. This caused repeated fat chain traversing from the first entry of
> the directory that would show worse performance if huge amounts of files
> exist under single directory.
> Fix not to rewind, make continue from currently referenced cluster and dir
> entry.
> 
> Tested with 50,000 files under single directory / 256GB sdcard, with
> command "time ls -l > /dev/null",
> Before :     0m08.69s real     0m00.27s user     0m05.91s system
> After  :     0m07.01s real     0m00.25s user     0m04.34s system
> 
> Signed-off-by: Hyeongseok Kim <hyeongseok@gmail.com>
> ---
>  fs/exfat/dir.c | 42 +++++++++++++++++++++++++++++++++---------
>  1 file changed, 33 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c index
> e1d5536de948..59d12eaa0649 100644
> --- a/fs/exfat/dir.c
> +++ b/fs/exfat/dir.c
> @@ -147,7 +147,7 @@ static int exfat_readdir(struct inode *inode, loff_t
> *cpos, struct exfat_dir_ent
>  					0);
> 
>  			*uni_name.name = 0x0;
> -			exfat_get_uniname_from_ext_entry(sb, &dir, dentry,
> +			exfat_get_uniname_from_ext_entry(sb, &clu, i,
>  				uni_name.name);

Looks good. Old code looks like a bug as you said.

>  			exfat_utf16_to_nls(sb, &uni_name,
>  				dir_entry->namebuf.lfn,
> @@ -911,10 +911,15 @@ enum {
>  };
> 
>  /*
> - * return values:
> - *   >= 0	: return dir entiry position with the name in dir
> - *   -ENOENT	: entry with the name does not exist
> - *   -EIO	: I/O error
> + * @ei:         inode info of directory
> + * @p_dir:      input as directory structure in which we search name
> + *              if found, output as a cluster dir where the name exists
> + *              if not found, not changed from input
> + * @num_entries entry size of p_uniname
> + * @return:
> + *   >= 0:      dir entry position from output p_dir.dir
> + *   -ENOENT:   entry with the name does not exist
> + *   -EIO:      I/O error
>   */
>  int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info
> *ei,
>  		struct exfat_chain *p_dir, struct exfat_uni_name *p_uniname,
> @@ -925,14 +930,16 @@ int exfat_find_dir_entry(struct super_block *sb,
> struct exfat_inode_info *ei,
[snip]
  			hint_stat->clu = p_dir->dir;
>  			hint_stat->eidx = 0;
> -			return (dentry - num_ext);
> +
> +			exfat_chain_dup(p_dir, &tmp_clu);
> +			return dentry_in_cluster;
>  		}
>  	}
> 
>  	hint_stat->clu = clu.dir;
>  	hint_stat->eidx = dentry + 1;
> -	return dentry - num_ext;
> +
> +	exfat_chain_dup(p_dir, &tmp_clu);
> +	return dentry_in_cluster;
>  }

Changing the functionality of exfat find_dir_entry() will affect
exfat_find() and exfat_lookup(), breaking the concept of ei->dir.dir
which should have the starting cluster of its parent directory.

Well, is there any missing patch related to exfat_find()?
It would be nice to modify the caller of this function, exfat_find(),
so that this change in functionality doesn't affect other functions.

Thanks.

> 
>  int exfat_count_ext_entries(struct super_block *sb, struct exfat_chain
> *p_dir,
> --
> 2.27.0.83.g0313f36


