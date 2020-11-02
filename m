Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8122A33C0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 20:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgKBTMs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 14:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgKBTMs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 14:12:48 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D14BC0617A6
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2020 11:12:48 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id r7so12523263qkf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2020 11:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VAQ2TnpJpSVGzs9QxUvU5ZK0uQebk2f7vZtBu6/vXNM=;
        b=C7RVtAPpyBQzNGUG4jZgFRVUqm/6zBJOG+5P1ElksKEHbVFoTPvq2bqlVA56N8Tl4s
         riJvl5ka/fXVWurSWnzGygvr+pAPdh01ADBBdUwcU5gw+e/Wc0jvo9muwBSIf42Ajkht
         GYINzk6IAuEwETE34w7/iJKUWVgzsdtWHDB3whcTZgu1ItEuihstyPwB1dLjmY41P7Tn
         AhWH0DYOASr8gq7Ne4lEryXfuIqCO55aysNJ+7fNYwTJw1whYADQ1UIByG96m3uy0VxV
         nymThXqWCRKPp93dYEGj6WF550dQ6z3xkWGBt866aY107P5GApkM+mjOii97ZOJ1w2ry
         7GpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VAQ2TnpJpSVGzs9QxUvU5ZK0uQebk2f7vZtBu6/vXNM=;
        b=tLo+II5bW8ZKsW/2iSdGbYp19JdCFZS7n2BkypdRnTANkxckq5yD9pLbujQBeXOcmY
         HDxaPJThMXSTz6Ud/4MjzLN/7QV6BSyZfIqCv6ekXmEBqTai8+r2I56v9q1ckrDABI1x
         jfjhS4fd3fidllv1zwJnpCK0p2ehAEkz68pPr+1VYwGUrbzofr0cIgHH8Jo6CCidpm/g
         ZADC/BQScQB4c320TO9oghi9GvqlqG38NdntVkKVRQmheBFxMnzxEACFqVFICfdS4lhZ
         h7dIjf/1BS2NJ/JsEA/2ZzRznkjpjrfdGo5rxkvPxytV2s38dkQYU8SqZQQOKnw9Zr92
         5Odg==
X-Gm-Message-State: AOAM532TLkkMKZxe3+bjx0C7K5Fu9avqYS0L5yug721JRT6wH8/BOPti
        6lP4rwnPGII+miKRcu/tTQ==
X-Google-Smtp-Source: ABdhPJz2PnUt91CU8Wz3Tgul0hHG7qTSVyvEDt74rVFK3OUq9oPNC48D5ZESNB3AAt4tVwKWvvfJXw==
X-Received: by 2002:a37:664a:: with SMTP id a71mr10555111qkc.370.1604344367822;
        Mon, 02 Nov 2020 11:12:47 -0800 (PST)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id a206sm5606583qkb.64.2020.11.02.11.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 11:12:47 -0800 (PST)
Date:   Mon, 2 Nov 2020 14:12:45 -0500
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de
Subject: Re: [PATCH 04/17] mm/filemap: Support readpage splitting a page
Message-ID: <20201102191245.GI2123636@moria.home.lan>
References: <20201102184312.25926-1-willy@infradead.org>
 <20201102184312.25926-5-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102184312.25926-5-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 02, 2020 at 06:42:59PM +0000, Matthew Wilcox (Oracle) wrote:
> For page splitting to succeed, the thread asking to split the
> page has to be the only one with a reference to the page.  Calling
> wait_on_page_locked() while holding a reference to the page will
> effectively prevent this from happening with sufficient threads waiting
> on the same page.  Use put_and_wait_on_page_locked() to sleep without
> holding a reference to the page, then retry the page lookup after the
> page is unlocked.
> 
> Since we now get the page lock a little earlier in filemap_update_page(),
> we can eliminate a number of duplicate checks.  The original intent
> (commit ebded02788b5 ("avoid unnecessary calls to lock_page when waiting
> for IO to complete during a read")) behind getting the page lock later
> was to avoid re-locking the page after it has been brought uptodate by
> another thread.  We still avoid that because we go through the normal
> lookup path again after the winning thread has brought the page uptodate.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>
