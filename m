Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246626496C4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Dec 2022 23:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbiLKW3j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Dec 2022 17:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiLKW3i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Dec 2022 17:29:38 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B11BE27;
        Sun, 11 Dec 2022 14:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RkoXLrf60DlqfevHVd1fistJ/ZvbvLvkVLWJvdmPdTY=; b=t2swjnBPMgJs0tduA6VEkoE4ms
        qg1XHhVIB+Tdxrw2ZvPedffiLUl8yP98KB/DVSBDEcNvi9lMIyQKVz8x3uzDnhRXiSrESBEzJ9w0V
        NVde3mnrdrxklo48kk7dHLVQ5sf6acV9YmRKsd3bCTnUy3AVoc0wpmND9tQenRnPj7AKW/LKTkjbj
        H6cyhGaJ/R9vTfkoW92/4S7Qq8tVqp3jl25IbpElvmkxtp7DAbbwvVCIjQHIXahkNVbAFRg1zOxIU
        wz7joIsCkxpshuCXlTRbyfnTuwmBanOMpZlcjU54XE7z9CYNCTWoVMkOXSOw+X/v/ske1FfrQaG+3
        kITHprQg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1p4Up9-00B6qQ-0P;
        Sun, 11 Dec 2022 22:29:31 +0000
Date:   Sun, 11 Dec 2022 22:29:31 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Evgeniy Dushistov <dushistov@mail.ru>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] fs/ufs: Change the signature of ufs_get_page()
Message-ID: <Y5ZZy23FFAnQDR3C@ZenIV>
References: <20221211213111.30085-1-fmdefrancesco@gmail.com>
 <20221211213111.30085-3-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221211213111.30085-3-fmdefrancesco@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Dec 11, 2022 at 10:31:10PM +0100, Fabio M. De Francesco wrote:
> -static struct page *ufs_get_page(struct inode *dir, unsigned long n)
> +static void *ufs_get_page(struct inode *dir, unsigned long n, struct page **page)
>  {
>  	struct address_space *mapping = dir->i_mapping;
> -	struct page *page = read_mapping_page(mapping, n, NULL);
> -	if (!IS_ERR(page)) {
> -		kmap(page);
> -		if (unlikely(!PageChecked(page))) {
> -			if (!ufs_check_page(page))
> +	*page = read_mapping_page(mapping, n, NULL);
> +	if (!IS_ERR(*page)) {
> +		kmap(*page);
> +		if (unlikely(!PageChecked(*page))) {
> +			if (!ufs_check_page(*page))
>  				goto fail;
>  		}
>  	}
>  	return page;

	return page_address(page), surely?
>  
>  fail:
> -	ufs_put_page(page);
> +	ufs_put_page(*page);
>  	return ERR_PTR(-EIO);
>  }
>  
> @@ -227,15 +227,12 @@ ufs_next_entry(struct super_block *sb, struct ufs_dir_entry *p)
>  
>  struct ufs_dir_entry *ufs_dotdot(struct inode *dir, struct page **p)
>  {
> -	struct page *page = ufs_get_page(dir, 0);
> -	struct ufs_dir_entry *de = NULL;
> +	struct ufs_dir_entry *de = ufs_get_page(dir, 0, p);

... considering e.g. this.  The caller expects the pointer to beginning of
page, not pointer to struct page itself.  Other callers are also like that...
