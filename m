Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5EA1C31B7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2019 12:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731166AbfJAKqC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Oct 2019 06:46:02 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44871 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730122AbfJAKqB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Oct 2019 06:46:01 -0400
Received: by mail-ed1-f66.google.com with SMTP id r16so11407783edq.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Oct 2019 03:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZGPIEKrHmzcXL2G1AKBp3a5BxehFh3AVUPgPe2piYK4=;
        b=VxJqWe3mdZat5nR/fSc2HvBQrlQKull+sVq32H4etLILzPBpyr6lVFrBD74sM+QgeW
         n5Vjw2s85vp2oTMun6+bsscUIJDoizbDUeXixHcVM9q5Qq/QnxLQHocmATrcpgBIpyX+
         VEGe+Q//+gTcp6vBNvc24PMoWYr7ThfKxW354YRyFC2RVKv9ekJgXFX/zWqH6JH3bJey
         55Q7uNfhxksBxLGuYWgqKqGnDdp5gnBk3K32tQQ6+LY+SPIIsRlH+L936r/G0B3NpiZS
         RKg+Y7r+YZXqFEB0U26J3mRe6fTIVy0mwUdb/zmONsyo4JIS305UBeptY38Kv4p4Sbju
         irxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZGPIEKrHmzcXL2G1AKBp3a5BxehFh3AVUPgPe2piYK4=;
        b=puG3Kr8jkZ9V5QMOqBYNZAd+BYy3PY09mAKpogRLeINLKsUhfpXUuMAUC2lx/553A3
         kCKJNbPftibczD6zb7KxvAwDu7WqE5Y9j1nPKro9VJgGfOHICC3TVIb80Z1pbrzMfM1M
         MjX6z6CAC3W4W5uDxjTyrEBvBoJVfWJqb1OVpMFdc0bk5rjRV7NdDeNvrTk2AMpzsG2s
         7qxBJJvwo+C/I4ttsIO7s8zWdLcuePm7kUXncVWc7jO1GC8ypBYX6zDLm9WJwpeSNK3b
         MDkAtZbxh2iVKyVKEjz50rTEDFuq84PiLWW2fvWLC4CfCJFx0UavXdKf06xwaIY2anaL
         U5cg==
X-Gm-Message-State: APjAAAUNvhT6f+BoBIwksUujny0+u77bSnptOooe3Ckdk9xTLqIwG7L9
        aG7HWb5SUYIr6DquLmh91xpn1HBPrS0=
X-Google-Smtp-Source: APXvYqx+vdXoo3tJzcApTsLX/qaEoEohFu9FCkGIiXfq+CUARk1Jii+GqGjNaAc7FqOsJtWmP86UPQ==
X-Received: by 2002:a05:6402:32f:: with SMTP id q15mr24712672edw.143.1569926758568;
        Tue, 01 Oct 2019 03:45:58 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id z20sm3051639edb.3.2019.10.01.03.45.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 03:45:57 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 7B8AE102FB8; Tue,  1 Oct 2019 13:45:58 +0300 (+03)
Date:   Tue, 1 Oct 2019 13:45:58 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH 14/15] mm: Align THP mappings for non-DAX
Message-ID: <20191001104558.rdcqhjdz7frfuhca@box>
References: <20190925005214.27240-1-willy@infradead.org>
 <20190925005214.27240-15-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925005214.27240-15-willy@infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 24, 2019 at 05:52:13PM -0700, Matthew Wilcox wrote:
> From: William Kucharski <william.kucharski@oracle.com>
> 
> When we have the opportunity to use transparent huge pages to map a
> file, we want to follow the same rules as DAX.
> 
> Signed-off-by: William Kucharski <william.kucharski@oracle.com>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/huge_memory.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index cbe7d0619439..670a1780bd2f 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -563,8 +563,6 @@ unsigned long thp_get_unmapped_area(struct file *filp, unsigned long addr,
>  
>  	if (addr)
>  		goto out;
> -	if (!IS_DAX(filp->f_mapping->host) || !IS_ENABLED(CONFIG_FS_DAX_PMD))
> -		goto out;
>  
>  	addr = __thp_get_unmapped_area(filp, len, off, flags, PMD_SIZE);
>  	if (addr)

I think you reducing ASLR without any real indication that THP is relevant
for the VMA. We need to know if any huge page allocation will be
*attempted* for the VMA or the file.

-- 
 Kirill A. Shutemov
