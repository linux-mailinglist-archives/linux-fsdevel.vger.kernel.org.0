Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C92523EA991
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 19:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236320AbhHLRhk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 13:37:40 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51322 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbhHLRhk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 13:37:40 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C1ABA22258;
        Thu, 12 Aug 2021 17:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628789833; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rtvikXvVzhf77pjK9DX6g9U2RJhd2kjezc1u1IrW7D0=;
        b=jsvWY403o1qR2yyFGI0LQZYk1erQXkl0GHfrYzrPmFOLKEdReDDgLKaenzLnZMa5/Fclog
        XjOzsWREdkRGd8a9F13RFKaHNMGSFjv8pFTg4yp6wzHZCXvjaZJHw6/zPUMwIKIpcCiaMN
        rK2hCXjnT4xKb6eoK0W1/gUfo43jA5c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628789833;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rtvikXvVzhf77pjK9DX6g9U2RJhd2kjezc1u1IrW7D0=;
        b=YIp8Up3ObmAebni6fHUvyUd6o31EV6p+p8IHj51NHWAuEE9N5YpBJz9HXbtB/dIIhCxl6s
        TY5H/wb70mSpVoCw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 9E9A013AC3;
        Thu, 12 Aug 2021 17:37:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id oC8/JUlcFWHoEQAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Thu, 12 Aug 2021 17:37:13 +0000
Subject: Re: [PATCH v14 087/138] mm/filemap: Convert mapping_get_entry to
 return a folio
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-88-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <e3278134-172a-e7ff-ca59-84d671fc7d47@suse.cz>
Date:   Thu, 12 Aug 2021 19:37:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210715033704.692967-88-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/15/21 5:36 AM, Matthew Wilcox (Oracle) wrote:
> The pagecache only contains folios, so indicate that this is definitely
> not a tail page.  Shrinks mapping_get_entry() by 56 bytes, but grows
> pagecache_get_page() by 21 bytes as gcc makes slightly different hot/cold
> code decisions.  A net reduction of 35 bytes of text.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
