Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 125EE3E8CAF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 10:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236320AbhHKI6q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 04:58:46 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:36992 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234568AbhHKI6p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 04:58:45 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C08CA1FEAF;
        Wed, 11 Aug 2021 08:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628672301; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d95fm1Mc+V7vY5Yxcw83zu4yFAdtfpX8CP9valakjYQ=;
        b=H6zImDqHUdh5nQQUQqFs0lGsMBeotc6M2Iapp8KDLhDAXPg/X/v4rM9CnPGbXjS1PTyB4T
        156112GUncUNtIaJTN3G27Qda6/j6GXl6Ki5ufC8bOX4jt6PTHT+Y7TGwYWMwB9n6g99RK
        E3nSmwNcztN6V5UdRhH5YTjJGLlTIBM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628672301;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d95fm1Mc+V7vY5Yxcw83zu4yFAdtfpX8CP9valakjYQ=;
        b=tRkHhChRQ1KR9UXlEP8vOmAOV+UgcuuI41G5vJJgu+79LsONbmVfRzDzZtOHKX0iiFG8QW
        tDnL9OktMZyqlzBg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id A216E136D9;
        Wed, 11 Aug 2021 08:58:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id JHTrJi2RE2FweAAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Wed, 11 Aug 2021 08:58:21 +0000
Subject: Re: [PATCH v14 011/138] mm/lru: Add folio LRU functions
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Yu Zhao <yuzhao@google.com>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-12-willy@infradead.org>
 <91fb7d5b-9f5f-855e-2c87-dab105d5c977@suse.cz>
 <YRK6y5s8T3qd38G1@casper.infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <3af5a403-2eb9-cc87-f76d-cbbefe5bc82a@suse.cz>
Date:   Wed, 11 Aug 2021 10:58:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YRK6y5s8T3qd38G1@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/10/21 7:43 PM, Matthew Wilcox wrote:
> On Tue, Aug 10, 2021 at 06:01:16PM +0200, Vlastimil Babka wrote:
>> Actually looking at the git version, which has also this:
>> 
>>  static __always_inline void update_lru_size(struct lruvec *lruvec,
>>                                 enum lru_list lru, enum zone_type zid,
>> -                               int nr_pages)
>> +                               long nr_pages)
>>  {
>> 
>> Why now and here? Some of the functions called from update_lru_size()
>> still take int so this looks arbitrary?
> 
> I'm still a little freaked out about the lack of warning for:
> 
> void f(long n);
> void g(unsigned int n) { f(-n); }
> 
> so I've decided that the count of pages in a folio is always of type
> long.  The actual number is positive, and currently it's between 1 and
> 1024 (inclusive on both bounds), so it's always going to be
> representable in an int.  Narrowing it doesn't cause a bug, so we don't
> need to change nr_pages anywhere, but it does no harm to make functions
> take a long instead of an int (it may even cause slightly better code
> generation, based on the sample of functions I've looked at).
> 
> Maybe changing update_lru_size() in this patch is wrong.  I can drop it
> if you like.

It's fine, knowing it wasn't some rebasing error.
