Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 145943EA814
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 17:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238534AbhHLPzj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 11:55:39 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50302 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238513AbhHLPzi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 11:55:38 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 017D81FF5E;
        Thu, 12 Aug 2021 15:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628783712; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A/eLGAQNVPbiz2tp9BUVayG4hS0zijcqKuMH2iPkfQ0=;
        b=ltFCgaLprHU/6wsgzNv7ddPVxYMLx0+i5jtMh6s44xLJz3iWpJqgJGpn+ZcXQfcDweTVSa
        JhybeA/wCUz3AloBv33CMskL7TfpyyDHRrYIhyMWji1UL95UV6SdHOIKx4uD3uGHenDn48
        BVfGX1MCnSMZQtJE4O7lV/NL9Y3hpFo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628783712;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A/eLGAQNVPbiz2tp9BUVayG4hS0zijcqKuMH2iPkfQ0=;
        b=TwUTAX4iTDG7m35vUcYb+54ms1mgJaZjf9+OrHq9vaXZ53FDQWAls1adKkxh7YvtIEdCPU
        +Qkzg+e/LW/e3CBg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id D6DA413ACC;
        Thu, 12 Aug 2021 15:55:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 0v17M19EFWGYeQAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Thu, 12 Aug 2021 15:55:11 +0000
Subject: Re: [PATCH v14 068/138] mm/writeback: Add folio_mark_dirty()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-69-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <1ac0a15c-5ce8-7169-9790-a1ac6abce040@suse.cz>
Date:   Thu, 12 Aug 2021 17:55:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210715033704.692967-69-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/15/21 5:35 AM, Matthew Wilcox (Oracle) wrote:
> Reimplement set_page_dirty() as a wrapper around folio_mark_dirty().
> There is no change to filesystems as they were already being called
> with the compound_head of the page being marked dirty.  We avoid
> several calls to compound_head(), both statically (through
> using folio_test_dirty() instead of PageDirty() and dynamically by
> calling folio_mapping() instead of page_mapping().
> 
> Also return bool instead of int to show the range of values actually
> returned, and add kernel-doc.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
