Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B15CD42C567
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Oct 2021 17:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234368AbhJMQAM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Oct 2021 12:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234266AbhJMQAL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Oct 2021 12:00:11 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEC2C061570;
        Wed, 13 Oct 2021 08:58:08 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id c20so2990268qtb.2;
        Wed, 13 Oct 2021 08:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QRCQWTldVH+OZHyOa69RDIQGz1tL+bbpmwzuPKAYPxw=;
        b=LCbFYikTD5PzbFfZnNoaU71X9aBqMyv+Oj6vxAprqwI64fSHD/tLdFOzvSMjTp8OuN
         mXi9nVR+rBk0Feyf+o/G4ubwH/l+7VV0dvuMAFPsp+pNBszRWtKFt+GfQyOQiO6XjBxG
         LxVDFEDdWu3SdyY9WJ3ulnfqbrKIu2YlLwcVPeEXOlByV67hWwjMUOaiwferSKqP3WAF
         8KRO8y813uJKVOSsojpa3qOIoXRSxzdGMFj5Dwvt1BCsoKh6zW9T5b4SjMxmb9j6ZszQ
         nHlZ3tsfw2pbtAiOTAqlV/AbKrmFO7X1h7lPHhAZkfZDocWqptFMeNXaSYKph8g50njI
         +rGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QRCQWTldVH+OZHyOa69RDIQGz1tL+bbpmwzuPKAYPxw=;
        b=5JoR/mw8Um8ZF/Lhpw5myg0veHTbjSP17nZgj3qHjADrGUF52EJsv9Yp1igil26t+W
         U97sUIZXHSVMvGqBISDeUCYzeaEjhrooPvXUi0aM8xB9GrYoqxfUIqJYSa9PRMubEpyr
         C5944HSV589WM+1kKwriUdYVd/towXFHbffDrJ69k/aItuMvgs4JA43cD2VE3HePCY12
         C7gPTN0z8LoQmy7nKjqVXCaU8vXI5CZm12Xcn5PJxG3wsouub7+rjCh8xUeUmSm3sLP9
         ehcEs67j8JNRfXVvhEo7/g8uGOb2+wcGaiA4ajwUKD3IVagJToR7IlGZaoZ+q8MwEaZs
         Ldpg==
X-Gm-Message-State: AOAM533AM+qBxGQNehQoI+Gf1PnjphalH9I/HEMjBUkLBticGeLU+DoC
        448+N55SaCeJKXWzJ6YyDw==
X-Google-Smtp-Source: ABdhPJzm3GPLkpM6fcr61oXHPUjNPaXCfY36KcT8EufJCKoDx1csvg98Vq2gSuHVE0/ONPg6MlP1QA==
X-Received: by 2002:ac8:5705:: with SMTP id 5mr111650qtw.184.1634140687458;
        Wed, 13 Oct 2021 08:58:07 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id m6sm4908913qkh.69.2021.10.13.08.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 08:58:06 -0700 (PDT)
Date:   Wed, 13 Oct 2021 11:58:04 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     David Howells <dhowells@redhat.com>
Cc:     willy@infradead.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: Stop filemap_read() from grabbing a superfluous
 page
Message-ID: <YWcCDE6rz1xgh9vD@moria.home.lan>
References: <163360810881.1636291.17477809397516812670.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163360810881.1636291.17477809397516812670.stgit@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 07, 2021 at 01:01:48PM +0100, David Howells wrote:
> Under some circumstances, filemap_read() will allocate sufficient pages to
> read to the end of the file, call readahead/readpages on them and copy the
> data over - and then it will allocate another page at the EOF and call
> readpage on that and then ignore it.  This is unnecessary and a waste of
> time and resources.
> 
> filemap_read() *does* check for this, but only after it has already done
> the allocation and I/O.  Fix this by checking before calling
> filemap_get_pages() also.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Kent Overstreet <kent.overstreet@gmail.com>
> cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> cc: linux-mm@kvack.org
> cc: linux-fsdevel@vger.kernel.org
> Link: https://lore.kernel.org/r/160588481358.3465195.16552616179674485179.stgit@warthog.procyon.org.uk/

Acked-by: Kent Overstreet <kent.overstreet@gmail.com>
