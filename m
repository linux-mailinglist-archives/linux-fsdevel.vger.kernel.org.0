Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDE5531208
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 May 2022 18:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238171AbiEWPtr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 May 2022 11:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238172AbiEWPto (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 May 2022 11:49:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B343C736
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 May 2022 08:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=k7lfc53khnUp5WjIao4kSlHMBTeUyv9VgFHSYwKAcm8=; b=vmY9jvtTTcSibpHn0O1Y0UtBCQ
        QPQGB0b2GYvoNA5Wb4i2uipcRdRNC0Bo6c2KuYFnBIsyjh6b8YaomzaLz/kbakw6Z7GhDtCQkltzI
        AEtZcQcFXgHLca/5khJ0kpeNlAI0hlQu8kAD89796CX+unbEQVp6pqB1oBW31U/LFq05s1hclCZ3Z
        n++vTWV2C9SROghDweNKCp+2v/p2wx0p5QnDfD57ABblaaGdQYdZeHEGLCEa2QV9VndmTJOFs0inX
        z52CbSvQmZixGs/LFrjfA0e2weryXJT5oFG/D/IBD67GZCUppi7wez7DuhbxCsVC22Cxdw0KVzLca
        ub8m2y1Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ntAJO-00GHgW-Ln; Mon, 23 May 2022 15:49:38 +0000
Date:   Mon, 23 May 2022 16:49:38 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] what to do with IOCB_DSYNC?
Message-ID: <YoutEnMCVdwlzboT@casper.infradead.org>
References: <YorYeQpW9nBJEeSx@zeniv-ca.linux.org.uk>
 <290daf40-a5f6-01f8-0764-2f4eb96b9d40@kernel.dk>
 <22de2da8-7db0-68c5-2c85-d752a67f9604@kernel.dk>
 <9c3a6ad4-cdb5-8e0d-9b01-c2825ea891ad@kernel.dk>
 <6ea33ba8-c5a3-a1e7-92d2-da8744662ed9@kernel.dk>
 <YouYvxEl1rF2QO5K@zeniv-ca.linux.org.uk>
 <0343869c-c6d1-5e7c-3bcb-f8d6999a2e04@kernel.dk>
 <YoueZl4Zx0WUH3CS@zeniv-ca.linux.org.uk>
 <6594c360-0c7c-412f-29c9-377ddda16937@kernel.dk>
 <f74235f7-8c55-8def-9a3f-bc5bacd7ee3c@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f74235f7-8c55-8def-9a3f-bc5bacd7ee3c@kernel.dk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 23, 2022 at 09:44:12AM -0600, Jens Axboe wrote:
> On 5/23/22 9:12 AM, Jens Axboe wrote:
> >> Current branch pushed to #new.iov_iter (at the moment; will rename
> >> back to work.iov_iter once it gets more or less stable).
> > 
> > Sounds good, I'll see what I need to rebase.
> 
> On the previous branch, ran a few quick numbers. dd from /dev/zero to
> /dev/null, with /dev/zero using ->read() as it does by default:
> 
> 32      260MB/sec
> 1k      6.6GB/sec
> 4k      17.9GB/sec
> 16k     28.8GB/sec
> 
> now comment out ->read() so it uses ->read_iter() instead:
> 
> 32      259MB/sec
> 1k      6.6GB/sec
> 4k      18.0GB/sec
> 16k	28.6GB/sec
> 
> which are roughly identical, all things considered. Just a sanity check,
> but looks good from a performance POV in this basic test.
> 
> Now let's do ->read_iter() but make iov_iter_zero() copy from the zero
> page instead:
> 
> 32      250MB/sec
> 1k      7.7GB/sec
> 4k      28.8GB/sec
> 16k	71.2GB/sec
> 
> Looks like it's a tad slower for 32-bytes, considerably better for 1k,
> and massively better at page size and above. This is on an Intel 12900K,
> so recent CPU. Let's try cacheline and above:
> 
> Size	Method			BW		
> 64	copy_from_zero()	508MB/sec
> 128	copy_from_zero()	1.0GB/sec
> 64	clear_user()		513MB/sec
> 128	clear_user()		1.0GB/sec

See this thread-of-doom:

https://lore.kernel.org/all/Ynq1nVpu1xCpjnXm@zn.tnic/
