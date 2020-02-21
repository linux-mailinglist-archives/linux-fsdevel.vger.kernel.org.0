Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0244167DA3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 13:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgBUMmO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 07:42:14 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40878 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727686AbgBUMmO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 07:42:14 -0500
Received: by mail-lf1-f65.google.com with SMTP id c23so1385089lfi.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Feb 2020 04:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BjoBKXIcxCqkMcDtocPoDMNTlqqBgsrHw4ar9iaPBm8=;
        b=ImxHL/wm/0DS01CiAm6IEyWwr1YLg4Y3BMgGb3qHBzpXs/WO6b5aGLiMLpDzAoh9Tg
         MJJUjIIODYjwEhY8Iy+ppZfH3ZtHB+J9OXVBESkHQ0QoFjAQI7F/ylY3IiqDeNW1f/FG
         /iDbwrOK0MFXFLxT0aRtLkbodQsAn34GEkeKad5RP4G1ajX7uEFgyKVrglDwdbkW1ZSE
         OzU0NvLF0whVrsNO507XNiZkfQ6wCsuB2gM8lTiu0gYap7T/G2rgum0ZXp/fOGY0Ftyq
         08vypgcFeiDD7zXPofpZXUzuRdyRMOmnR0wKF8F70sFde2cGAEoLtBdJcnLS17waDJXM
         euCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BjoBKXIcxCqkMcDtocPoDMNTlqqBgsrHw4ar9iaPBm8=;
        b=bpBy4r+JtP5pqbh0vLlMsrbYhvinfkYVGsQxywLYTsglvxc7vEBcH8/yqXbzFVQKuP
         1CHG7NJ9NOFvV0yqHzhvco9MUlbDtp9UF8xCGWxYn6IZ1OXyzb41dIc/CxdB/Yi4wftL
         KTHTWdSrlkTQQU4lw5tDidI/jLXuFRnIQnR76YzTxr+WtpbjhJYCiB38xi5mSHtbpV5c
         Jr6grs/BwIQVGsU6n0dwBAI698LwCydZXp093IxIUI/SdDOEjYXhgcQ0LD5whLdeRqOE
         ko07uz6g3qlSlbgDvN0aPp2wAmupV7SXjbsvN/WJZ+yhSmyJyIzUmuTtTL5lRXCGMBuk
         bxjA==
X-Gm-Message-State: APjAAAWBFAeaXSFiZ4UtrFj1v3XZwLVjcbXojF0nLfBqmbGIkzhyN0zM
        mRM5nd2mdF04y/HozER7Gxo9iA==
X-Google-Smtp-Source: APXvYqwDJ3VvW3VVUq4oyV9v/CU0PsmTsHm77UKYLtap8C0MsC9PnyOumhZw7OnquLEBmI8nLdUKWA==
X-Received: by 2002:ac2:4477:: with SMTP id y23mr5248642lfl.135.1582288931518;
        Fri, 21 Feb 2020 04:42:11 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id r21sm1577795ljn.64.2020.02.21.04.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 04:42:10 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id AF956100FC3; Fri, 21 Feb 2020 15:42:40 +0300 (+03)
Date:   Fri, 21 Feb 2020 15:42:40 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/25] fs: Add zero_user_large
Message-ID: <20200221124240.tk4p2cx2p53emx5a@box>
References: <20200212041845.25879-1-willy@infradead.org>
 <20200212041845.25879-14-willy@infradead.org>
 <20200214135248.zqcqx3erb4pnlvmu@box>
 <20200214160342.GA7778@bombadil.infradead.org>
 <20200218141634.zhhjgtv44ux23l3l@box>
 <20200218161349.GS7778@bombadil.infradead.org>
 <20200218171052.lwd56nr332qjgs5j@box>
 <20200218180705.GA24185@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218180705.GA24185@bombadil.infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 18, 2020 at 10:07:05AM -0800, Matthew Wilcox wrote:
> On Tue, Feb 18, 2020 at 08:10:52PM +0300, Kirill A. Shutemov wrote:
> > Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> 
> Thanks
> 
> > > +#if defined(CONFIG_HIGHMEM) && defined(CONFIG_TRANSPARENT_HUGEPAGE)
> > > +void zero_user_segments(struct page *page, unsigned start1, unsigned end1,
> > > +               unsigned start2, unsigned end2);
> > > +#else /* !HIGHMEM || !TRANSPARENT_HUGEPAGE */
> > 
> > This is a neat trick. I like it.
> > 
> > Although, it means non-inlined version will never get tested :/
> 
> I worry about that too, but I don't really want to incur the overhead on
> platforms people actually use.

I'm also worried about latency: kmap_atomic() disables preemption even if
system has no highmem. Some archs have way too large THP to clear them
with preemption disabled.

I *think* there's no real need in preemption disabling in this situation
and we can wrap kmap_atomic()/kunmap_atomic() into CONFIG_HIGHMEM.

-- 
 Kirill A. Shutemov
