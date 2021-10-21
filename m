Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28865436861
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 18:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhJUQzP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 12:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbhJUQzP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 12:55:15 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADB5C061764
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Oct 2021 09:52:58 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id 187so1153439pfc.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Oct 2021 09:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=IcgK3jqVdAfaeLFQJYqlQnHUd7xPkY+EUw9K+n+kqs8=;
        b=NxX5zcQUO+fne7dKWR46fV4PfZld2HLI49rRywG0foVkSd+cBb+s1hZ40e+nH5onfn
         kBsEQ3w9oie1KHcQr7FmveD1vCIgEOMIhNzr4IPD+8IFTd7FvWajZC3kIb+OG6OZl7FM
         V9i2a0bXHzZCPJnk5cFtALFaewEnD0eEm7l3E3fjrX4rZD8Azo7znuj6s+XI6TRo0LEq
         JhI7rhLSJqOcHFz+QoCPrIW8GTUypGTBPb7DV/uIsFP2z41xHu5DDxIKY1e2FOCWB6Jn
         9T+VkHm+RKcUZ9P/bDxXDqUgIrGyUCR8dCoWxYYhywAbHUkEBDurwoUVbXsSOf4hPbBs
         x8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=IcgK3jqVdAfaeLFQJYqlQnHUd7xPkY+EUw9K+n+kqs8=;
        b=fAPn9Z/v0b6t4+KxqmZbPmzwz3Z9cH9Me8Sjpg63MKZL2xPn8hNxyXFz9McmKZoVqT
         8F+1K0u5zeDxg1q6vcwFUXQ8I1M5aHvmYHF/XhYwB+J0ddmnZVhJ/dUoP/uYpEXeFQYu
         Cwt34DkJq0SUrFkD+z2n7XPpUEpcvHG4RW9elddIAzeu4AZxhY5LMGFMlscu5p2fEvoM
         +UA1CHI+jBAmgbY0hVh+J+AjpbzjziV9ebo0XlfwF8L27QNm3dcaI1autXdZCLSpyTJ0
         HiVHhVZK4HHEIxPTIvrzAYhicfdCJEp+CLPdX+/+93pGX8bExB18sk6XakbcYM32UpG1
         4gdw==
X-Gm-Message-State: AOAM530KD53yO0EBpd0xEkfqsG2ImiknyIjUilbgThxw3tSfOIezJFY1
        VwX+FW6hKWi1tGoz/ty74TPjlw==
X-Google-Smtp-Source: ABdhPJwnRX/13QCgPfeN04lkAFNZK/zCphybLsqgGISYluyjPOdd7zMQGUBgzQJecMMoMzKX5MKdkg==
X-Received: by 2002:a63:b203:: with SMTP id x3mr5321714pge.239.1634835178331;
        Thu, 21 Oct 2021 09:52:58 -0700 (PDT)
Received: from relinquished.localdomain ([2601:602:8b80:8e0::381])
        by smtp.gmail.com with ESMTPSA id rm6sm6602236pjb.18.2021.10.21.09.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 09:52:57 -0700 (PDT)
Date:   Thu, 21 Oct 2021 09:52:56 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v11 05/10] btrfs-progs: receive: process encoded_write
 commands
Message-ID: <YXGa6LWMwRVCnIz8@relinquished.localdomain>
References: <cover.1630514529.git.osandov@fb.com>
 <a06e83a401e0f66725975016bf6e6a23d5c8ea3d.1630515568.git.osandov@fb.com>
 <dff53e1a-9717-4b92-09c3-36127ed966d9@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dff53e1a-9717-4b92-09c3-36127ed966d9@suse.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 21, 2021 at 04:33:00PM +0300, Nikolay Borisov wrote:
> 
> 
> On 1.09.21 г. 20:01, Omar Sandoval wrote:
> > From: Boris Burkov <borisb@fb.com>
> > 
> <snip>
> 
> > +/* Data is not compressed. */
> > +#define BTRFS_ENCODED_IO_COMPRESSION_NONE 0
> > +/* Data is compressed as a single zlib stream. */
> > +#define BTRFS_ENCODED_IO_COMPRESSION_ZLIB 1
> > +/*
> > + * Data is compressed as a single zstd frame with the windowLog compression
> > + * parameter set to no more than 17.
> > + */
> > +#define BTRFS_ENCODED_IO_COMPRESSION_ZSTD 2
> > +/*
> > + * Data is compressed page by page (using the page size indicated by the name of
> > + * the constant) with LZO1X and wrapped in the format documented in
> > + * fs/btrfs/lzo.c. For writes, the compression page size must match the
> > + * filesystem page size.
> > + */
> > +#define BTRFS_ENCODED_IO_COMPRESSION_LZO_4K 3
> > +#define BTRFS_ENCODED_IO_COMPRESSION_LZO_8K 4
> > +#define BTRFS_ENCODED_IO_COMPRESSION_LZO_16K 5
> > +#define BTRFS_ENCODED_IO_COMPRESSION_LZO_32K 6
> > +#define BTRFS_ENCODED_IO_COMPRESSION_LZO_64K 7
> > +#define BTRFS_ENCODED_IO_COMPRESSION_TYPES 8
> 
> nit: Make those an enum ? Same applies for the kernel counterpart patch.

I responded to this before:
https://lore.kernel.org/linux-btrfs/YR%2Fq69Tiz6PFqFJN@relinquished.localdomain/
