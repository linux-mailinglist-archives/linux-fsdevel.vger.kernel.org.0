Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 685F5BF4D3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2019 16:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfIZON2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Sep 2019 10:13:28 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36410 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfIZON2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Sep 2019 10:13:28 -0400
Received: by mail-ed1-f68.google.com with SMTP id h2so2192667edn.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Sep 2019 07:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Vn4RSijfnGv66ggFJIHwXLRfY5IYfYHE5mOxifctFWA=;
        b=n+alj0kI2bszwuP5vu089IXNWt6SHf9p9y/PJMEnOWrhUKD8kNwTwBQKaK5fJrBgJ0
         DLsEATPCu1u9frWLnWJWIySO/950XmCObL/Gfy3oUgeip9+24O/Kevhp2faieQm133hZ
         YNw7dsu929RVaHOXq2074z0GHJoqrzEhOU8oVre8VqrLoYIcYnj3Kquy6QY0DEGvbJF9
         Cjk2YXPboM8tV/rsJgR9z+EOCVi7mr401yopZh6xAVGwMCEjPBtSxnVsvXTKt/kPHWgz
         TIAvcTtaVXlXpExw64irCGAccUumoMGTA2pPYZd3HRp5N5Um9cWtUtTivWxdg7tYW/ay
         Zt7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vn4RSijfnGv66ggFJIHwXLRfY5IYfYHE5mOxifctFWA=;
        b=Rai0sJzpuAJ5ir/lpv2hmpTrD4naut9ugpZBAI5f4m9MrCqTFrd7cr5yBXqKxCah61
         duccljqhkWO3e3hosyC4iIvjs/ZmqKBmtyR3wUdyTwTL3bTuGPMpfXe2zJG5mCNuQcg0
         Q2LOnp4mPcl4VVN+YV00XwasTG/0oLg/0Ivp7ZbxEOWekFAG+Xm4S4aO0zjNpKAWmS6R
         UKC1ZL5Fbft7whW9UYtpSR6n2KM/SaDt5DB+JCYTj8II3UEKGzYwE9uLufFL6nTw9aG9
         DnChBiDTb3GpSLYiXw5MgO5TuQDs2y8uFbdo6BGB59Pb0L04TxrVtjxE3QhpZZbQQ1Hb
         XJZw==
X-Gm-Message-State: APjAAAXRVLz1UYAyjOR7EGgZol/1jrKgeL+ymobyJYmt+lFPGKy+KV4f
        tvZNqaw/iCnNZgoiG18P1NrPDw==
X-Google-Smtp-Source: APXvYqzrQUqueSPMkuBVzXfwe7X+tnL71qVwO3XqRk0vg77XaF7BwKOfcf2zASWGr4wwQG+MuAQ8nA==
X-Received: by 2002:a17:906:1d03:: with SMTP id n3mr3296087ejh.287.1569507206884;
        Thu, 26 Sep 2019 07:13:26 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id bq13sm252145ejb.25.2019.09.26.07.13.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 07:13:26 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 4A304101CFB; Thu, 26 Sep 2019 17:13:29 +0300 (+03)
Date:   Thu, 26 Sep 2019 17:13:29 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/15] mm: Make prep_transhuge_page tail-callable
Message-ID: <20190926141329.zumbhytzrpx4ekmq@box>
References: <20190925005214.27240-1-willy@infradead.org>
 <20190925005214.27240-8-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925005214.27240-8-willy@infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 24, 2019 at 05:52:06PM -0700, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> By permitting NULL or order-0 pages as an argument, and returning the
> argument, callers can write:
> 
> 	return prep_transhuge_page(alloc_pages(...));
> 
> instead of assigning the result to a temporary variable and conditionally
> passing that to prep_transhuge_page().

Patch makes sense, "tail-callable" made me think you want it to be able
accept tail pages. Can we re-phrase this?
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
