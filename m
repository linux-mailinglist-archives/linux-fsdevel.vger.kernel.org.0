Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92CC269643A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Feb 2023 14:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbjBNNGj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Feb 2023 08:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbjBNNGg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Feb 2023 08:06:36 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A154D27991;
        Tue, 14 Feb 2023 05:06:33 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4917021E80;
        Tue, 14 Feb 2023 13:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676379992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t/WyduiwgFGGIrxKCM1jbAXGdU4yomecwQDiF7860eU=;
        b=UHHpolVy9IvE3Tz9YeLKmE1RHCzYWxqyuoz0CkrJKlbGglNQ/LDCv2vEjCiJ6G/Po2nl50
        etQ6Iqxod5yueABAorQAmkHxGkRBNI0s2u70uOamORpS70k0ZYo7mLke1Nko3vc+fR7OpS
        c4RxzF9waNnftoWU9eJpXbO6tcsL4fs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676379992;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t/WyduiwgFGGIrxKCM1jbAXGdU4yomecwQDiF7860eU=;
        b=dx5fO6ybyiOW5awrLEN7vfe53YeG3nevLopNOqwQGa/hMyWoIPAuqKUcgPIObMcjphyGPp
        VsdpVhusQ8L4qXDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B3BF2138E3;
        Tue, 14 Feb 2023 13:06:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id D9DXK1eH62M+LAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 14 Feb 2023 13:06:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 7FEE2A06D8; Tue, 14 Feb 2023 14:06:29 +0100 (CET)
Date:   Tue, 14 Feb 2023 14:06:29 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, John Hubbard <jhubbard@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 1/5] mm: Do not reclaim private data from pinned page
Message-ID: <20230214130629.hcnvwpgqzhc3ulgg@quack3>
References: <20230209121046.25360-1-jack@suse.cz>
 <20230209123206.3548-1-jack@suse.cz>
 <Y+Ucq8A+WMT0ZUnd@casper.infradead.org>
 <20230210112954.3yzlyi4hjgci36yn@quack3>
 <Y+oI+AYsADUZsB7m@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+oI+AYsADUZsB7m@infradead.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 13-02-23 01:55:04, Christoph Hellwig wrote:
> On Fri, Feb 10, 2023 at 12:29:54PM +0100, Jan Kara wrote:
> > functionally that would make sense but as I've mentioned in my reply to you
> > [1], the problem here is the performance. I've now dug out the discussion
> > from 2018 where John actually tried to take pinned pages out of the LRU [2]
> > and the result was 20% IOPS degradation on his NVME drive because of the
> > cost of taking the LRU lock. I'm not even speaking how costly that would
> > get on any heavily parallel direct IO workload on some high-iops device...
> 
> I think we need to distinguish between short- and long terms pins.
> For short term pins like direct I/O it doesn't make sense to take them
> off the lru, or to do any other special action.  Writeback will simplify
> have to wait for the short term pin.
> 
> Long-term pins absolutely would make sense to be taken off the LRU list.

Yeah, I agree distinguishing these two would be nice as we could treat them
differently then. The trouble is a bit with always-crowded struct page. But
now it occurred to me that if we are going to take these long-term pinned
pages out from the LRU, we could overload the space for LRU pointers with
the counter (which is what I think John originally did). So yes, possibly
we could track separately long-term and short-term pins. John, what do you
think? Maybe time to revive your patches from 2018 in a bit different form?
;)

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
