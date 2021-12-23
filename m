Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C77E847DE87
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 06:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbhLWFMN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 00:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhLWFMM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 00:12:12 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FF4C061401
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Dec 2021 21:12:12 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id o7so3790222ioo.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Dec 2021 21:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=UuLwAbQ1jnMAbt5WK9pjv43q57hnU7ZpBUC8SgtaEwY=;
        b=JWxLbg9g+XejRLq6wFQZpd5b0q8gKjHY9sZebAr8x3oA25Db6O6zBt+GFcAjAvPT3H
         BahMkHRUOAEN7R1iUuzMEy0mfXFv40fkjxw3ivHYwmdssofubyraMQ5fq6XVoFo0EIcb
         nxrJuKTASdTWnHPwcAjTKPvCEB4fEutD3Q8tj6hjfBzYBVEcw+ec5mCSIyJRHfkwOYoB
         c/hqjuX9DQql7KXadsl0y8DOA1BDqaxiQGcuvd5REVk6/tcZWyyBcxSs5q7UnUx3wvZx
         aIDa0hOJLkULAyCMDQ+4KE1yP31Jvg6pnnz3jasOpPWN5g1tK4fLwfAhWBaY8YOpiNpP
         WCng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=UuLwAbQ1jnMAbt5WK9pjv43q57hnU7ZpBUC8SgtaEwY=;
        b=J4r13wloS9wBvOwi3GYHOgvP8LkYoF25F0AvCHuVPnwDOw9qKFK1oAQoBEKiEN3XLF
         nfwrHc+TAlYG+33WvX7g9ofiBBFOqLU+lUM54pPo1S/QaXLmtK67rgewfbqmAVc8xED2
         RFHk/0tgeW7Qs/eMBqdKrKLSnYd+r5dey/3faz4UHzV5wF2jxjjvy2/JMxmuU5cmnwSw
         I+g09AIbfNBoDXP6Kqlu71B6pbydGNTjrxNQre/e/1M+qMEW1yWIX/26h9m9QzKrDXpk
         eBTTiPBfPa0MuTwUkq9Vr+JsPPEOBxPz9Q6UBxfBfV+nEYHvjGetEJXTB51J7KhC+FAd
         xRvQ==
X-Gm-Message-State: AOAM531WIL1aoGbgMv3insWMJZsSY/U1Blx0JU+ujNBbh9ytHCn3ueqH
        S3goWnnqmHSaBrp/KbEtBZ8=
X-Google-Smtp-Source: ABdhPJyFfKXX+2kAlC6TqGgP8VNft2z3Dloqkcrd5Ea90+WU9dHoDi+7biR8HedP8N/IurSGrGM8Mg==
X-Received: by 2002:a05:6638:2402:: with SMTP id z2mr365165jat.200.1640236331920;
        Wed, 22 Dec 2021 21:12:11 -0800 (PST)
Received: from smtpclient.apple ([2601:285:8200:efd:acef:6a41:306c:188b])
        by smtp.gmail.com with ESMTPSA id k7sm2648838iov.40.2021.12.22.21.12.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Dec 2021 21:12:11 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH] mm,fs: Split dump_mapping() out from dump_page()
From:   William Kucharski <kucharsk@gmail.com>
In-Reply-To: <20211121121056.2870061-1-willy@infradead.org>
Date:   Wed, 22 Dec 2021 22:12:09 -0700
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0DC4DA13-319E-4EA3-B154-761D1D20FFD5@gmail.com>
References: <20211121121056.2870061-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good to me.

Reviewed-by: William Kucharski <william.kucharski@oracle.com>

