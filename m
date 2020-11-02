Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 933682A336B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 19:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725809AbgKBS4Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 13:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgKBS4X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 13:56:23 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680BDC0617A6
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2020 10:56:23 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id g17so1449410qts.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2020 10:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ypf9libc2cK94R312mpXqv3zha60UndnxNEekECA5ic=;
        b=fZ4ijKUxDXUgvlTrWNWxgePIahF5Jj3TV0Yp8lN3OBFETZGs5itt5e+E8se3dadOTM
         WW1bLJ4HoFSoy1egsL7wmtx78yVMABlPnoR2XYc7pdBYYoxL5ynoe8kLN01gF3t5ClqN
         a+aNJvLOfKL9Ud5RhmY1jQmFWKT/oHgCxToQ17WRItk7EnJT0nWdBhKiH9mefGtVtUrF
         uBLRU5ZtEcuyMee1ni1XzMroj6TISZpzPcU4Pe0aYsS0y30uXdbORI1V9GCq6U4xvon5
         d/spSSEcmbozYSRh3nAVvFHHOEkXjzNTX4JBRJV1zP+bmNtROHiiCvhyCuzpcWcimTbN
         R9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ypf9libc2cK94R312mpXqv3zha60UndnxNEekECA5ic=;
        b=WritSnTT6+IPs2sdjDv2WPCz2YHapOg6fOveOZq/Nhum0bu+vb2brdOuU5XOeLQeKj
         dC5t6tQtZKgTQ7hZBouiw/96t2WR/m3+TuPoehzptpQrcI78o7a7zUeiDuQZ3ki5SeBK
         ztTy1Toed1YU19Dh9D9YZBY3O6EBxrgsyPjdsH/tCix+gbYRW9vXOoFEw66NvVIqXJJc
         KKwxvKCYnKbPnraNq8vIxJZM8j9ec+9HvK2uA3rTLWuyqYU5PjZBdG4Jn7uUD5pMyCpv
         qEEEh5GE16NBI07d1tVL+eFdtBVjaj7DryrI3ah5Few+4JisnrrL2/4CiJIYQv56yS4s
         cwTw==
X-Gm-Message-State: AOAM530N2v80UTUCoe5+K5pqgcIDvSxMQQEYvuyK6oInpPnlEMEaza2k
        v9tEOHe69JFayrBloJjvH9tD8BT/xm+h
X-Google-Smtp-Source: ABdhPJw2nhzU0Y/rDq9hu2VP47nkW/h6k22/ELskL7Z9yyTjvbbAuePDAb57kNWEA3KM4YD59E0n1w==
X-Received: by 2002:ac8:594f:: with SMTP id 15mr4231103qtz.347.1604343382744;
        Mon, 02 Nov 2020 10:56:22 -0800 (PST)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id e19sm8530259qkl.94.2020.11.02.10.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 10:56:22 -0800 (PST)
Date:   Mon, 2 Nov 2020 13:56:20 -0500
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de
Subject: Re: [PATCH 03/17] mm/filemap: Pass a sleep state to
 put_and_wait_on_page_locked
Message-ID: <20201102185620.GF2123636@moria.home.lan>
References: <20201102184312.25926-1-willy@infradead.org>
 <20201102184312.25926-4-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102184312.25926-4-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 02, 2020 at 06:42:58PM +0000, Matthew Wilcox (Oracle) wrote:
> This is prep work for the next patch, but I think at least one of the
> current callers would prefer a killable sleep to an uninterruptible one.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>
