Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB7F02B2C95
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Nov 2020 11:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgKNKGw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Nov 2020 05:06:52 -0500
Received: from verein.lst.de ([213.95.11.211]:49940 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbgKNKGw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Nov 2020 05:06:52 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id B244267373; Sat, 14 Nov 2020 11:06:48 +0100 (CET)
Date:   Sat, 14 Nov 2020 11:06:48 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, hughd@google.com, hch@lst.de,
        hannes@cmpxchg.org, yang.shi@linux.alibaba.com,
        dchinner@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 08/16] iomap: Use mapping_seek_hole_data
Message-ID: <20201114100648.GI19102@lst.de>
References: <20201112212641.27837-1-willy@infradead.org> <20201112212641.27837-9-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112212641.27837-9-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 12, 2020 at 09:26:33PM +0000, Matthew Wilcox (Oracle) wrote:
> Enhance mapping_seek_hole_data() to handle partially uptodate pages and
> convert the iomap seek code to call it.

Maybe split this into two patches for the mapping_seek_hole_data
enhancement (which could use a little more of a commit log anyway..)
and the iomap switch?

> -static inline bool page_seek_match(struct page *page, bool seek_data)
> +static inline loff_t page_seek_hole_data(struct xa_state *xas,
> +		struct address_space *mapping, struct page *page,
> +		loff_t start, loff_t end, bool seek_data)

This seems like quite a huge function to force inline..

