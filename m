Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59D6342311D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Oct 2021 21:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235761AbhJET7q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Oct 2021 15:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235526AbhJET7n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Oct 2021 15:59:43 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D55C061749
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Oct 2021 12:57:52 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id o13so433682qvm.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Oct 2021 12:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8ZsMAGNTayv2iBn8EXiHZZPaHMkYLBgsl5jLImI14h0=;
        b=oh+Odu40d838WzNq/zvm7zb8DZUKDR9CSey+zO0RLrl3v/ly4FG2gn3EgmDLCT8OYs
         bfOkYNHQ7Xd8DtMLikbPn1SX1Ptfis5iywRMiA0hwGaCv1HDoFkUDW5GzoW1hFDNWiuO
         rMPSijwUaPaT2tQL9WD8mn6FoAXjHNrwU1RvUbuuL8uaHMAKWvkPJwR5Hu85wR/+w13z
         riRu+g2xZP88AyiO+q81CGqZiYVPTroq64qmJLkb3TZ4YMWmxaK64uu3q6m7QBjeVb1h
         chb9nRkfGu0r6ARwha9mJ5WpZqNnTS83YlLxnrbieIU6K5FaFiuebUWlNSsiwFgA7zM3
         32Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8ZsMAGNTayv2iBn8EXiHZZPaHMkYLBgsl5jLImI14h0=;
        b=BSzoP6iSpbTlAo70WSmKC0OndEBsMH+CgX1fRqrkqpx/or0nBZdOtQvpPvW9wI7XIQ
         JpS3jc28JWwj17P2m4fQJSnK0WeFQ0sKe5R06SmKuKpd6MR+T24rz9S6Te2xRa7qCQEQ
         RyldYkTT25Mz+KSLUoP/7CdACgmvTrjyRed/ifs+6G0JNx918enBlwiTpVF2aqtRvjzS
         YF5z4jrFipHBR3U8oB2oViihesiV+UEiktpljHZp2DOkj/585UUqcX5ucN+T1z6QjgRi
         DcXMCIxdJER4oCxovuZRRJ7BAtwQw4AIQJD4l+iMOoNyzV3CuevFcfk6Z8MxKhGE+gaw
         eVtA==
X-Gm-Message-State: AOAM533K0kE4EIBDSFtJ+5E7bwj8dyLFoTF8UmMsMJCXhUEuPAqUBrvk
        R+4Y7eBPrWLtNu/yIwGO3/rcFU+nbx3iPw==
X-Google-Smtp-Source: ABdhPJy2LAecQlkA5PqstBXPQYwI9yj/XHyCEnz69vrtX3R59Wivgq5kn6JOJ0gIxOpEUZcXP4U2/g==
X-Received: by 2002:a05:6214:5b1:: with SMTP id by17mr27353744qvb.18.1633463871763;
        Tue, 05 Oct 2021 12:57:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id z19sm10946484qts.96.2021.10.05.12.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 12:56:51 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mXqXi-00BIG6-O4; Tue, 05 Oct 2021 16:56:02 -0300
Date:   Tue, 5 Oct 2021 16:56:02 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] Memory folios for v5.15
Message-ID: <20211005195602.GA2688930@ziepe.ca>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YSQSkSOWtJCE4g8p@cmpxchg.org>
 <YVxYgQa1cECYMtOL@casper.infradead.org>
 <YVyLh+bnZzNeQkyb@cmpxchg.org>
 <YVyZruvGbGlNycSu@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVyZruvGbGlNycSu@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 05, 2021 at 07:30:06PM +0100, Matthew Wilcox wrote:

> Outside of core MM developers, I'm not sure that a lot of people
> know that a struct page might represent 2^n pages of memory.  Even
> architecture maintainers seem to be pretty fuzzy on what
> flush_dcache_page() does for compound pages:
> https://lore.kernel.org/linux-arch/20200818150736.GQ17456@casper.infradead.org/

I definitely second that opinion

A final outcome where we still have struct page refering to all kinds
of different things feels like a missed opportunity to me.

Jason
