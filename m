Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8122223E456
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Aug 2020 01:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgHFXYH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Aug 2020 19:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgHFXYG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Aug 2020 19:24:06 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8872AC061574
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Aug 2020 16:24:05 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id t6so175104ljk.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Aug 2020 16:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VgoGp2DsY5zPhxqgq4Oy4vGUjLnQwWQ4gdyr/irKbY4=;
        b=KKjv6IjJr551lE/pPran8bv8Ogy5tkDSNLx76eFZojKkUnVAn2sW5C+XQ3q8V2XFLA
         V7+Wn1pUyanc8nJFL9bTVroQYKH3the5ZGn3R83H4HGh9TIOvNCDCdkPUFk9G7PJ8trd
         jinz+MsfUDev7qSSJMzyxMJeIgW672xXAPhb1ZsqAhs0x+WalXFxXX1BBlL7yuzxyfft
         282qE4rzfyui+Gpk/nneyyJGnOKcnJorIshj0AKBI9lfPlGQfORQ/FpXU8HFt6ymBdYG
         65XEiehWmKpvlMEBxKO6PUpzrSFuXtbh07scxPiU/bbYUUq7xzkGS894iUxwKD8+PzyN
         h2jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VgoGp2DsY5zPhxqgq4Oy4vGUjLnQwWQ4gdyr/irKbY4=;
        b=mxTv/Kwlv0FOm35PTqfpaGSLhliFcf26j4axE1OQo6/gej2mn+/Bw5Orl2fFmpUtyv
         jx0kvZb9S+iEQFaAGZRGooslJiRHU9psuX3cZHEw3Smkla28XodarTtZ4sYXtSn9r+aV
         Up0T/Q8DIAmvsBrHY+A1DJd+M/kzXlo8YwBL103T67XIdF2bkktd4GkFxYXzG8hp8LZ0
         Dhxj4w/+38TpNjr80/yuJ6z+cauei+qL9Ud0MvFHYsNrk86Jfp9XxsU9OB3RYTh2yJ0B
         +XYmsN7ykjDV6+dh2oJavE3L5pyFjRLwW4N9Iutgk3lkQ2VmUsUC68TmB2d0N7YA7uCW
         nCEg==
X-Gm-Message-State: AOAM5301+p6GTdA1aBT5SQshyHJfl2AW4tL4Q19nN5WTPGHCb+DggP0w
        Ds+7S7zUI9NF5giGC8KsU7q08i7bDEI=
X-Google-Smtp-Source: ABdhPJyBZ5SbubFpFJf+5IGHmjYhSBID5NxEHXK4QhhnQaAU6p2DsBsTuKPl3r88jI+j0IrrKSEqnw==
X-Received: by 2002:a2e:91d4:: with SMTP id u20mr4619135ljg.87.1596756242133;
        Thu, 06 Aug 2020 16:24:02 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id g24sm3063504ljl.139.2020.08.06.16.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 16:24:01 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id D228C102F9C; Fri,  7 Aug 2020 02:24:00 +0300 (+03)
Date:   Fri, 7 Aug 2020 02:24:00 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Subject: Re: [PATCH 1/4] mm: Introduce and use page_cache_empty
Message-ID: <20200806232400.s7nhmnoi3tkk7p2r@box>
References: <20200804161755.10100-1-willy@infradead.org>
 <20200804161755.10100-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804161755.10100-2-willy@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 04, 2020 at 05:17:52PM +0100, Matthew Wilcox (Oracle) wrote:
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 484a36185bb5..a474a92a2a72 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -18,6 +18,11 @@
>  
>  struct pagevec;
>  
> +static inline bool page_cache_empty(struct address_space *mapping)
> +{
> +	return xa_empty(&mapping->i_pages);

What about something like

	bool empty = xa_empty(&mapping->i_pages);
	VM_BUG_ON(empty && mapping->nrpages);
	return empty;

?

> +}
> +
>  /*
>   * Bits in mapping->flags.
>   */

-- 
 Kirill A. Shutemov
