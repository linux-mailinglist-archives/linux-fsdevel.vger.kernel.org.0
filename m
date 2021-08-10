Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4093D3E7D18
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 18:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbhHJQE5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 12:04:57 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49436 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhHJQE5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 12:04:57 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6FC862206A;
        Tue, 10 Aug 2021 16:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628611474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+9hOZdmGXF7uPz0UrOXyZ72hX+fcy1HDX0c3Fsbxfqo=;
        b=F8Ybk1/d5s7NGQ2OACApxGGPjSYj8MIhrKA3Ho8AEIHDYlFeOayuX9OURfIRPdpyQQZYmR
        ZqJ5nam597n1+rahglZ9Jy5yGt9v+pGv1TC6VR2B5mwqzYXhAAeRUiN3doGBnoR04OC5MS
        OBRX0s5Y70i5pVIOxfs9yV7PVgOluxM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628611474;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+9hOZdmGXF7uPz0UrOXyZ72hX+fcy1HDX0c3Fsbxfqo=;
        b=QwypvChq2ShHegLeWuyOUNAHOEL0UWnX9W33H3l8B4h4bSF19JOB5t1tYZ+VtZUzVWhuuD
        8FXCiFus+PFDH2Dg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 4EAE5137DA;
        Tue, 10 Aug 2021 16:04:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id J+eSEpKjEmEeTAAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Tue, 10 Aug 2021 16:04:34 +0000
Subject: Re: [PATCH v14 017/138] mm/filemap: Add folio_unlock()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        William Kucharski <william.kucharski@oracle.com>,
        David Howells <dhowells@redhat.com>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-18-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <8e1fe292-937d-87d2-1c36-8ff5c30bfefe@suse.cz>
Date:   Tue, 10 Aug 2021 18:04:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210715033704.692967-18-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/15/21 5:35 AM, Matthew Wilcox (Oracle) wrote:
> Convert unlock_page() to call folio_unlock().  By using a folio we
> avoid a call to compound_head().  This shortens the function from 39
> bytes to 25 and removes 4 instructions on x86-64.  Because we still
> have unlock_page(), it's a net increase of 16 bytes of text for the
> kernel as a whole, but any path that uses folio_unlock() will execute
> 4 fewer instructions.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Layton <jlayton@kernel.org>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> Reviewed-by: David Howells <dhowells@redhat.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
