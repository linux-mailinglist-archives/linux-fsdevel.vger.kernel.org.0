Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCA7215587
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jul 2020 12:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbgGFK31 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jul 2020 06:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727896AbgGFK31 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jul 2020 06:29:27 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1F0C061794
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2020 03:29:27 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id t25so40037773lji.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jul 2020 03:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z3GIP+vVrK1iHIphuqjERXSBeRY1FUo4bBevHdOntZI=;
        b=fnR3wKhomOKGAbk5kNsqA7fQWlDE1fPbB7rfZFIOPpIIJ/i7ZSfYawc59Wrfl8hD/v
         wPiFcg3SkHJZgLv27oC1CBZoRYMrVzUwPc6R9V6pQ7KdnZfRFBXafyzVXNi02akOYgNw
         7BeNnJISYoTMO57R5FS9IH2uaMJXvkvzCXAJ6EdvbstbJjmQ5aaFt3U3Z30rFkhBwGpp
         An4nIs+LP7823hcUA8cEVNj3tnGT+4ctek5/3Nc7fXHYkk09feJqZW9UBTCfKDwricTV
         Hd5BRapdvPv+DVjg4GnIm6kWdVdzrfvJnZWY9IzrKZGXQqasWSTrAGd8RDjUpcmXAs+u
         e/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z3GIP+vVrK1iHIphuqjERXSBeRY1FUo4bBevHdOntZI=;
        b=RQgbJb3rF99wuu3G1AjMoqAyM6noBv2pSnEGD2VS6mKfHyyWDQaKyTrSabQBmOvxyn
         2WzhvE8CqkPfIaOvEbDmnmqU7SOdN+HKZ9pkhac+crbI7AleoTaLf9fTiq/ZVCwrPFzZ
         HSYI9n5Rw9M3C+Gn66TYWs96mOCiPY/4hXxvOyPGGbFPjyKxgNW9MDHvZmkmuBS38evR
         mK7H2qOpSX0CgIoPbBxVtnJeGLgV2WyHSA5UjqJaF7O8fC1/IsTgW0QAMbPMlf8soaij
         zy7V0aTHDj/GtzqEZk3nUz64kQCAaybF7grf6MKqk3KAsVtwhh1kDqnQDO2E+JO56baX
         jxrA==
X-Gm-Message-State: AOAM531Epu61ph4gJqoAJK1YqC56Je3jIu17APYBZBn9ToKBgNmIu+lC
        meaO/Nplx4LsieShVj1sgbIK4g==
X-Google-Smtp-Source: ABdhPJxZvqvsJrrcDAq3zGS5SOshEw2BuqtwlExxfkd1OM8yozcvrbINqyo92u6Pctkr7xTf+TwzrQ==
X-Received: by 2002:a2e:9a16:: with SMTP id o22mr27755376lji.40.1594031365574;
        Mon, 06 Jul 2020 03:29:25 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id u7sm11565953lfi.45.2020.07.06.03.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 03:29:24 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 4359710220C; Mon,  6 Jul 2020 13:29:25 +0300 (+03)
Date:   Mon, 6 Jul 2020 13:29:25 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/7] mm: Store compound_nr as well as compound_order
Message-ID: <20200706102925.ot3vgdg5mnr5d4gh@box>
References: <20200629151959.15779-1-willy@infradead.org>
 <20200629151959.15779-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629151959.15779-2-willy@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 29, 2020 at 04:19:53PM +0100, Matthew Wilcox (Oracle) wrote:
> This removes a few instructions from functions which need to know how many
> pages are in a compound page.  The storage used is either page->mapping
> on 64-bit or page->index on 32-bit.  Both of these are fine to overlay
> on tail pages.

I'm not a fan of redundant data in struct page, even if it's less busy
tail page. We tend to find more use of the space over time.

Any numbers on what it gives for typical kernel? Does it really worth it?

-- 
 Kirill A. Shutemov
