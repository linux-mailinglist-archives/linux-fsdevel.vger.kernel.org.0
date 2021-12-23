Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6EB047E48B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 15:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348831AbhLWOdB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 09:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbhLWOdB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 09:33:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919A8C061401
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Dec 2021 06:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QcDVR64BxqDwzqoahP33c28v+/sUsP60ObvEvRp3VzA=; b=OOmPCM8DjrglabG0TzcBn8t/DE
        yLPzvuSs69nlkWcn7IiI0nKudl7xEnkujpIuhWub11koR3NgN7wE4JBkwpKL0N3PZijdYiXiNg2Hh
        iihpLaPevCwZ/EpqrQOzmA6x37/i0VJGFeS6p47nHwGWgTWXK47HW4vI5RTHpmG+z9hox/aMwKz54
        VMFHrz4TqEeV4a8HFHbGsv4nPb/DaUAB69+alR6+AoIRGlAMXumcidykImF5QiDhV+Ixk71+dZiuG
        ago1OviBVc+MJ6slEYa6Pzon22xVkmXyNINqP80qcd3a/J4CZTIWoMQa7tm6v8264jwZiRUtp1Lfk
        kTV1Y5yA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0P9P-004Kvp-1f; Thu, 23 Dec 2021 14:32:59 +0000
Date:   Thu, 23 Dec 2021 14:32:59 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 09/48] filemap: Add folio_put_wait_locked()
Message-ID: <YcSIm9Qf1pU+BJM1@casper.infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <20211208042256.1923824-10-willy@infradead.org>
 <YcQemGi3byMpaIo3@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcQemGi3byMpaIo3@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 22, 2021 at 11:00:40PM -0800, Christoph Hellwig wrote:
> > -int put_and_wait_on_page_locked(struct page *page, int state);
> > +int folio_put_wait_locked(struct folio *folio, int state);
> 
> This could actually move to mm/internal.h.

It doesn't have any callers outside mm/ for now (and actually a couple
of the callers are going away), but conceptually it's part of the
lock_page() family of functions.  Some other places might benefit from
waiting without the reference held.
