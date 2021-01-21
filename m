Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0982FF62D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 21:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbhAUUnm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 15:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727550AbhAUUnP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 15:43:15 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD50AC06174A
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Jan 2021 12:42:34 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id d14so3039607qkc.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Jan 2021 12:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/cN+TIyFlXTYzj8exXBqwp7S9shR8K+JZFzTefh5owU=;
        b=tCnozVcakStoR6Ant0DnFGkC2zcvbtAQ+2Wx5n2GAa4iQsm/U/7xWnm/XNw80wd0oV
         m3BHXk/kskullDm/TF1t9Km9gNBOyz4pWGkiIwNPSzh2VpWKJBeDzuGTvbBM5kU7bf4d
         SzZukFdyF5QQim7GxlqmNWl4o4DIwD2fJ4d+4PL7M9C6Qqcqt7NVAZXwyx6yDUMWfJFw
         M1kWz250Rxt9/5/u0KnJlB6FWCSxvgZz3fLnm9oJElp6C9xu/77/a88LO2JJbX7r8dvd
         Gw0eIfKRp9to3eg1VWdHdPYUIQxaG9oq5EsGqNADGB4iKZmpE/UC9mQUCAQD+SRxcOOp
         L+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/cN+TIyFlXTYzj8exXBqwp7S9shR8K+JZFzTefh5owU=;
        b=EUHa41qh8qKkL+cPA08yWSO42iWMyhW4FPkIHsYUBpyN4fceXzaAJQhLAnisQNM/O3
         JxGWgTQm8rOlmFzIzj4WKs4SJ05UjLA2S3uVQmDz16i+/ZLweCLwQthz9iJY8LJg+qRR
         hq7lE0dzYNu+hC3rf9/il8kfpJS0v3xBzzptEotk1WLojpvmGzG1G57gaQjAasjb1Hnd
         bVEwVNH7fVlQ9AwomWZlCgZL9PKbB1tIuPFoZ1tvGTq3gKwCR6mRRD04eJSrkMHMpfH1
         Cq8szkZr3a9MjDJMSZyS2Ju8J9KXJ5LKWRvXbxdzEFcakVh/1xeJTWE22oGtA8FQnUav
         Q7fg==
X-Gm-Message-State: AOAM532PP/KM7xBIcZ6hXyWlsaOy93cfDnvrPAs8uBW8Bm35NEsY7YQE
        5SNqrB08Y5tA8NEHT85/JLtcDQ==
X-Google-Smtp-Source: ABdhPJyPI7EORYAgVycLlQegnFv2rd20pMb2lVvSFF30VqlvxDOeWo1+I8FlJvkL88KcDDYEjDVixw==
X-Received: by 2002:a37:7a46:: with SMTP id v67mr1709338qkc.16.1611261754179;
        Thu, 21 Jan 2021 12:42:34 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:b808])
        by smtp.gmail.com with ESMTPSA id c62sm4392313qkf.34.2021.01.21.12.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 12:42:33 -0800 (PST)
Date:   Thu, 21 Jan 2021 15:42:31 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-nvdimm@lists.01.org, Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH v2 1/4] mm: Introduce and use mapping_empty
Message-ID: <YAnnN1pnZAPse5X+@cmpxchg.org>
References: <20201026151849.24232-1-willy@infradead.org>
 <20201026151849.24232-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026151849.24232-2-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 26, 2020 at 03:18:46PM +0000, Matthew Wilcox (Oracle) wrote:
> Instead of checking the two counters (nrpages and nrexceptional), we
> can just check whether i_pages is empty.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Tested-by: Vishal Verma <vishal.l.verma@intel.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Heh, I was looking for the fs/inode.c hunk here, because I remember
those BUG_ONs in the inode free path. Found it in the last patch - I
guess they escaped grep but the compiler let you know? :-)
