Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22BA36FE504
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 May 2023 22:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236391AbjEJU21 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 May 2023 16:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235881AbjEJU20 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 May 2023 16:28:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC34B4C16
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 May 2023 13:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683750456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9GYo8N3GVBW0oULuq3gkozsZNhPHI8kWzSKmHgQI1Vo=;
        b=ftTZYbIjUPCHUZOHTKpYPhwd+H+eisItbPD7Q5ADJhtEtSo/aJg9kfJojfceY5cCJoWaS6
        9L3bPsYYNenqJLM1/pO9VFTYxj0uZaN7PLF+WLHS+oiqxEqGs1wtIUNjTcBhIu0w9xKfyr
        muX0thqa6+/EgmU1xfmy6+sLQBw1JXg=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-1pTAwnwkNdu9WR5URfHZXA-1; Wed, 10 May 2023 16:27:34 -0400
X-MC-Unique: 1pTAwnwkNdu9WR5URfHZXA-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1ac4e2d6eb7so5718075ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 May 2023 13:27:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683750453; x=1686342453;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9GYo8N3GVBW0oULuq3gkozsZNhPHI8kWzSKmHgQI1Vo=;
        b=NbmTKU8bNg0Irhn79DLmjCisE93sWQ0EVSohub9JqxcAuLhrbZG+gF2+35KeEZlitj
         njql8ATIJOmnXFg6qv5EeKP56HmIPo+Z3xgA6+I1haLfIwfO4K+dykEAIQ7nr9o1clRl
         riJ2PBaywZ8eZfahe5iL3wdC7vpGMmUOaLrrQ7DpPXtAxBzr18oELtAyMd6Qo7GrIEc3
         Tjaz+sFBSZ4jn1ZEWJwZCu2EqJZKbS8FG117ISJNutUzXMfIsTmAPgI5a0xNoqtuPAVx
         pcEUBkMj9/P9INXh1nW2b4p2iJk9DGoq91/kqfpKR58cWkE55xkgaVZUGekC4xCsuDYy
         bI9Q==
X-Gm-Message-State: AC+VfDxz73aUYqbRzEhJcChYBbQAQBPjfETGHAH9zsn749nl7RpxIqly
        WJm/hguiulENZLeFcbyrEMOfGMwP4qaBRhbqct9pYKmgEUERjmg1NR5zW9OBsVl7miMQrX8ztpF
        jBrvDNUwANxfG7/OnrE+eKjIs+w==
X-Received: by 2002:a17:902:ea0b:b0:1ac:69ba:e159 with SMTP id s11-20020a170902ea0b00b001ac69bae159mr17043164plg.5.1683750453420;
        Wed, 10 May 2023 13:27:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7vWW0nbm4b6CKppwdgUldxkv86ysGUVfro14rqsXNjjup9ieVZhY479DLefU70ByzdIyIOyQ==
X-Received: by 2002:a17:902:ea0b:b0:1ac:69ba:e159 with SMTP id s11-20020a170902ea0b00b001ac69bae159mr17043137plg.5.1683750452968;
        Wed, 10 May 2023 13:27:32 -0700 (PDT)
Received: from x1n ([2001:4958:15a0:30:ea6e:cae6:2dab:2897])
        by smtp.gmail.com with ESMTPSA id f10-20020a17090274ca00b001ab28f620d0sm4199783plt.290.2023.05.10.13.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 13:27:32 -0700 (PDT)
Date:   Wed, 10 May 2023 13:27:31 -0700
From:   Peter Xu <peterx@redhat.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@linaro.org>,
        syzbot+48011b86c8ea329af1b9@syzkaller.appspotmail.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] filemap: Handle error return from __filemap_get_folio()
Message-ID: <ZFv+M5egsMxE1rhF@x1n>
References: <20230506160415.2992089-1-willy@infradead.org>
 <CAHk-=winrN4jsysShx0kWKVzmSMu7Pp3nz_6+aps9CP+v-qHWQ@mail.gmail.com>
 <CAHk-=winai-5i6E1oMk7hXPfbP+SCssk5+TOLCJ3koaDrn7Bzg@mail.gmail.com>
 <CAHk-=wiZ0GaAdqyke-egjBRaqP-QdLcX=8gNk7m6Hx7rXjcXVQ@mail.gmail.com>
 <20230509191918.GB18828@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230509191918.GB18828@cmpxchg.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 09, 2023 at 03:19:18PM -0400, Johannes Weiner wrote:
