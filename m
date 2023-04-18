Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9446E6DD1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Apr 2023 23:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbjDRVEi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Apr 2023 17:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjDRVEh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Apr 2023 17:04:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879D77ED6
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Apr 2023 14:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vCDjzmaa3p2tMjM3G7FhW//Qkig+FdA45bmUQyJrhjw=; b=MBn6xJFwXjeDDMq/7JwyghynDc
        HheluoZuMADZqg1+WWnJFewuS+WRWqWL12y08K1M9Lp7xm29HQYmJr4Oak+ERnNX4tAiPPNzNDwoP
        UPSR9iJt3NeirdcXFa0b7SxM/RLLg9ctQLkBIPyHwE9vuAmeWdQt/A07wi0JMtWFz6B0fCsfGudyS
        Fg7m4KZLJSGBnO/U26I1oqEu3lGigWvyiXaTRZebHSns1z6TJNTCxMja9Dfd6heA5XtlyGq6hrl6A
        iRrRbOs81Xrzr1mZE2678Vp/2KA/xpEEW8xOJmv0oztY1JibkInrpVKbPknsyZowLxGMnMQT4jUnd
        K4Jkj6KQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1posV4-00CfRE-Ff; Tue, 18 Apr 2023 21:04:30 +0000
Date:   Tue, 18 Apr 2023 22:04:30 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, tytso@mit.edu, broonie@kernel.org,
        sfr@canb.auug.org.au, hch@lst.de,
        Eric Biggers <ebiggers@kernel.org>,
        syzbot+d1ae544e6e9dc29bcba5@syzkaller.appspotmail.com,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH] ext4: Handle error pointers being returned from
 __filemap_get_folio
Message-ID: <ZD8F3qV6eLHZpagX@casper.infradead.org>
References: <20230418200636.3006418-1-willy@infradead.org>
 <20230418132321.4cfac3c19488c158a9e08281@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418132321.4cfac3c19488c158a9e08281@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 18, 2023 at 01:23:21PM -0700, Andrew Morton wrote:
> On Tue, 18 Apr 2023 21:06:35 +0100 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:
> 
> > Commit "mm: return an ERR_PTR from __filemap_get_folio" changed from
> > returning NULL to returning an ERR_PTR().  This cannot be fixed in either
> > the ext4 tree or the mm tree, so this patch should be applied as part
> > of merging the two trees.
> 
> Well that's awkward.
> 
> > --- a/fs/ext4/inline.c
> > +++ b/fs/ext4/inline.c
> > @@ -566,8 +566,9 @@ static int ext4_convert_inline_data_to_extent(struct address_space *mapping,
> >  	 * started */
> >  	folio = __filemap_get_folio(mapping, 0, FGP_WRITEBEGIN | FGP_NOFS,
> >  			mapping_gfp_mask(mapping));
> > -	if (!folio) {
> > -		ret = -ENOMEM;
> > +	if (IS_ERR(folio)) {
> > +		ret = PTR_ERR(folio);
> > +		folio = NULL;
> >  		goto out;
> >  	}
> 
> I suppose this could go into the ext4 tree, with IS_ERR_OR_NULL and a
> FIXME for later.

It looks really bad.

	if (IS_ERR_OR_NULL(folio)) {
		if (!folio)
			ret = -ENOMEM;
		else
			ret = PTR_ERR(folio);
		folio = NULL;
		goto out;
	}

> Or linux-next can carry it as one of its merge/build/other resolution
> patches?

That was my expectation.  Very unfortunate collision.  I'm sure Linus
will love it.

(Hold off on this precise version; running xfstests against it finds
something wrong)
