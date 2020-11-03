Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02D8B2A4730
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 15:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbgKCOEu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 09:04:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729359AbgKCOEZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 09:04:25 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42496C0613D1
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2020 06:04:23 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id k14so7143295lfg.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2020 06:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tQEztWlaS7JtdJFovU8fWLlzfDszLf3xC5WKPOKeT3k=;
        b=XqSacWEoT3DZ+pElqGH+IfCgBpUmp16LYy0oi58xIsrVz8X5yLjsrWf93RFDCViHh0
         /OcWEvxKWsxPpE+X1qfqfnNXVyGY2vWzY4ZtCc+a5lF3x4zYvGLWCRzQKktDlQML/7rD
         jJFpci52KD7XNGrcXRVtI1RnWSEW4UMBtG94n9k8p27l1D8kXtA68XBuWbICzST1BcEP
         0U09KO3cHJt/1EwA+kFdvnWF4tSj0uNI6nMgQGr3RL9Ylt/EJDgfLCqfAlAbfQeIPprr
         XINf3C8FReE93sj+1oF3sdwAlTkxlLhYv9dDPxux7qN7kpWDfITIQSnwmcoSXewXEXmY
         +WFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tQEztWlaS7JtdJFovU8fWLlzfDszLf3xC5WKPOKeT3k=;
        b=iYXDkrhuphluzTJSKrWC5aIOcgCV6/VapSllVXHdD2os3AdT/m8xaymfgxb8RrPwnz
         r48TBPJCX1ch71Gl0jaN209b30oKGbUU9dklgoY3KvjC1eNHL5NOhJhtuJG5fVSX3UXS
         uKKf5Fq6gfdj4Rgic+mrea6Vy4KbPrSJfpEuVZln1idL+4Dww8pv8oSOZtY2t4o9lKda
         ykRjkePXubJX93sKgobWNK+pg0evKZSoeRJ+6FIUj46h2JSuZ2EOwwVoY30B0b8XONZq
         hG0i+ISXwRQ2b6zD3ZMmll3jHlLgI5NVLaZ6A/WDLSVeWQdLWMNg8IH2Ms22joKpcbxN
         sp3Q==
X-Gm-Message-State: AOAM5339Bt+jhrMZRgHwmdup7KdYM0p9zUHgHLZxQMVzTTDCsGQWn+Ii
        HukxwrWDnStCOrfvCfbuK/ZXaxYpo1ZLLA==
X-Google-Smtp-Source: ABdhPJyrKNM92hUpbMTkmnXF4TxO8r+uUZXkrMuPwPFl4EHA4JL9REWJV3KSvzVks6bQGIMJCgNqPQ==
X-Received: by 2002:ac2:5970:: with SMTP id h16mr2259851lfp.583.1604412260694;
        Tue, 03 Nov 2020 06:04:20 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id l3sm3860608lfp.219.2020.11.03.06.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 06:04:20 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 1BCB110231C; Tue,  3 Nov 2020 17:04:21 +0300 (+03)
Date:   Tue, 3 Nov 2020 17:04:21 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/19] mm: Use multi-index entries in the page cache
Message-ID: <20201103140421.alhfhxwlye5ygwkn@box>
References: <20201029193405.29125-1-willy@infradead.org>
 <20201029193405.29125-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029193405.29125-3-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 29, 2020 at 07:33:48PM +0000, Matthew Wilcox (Oracle) wrote:
> +static inline bool thp_last_tail(struct page *head, pgoff_t index)
> +{
> +	if (!PageTransCompound(head) || PageHuge(head))
> +		return true;

Do we need the branch? It's going to be reduced to index == head->index
for non-THP anyway. It should be fine, right?

> +	return index == head->index + thp_nr_pages(head) - 1;
> +}
> +

It's true for non-THP, so name is somewhat misleading.

Maybe is_last_subpage() or something?


-- 
 Kirill A. Shutemov
