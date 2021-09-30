Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D516641E070
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Sep 2021 20:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352940AbhI3SBl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Sep 2021 14:01:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:50336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352908AbhI3SBl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Sep 2021 14:01:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5B559619F6;
        Thu, 30 Sep 2021 17:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633024798;
        bh=XqDuBOd5I+ZLfLeu4Zc8sAqKLHJkcyPDVnlaZ94W4Bw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DQe0F7QUVdz2wES6cxy6eiIAFN9CWXMQztKUAENKkZ+QfqIj9vebhKMI62Iwg3TIf
         b7FZ68MX07LelJYt67SneH0Am6SJfghn1tQwqKBxp+QgLiXtLxaE6BdSXamRRlzUfl
         4jt5M6vDeJCK9B4npitCqTOGfaFWfc3yWz2HX3IMDsXtqBuEYNGXHBsa9FCaZhvJJz
         UuuOSgbZChp0i2LFbIqhIZCzJkchGeboWS5qrIH0ndD8BgKJAXZ4ay7Gqt2KaESnBY
         0AXRZURRsq5e2JMU7LLp+Je/Ohm5yKxFt6+4uiyiEu98LfrTae3Hha7EEI6TFmNwji
         GcIzSrQcIk4Dg==
Date:   Thu, 30 Sep 2021 10:59:57 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Stephen <stephenackerman16@gmail.com>, kvm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: kvm crash in 5.14.1?
Message-ID: <20210930175957.GA10573@magnolia>
References: <2b5ca6d3-fa7b-5e2f-c353-f07dcff993c1@gmail.com>
 <16c7a433-6e58-4213-bc00-5f6196fe22f5@gmail.com>
 <YVSEZTCbFZ+HD/f0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YVSEZTCbFZ+HD/f0@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 29, 2021 at 03:21:09PM +0000, Sean Christopherson wrote:
> On Tue, Sep 28, 2021, Stephen wrote:
> > Hello,
> > 
> > I got this crash again on 5.14.7 in the early morning of the 27th.
> > Things hung up shortly after I'd gone to bed. Uptime was 1 day 9 hours 9
> > minutes.
> 
> ...
> 
> > BUG: kernel NULL pointer dereference, address: 0000000000000068
> > #PF: supervisor read access in kernel mode
> > #PF: error_code(0x0000) - not-present page
> > PGD 0 P4D 0
> > Oops: 0000 [#1] SMP NOPTI
> > CPU: 21 PID: 8494 Comm: CPU 7/KVM Tainted: G            E     5.14.7 #32
> > Hardware name: Gigabyte Technology Co., Ltd. X570 AORUS ELITE WIFI/X570
> > AORUS ELITE WIFI, BIOS F35 07/08/2021
> > RIP: 0010:internal_get_user_pages_fast+0x738/0xda0
> > Code: 84 24 a0 00 00 00 65 48 2b 04 25 28 00 00 00 0f 85 54 06 00 00 48
> > 81 c4 a8 00 00 00 44 89 e0 5b 5d 41 5c 41 5d 41 5e 41 5f c3 <48> 81 78
> > 68 a0 a3 >
> 
> I haven't reproduced the crash, but the code signature (CMP against an absolute
> address) is quite distinct, and is consistent across all three crashes.  I'm pretty
> sure the issue is that page_is_secretmem() doesn't check for a null page->mapping,
> e.g. if the page is truncated, which IIUC can happen in parallel since gup() doesn't
> hold the lock.
> 
> I think this should fix the problems?
> 
> diff --git a/include/linux/secretmem.h b/include/linux/secretmem.h
> index 21c3771e6a56..988528b5da43 100644
> --- a/include/linux/secretmem.h
> +++ b/include/linux/secretmem.h
> @@ -23,7 +23,7 @@ static inline bool page_is_secretmem(struct page *page)
>         mapping = (struct address_space *)
>                 ((unsigned long)page->mapping & ~PAGE_MAPPING_FLAGS);
> 
> -       if (mapping != page->mapping)
> +       if (!mapping || mapping != page->mapping)

I'll roll this out on my vm host and try to re-run the mass fuzztest
overnight, though IT claims they're going to kill power to the whole
datacenter until Monday(!)...

--D

>                 return false;
> 
>         return mapping->a_ops == &secretmem_aops;
