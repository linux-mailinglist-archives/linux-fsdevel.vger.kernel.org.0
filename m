Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 037E718091B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Mar 2020 21:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbgCJU0O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Mar 2020 16:26:14 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36287 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgCJU0O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Mar 2020 16:26:14 -0400
Received: by mail-wm1-f68.google.com with SMTP id g62so2861614wme.1;
        Tue, 10 Mar 2020 13:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JqYk8R4UPwKS97k6zpIyj5riBjZ7GjDwEcUa5Ekupac=;
        b=tCkxaKUGWKNb+HTFdm5JbBkMM4KtNpMAde+z/oWZh3mOGSVZ2p5N/0MdlVGcB8K27b
         3ARO+n2hD1B00XYU/Y/P9RfKsDcCWTRsIkZYDjf1fWtRuvqJJUzrfduyJbeidLDwsxJi
         apRYCKwT1z4pdpgXFVifYp++iYW1EHHw4fdRZUAP5VdrWn4scSsSsvpA2uYe8u3nMsx6
         4gZyM6cLKDY8khJubIx5bQR1L+922dEpo4MAtMLgJQ5/GoxL814HlZTenVZeWdeTbyuE
         531KTbZpXTCmUlUfmx9MDq8sCPIlcKWJDuulZy+9563ns1wcWGpLzHpEW8qlzpfBeNSL
         7/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JqYk8R4UPwKS97k6zpIyj5riBjZ7GjDwEcUa5Ekupac=;
        b=V6wN2DPztC6sn5Or5tulihCVHS5QJYVs0I1ReTM+1D0OmVAldrKEO17JpfLcT6Yvx0
         dsY85I1fAAuitKMaJdaN5JtID6Gex7Da4J7pVobcPfplDkMscJ419/8g656Y0aCCgYlQ
         9Dz6BgA6Abf9nKTpcvv9tizSUdLB8LFBtRrtbQ8XjZE1Bg3BWgiy61dCWyA904sU9bYO
         i9W1eAGwNf/8fGoINsEN/LyhDRw64GuF1ZrM/XxD9o9ezryhWimHXMdKbZke+BcAHFaj
         J58rQssxwwcakkEAoUO8JPBsJBXp/zjGbHdPlfeDPD1Ei6/3KwWQAJwfJ/PmfHxyLOhL
         Kq8Q==
X-Gm-Message-State: ANhLgQ3FZCQz9o6JnVTf8est9Memn+lzlCKBydU0wljBgvROql6dTO7/
        Ht7ZVmFnAFC9eYQblqwsxL341P8=
X-Google-Smtp-Source: ADFU+vvQS3dt6GEtid3fA+7d9DuJE3zKvSKgS14keG2HQAca41GrUO3nrwsCDXKWZ+MwILBlwMptqw==
X-Received: by 2002:a1c:7e08:: with SMTP id z8mr3581832wmc.166.1583871972104;
        Tue, 10 Mar 2020 13:26:12 -0700 (PDT)
Received: from avx2 ([46.53.249.42])
        by smtp.gmail.com with ESMTPSA id c2sm5593845wma.39.2020.03.10.13.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 13:26:11 -0700 (PDT)
Date:   Tue, 10 Mar 2020 23:26:09 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 3/3] mm/vma: Introduce some more VMA flag wrappers
Message-ID: <20200310202609.GA6287@avx2>
References: <1583131666-15531-1-git-send-email-anshuman.khandual@arm.com>
 <1583131666-15531-4-git-send-email-anshuman.khandual@arm.com>
 <alpine.LSU.2.11.2003022212090.1344@eggly.anvils>
 <ce7dd2ac-26e8-d83c-46d0-0c61609be417@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ce7dd2ac-26e8-d83c-46d0-0c61609be417@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 03, 2020 at 02:43:21PM +0530, Anshuman Khandual wrote:
> On 03/03/2020 12:04 PM, Hugh Dickins wrote:
> > On Mon, 2 Mar 2020, Anshuman Khandual wrote:

> >> vma_is_dontdump()
> >> vma_is_noreserve()
> >> vma_is_special()
> >> vma_is_locked()
> >> vma_is_mergeable()
> >> vma_is_softdirty()
> >> vma_is_thp()
> >> vma_is_nothp()

> > Improved readability? Not to my eyes.
> 
> As mentioned before, I dont feel strongly about patch 3/3 and will drop.

Should be "const struct vm_area_struct *" anyway.
