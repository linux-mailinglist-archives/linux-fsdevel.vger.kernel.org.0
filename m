Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3683E562E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 11:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238508AbhHJJDD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 05:03:03 -0400
Received: from verein.lst.de ([213.95.11.211]:35309 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233739AbhHJJDC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 05:03:02 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 88C5768AFE; Tue, 10 Aug 2021 11:02:34 +0200 (CEST)
Date:   Tue, 10 Aug 2021 11:02:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, pali@kernel.org, dsterba@suse.cz,
        aaptel@suse.com, willy@infradead.org, rdunlap@infradead.org,
        joe@perches.com, mark@harmstone.com, nborisov@suse.com,
        linux-ntfs-dev@lists.sourceforge.net, anton@tuxera.com,
        dan.carpenter@oracle.com, hch@lst.de, ebiggers@kernel.org,
        andy.lavr@gmail.com, kari.argillander@gmail.com,
        oleksandr@natalenko.name
Subject: Re: [PATCH v27 02/10] fs/ntfs3: Add initialization of super block
Message-ID: <20210810090234.GA23732@lst.de>
References: <20210729134943.778917-1-almaz.alexandrovich@paragon-software.com> <20210729134943.778917-3-almaz.alexandrovich@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729134943.778917-3-almaz.alexandrovich@paragon-software.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +static struct dentry *ntfs_mount(struct file_system_type *fs_type, int flags,
> +				 const char *dev_name, void *data)
> +{
> +	return mount_bdev(fs_type, flags, dev_name, data, ntfs_fill_super);
> +}
> +
> +static struct file_system_type ntfs_fs_type = {
> +	.owner = THIS_MODULE,
> +	.name = "ntfs3",
> +	.mount = ntfs_mount,
> +	.kill_sb = kill_block_super,
> +	.fs_flags = FS_REQUIRES_DEV,
> +};

You can't add new callers of mount_bdev or users of the old mount
support.  Please switch to the file system context based API before
resending.  Take a look at e.g. XFS for how to implement it.
