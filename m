Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783C56EA66F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 11:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjDUJBg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 05:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjDUJBa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 05:01:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35066181;
        Fri, 21 Apr 2023 02:01:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 87037210E6;
        Fri, 21 Apr 2023 09:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682067687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WNmeuisUtJOS0e4JRe3RCvMm6EO6FFE/WKAiRaEal/E=;
        b=K+/pMMgMT/1YH1mt+8+9/w2LZ2UD4mCFUAQ1YFU30rAC7mqVOevf8rGc8o17oPSFYr4vdz
        /i6m2+R4gGR/YhkSLr2womU1tMZhHX1apPj2dTsaT98wpMv/Tpfx/jxqba3JRUendTqmL1
        Q2R2IT3h05b0AtMLSTKtVzNiu+44O28=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682067687;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WNmeuisUtJOS0e4JRe3RCvMm6EO6FFE/WKAiRaEal/E=;
        b=IT9nCn+/Ipnkil5UxQDEd2Gknx3JGzCc+mmfcxUbFGvdAp0ttwT4QpaKfbQuUdv3uX/EAQ
        lpd2Nhg/eOGnTYBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6F64413456;
        Fri, 21 Apr 2023 09:01:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EjYjG+dQQmQrQQAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 21 Apr 2023 09:01:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id CD5DAA0729; Fri, 21 Apr 2023 11:01:26 +0200 (CEST)
Date:   Fri, 21 Apr 2023 11:01:26 +0200
From:   Jan Kara <jack@suse.cz>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [RFC PATCH 0/3] permit write-sealed memfd read-only shared
 mappings
Message-ID: <20230421090126.tmem27kfqamkdaxo@quack3>
References: <cover.1680560277.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1680560277.git.lstoakes@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi!

On Mon 03-04-23 23:28:29, Lorenzo Stoakes wrote:
> This patch series is in two parts:-
> 
> 1. Currently there are a number of places in the kernel where we assume
>    VM_SHARED implies that a mapping is writable. Let's be slightly less
>    strict and relax this restriction in the case that VM_MAYWRITE is not
>    set.
> 
>    This should have no noticeable impact as the lack of VM_MAYWRITE implies
>    that the mapping can not be made writable via mprotect() or any other
>    means.
> 
> 2. Align the behaviour of F_SEAL_WRITE and F_SEAL_FUTURE_WRITE on mmap().
>    The latter already clears the VM_MAYWRITE flag for a sealed read-only
>    mapping, we simply extend this to F_SEAL_WRITE too.
> 
>    For this to have effect, we must also invoke call_mmap() before
>    mapping_map_writable().
> 
> As this is quite a fundamental change on the assumptions around VM_SHARED
> and since this causes a visible change to userland (in permitting read-only
> shared mappings on F_SEAL_WRITE mappings), I am putting forward as an RFC
> to see if there is anything terribly wrong with it.

So what I miss in this series is what the motivation is. Is it that you need
to map F_SEAL_WRITE read-only? Why?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
