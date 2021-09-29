Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0403741C838
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Sep 2021 17:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345105AbhI2PWz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Sep 2021 11:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345086AbhI2PWz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Sep 2021 11:22:55 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5C8C061760
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Sep 2021 08:21:14 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id n18so3036575pgm.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Sep 2021 08:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=hVd1gH+kQJeE39pFKVVrRFFFNBYhMYhDCh6W6dICdvg=;
        b=jxJaXVqLKmWeXRITZqbu/yFnOyoHEMy0nb1Vv4kwcyJCbrHuyudWxfXkDcUdLeeV5u
         oVJq9/Ap6P6u68TkD+22snpv2Dw6k2Pjt3AUc3NdvII749AokEMB1NkzkHOVHcjJdAyY
         Hlf7AAZpgx2hLOXn7sH6XpO6BvsT6zEyoY3PTDff32Rpi39Yww2IL04sus5DIfbQF7I1
         QHxsmXgWCGtO+a1hlr5p4wQTPYFTc6JpE+rd5AP3BhZNmKQDaDY61PoPjf0GStMwn0Eo
         FWus/VQmH38ncDI6zC/7cG3mvQisORwuUozeCsJRYttLzbLVndb9ruzP3JYu3VDpuy1V
         qYaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hVd1gH+kQJeE39pFKVVrRFFFNBYhMYhDCh6W6dICdvg=;
        b=lIx4eXFp7zL6QMaT+e6hkJ1AesKGVGbUrbvjZpyvfAaCurL2kqCcLXv/Ze2p/Bu/zn
         uhdpGLhfrTRAgrDdQOLjh16DmqvS0kTS/KZulFKz+9Q/EszQCbfrEHC4fHE4WWKeCIKU
         zrJzSJ/20NU9G5vjZEhLJSe+KHAHdTQxkvqg/NMH3DIjOz8iTB2PT0Fv/EtItJctoZxa
         vHhUBYkK74YQBX+UaDm/LPfIIJx+Zq4oGgl1bwumqmzTFKQwCAimEEcSOZ/I2lpwDyGt
         B+J7HoV8cLTXu4K0MOgEkDJK4DOIh8rHtb/1XRR22JoHGB67Q5Sjq1QTZuiW310rgiHe
         0N4A==
X-Gm-Message-State: AOAM533C7VOxFSUbu23Ur3hsxHZI2MnpEFrW8AD92nQxGkL9pAV+e5xS
        WKIni5R5KZyH5+kz0kR6TEFSrWxhQ0zwUw==
X-Google-Smtp-Source: ABdhPJwknkO3jUb/3aE2bLJWkGe1nnBdpCwNHtCzopo/FM06iJLWiO7fnWcQuoA+N1ZtZtsABeFIjw==
X-Received: by 2002:a63:790b:: with SMTP id u11mr454949pgc.71.1632928873659;
        Wed, 29 Sep 2021 08:21:13 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id p17sm197322pfo.9.2021.09.29.08.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 08:21:13 -0700 (PDT)
Date:   Wed, 29 Sep 2021 15:21:09 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Stephen <stephenackerman16@gmail.com>
Cc:     djwong@kernel.org, kvm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: kvm crash in 5.14.1?
Message-ID: <YVSEZTCbFZ+HD/f0@google.com>
References: <2b5ca6d3-fa7b-5e2f-c353-f07dcff993c1@gmail.com>
 <16c7a433-6e58-4213-bc00-5f6196fe22f5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16c7a433-6e58-4213-bc00-5f6196fe22f5@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 28, 2021, Stephen wrote:
> Hello,
> 
> I got this crash again on 5.14.7 in the early morning of the 27th.
> Things hung up shortly after I'd gone to bed. Uptime was 1 day 9 hours 9
> minutes.

...

> BUG: kernel NULL pointer dereference, address: 0000000000000068
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 0 P4D 0
> Oops: 0000 [#1] SMP NOPTI
> CPU: 21 PID: 8494 Comm: CPU 7/KVM Tainted: G            E     5.14.7 #32
> Hardware name: Gigabyte Technology Co., Ltd. X570 AORUS ELITE WIFI/X570
> AORUS ELITE WIFI, BIOS F35 07/08/2021
> RIP: 0010:internal_get_user_pages_fast+0x738/0xda0
> Code: 84 24 a0 00 00 00 65 48 2b 04 25 28 00 00 00 0f 85 54 06 00 00 48
> 81 c4 a8 00 00 00 44 89 e0 5b 5d 41 5c 41 5d 41 5e 41 5f c3 <48> 81 78
> 68 a0 a3 >

I haven't reproduced the crash, but the code signature (CMP against an absolute
address) is quite distinct, and is consistent across all three crashes.  I'm pretty
sure the issue is that page_is_secretmem() doesn't check for a null page->mapping,
e.g. if the page is truncated, which IIUC can happen in parallel since gup() doesn't
hold the lock.

I think this should fix the problems?

diff --git a/include/linux/secretmem.h b/include/linux/secretmem.h
index 21c3771e6a56..988528b5da43 100644
--- a/include/linux/secretmem.h
+++ b/include/linux/secretmem.h
@@ -23,7 +23,7 @@ static inline bool page_is_secretmem(struct page *page)
        mapping = (struct address_space *)
                ((unsigned long)page->mapping & ~PAGE_MAPPING_FLAGS);

-       if (mapping != page->mapping)
+       if (!mapping || mapping != page->mapping)
                return false;

        return mapping->a_ops == &secretmem_aops;
