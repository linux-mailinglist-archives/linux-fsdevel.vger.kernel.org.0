Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D4175D181
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jul 2023 20:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjGUSsL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jul 2023 14:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGUSsK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jul 2023 14:48:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BA7E47
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Jul 2023 11:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=a4HzuP9b0pIZ/Y8IfgWdavC7qv9/cPHj5HMecrc3lf0=; b=ofGXXsb18eAgrHH82mCo0t2TnH
        mok84wTg2S3rFWDibuvUDyQV0U/0aYS+WQcLc2ASjFZJN832MEU++a7eE6ck/ibkdBJo3bgybfK5E
        gb7nII6KH6RN3fFeJG1OA0vwyG+d5VLgiQQ5FS6UYL9oB2/HhuKx5rmeHPJKw2lnz7Ar3qQ5dSjNb
        3oRUoZj9lD7oeI0P5vNrkndor28hWorN8hcXWnEpHymODmloKeFm2dPigU2cRaJox8D9hJJoPW/sj
        NXVqJrDIkU19zocpf4ibRnl7VIUY01hAEgaaMC5hNUJua+uZv0GebOoPh2JYFrHbGRn0XTDwMTBj0
        7QVsnk6A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qMvAZ-001N43-LZ; Fri, 21 Jul 2023 18:48:03 +0000
Date:   Fri, 21 Jul 2023 19:48:03 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Arjun Roy <arjunroy@google.com>, Eric Dumazet <edumazet@google.com>
Cc:     linux-mm@kvack.org, Suren Baghdasaryan <surenb@google.com>,
        linux-fsdevel@vger.kernel.org,
        Punit Agrawal <punit.agrawal@bytedance.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH v2 9/9] tcp: Use per-vma locking for receive zerocopy
Message-ID: <ZLrS4yBQRcDmwx9R@casper.infradead.org>
References: <20230711202047.3818697-1-willy@infradead.org>
 <20230711202047.3818697-10-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711202047.3818697-10-willy@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Eric?  Arjun?  Any comments?

On Tue, Jul 11, 2023 at 09:20:47PM +0100, Matthew Wilcox (Oracle) wrote:
> From: Arjun Roy <arjunroy@google.com>
> 
> Per-VMA locking allows us to lock a struct vm_area_struct without
> taking the process-wide mmap lock in read mode.
> 
> Consider a process workload where the mmap lock is taken constantly in
> write mode. In this scenario, all zerocopy receives are periodically
> blocked during that period of time - though in principle, the memory
> ranges being used by TCP are not touched by the operations that need
> the mmap write lock. This results in performance degradation.
> 
> Now consider another workload where the mmap lock is never taken in
> write mode, but there are many TCP connections using receive zerocopy
> that are concurrently receiving. These connections all take the mmap
> lock in read mode, but this does induce a lot of contention and atomic
> ops for this process-wide lock. This results in additional CPU
> overhead caused by contending on the cache line for this lock.
> 
> However, with per-vma locking, both of these problems can be avoided.
> 
> As a test, I ran an RPC-style request/response workload with 4KB
> payloads and receive zerocopy enabled, with 100 simultaneous TCP
> connections. I measured perf cycles within the
> find_tcp_vma/mmap_read_lock/mmap_read_unlock codepath, with and
> without per-vma locking enabled.
> 
> When using process-wide mmap semaphore read locking, about 1% of
> measured perf cycles were within this path. With per-VMA locking, this
> value dropped to about 0.45%.
> 
> Signed-off-by: Arjun Roy <arjunroy@google.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  net/ipv4/tcp.c | 39 ++++++++++++++++++++++++++++++++-------
>  1 file changed, 32 insertions(+), 7 deletions(-)
> 
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 1542de3f66f7..7118ec6cf886 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -2038,6 +2038,30 @@ static void tcp_zc_finalize_rx_tstamp(struct sock *sk,
>  	}
>  }
>  
> +static struct vm_area_struct *find_tcp_vma(struct mm_struct *mm,
> +		unsigned long address, bool *mmap_locked)
> +{
> +	struct vm_area_struct *vma = lock_vma_under_rcu(mm, address);
> +
> +	if (vma) {
> +		if (vma->vm_ops != &tcp_vm_ops) {
> +			vma_end_read(vma);
> +			return NULL;
> +		}
> +		*mmap_locked = false;
> +		return vma;
> +	}
> +
> +	mmap_read_lock(mm);
> +	vma = vma_lookup(mm, address);
> +	if (!vma || vma->vm_ops != &tcp_vm_ops) {
> +		mmap_read_unlock(mm);
> +		return NULL;
> +	}
> +	*mmap_locked = true;
> +	return vma;
> +}
> +
>  #define TCP_ZEROCOPY_PAGE_BATCH_SIZE 32
>  static int tcp_zerocopy_receive(struct sock *sk,
>  				struct tcp_zerocopy_receive *zc,
> @@ -2055,6 +2079,7 @@ static int tcp_zerocopy_receive(struct sock *sk,
>  	u32 seq = tp->copied_seq;
>  	u32 total_bytes_to_map;
>  	int inq = tcp_inq(sk);
> +	bool mmap_locked;
>  	int ret;
>  
>  	zc->copybuf_len = 0;
> @@ -2079,13 +2104,10 @@ static int tcp_zerocopy_receive(struct sock *sk,
>  		return 0;
>  	}
>  
> -	mmap_read_lock(current->mm);
> -
> -	vma = vma_lookup(current->mm, address);
> -	if (!vma || vma->vm_ops != &tcp_vm_ops) {
> -		mmap_read_unlock(current->mm);
> +	vma = find_tcp_vma(current->mm, address, &mmap_locked);
> +	if (!vma)
>  		return -EINVAL;
> -	}
> +
>  	vma_len = min_t(unsigned long, zc->length, vma->vm_end - address);
>  	avail_len = min_t(u32, vma_len, inq);
>  	total_bytes_to_map = avail_len & ~(PAGE_SIZE - 1);
> @@ -2159,7 +2181,10 @@ static int tcp_zerocopy_receive(struct sock *sk,
>  						   zc, total_bytes_to_map);
>  	}
>  out:
> -	mmap_read_unlock(current->mm);
> +	if (mmap_locked)
> +		mmap_read_unlock(current->mm);
> +	else
> +		vma_end_read(vma);
>  	/* Try to copy straggler data. */
>  	if (!ret)
>  		copylen = tcp_zc_handle_leftover(zc, sk, skb, &seq, copybuf_len, tss);
> -- 
> 2.39.2
> 
