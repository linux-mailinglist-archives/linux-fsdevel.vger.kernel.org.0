Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF952E01B4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Dec 2020 21:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgLUUyS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Dec 2020 15:54:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38897 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726048AbgLUUyR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Dec 2020 15:54:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608583970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YISt5j4b8XAb8GNT7dnsvmnkE22RNgIdTlImdupifmU=;
        b=DGBQZcf0pJ3iJ7VJ1xWubLRp0evF4DvpT7ZVpYcIXwMUgdKZowv5dbhsoz9Ce4zYucFA+h
        VexD8Bjo3+rNyXJqkKD6j9cQOmGP5/MI2WPC0M2MCWsoILnEvvIpl4NFp8augtxQmuS82M
        ARKBOYULMiJnvGTVNQU36AtbdN5Yf+w=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-aJpcTbPqPVW19PVWqZPQpw-1; Mon, 21 Dec 2020 15:52:48 -0500
X-MC-Unique: aJpcTbPqPVW19PVWqZPQpw-1
Received: by mail-qt1-f200.google.com with SMTP id i13so8688213qtp.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Dec 2020 12:52:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YISt5j4b8XAb8GNT7dnsvmnkE22RNgIdTlImdupifmU=;
        b=iwACSJDtlyg0OcB8W4Qhrz/CFP3ZNEfmgi0OrnAIq5DnQYOvlIB8/j0Q/F+gFASBVZ
         Pi47YglfcI0XxGbx/a14CfZJl78xuPe3Z1ZyM2kaiuNCLPBXuUrwaQvafjzW3x816D48
         9DARb/TIM3+Da5Jo0Wtl7ta601iIs64U/57eCiMGv4dBEdfN8WPu9E1NqO1KY54a3L6x
         WLJPnhySjZd/SHEbG9BDUFyCbWmh6pEt5c/EHNVTFvDU9baDpME20xuFYYaQt2TTiC5P
         +fEOX1bh6LcSyf6jk8GdIAK/i40pFG8itM2qAXfnlk5ba82rOCLMNTxgVchawYRBmJIS
         Y3AQ==
X-Gm-Message-State: AOAM5319yWv+AItyiPjuAx79RwNrcswd1osBSyMuAcDA1QV/oefMG/zR
        CXrvmhhNg5tzjwtKI07IktP5kV9TpNGHXLnAxCyd47fK62CR9uJg5/14Z3Y8B20F3HXth3b6rNV
        WgB3GdmN+1AAwOVPm1DEMrt570g==
X-Received: by 2002:ac8:1c6a:: with SMTP id j39mr18262155qtk.341.1608583968346;
        Mon, 21 Dec 2020 12:52:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxlTQNtGfgcc75KoX43sIvGUMqc1M5QQjfDVaI6Wi++irNpTyfAAD7kpHTPTCFPsWuJ85Dxgg==
X-Received: by 2002:ac8:1c6a:: with SMTP id j39mr18262143qtk.341.1608583968088;
        Mon, 21 Dec 2020 12:52:48 -0800 (PST)
Received: from xz-x1 ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id y67sm1521029qka.68.2020.12.21.12.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 12:52:47 -0800 (PST)
Date:   Mon, 21 Dec 2020 15:52:45 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [RFC PATCH 03/13] selftests/vm/userfaultfd: wake after copy
 failure
Message-ID: <20201221205245.GJ6640@xz-x1>
References: <20201129004548.1619714-1-namit@vmware.com>
 <20201129004548.1619714-4-namit@vmware.com>
 <20201221192846.GH6640@xz-x1>
 <2B08ECCA-A7D2-4743-8956-571CB8788FDA@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2B08ECCA-A7D2-4743-8956-571CB8788FDA@vmware.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 21, 2020 at 07:51:52PM +0000, Nadav Amit wrote:
