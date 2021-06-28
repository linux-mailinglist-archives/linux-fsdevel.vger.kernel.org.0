Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC81F3B5E55
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jun 2021 14:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbhF1MtE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Jun 2021 08:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbhF1MtC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Jun 2021 08:49:02 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10247C061760
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jun 2021 05:46:37 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id u13so32447188lfk.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jun 2021 05:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bE94dkEiagNN+9+kFZlZw382SA94vUnxjwE0fje0Xk0=;
        b=Ht6Gea2SfQjaOGwZUSX+vM/eLTPlMEdb/841pVZfh+X68ssJ1KJDHcIP4x+pWOYZPj
         t507EHUiwc06CyBU/9L/T/wwPHRyOJKOMbq7acJb03LCk6Fu7c98WPFUiyYL9dcjes/O
         kR7VdZUEuquwEjystBKf8BJr/j1YtBuj4S+DbiOcsrqJiOyonmBQL03PDuKJzgzMjZnx
         sRjoeMZxy0tu9vK291N7BDHMWi/7Mxlw1wjnOaIUg41nDmWg7TZaPL/7OZf24MSsdWKm
         OUo1EtZQKY2OcT5a6oEKfexbrIFtzp5kIUpdQOQ04a+MWXtGOya3iCUPJ40pkYBjfhaV
         IwAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bE94dkEiagNN+9+kFZlZw382SA94vUnxjwE0fje0Xk0=;
        b=QYxEEK7GO14U3iYlfrxRqZ12g+chfUaCYNbKbE/gSANWSl9KX6AuVz9pmm7l+naPPO
         qsgF/rNyU1O4pEOK35hAKx6sdhYLZq4OXWoSiAyZOhbMKuOccZE9AVZ3qa6SFIqMh/09
         FGVUUSW7D/xVa8/Utwpbxqm35ZN0MLQHN3SO0JqXnzMl7a7Pja2md15FzGZ9OBI0PdJ8
         pIjErfmFRhLmFBQR890e9BESMaeIdoS+e4aXK1eXO5EpVMAuPeP8mZdP+EMrB2yuVEvo
         PnPxuy1y3fp9MA39zSmDs7nJva8og21XB4/KroSwZAEUl6PuaYGtU1qXtsHkBYrjRAjd
         HGog==
X-Gm-Message-State: AOAM530+eSCMa7tdceZSghs3PS1HzQNhdsbE5QXzsfNkyNRW/m4L/KW5
        aAAfZWm8fYIDI/T/FLLrtqd43w==
X-Google-Smtp-Source: ABdhPJx3x4IfClwhHCvXuiTmI3sq3nF9lEkNhcJjaCr83013VKYnGJ8cEjohV6J5iX9lASPr1gWtVA==
X-Received: by 2002:a05:6512:138a:: with SMTP id p10mr18835229lfa.505.1624884395244;
        Mon, 28 Jun 2021 05:46:35 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id q23sm1219833lfe.170.2021.06.28.05.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 05:46:34 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id E241710280E; Mon, 28 Jun 2021 15:46:33 +0300 (+03)
Date:   Mon, 28 Jun 2021 15:46:33 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v12 24/33] mm/swap: Add folio_rotate_reclaimable()
Message-ID: <20210628124633.vlckysu3zvvkyy4v@box.shutemov.name>
References: <20210622114118.3388190-1-willy@infradead.org>
 <20210622114118.3388190-25-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622114118.3388190-25-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 22, 2021 at 12:41:09PM +0100, Matthew Wilcox (Oracle) wrote:
> Convert rotate_reclaimable_page() to folio_rotate_reclaimable().  This
> eliminates all five of the calls to compound_head() in this function,
> saving 75 bytes at the cost of adding 15 bytes to its one caller,
> end_page_writeback().  We also save 36 bytes from pagevec_move_tail_fn()
> due to using folios there.  Net 96 bytes savings.
> 
> Also move its declaration to mm/internal.h as it's only used by filemap.c.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
