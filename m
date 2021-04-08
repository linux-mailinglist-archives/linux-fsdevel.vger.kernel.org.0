Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F393357EA3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 11:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhDHJCP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 05:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbhDHJCN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 05:02:13 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1ED8C061761
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Apr 2021 02:02:00 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id u17so1762446ejk.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Apr 2021 02:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cXalpWPdovuqi5PtyyBVt6MR8In8wK+QHdjt9pvsaQ4=;
        b=hXItazSBCUJKTKFr8ty0kuL/11ikHtPiXUThWd8G8PO444TtM/DMLIuh6TLqS0P7W/
         KA40sKleR67T20vW1C6bSQ6K0Fr0NqoOgi+bGrS48c3RSh5lQG5JlxMiv5Myj/gbL2At
         t3VNG06cCMARp0qjsyVCb+Z/sBuJ0tEt98J2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cXalpWPdovuqi5PtyyBVt6MR8In8wK+QHdjt9pvsaQ4=;
        b=AvZQ4EXgO8g7fHYL7/MxBKKqRL/YZmTRbhcUYWv/9Y0FidkbGjZEC7sI9lZjOhWUO8
         KByGlGSFj3aJi1EowBN/ARYopvlKgWF/jz0JJR1OnoXgvkcol4Tj6dqiJImbq3EDwW3p
         ZBFQEKbvUmLRjE8kdTzZTUZA3kWs4MBBmAg70wNQtTMUN72y/fvH9RuizHDUrhS387AN
         RurhX0qiyMwR5lD5/o3LW6XtfmTPHtVN72GJrTQQBKeQOd28xs6Zp3ahXZDDdjuNqKUR
         tpWFtLn4TcpmfTRSSYGsL+tAHt8UAbpJKlSRbtdIoxcuIAyXn4hd3lITCgZpkVMqDDHF
         UlrQ==
X-Gm-Message-State: AOAM532WkCnfzT1ekcH95cngpP7wZrZmLCsggQ/x46UaE7Tzbbrd6a43
        tHJxZScbptH67AAryjGxBeMkuQ==
X-Google-Smtp-Source: ABdhPJzBa4HtKr4hNJ415kDMr8yGygx8z+sS2pW2rkqme7X4wimsY5DsOfWZUwuhrlrMqbDHdk49Vw==
X-Received: by 2002:a17:906:3713:: with SMTP id d19mr8909450ejc.513.1617872518956;
        Thu, 08 Apr 2021 02:01:58 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id s6sm10262058ejv.11.2021.04.08.02.01.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 02:01:58 -0700 (PDT)
Subject: Re: [PATCH v6 01/27] mm: Introduce struct folio
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org
References: <20210331184728.1188084-1-willy@infradead.org>
 <20210331184728.1188084-2-willy@infradead.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <f89f694f-d472-3287-51aa-86258e107361@rasmusvillemoes.dk>
Date:   Thu, 8 Apr 2021 11:01:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210331184728.1188084-2-willy@infradead.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 31/03/2021 20.47, Matthew Wilcox (Oracle) wrote:

> +static inline void folio_build_bug(void)
> +{
> +#define FOLIO_MATCH(pg, fl)						\
> +BUILD_BUG_ON(offsetof(struct page, pg) != offsetof(struct folio, fl));
> +
> +	FOLIO_MATCH(flags, flags);
> +	FOLIO_MATCH(lru, lru);
> +	FOLIO_MATCH(mapping, mapping);
> +	FOLIO_MATCH(index, index);
> +	FOLIO_MATCH(private, private);
> +	FOLIO_MATCH(_mapcount, _mapcount);
> +	FOLIO_MATCH(_refcount, _refcount);
> +#ifdef CONFIG_MEMCG
> +	FOLIO_MATCH(memcg_data, memcg_data);
> +#endif
> +#undef FOLIO_MATCH
> +	BUILD_BUG_ON(sizeof(struct page) != sizeof(struct folio));
> +}
> +

Perhaps do this next to the definition of struct folio instead of hiding
it in some arbitrary TU - hint, we have static_assert() that doesn't
need to be in function context. And consider amending FOLIO_MATCH by a
static_assert(__same_type(typeof_member(...), typeof_member(...))).

Rasmus
