Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D77E134BCC0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Mar 2021 17:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbhC1PIQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Mar 2021 11:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbhC1PHg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Mar 2021 11:07:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD65BC061756;
        Sun, 28 Mar 2021 08:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=U3VUBgSWmtuhj2eaOcurajScUzkTC8xyuO2uGbgOuaE=; b=aSLec8BLfvM6s8JuxKcmT1Wg2W
        m/And3P1jFN2IW/L1JYvNroaUyFxLz1W6U6oz2tM0c5Sp4BKZUJNortM4lqrYuDyQgFOu7KQfKV26
        NE/GIoPujfo70lzZ3SrNV6WgavKVz7Mddbw9+fBhoAZuak+LqRB9jlhYNddifLa4BckCw1fK+2XZt
        zaMHXwj84B8anfi9sKC1D8iIJj788XdTVYqtxEE9t9kVqlZcoc9xa3IdPN4IA4PPLZ5iTdV+QRT+d
        bqgwGE1tdJzUh/NLuFafHWioh96XJcCZRhZ1Wg1yckv0WTHCdvtIBvJCBz4e0ODFl5hZk9rrMfG9V
        OVKMzBeg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lQX0V-000CDn-KJ; Sun, 28 Mar 2021 15:07:20 +0000
Date:   Sun, 28 Mar 2021 16:07:15 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        krisman@collabora.com, kernel@collabora.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Daniel Rosenberg <drosen@google.com>,
        Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 1/3] fs/dcache: Add d_clear_dir_neg_dentries()
Message-ID: <20210328150715.GA33249@casper.infradead.org>
References: <20210328144356.12866-1-andrealmeid@collabora.com>
 <20210328144356.12866-2-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210328144356.12866-2-andrealmeid@collabora.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 28, 2021 at 11:43:54AM -0300, André Almeida wrote:
> +/**
> + * d_clear_dir_neg_dentries - Remove negative dentries in an inode
> + * @dir: Directory to clear negative dentries
> + *
> + * For directories with negative dentries that are becoming case-insensitive
> + * dirs, we need to remove all those negative dentries, otherwise they will
> + * become dangling dentries. During the creation of a new file, if a d_hash
> + * collision happens and the names match in a case-insensitive, the name of
> + * the file will be the name defined at the negative dentry, that can be
> + * different from the specified by the user. To prevent this from happening, we
> + * need to remove all dentries in a directory. Given that the directory must be
> + * empty before we call this function we are sure that all dentries there will
> + * be negative.
> + */

This is quite the landmine of a function.  It _assumes_ that the directory
is empty, and clears all dentries in it.

> +void d_clear_dir_neg_dentries(struct inode *dir)
> +{
> +	struct dentry *alias, *dentry;
> +
> +	hlist_for_each_entry(alias, &dir->i_dentry, d_u.d_alias) {
> +		list_for_each_entry(dentry, &alias->d_subdirs, d_child) {
> +			d_drop(dentry);
> +			dput(dentry);
> +		}

I would be happier if it included a check for negativity.  d_is_negative()
or maybe this newfangled d_really_is_negative() (i haven't stayed up
to speed on the precise difference between the two)

> +	}
> +}
> +EXPORT_SYMBOL(d_clear_dir_neg_dentries);

I'd rather see this _GPL for such an internal thing.
