Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2343E7CFA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 18:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239203AbhHJQBm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 12:01:42 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48992 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239168AbhHJQBl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 12:01:41 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 14F9322069;
        Tue, 10 Aug 2021 16:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628611278; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oCRKUveE33VvcZMJL2XnwneZOV742TksTwb3FEBahsM=;
        b=T+BoxSbgtruUXzJbuimf79cKwQ8YblfGeaVl6NlwHHvNVCX1ET1707rrLhseItDqI5QKKv
        49yogIW1pIrkWiXBr5tjZ/mTHGp8bL/AbDGnK3fBxL4i/m8zx2ro888PClvHo67EW6hqdt
        qp/S2tnKignm0KJSkYP+RA+szTkooMs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628611278;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oCRKUveE33VvcZMJL2XnwneZOV742TksTwb3FEBahsM=;
        b=D0JRzRyOU3Hm1PxLBc+KyqIa2waelCCd+hvILDxPW+CQIuVV3uwseBnATR7ldEjY7+jpj9
        Mt9ZjvdRuTOCKrBg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id E8896137DA;
        Tue, 10 Aug 2021 16:01:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id D70YOM2iEmF2SwAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Tue, 10 Aug 2021 16:01:17 +0000
Subject: Re: [PATCH v14 011/138] mm/lru: Add folio LRU functions
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>, Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-12-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <91fb7d5b-9f5f-855e-2c87-dab105d5c977@suse.cz>
Date:   Tue, 10 Aug 2021 18:01:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210715033704.692967-12-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/15/21 5:34 AM, Matthew Wilcox (Oracle) wrote:
> Handle arbitrary-order folios being added to the LRU.  By definition,
> all pages being added to the LRU were already head or base pages, but
> call page_folio() on them anyway to get the type right and avoid the
> buried calls to compound_head().
> 
> Saves 783 bytes of kernel text; no functions grow.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Yu Zhao <yuzhao@google.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: David Howells <dhowells@redhat.com>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Actually looking at the git version, which has also this:

 static __always_inline void update_lru_size(struct lruvec *lruvec,
                                enum lru_list lru, enum zone_type zid,
-                               int nr_pages)
+                               long nr_pages)
 {

Why now and here? Some of the functions called from update_lru_size()
still take int so this looks arbitrary?

