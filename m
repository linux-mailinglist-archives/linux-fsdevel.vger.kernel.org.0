Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 995393530A2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Apr 2021 23:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235243AbhDBVQT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Apr 2021 17:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhDBVQT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Apr 2021 17:16:19 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8FCC0613E6
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Apr 2021 14:16:17 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id d12so6009205oiw.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Apr 2021 14:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=EuMNzSviNgVTCMigCRn9biGypSs6VLzXgTTmdNbGnM0=;
        b=X/QMAEI97fgJ80rjf5uFusAtG4H/6OuS9yml3Iu4aBdSHgjhorK2ZE4AgLosnrcs9R
         JPRqXF1gOO4T/2rvF9wjHpJyfEW9Idw5AVyrsqt0KIgzU4QrHwOxF3Mk7mXfA0c3266/
         B2Sr+4xkGTLkp919H+ZpuV6vjm/v5KZLF0Z5s//CKlQJ3z/TAzLBYO8CvEkxsifUM2ch
         4hxs8LqAlRV1ehfc/cx7r3/aK9HkSCvTaF8LaoXeNMAdESRI+2JD7AOkRCyHmWwzgH9L
         kt0JoL74GWXs0hgNp27lO0SZdIGzCsX4lG23THqAFFz07Wdli/Ze0jnhzV3P8D0SiFO2
         BW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=EuMNzSviNgVTCMigCRn9biGypSs6VLzXgTTmdNbGnM0=;
        b=DSrKnBLO6hKlH2BwgdS9UDTUabYd45mmnGr8/sahl11953V63cmtOHC2azHTMF8/el
         GkCtnjrEIqsOJASNCtkx04fmsxqnYowcyrt+fFX0xpOqqQMCV9+cJO8P0A4JiTg9LePP
         +z1dLzk1x1/gjRgv6iLh19YIg1J6hwvnH55A2g5clj5cS29k1k1KjyU8+J3p1vRUnaQl
         q4I4Yu7WhvEBUdCvf5vBxf1/I9E+6YTeYWYozjQ7Cstrv6loBZqllxtl6/lSHwyshuqa
         ypaxRKJrzuNeWdWlOI4Wt2sfxf3HmtcwfjALS2Dwx/iz7qmZsv+MTKZOJ5H4rw70amOC
         2RVw==
X-Gm-Message-State: AOAM533nllfLE6unyFt8oBoIEd34qMQnU/JMYyKW3y8B0B1P8ul3/4Ld
        U1UUzlBNlbrPgO8coHuUfnkoWA==
X-Google-Smtp-Source: ABdhPJxHoLg7Mj6MbBeuVeCELsvBwuzhCT4GwDHbTxgp/9Ssp/rTN2MV9BgkVyI0Rhfnb98rln/95w==
X-Received: by 2002:a05:6808:3d9:: with SMTP id o25mr11264930oie.4.1617398176714;
        Fri, 02 Apr 2021 14:16:16 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id e34sm2099720ote.70.2021.04.02.14.16.15
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 02 Apr 2021 14:16:16 -0700 (PDT)
Date:   Fri, 2 Apr 2021 14:16:04 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Matthew Wilcox <willy@infradead.org>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: BUG_ON(!mapping_empty(&inode->i_data))
In-Reply-To: <alpine.LSU.2.11.2104021239060.1092@eggly.anvils>
Message-ID: <alpine.LSU.2.11.2104021354150.1029@eggly.anvils>
References: <alpine.LSU.2.11.2103301654520.2648@eggly.anvils> <20210331024913.GS351017@casper.infradead.org> <alpine.LSU.2.11.2103311413560.1201@eggly.anvils> <20210401170615.GH351017@casper.infradead.org> <20210402031305.GK351017@casper.infradead.org>
 <20210402132708.GM351017@casper.infradead.org> <20210402170414.GQ351017@casper.infradead.org> <alpine.LSU.2.11.2104021239060.1092@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2 Apr 2021, Hugh Dickins wrote:
> 
> There is a "Put holes back where they were" xas_store(&xas, NULL) on
> the failure path, which I think we would expect to delete empty nodes.
> But it only goes as far as nr_none.  Is it ok to xas_store(&xas, NULL)
> where there was no non-NULL entry before?  I should try that, maybe
> adjusting the !nr_none break will give a very simple fix.

No, XArray did not like that:
xas_update() XA_NODE_BUG_ON(node, !list_empty(&node->private_list)).

But also it's the wrong thing for collapse_file() to do, from a file
integrity point of view. So far as there is a non-NULL page in the list,
or nr_none is non-zero, those subpages are frozen at the src end, and
THP head locked and not Uptodate at the dst end. But go beyond nr_none,
and a racing task could be adding new pages, which THP collapse failure
has no right to delete behind its back.

Not an issue for READ_ONLY_THP_FOR_FS, but important for shmem and future.

> 
> Or, if you remove the "static " from xas_trim(), maybe that provides
> the xas_prune_range() you proposed, or the cleanup pass I proposed.
> To be called on collapse_file() failure, or when eviction finds
> !mapping_empty().

Something like this I think.

Hugh
