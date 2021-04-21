Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C96636709B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Apr 2021 18:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235525AbhDUQuM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 12:50:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:37628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242337AbhDUQuK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 12:50:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E35ED61449;
        Wed, 21 Apr 2021 16:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619023776;
        bh=ovwQvUiLjQh4syVeT9kD6YY2nN9dDFKXu4L+17YVjVY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=BTV6bhab9JxErl+ieNK9oDvjONaRI1t4awwwwkttErxlr1B9/7EKWjN/M09EjXSpb
         mSKuRperSp2jDXfwFbWb/EpsL+3apahcVwcU2f2DgmIxF+sPkyFuJrap9nCHQCyOhV
         i31C1ZJQUGhk4aTo32BSyMMF2MVB+HBHJNkeIeBLd/NfY/ILCcMgCLbMUzzfA6uQ0+
         wZHWYMN5xU+XsNS2/jLWmBV2EnU4iWUSv9W2dYhdWMn/8WSY2L/wKpjlVtJDy5sdrj
         34wBpVakFgbTAVpqwLThHom0tASvp8XK+0LgPffLrSj7RXgTx8IvL4PH2dxWEwvJoX
         VmodYns5wbWmw==
Message-ID: <931d356a9afd7066336308533f6f22ba7cea28e7.camel@kernel.org>
Subject: Re: [PATCH] mm/readahead: Handle ractl nr_pages being modified
From:   Jeff Layton <jlayton@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org
Date:   Wed, 21 Apr 2021 12:49:34 -0400
In-Reply-To: <20210420210328.GD3596236@casper.infradead.org>
References: <20210420200116.3715790-1-willy@infradead.org>
         <3675c1d23577dded6ca97e0be78c153ce3401e10.camel@kernel.org>
         <20210420210328.GD3596236@casper.infradead.org>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.0 (3.40.0-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2021-04-20 at 22:03 +0100, Matthew Wilcox wrote:
> On Tue, Apr 20, 2021 at 04:12:57PM -0400, Jeff Layton wrote:
> > > @@ -210,6 +208,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
> > >  			 * not worth getting one just for that.
> > >  			 */
> > >  			read_pages(ractl, &page_pool, true);
> > > +			i = ractl->_index + ractl->_nr_pages - index;
> 
> 			i = ractl->_index + ractl->_nr_pages - index - 1;
> 
> > > @@ -223,6 +222,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
> > >  					gfp_mask) < 0) {
> > >  			put_page(page);
> > >  			read_pages(ractl, &page_pool, true);
> > > +			i = ractl->_index + ractl->_nr_pages - index;
> 
> 			i = ractl->_index + ractl->_nr_pages - index - 1;
> 
> > Thanks Willy, but I think this may not be quite right. A kernel with
> > this patch failed to boot for me:
> 
> Silly off-by-one errors.  xfstests running against xfs is up to generic/278
> with the off-by-one fixed.


It worked fine with that change in place. You can add:

Tested-by: Jeff Layton <jlayton@kernel.org>

