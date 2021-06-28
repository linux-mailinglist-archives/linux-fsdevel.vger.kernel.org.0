Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD2ED3B5E5B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jun 2021 14:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbhF1MuE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Jun 2021 08:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbhF1MuC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Jun 2021 08:50:02 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFB5C061760
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jun 2021 05:47:35 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id h6so9295067ljl.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jun 2021 05:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ursImsAgaTR6zIVkoUjMNxEjW63HoZaM0yExGnPA+hA=;
        b=A9HeeZBytsdBt+1KdhCM8iMYlhjlcSmk3aSlcpPZfLvcQCszaafdjsRXs3H9qmus7S
         0oGxiIJFMc6G/tavzG8BGuy/gShF/O6oCBC8FElceRBF0UM+/sxGD9a1+qYYsdRuMCgg
         Fq4QkgqMoFDiOL/x//eWp4q+0sOSSUcmDeinQ8T+i2OjR2CCg85bWOQHwp2pJxj5YNe+
         x2Mq4dhrI72C0eeg6JofKANa8PT8TyH+7m17UjjuJvkRuwpFKoIwy+xryUsHBFw2ln8R
         Apz2LLOyVsGRtwMYzjpk6Ov/U8V6/4mBV6tpG1i1KOYNq5C0wCIhHuXbgE8cuQlW5xrZ
         Lt4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ursImsAgaTR6zIVkoUjMNxEjW63HoZaM0yExGnPA+hA=;
        b=Fnk8GjL7sSCv0jlIwu3KnQqM0mI3e0jM8XF3cIHB+YXt9Pg0yaqQzt3pyPmWmht1dv
         Yx9HAr6c2yziSwnoanwi4GjJt/KP+lgONyzvzwUdp9wxy8ltBmY9xFR597Lip42PK3Se
         IEDEQYcfmsrQzJAcu7J6kbiw32kBj8ABOJrz3aCbjf4qQejdZ6QPLZQo1FkjsDKYjv+t
         gnuX+FCQ0aGK+r6VfeStzbY5ZIyB60RO49sGvwqkW4wGfx83cDFlmsMaM27prYJIbOhS
         mHcWNqrL2jXnSQzc4r4sN1hOl86NtMHYfPeaTns4YIZ/j8aUl3KY9xvgKub7TYd2dvjS
         /1aw==
X-Gm-Message-State: AOAM531MTjJVoQ20JGvi1Gej/0guoY1ibTmgqnQ+fy7Yca/wuoXPCbzG
        S0fZBNEVF3U1NNc7P/YxJnbe3Q==
X-Google-Smtp-Source: ABdhPJxULJGp6xra6k3QCedA5kyzdSVv4Np6dSUQ0wM2xq9j7UdtgKnpSKQCIkzC5DaS+uKsQRQK1w==
X-Received: by 2002:a2e:8608:: with SMTP id a8mr19894662lji.268.1624884454268;
        Mon, 28 Jun 2021 05:47:34 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id f15sm1308952lfe.199.2021.06.28.05.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 05:47:33 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 255AE10280E; Mon, 28 Jun 2021 15:47:33 +0300 (+03)
Date:   Mon, 28 Jun 2021 15:47:33 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v12 31/33] mm/filemap: Add folio private_2 functions
Message-ID: <20210628124733.iumn4xg5iabojs7a@box.shutemov.name>
References: <20210622114118.3388190-1-willy@infradead.org>
 <20210622114118.3388190-32-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622114118.3388190-32-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 22, 2021 at 12:41:16PM +0100, Matthew Wilcox (Oracle) wrote:
> end_page_private_2() becomes folio_end_private_2(),
> wait_on_page_private_2() becomes folio_wait_private_2() and
> wait_on_page_private_2_killable() becomes folio_wait_private_2_killable().
> 
> Adjust the fscache equivalents to call page_folio() before calling these
> functions to avoid adding wrappers.  Ends up costing 1 byte of text
> in ceph & netfs, but the core shrinks by three calls to page_folio().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: David Howells <dhowells@redhat.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
