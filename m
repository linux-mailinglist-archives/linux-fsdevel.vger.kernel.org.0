Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C9654D06E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jun 2022 19:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344819AbiFORyW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jun 2022 13:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235028AbiFORyV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jun 2022 13:54:21 -0400
Received: from hi1smtp01.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6634E26117;
        Wed, 15 Jun 2022 10:54:20 -0700 (PDT)
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hi1smtp01.de.adit-jv.com (Postfix) with ESMTPS id 33E96520291;
        Wed, 15 Jun 2022 19:54:18 +0200 (CEST)
Received: from lxhi-065 (10.72.94.5) by hi2exch02.adit-jv.com (10.72.92.28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2308.27; Wed, 15 Jun
 2022 19:54:17 +0200
Date:   Wed, 15 Jun 2022 19:54:12 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
CC:     <viro@zeniv.linux.org.uk>, <linux-security-module@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>, <initramfs@vger.kernel.org>,
        <linux-api@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bug-cpio@gnu.org>,
        <silviu.vlasceanu@huawei.com>, <dmitry.kasatkin@huawei.com>,
        <takondra@cisco.com>, <kamensky@cisco.com>, <hpa@zytor.com>,
        <arnd@arndb.de>, <rob@landley.net>, <james.w.mcmechan@gmail.com>,
        <niveditas98@gmail.com>, Dirk Behme <dirk.behme@de.bosch.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH v4 1/3] initramfs: add file metadata
Message-ID: <20220615175412.GA7029@lxhi-065>
References: <20190523121803.21638-1-roberto.sassu@huawei.com>
 <20190523121803.21638-2-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190523121803.21638-2-roberto.sassu@huawei.com>
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
Hello Mimi,

On Thu, May 23, 2019 at 02:18:01PM +0200, Roberto Sassu wrote:
> From: Mimi Zohar <zohar@linux.vnet.ibm.com>
> 
> This patch adds metadata to a file from a supplied buffer. The buffer might
> contains multiple metadata records. The format of each record is:
> 
> <metadata len (ASCII, 8 chars)><version><type><metadata>
> 
> For now, only the TYPE_XATTR metadata type is supported. The specific
> format of this metadata type is:
> 
> <xattr #N name>\0<xattr #N value>
> 
> [kamensky: fixed restoring of xattrs for symbolic links by using
>            sys_lsetxattr() instead of sys_setxattr()]
> 
> [sassu: removed state management, kept only do_setxattrs(), added support
>         for generic file metadata, replaced sys_lsetxattr() with
>         vfs_setxattr(), added check for entry_size, added check for
>         hdr->c_size, replaced strlen() with strnlen(); moved do_setxattrs()
>         before do_name()]
> 
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Signed-off-by: Victor Kamensky <kamensky@cisco.com>
> Signed-off-by: Taras Kondratiuk <takondra@cisco.com>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  include/linux/initramfs.h | 21 ++++++++++
>  init/initramfs.c          | 88 ++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 107 insertions(+), 2 deletions(-)
>  create mode 100644 include/linux/initramfs.h

[..]

> +static int __init do_setxattrs(char *pathname, char *buf, size_t size)
> +{
> +	struct path path;
> +	char *xattr_name, *xattr_value;
> +	size_t xattr_name_size, xattr_value_size;
> +	int ret;
> +
> +	xattr_name = buf;
> +	xattr_name_size = strnlen(xattr_name, size);
> +	if (xattr_name_size == size) {
> +		error("malformed xattrs");
> +		return -EINVAL;
> +	}
> +

[..]

> +
> +		switch (hdr->c_type) {
> +		case TYPE_XATTR:
> +			do_setxattrs(pathname, buf + sizeof(*hdr),
> +				     entry_size - sizeof(*hdr));

Is it on purpose not to check the return value of do_setxattrs?

I think I would have more comfort and piece of mind if I knew
the return value is properly checked and acted upon. Otherwise,
why returning an int from within do_setxattrs() at all?

BR, Eugeniu
