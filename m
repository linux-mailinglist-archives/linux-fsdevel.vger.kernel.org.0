Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5526354CD82
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jun 2022 17:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347125AbiFOPwk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jun 2022 11:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345858AbiFOPwh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jun 2022 11:52:37 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8AAB66;
        Wed, 15 Jun 2022 08:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655308349; x=1686844349;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vEpxs2+wXr4SsR+MY+H6e3dQBj8yAjWaewnFE5qkviQ=;
  b=KR3vgA3Ss6LOK2vmKOjb3tQ30EoLt/tjcs4oeUT1tviqGc1SOy/u3jXW
   /Jf67D3PuIiqNU2Ysrl7mu9wp1cjTFjh9dxcT/xb44ULb9pJVsAF+sOr9
   NJL4CqCh3l8sXLThtWK/JcyR/YoOQKwpgRERctziCfNEPRP9aMqgyOfa2
   /RSPaTWLzBnTN8WRrcjL0+gofyk1/hfBUh1gSaxpye0tEm/FrhxDAFf+p
   Dq+pWyTRSyDruhsAtt2qKEEGlvCUWiH+AxVlAnFsUWRjj3U3JGUJZHWY/
   nf5YNogIETTLYYZNPxqTZvoagXzHJJIdytUxzZWcd1xypTX07CGIaKAEv
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="340665401"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="340665401"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 08:52:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="572247935"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga002.jf.intel.com with ESMTP; 15 Jun 2022 08:52:24 -0700
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 25FFqMbv015178;
        Wed, 15 Jun 2022 16:52:22 +0100
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        viro@zeniv.linux.org.uk, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, initramfs@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, bug-cpio@gnu.org,
        zohar@linux.vnet.ibm.com, silviu.vlasceanu@huawei.com,
        dmitry.kasatkin@huawei.com, takondra@cisco.com, kamensky@cisco.com,
        hpa@zytor.com, arnd@arndb.de, rob@landley.net,
        james.w.mcmechan@gmail.com, niveditas98@gmail.com
Subject: Re: [PATCH v4 0/3] initramfs: add support for xattrs in the initial ram disk
Date:   Wed, 15 Jun 2022 17:50:34 +0200
Message-Id: <20220615155034.1271240-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20190523121803.21638-1-roberto.sassu@huawei.com>
References: <20190523121803.21638-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>
Date: Thu, 23 May 2019 14:18:00 +0200

> This patch set aims at solving the following use case: appraise files from
> the initial ram disk. To do that, IMA checks the signature/hash from the

Hi,
is this[0] relatable somehow?

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
> >>From the kernel space perspective, backporting this functionality to older
> kernels should be very easy. It is sufficient to add two calls to the new
> function do_process_metadata() in do_copy(), and to check the file name in
> do_name(). From the user space perspective, unlike the previous version of
> the patch set, it is required to modify the image generators in order to
> include metadata as separate files.
> 
> Changelog
> 
> v3:
> - include file metadata as separate files named METADATA!!!
> - add the possibility to include in the ram disk arbitrary metadata types
> 
> v2:
> - replace ksys_lsetxattr() with kern_path() and vfs_setxattr()
>   (suggested by Jann Horn)
> - replace ksys_open()/ksys_read()/ksys_close() with
>   filp_open()/kernel_read()/fput()
>   (suggested by Jann Horn)
> - use path variable instead of name_buf in do_readxattrs()
> - set last byte of str to 0 in do_readxattrs()
> - call do_readxattrs() in do_name() before replacing an existing
>   .xattr-list
> - pass pathname to do_setxattrs()
> 
> v1:
> - move xattr unmarshaling to CPIO parser
> 
> 
> Mimi Zohar (1):
>   initramfs: add file metadata
> 
> Roberto Sassu (2):
>   initramfs: read metadata from special file METADATA!!!
>   gen_init_cpio: add support for file metadata
> 
>  include/linux/initramfs.h |  21 ++++++
>  init/initramfs.c          | 137 +++++++++++++++++++++++++++++++++++++-
>  usr/Kconfig               |   8 +++
>  usr/Makefile              |   4 +-
>  usr/gen_init_cpio.c       | 137 ++++++++++++++++++++++++++++++++++++--
>  usr/gen_initramfs_list.sh |  10 ++-
>  6 files changed, 305 insertions(+), 12 deletions(-)
>  create mode 100644 include/linux/initramfs.h
> 
> -- 
> 2.17.1

[0] https://lore.kernel.org/all/20210702233727.21301-1-alobakin@pm.me

Thanks,
Olek
