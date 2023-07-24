Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF8075FDEA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 19:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjGXRjD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 13:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjGXRjC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:39:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C0610D1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 10:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=Ng7LWPJ/45nE+0X2Uw07gbapNF8HAGcGiyHU5W4Ls88=; b=Ib8J3t6H2bxdWiJ/MpoM5DyuiH
        jfMB1ThC6+iOljpj0S+y/TjWdLWoDNnwb/OwnmtX2E17KtfwtmaOXNOgaJAg6GBkUjto+0SCxwclX
        vAg8QebpyvqfwneaTgtq8ooKKbXEw3ldykDIu/CLONAsim1wkQuYX+nC09zbnX5kpgRFtprfQuTCC
        nG1dj27lbqnY/ECGbRR6SDQykvZ3GILpWT9c7E8Bh5QJm2cS9DpRAb4FZOJadQwzjG0w6uWx0sJx5
        7GVUaL/A6RNhmpJ1ysf2UjaQ8pj5DC9dQJ6u9m1STsedOZPKUTjeupeE9OYXAyq2iyJ9znGsKtHp/
        5+dUQhKA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qNzWL-004eOz-A1; Mon, 24 Jul 2023 17:38:57 +0000
Date:   Mon, 24 Jul 2023 18:38:57 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     linux-mm@kvack.org, Arjun Roy <arjunroy@google.com>,
        Eric Dumazet <edumazet@google.com>,
        linux-fsdevel@vger.kernel.org,
        Punit Agrawal <punit.agrawal@bytedance.com>
Subject: Re: [PATCH v2 7/9] mm: Run the fault-around code under the VMA lock
Message-ID: <ZL63MYjtUuiyGgjS@casper.infradead.org>
References: <20230711202047.3818697-1-willy@infradead.org>
 <20230711202047.3818697-8-willy@infradead.org>
 <CAJuCfpF9DjN1OqKer_aGRWAHCBtEfYVcyThYzu9CXbWXSB8ybQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpF9DjN1OqKer_aGRWAHCBtEfYVcyThYzu9CXbWXSB8ybQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 13, 2023 at 08:32:27PM -0700, Suren Baghdasaryan wrote:
> On Tue, Jul 11, 2023 at 1:20 PM Matthew Wilcox (Oracle)
> <willy@infradead.org> wrote:
> >
> > The map_pages fs method should be safe to run under the VMA lock instead
> > of the mmap lock.  This should have a measurable reduction in contention
> > on the mmap lock.
> >
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> I'll trust your claim that vmf->vma->vm_ops->map_pages() never rely on
> mmap_lock. I think it makes sense but I did not check every case :)

Fortunately, there's really only one implementation of ->map_pages()
and it's filemap_map_pages().  afs_vm_map_pages() is a thin wrapper
around it.
