Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B7842497D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 00:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239743AbhJFWMh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Oct 2021 18:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhJFWMh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Oct 2021 18:12:37 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78002C061746
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Oct 2021 15:10:44 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id m26so3590489pff.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Oct 2021 15:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oWSruVJuryiK/bq8Tb7cAfiZtFXGIkkK3qdg+hZlJPo=;
        b=gKlJU+m40tax0PtyUq20EP3NhUZJyemt4EdKN1VUXbXdxVsJAOkV4RZI1O8r68cY8/
         uy6xIIB5iuLzMXW/K/+2k0lmHSNNCVpemBHfeF3L+QQFjR8efmgTzpYcRWuc2lIgifLp
         GTs54GuwtkFfcFGLJAS6Sc9HSVGFa6J0YvaAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oWSruVJuryiK/bq8Tb7cAfiZtFXGIkkK3qdg+hZlJPo=;
        b=5KGsPOL/jyXFactg8sJR7Z0l7rzDGMOv17oRr2L+n9FBX6JivB4v0LCUvu+dmtBvRG
         xNdnXX5mj4otTgmUp78JL/Lj+y5g4PSxiEF1apgLUQP/I/pkPVQVkBFlOth711nZMQD3
         Lr5m68kmQ3PooVWSGKvsvu+z5BkDS5e+ZPhOG0BM/DYLg8MTTxTTYXxgBL8Z/3NrSYeL
         H/D93GLPJ7rIArmnUSDkVod100PrkWzH6ZDHJhVTFsk4fBKqlT8iVRKZZwpGCKDYEQvm
         cMmqalVkOmFGZMihUI2GVzl+cCZJii/w7pgCRcBurjeucVa+2QzKiJY2JjWMZzxN64OY
         jTxQ==
X-Gm-Message-State: AOAM533aGqB/gICbWXpWchopB6gMAWYaUjicQC8DcgHHGuGdiXUUYYxP
        GZCUoKuU0fIFODLos7OO4sxgEg==
X-Google-Smtp-Source: ABdhPJw1osKOoy8Z1O6LqqUXzbmJotscDxwacRYKTdspCtWoI+9jVL0+t6IYiwgWRhmCEKuZsan7aw==
X-Received: by 2002:a63:7d04:: with SMTP id y4mr430350pgc.131.1633558244085;
        Wed, 06 Oct 2021 15:10:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n185sm22879077pfn.171.2021.10.06.15.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 15:10:43 -0700 (PDT)
Date:   Wed, 6 Oct 2021 15:10:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Hao Sun <sunhao.th@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        Christoph Hellwig <hch@lst.de>
Subject: Re: WARNING in __kernel_read
Message-ID: <202110061510.24208C2@keescook>
References: <CACkBjsbPsmUiC7NFgOZcVcwPA7RLpiCFkgEA=LsnvcFsWFG34Q@mail.gmail.com>
 <YV2T3HVHHmQPHVYG@casper.infradead.org>
 <YV2rQnl1kJ84C1RV@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YV2rQnl1kJ84C1RV@mit.edu>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 06, 2021 at 09:57:22AM -0400, Theodore Ts'o wrote:
> On Wed, Oct 06, 2021 at 01:17:32PM +0100, Matthew Wilcox wrote:
> > finit_module() is not the only caller of kernel_read_file_from_fd()
> > which passes it a fd that userspace passed in, for example
> > kexec_file_load() doesn't validate the fd either.  We could validate
> > the fd in individual syscalls, in kernel_read_file_from_fd()
> > or just do what vfs_read() does and return -EBADF without warning.
> 
> My suggestion would be to do both, and keep a WARN() in
> __kernel_read(), since that should never happen (and we want a stack
> trace if it does).

Agreed.

-- 
Kees Cook
