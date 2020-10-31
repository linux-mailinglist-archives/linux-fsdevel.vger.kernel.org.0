Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C983F2A189B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Oct 2020 16:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgJaPmc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Oct 2020 11:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbgJaPmc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Oct 2020 11:42:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071FEC0617A6
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2020 08:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sSLFkz3d1Cn8ttpMqHEgOVeNrly/EFMpMNdfgjMy8vs=; b=HEB8Ig15St5eZs4IfN6rX2YV6y
        aPWl4qfjNwnB78M1+o/sF49b42LwEZe/kgZo19mc+Z/4GUscOGT35XeN+W5eXYSh+VTcHlQQTG6Ny
        A+2UFf4o3+WoGvliczjezd/dcbGE6x0E+JSMPM2Z2Hnz1tEMvt8VHs2cHP9iJEYGWw2d0MA5wuQfT
        yfDNyedaGm2Ujwy0tWoNB0ZDHZPUvP6JS/mt5yFvZ4I+ND+Eyhklpvs0bO8r1wKLTMmnBYbia/uNG
        D9itnj6OxvGMxfqZ6Tb6hnlHhRbJdX2fnsRd/3XHIXCLauHez9n9leKSyx+3fY6rX7VqO0rs9YA+k
        GWhMYcQA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYt1P-0004Ik-Jl; Sat, 31 Oct 2020 15:42:27 +0000
Date:   Sat, 31 Oct 2020 15:42:27 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: clean up the generic pagecache read helpers
Message-ID: <20201031154227.GQ27442@casper.infradead.org>
References: <20201031090004.452516-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201031090004.452516-1-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Oct 31, 2020 at 09:59:51AM +0100, Christoph Hellwig wrote:
> Hi Andrew,
> 
> this series cleans up refactors our generic read from page cache helpers.
> The recent usage of the gang lookups helped a fair amount compared to
> the previous state, but left some of the old mess and actually introduced
> some new rather odd calling conventions as well.
> 
> Matthew: I think this should actually help with your THP work even if it
> means another rebase.  I was a bit surprised how quickly the gang lookups
> went in as well.

I think this is 90% the same direction I'm heading in.  I'll chime in
with a few suggestions on the individual patches.
