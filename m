Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E764C4EC8E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 17:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348485AbiC3P5j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 11:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344260AbiC3P5i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:57:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A403411172;
        Wed, 30 Mar 2022 08:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HMOfcZjpKd4HXdTf9ncMsCYUAoRwb/T1kB389y4bGdM=; b=vGlnpbNoOXVcnZwa9UF4XeaYjg
        WhSwj4N324o9z4cmAPpBHKLuGFaSQDMnT2YLY1wfdVblptnzehIXDuv9lkPIlElrn2MrE7VX7Glft
        UACY82x8M8Jv6swJSFUDw7eh4N+BahXF+TuslARHWS8UJQqPM+YPM8gcr6yZa32K49JMRWPeJL+z5
        PX0lW2IbmXB+otVjy8FmuXPTYqXNiQHPtYVvcNvP02ykgn7Kk2sHeYMjQbJ1QTfY99WjV9cRWRtnJ
        GqqqB2jqMAzL0gJ2pAsmJnSEVnlL60AGLGdKckmYakWKDAttkG47zhFguWE7IYditonyLJoTItjnH
        Dp600qZg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZafi-00Gh5T-DI; Wed, 30 Mar 2022 15:55:46 +0000
Date:   Wed, 30 Mar 2022 08:55:46 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Ashish Sangwan <a.sangwan@samsung.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: writeback completion soft lockup BUG in folio_wake_bit()
Message-ID: <YkR9gu4Ye2uydkTd@infradead.org>
References: <YjDj3lvlNJK/IPiU@bfoster>
 <YjJPu/3tYnuKK888@casper.infradead.org>
 <CAHk-=wgPTWoXCa=JembExs8Y7fw7YUi9XR0zn1xaxWLSXBN_vg@mail.gmail.com>
 <YjNN5SzHELGig+U4@casper.infradead.org>
 <CAHk-=wiZvOpaP0DVyqOnspFqpXRaT6q53=gnA2psxnf5dbt7bw@mail.gmail.com>
 <YjOlJL7xwktKoLFN@casper.infradead.org>
 <20220318131600.iv7ct2m4o52plkhl@quack3.lan>
 <CAHk-=wiky+cT7xF_2S94ToEjm=XNX73CsFHaQJH3tzYQ+Vb1mw@mail.gmail.com>
 <YjYDaBnN36zggeGa@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjYDaBnN36zggeGa@mit.edu>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 19, 2022 at 12:23:04PM -0400, Theodore Ts'o wrote:
> So the thing that I've been waiting to do for a while is to replace
> the whole data=ordered vs data=writeback and dioread_nolock and
> dioread_lock is a complete reworking of the ext4 buffered writeback
> path, where we write the data blocks *first*, and only then update the
> ext4 metadata.

> *) Determining where the new allocated data blockblocks should be, and
>    preventing those blocks from being used for any other purposes, but
>    *not* updating the file system metadata to reflect that change.
> 
> *) Submit the data block write
> 
> *) On write completion, update the metadata blocks in a kernel thread.

I think that would be easily done by switching to the iomap buffered
I/O code, which is very much built around that model.
