Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE483A87DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 19:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbhFORhX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 13:37:23 -0400
Received: from verein.lst.de ([213.95.11.211]:50622 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231593AbhFORhF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:37:05 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9D04C68C7B; Tue, 15 Jun 2021 19:34:54 +0200 (CEST)
Date:   Tue, 15 Jun 2021 19:34:53 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] iomap: Use __set_page_dirty_nobuffers
Message-ID: <20210615173453.GA2849@lst.de>
References: <20210615162342.1669332-1-willy@infradead.org> <20210615162342.1669332-4-willy@infradead.org> <YMjhP+Bk5PY5yqm7@kroah.com> <YMjkNd0zapLcooNB@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMjkNd0zapLcooNB@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 15, 2021 at 06:32:37PM +0100, Matthew Wilcox wrote:
> On Tue, Jun 15, 2021 at 07:19:59PM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Jun 15, 2021 at 05:23:39PM +0100, Matthew Wilcox (Oracle) wrote:
> > Using __ functions in structures in different modules feels odd to me.
> > Why not just have iomap_set_page_dirty be a #define to this function now
> > if you want to do this?
> > 
> > Or take the __ off of the function name?
> > 
> > Anyway, logic here is fine, but feels odd.
> 
> heh, that was how I did it the first time.  Then I thought that it was
> better to follow Christoph's patch:
> 
>  static const struct address_space_operations adfs_aops = {
> +       .set_page_dirty = __set_page_dirty_buffers,
> (etc)

Eventually everything around set_page_dirty should be changed to operate
on folios, and that will be a good time to come up with a sane
naming scheme without introducing extra churn.
