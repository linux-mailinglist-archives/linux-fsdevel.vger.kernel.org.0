Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B18504361E2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 14:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbhJUMlG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 08:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbhJUMkz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 08:40:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C97C06174E;
        Thu, 21 Oct 2021 05:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=b97dcGvMvaI7aNoEUbcHH/tMuj2TYYPHMA+1H8wp8Qo=; b=aAkW3J2JlENuuKlasNEJbAmEsN
        H2+y0RaYxX/Q16d8wL73pYeNZClhK5KLJIcjOSaTtEKLqCvZwDX/k6V9kFsm3l1kN87LKJvpeZ1OH
        C4JnuFj6UkqRr6bsFdyrlKUjJ5WrSOlXwQyCv5N49FBJF41IIH0GWpSNy+H0U4cGP4ZssIqyG6yfr
        myeYp5/82dZZzQkVD7va6x00m8hRH/QA6FQQMw03GURemKYoUFjgA8ecByqppNcEbMd3g5L8pT2yg
        xRa05XyI9uYXJifIpoFPvVGm8hP0T9H2IlUKPdu4w7mAd6lRE8LW1irQdoYIVN7CbpWZE/ACwcfeg
        B7HAqONw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdXL3-007WMs-Ra; Thu, 21 Oct 2021 12:38:29 +0000
Date:   Thu, 21 Oct 2021 05:38:29 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
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
Message-ID: <YXFfRbPUpWUACVm3@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 21, 2021 at 02:35:32PM +0200, David Hildenbrand wrote:
> My opinion after all the discussions: use a dedicate type with a clear
> name to solve the immediate filemap API issue. Leave the remainder alone
> for now. Less code to touch, less subsystems to involve (well, still a
> lot), less people to upset, less discussions to have, faster review,
> faster upstream, faster progress. A small but reasonable step.

I don't get it.  I mean I'm not the MM expert, I've only been touching
most areas of it occasionally for the last 20 years, but anon and file
pages have way more in common both in terms of use cases and
implementation than what is different (unlike some of the other (ab)uses
of struct page).  What is the point of splitting it now when there are
tons of use cases where they are used absolutely interchangable both
in consumers of the API and the implementation?
