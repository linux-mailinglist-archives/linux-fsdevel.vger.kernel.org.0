Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D36DA255E1A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Aug 2020 17:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbgH1Ppz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Aug 2020 11:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbgH1Pps (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Aug 2020 11:45:48 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5644FC061264;
        Fri, 28 Aug 2020 08:45:48 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBgZU-006DUL-Oj; Fri, 28 Aug 2020 15:45:44 +0000
Date:   Fri, 28 Aug 2020 16:45:44 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        pali@kernel.org, dsterba@suse.cz, aaptel@suse.com,
        willy@infradead.org, rdunlap@infradead.org, joe@perches.com,
        mark@harmstone.com
Subject: Re: [PATCH v3 04/10] fs/ntfs3: Add file operations and implementation
Message-ID: <20200828154544.GJ1236603@ZenIV.linux.org.uk>
References: <20200828143938.102889-1-almaz.alexandrovich@paragon-software.com>
 <20200828143938.102889-5-almaz.alexandrovich@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828143938.102889-5-almaz.alexandrovich@paragon-software.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 28, 2020 at 07:39:32AM -0700, Konstantin Komarov wrote:

> +static struct dentry *__ntfs_lookup(struct inode *dir, struct dentry *dentry,
> +				    struct ntfs_fnd *fnd)
> +{
> +	struct dentry *d;
> +	struct inode *inode;
> +
> +	inode = dir_search(dir, &dentry->d_name, fnd);
> +
> +	if (!inode) {
> +		d_add(dentry, NULL);
> +		d = NULL;
> +		goto out;
> +	}
> +
> +	if (IS_ERR(inode)) {
> +		d = ERR_CAST(inode);
> +		goto out;
> +	}
> +
> +	d = d_splice_alias(inode, dentry);
> +	if (IS_ERR(d)) {
> +		iput(inode);
> +		goto out;
> +	}
> +
> +out:
> +	return d;
> +}

This is bollocks.  First and foremost, d_splice_alias() *does* iput() on
failure, so you've got double-put there.  What's more
	* d_splice_alias(ERR_PTR(err), dentry) return err
	* d_splice_alias(NULL, dentry) is equivalent to d_add(dentry, NULL) and returns NULL

IOW, all that boilerplate could be replaced with one line:

	return d_splice_alias(dir_search(dir, &dentry->d_name, fnd), dentry);
