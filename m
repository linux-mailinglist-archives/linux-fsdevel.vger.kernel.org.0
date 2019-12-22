Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43FAC128C15
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Dec 2019 01:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfLVAQM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Dec 2019 19:16:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:52390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbfLVAQM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Dec 2019 19:16:12 -0500
Received: from zzz.localdomain (h75-100-12-111.burkwi.broadband.dynamic.tds.net [75.100.12.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0C0A206B7;
        Sun, 22 Dec 2019 00:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576973771;
        bh=zi2nezPZMF4U5iDzHEZMniOW0jiKQ3XbzvQhTGVXih0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PmEfdcFEm4iZEYixgfnC/uRgDEvX64zJcJZxYGNrmnC0RXjmgUCwRq2bvJHzcfEd7
         cD8IWH5mszK2iHiQeuHCMd4zK8J0IDMhr8Utv4MZmvn41dMIQwyBIhGe4pZDLiqNMR
         HajyfoOLGjhfi6UBWGo831W+/NFlYI1SyH8S+KUA=
Date:   Sat, 21 Dec 2019 18:16:08 -0600
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v6 9/9] ext4: add inline encryption support
Message-ID: <20191222001608.GB551@zzz.localdomain>
References: <20191218145136.172774-1-satyat@google.com>
 <20191218145136.172774-10-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218145136.172774-10-satyat@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 18, 2019 at 06:51:36AM -0800, Satya Tangirala wrote:
> @@ -1460,6 +1466,7 @@ enum {
>  	Opt_journal_path, Opt_journal_checksum, Opt_journal_async_commit,
>  	Opt_abort, Opt_data_journal, Opt_data_ordered, Opt_data_writeback,
>  	Opt_data_err_abort, Opt_data_err_ignore, Opt_test_dummy_encryption,
> +	Opt_inlinecrypt,
>  	Opt_usrjquota, Opt_grpjquota, Opt_offusrjquota, Opt_offgrpjquota,
>  	Opt_jqfmt_vfsold, Opt_jqfmt_vfsv0, Opt_jqfmt_vfsv1, Opt_quota,
>  	Opt_noquota, Opt_barrier, Opt_nobarrier, Opt_err,
> @@ -1556,6 +1563,7 @@ static const match_table_t tokens = {
>  	{Opt_noinit_itable, "noinit_itable"},
>  	{Opt_max_dir_size_kb, "max_dir_size_kb=%u"},
>  	{Opt_test_dummy_encryption, "test_dummy_encryption"},
> +	{Opt_inlinecrypt, "inlinecrypt"},
>  	{Opt_nombcache, "nombcache"},
>  	{Opt_nombcache, "no_mbcache"},	/* for backward compatibility */
>  	{Opt_removed, "check=none"},	/* mount option from ext2/3 */
> @@ -1767,6 +1775,11 @@ static const struct mount_opts {
>  	{Opt_jqfmt_vfsv1, QFMT_VFS_V1, MOPT_QFMT},
>  	{Opt_max_dir_size_kb, 0, MOPT_GTE0},
>  	{Opt_test_dummy_encryption, 0, MOPT_GTE0},
> +#ifdef CONFIG_FS_ENCRYPTION_INLINE_CRYPT
> +	{Opt_inlinecrypt, EXT4_MOUNT_INLINECRYPT, MOPT_SET},
> +#else
> +	{Opt_inlinecrypt, EXT4_MOUNT_INLINECRYPT, MOPT_NOSUPPORT},
> +#endif
>  	{Opt_nombcache, EXT4_MOUNT_NO_MBCACHE, MOPT_SET},
>  	{Opt_err, 0, 0}
>  };

This mount option will need to be documented in
Documentation/admin-guide/ext4.rst for ext4 and
Documentation/filesystems/f2fs.txt for f2fs.

- Eric
