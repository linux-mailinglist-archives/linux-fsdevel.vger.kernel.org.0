Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7FED53639C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 May 2022 15:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352173AbiE0N5C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 May 2022 09:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240514AbiE0N5A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 May 2022 09:57:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5A312636
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 06:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rVGNfA2KOKMMKQxHMw7Bl8sMDqhn/iAj5Rbvd+jGcrE=; b=UYhm/b1bVNzPzhbsD47JkMo1vj
        R5iqplgtUNxUSuNc+pCWlQRknQg17DiyAyzTKgQWdU3R6RGllaC1pyYS4ateLvZU5YSXOHH1HC5gu
        UGd+BkkskdbS/2rPIufl5w2djB7D+W92CYmDUFJ60GgSgr0MASrIXe663xZ/AN1cScISusM4bugEx
        yDTrKexJJmI2JUNMCLE7LQY0F0dHGT1rZJyomzkOOUx+3LzbqkVzm8c/H2Mx++M0+EIY90urJsSMm
        jEvHf/6r8ebgeocVmxbFla/lJrpu07EKNZ9LDWevVKuZdGUcQskISEAqywwB5nPH8r/Z1DJgVEn6n
        cW7ceybQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nuaSS-0028gs-Fh; Fri, 27 May 2022 13:56:52 +0000
Date:   Fri, 27 May 2022 14:56:52 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     jfs-discussion@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [RFC PATCH 7/9] jfs: Read quota through the page cache
Message-ID: <YpDYpHG0cZM9E5lD@casper.infradead.org>
References: <20220526192910.357055-1-willy@infradead.org>
 <20220526192910.357055-8-willy@infradead.org>
 <YpBlF2xbfL2yY98n@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpBlF2xbfL2yY98n@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 26, 2022 at 10:43:51PM -0700, Christoph Hellwig wrote:
> >  static ssize_t jfs_quota_read(struct super_block *sb, int type, char *data,
> > +			      size_t len, loff_t pos)
> >  {
> >  	struct inode *inode = sb_dqopt(sb)->files[type];
> > +	struct address_space *mapping = inode->i_mapping;
> >  	size_t toread;
> > +	pgoff_t index;
> >  	loff_t i_size = i_size_read(inode);
> >  
> > +	if (pos > i_size)
> >  		return 0;
> > +	if (pos + len > i_size)
> > +		len = i_size - pos;
> >  	toread = len;
> > +	index = pos / PAGE_SIZE;
> > +
> >  	while (toread > 0) {
> > +		struct folio *folio = read_mapping_folio(mapping, index, NULL);
> > +		size_t tocopy = PAGE_SIZE - offset_in_page(pos);
> > +		void *src;
> > +
> > +		if (IS_ERR(folio))
> > +			return PTR_ERR(folio);
> > +
> > +		src = kmap_local_folio(folio, offset_in_folio(folio, pos));
> > +		memcpy(data, src, tocopy);
> > +		kunmap_local(src);
> 
> It would be great to have a memcpy_from_folio like the existing
> memcpy_from_page for this.

Yes, I agree.  It could copy more than a single page like
zero_user_segments() does.

> > +		folio_put(folio);
> >  
> >  		toread -= tocopy;
> >  		data += tocopy;
> > +		pos += tocopy;
> > +		index++;
> >  	}
> >  	return len;
> 
> And this whole helper is generic now.  It might be worth to move it
> into fs/quota/dquot.c as generic_quota_read.

I was thinking it was filemap_read_kernel(inode, pos, dst, len)
but perhaps both of these things ...
