Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A035B7B6712
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 13:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239984AbjJCLDC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 07:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239983AbjJCLDA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 07:03:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8397DD;
        Tue,  3 Oct 2023 04:02:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 700AB2189A;
        Tue,  3 Oct 2023 11:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696330975; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eHdsnnP4BvSQvEhgo909hDKlWY49tL1RfeBhW4GH4Rg=;
        b=w4/+rG+49ABLgvSvYzOWWxX2mU3m9amiEr8Vi07XDHsRiVNVQPXLog84IpurnjqHoAEcun
        d63grMdUHUhBDrftNyXydzosdU8wirz2PM+u+Aa86RnoElcb+mcTgG0S2iYj5dhvEKkxL7
        SAv9jEsMn5uraEqrcKhzehGEJGoCR7k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696330975;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eHdsnnP4BvSQvEhgo909hDKlWY49tL1RfeBhW4GH4Rg=;
        b=D9V4mhDDV5Dz1HErZmvYdJgIfh6pQpYKtvG2DVRKGcYzkxzK3zYWS/nmkZf4wDh/I906eA
        NY76KibgSNgv3EBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5F464139F9;
        Tue,  3 Oct 2023 11:02:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Zx9EF9/0G2X8cwAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 03 Oct 2023 11:02:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B169AA07CB; Tue,  3 Oct 2023 13:02:54 +0200 (CEST)
Date:   Tue, 3 Oct 2023 13:02:54 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: Re: [PATCH 02/10] ext2: Convert ext2_check_page to ext2_check_folio
Message-ID: <20231003110254.vewb7a5hyxohbz45@quack3>
References: <20230921200746.3303942-1-willy@infradead.org>
 <20230921200746.3303942-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921200746.3303942-2-willy@infradead.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 21-09-23 21:07:39, Matthew Wilcox (Oracle) wrote:
> Support in this function for large folios is limited to supporting
> filesystems with block size > PAGE_SIZE.  This new functionality will only
> be supported on machines without HIGHMEM, so the problem of kmap_local
> only being able to map a single page in the folio can be ignored.
> We will not use large folios for ext2 directories on HIGHMEM machines.

A look like a fool replying to the same patch multiple times ;) but how is
this supposed to work even without HIGHMEM? Suppose we have a page size 4k
and block size 16k. Directory entries in a block can then straddle 4k
boundary so if kmap_local() is mapping only a single page, then we are
going to have hard time parsing this all?

Oh, I guess you are pointing to the fact kmap_local_folio() gives you back
address usable for the whole folio access if !HIGHMEM. But then all the
iterations (e.g. in ext2_readdir()) has to be folio-size based and not
page-size based as they currently are? You didn't change these iterations
in your patches which has confused me...

								Honza 

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