> On Nov 21, 2021, at 5:10 AM, Matthew Wilcox (Oracle) =
<willy@infradead.org> wrote:
>=20
> dump_mapping() is a big chunk of dump_page(), and it'd be handy to be
> able to call it when we don't have a struct page.  Split it out and =
move
> it to fs/inode.c.  Take the opportunity to simplify some of the debug
> messages a little.
>=20
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
> fs/inode.c         | 49 +++++++++++++++++++++++++++++++++++++++++++
> include/linux/fs.h |  1 +
> mm/debug.c         | 52 ++--------------------------------------------
> 3 files changed, 52 insertions(+), 50 deletions(-)
>=20
> diff --git a/fs/inode.c b/fs/inode.c
> index bdfbd5962f2b..67758b2b702f 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -522,6 +522,55 @@ void __remove_inode_hash(struct inode *inode)
> }
> EXPORT_SYMBOL(__remove_inode_hash);
>=20
> +void dump_mapping(const struct address_space *mapping)
> +{
> +	struct inode *host;
> +	const struct address_space_operations *a_ops;
> +	struct hlist_node *dentry_first;
> +	struct dentry *dentry_ptr;
> +	struct dentry dentry;
> +	unsigned long ino;
> +
> +	/*
> +	 * If mapping is an invalid pointer, we don't want to crash
> +	 * accessing it, so probe everything depending on it carefully.
> +	 */
> +	if (get_kernel_nofault(host, &mapping->host) ||
> +	    get_kernel_nofault(a_ops, &mapping->a_ops)) {
> +		pr_warn("invalid mapping:%px\n", mapping);
> +		return;
> +	}
> +
> +	if (!host) {
> +		pr_warn("aops:%ps\n", a_ops);
> +		return;
> +	}
> +
> +	if (get_kernel_nofault(dentry_first, &host->i_dentry.first) ||
> +	    get_kernel_nofault(ino, &host->i_ino)) {
> +		pr_warn("aops:%ps invalid inode:%px\n", a_ops, host);
> +		return;
> +	}
> +
> +	if (!dentry_first) {
> +		pr_warn("aops:%ps ino:%lx\n", a_ops, ino);
> +		return;
> +	}
> +
> +	dentry_ptr =3D container_of(dentry_first, struct dentry, =
d_u.d_alias);
> +	if (get_kernel_nofault(dentry, dentry_ptr)) {
> +		pr_warn("aops:%ps ino:%lx invalid dentry:%px\n",
> +				a_ops, ino, dentry_ptr);
> +		return;
> +	}
> +
> +	/*
> +	 * if dentry is corrupted, the %pd handler may still crash,
> +	 * but it's unlikely that we reach here with a corrupt mapping
> +	 */
> +	pr_warn("aops:%ps ino:%lx dentry name:\"%pd\"\n", a_ops, ino, =
&dentry);
> +}
> +
> void clear_inode(struct inode *inode)
> {
> 	/*
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index d6a4eb6cf825..acaad2b0d5b9 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3149,6 +3149,7 @@ extern void unlock_new_inode(struct inode *);
> extern void discard_new_inode(struct inode *);
> extern unsigned int get_next_ino(void);
> extern void evict_inodes(struct super_block *sb);
> +void dump_mapping(const struct address_space *);
>=20
> /*
>  * Userspace may rely on the the inode number being non-zero. For =
example, glibc
> diff --git a/mm/debug.c b/mm/debug.c
> index fae0f81ad831..b3ebfab21cb3 100644
> --- a/mm/debug.c
> +++ b/mm/debug.c
> @@ -110,56 +110,8 @@ static void __dump_page(struct page *page)
> 		type =3D "ksm ";
> 	else if (PageAnon(page))
> 		type =3D "anon ";
> -	else if (mapping) {
> -		struct inode *host;
> -		const struct address_space_operations *a_ops;
> -		struct hlist_node *dentry_first;
> -		struct dentry *dentry_ptr;
> -		struct dentry dentry;
> -		unsigned long ino;
> -
> -		/*
> -		 * mapping can be invalid pointer and we don't want to =
crash
> -		 * accessing it, so probe everything depending on it =
carefully
> -		 */
> -		if (get_kernel_nofault(host, &mapping->host) ||
> -		    get_kernel_nofault(a_ops, &mapping->a_ops)) {
> -			pr_warn("failed to read mapping contents, not a =
valid kernel address?\n");
> -			goto out_mapping;
> -		}
> -
> -		if (!host) {
> -			pr_warn("aops:%ps\n", a_ops);
> -			goto out_mapping;
> -		}
> -
> -		if (get_kernel_nofault(dentry_first, =
&host->i_dentry.first) ||
> -		    get_kernel_nofault(ino, &host->i_ino)) {
> -			pr_warn("aops:%ps with invalid host inode =
%px\n",
> -					a_ops, host);
> -			goto out_mapping;
> -		}
> -
> -		if (!dentry_first) {
> -			pr_warn("aops:%ps ino:%lx\n", a_ops, ino);
> -			goto out_mapping;
> -		}
> -
> -		dentry_ptr =3D container_of(dentry_first, struct dentry, =
d_u.d_alias);
> -		if (get_kernel_nofault(dentry, dentry_ptr)) {
> -			pr_warn("aops:%ps ino:%lx with invalid dentry =
%px\n",
> -					a_ops, ino, dentry_ptr);
> -		} else {
> -			/*
> -			 * if dentry is corrupted, the %pd handler may =
still
> -			 * crash, but it's unlikely that we reach here =
with a
> -			 * corrupted struct page
> -			 */
> -			pr_warn("aops:%ps ino:%lx dentry =
name:\"%pd\"\n",
> -					a_ops, ino, &dentry);
> -		}
> -	}
> -out_mapping:
> +	else if (mapping)
> +		dump_mapping(mapping);
> 	BUILD_BUG_ON(ARRAY_SIZE(pageflag_names) !=3D __NR_PAGEFLAGS + =
1);
>=20
> 	pr_warn("%sflags: %#lx(%pGp)%s\n", type, head->flags, =
&head->flags,
> --=20
> 2.33.0
>=20
>=20

