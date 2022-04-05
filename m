Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D725E4F45B9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 00:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346071AbiDENev (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Apr 2022 09:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377046AbiDENMq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Apr 2022 09:12:46 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65A2120DA3;
        Tue,  5 Apr 2022 05:12:51 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 81BE01F7AE;
        Tue,  5 Apr 2022 12:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649160770;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/iIK4IU6j3+Uo5l6+7LzbpsQLqXq+AMjHPYQVXiK+s0=;
        b=nyDFnzsydFaAJRoydrXbuGhbN1CuPAs6b94/8t/8QhRfZOBjATR/JtQEr0PKFcwYWnCVVP
        vVHRRuPcTKMWtOjKUkYxStbCyI7lJAidHB7/BKugFEOBxmY8G7GSVqzmlrrxdy7pQC9IOy
        sOR0SQyVSaNtgdZBZlCjtjgGpwoGu68=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649160770;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/iIK4IU6j3+Uo5l6+7LzbpsQLqXq+AMjHPYQVXiK+s0=;
        b=PRDmohv2bqg2SiWHds2qJ7AS5EgCW6hoUEYX9gRBElZsIqcxpo8xCIJKDnhYBPyDVBx7Lu
        mnmQbDvljuT36RCQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 7921BA3B92;
        Tue,  5 Apr 2022 12:12:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4ECCDDA80E; Tue,  5 Apr 2022 14:08:49 +0200 (CEST)
Date:   Tue, 5 Apr 2022 14:08:48 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [GIT PULL] Folio fixes for 5.18
Message-ID: <20220405120848.GV15609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
References: <YkdKgzil38iyc7rX@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkdKgzil38iyc7rX@casper.infradead.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 01, 2022 at 07:54:59PM +0100, Matthew Wilcox wrote:
> A mixture of odd changes that didn't quite make it into the original
> pull and fixes for things that did.  Also the readpages changes had to
> wait for the NFS tree to be pulled first.
> 
> The following changes since commit d888c83fcec75194a8a48ccd283953bdba7b2550:
> 
>   fs: fix fd table size alignment properly (2022-03-29 23:29:18 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/users/willy/pagecache.git tags/folio-5.18d
> 
> for you to fetch changes up to 5a60542c61f3cce6e5dff2a38c8fb08a852a517b:
> 
>   btrfs: Remove a use of PAGE_SIZE in btrfs_invalidate_folio() (2022-04-01 14:40:44 -0400)

Matthew, can you please always CC linux-btrfs@vger.kernel.org for any
patches that touch code under fs/btrfs? I've only noticed your folio
updates in this pull request. Some of the changes are plain API switch,
that's fine but I want to know about that, some changes seem to slightly
modify logic that I'd really like to review and there are several missed
opportunities to fix coding style. Thanks.
