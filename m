Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D853419EB1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 20:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235818AbhI0Szh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 14:55:37 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60960 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235804AbhI0Szg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 14:55:36 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3B9511FF71;
        Mon, 27 Sep 2021 18:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632768837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i8YFrJJL3ygDjTHfhpq/hMFm7t3mtPppxrHwThWiRyE=;
        b=Ye7n1C/Gtiaw0lIGnDPPVjtS2+5wNp0fzQmY/qzeSw29Jz0vJLCx3BpQ09/Mj02MxM2bvj
        3oqwKnjSrXl8o/sXq2prfyd6MoHeiqz8WnffQ8C0a54znwnnFUN9laIi1omboDqV+3fW2u
        6T9ZcBcyNW0cN8uSekz6pNJphQLMoAs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632768837;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i8YFrJJL3ygDjTHfhpq/hMFm7t3mtPppxrHwThWiRyE=;
        b=HzQWu9YFVJihCFVRftrGHi4rgdEJv5g5cGIdHYYwFULRH3DRXpIvstpZUIJ81ovtmmL7Pf
        Ds9xg/jp8pvZ4SCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7900613BF2;
        Mon, 27 Sep 2021 18:53:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WHTIG0ATUmHXNwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 27 Sep 2021 18:53:52 +0000
Message-ID: <df6ad8ab-b3a9-6264-e699-28422a74f995@suse.cz>
Date:   Mon, 27 Sep 2021 20:53:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: Struct page proposal
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
References: <YUvWm6G16+ib+Wnb@moria.home.lan>
 <bc22b4d0-ba63-4559-88d9-a510da233cad@suse.cz>
 <YVIH5j5xkPafvNds@casper.infradead.org> <YVII7eM7P42riwoI@moria.home.lan>
 <YVIJg+kNqqbrBZFW@casper.infradead.org>
 <b57911a4-3963-aa65-1f8e-46578b3c0623@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <b57911a4-3963-aa65-1f8e-46578b3c0623@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/27/2021 8:16 PM, David Hildenbrand wrote:
> On 27.09.21 20:12, Matthew Wilcox wrote:
>>
>> But the thing we're allocating is at least PAGE_SIZE bytes in size.
>> Why is "We should avoid storing anything in the free page itself" true?
>>
> 
> Immediately comes to mind:
> * Free page reporting via virtio-balloon
> * CMA on s390x (see arch_free_page())
> * Free page poisoning
> * init_on_free

I was thinking of debug_pagealloc (unmaps free pages from direct map) but yeah,
the list is longer.


