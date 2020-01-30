Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94E9C14D702
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2020 08:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgA3H0G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jan 2020 02:26:06 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39060 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgA3H0G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jan 2020 02:26:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RPPsRlIh7a3GIi8RqNtoOhkrf/5qMif620lE3PkTLu8=; b=FComybUBSpIsVsPCMSjmNCnBS
        9jLghFjTprEBfNjFjotn0sZjFkUk4e5TRB/GGvxDYm99qbUJ5kRnW4GEyI9GkI9uGWpiqyGnV7sA2
        lqc2Ee9r0a6z21o47otyJKWgncd69lhhD4PVvN8M8lGZYX8sqZe0Y7kofXKTevE32P7oLZRCWorlO
        IIRq3TqCkooTcnzMioOCtxntyO1r8CU6MrNiyAJHmE+uQFB5Ytb6lvfa6+zyS8e6kqpYXl10+E8ui
        Er77KzutKqQDNgw32ehmvYUvxjTFbz+C1plaGsnQ/Xa5oOT0l//Xq9xZP7pjzIzDn2gq/fAlOr86o
        BKECudI5g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ix4DF-0001Z7-B0; Thu, 30 Jan 2020 07:26:05 +0000
Date:   Wed, 29 Jan 2020 23:26:05 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/12] fuse: Convert from readpages to readahead
Message-ID: <20200130072605.GJ6615@bombadil.infradead.org>
References: <20200125013553.24899-1-willy@infradead.org>
 <20200125013553.24899-12-willy@infradead.org>
 <CAJfpegvk2ZHzZCriAjdWoKvDXLtXi_c4mh34qLfy9O89+oAwhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvk2ZHzZCriAjdWoKvDXLtXi_c4mh34qLfy9O89+oAwhQ@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 29, 2020 at 11:50:37AM +0100, Miklos Szeredi wrote:
> On Sat, Jan 25, 2020 at 2:36 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> >
> > Use the new readahead operation in fuse.  Switching away from the
> > read_cache_pages() helper gets rid of an implicit call to put_page(),
> > so we can get rid of the get_page() call in fuse_readpages_fill().
> > We can also get rid of the call to fuse_wait_on_page_writeback() as
> > this page is newly allocated and so cannot be under writeback.
> 
> Not sure.  fuse_wait_on_page_writeback() waits not on the page but the
> byte range indicated by the index.
> 
> Fuse writeback goes through some hoops to prevent reclaim related
> deadlocks, which means that the byte range could still be under
> writeback, yet the page belonging to that range be already reclaimed.
>  This fuse_wait_on_page_writeback() is trying to serialize reads
> against such writes.

Thanks.  I'll put that back in.
