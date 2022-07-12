Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4824572399
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jul 2022 20:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234548AbiGLStx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jul 2022 14:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234635AbiGLStY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jul 2022 14:49:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F03D1C93
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jul 2022 11:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=YJXP41T52yQeXQcvcmpiXYKAyU8zLvvEIDy9GLrYKsM=; b=RrU5IeMnbPa2GbG5c2wun3zl5d
        Mo3pUzv8IqMgvFCMwQFHS7eFkHaAEn/EUHi5MwjV5RedQKcuIqgX5yoGRBK3njgfK1bMB3qnBsNsu
        Wg0AyyFYMsvevKXULWSb7Fyny+x6g5u3+U/63mbGSreWehl8vf7uQylH83Rky8hUkDjjmZP/e+NZi
        g7FhIm40gTRCE4o08fPyKBGC5Njbvj5bJ81kUonEfrtEErKUtFwehVdgvF/od76U4g+/29OP62+me
        gz9tvFmJBXX5w4RW1MsKFqoypBYfqgAvPY+EQ4hTvMGmk7vp+edZIFLSnCq7VfjfEzCoQ2dYZD6o+
        iKE76zsg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oBKr9-007CeZ-Bd; Tue, 12 Jul 2022 18:43:35 +0000
Date:   Tue, 12 Jul 2022 19:43:35 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     ansgar.loesser@kom.tu-darmstadt.de,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Amir Goldstein <amir73il@gmail.com>,
        Mark Fasheh <mark@fasheh.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Security Officers <security@kernel.org>,
        Max Schlecht <max.schlecht@informatik.hu-berlin.de>,
        =?iso-8859-1?Q?Bj=F6rn?= Scheuermann 
        <scheuermann@kom.tu-darmstadt.de>
Subject: Re: Information Leak: FIDEDUPERANGE ioctl allows reading writeonly
 files
Message-ID: <Ys3A16T3hwe9M+T2@casper.infradead.org>
References: <a7c93559-4ba1-df2f-7a85-55a143696405@tu-darmstadt.de>
 <CAHk-=wjrOgiWfN2uWf8Ajgr4SjeWMkEJ1Sd=H6pnS_JLjJwTcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wjrOgiWfN2uWf8Ajgr4SjeWMkEJ1Sd=H6pnS_JLjJwTcQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 12, 2022 at 10:33:01AM -0700, Linus Torvalds wrote:
> [ Adding random people who get blamed for lines in this remap_range
> thing to the participants ]
> 
> On Tue, Jul 12, 2022 at 5:11 AM Ansgar Lößer
> <ansgar.loesser@tu-darmstadt.de> wrote:
> >
> > using the deduplication API we found out, that the FIDEDUPERANGE ioctl
> > syscall can be used to read a writeonly file.
> 
> So I think your patch is slightly wrong, but I think this is worth
> fixing - just likely differently.

I'm going to leave discussing the permissions aspect to the experts in
that realm, but from a practical point of view, why do we allow the dedupe
ioctl to investigate arbitrary byte ranges?  If you're going to dedupe,
it has to be block aligned (both start and length).  If we enforce that
in the ioctl, this attack becomes impractical (maybe you can investigate
512-byte blobs of an 8192-bit key, but we seem to max out at 4096-bit
keys before switching to a fundamentally harder algorithm).
