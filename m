Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA2F35567D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 16:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244534AbhDFOVm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 10:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235007AbhDFOVm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 10:21:42 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABCAC06174A
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Apr 2021 07:21:34 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id b4so23045247lfi.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Apr 2021 07:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z4dXCA52eL9yGYEpPl96DmhaClVisBUZpt2xtmJBb8M=;
        b=X77QCn7n498c3YiPPqKnvfoDK1ALPoIzwOTOdapWUWwuKzdsQ3xWo/OznfYtfC3dGj
         rb0TAx5ZQC0MHX4OKg93zU6SjTAMKpJ9IcYP3bKj13S8/eM2pzb4yWt4axt8JMso//Cv
         DtdbXbOFBKwVnfgjZVMu68klEoBuAPo3x6w0B8KQjNFgtEMSmUeIz//i7CwJB9nK2jBL
         CdTnOlED4hyt46OO+HDicforXu3Edsso60+o5DqQz2N+4lg33wQRM3d5d3Lib5pxsAVq
         e4jIuZVi2GXr4sX+l5N9xLdgqRGdIz4WleLpCls93DJZgbgGbuB9IcRkc+/LYLC0cWY8
         8v0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z4dXCA52eL9yGYEpPl96DmhaClVisBUZpt2xtmJBb8M=;
        b=G1HLM6vWNk8IHsRd90Wj1+igZrcOSJt9Eo+ECDDj7n/hIRkkTWNpOox4eqbknp4HYO
         b8Z9FuOHAYEnviuhtjVSQFeGyAdruEvsY+ye+LNu3xi/BlAn5Px5+IlVmj4EWG8FZNGV
         N7eO7u1coRIkydvrZVUjwjxlSHpSXRYBM8toRDO80YyvQmROPUPWC13MQE5DfrCC6LTU
         UMnTu0jfCrNUN3Bt5qPyJlVPKksKSS5Dx0hoftyiFHzZPnRhg5cZKFBZ1S4AIvbXOh/I
         QOI+HnwpcFlQWK3g6QfTo1wRDNbanBYp0j+i2tZm2EOIfUgQWzRsnjPiYsUFr6qS9McU
         QcJA==
X-Gm-Message-State: AOAM532xNHwqgq3EX+ezyPNSqO/r3htgSyOjZiAWnaEJgQWmVu3sM80w
        rJRJh0JSZWUYIWK+nQYF7Yh7nlSiEVo4kg==
X-Google-Smtp-Source: ABdhPJwF9aOPC9ghWeCjNX8vk/cr/PjNYGMD/2j84h1aHqOpZ4D87I8y7s/rUF+6j04Rmu5y2i8WMA==
X-Received: by 2002:ac2:4111:: with SMTP id b17mr20833051lfi.96.1617718892692;
        Tue, 06 Apr 2021 07:21:32 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id f8sm2174697lfs.143.2021.04.06.07.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 07:21:32 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id F2E47101FF7; Tue,  6 Apr 2021 17:21:34 +0300 (+03)
Date:   Tue, 6 Apr 2021 17:21:34 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH v6 01/27] mm: Introduce struct folio
Message-ID: <20210406142134.tkxyy7ytib7vubf4@box.shutemov.name>
References: <20210331184728.1188084-1-willy@infradead.org>
 <20210331184728.1188084-2-willy@infradead.org>
 <20210406122918.h5dsnbjhmwpfasf4@box.shutemov.name>
 <20210406124807.GO2531743@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406124807.GO2531743@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 06, 2021 at 01:48:07PM +0100, Matthew Wilcox wrote:
> Now, maybe we should put this optimisation into the definition of nth_page?

Sounds like a good idea to me.

> > > +struct folio {
> > > +	/* private: don't document the anon union */
> > > +	union {
> > > +		struct {
> > > +	/* public: */
> > > +			unsigned long flags;
> > > +			struct list_head lru;
> > > +			struct address_space *mapping;
> > > +			pgoff_t index;
> > > +			unsigned long private;
> > > +			atomic_t _mapcount;
> > > +			atomic_t _refcount;
> > > +#ifdef CONFIG_MEMCG
> > > +			unsigned long memcg_data;
> > > +#endif
> > 
> > As Christoph, I'm not a fan of this :/
> 
> What would you prefer?

I liked earlier approach with only struct page here. Once we know a field
should never be referenced from raw struct page, we can move it here.

But feel free to ignore my suggestion. It's not show-stopper for me and
reverting is back doesn't worth it.

I went through the patchset and it looks good. You can use my

  Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

on all of them.

Thanks a lot for doing this.

-- 
 Kirill A. Shutemov
