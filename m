Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29DD52A349C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 20:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbgKBTw2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 14:52:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbgKBTwD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 14:52:03 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F9AC0617A6
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2020 11:52:02 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id s14so12572104qkg.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2020 11:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wB0BIwPgVyOH42LZYDNokxs7DTRROczINKmnzdae7SE=;
        b=SFIBn7SHylaSYFx/DeIRGWV5iBUjC70iHnVSHxf6PALPXybZEItNAZFT+lKvN1dtY+
         wQvIbN6glFShGgywf6LcsvLlJUp39h/CGXeYm/S+2HoiKER5Gn/L8RHoC2xM9qf1K3bq
         WjKFYLJij9vkg50V9MGSt07n19w+V6lQQNbRmYuZVcq6MPCA/PmRwZfY6QPUweporToM
         9ZuxJrm7QeLP3I/20B95URi7lKWMQqEKNUU9qkIoQFyqBe4jhcvd6pgEISroXrae2v8y
         /nH3Tz+/eYm4qGKYg0duNiXmwOvxnE33sD9fevDVJw7N6elKylbbpXANRD1TVnZZJPlC
         xYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wB0BIwPgVyOH42LZYDNokxs7DTRROczINKmnzdae7SE=;
        b=OGJQl2aCBuXK3/aBGumMCCJxJpLqUVdshrs6sUojiDsW5T6Wl0oOdf6e9uA62H9TvB
         X3cVlFUKcoteWv1QMt6VQLi1QXi7gUqMjPpmM3otoB0WXF0eFnRTwb4L0vhgkALTiPDW
         CDybm927euR++zv1ID2bS4xM/yt17S1Mfb4GhLKfYXOlljPWOV9krwCiw8BnPhKwKZTD
         RIvntByQBLL6Gi5U6zmMzYfuYzYboocsm2Xm9j+HlywVMclmjyykFO5oatmS9PLkBA9Y
         jeVPPAaa4ksFJKXejgai7SjE6b0Rfs8T6PLFRb1UFok8MsHrSm/VCyfOmaTwZup5mDws
         PoDA==
X-Gm-Message-State: AOAM530Q7AaMbMxe3UPV6lQfLIL+QGJPcLl5gfRdwEgrFzIA+ax3i82X
        X//7LWoJqpwKdclqDQ3CEA==
X-Google-Smtp-Source: ABdhPJxAdj4TSMqHIKkbyIs1DZsppB4jWLN94UyjAnqKoFNtVe5vltc1QDbXyg6qwh3pE5UVHovOAg==
X-Received: by 2002:a37:a8d1:: with SMTP id r200mr17146333qke.415.1604346722137;
        Mon, 02 Nov 2020 11:52:02 -0800 (PST)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id k64sm8777980qkc.97.2020.11.02.11.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 11:52:01 -0800 (PST)
Date:   Mon, 2 Nov 2020 14:52:00 -0500
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de
Subject: Re: [PATCH 12/17] mm/filemap: Split filemap_readahead out of
 filemap_get_pages
Message-ID: <20201102195200.GP2123636@moria.home.lan>
References: <20201102184312.25926-1-willy@infradead.org>
 <20201102184312.25926-13-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102184312.25926-13-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 02, 2020 at 06:43:07PM +0000, Matthew Wilcox (Oracle) wrote:
> This simplifies the error handling.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>
