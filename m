Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC07A3B5E68
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jun 2021 14:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbhF1MyC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Jun 2021 08:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbhF1Mx7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Jun 2021 08:53:59 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107BBC061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jun 2021 05:51:33 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id w11so4936413ljh.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jun 2021 05:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tFpwwri/X5gBvVcIgbQFvNQzUQidUndNbiZ2bXpBwRI=;
        b=QSzp02hungPLcF2/Cclzm2bRcUqPPjAJhMpnMMYM06cAEyZlUpfYXyt1m/9QLJlxPY
         2W4v66FlwC0sjTPbdI+OiNlLgxrQRwZ1t8YtWG86BforsYbSitzG82kv1fT7ZHhAJBTS
         cDriYUDGYEZkixrY8HPqDdynH4E3cl1ETyGf+X2pblTRbWBs7km95NJ+EG4FXiURfwpR
         Ex7zSufnSLaXaRGt++aQJLoRok6wA28GcOs5JL5Q6T9zcPa0FXe4KAbINStf2hYzshgq
         jjfW81aVLxJCnwg5mNYEIYMQSkZTOWL6ISzKgSlJW5OIOU72pfHj4grCzGJv7UIFW/N1
         HJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tFpwwri/X5gBvVcIgbQFvNQzUQidUndNbiZ2bXpBwRI=;
        b=Vs6TtPCYNxMCJ0Hkw5+aodiuReudtKC7OhNK85uR7aJomDgXyBvRfwtI6DrdriapFU
         LfEZaAsjqPX3xv5kUpTV0uTnnjyrmZ5vUjX11znoHcR+j/+vlMUieFLZXlCUk5LnMEAB
         x9LqLdLbjbzgH4UIM9euCM8pc5+uXKMf2LAcaE7IS5aUO4mouj4B9H9S4wy03oyKQrEA
         Uyl43Lv+gYMoYczcaLN2V9VjcZhQgJTcheg1NSpvN5MF6jIpjNCqucKp5VxQ2uYXSLRE
         gFi5FdbKDLVD23vEZI3oYnC+TFdYdooRiyDZgqpZIXYDSP40rQ1ZLRw+Oo8K/czan+U8
         XldQ==
X-Gm-Message-State: AOAM532YuAZhRNm/OI97fzwT3iYTNTJ4uxBzrqVPWbZXnOKzsnHYuEdW
        mNt/GKMDo/nR9fie72lLMLJEzA==
X-Google-Smtp-Source: ABdhPJxVfKLXmUyo/IPHv7koQEdozO13+4TNRhiUA/dg0gFgaOU6YfZ1tCAUcYQF6ibP+ldh3zdyIQ==
X-Received: by 2002:a2e:a486:: with SMTP id h6mr12691552lji.321.1624884691482;
        Mon, 28 Jun 2021 05:51:31 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id c20sm977200lja.30.2021.06.28.05.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 05:51:30 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 134CC10280E; Mon, 28 Jun 2021 15:51:30 +0300 (+03)
Date:   Mon, 28 Jun 2021 15:51:30 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v12 33/33] mm: Add folio_mapped()
Message-ID: <20210628125130.l6refof72f2ami5m@box.shutemov.name>
References: <20210622114118.3388190-1-willy@infradead.org>
 <20210622114118.3388190-34-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622114118.3388190-34-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 22, 2021 at 12:41:18PM +0100, Matthew Wilcox (Oracle) wrote:
> This function is the equivalent of page_mapped().  It is slightly
> shorter as we do not need to handle the PageTail() case.  Reimplement
> page_mapped() as a wrapper around folio_mapped().  folio_mapped()
> is 13 bytes smaller than page_mapped(), but the page_mapped() wrapper
> is 30 bytes, for a net increase of 17 bytes of text.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: David Howells <dhowells@redhat.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
