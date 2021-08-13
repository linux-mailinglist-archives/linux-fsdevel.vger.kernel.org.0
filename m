Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFE063EB2AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Aug 2021 10:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238823AbhHMIds (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Aug 2021 04:33:48 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50696 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbhHMIdr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Aug 2021 04:33:47 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C47FF222D4;
        Fri, 13 Aug 2021 08:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628843599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0jCWY77+gLyatOQ2sRYjPfd4/tyo+rtSXinShJm80Yg=;
        b=1LAo713+1rwwurHUZRYb0hJJ4VPxRKGiBO/AEPBwJWLQlS6GJUiC5IN4qQ6R9BJFGtbuKU
        KLId8EK8UFSZJ6JWlDQdJJyeN8jDfJv5COq5nP49ezWfsb9w/UQU0IUFkVZXkrkYC16z7k
        +ne5XNbJBEyBfP/SepnlhzcCXFwsjAI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628843599;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0jCWY77+gLyatOQ2sRYjPfd4/tyo+rtSXinShJm80Yg=;
        b=ZXkH/0TK1osuPRTSHHAzIS5QiT17rC+cCSK2MwjRBJplWQb68Z+gJm5bklxfVBPslHn1KH
        XKsqMWfysXeRoUDw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id B276A1396D;
        Fri, 13 Aug 2021 08:33:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id P9sCK08uFmF0PQAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Fri, 13 Aug 2021 08:33:19 +0000
Subject: Re: [PATCH v14 062/138] mm/migrate: Add folio_migrate_copy()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-63-willy@infradead.org>
 <b9c3038a-56af-95e9-b5dd-8e88f508719e@suse.cz>
 <YRXyGg7MWZTLA+YU@casper.infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <c33999ee-64ce-cf00-a457-66fb6b90a64d@suse.cz>
Date:   Fri, 13 Aug 2021 10:33:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YRXyGg7MWZTLA+YU@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/13/21 6:16 AM, Matthew Wilcox wrote:
> On Thu, Aug 12, 2021 at 01:56:24PM +0200, Vlastimil Babka wrote:
>> On 7/15/21 5:35 AM, Matthew Wilcox (Oracle) wrote:
>> > This is the folio equivalent of migrate_page_copy(), which is retained
>> > as a wrapper for filesystems which are not yet converted to folios.
>> > Also convert copy_huge_page() to folio_copy().
>> > 
>> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>> 
>> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>> 
>> The way folio_copy() avoids cond_resched() for single page would IMHO deserve a
>> comment though, so it's not buried only in this thread.
> 
> I think folio_copy() deserves kernel-doc.
> 
> /**
>  * folio_copy - Copy the contents of one folio to another.
>  * @dst: Folio to copy to.
>  * @src: Folio to copy from.
>  *
>  * The bytes in the folio represented by @src are copied to @dst.
>  * Assumes the caller has validated that @dst is at least as large as @src.
>  * Can be called in atomic context for order-0 folios, but if the folio is
>  * larger, it may sleep.
>  */
> 
LGTM.
