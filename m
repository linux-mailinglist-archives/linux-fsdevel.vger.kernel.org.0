Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82BDC2A3448
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 20:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgKBTip (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 14:38:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbgKBTip (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 14:38:45 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18833C0617A6
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2020 11:38:45 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id m65so9986366qte.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2020 11:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vrqSsdCV/rIQCp2IIgQgFHq93wNws+wEPI1TpeJQPKg=;
        b=Y1TlIFDueG6X0facR+kMZCi31dxb4Z6XChlS6AWH7InUjfzmET1zsR6JsE4WpmrSyY
         G7u5I1W4iVKbI4keNcIptTzj2DLE8SWIDf0cvj4iSA/dEHuziJRUtUuGi5iqnHO/vojS
         XRbhTnCXN3T7katAEvHn8T544zF4pi1o9pNXUn9kk0mc8ifjKkHTMPfBCwUBroU8YPGP
         CYrgJTxLdB+PrelmqGHhpoQlvHCIcN602vVghoHT3+C0LM7xySSb15b4PtCfu+igZbGF
         WlBX++ccZRWc01w80eK6fb/PulMtkUYQzuP30KfM3liRVdl3kvWhfro9vBIhHpVarsgS
         1YNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vrqSsdCV/rIQCp2IIgQgFHq93wNws+wEPI1TpeJQPKg=;
        b=cpSo282uHRMpAdop7BNbolIosUnDaOY2sZvZf246iKZEuFA94nrwn6ICWCHLZYhWrn
         e//wkvrLDFkH1NGTmGICPKF+Bkd8+OujjKC3POA4dc+KmC+2/x6HM8Jz4QFC+MCL3lp5
         yc1MqSJ0Ng/fgt8U1CXe3jrwamp3VAMqWc6/YFIhEroo6AIM0LJiXlExNv2G0mhMRgKx
         5pQJZ+QO1GqP8E1ho9e8M6tEXqdodCxqC4o5qwH7yNVkJfXUxrudNjd+18CWK67JGbjR
         lfvTtXdS5oFonzam+CPdWs4OhsDB1xNwfqrIVKbnef2XVFMI9W8Q1SuQ5XRISAz02a+R
         s37Q==
X-Gm-Message-State: AOAM532qmjPHOd546kXET/Tc3MWwFiDAuJRGeAwMzzOOUFJJIuRTDxx+
        CGnSJ+5iJQUsE7eNxfyuXXy+a8LGaHQH
X-Google-Smtp-Source: ABdhPJwlRsFUXcEZjGbvSlSN7PjHMfCsBrNeEtJLPDmlgvhyVloBnB4kpCVUciPgxJlwbe51kEzYfA==
X-Received: by 2002:a05:622a:2d4:: with SMTP id a20mr12263199qtx.349.1604345924396;
        Mon, 02 Nov 2020 11:38:44 -0800 (PST)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id 69sm8799281qko.48.2020.11.02.11.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 11:38:43 -0800 (PST)
Date:   Mon, 2 Nov 2020 14:38:42 -0500
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de
Subject: Re: [PATCH 08/17] mm/filemap: Change filemap_create_page arguments
Message-ID: <20201102193842.GL2123636@moria.home.lan>
References: <20201102184312.25926-1-willy@infradead.org>
 <20201102184312.25926-9-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102184312.25926-9-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 02, 2020 at 06:43:03PM +0000, Matthew Wilcox (Oracle) wrote:
> filemap_create_page() doesn't need the iocb or the iter.  It just needs
> the file and the index.  Move the iocb flag checks to the caller.  We can
> skip checking GFP_NOIO as that's checked a few lines earlier.  There's no
> need to fall through to filemap_update_page() -- if filemap_create_page
> couldn't update it, filemap_update_page will not be able to.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>
