Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5D233CF840
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 12:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237652AbhGTKFg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 06:05:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:34988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237617AbhGTKEO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 06:04:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A91A761208;
        Tue, 20 Jul 2021 10:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626777890;
        bh=X130X0YVgUCYc69QG5qiLAvITmmN1lXsCRtssf0iGfw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KVApPeMHeRy15Lpbb+D5SHate6j2Rxr3yKHupmiwwCGPpsZL3itxKvpcfjZUQHl42
         6iPOZSLA2oJN7wc3w4y8uRYv9VyCb5U+cISizGj61SvpPYRCrKf7tL29zgJbZVen5e
         Y1WPacVJrk+/vE2m6+54kEuIDmZ8w/ADZSNWx0rb64v4f/gpxMMV8oo4zsKPxA+xdn
         pYLIQSwfTK28T3cTL/AnjowJ0FTCkq2Jh9QGS5/1eGoOTgpM/E+R9H+sYjt8flell5
         EyEQ6WmYfvic28PHXSlDcy1QZ9LJ3hSPeyhBLs4E6Eoju13bp/H3+4Q+VVnwsAFyed
         cGF6MXcoeZ9HA==
Date:   Tue, 20 Jul 2021 13:44:42 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v14 018/138] mm/filemap: Add folio_lock()
Message-ID: <YPapGqFH3Y0JJkCF@kernel.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-19-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-19-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:35:04AM +0100, Matthew Wilcox (Oracle) wrote:
> This is like lock_page() but for use by callers who know they have a folio.
> Convert __lock_page() to be __folio_lock().  This saves one call to
> compound_head() per contended call to lock_page().
> 
> Saves 455 bytes of text; mostly from improved register allocation and
> inlining decisions.  __folio_lock is 59 bytes while __lock_page was 79.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Layton <jlayton@kernel.org>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> Reviewed-by: David Howells <dhowells@redhat.com>
> ---
>  include/linux/pagemap.h | 24 +++++++++++++++++++-----
>  mm/filemap.c            | 29 +++++++++++++++--------------
>  2 files changed, 34 insertions(+), 19 deletions(-)

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

