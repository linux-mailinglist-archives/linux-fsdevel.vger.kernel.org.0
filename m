Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6294B2A336A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 19:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgKBSzk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 13:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgKBSzk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 13:55:40 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BF7C0617A6
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2020 10:55:38 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id m14so9894726qtc.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2020 10:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0MuHHQkQxkCnA9K9EG6Ur3HVjOP4w19FlJqIl/E58a0=;
        b=gqaNDzneZ37a04uL8XxZys13yoEgLHzxGZy4lZyF74sarrLlIbe/vXmz92Miv2huog
         q4e00O+K9segwAZ/vLTw797VTQ6dOJaURh2BkZl9W2Rpus4d7sjBOWLbZAsFeDoecbe/
         YrIFIJ38HX/k4chY5mtjtM2xAc19TjWTzBKvPhmO/16/7tvAm9PH+EVVi1h33yDrJDb1
         KEqXNF1/3gKgMZHhEp/Y+rgEpluOTV2ic0h+L7phnupLDJffXCj3LJM6rg55oZO6zI2W
         WwdhmVYqOPgaIG6TStT4MX47WTX9+8qVOmNHF7CobhY5/w/wvqQAOv3fbEtqR0j2VKZD
         FAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0MuHHQkQxkCnA9K9EG6Ur3HVjOP4w19FlJqIl/E58a0=;
        b=FZH2CtQtVM4cHpJav+eJ8JZUdGBEnWgFSOQGnhPQxkv+KR4dT/wKHuq2C3vW4WoH20
         cj84qGmGELB5XcJyUHOd+NAN5e/Dek1KwKIhPNd1HO7EBNAnSF+2dUsEh/Yt69HbQjz5
         6VMVrQVX3xWpeEg2rtq9v8EpZahQqcCRevXLS2ydSIvrZQen2d2knwbiCVKsWtwu4hB/
         8G0fCyoeDMaU0CeVhncHoR91GStbGrr/HvY4Dput8UIaR8vCg74KvsOPGGozhHbtPrYj
         9LrXO8/XIE2ZikCfeX/bDuZ66PccIY2yVKoL9KfKy8Ps3d4tPbm1gXJ6mGFzt8/+A5nv
         yN2A==
X-Gm-Message-State: AOAM532bGKY9iiWNnBZK+VvFyJtQdYyiaNACJbbqFPmu8StyZtxGsKh2
        zEsouv723QZQzzvCPPNPV6+EFHgFEHWE
X-Google-Smtp-Source: ABdhPJwe030Nob+p/W+gDWzhYQBgR0OOs+0g1LPFeF5dbPYOqgqFuKe6pzckxlFhcqOOiVhZUiKUww==
X-Received: by 2002:ac8:7189:: with SMTP id w9mr2660598qto.288.1604343338117;
        Mon, 02 Nov 2020 10:55:38 -0800 (PST)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id r55sm4843892qte.8.2020.11.02.10.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 10:55:37 -0800 (PST)
Date:   Mon, 2 Nov 2020 13:55:35 -0500
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de
Subject: Re: [PATCH 02/17] mm/filemap: Use THPs in generic_file_buffered_read
Message-ID: <20201102185535.GE2123636@moria.home.lan>
References: <20201102184312.25926-1-willy@infradead.org>
 <20201102184312.25926-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102184312.25926-3-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 02, 2020 at 06:42:57PM +0000, Matthew Wilcox (Oracle) wrote:
> Add mapping_get_read_thps() which returns the THPs which represent a
> contiguous array of bytes in the file.  It also stops when encountering
> a page marked as Readahead or !Uptodate (but does return that page)
> so it can be handled appropriately by filemap_get_pages().  That lets us
> remove the loop in filemap_get_pages() and check only the last page.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>
