Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1CB3EA642
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 16:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237905AbhHLOLr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 10:11:47 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:34398 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236028AbhHLOLq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 10:11:46 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5905B1FF47;
        Thu, 12 Aug 2021 14:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628777480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ltG9XPJTgXiAW64Yau60CHRwOU6O3fnGzP+EX5Voqfk=;
        b=ozwUzeBE3l7fsgaGC33rWU3XVDMUss29nM4ATaect5WZF8zBa+Wwq7Q7O+iitx+zIMYGE+
        LNAqO2PEQqzit9I2z0RIBjqrGdaSXffcGufjO0obyB8LLsZymeU4Cnnx0ScFJVvLRXL0Cs
        VAjrSY40522Hu7QXzs+GZcwYnskwOQg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628777480;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ltG9XPJTgXiAW64Yau60CHRwOU6O3fnGzP+EX5Voqfk=;
        b=sRXs1GKSGD6V2LMvRw105RYLEhIXcS02ZAvmjVaHJHZaorfkY8SMNk97ZDQVjnSKDU5ds5
        go0G+lyqKOa3cbDA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 3B55E13A90;
        Thu, 12 Aug 2021 14:11:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id S6FEDQgsFWFzXwAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Thu, 12 Aug 2021 14:11:20 +0000
Subject: Re: [PATCH v14 067/138] mm/writeback: Add folio_start_writeback()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-68-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <9efcf51a-0375-6942-aadb-a83699eca456@suse.cz>
Date:   Thu, 12 Aug 2021 16:11:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210715033704.692967-68-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/15/21 5:35 AM, Matthew Wilcox (Oracle) wrote:
> Rename set_page_writeback() to folio_start_writeback() to match
> folio_end_writeback().  Do not bother with wrappers that return void;
> callers are perfectly capable of ignoring return values.
> 
> Add wrappers for set_page_writeback(), set_page_writeback_keepwrite() and
> test_set_page_writeback() for compatibililty with existing filesystems.
> The main advantage of this patch is getting the statistics right,
> although it does eliminate a couple of calls to compound_head().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
