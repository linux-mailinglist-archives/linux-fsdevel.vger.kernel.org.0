Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF6513DA82C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jul 2021 18:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbhG2QAv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jul 2021 12:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235214AbhG2QAl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jul 2021 12:00:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E762C0617A4;
        Thu, 29 Jul 2021 09:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lz3sCBUeoFIpcuJvkV+2hxcBz6NNpFWXO3cu/2smPZU=; b=rAdanEV3TxYnKye4f2nl/t9Vmz
        VvBRYHsQc2daZHGww9PrpfLisetD38btktOOIp+KJKfyuFC5LLEnHs/WlvvaD2+SFzzsDhVo387Fy
        /vkh9nSmyzuIdYc1kb6LUUrALObzOGJYaHoHagmA+FbCa60A44n9FkbrXIzdhAkGoC5By+vjko248
        iP2+tkxUG9pl3TMISopAEr70NLHUj3I1X2RoYdR3YgX254YGRVEA/iBuQszMwUL3Ie0hZLeTP9Hls
        90PEXvI6g36ruUlwwwnkoZ3gv/lDsdlSZPU0r+GOAauHY/N+8C8uRdzS47Vyc/x/S56Zz9R/XbH/U
        vlyqABJQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m98R2-00HGfk-5K; Thu, 29 Jul 2021 15:59:23 +0000
Date:   Thu, 29 Jul 2021 16:59:00 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, pali@kernel.org, dsterba@suse.cz,
        aaptel@suse.com, rdunlap@infradead.org, joe@perches.com,
        mark@harmstone.com, nborisov@suse.com,
        linux-ntfs-dev@lists.sourceforge.net, anton@tuxera.com,
        dan.carpenter@oracle.com, hch@lst.de, ebiggers@kernel.org,
        andy.lavr@gmail.com, kari.argillander@gmail.com,
        oleksandr@natalenko.name
Subject: Re: [PATCH v27 02/10] fs/ntfs3: Add initialization of super block
Message-ID: <YQLQRGyKGdL00sQ7@casper.infradead.org>
References: <20210729134943.778917-1-almaz.alexandrovich@paragon-software.com>
 <20210729134943.778917-3-almaz.alexandrovich@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729134943.778917-3-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 29, 2021 at 04:49:35PM +0300, Konstantin Komarov wrote:
> +static void ntfs_readahead(struct readahead_control *rac)
> +{
> +	struct address_space *mapping = rac->mapping;
> +	struct inode *inode = mapping->host;
> +	struct ntfs_inode *ni = ntfs_i(inode);
> +	u64 valid;
> +	loff_t pos;
> +
> +	if (is_resident(ni)) {
> +		/* no readahead for resident */
> +		return;
> +	}
> +
> +	if (is_compressed(ni)) {
> +		/* no readahead for compressed */
> +		return;

I'm sure this works, but it could perform better ;-)

The ->readpage path that you fall back to is synchronous (unless I
misunderstand something).  We now have readahead_expand() which lets
you ensure that there are pages in the page cache for the entire
range of the compressed extent.  So if you can create an asynchronous
decompression path (probably need your own custom bi_end_io), you can
start reads here and only unlock the pages after you've done the
decompression.

This should not gate your code being accepted upstream.  What I'd
really like to see is your buffered i/o path being converted from
buffer_heads to iomap, and iomap to gain the ability to handle
compressed extents.

> +	valid = ni->i_valid;
> +	pos = readahead_pos(rac);
> +
> +	if (valid < i_size_read(inode) && pos <= valid &&
> +	    valid < pos + readahead_length(rac)) {
> +		/* range cross 'valid'. read it page by page */
> +		return;

This, I do not understand.  Why can't ntfs_get_block / mpage_readahead
cope with a readahead that crosses i_valid?  AIUI, i_valid is basically
the same as i_size, and mpage_readahead() handles crossing i_size
just fine.

