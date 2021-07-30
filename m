Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 312433DB484
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 09:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237816AbhG3Haf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 03:30:35 -0400
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:25024 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237737AbhG3Haf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 03:30:35 -0400
Received: from [10.0.2.15] ([86.243.172.93])
        by mwinf5d81 with ME
        id bKWP2500H21Fzsu03KWPbY; Fri, 30 Jul 2021 09:30:29 +0200
X-ME-Helo: [10.0.2.15]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 30 Jul 2021 09:30:29 +0200
X-ME-IP: 86.243.172.93
Subject: Re: [PATCH v27 05/10] fs/ntfs3: Add attrib operations
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        linux-fsdevel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        pali@kernel.org, dsterba@suse.cz, aaptel@suse.com,
        willy@infradead.org, rdunlap@infradead.org, joe@perches.com,
        mark@harmstone.com, nborisov@suse.com,
        linux-ntfs-dev@lists.sourceforge.net, anton@tuxera.com,
        dan.carpenter@oracle.com, hch@lst.de, ebiggers@kernel.org,
        andy.lavr@gmail.com, kari.argillander@gmail.com,
        oleksandr@natalenko.name
References: <20210729134943.778917-1-almaz.alexandrovich@paragon-software.com>
 <20210729134943.778917-6-almaz.alexandrovich@paragon-software.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <46dbc10f-37a1-80f7-b4b5-e49eb867eff2@wanadoo.fr>
Date:   Fri, 30 Jul 2021 09:30:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210729134943.778917-6-almaz.alexandrovich@paragon-software.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

below are a few comments based on a cppcheck run.
Don't take it too seriously into consideration, this is just a minor 
clean-up.

It is reported only if a new iteration is done and if it makes sense to 
include it.

CJ

Le 29/07/2021 à 15:49, Konstantin Komarov a écrit :
> This adds attrib operations
> 
> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> ---
>   fs/ntfs3/attrib.c   | 2082 +++++++++++++++++++++++++++++++++++++++++++
>   fs/ntfs3/attrlist.c |  456 ++++++++++
>   fs/ntfs3/xattr.c    | 1046 ++++++++++++++++++++++
>   3 files changed, 3584 insertions(+)
>   create mode 100644 fs/ntfs3/attrib.c
>   create mode 100644 fs/ntfs3/attrlist.c
>   create mode 100644 fs/ntfs3/xattr.c
> 
> diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
> new file mode 100644
> index 000000000..bca85e7b6
> --- /dev/null
> +++ b/fs/ntfs3/attrib.c

[...]

> +/*
> + * load runs for given range [from to)
> + */
> +int attr_load_runs_range(struct ntfs_inode *ni, enum ATTR_TYPE type,
> +			 const __le16 *name, u8 name_len, struct runs_tree *run,
> +			 u64 from, u64 to)
> +{
> +	struct ntfs_sb_info *sbi = ni->mi.sbi;
> +	u8 cluster_bits = sbi->cluster_bits;
> +	CLST vcn = from >> cluster_bits;

This initialization is overwritten in the for loop below.
It can be removed.

> +	CLST vcn_last = (to - 1) >> cluster_bits;
> +	CLST lcn, clen;
> +	int err;
> +
> +	for (vcn = from >> cluster_bits; vcn <= vcn_last; vcn += clen) {

here

> +		if (!run_lookup_entry(run, vcn, &lcn, &clen, NULL)) {
> +			err = attr_load_runs_vcn(ni, type, name, name_len, run,
> +						 vcn);
> +			if (err)
> +				return err;
> +			clen = 0; /*next run_lookup_entry(vcn) must be success*/
> +		}
> +	}
> +
> +	return 0;
> +}

[...]
