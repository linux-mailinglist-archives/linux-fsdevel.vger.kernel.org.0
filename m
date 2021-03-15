Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B34E33B4DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 14:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhCONqA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 09:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbhCONpj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 09:45:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20616C06174A;
        Mon, 15 Mar 2021 06:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vX11bsGcJE0CRePOS5HuSnKaopIkgIWxWo8E8FVQGL8=; b=oQ69t1xbTPN6zyN+S04ZNJkw+1
        NHEq0XYigCUv7yk6ZSAuVHwDlAK7Y6Doa2HYx1gTelmAJcpuvZf5R7Esrm2Fkc3v8923U3B5YIf3a
        +WP6njTaJgADtltqncxuHYiEHjoJQHnoQMeqq7qzrd/TrOdVRTVx5gdVykRS4nzW5hgA8wkALDaJ1
        QOeAca+77u8HF9PRx/8d66M2YZut228mYetTSnOL3tHYHD55D3f8/QoPRLr5NzX16+KJKJ1+l2U7h
        V8f4fJ0tZAkO0I/GGeHWAOeuaIzH3+K94n9N8v+CY5hKgvOMZTAAm8zMR5TiQtRyewS9sIy/Q6DhV
        xaOi0Usw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lLnWu-000Fop-2q; Mon, 15 Mar 2021 13:45:14 +0000
Date:   Mon, 15 Mar 2021 13:45:08 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 00/25] Page folios
Message-ID: <20210315134508.GX2577561@casper.infradead.org>
References: <20210305041901.2396498-1-willy@infradead.org>
 <20210313123658.ad2dcf79a113a8619c19c33b@linux-foundation.org>
 <alpine.LSU.2.11.2103131842590.14125@eggly.anvils>
 <20210315115501.7rmzaan2hxsqowgq@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315115501.7rmzaan2hxsqowgq@box>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 15, 2021 at 02:55:01PM +0300, Kirill A. Shutemov wrote:
> I'm with Matthew on this. I would really want to drop the number of places
> where we call compoud_head(). I hope we can get rid of the page flag
> policy hack I made.

I can't see that far ahead too clearly, but I do think that at some
point we'll actually distinguish between folio flags and page flags.
For example, we won't have a FolioHWPoison, because we won't keep a folio
together if one page in it has become defective.  Nor will we have a
PageUptodate because we'll only care about whether a folio is uptodate.
And at that point, we won't want page flag policies.

