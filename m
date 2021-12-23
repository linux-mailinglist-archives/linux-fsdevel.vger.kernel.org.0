Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8182F47E489
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 15:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348831AbhLWObb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 09:31:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243798AbhLWObb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 09:31:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92310C061401
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Dec 2021 06:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Z1eiMI4jxOj7ZcVKGJ+SsGYdaWD045y5IWQK69kPbEw=; b=p8knSI2G3hsJCE+YZgPkHeSAHv
        0yGoq7Jk+7qtmkXt5XHUqiF2lJfEh4UVNqlrbulzR5GGYRkmWli5BcOvHryJsS9K1t5UGahLxngzH
        mUKQvOa8cxgMxMPlkuvH4+4ul4sMjqCgih/8gQVdbDCJ2PZzSShLKNrrQ8koUpMHayeK47v/fH7Zo
        gil7s0b2/x+FE/jrbwgbskSQ7J/9vCevZ5//OwuwDm4A90Pr9OQEao9rKjxk5LQMTJZr7YKd/YzAu
        8qQey8LJmkjXJz07BWRdYdQeSG3WhYh8SkiNu4zhQDLk0jkVedMdZt9DiS5yMSP+tJ84AlhGknxI4
        xSn2wzbg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0P7v-004KsY-Nx; Thu, 23 Dec 2021 14:31:27 +0000
Date:   Thu, 23 Dec 2021 14:31:27 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 07/48] iov_iter: Convert iter_xarray to use folios
Message-ID: <YcSIP5VuRJgU0iVg@casper.infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <20211208042256.1923824-8-willy@infradead.org>
 <YcQd2Fw7atXoU3Dn@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcQd2Fw7atXoU3Dn@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 22, 2021 at 10:57:28PM -0800, Christoph Hellwig wrote:
> > +		size_t offset = offset_in_folio(folio, start + __off);	\
> > +		if (xas_retry(&xas, folio))			\
> >  			continue;				\
> > +		if (WARN_ON(xa_is_value(folio)))		\
> >  			break;					\
> > +		if (WARN_ON(folio_test_hugetlb(folio)))		\
> >  			break;					\
> > +		while (offset < folio_size(folio)) {		\
> 
> Nit: I'd be tempted to use a for loop on offset here.

Dave, this is your code originally ... any opinions?

> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
