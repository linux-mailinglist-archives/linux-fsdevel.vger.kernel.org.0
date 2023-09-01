Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9090E78F9F1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Sep 2023 10:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344776AbjIAIXd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Sep 2023 04:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236869AbjIAIXc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Sep 2023 04:23:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C86D193;
        Fri,  1 Sep 2023 01:23:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CBCAF1F45E;
        Fri,  1 Sep 2023 08:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693556604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lM2jFMiCbU/7Z0Wt66YsVsUtlY4aIj0FUbivaBixA/c=;
        b=zT4zGINVx2k3wPqz3jcmE9bmJBpBcsDBUwenKzhLerIp+oH2aCkG4+EXh39zRNryjQv5Db
        syu8c53NOsHAVW9SIMV7rmXaawFxBmlGIS7oN+eGtRpy7NQAkXpdI57c9wkvRp8eiDiXja
        uA4epJ/r7clJCygmuQc278PsV8l56iM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693556604;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lM2jFMiCbU/7Z0Wt66YsVsUtlY4aIj0FUbivaBixA/c=;
        b=ZsrMXAmASwR20bAW12DsiBEXD871qEuKP0anx4duKH2O41WOTWfcG8WLKUJiaYTSgmrfs1
        lQlapOLm5eLYniDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3A66A1358B;
        Fri,  1 Sep 2023 08:23:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BOk4DXyf8WREHQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 01 Sep 2023 08:23:24 +0000
Message-ID: <2d9312bf-a5ad-0427-c197-fef6ea5cfe0a@suse.cz>
Date:   Fri, 1 Sep 2023 10:23:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RFC PATCH v11 10/29] mm: Add AS_UNMOVABLE to mark mapping as
 completely unmovable
To:     Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Fuad Tabba <tabba@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        David Hildenbrand <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>
References: <20230718234512.1690985-1-seanjc@google.com>
 <20230718234512.1690985-11-seanjc@google.com>
 <20230725102403.xywjqlhyqkrzjok6@box.shutemov.name>
 <ZL/Fa4W2Ne9EVxoh@casper.infradead.org>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <ZL/Fa4W2Ne9EVxoh@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/25/23 14:51, Matthew Wilcox wrote:
> On Tue, Jul 25, 2023 at 01:24:03PM +0300, Kirill A . Shutemov wrote:
>> On Tue, Jul 18, 2023 at 04:44:53PM -0700, Sean Christopherson wrote:
>> > diff --git a/mm/compaction.c b/mm/compaction.c
>> > index dbc9f86b1934..a3d2b132df52 100644
>> > --- a/mm/compaction.c
>> > +++ b/mm/compaction.c
>> > @@ -1047,6 +1047,10 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>> >  		if (!mapping && (folio_ref_count(folio) - 1) > folio_mapcount(folio))
>> >  			goto isolate_fail_put;
>> >  
>> > +		/* The mapping truly isn't movable. */
>> > +		if (mapping && mapping_unmovable(mapping))
>> > +			goto isolate_fail_put;
>> > +
>> 
>> I doubt that it is safe to dereference mapping here. I believe the folio
>> can be truncated from under us and the mapping freed with the inode.
>> 
>> The folio has to be locked to dereference mapping safely (given that the
>> mapping is still tied to the folio).
> 
> There's even a comment to that effect later on in the function:
> 
>                         /*
>                          * Only pages without mappings or that have a
>                          * ->migrate_folio callback are possible to migrate
>                          * without blocking. However, we can be racing with
>                          * truncation so it's necessary to lock the page
>                          * to stabilise the mapping as truncation holds
>                          * the page lock until after the page is removed
>                          * from the page cache.
>                          */
> 
> (that could be reworded to make it clear how dangerous dereferencing
> ->mapping is without the lock ... and it does need to be changed to say
> "folio lock" instead of "page lock", so ...)
> 
> How does this look?
> 
>                         /*
>                          * Only folios without mappings or that have
>                          * a ->migrate_folio callback are possible to
>                          * migrate without blocking. However, we can
>                          * be racing with truncation, which can free
>                          * the mapping.  Truncation holds the folio lock
>                          * until after the folio is removed from the page
>                          * cache so holding it ourselves is sufficient.
>                          */

Incorporated to my attempt at a fix (posted separately per the requested
process):

https://lore.kernel.org/all/20230901082025.20548-2-vbabka@suse.cz/
