Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBCBC410072
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 22:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243566AbhIQU7D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 16:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243276AbhIQU7C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 16:59:02 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E30FC061764
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Sep 2021 13:57:39 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id i25so38472193lfg.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Sep 2021 13:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=67xh3DmcBCGG+JgtqbeDJCPPKQGkafOab0xKjSMAcZA=;
        b=u/akYP8fIr5YX9VRdaEVJHYLd0LzSg00EpqVzqSwjM17eMmXVH4Vt7u55dJWa8zxUz
         NatucGpPSkbwSP36Zo8i0K+Tdv4MYgV0IB/C8Y1h8sVeFQfotq0CFjm9TF5uRAiK70nI
         e/zksaD+yvzB/to75omh0tw2JV236bxtkje3LEy0TifQzhUci5ZgWzfaeqgzT42/HlSj
         pcnjR+YcgyYj9PnIlzHCJsUWc5ZXad3h2vkzZ2KrVaIog3EvfIoCBxsAO0XU25Plpn6c
         iO6xIkbdg4nNSOTo5H8okK8vCt4llN9fyKMHGUuo3+1cwcSKm/oYiJ8xK7fgFfR8zrvk
         3FdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=67xh3DmcBCGG+JgtqbeDJCPPKQGkafOab0xKjSMAcZA=;
        b=L75q9RLLWpL7/PqyoLwK0O37nQnGinfBn42Mzx9brxa1OTtQMVIQoM0bewayNjEU6f
         GP4GXlcuecCdjJDgJeFxvX0hn+nisNpOwVgScQH9eFqt9YPDkSToVTyf14Y69ahsgSTs
         qzVquXywKwCjdQlAuSV4crtrudGD4SAb8pNrJs8/xUC4TdKkHFLBJl7mectQFa8j2jma
         bjEYcHSnTNveasXQB47sKlMZgq7ktZ3EYcVHWa3c3DkOsUGVr9JiIAQGlW7aayHv+0B1
         lpe9yKGfPcauN6Q++EBPsR0hcY0c6qlkJpKnU+uLdWcRyzuehgf4KOjUxV4MadoKaycX
         u28g==
X-Gm-Message-State: AOAM531VUPuXcACb4KvKmJ+MGG6P7Ep7j07AKCuTf/UeUjLAa9gNu/Te
        B5MmBZYP0+OrWyposP8daK747w==
X-Google-Smtp-Source: ABdhPJwzRLrammj1aWXBUhzKKoAy7/XvwF3BlowXLWGM9+36v2HXfgkOqKBJbRpX1iY07s9D7jGvhw==
X-Received: by 2002:a2e:9903:: with SMTP id v3mr11033539lji.383.1631912257807;
        Fri, 17 Sep 2021 13:57:37 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id y14sm607162lfk.237.2021.09.17.13.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 13:57:36 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 4AFBE103041; Fri, 17 Sep 2021 23:57:35 +0300 (+03)
Date:   Fri, 17 Sep 2021 23:57:35 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: Folio discussion recap
Message-ID: <20210917205735.tistsacwwzkcdklx@box.shutemov.name>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YTu9HIu+wWWvZLxp@moria.home.lan>
 <YUIT2/xXwvZ4IErc@cmpxchg.org>
 <20210916025854.GE34899@magnolia>
 <YUN2vokEM8wgASk8@cmpxchg.org>
 <20210917052440.GJ1756565@dread.disaster.area>
 <YUTC6O0w3j7i8iDm@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUTC6O0w3j7i8iDm@cmpxchg.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 17, 2021 at 12:31:36PM -0400, Johannes Weiner wrote:
> I didn't suggest to change what the folio currently already is for the
> page cache. I asked to keep anon pages out of it (and in the future
> potentially other random stuff that is using compound pages).

It would mean that anon-THP cannot benefit from the work Willy did with
folios. Anon-THP is the most active user of compound pages at the moment
and it also suffers from the compound_head() plague. You ask to exclude
anon-THP siting *possible* future benefits for pagecache.

Sorry, but this doesn't sound fair to me.

We already had similar experiment with PAGE_CACHE_SIZE. It was introduced
with hope to have PAGE_CACHE_SIZE != PAGE_SIZE one day. It never happened
and only caused confusion on the border between pagecache-specific code
and generic code that handled both file and anon pages.

If you want to limit usage of the new type to pagecache, the burden on you
to prove that it is useful and not just a dead weight.

-- 
 Kirill A. Shutemov
