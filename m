Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD6D4103BD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Sep 2021 06:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238562AbhIRExU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Sep 2021 00:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237401AbhIRExS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Sep 2021 00:53:18 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085D6C0613C1;
        Fri, 17 Sep 2021 21:51:54 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id g11so7789798qvd.2;
        Fri, 17 Sep 2021 21:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xnlJK2QDxvN8iWcRjZHdIvPQ/AxJxZfwNJq8W7/WDx0=;
        b=qO51PU+KTWRMVs02aFCQLj0BxjhJ30qJ/LQP1kVVFzP5x/xvKyKRo0A90P288aHv5x
         ATY1ru8pgVRbC0edCG91cYjKvXJBVMbnhEgOUFGW8ubGN3FGjQlFh9oReJe8w8Wu1EWU
         +nmDLVH2VvTi/MKNXOqaTciuwYvoIV3igYOAsopJ4sgLvpwlDk5S8EDNCdY+uAvcgu2u
         +OuurEGEs0KepoTzwf1KyuXc99Q3tkvyFJhFJ31IK+V4gs3bK6mCipNCZLTyA4pEnbcd
         hZEhxTZabllMY7OdhS8tn29oLGV+Sckqt4K1EynF4PMN7Bv1uLENU+maOMgmRwA6iNjv
         QXNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xnlJK2QDxvN8iWcRjZHdIvPQ/AxJxZfwNJq8W7/WDx0=;
        b=x5K2JpxmVcJ3v1BXmSGdTaoPHTLLmlOe9teHUVJEa8Hx5K05FNJgCuqjQ9KIoIXHI/
         DpuP0eFP/jYN75ngAMfBdoGDJacNKdWt86eu5PDvedGPJpeSwynhDXmk6rs0kzc5Ir+3
         ZqpS/uWz/d5epPcysM1gFqGNnUVTPNWXBA00YxdV/CoWwT+UU1gOeHiOI1fNGP/lAxqX
         B+5B57p3OptAESwGN/qlR0iY2OUZrW6d+WAztpwEe+IBCSwS1V/pKabPMGhcOm0IfBD0
         OylL+cfdCtO3WRo9TGqhLJ/E96RpNEbseYQAk8BJ/QL8I2OtDH7NFiTLSF+m/lkUFCdG
         BcJA==
X-Gm-Message-State: AOAM532fRoYtFAh/SSjTH7ViVWNCcidHjjT8GZg1jYIAoYJGIIaRoKYE
        y2VToI3QJXAICwMmoHDjiQ==
X-Google-Smtp-Source: ABdhPJx14NpxICY0C7PwvNnMhv+HtvMLK120FWdUGyxYOjBXD/sLmEJIKIgvSKZa5Byyy0f1X5lw4g==
X-Received: by 2002:a05:6214:529:: with SMTP id x9mr14616598qvw.17.1631940713177;
        Fri, 17 Sep 2021 21:51:53 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id w20sm6526364qkj.116.2021.09.17.21.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 21:51:52 -0700 (PDT)
Date:   Sat, 18 Sep 2021 00:51:50 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: Folio discussion recap
Message-ID: <YUVwZpTEuqhITGaJ@moria.home.lan>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YTu9HIu+wWWvZLxp@moria.home.lan>
 <YUIT2/xXwvZ4IErc@cmpxchg.org>
 <20210916025854.GE34899@magnolia>
 <YUN2vokEM8wgASk8@cmpxchg.org>
 <20210917052440.GJ1756565@dread.disaster.area>
 <YUTC6O0w3j7i8iDm@cmpxchg.org>
 <20210918010440.GK1756565@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210918010440.GK1756565@dread.disaster.area>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 18, 2021 at 11:04:40AM +1000, Dave Chinner wrote:
> As for long term, everything in the page cache API needs to
> transition to byte offsets and byte counts instead of units of
> PAGE_SIZE and page->index. That's a more complex transition, but
> AFAIA that's part of the future work Willy is intended to do with
> folios and the folio API. Once we get away from accounting and
> tracking everything as units of struct page, all the public facing
> APIs that use those units can go away.

Probably 95% of the places we use page->index and page->mapping aren't necessary
because we've already got that information from the context we're in and
removing them would be a useful cleanup - if we've already got that from context
(e.g. we're looking up the page in the page cache, via i_pageS) eliminating the
page->index or page->mapping use means we're getting rid of a data dependency so
it's good for performance - but more importantly, those (much fewer) places in
the code where we actually _do_ need page->index and page->mapping are really
important places to be able to find because they're interesting boundaries
between different components in the VM.
