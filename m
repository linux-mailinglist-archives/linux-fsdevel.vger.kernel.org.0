Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDA293CBC93
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 21:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbhGPTd6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jul 2021 15:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhGPTd4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jul 2021 15:33:56 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7646FC061760
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jul 2021 12:31:01 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id j27-20020a4a751b0000b029025fb3e97502so2693760ooc.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jul 2021 12:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ymF8ybeEk0d32lRpmE+zE8M1FoML+GUy3KZheoW8rSE=;
        b=uQIkkskr46yAVjD9zPIeHiRdmP5fFiiZzZbRdBzZEf5EJW/wvkmlClPVTLTt8agNcx
         sE2rE1M8xy/LB3hbIU9BNzMiD7140U8Y40lirE1SbYMAC5pCBjVLi+gZMyu/jYBWLYG3
         lzMwiWqo9NxLXG2xdeabgYAmCTk701N8wcgBKUodcV2py/sh50RXqTI8L0CLd0nZt/Ml
         ftEAw/6i0XmzqcDWFY0geujP0EoKtQ6rGkrktzTIFocPxSKjo61YFodRN+PHwxaseWLs
         QkZGMRD/OFLN960MKyGBDc6HIPydrTwVsoMGTiVLsPw7POrHSnS2Cw/wCxKltEmJn8ZO
         ykuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ymF8ybeEk0d32lRpmE+zE8M1FoML+GUy3KZheoW8rSE=;
        b=EQsHUSEaOVTh8Z2g6xTCEpM2lQgK34XxRrLlQTOrM++GW3UcQ+aHEGrMvBNyBLKiCz
         u80DWDOAsIbd9WRhDvNnKYgUU7yxtoSvvhE0Oqr7WEPfCW0MY9ANaG6nWRutzPLzNT1a
         jb3IdhyWvVTo4FOfCh6taXSq8JC/eshmCxb43uV4eF79GoIZgCyCu7FLqvuTGz+HDo7V
         n27DJ7Yxv/7zLmm7VFWeLjFl/qNyBseSgZmLbNUulGOFrfYIh5BNerYaXy0Hl673jEcR
         MdFJ6chCQLQqrpRZPsYWrzlXSbi0ZyAq2OhmcKGlGWZ8OVUSmdNf13o5kdn2JjIKhejN
         hszg==
X-Gm-Message-State: AOAM530T3cXL3xOI/SKJtzO0n8MSlymGhg3AiTAb4E+Y9eyp3eHxs4D5
        8L/l/wmwP5wakLopYV1v4PtatQ==
X-Google-Smtp-Source: ABdhPJx542yjJLOWVtxZwNG+jD3b3yo1NIkbykK82I869+hqP1OnJB155Wu/rBbkO58+PQanVQp2rw==
X-Received: by 2002:a4a:5dc6:: with SMTP id w189mr8872969ooa.1.1626463860763;
        Fri, 16 Jul 2021 12:31:00 -0700 (PDT)
Received: from smtpclient.apple ([2600:1700:42f0:6600:ec90:c991:5957:a3db])
        by smtp.gmail.com with ESMTPSA id w2sm603139oon.0.2021.07.16.12.30.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Jul 2021 12:30:59 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [RESEND PATCH v2] hfsplus: prevent negative dentries when
 casefolded
From:   Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <20210716073635.1613671-1-cccheng@synology.com>
Date:   Fri, 16 Jul 2021 12:30:56 -0700
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        gustavoars@kernel.org, gregkh@linuxfoundation.org,
        keescook@chromium.org, mszeredi@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <02B9566C-A78E-42FB-924B-A503E4BC6D2F@dubeyko.com>
