Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523766496CC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Dec 2022 23:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbiLKWju (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Dec 2022 17:39:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiLKWjt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Dec 2022 17:39:49 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DA9BC8C;
        Sun, 11 Dec 2022 14:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8nBoLihTgg1o/rDSJVfWlE6H3OQKZQg483QB0jOBInM=; b=kjwwvm5M60+cg0oPps1CyCFMZg
        yZlvn9jd9UvZ1BDnQBT2eWKlmGe4+WBof3Gm8TFX1yFX55h4wee8uvV4W2/5DPyM4h49PIDBDfO8y
        QoT23IkV3uF7MDmKI6yCmi3DX7EyGb2tajw7X9+UjTi93b45riAUqnmUQ/E2tZhaE5/84cgzenHIv
        8FTmXSuXPkNqWKVDeDJ37yPbkEo5hNJpjk1HTKJ8Yfo3OnLe8+qh38QjjF8/OqsWrefQbVBq3To0t
        1uwqfzXO/PuKd1LzhOxsSPpP0hQBSilro3U/uIDxeGjkNnjCTkgQ++0IJl6H9hmftJnkae+2PgbNw
        tJxk+xzg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1p4Uz2-00B6vV-37;
        Sun, 11 Dec 2022 22:39:45 +0000
Date:   Sun, 11 Dec 2022 22:39:44 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Evgeniy Dushistov <dushistov@mail.ru>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3] fs/ufs: Replace kmap() with kmap_local_page()
Message-ID: <Y5ZcMPzPG9h6C9eh@ZenIV>
References: <20221211213111.30085-1-fmdefrancesco@gmail.com>
 <20221211213111.30085-4-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221211213111.30085-4-fmdefrancesco@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Dec 11, 2022 at 10:31:11PM +0100, Fabio M. De Francesco wrote:

> +/*
> + * Calls to ufs_get_page()/ufs_put_page() must be nested according to the
> + * rules documented in kmap_local_page()/kunmap_local().
> + *
> + * NOTE: ufs_find_entry() and ufs_dotdot() act as calls to ufs_get_page()
> + * and must be treated accordingly for nesting purposes.
> + */
>  static void *ufs_get_page(struct inode *dir, unsigned long n, struct page **page)
>  {
> +	char *kaddr;
> +
>  	struct address_space *mapping = dir->i_mapping;
>  	*page = read_mapping_page(mapping, n, NULL);
>  	if (!IS_ERR(*page)) {
> -		kmap(*page);
> +		kmap_local_page(*page);
>  		if (unlikely(!PageChecked(*page))) {
> -			if (!ufs_check_page(*page))
> +			if (!ufs_check_page(*page, kaddr))

	Er...  Building the patched tree is occasionally useful.
Here kaddr is obviously uninitialized and compiler would've
probably caught that.

	And return value of kmap_local_page() is lost, which
is related to the previous issue ;-)


>  				goto fail;
>  		}
>  	}
> -	return page;
> +	return *page;

Hell, no.  Callers expect the pointer to the first byte of
your page.  What it should return is kaddr.

> @@ -388,7 +406,8 @@ int ufs_add_link(struct dentry *dentry, struct inode *inode)
>  	mark_inode_dirty(dir);
>  	/* OFFSET_CACHE */
>  out_put:
> -	ufs_put_page(page);
> +	ufs_put_page(page, kaddr);
> +	return 0;
>  out_unlock:
>  	unlock_page(page);
>  	goto out_put;

That can't be right.  Places like
        if (err)
		goto out_unlock;
do not expect err to be lost.  You end up returning 0 now.  Something strange
happened here (in the previous commit, perhaps?)
