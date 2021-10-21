Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBD243620D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 14:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbhJUMrh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 08:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbhJUMrh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 08:47:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9E7C06161C;
        Thu, 21 Oct 2021 05:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MhYSZk7FAb+xEHuiCzqmgFseK1YofUw99Jp2bva3xY8=; b=wVbv7NUbTjE8dMe69LJ3KyJhcb
        65x7KsMVnnOpwDx2m5nASW/7LO2m9m+V1QKkFSqW//U1b1RijQxuQlUD4PrsbfPRP6RDx/wdevlOk
        3T8UwJSjKBVgfKaiDNrCbShQAcmagdvdObG0SVx9XlDZd4fNSD3LGTEytVpaeiKdMF6Y5z1hzz8so
        Z513j9bejFZRpj1FG1m5QySDRgw23NQi0vNt13lbT8UgVLuqlBz2hyp6hKQ07pkTh3zRx/nyAAsXD
        k3wZ1SHfCI8//EYUi6XCQJr5G0mxUKylt8S3s+/ky0BTdnO3Tu6gWpvIqOZKk3nbr/D46Gxk92xkR
        NSjXSV9g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdXON-00DGl6-Rc; Thu, 21 Oct 2021 12:42:41 +0000
Date:   Thu, 21 Oct 2021 13:41:55 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: Folios for 5.15 request - Was: re: Folio discussion recap -
Message-ID: <YXFgEzZw/AOJ7AnW@casper.infradead.org>
References: <YW3tkuCUPVICvMBX@cmpxchg.org>
 <20211018231627.kqrnalsi74bgpoxu@box.shutemov.name>
 <YW7hQlny+Go1K3LT@cmpxchg.org>
 <996b3ac4-1536-2152-f947-aad6074b046a@redhat.com>
 <YXBRPSjPUYnoQU+M@casper.infradead.org>
 <436a9f9c-d5af-7d12-b7d2-568e45ffe0a0@redhat.com>
 <YXEOCIWKEcUOvVtv@infradead.org>
 <f31af20e-245d-a8f1-49fa-e368de9fa95c@redhat.com>
 <YXFXGeYlGFsuHz/T@moria.home.lan>
 <2fc2c5da-c0e9-b954-ba48-e258b88e3271@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fc2c5da-c0e9-b954-ba48-e258b88e3271@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 21, 2021 at 02:35:32PM +0200, David Hildenbrand wrote:
> My opinion after all the discussions: use a dedicate type with a clear
> name to solve the immediate filemap API issue. Leave the remainder alone
> for now. Less code to touch, less subsystems to involve (well, still a
> lot), less people to upset, less discussions to have, faster review,
> faster upstream, faster progress. A small but reasonable step.

I didn't change anything I didn't need to.  File pages go onto the
LRU list, so I need to change the LRU code to handle arbitrary-sized
folios instead of pages which are either order-0 or order-9.  Every
function that I convert in this patchset is either used by another
function in this patchset, or by the fs/iomap conversion that I have
staged for the next merge window after folios goes in.
