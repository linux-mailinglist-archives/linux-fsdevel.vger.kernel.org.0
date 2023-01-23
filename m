Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2FBF67840E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 19:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbjAWSFB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 13:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233860AbjAWSE6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 13:04:58 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87682421F;
        Mon, 23 Jan 2023 10:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iWZSqyep+LoaN2x9iOc1JSYDPdPJNUsznCO3NspXGyk=; b=MFqEjza85xfw3v2CnoXNvNjgwX
        XaVQEpG/4doVDAQhGDrJv6SuNU1FfCKn25IBY7gq8wFFL0YFXFBvPZJPciEryqLEG0sljMmmwYFpj
        cjIHKD+tQaf6enO18RDrJ1xP2ap7rB460NbfmrsxSmdszZMgybgSqf8aAbscdHwF0QNji5MRAtXlK
        Isr0Gzgh4IJVG8xXBKeYi5afLtpKGoLCSr+1vWQ507Ouwrk+yl1IHbwHg/gZd5qmCjnVdAFDn5xUO
        gGxlGq5m00n/IIWuolmnYaRIW0KXpGNfa5SFgblRL0H1xa14hWFMDqIzWm//7YmlxFLrVvAv+cLS8
        WAODFETA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pK1BS-004QK3-Pn; Mon, 23 Jan 2023 18:04:43 +0000
Date:   Mon, 23 Jan 2023 18:04:42 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/8] iov_iter: Improve page extraction (ref, pin or
 just list)
Message-ID: <Y87MOoXsBMy/RJ63@casper.infradead.org>
References: <Y865EIsHv3oyz+8U@casper.infradead.org>
 <Y862ZL5umO30Vu/D@casper.infradead.org>
 <20230120175556.3556978-1-dhowells@redhat.com>
 <318138.1674491927@warthog.procyon.org.uk>
 <324815.1674494391@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <324815.1674494391@warthog.procyon.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 23, 2023 at 05:19:51PM +0000, David Howells wrote:
> Matthew Wilcox <willy@infradead.org> wrote:
> 
> > > Wouldn't that potentially make someone's entire malloc() heap entirely NOCOW
> > > if they did a single DIO to/from it.
> > 
> > Yes.  Would that be an actual problem for any real application?
> 
> Without auditing all applications that do direct I/O writes, it's hard to
> say - but a big database engine, Oracle for example, forking off a process,
> say, could cause a massive slow down as fork suddenly has to copy a huge
> amount of malloc'd data unnecessarily[*].
> 
> [*] I'm making wild assumptions about how Oracle's DB engine works.

Yes.  The cache is shared between all Oracle processes, so it's not COWed.
Indeed (as the mshare patches show), what Oracle wants is _more_ sharing
between the processes, not _less_.

> > > Also you only mention DIO read - but what about "start DIO write; fork();
> > > touch buffer" in the parent - now the write buffer belongs to the child
> > > and they can affect the parent's write.
> > 
> > I'm struggling to see the problem here.  If the child hasn't exec'd, the
> > parent and child are still in the same security domain.  The parent
> > could have modified the buffer before calling fork().
> 
> It could still inadvertently change the data its parent set to write out.  The
> child *shouldn't* be able to change the parent's in-progress write.  The most
> obvious problem would be in something that does DIO from a stack buffer, I
> think.

If it's a problem then O_DIRECT writes can also set the NOCOW flag.
