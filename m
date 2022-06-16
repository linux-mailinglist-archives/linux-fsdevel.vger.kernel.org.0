Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E70954E54E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jun 2022 16:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241568AbiFPOs3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jun 2022 10:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376708AbiFPOsL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jun 2022 10:48:11 -0400
Received: from hi1smtp01.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852342983E;
        Thu, 16 Jun 2022 07:48:09 -0700 (PDT)
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hi1smtp01.de.adit-jv.com (Postfix) with ESMTPS id C22C9520290;
        Thu, 16 Jun 2022 16:48:07 +0200 (CEST)
Received: from lxhi-065 (10.72.94.5) by hi2exch02.adit-jv.com (10.72.92.28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2308.27; Thu, 16 Jun
 2022 16:48:07 +0200
Date:   Thu, 16 Jun 2022 16:47:59 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
CC:     <viro@zeniv.linux.org.uk>, <linux-security-module@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>, <initramfs@vger.kernel.org>,
        <linux-api@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bug-cpio@gnu.org>,
        <zohar@linux.vnet.ibm.com>, <silviu.vlasceanu@huawei.com>,
        <dmitry.kasatkin@huawei.com>, <takondra@cisco.com>,
        <kamensky@cisco.com>, <hpa@zytor.com>, <arnd@arndb.de>,
        <rob@landley.net>, <james.w.mcmechan@gmail.com>,
        <niveditas98@gmail.com>, Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH v4 3/3] gen_init_cpio: add support for file metadata
Message-ID: <20220616144759.GA3967@lxhi-065>
References: <20190523121803.21638-1-roberto.sassu@huawei.com>
 <20190523121803.21638-4-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190523121803.21638-4-roberto.sassu@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.72.94.5]
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Roberto,

On Do, Mai 23, 2019 at 02:18:03 +0200, Roberto Sassu wrote:
> This patch adds support for file metadata (only TYPE_XATTR metadata type).
> gen_init_cpio has been modified to read xattrs from files that will be
> added to the image and to include file metadata as separate files with the
> special name 'METADATA!!!'.
> 
> This behavior can be selected by setting the desired file metadata type as
> value for CONFIG_INITRAMFS_FILE_METADATA.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  usr/Kconfig               |   8 +++
>  usr/Makefile              |   4 +-
>  usr/gen_init_cpio.c       | 137 ++++++++++++++++++++++++++++++++++++--
>  usr/gen_initramfs_list.sh |  10 ++-
>  4 files changed, 150 insertions(+), 9 deletions(-)
> 
> diff --git a/usr/gen_init_cpio.c b/usr/gen_init_cpio.c
> index 03b21189d58b..e93cb1093e77 100644
> --- a/usr/gen_init_cpio.c
> +++ b/usr/gen_init_cpio.c

[..]

> +static int write_xattrs(const char *path)
> +{

[..]

> +
> +		snprintf(str, sizeof(str), "%.8lx",
> +			 sizeof(hdr) + name_len + 1 + value_len);

Cppcheck 2.7 reports at this line:

usr/gen_init_cpio.c:107,portability,invalidPrintfArgType_uint,%lx in format string (no. 1) requires 'unsigned long' but the argument type is 'size_t {aka unsigned long}'.

This can be addressed via 's/lx/zx/', according to https://www.kernel.org/doc/Documentation/printk-formats.txt .

BR, Eugeniu
