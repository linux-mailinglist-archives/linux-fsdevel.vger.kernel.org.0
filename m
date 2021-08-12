Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 799B53EA880
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 18:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbhHLQZI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 12:25:08 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:54468 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232353AbhHLQZH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 12:25:07 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 98D621FD64;
        Thu, 12 Aug 2021 16:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628785481; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O1P5cfCreQpHbUvjnHSmGavypkvtu0Fv9JV7GTmIvDs=;
        b=MtGuQnGVxAj9qQY/WgpjvbugyusrHdR5L7BXpt8FTy5H0s7kmeSTs4lsvn0whf1EK2Fmsi
        ckQEdalKDo11BCZr9P7SVX6A/GrZLBoi7uz92i7jOoIz8RWh3b8aE8hhRDFWw4GAsEfoYe
        7/4eOWPcl66cnKcIrsenu37p6dMUshQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628785481;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O1P5cfCreQpHbUvjnHSmGavypkvtu0Fv9JV7GTmIvDs=;
        b=zt8ZO1+IZNaXQV/OlENgwdECaPRSnbY+rqdwobgWPQ40IdDnnpRDfIQp9d8kItrTBaa3rn
        6aOd0QR3QyY+8RDg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 7555713ACC;
        Thu, 12 Aug 2021 16:24:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 7X+TG0lLFWHEAQAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Thu, 12 Aug 2021 16:24:41 +0000
Subject: Re: [PATCH v14 074/138] mm/writeback: Add folio_clear_dirty_for_io()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-75-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <24a7db9a-0c61-44ec-3ffe-bd6462316a9a@suse.cz>
Date:   Thu, 12 Aug 2021 18:24:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210715033704.692967-75-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/15/21 5:36 AM, Matthew Wilcox (Oracle) wrote:
> Transform clear_page_dirty_for_io() into folio_clear_dirty_for_io()
> and add a compatibility wrapper.  Also move the declaration to pagemap.h
> as this is page cache functionality that doesn't need to be used by the
> rest of the kernel.
> 
> Increases the size of the kernel by 79 bytes.  While we remove a few
> calls to compound_head(), we add a call to folio_nr_pages() to get the
> stats correct for the eventual support of multi-page folios.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
