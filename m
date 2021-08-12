Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8EE43EA5B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 15:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236474AbhHLNaS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 09:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbhHLNaR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 09:30:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E6DC061756;
        Thu, 12 Aug 2021 06:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=n3uGT6TuiZ+IureAJFuqNJpYzye9DlC/CR/MXpjpxJc=; b=bsSlLQ58RC0af8sYZ1HdLl+NGr
        LgBiJt6uTA6r/q4LkEnLqAIR8aT8kmsUJGHP6PJ76xz76cOjhDysZNVvUnI3m+oEFsgzMsNmlmxHG
        PheuAnTNIywrGLOedtEguU55zUd3ZmBaKAkl+sdAivIi30utO9GIQOVfdeqKiU/0n4IyHrqeb8cFy
        CGrZFXZO6OJq6RP77p2Vxa4TPdCo+9IXeCj7ZekmRH55B+7nyIQGYe/L42KYVGZkb95X6QWWutdca
        0GrhpiAd7+GlZFKgq97JGBEFEPi9LKvltjZrxEXJBDSkpmRMHLMKp/LeQALUOBXMbD2yeALx7x6bI
        SmJL4+/g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mEAl0-00EbbJ-US; Thu, 12 Aug 2021 13:28:47 +0000
Date:   Thu, 12 Aug 2021 14:28:26 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 8/8] iomap: Add writethrough for O_SYNC
Message-ID: <YRUh+tKuGI192qpc@casper.infradead.org>
References: <20210811024647.3067739-1-willy@infradead.org>
 <20210811024647.3067739-9-willy@infradead.org>
 <YRUfE5GH7LbyBnSM@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRUfE5GH7LbyBnSM@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 12, 2021 at 02:16:03PM +0100, Christoph Hellwig wrote:
> On Wed, Aug 11, 2021 at 03:46:47AM +0100, Matthew Wilcox (Oracle) wrote:
> > For O_SYNC writes, if the filesystem has already allocated blocks for
> > the range, we can avoid marking the page as dirty and skip straight to
> > marking the page as writeback.
> 
> So this just optimizes O_SYNC overwrites.  How common are those for
> bufered I/O?  I know databases use them a lot with direct I/O, but for
> buffere I/O this seems like an odd I/O pattern.

As the comment says:

+       /* Can't allocate blocks here because we don't have ->prepare_ioend */

Give me a way to allocate blocks and it can do better!  I didn't realise
this was going to be a problem when I embarked on this, but attempting
to do IO to wild addresses made me realise that most appending O_SYNC
writes are IOMAP_DELALLOC and so don't have allocated blocks.

And it's not just overwrites.  If you open(O_SYNC|O_TRUNC) and then
write ten bytes at a time, the first write to each block will cause us
to fall back to writeback pages, but subsequent writes to a block will
writethrough.
