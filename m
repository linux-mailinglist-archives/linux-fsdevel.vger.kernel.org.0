Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A58543B5E2C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jun 2021 14:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbhF1MnT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Jun 2021 08:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbhF1MnS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Jun 2021 08:43:18 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1F1C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jun 2021 05:40:53 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id a6so1618424ljq.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jun 2021 05:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pWlR4YOkd8r6fBXSkgmDPdaUdCNYp8ikvYFMARhlCFg=;
        b=Oxksn4yKNReeH+KzWlY47KMNb9WTHopjB+tZf0NdYwVRIS3ZcFJ7afYEXXrxkqLIm6
         67Mss8GReFxB2AAOvKMD2qBQLWA42WpBddsLFYajCpUVv6rptpdC5xPvkW9xNA064UHn
         HrrPTAORiyHrH2sVlTca3RunbMlqXsTAptOg7u2VKKdMlWbSnLW1GEDRl8a6OwPtjcfL
         AFMH7JypJL11pG/D0zZ5/BwGTKHk9Js23O7SeQswpmANqyFhKkWOPk7EAdLx0XmC0VCf
         OUNQgPpdSwmXU4F9JEDMELGGOFoaSrpHkjokPRp51axX5Y1zg5/shsIpG0MPnESiT/0C
         32yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pWlR4YOkd8r6fBXSkgmDPdaUdCNYp8ikvYFMARhlCFg=;
        b=qn6hbWr0fbKRzFPAtzW3/X2t/re4gzAFGrvqI2R8qJumoJGoWLji5aO80RLHzxDxxM
         BS2yugYS8nF+jlzFj6uB5YdMf8u6sCCOKZDyupudCiQlB4qQDE8smKovWhO1/es4jmZx
         fRGe9z7RcnMKVFPi18FJnciMUeX7zjIYBEpuoWsMkaLAW7uDT3LYjpfjUKKg4HIxeMJB
         YgpWpLcOBbZSYcEIzTHhqNySUWqiwTvnPfjAj3Fkp4jPbas6NDEDOJiadXonl8khm3zC
         twCqCW4AkJNYiHCZG3bPAbidrlWPZaLkQCZd0EGcw3F3gdMitXC4Zv9VxUeMURND1g30
         8Xyw==
X-Gm-Message-State: AOAM531MlRSyb0FkxkQly/iBTSVXUDsxEgF5u1c6jeaFHLzxvYTCqKLN
        GhnKuJKZ53IbkgXZuLdea/Ev3A==
X-Google-Smtp-Source: ABdhPJxqOQLjAKOnhgVMn+Pqls/utX1ohXkGCAy/hp1RrNvoBiG/wi/OXtYdsQObKDfc/fG0tkghRg==
X-Received: by 2002:a2e:9945:: with SMTP id r5mr20046316ljj.324.1624884051437;
        Mon, 28 Jun 2021 05:40:51 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id m18sm393250lfu.67.2021.06.28.05.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 05:40:50 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 2AF8210280E; Mon, 28 Jun 2021 15:40:50 +0300 (+03)
Date:   Mon, 28 Jun 2021 15:40:50 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>, Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v12 11/33] mm/lru: Add folio LRU functions
Message-ID: <20210628124050.6xa7m6n362hst2op@box.shutemov.name>
References: <20210622114118.3388190-1-willy@infradead.org>
 <20210622114118.3388190-12-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622114118.3388190-12-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 22, 2021 at 12:40:56PM +0100, Matthew Wilcox (Oracle) wrote:
> Handle arbitrary-order folios being added to the LRU.  By definition,
> all pages being added to the LRU were already head or base pages,
> so define page wrappers around folio functions where the original
> page functions involved calling compound_head() to manipulate flags,
> but define folio wrappers around page functions where there's no need to
> call compound_head().  The one thing that does change for those functions
> is calling compound_nr() instead of thp_nr_pages(), in order to handle
> arbitrary-sized folios.
> 
> Saves 783 bytes of kernel text; no functions grow.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Yu Zhao <yuzhao@google.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: David Howells <dhowells@redhat.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
