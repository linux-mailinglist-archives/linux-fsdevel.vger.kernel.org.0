Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E887640F7E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Dec 2022 21:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234333AbiLBUwT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Dec 2022 15:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234164AbiLBUwK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Dec 2022 15:52:10 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32230E0B1
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Dec 2022 12:52:09 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id s186so6404442oia.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Dec 2022 12:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BNopcQzyMrDOh/b/vCRXkHr0H7DdGm+B3oHqrj558/o=;
        b=Die1nGt6J60l86Yi+h0GfQHRGFQZ6y5EBu8ES0Y60XkiAG98hhXbhwiZTJJapd5tqC
         Y0FfGbwNdIS8j64+XHqEeH3rd4sSad6MxK0se3o6K8AE2IQGUGjvEkCyhZtOTdWempMn
         8h+lUmJ5h3PpQGDSuHjeMStqg+zvlIviSCvMBH0xvxZ7DEFaep5xgBLfomNWfpT4ZFKt
         cBHgR+eIqwGofCuPqfo7BrHvvt2lBQvb1WPhx0h+uxZSZoUMLtSZfAeSzMO8L77vbkQ2
         v9KrG0HtD11IpV2HL0Fjgam/3BneHHTeNW25jjTjMHAoSmWevpQUCm93yFWMkwF6B9CZ
         m5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BNopcQzyMrDOh/b/vCRXkHr0H7DdGm+B3oHqrj558/o=;
        b=RmwZaY8jkclbDLiRDGMrpA/pQi74NgWjfbagBARmrdpW3nxrmbUBKYU9TbTI9L53RK
         FwjhWozAy087T8kvue54e+2DC+glJysuH7THKksGYg84MlmYtX78l0lfNJD7XiLXBNMy
         uGWSJJnVlJHT2D4UR12JZQ+b45t3yci0u6iREyh7n1GumTMbRSpAM9aLTqPgLlUceO/k
         LIWmkcm43WuYKwS5VzLwjMhamYuzki/BP1KiO39LA832n33dkInUTcSW8r4rScQE5IUk
         TD+lUnbS/61ZBTT2nh8+A1+5e1pDLKj9tFCE55sKWElWgLMMXs/NdPGaN4+Dt/zC9Wgf
         7B9Q==
X-Gm-Message-State: ANoB5pnpYfRhmSCJ7xpcCJJFZVpFRzFA5wEQ2NdoN237csR+NXB9uMvx
        DE3t21u7QxfeHUxCqwyVUdn4Mw==
X-Google-Smtp-Source: AA0mqf4RQat+esU5YQe1DuNW4jFEYehg1OHgIrBnGpvDqoJZ81OazoeMrPpcRO3+/5iW4PcxexG9lw==
X-Received: by 2002:a05:6808:1444:b0:35a:2613:c9f with SMTP id x4-20020a056808144400b0035a26130c9fmr35617871oiv.250.1670014328404;
        Fri, 02 Dec 2022 12:52:08 -0800 (PST)
Received: from smtpclient.apple (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id n7-20020a056870a44700b00130d060ce80sm4737802oal.31.2022.12.02.12.52.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Dec 2022 12:52:07 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH] hfsplus: Fix bug causing custom uid and gid being unable
 to be assigned with mount
From:   Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <93F5197D-2B61-4129-B5D4-771934F70577@live.com>
Date:   Fri, 2 Dec 2022 12:52:05 -0800
Cc:     "willy@infradead.org" <willy@infradead.org>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <55A80630-60FB-44BE-9628-29104AB8A7D0@dubeyko.com>
References: <93F5197D-2B61-4129-B5D4-771934F70577@live.com>
To:     Aditya Garg <gargaditya08@live.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Dec 2, 2022, at 7:39 AM, Aditya Garg <gargaditya08@live.com> wrote:
>=20
> From: Aditya Garg <gargaditya08@live.com>
>=20
> Inspite of specifying UID and GID in mount command, the specified UID =
and
> GID was not being assigned. This patch fixes this issue.
>=20
> Signed-off-by: Aditya Garg <gargaditya08@live.com>
> ---
> fs/hfsplus/hfsplus_fs.h | 2 ++
> fs/hfsplus/inode.c      | 4 ++--
> fs/hfsplus/options.c    | 2 ++
> 3 files changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
> index a5db2e3b2..6aa919e59 100644
> --- a/fs/hfsplus/hfsplus_fs.h
> +++ b/fs/hfsplus/hfsplus_fs.h
> @@ -198,6 +198,8 @@ struct hfsplus_sb_info {
> #define HFSPLUS_SB_HFSX		3
> #define HFSPLUS_SB_CASEFOLD	4
> #define HFSPLUS_SB_NOBARRIER	5
> +#define HFSPLUS_SB_UID		6
> +#define HFSPLUS_SB_GID		7
>=20
> static inline struct hfsplus_sb_info *HFSPLUS_SB(struct super_block =
*sb)
> {
> diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
> index aeab83ed1..4d1077db8 100644
> --- a/fs/hfsplus/inode.c
> +++ b/fs/hfsplus/inode.c
> @@ -192,11 +192,11 @@ static void hfsplus_get_perms(struct inode =
*inode,
> 	mode =3D be16_to_cpu(perms->mode);
>=20
> 	i_uid_write(inode, be32_to_cpu(perms->owner));
> -	if (!i_uid_read(inode) && !mode)
> +	if (test_bit(HFSPLUS_SB_UID, &sbi->flags))
> 		inode->i_uid =3D sbi->uid;
>=20
> 	i_gid_write(inode, be32_to_cpu(perms->group));
> -	if (!i_gid_read(inode) && !mode)
> +	if (test_bit(HFSPLUS_SB_GID, &sbi->flags))
> 		inode->i_gid =3D sbi->gid;

I am slightly confused. Do you mean that all files/folders will have the =
same UID/GID always?
What if user changes the UID/GID a particular file/folder? Also, what if =
we mounted
file system without specifying the UID/GID, then what UID/GID will be =
returned by
your logic?

Thanks,
Slava.

>=20
> 	if (dir) {
> diff --git a/fs/hfsplus/options.c b/fs/hfsplus/options.c
> index 047e05c57..10a0bdacb 100644
> --- a/fs/hfsplus/options.c
> +++ b/fs/hfsplus/options.c
> @@ -137,6 +137,7 @@ int hfsplus_parse_options(char *input, struct =
hfsplus_sb_info *sbi)
> 				return 0;
> 			}
> 			sbi->uid =3D make_kuid(current_user_ns(), =
(uid_t)tmp);
> +			set_bit(HFSPLUS_SB_UID, &sbi->flags);
> 			if (!uid_valid(sbi->uid)) {
> 				pr_err("invalid uid specified\n");
> 				return 0;
> @@ -148,6 +149,7 @@ int hfsplus_parse_options(char *input, struct =
hfsplus_sb_info *sbi)
> 				return 0;
> 			}
> 			sbi->gid =3D make_kgid(current_user_ns(), =
(gid_t)tmp);
> +			set_bit(HFSPLUS_SB_GID, &sbi->flags);
> 			if (!gid_valid(sbi->gid)) {
> 				pr_err("invalid gid specified\n");
> 				return 0;
> --=20
> 2.38.1
>=20

