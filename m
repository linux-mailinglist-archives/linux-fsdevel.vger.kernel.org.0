Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4936615C831
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 17:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbgBMQ0e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 11:26:34 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57948 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727558AbgBMQ0e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 11:26:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kPlH775QJbn8K8wfZvzjHNcv5oOWudjwxkPvsWLCDdo=; b=pKHqdBZNcGOP2X9I4VB4N1ffkS
        uHSTE8nJ9E7WizXgntstiRRYSrviUpXs1vBBmeRLtkiabYM/ubpN9XzjZVNoB2HvdOx/aUMq9GzN8
        8GyruXlfqehb9BGPhPuFUltDTUnqND8t0lZk4rJKs0A2yVcBDc4IHNPrnXAdDFV8t/kPFzCs1/Y1t
        yAdbsetEYihXJND5jjiVgTLbYB2PR7JLiNJFPAYXzW67zzYtIaWZp0FZ4DaC4BbdIIYPhzQfeai4V
        lgw+riNojZsfj7fpMymUqwS3rH9WgBebiPxCLgY7EHokbSXVYb2/UgNVET6ykW2yzN94zqEctDzWG
        0yeWSo+Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j2HJy-0003UA-0l; Thu, 13 Feb 2020 16:26:34 +0000
Date:   Thu, 13 Feb 2020 08:26:33 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/25] fs: Make page_mkwrite_check_truncate thp-aware
Message-ID: <20200213162633.GP7778@bombadil.infradead.org>
References: <20200212041845.25879-1-willy@infradead.org>
 <20200212041845.25879-12-willy@infradead.org>
 <20200213154419.szxgd5tv2tjxmlz7@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213154419.szxgd5tv2tjxmlz7@box>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 13, 2020 at 06:44:19PM +0300, Kirill A. Shutemov wrote:
> On Tue, Feb 11, 2020 at 08:18:31PM -0800, Matthew Wilcox wrote:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > 
> > If the page is compound, check the appropriate indices and return the
> > appropriate sizes.
> 
> Is it guarnteed that the page is never called on tail page?

I think so.  page_mkwrite_check_truncate() is only called on pages
which belong to a particular filesystem.  Only filesystems which have
the FS_LARGE_PAGES flag set will have compound pages allocated in the
page cache for their files.  As filesystems are converted, they will
only see large head pages.

I'll happily put in a VM_BUG_ON(PageTail(page), page); to ensure we
don't screw that up.
