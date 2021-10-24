Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B06438B26
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Oct 2021 19:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbhJXR7n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Oct 2021 13:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhJXR7n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Oct 2021 13:59:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1643BC061745;
        Sun, 24 Oct 2021 10:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1owrIlrp7QuBS7qUG1k8fP6sKZZoIWNREotivRjTego=; b=tDdrpGRDcR2fZMb6A1NZfP2lzA
        9nUukj1JE/B7h5Fhe7f9FPnNmROgMH/50L+iNfpN0ENPPMv245cfAKIIuEcVly86Dzt9TGGxEwEeh
        kJ+Jr6kEiAe3XTzHDsL5QAhSzUARKITsL9iR8fpil8ouiG9CgB2c+5qJ028+rhlz6klMQqnkBnKWk
        OtaFZKmJnx2TZRTTU9W1gUOFkXN0TEBY3aQU5xMV7IE0nsdozwtk//IX0qggMSYc0ZaB8h1u8H+BZ
        pYQtGH7xbBl7wabKs0BGUp0MBxQ1Uuypt3rovQANDhy7wIPm5sx1oZJL4WoFKwcVEBJZ8RjWIkZny
        2IJCQhRw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mehiD-00FWjz-AL; Sun, 24 Oct 2021 17:55:52 +0000
Date:   Sun, 24 Oct 2021 18:55:13 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Len Baker <len.baker@gmx.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2][next] sysctl: Avoid open coded arithmetic in memory
 allocator functions
Message-ID: <YXWeAdsMRcR5tInN@casper.infradead.org>
References: <20211023105414.7316-1-len.baker@gmx.com>
 <YXQbxSSw9qan87cm@casper.infradead.org>
 <20211024091328.GA2912@titan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211024091328.GA2912@titan>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Oct 24, 2021 at 11:13:28AM +0200, Len Baker wrote:
> I think it is better to be defensive. IMHO I believe that if the
> struct_size() helper could be used in this patch, it would be more
> easy to ACK. But it is not possible due to the complex memory
> layouts.

I think it's better for code to be understandable.  Your patch makes
the code less readable in the name of "security", which is a poor
justification.

> However, there are a lot of code in the kernel that uses the
> struct_size() helper for memory allocator arguments where we know
> that it don't overflow. For example:

Well, yes.  That's because struct_size() actually makes code more
readable as well as more secure.

> As a last point I would like to know the opinion of Kees and
> Gustavo since they are also working on this task.
> 
> Kees and Gustavo, what do you think?

You might want to check who was co-author on 610b15c50e86 before
discarding my opinion.
