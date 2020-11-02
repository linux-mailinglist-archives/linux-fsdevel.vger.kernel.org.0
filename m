Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA5AB2A34E5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 21:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgKBUI2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 15:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgKBUHJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 15:07:09 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68770C0617A6
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2020 12:07:09 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id a64so9279659qkc.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2020 12:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WDVlqMiU8YOhIVKvJhh9GoXydLuGHoEWT5TLUaJudgM=;
        b=eSPa7GFso1D/Cp0X86OAklw4mhgBUKA9GElI+J4rfekhyAVs+eLflOc4RBOn6DZRH8
         ueqqEde0aKuSBnJxLGcTUQHnBfRbsK1SPfrPmFtKRZCXVTmux9pN6TO3eng2e3j5LU/G
         4qrnI3CFoXN3GfAL3SWzOsZcX70sdrBHKdQcuiXudx0ZjKdf4do/UOBvLlzRTVe21Kzp
         KTHAqDUhI3EN5jlOIzhv0q49wDxBlFpRFr8rMe/j1WdH3KifqdHrl/XxvC8vZwtBvBHR
         1ieqa7dnTALs+4BizaA/6iJHZkC3wwPPom5yn8NnPR2YDai/wc2d7+ejEjI1F+vYzXMl
         fcig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WDVlqMiU8YOhIVKvJhh9GoXydLuGHoEWT5TLUaJudgM=;
        b=ZLTlJj5utH/ZyxuPbkZ3ABM3q8qZkcYuulwKpavwll/jN26DnnmaLZFLvOUAz6Y8lv
         gcGrb5AzTHaIhXuMDPnDWlO3iJ0Xy0ThP2G92zfxLPOkUg7hHpga2FN47WKWDVoqGG36
         rP4W3SULYzK9uMy3JFO6X1phZ2R9mTw2L89KZVD80FORrUmpwTTAADKOXqwdOMJ7dhro
         hjWaCN4g8WBTSHI3GmvzQiJinE0Nt1xXwrE1FtL5nZOxXa7cSIiZ2yq4IsGY+ER0iAie
         O0TKvGQHdAwqz6RmUsS4NoiEqno7HWuD4yxzZaP9T4gncumL5vJDRB8N/LHhFIzXbt8e
         7PTg==
X-Gm-Message-State: AOAM532qk6o9PnCH9qu9tlJMhfLWtR8y4K2wOpYNMs9wL0YdkbpsgL90
        yi9Abxug5EZ00qL216tfwQ==
X-Google-Smtp-Source: ABdhPJx43YobDpT7KefvVcY6l3twmWICqv9QAOghJQFotDcLjD9NdDbfJ3llilqYK26909dia55bNg==
X-Received: by 2002:a37:9c06:: with SMTP id f6mr16402291qke.197.1604347628765;
        Mon, 02 Nov 2020 12:07:08 -0800 (PST)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id q20sm8838189qtl.69.2020.11.02.12.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 12:07:08 -0800 (PST)
Date:   Mon, 2 Nov 2020 15:07:06 -0500
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 17/17] mm: simplify generic_file_read_iter
Message-ID: <20201102200706.GU2123636@moria.home.lan>
References: <20201102184312.25926-1-willy@infradead.org>
 <20201102184312.25926-18-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102184312.25926-18-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 02, 2020 at 06:43:12PM +0000, Matthew Wilcox (Oracle) wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> Avoid the pointless goto out just for returning retval.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>
