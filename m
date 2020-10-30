Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66DD329F993
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 01:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbgJ3ATM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 20:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgJ3ATM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 20:19:12 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE92BC0613CF
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2020 17:19:11 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id a20so4947625ilk.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2020 17:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hbsH7zepBu84v24A4Cjn3HzupBJL/zDgRWeJ1T6CeAQ=;
        b=atJ2k5VGx1QuuXvSZAn5gHyA0XD0tRSCYv+qurKT98JH01NI20QBggQorhLIsyIOKz
         uu2IeNZvN0NXh40l4jcrzC1dKNhVxSYcB0ACJVI5PzYEtRMJ2DmYuC0ta8nxRhyTbhmy
         XvpFgPYTRaef6XtRR8JJSfqgZlSQOAeIU/tMRCHJq8ivGIFPjG3uLvRFo8ey49BlAEgc
         0Ef47Fa1BOlie/LydvgWBkDxJ7MkZrqsKlrc5wd5ZiK3e4qgPE5D3jQnTNnQhVSJdSM3
         O/t84TsH4G37QdCQ+5bnYDxyW+rlnhcA6yyz5tvExCpkkj1adDZ4UsLC1PQS+MxJvLDi
         bIfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hbsH7zepBu84v24A4Cjn3HzupBJL/zDgRWeJ1T6CeAQ=;
        b=YY+HDg5WaK3Y8Mo9jhTcDmNjVqNheWPG4bH+W5VLjrwUxf4Eaj8ozqHXy2gD0ixrRh
         zUXBQNJ8rFIGc5C1yixTjfhTph3tYHWqEs7gQ9FnlsJCJgBBKoa3DGYSQdhf7DrQTgBv
         mEM3iqX/sEZPLHAB36YejogWm58+Z/cG6m11a/9ePJxAjkt5zcWR16UpFZQbAI3SioeV
         USO2PSmL4Gq+KzRE+rzudsAAid1Q7e7sCknq+15kkwzUVk+Ud1N1gBEEezPYceNaRHoj
         v5yCc+40C/9ILD3xQMpVeGmlp9NVCGOaWFaIIVTWG9f+3KTznWJ5ZoFP7SJMMYzQww9w
         Dhnw==
X-Gm-Message-State: AOAM533PDLg+yMkhfdqFEmDE+ZrCfFV7yicXypAzgaPXUk3+M5s0GMWk
        CmRxcfenKOPBCgwRiB+wbg==
X-Google-Smtp-Source: ABdhPJykWguXOLwgza4IKeW34eeZJ1BHEjlKdTLCjnE2wzLEFtL0Srr1sKRejtCbJ0zMisPyxKWCfA==
X-Received: by 2002:a92:d302:: with SMTP id x2mr15169ila.66.1604017151365;
        Thu, 29 Oct 2020 17:19:11 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id v26sm3301560iot.35.2020.10.29.17.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 17:19:10 -0700 (PDT)
Date:   Thu, 29 Oct 2020 20:19:09 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 07/19] mm/filemap: Use head pages in
 generic_file_buffered_read
Message-ID: <20201030001909.GC2123636@moria.home.lan>
References: <20201029193405.29125-1-willy@infradead.org>
 <20201029193405.29125-8-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029193405.29125-8-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 29, 2020 at 07:33:53PM +0000, Matthew Wilcox (Oracle) wrote:
> Add mapping_get_read_heads() which returns the head pages which
> represent a contiguous array of bytes in the file.  It also stops
> when encountering a page marked as Readahead or !Uptodate (but
> does return that page) so it can be handled appropriately by
> gfbr_get_pages().

I don't like the _heads naming - this is like find_get_pages_contig() except it
returns compound pages instead of single pages, and the naming should reflect
that. And, working with compound pages should be the default in the future -
code working with individual pages should be considered a code smell in the
future, i.e. find_get_pages() et. all. should be considered deprecated.

We have the same issue in the block layer with multi page bvecs where the naming
really should be better; the more complicated name should be for the unusual
case, which is not what we have now.

Also - you're implementing new core functionality with a pecularity of the read
path, the two probably be split out. Perhaps find_get_cpages (compound_pages)
that can also be passed a stop condition.

Not all of this is necessarily for this patch, but perhaps a comment indicating
where we want to go in the future would be helpful.

> -			if (writably_mapped)
> -				flush_dcache_page(pages[i]);
> +			if (writably_mapped) {
> +				int j;
> +
> +				for (j = 0; j < thp_nr_pages(page); j++)
> +					flush_dcache_page(page + j);
> +			}

this should be a new helper
