Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D94D1F4AF9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 03:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgFJBiK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 21:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgFJBiJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 21:38:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1BBC05BD1E;
        Tue,  9 Jun 2020 18:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3F+VJ7llQg7YlsIbOqQTOSpD+AGEuzKY4qvDrz+pcDo=; b=b7sppN8zHI2+EHa+QBLCEjEWUe
        DE4rAM2ipTmZ97VXCv7po/GpLltoOcSIwIHrIdN3vnyRVCwizdRIU3/HUO7+V7BRcUeDfOcavlb10
        cISGdTB9JsjaHwJFp/e2yO9zPYfIEXzl32tiPwV4saSZdd3Q4d80q0IZNDcpXqcdc1HD9/BD8/mkA
        fPc5EhmWHUNWbF5yZRIaSE81Xabswr22lDSSv78Ceij8+CoSA4BFe02qGWJkH+jn46SHzMXQlVYT6
        7gAx54PsEmcE1kzp4It3phT3M/jMdhLbmhkzFXb3egQ918rhyxYOVkuHkhNljuBFniSspPDUaWCaw
        1ty82RTg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jipgu-00076G-HV; Wed, 10 Jun 2020 01:38:08 +0000
Date:   Tue, 9 Jun 2020 18:38:08 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] fs: generic_file_buffered_read() now uses
 find_get_pages_contig
Message-ID: <20200610013808.GF19604@bombadil.infradead.org>
References: <20200610001036.3904844-1-kent.overstreet@gmail.com>
 <20200610001036.3904844-3-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610001036.3904844-3-kent.overstreet@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 09, 2020 at 08:10:36PM -0400, Kent Overstreet wrote:
> Convert generic_file_buffered_read() to get pages to read from in
> batches, and then copy data to userspace from many pages at once - in
> particular, we now don't touch any cachelines that might be contended
> while we're in the loop to copy data to userspace.
> 
> This is is a performance improvement on workloads that do buffered reads
> with large blocksizes, and a very large performance improvement if that
> file is also being accessed concurrently by different threads.

Hey, you're stealing my performance improvements!

Granted, I haven't got to doing performance optimisations (certainly
not in this function), but this is one of the places where THP in the
page cache will have a useful performance improvement.

I'm not opposed to putting this in, but I may back it out as part of
the THP work because the THPs will get the same performance improvements
that you're seeing here with less code.
