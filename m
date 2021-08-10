Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 196713E7D26
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 18:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbhHJQIe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 12:08:34 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49908 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbhHJQI0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 12:08:26 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B404921FF3;
        Tue, 10 Aug 2021 16:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628611683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xYaFzcIMw3qFmrYTgphte6/1PHFhObKrzlRtTshtz30=;
        b=qk8q7pkuEJDBRmDi0XWjJiCMOBtUMgVD3VgPOsfacQ+7B0EzIvwE3AjBrQgr26JZBbr8HO
        UK7XZc74aeOTC/NpE8tXNfRwzQ90U04DGhk/vnycpDrYuX72GEFDabffdnhMT7c3ffEwNe
        JlmEc8SeRUlFPb78uk77QeBzLf91CTk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628611683;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xYaFzcIMw3qFmrYTgphte6/1PHFhObKrzlRtTshtz30=;
        b=/Rvwrz+U1xpku/2UomWswBRqPRzN8NIdIVSOHq1NPDYJpYLl5tCpTpX41ahErZY+hu1Mfd
        oNt2yf+ptmJzPGBw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 8BB4C137DA;
        Tue, 10 Aug 2021 16:08:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id Kyr4IGOkEmHUTAAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Tue, 10 Aug 2021 16:08:03 +0000
Subject: Re: [PATCH v14 022/138] mm/filemap: Add __folio_lock_or_retry()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        William Kucharski <william.kucharski@oracle.com>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-23-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <984ee3c0-7189-3481-8a1f-9e2765906224@suse.cz>
Date:   Tue, 10 Aug 2021 18:08:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210715033704.692967-23-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/15/21 5:35 AM, Matthew Wilcox (Oracle) wrote:
> Convert __lock_page_or_retry() to __folio_lock_or_retry().  This actually
> saves 4 bytes in the only caller of lock_page_or_retry() (due to better
> register allocation) and saves the 14 byte cost of calling page_folio()
> in __folio_lock_or_retry() for a total saving of 18 bytes.  Also use
> a bool for the return type.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Layton <jlayton@kernel.org>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Nit:

> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1625,48 +1625,46 @@ static int __folio_lock_async(struct folio *folio, struct wait_page_queue *wait)
>  
>  /*
>   * Return values:
> - * 1 - page is locked; mmap_lock is still held.
> - * 0 - page is not locked.
> + * true - folio is locked; mmap_lock is still held.
> + * false - folio is not locked.
>   *     mmap_lock has been released (mmap_read_unlock(), unless flags had both
>   *     FAULT_FLAG_ALLOW_RETRY and FAULT_FLAG_RETRY_NOWAIT set, in
>   *     which case mmap_lock is still held.
>   *
>   * If neither ALLOW_RETRY nor KILLABLE are set, will always return 1

s/1/true/ ? :)

> - * with the page locked and the mmap_lock unperturbed.
> + * with the folio locked and the mmap_lock unperturbed.
>   */
> -int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
> +bool __folio_lock_or_retry(struct folio *folio, struct mm_struct *mm,
>  			 unsigned int flags)
>  {
> -	struct folio *folio = page_folio(page);
> -
>  	if (fault_flag_allow_retry_first(flags)) {
>  		/*
>  		 * CAUTION! In this case, mmap_lock is not released
>  		 * even though return 0.
>  		 */
>  		if (flags & FAULT_FLAG_RETRY_NOWAIT)
> -			return 0;
> +			return false;
>  
>  		mmap_read_unlock(mm);
>  		if (flags & FAULT_FLAG_KILLABLE)
>  			folio_wait_locked_killable(folio);
>  		else
>  			folio_wait_locked(folio);
> -		return 0;
> +		return false;
>  	}
>  	if (flags & FAULT_FLAG_KILLABLE) {
> -		int ret;
> +		bool ret;
>  
>  		ret = __folio_lock_killable(folio);
>  		if (ret) {
>  			mmap_read_unlock(mm);
> -			return 0;
> +			return false;
>  		}
>  	} else {
>  		__folio_lock(folio);
>  	}
>  
> -	return 1;
> +	return true;
>  }
>  
>  /**
