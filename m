Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A19669657E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Feb 2023 14:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbjBNN4t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Feb 2023 08:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbjBNN4s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Feb 2023 08:56:48 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCA176AB;
        Tue, 14 Feb 2023 05:56:16 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 168F31FE67;
        Tue, 14 Feb 2023 13:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676382965; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wEcL9ZqDcFReJTdiwk7aAbf7PWmErFH9naF5RkkLE+Y=;
        b=1L1VOwSuTzy4sqE98fsLQ35bRFPl2Zkt0E1OhCPN0qVtEgYi5BC/ul/22EOcDbiA5pB4/A
        oPW6+TvceVbc9yypZDxV2L3m1wpsOT+nj5PYCHAzwyq6F4kyxPdIcYM/HVlgTRmtXrDzoN
        AmUXwmFa6ky1OyB6ys71AVwtfEsIyOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676382965;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wEcL9ZqDcFReJTdiwk7aAbf7PWmErFH9naF5RkkLE+Y=;
        b=XqMBO5MLSMI5MJEF7FlkjGRdicMdFsJjbKPEeq7aYBVzx7OsKfrmUJWNfHbKWD4tC/1JWS
        cYzBTb3CtC/GQxDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 088EF138E3;
        Tue, 14 Feb 2023 13:56:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id h7ISAvWS62NHRAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 14 Feb 2023 13:56:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 9386FA06D8; Tue, 14 Feb 2023 14:56:04 +0100 (CET)
Date:   Tue, 14 Feb 2023 14:56:04 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        John Hubbard <jhubbard@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 4/5] block: Add support for bouncing pinned pages
Message-ID: <20230214135604.s5bygnthq7an5eoo@quack3>
References: <20230209121046.25360-1-jack@suse.cz>
 <20230209123206.3548-4-jack@suse.cz>
 <Y+oKAB/epmJNyDbQ@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+oKAB/epmJNyDbQ@infradead.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 13-02-23 01:59:28, Christoph Hellwig wrote:
> Eww.  The block bounc code really needs to go away, so a new user
> makes me very unhappy.
> 
> But independent of that I don't think this is enough anyway.  Just
> copying the data out into a new page in the block layer doesn't solve
> the problem that this page needs to be tracked as dirtied for fs
> accounting.  e.g. every time we write this copy it needs space allocated
> for COW file systems.

Right, I forgot about this in my RFC. My original plan was to not clear the
dirty bit in clear_page_dirty_for_io() even for WB_SYNC_ALL writeback when
we do writeback the page and perhaps indicate this in the return value of
clear_page_dirty_for_io() so that the COW filesystem can keep tracking this
page as dirty.

> Which brings me back to if and when we do writeback for pinned page.
> I don't think doing any I/O for short term pins like direct I/O
> make sense.  These pins are defined to be unpinned after I/O
> completes, so we might as well just wait for the unpin instead of doing
> anything complicated.

Agreed. For short term pins we could just wait which should be quite
simple (although there's some DoS potential of this behavior if somebody
runs multiple processes that keep pinning some page with short term pins).

> Long term pins are more troublesome, but I really wonder what the
> defined semantics for data integrity writeback like fsync on them
> is to start with as the content is very much undefined.  Should
> an fsync on a (partially) long term pinned file simplfy fail?  It's
> not like we can win in that scenario.

Well, we have also cases like sync(2) so one would have to be careful with
error propagation and I'm afraid there are enough programs out-there that
treat any error return from fsync(2) as catastrophic so I suspect this
could lead to some surprises. The case I'm most worried about is if some
application sets up RDMA to an mmaped file, runs the transfer and waits for
it to complete, doesn't bother to unpin the pages (keeps them for future
transfers) and calls fsync(2) to make data stable on local storage. That
does seem like quite sensible use and so far it works just fine. And not
writing pages with fsync(2) would break such uses.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