> On Sat, May 06, 2023 at 10:04:48AM -0700, Linus Torvalds wrote:
> > On Sat, May 6, 2023 at 9:35 AM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > And yes, the simplest fix for the "wrong test" would be to just add a
> > > new "out_nofolio" error case after "out_retry", and use that.
> > >
> > > However, even that seems wrong, because the return value for that path
> > > is the wrong one.
> > 
> > Actually, my suggested patch is _also_ wrong.
> > 
> > The problem is that we do need to return VM_FAULT_RETRY to let the
> > caller know that we released the mmap_lock.
> > 
> > And once we return VM_FAULT_RETRY, the other error bits don't even matter.
> > 
> > So while I think the *right* thing to do is to return VM_FAULT_OOM |
> > VM_FAULT_RETRY, that doesn't actually end up working, because if
> > VM_FAULT_RETRY is set, the caller will know that "yes, mmap_lock was
> > dropped", but the callers will also just ignore the other bits and
> > unconditionally retry.
> > 
> > How very very annoying.
> > 
> > This was introduced several years ago by commit 6b4c9f446981
> > ("filemap: drop the mmap_sem for all blocking operations").
> > 
> > Looking at that, we have at least one other similar error case wrong
> > too: the "page_not_uptodate" case carefully checks for IO errors and
> > retries only if there was no error (or for the AOP_TRUNCATED_PAGE)
> > case.
> > 
> > For an actual IO error on page reading, it returns VM_FAULT_SIGBUS.
> > 
> > Except - again - for that "if (fpin) goto out_retry" case, which will
> > just return VM_FAULT_RETRY and retry the fault.
> > 
> > I do not believe that retrying the fault is the right thing to do when
> > we ran out of memory, or when we had an IO error, and I do not think
> > it was intentional that the error handling was changed.
> 
> This is a while ago and the code has changed quite a bit since, so
> bear with me.
> 
> Originally, we only ever did a maximum of two tries: one where the
> lock might be dropped to kick off IO, then a synchronous one. IIRC the
> thinking at the time was that events like OOMs and IO failures are
> rare enough that doing the retry anyway (even if somewhat pointless)
> and reacting to the issue then (if it persisted) was a tradeoff to
> keep the retry logic simple.
> 
> Since 4064b9827063 ("mm: allow VM_FAULT_RETRY for multiple times") we
> don't clear FAULT_FLAG_ALLOW_RETRY anymore though, and we might see
> more than one loop. At least outside the page cache. So I agree it
> makes sense to look at the return value more carefully and act on
> errors more timely in the arch handler.
> 
> Draft patch below. It survives a boot and a will-it-scale smoke test,
> but I haven't put it through the grinder yet.
> 
> One thing that gave me pause is this comment:
> 
> 	/*
> 	 * If we need to retry the mmap_lock has already been released,
> 	 * and if there is a fatal signal pending there is no guarantee
> 	 * that we made any progress. Handle this case first.
> 	 */
> 
> I think it made sense when it was added in 26178ec11ef3 ("x86: mm:
> consolidate VM_FAULT_RETRY handling"). But after 39678191cd89
> ("x86/mm: use helper fault_signal_pending()") it's in a misleading
> location, since the signal handling is above it.
> 
> So I'm removing it, but please let me know if I missed something.
> 
> ---
>  arch/x86/mm/fault.c | 40 +++++++++++++++++++++++-----------------
>  mm/filemap.c        | 18 +++++++++++-------
>  2 files changed, 34 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index e4399983c50c..f1d242be723f 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -1456,20 +1456,15 @@ void do_user_addr_fault(struct pt_regs *regs,
>  		return;
>  
>  	/*
> -	 * If we need to retry the mmap_lock has already been released,
> -	 * and if there is a fatal signal pending there is no guarantee
> -	 * that we made any progress. Handle this case first.
> +	 * If we need to retry the mmap_lock has already been released.
>  	 */
> -	if (unlikely(fault & VM_FAULT_RETRY)) {
> -		flags |= FAULT_FLAG_TRIED;
> -		goto retry;
> -	}
> +	if (likely(!(fault & VM_FAULT_RETRY)))
> +		mmap_read_unlock(mm);
>  
> -	mmap_read_unlock(mm);
>  #ifdef CONFIG_PER_VMA_LOCK
>  done:
>  #endif
> -	if (likely(!(fault & VM_FAULT_ERROR)))
> +	if (likely(!(fault & (VM_FAULT_ERROR|VM_FAULT_RETRY))))
>  		return;
>  
>  	if (fatal_signal_pending(current) && !user_mode(regs)) {
> @@ -1493,15 +1488,26 @@ void do_user_addr_fault(struct pt_regs *regs,
>  		 * oom-killed):
>  		 */
>  		pagefault_out_of_memory();
> -	} else {
> -		if (fault & (VM_FAULT_SIGBUS|VM_FAULT_HWPOISON|
> -			     VM_FAULT_HWPOISON_LARGE))
> -			do_sigbus(regs, error_code, address, fault);
> -		else if (fault & VM_FAULT_SIGSEGV)
> -			bad_area_nosemaphore(regs, error_code, address);
> -		else
> -			BUG();
> +		return;
> +	}
> +
> +	if (fault & (VM_FAULT_SIGBUS|VM_FAULT_HWPOISON|
> +		     VM_FAULT_HWPOISON_LARGE)) {
> +		do_sigbus(regs, error_code, address, fault);
> +		return;
>  	}
> +
> +	if (fault & VM_FAULT_SIGSEGV) {
> +		bad_area_nosemaphore(regs, error_code, address);
> +		return;
> +	}
> +
> +	if (fault & VM_FAULT_RETRY) {
> +		flags |= FAULT_FLAG_TRIED;
> +		goto retry;
> +	}
> +
> +	BUG();
>  }
>  NOKPROBE_SYMBOL(do_user_addr_fault);
>  
> diff --git a/mm/filemap.c b/mm/filemap.c
> index b4c9bd368b7e..f97ca5045c19 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3290,10 +3290,11 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>  					  FGP_CREAT|FGP_FOR_MMAP,
>  					  vmf->gfp_mask);
>  		if (IS_ERR(folio)) {
> +			ret = VM_FAULT_OOM;
>  			if (fpin)
>  				goto out_retry;
>  			filemap_invalidate_unlock_shared(mapping);
> -			return VM_FAULT_OOM;
> +			return ret;
>  		}
>  	}
>  
> @@ -3362,15 +3363,18 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>  	 */
>  	fpin = maybe_unlock_mmap_for_io(vmf, fpin);
>  	error = filemap_read_folio(file, mapping->a_ops->read_folio, folio);
> -	if (fpin)
> -		goto out_retry;
>  	folio_put(folio);
> -
> -	if (!error || error == AOP_TRUNCATED_PAGE)
> +	folio = NULL;
> +	if (!error || error == AOP_TRUNCATED_PAGE) {
> +		if (fpin)
> +			goto out_retry;
>  		goto retry_find;
> +	}
> +	ret = VM_FAULT_SIGBUS;
> +	if (fpin)
> +		goto out_retry;
>  	filemap_invalidate_unlock_shared(mapping);
> -
> -	return VM_FAULT_SIGBUS;
> +	return ret;
>  
>  out_retry:
>  	/*
> -- 
> 2.40.1
> 

The change looks all right to me.

Acked-by: Peter Xu <peterx@redhat.com>

For the long term maybe we want to cleanup a bit on the VM_FAULT_* entries,
e.g., here VM_FAULT_RETRY doesn't really mean "we should retry the fault"
but instead only the hint to show that we'ver released the mmap lock when
any error is set.

Meanwhile it's also not the only one to express that because now we also
have VM_FAULT_COMPLETED, so it's debatable which one we should use here
purely from the logic and definition of the retvals.

One thing we can make this slightly cleaner in the future is we can have a
flag sololy for "we have released the mmap lock", so fundamentally we can
consider renaming COMPLETE->MM_RELEASED, then we use RETRY to only hint
"whether we really want to retry" and leave "whether mmap lock released"
for the new flag.

It could look like:

  MM_RELEASED    (new) RETRY
  0              0             -> page fault resolved (old "retval=0")
  0              1             -> retry with mmap held (currently invalid, so let's ignore this)
  1              0             -> resolved and lock released (old COMPLETE)
  1              1             -> lock releaesd,need to retry (old RETRY)

Then IIUC for error cases we can return MM_RELEASED|ERROR for whatever
error (without setting RETRY).

Not sure whether it helps in any form.  Even if it would, it can definitely
be done on top.

Thanks,

-- 
Peter Xu

