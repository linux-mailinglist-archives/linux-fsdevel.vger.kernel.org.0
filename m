Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2BE552DC4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jun 2022 11:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbiFUJAC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jun 2022 05:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiFUJAA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jun 2022 05:00:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1F362F6;
        Tue, 21 Jun 2022 01:59:58 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6E59621EFE;
        Tue, 21 Jun 2022 08:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655801997; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eUEOchQkf9x5e/yDFu3Cw69RvWgl2OREI1612saaUJc=;
        b=hhB3bGID15ObSnv+vpj4tfA3asH5XkoQyw1JwyYueuxBwfItcIepMAsHjsVSyVQHFTtoMo
        dLDoaMHYTcgWzmxCn1w4/HNJ5nc/HrxtXvWP3lCtyyK2bEi5MalqE93seFoBsZtruh+dlg
        RFssgRFtP8MqEzYiltByvy/fLi4Pb7k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655801997;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eUEOchQkf9x5e/yDFu3Cw69RvWgl2OREI1612saaUJc=;
        b=66wSKJj2EmFckhAw3sknT4WwhCws68vrJiDXAfC64IjSHgJZ7KdIcsASPJf3c6Hpb+ozqr
        j4hi66SXh5PqgUCg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5806B2C141;
        Tue, 21 Jun 2022 08:59:57 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id ED477A062B; Tue, 21 Jun 2022 10:59:56 +0200 (CEST)
Date:   Tue, 21 Jun 2022 10:59:56 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [POC][PATCH] xfs: reduce ilock contention on buffered randrw
 workload
Message-ID: <20220621085956.y5wyopfgzmqkaeiw@quack3.lan>
References: <20190407232728.GF26298@dastard>
 <CAOQ4uxgD4ErSUtbu0xqb5dSm_tM4J92qt6=hGH8GRc5KNGqP9A@mail.gmail.com>
 <20190408141114.GC15023@quack2.suse.cz>
 <CAOQ4uxhxgYASST1k-UaqfbLL9ERquHaKL2jtydB2+iF9aT8SRQ@mail.gmail.com>
 <20190409082605.GA8107@quack2.suse.cz>
 <CAOQ4uxgu4uKJp5t+RoumMneR6bw_k0CRhGhU-SLAky4VHSg9MQ@mail.gmail.com>
 <20220617151135.yc6vytge6hjabsuz@quack3>
 <CAOQ4uxjvx33KRSm-HX2AjL=aB5yO=FeWokZ1usDKW7+R4Ednhg@mail.gmail.com>
 <20220620091136.4uosazpwkmt65a5d@quack3.lan>
 <CAOQ4uxg+uY5PdcU1=RyDWCxbP4gJB3jH1zkAj=RpfndH9czXbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxg+uY5PdcU1=RyDWCxbP4gJB3jH1zkAj=RpfndH9czXbg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 21-06-22 10:49:48, Amir Goldstein wrote:
> > How exactly do you imagine the synchronization of buffered read against
> > buffered write would work? Lock all pages for the read range in the page
> > cache? You'd need to be careful to not bring the machine OOM when someone
> > asks to read a huge range...
> 
> I imagine that the atomic r/w synchronisation will remain *exactly* as it is
> today by taking XFS_IOLOCK_SHARED around generic_file_read_iter(),
> when reading data into user buffer, but before that, I would like to issue
> and wait for read of the pages in the range to reduce the probability
> of doing the read I/O under XFS_IOLOCK_SHARED.
> 
> The pre-warm of page cache does not need to abide to the atomic read
> semantics and it is also tolerable if some pages are evicted in between
> pre-warn and read to user buffer - in the worst case this will result in
> I/O amplification, but for the common case, it will be a big win for the
> mixed random r/w performance on xfs.
> 
> To reduce risk of page cache thrashing we can limit this optimization
> to a maximum number of page cache pre-warm.
> 
> The questions are:
> 1. Does this plan sound reasonable?

Ah, I see now. So essentially the idea is to pull the readahead (which is
currently happening from filemap_read() -> filemap_get_pages()) out from under
the i_rwsem. It looks like a fine idea to me.

> 2. Is there a ready helper (force_page_cache_readahead?) that
>     I can use which takes the required page/invalidate locks?

page_cache_sync_readahead() should be the function you need. It does take
care to lock invalidate_lock internally when creating & reading pages. I
just cannot comment on whether calling this without i_rwsem does not break
some internal XFS expectations for stuff like reflink etc.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