References: <20210716073635.1613671-1-cccheng@synology.com>
To:     Chung-Chiang Cheng <cccheng@synology.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jul 16, 2021, at 12:36 AM, Chung-Chiang Cheng =
<cccheng@synology.com> wrote:
>=20
> hfsplus uses the case-insensitive filenames by default, but VFS =
negative
> dentries are incompatible with case-insensitive. For example, the
> following instructions will get a cached filename 'aaa' which isn't
> expected. There is no such problem in macOS.
>=20
>  touch aaa
>  rm aaa
>  touch AAA
>=20
> This patch takes the same approach to drop negative dentires as vfat =
does.
> The dentry is revalidated without blocking and storing to the dentry,
> and should be safe in rcu-walk.
>=20
> Signed-off-by: Chung-Chiang Cheng <cccheng@synology.com>
> ---
> fs/hfsplus/hfsplus_fs.h |  1 +
> fs/hfsplus/inode.c      |  1 +
> fs/hfsplus/unicode.c    | 32 ++++++++++++++++++++++++++++++++
> 3 files changed, 34 insertions(+)
>=20
> diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
> index 1798949f269b..4ae7f1ca1584 100644
> --- a/fs/hfsplus/hfsplus_fs.h
> +++ b/fs/hfsplus/hfsplus_fs.h
> @@ -520,6 +520,7 @@ int hfsplus_asc2uni(struct super_block *sb, struct =
hfsplus_unistr *ustr,
> int hfsplus_hash_dentry(const struct dentry *dentry, struct qstr =
*str);
> int hfsplus_compare_dentry(const struct dentry *dentry, unsigned int =
len,
> 			   const char *str, const struct qstr *name);
> +int hfsplus_revalidate_dentry(struct dentry *dentry, unsigned int =
flags);
>=20
> /* wrapper.c */
> int hfsplus_submit_bio(struct super_block *sb, sector_t sector, void =
*buf,
> diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
> index 6fef67c2a9f0..4188a0760118 100644
> --- a/fs/hfsplus/inode.c
> +++ b/fs/hfsplus/inode.c
> @@ -179,6 +179,7 @@ const struct address_space_operations hfsplus_aops =
=3D {
> const struct dentry_operations hfsplus_dentry_operations =3D {
> 	.d_hash       =3D hfsplus_hash_dentry,
> 	.d_compare    =3D hfsplus_compare_dentry,
> +	.d_revalidate =3D hfsplus_revalidate_dentry,
> };
>=20
> static void hfsplus_get_perms(struct inode *inode,
> diff --git a/fs/hfsplus/unicode.c b/fs/hfsplus/unicode.c
> index 73342c925a4b..e336631334eb 100644
> --- a/fs/hfsplus/unicode.c
> +++ b/fs/hfsplus/unicode.c
> @@ -10,6 +10,7 @@
>  */
>=20
> #include <linux/types.h>
> +#include <linux/namei.h>
> #include <linux/nls.h>
> #include "hfsplus_fs.h"
> #include "hfsplus_raw.h"
> @@ -518,3 +519,34 @@ int hfsplus_compare_dentry(const struct dentry =
*dentry,
> 		return 1;
> 	return 0;
> }
> +
> +int hfsplus_revalidate_dentry(struct dentry *dentry, unsigned int =
flags)
> +{

What=E2=80=99s about this code?

If (flags & LOOKUP_RCU)
   return -ECHILD;

Do we really need to miss it here?

Thanks,
Slava.


> +	/*
> +	 * dentries are always valid when disabling casefold.
> +	 */
> +	if (!test_bit(HFSPLUS_SB_CASEFOLD, =
&HFSPLUS_SB(dentry->d_sb)->flags))
> +		return 1;
> +
> +	/*
> +	 * Positive dentries are valid when enabling casefold.
> +	 *
> +	 * Note, rename() to existing directory entry will have =
->d_inode, and
> +	 * will use existing name which isn't specified name by user.
> +	 *
> +	 * We may be able to drop this positive dentry here. But =
dropping
> +	 * positive dentry isn't good idea. So it's unsupported like
> +	 * rename("filename", "FILENAME") for now.
> +	 */
> +	if (d_really_is_positive(dentry))
> +		return 1;
> +
> +	/*
> +	 * Drop the negative dentry, in order to make sure to use the =
case
> +	 * sensitive name which is specified by user if this is for =
creation.
> +	 */
> +	if (flags & (LOOKUP_CREATE | LOOKUP_RENAME_TARGET))
> +		return 0;
> +
> +	return 1;
> +}
> --=20
> 2.25.1
>=20