> > On Dec 21, 2020, at 11:28 AM, Peter Xu <peterx@redhat.com> wrote:
> > 
> > On Sat, Nov 28, 2020 at 04:45:38PM -0800, Nadav Amit wrote:
> >> From: Nadav Amit <namit@vmware.com>
> >> 
> >> When userfaultfd copy-ioctl fails since the PTE already exists, an
> >> -EEXIST error is returned and the faulting thread is not woken. The
> >> current userfaultfd test does not wake the faulting thread in such case.
> >> The assumption is presumably that another thread set the PTE through
> >> copy/wp ioctl and would wake the faulting thread or that alternatively
> >> the fault handler would realize there is no need to "must_wait" and
> >> continue. This is not necessarily true.
> >> 
> >> There is an assumption that the "must_wait" tests in handle_userfault()
> >> are sufficient to provide definitive answer whether the offending PTE is
> >> populated or not. However, userfaultfd_must_wait() test is lockless.
> >> Consequently, concurrent calls to ptep_modify_prot_start(), for
> >> instance, can clear the PTE and can cause userfaultfd_must_wait()
> >> to wrongly assume it is not populated and a wait is needed.
> > 
> > Yes userfaultfd_must_wait() is lockless, however my understanding is that we'll
> > enqueue before reading the page table, which seems to me that we'll always get
> > notified even the race happens.  Should apply to either UFFDIO_WRITEPROTECT or
> > UFFDIO_COPY, iiuc, as long as we follow the order of (1) modify pgtable (2)
> > wake sleeping threads.  Then it also means that when must_wait() returned true,
> > it should always get waked up when fault resolved.
> > 
> > Taking UFFDIO_COPY as example, even if UFFDIO_COPY happen right before
> > must_wait() calls:
> > 
> >       worker thread                       uffd thread
> >       -------------                       -----------
> > 
> >   handle_userfault
> >    spin_lock(fault_pending_wqh)
> >    enqueue()
> >    set_current_state(INTERRUPTIBLE)
> >    spin_unlock(fault_pending_wqh)
> >    must_wait()
> >      lockless walk page table
> >                                           UFFDIO_COPY
> >                                             fill in the hole
> >                                             wake up threads
> >                                               (this will wake up worker thread too?)
> >    schedule()
> >      (which may return immediately?)
> > 
> > While here fault_pending_wqh is lock protected. I just feel like there's some
> > other reason to cause the thread to stall.  Or did I miss something?
> 
> But what happens if the copy completed before the enqueuing? Assume
> the page is write-protected during UFFDIO_COPY:
> 
> 
> cpu0					cpu1		
> ----					----			
> handle_userfault
> 					UFFDIO_COPY
> 					[ write-protected ]
> 				 	 fill in the hole
> 				 	 wake up threads
> 				 	 [nothing to wake]
> 							
> 					UFFD_WP (unprotect)
> 					 logically marks as unprotected
> 					 [nothing to wake]
> 
>  spin_lock(fault_pending_wqh)
>   enqueue()
>   set_current_state(INTERRUPTIBLE)
>   spin_unlock(fault_pending_wqh)
>   must_wait()
> 
> 					[ #PF on the same PTE
> 					 due to write-protection ]
> 
> 					...
> 					 wp_page_copy()
> 					  ptep_clear_flush_notify()
> 					  [ PTE is clear ]
> 					
>    lockless walk page table
>     pte_none(*pte) -> must wait
> 
> Note that additional scenarios are possible. For instance, instead of
> wp_page_copy(), we can have other change_pte_range() (due to worker’s
> mprotect() or NUMA balancing), calling ptep_modify_prot_start() and clearing
> the PTE.
> 
> Am I missing something?

Ah I see your point, thanks.  I think you're right:

Reviewed-by: Peter Xu <peterx@redhat.com>

Would you mind adding something like above into the commit message if you're
going to repost?  IMHO it would even be nicer to mention why
UFFDIO_WRITEPROTECT does not need this extra wakeup (I think it's because it'll
do the wakeup unconditionally anyway).

-- 
Peter Xu

