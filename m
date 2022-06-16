Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFCD54E1D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jun 2022 15:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbiFPNYR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jun 2022 09:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiFPNYR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jun 2022 09:24:17 -0400
Received: from hi1smtp01.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F8033EB6;
        Thu, 16 Jun 2022 06:24:15 -0700 (PDT)
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hi1smtp01.de.adit-jv.com (Postfix) with ESMTPS id 56957520290;
        Thu, 16 Jun 2022 15:24:13 +0200 (CEST)
Received: from lxhi-065 (10.72.94.14) by hi2exch02.adit-jv.com (10.72.92.28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2308.27; Thu, 16 Jun
 2022 15:24:12 +0200
Date:   Thu, 16 Jun 2022 15:24:08 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
CC:     <viro@zeniv.linux.org.uk>, <linux-security-module@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        <linux-integrity@vger.kernel.org>, <initramfs@vger.kernel.org>,
        <linux-api@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bug-cpio@gnu.org>,
        <zohar@linux.vnet.ibm.com>, <silviu.vlasceanu@huawei.com>,
        <dmitry.kasatkin@huawei.com>, <takondra@cisco.com>,
        <kamensky@cisco.com>, <hpa@zytor.com>, <arnd@arndb.de>,
        <rob@landley.net>, <james.w.mcmechan@gmail.com>,
        <niveditas98@gmail.com>, Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH v4 0/3] initramfs: add support for xattrs in the initial
 ram disk
Message-ID: <20220616132408.GA4018@lxhi-065>
References: <20190523121803.21638-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190523121803.21638-1-roberto.sassu@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.72.94.14]
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

Dear Yamada-san,

On Do, Mai 23, 2019 at 02:18:00 +0200, Roberto Sassu wrote:
> This patch set aims at solving the following use case: appraise files from
> the initial ram disk. To do that, IMA checks the signature/hash from the
> security.ima xattr. Unfortunately, this use case cannot be implemented
> currently, as the CPIO format does not support xattrs.
> 
> This proposal consists in including file metadata as additional files named
> METADATA!!!, for each file added to the ram disk. The CPIO parser in the
> kernel recognizes these special files from the file name, and calls the
> appropriate parser to add metadata to the previously extracted file. It has
> been proposed to use bit 17:16 of the file mode as a way to recognize files
> with metadata, but both the kernel and the cpio tool declare the file mode
> as unsigned short.
> 
> The difference from v2, v3 (https://lkml.org/lkml/2019/5/9/230,
> https://lkml.org/lkml/2019/5/17/466) is that file metadata are stored in
> separate files instead of a single file. Given that files with metadata
> must immediately follow the files metadata will be added to, image
> generators have to be modified in this version.
> 
> The difference from v1 (https://lkml.org/lkml/2018/11/22/1182) is that
> all files have the same name. The file metadata are added to is always the
> previous one, and the image generator in user space will make sure that
> files are in the correct sequence.
> 
> The difference with another proposal
> (https://lore.kernel.org/patchwork/cover/888071/) is that xattrs can be
> included in an image without changing the image format. Files with metadata
> will appear as regular files. It will be task of the parser in the kernel
> to process them.
> 
> This patch set extends the format of data defined in patch 9/15 of the last
> proposal. It adds header version and type, so that new formats can be
> defined and arbitrary metadata types can be processed.
> 
> The changes introduced by this patch set don't cause any compatibility
> issue: kernels without the metadata parser simply extract the special files
> and don't process metadata; kernels with the metadata parser don't process
> metadata if the special files are not included in the image.
> 
> >From the kernel space perspective, backporting this functionality to older
> kernels should be very easy. It is sufficient to add two calls to the new
> function do_process_metadata() in do_copy(), and to check the file name in
> do_name(). From the user space perspective, unlike the previous version of
> the patch set, it is required to modify the image generators in order to
> include metadata as separate files.

Since this patch series most likely falls under your jurisdiction and
also given your recent commits [*] in the same area, I am curious if
there are any early signs which would prevent your final acceptance
and would potentially result in a no-Go?

Can we have an early confirmation that, upon rebasing and handling of
all the review comments, you would be willing to accept the patches?

[*] Most recent commits touching usr/gen_initramfs.sh
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7168965ec7b10b8a2c7dea1f82f1ebadf44d64ba
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=65e00e04e5aea34b256814cfa21b32e3b94a2402
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=469e87e89fd61de804bd29f6dd0380a399b567a7

Thanks,
Eugeniu.
