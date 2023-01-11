Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD886651EC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jan 2023 03:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbjAKCfb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Jan 2023 21:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235643AbjAKCfD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Jan 2023 21:35:03 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5996583;
        Tue, 10 Jan 2023 18:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=d0YGCY6szKQs1ImzBHjkVaJVEnN/RxTejjbNebHYzkk=; b=u2vibEtylqVp2QJuE2pRqL/4In
        to6QDVfsY6ocla6rrpGVthxAQWrQndSa93RADTryEc2fBASLMQJMXxyibLY2vS8E52CooY9CqCkN7
        dsvanL26ca9yy3iIWoBg5uTg0BATYlkUQvyzIhMSAhUoFGkhZbwp70wzB2y9e9m9GRmOdEtGostTO
        jjGjYngXcBKtSX8eMZpmAYnXNTO7XpgRI5sAXZsRTOG0Mbhz0yqJic60GjkJOvLdOt/Hj5hu2Sa2K
        MXTjYDpuNnonoREWJvYnincmhAnyIZkhcAAko3uUorJrv7FKFwj0/OoLv547OA6tV1y1rqI/tZQ/E
        0VqxTGiA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pFQwx-0016kX-2c;
        Wed, 11 Jan 2023 02:34:47 +0000
Date:   Wed, 11 Jan 2023 02:34:47 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH v2 2/4] fs/sysv: Change the signature of dir_get_page()
Message-ID: <Y74gRx6jLf2RHgdq@ZenIV>
References: <20230109170639.19757-1-fmdefrancesco@gmail.com>
 <20230109170639.19757-3-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230109170639.19757-3-fmdefrancesco@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 09, 2023 at 06:06:37PM +0100, Fabio M. De Francesco wrote:
>  
> -struct sysv_dir_entry * sysv_dotdot (struct inode *dir, struct page **p)
> +struct sysv_dir_entry *sysv_dotdot(struct inode *dir, struct page **p)
>  {
> -	struct page *page = dir_get_page(dir, 0);
> -	struct sysv_dir_entry *de = NULL;
> +	struct page *page = NULL;
> +	struct sysv_dir_entry *de = dir_get_page(dir, 0, &page);
>  
> -	if (!IS_ERR(page)) {
> -		de = (struct sysv_dir_entry*) page_address(page) + 1;
> +	if (!IS_ERR(de)) {
>  		*p = page;
> +		return (struct sysv_dir_entry *)page_address(page) + 1;
>  	}
> -	return de;
> +	return NULL;
>  }

Would be better off with 

	struct sysv_dir_entry *de = dir_get_page(dir, 0, p);

	if (!IS_ERR(de))
		return de + 1;	// ".." is the second directory entry
	return NULL;

IMO...
