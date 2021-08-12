Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0F833EA9C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 19:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236945AbhHLRs6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 13:48:58 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52570 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbhHLRs5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 13:48:57 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 991BA221F8;
        Thu, 12 Aug 2021 17:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628790511; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nt13wCC1vTCNH5LpjxYew01TnAzZbKvQXsUqzFCe7IU=;
        b=pDbunGNVt4PAAzII8myrj+MEsYwGrC+ERYPFticrMA3x4bH3XG5yS/G0/Ik2NbU9ZSMN53
        z7rkkGMKgkEDOPNtK1thM4w4iYB0i7LPde98MQ2ZfND0x9t5M9BTM0D7mDtd/uyg4w6bgJ
        ja5Z46DgzQ+BqdlBnhVrqCuUo/Slu6M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628790511;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nt13wCC1vTCNH5LpjxYew01TnAzZbKvQXsUqzFCe7IU=;
        b=4XC//al3bI2/RnL8kSyIQe+zllUq5N4zyhl1Pi6nvx3BNT/3cwcJX5D/5ChmDB5u6kqIKO
        YW5SWMUgTla47BBA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 7D94313AC3;
        Thu, 12 Aug 2021 17:48:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id yoJfHe9eFWE1FAAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Thu, 12 Aug 2021 17:48:31 +0000
Subject: Re: [PATCH v14 089/138] mm/filemap: Add FGP_STABLE
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-90-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <98fae935-a50c-c604-82de-2dab5e18b6b0@suse.cz>
Date:   Thu, 12 Aug 2021 19:48:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210715033704.692967-90-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/15/21 5:36 AM, Matthew Wilcox (Oracle) wrote:
> Allow filemap_get_folio() to wait for writeback to complete (if the
> filesystem wants that behaviour).  This is the folio equivalent of
> grab_cache_page_write_begin(), which is moved into the folio-compat
> file as a reminder to migrate all the code using it.  This paves the
> way for getting rid of AOP_FLAG_NOFS once grab_cache_page_write_begin()
> is removed.
> 
> Kernel grows by 11 bytes.  filemap_get_folio() grows by 33 bytes but
> grab_cache_page_write_begin() shrinks by 22 bytes to make up for it.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
