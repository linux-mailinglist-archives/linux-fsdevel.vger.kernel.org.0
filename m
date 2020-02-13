Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E55315C052
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 15:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbgBMOaG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 09:30:06 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60584 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbgBMOaG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 09:30:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KTXaMIDU0VI58k/CHPXmfgCSDh5X+93IZYgYYvIbxGE=; b=QXUdB0/6AYsObrEOZa7o4zPxjv
        UC2iUMIw08PUkLzXQ1OQAtizLfmmBWEkBW/lGlqfp7M0pym9jVcl7kZK/ic6rltzWi8GT5JzjmOlB
        xkqeUwFBAMD+Pf7pV6M2+XgBCL8C46dw966pg6hG+xm1EZ36yaMzhKmOkodRVxrPXzy8rDs2jaQjg
        VRdAFafSYz/LKKI4xNk0NB1RTHg+ta/h30n5fao/Su7dOFGe2C2LZb6a1Mo733D4OrFUUEedegjea
        V1nCfMOeF0/bPJ7k0/cRQEvadIZH8n7Uzkan1jx3F/UFGmz4Os4ZX2y3a3IYTDMgoipisXgBY450w
        GdED8D/Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j2FVF-00084J-Mh; Thu, 13 Feb 2020 14:30:05 +0000
Date:   Thu, 13 Feb 2020 06:30:05 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/25] mm: Allow hpages to be arbitrary order
Message-ID: <20200213143005.GL7778@bombadil.infradead.org>
References: <20200212041845.25879-1-willy@infradead.org>
 <20200212041845.25879-7-willy@infradead.org>
 <20200213141107.ftfnenli72eburei@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213141107.ftfnenli72eburei@box>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 13, 2020 at 05:11:07PM +0300, Kirill A. Shutemov wrote:
> On Tue, Feb 11, 2020 at 08:18:26PM -0800, Matthew Wilcox wrote:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > 
> > Remove the assumption in hpage_nr_pages() that compound pages are
> > necessarily PMD sized.  The return type needs to be signed as we need
> > to use the negative value, eg when calling update_lru_size().
> 
> But should it be long?
> Any reason to use macros instead of inline function?

Huh, that does look like a bit of a weird change now you point it out.
I'll change it back:

 static inline int hpage_nr_pages(struct page *page)
 {
-	if (unlikely(PageTransHuge(page)))
-		return HPAGE_PMD_NR;
-	return 1;
+	return compound_nr(page);
 }
