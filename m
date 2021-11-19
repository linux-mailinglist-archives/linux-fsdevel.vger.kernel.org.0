Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF5F457934
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Nov 2021 23:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234495AbhKSW7s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Nov 2021 17:59:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:47208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233433AbhKSW7r (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Nov 2021 17:59:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6581661A3D;
        Fri, 19 Nov 2021 22:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1637362605;
        bh=5TYNXOCWQqd9lahvFRSbbGUcFcxuELMbOWq1RB6UIKg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2dqufVZKmWo4eojHhdQmYJmMrhpHQKnua1AZQB3W8tMbkWb/oAtT0DpgeW3ZYiAlW
         RqpuBS8EHfDKyO2I7aHvbrFgYnXtvWVuK41H6mjoI4WhDI3g504NbZdxEKkiKNI93d
         ZNUNmF+x7lzsMulF54ax2R3jiYBj4FK9lGXrGpnM=
Date:   Fri, 19 Nov 2021 14:56:43 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Muchun Song <songmuchun@bytedance.com>, adobriyan@gmail.com,
        gladkov.alexey@gmail.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fs: proc: store PDE()->data into inode->i_private
Message-Id: <20211119145643.21bbd5ee8e2830dd72d983e3@linux-foundation.org>
In-Reply-To: <YZdQ+0D7n5xCnw5A@infradead.org>
References: <20211119041104.27662-1-songmuchun@bytedance.com>
        <YZdQ+0D7n5xCnw5A@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 18 Nov 2021 23:23:39 -0800 Christoph Hellwig <hch@infradead.org> wrote:

> On Fri, Nov 19, 2021 at 12:11:04PM +0800, Muchun Song wrote:
> > +
> > +/*
> > + * Obtain the private data passed by user through proc_create_data() or
> > + * related.
> > + */
> > +static inline void *pde_data(const struct inode *inode)
> > +{
> > +	return inode->i_private;
> > +}
> > +
> > +#define PDE_DATA(i)	pde_data(i)
> 
> What is the point of pde_data?

It's a regular old C function, hence should be in lower case.

I assume the upper case thing is a holdover from when it was
implemented as a macro.

>  If we really think changing to lower
> case is worth it (I don't think so, using upper case for getting at
> private data is a common idiom in file systems),

It is?  How odd.

I find the upper-case thing to be actively misleading.  It's mildly
surprising to discover that it's actually a plain old C function.

> we can just do that
> scripted in one go.

Yes, I'd like to see a followup patch which converts the current
PDE_DATA() callsites.

