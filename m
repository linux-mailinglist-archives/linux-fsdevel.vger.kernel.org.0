Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26E671AF65C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Apr 2020 05:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbgDSDOt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Apr 2020 23:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725877AbgDSDOs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Apr 2020 23:14:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2E0C061A0C
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Apr 2020 20:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=y++SqS8nECS3a8Sm4kXuXS/brL8CTqTt7OycVrBfW18=; b=NmfvHnW5KXzBKXoQFxljf/4egX
        RHaF8/r5WJWov6AqXEuiT2L7Db05TSjFFIDWOPA15yoswASj2m896CqZu3T1uAdkZdN7DNcxykmRa
        Ntoc/DY1Q2xpM/aS1kimMFKpnoE1GPs8c27Pd8bcnW+G0TKNcq11il2rgislkjdp0LDtMIhInP1Za
        uoprAh42WhL1Z8zRyn3PGS/3xiM60nc7zDOZDGHiE8vrBfJZh9Lv/QU3o89mHqTxxUIrY9AqKpg+3
        SIwowTewNLI+ULRTzpx44/G0MRmbfTDk9RWstxn1vo5M91EXm5kopuG++n4BpXL6no0yrZpYaGRf1
        tEnsui5A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQ0Ps-0005KZ-25; Sun, 19 Apr 2020 03:14:44 +0000
Date:   Sat, 18 Apr 2020 20:14:43 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/5] export __clear_page_buffers to cleanup code
Message-ID: <20200419031443.GT5820@bombadil.infradead.org>
References: <20200418225123.31850-1-guoqing.jiang@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200418225123.31850-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 19, 2020 at 12:51:18AM +0200, Guoqing Jiang wrote:
> When reading md code, I find md-bitmap.c copies __clear_page_buffers from
> buffer.c, and after more search, seems there are some places in fs could
> use this function directly. So this patchset tries to export the function
> and use it to cleanup code.

OK, I see why you did this, but there are a couple of problems with it.

One is just a sequencing problem; between exporting __clear_page_buffers()
and removing it from the md code, the md code won't build.

More seriously, most of this code has nothing to do with buffers.  It
uses page->private for its own purposes.

What I would do instead is add:

clear_page_private(struct page *page)
{
	ClearPagePrivate(page);
	set_page_private(page, 0);
	put_page(page);
}

to include/linux/mm.h, then convert all callers of __clear_page_buffers()
to call that instead.

