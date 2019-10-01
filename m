Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34C37C3280
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2019 13:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfJALcS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Oct 2019 07:32:18 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34333 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbfJALcS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:32:18 -0400
Received: by mail-ed1-f66.google.com with SMTP id p10so11588495edq.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Oct 2019 04:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lCGrxhcB/+iEshHFfidiQ7x9s/rMo7Q8hflUr8m+6po=;
        b=QfS4Zl1/GsIweSpHy1jVGdzJo/9HTx+ebgDpkvOyF+x3JNID3/YW722nrsLK0GRPMM
         bgyuVyo3Y5oKUWYcRCSFnlfRSo/RNjrlHNmYJalwEyVUd5xC73XZHT8C/6/KaXOZ5QIE
         ELEhYTJvYWi8+QZiRVTTXnOZFDC/kepWgWk1dqRYj48F2zmTPgmoD7Ee7oKQJSLcwaCQ
         0QqXuA9kJecUYaqKwt/zoXCbDpPT647LyZ4cGMDZcRx7CfFMZIxrabbTJXm7L7ZUZzay
         LmCdcUOt1LdqUIYN4nRDwQccsSbw5bEXPo4YaIJhHHhWNdifcuXEtE2esqFaBMyxtI3D
         aKVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lCGrxhcB/+iEshHFfidiQ7x9s/rMo7Q8hflUr8m+6po=;
        b=iJhhuI2NH0s4ELcTF4QJKIhh0k6QNbY6m6cl9tkAAKaHyDk/8fkKPyYzhi0emZWkTr
         hh1KA77nAYcFmnP7YO7yFkdPpD5/lwfQjXt8K1m6mHm3t5G7B+puOVXSG0YeCm5sXsop
         Uy00/tt9LUmiO35VogO/+jFqcpkEupliQqk/62QLbiS0yz6hwHUkUxHCfqFQLBHZCqGK
         khAUMjoPDzn6jvuc4kJoBVpw2OU5wcC/eON2KP7MWk+2kU/JJl15npxx36kduqYku0ww
         /eWy9BfiA0Fs0M17HmIx8JvlxYcgeDbekB3G4THzgsHCtKHi9KFimNwsS13D5dq6qQp0
         gU/g==
X-Gm-Message-State: APjAAAVCeEPkCFcGJXQKEwBcYlPnuD2ezmllG9de0n3sHNHzOKN5dhgj
        cnNnQYHft30DsNXlqjqzrFs8LQ==
X-Google-Smtp-Source: APXvYqxUu7r9KkLSUQ4qzyBtyXTZoSMDeyCZcpbwZlxw26HMZjQAZjkMxKkrWlcyrlww3lQL7ZOGzg==
X-Received: by 2002:a50:f0d4:: with SMTP id a20mr25567858edm.149.1569929536456;
        Tue, 01 Oct 2019 04:32:16 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id w16sm3089185edd.93.2019.10.01.04.32.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 04:32:15 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 33253102FB8; Tue,  1 Oct 2019 14:32:16 +0300 (+03)
Date:   Tue, 1 Oct 2019 14:32:16 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     William Kucharski <william.kucharski@oracle.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/15] mm: Align THP mappings for non-DAX
Message-ID: <20191001113216.3qbrkqmb2b2xtwkd@box>
References: <20190925005214.27240-1-willy@infradead.org>
 <20190925005214.27240-15-willy@infradead.org>
 <20191001104558.rdcqhjdz7frfuhca@box>
 <A935F599-BB18-40C3-90DD-47B7700743D6@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A935F599-BB18-40C3-90DD-47B7700743D6@oracle.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 01, 2019 at 05:21:26AM -0600, William Kucharski wrote:
> 
> 
> > On Oct 1, 2019, at 4:45 AM, Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > 
> > On Tue, Sep 24, 2019 at 05:52:13PM -0700, Matthew Wilcox wrote:
> >> 
> >> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >> index cbe7d0619439..670a1780bd2f 100644
> >> --- a/mm/huge_memory.c
> >> +++ b/mm/huge_memory.c
> >> @@ -563,8 +563,6 @@ unsigned long thp_get_unmapped_area(struct file *filp, unsigned long addr,
> >> 
> >> 	if (addr)
> >> 		goto out;
> >> -	if (!IS_DAX(filp->f_mapping->host) || !IS_ENABLED(CONFIG_FS_DAX_PMD))
> >> -		goto out;
> >> 
> >> 	addr = __thp_get_unmapped_area(filp, len, off, flags, PMD_SIZE);
> >> 	if (addr)
> > 
> > I think you reducing ASLR without any real indication that THP is relevant
> > for the VMA. We need to know if any huge page allocation will be
> > *attempted* for the VMA or the file.
> 
> Without a properly aligned address the code will never even attempt allocating
> a THP.
> 
> I don't think rounding an address to one that would be properly aligned to map
> to a THP if possible is all that detrimental to ASLR and without the ability to
> pick an aligned address it's rather unlikely anyone would ever map anything to
> a THP unless they explicitly designate an address with MAP_FIXED.
> 
> If you do object to the slight reduction of the ASLR address space, what
> alternative would you prefer to see?

We need to know by the time if THP is allowed for this
file/VMA/process/whatever. Meaning that we do not give up ASLR entropy for
nothing.

For instance, if THP is disabled globally, there is no reason to align the
VMA to the THP requirements.

-- 
 Kirill A. Shutemov
