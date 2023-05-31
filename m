Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7CD71848A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 16:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237630AbjEaOQg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 10:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237599AbjEaOQX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 10:16:23 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD2910EB;
        Wed, 31 May 2023 07:14:02 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f60b3f32b4so43223525e9.1;
        Wed, 31 May 2023 07:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685542385; x=1688134385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NXtfwCo398mNssja20yM7iI6aJ4z57XXGeGmgzDUvNw=;
        b=n83+i8eMwzD3kMQ/bOt8MUs50SBqqTJsdCejDBgqUeHkdZGxkr9lzs1RzZvqfh4VOg
         41IbkrcZobs2SmPtO/ik1OGA1Bbf9m9omBPizRY1kqn+yP7GGOAVwlzGP73ep1WpzL9f
         9FnRiwY6dRMBx3uLp0TGTtyQA4GGn6tc/6nOa/N4mO3aS0Sx70Hr9nD2dxXTd16Q19nw
         qPEmd7A7mdZglKoQWfh6NcJXfSt0wK2oIsvyoly9xhJd9pigGJq4KdQHBsmeU7mrYbln
         OPXrHY/tptYvQKh0ARk95ILnsfslZ7pT97oVhFibaFa2v3DqoItnNt80zLqgaqyDZdUj
         wRmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685542385; x=1688134385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NXtfwCo398mNssja20yM7iI6aJ4z57XXGeGmgzDUvNw=;
        b=c8nngrsfZRsgIuS+qxKspumk5XACzPEyIGU+XmsElXJAurShuP5nG1Tmzj7HbtJBF1
         DV8+qnQNHoYUjjLFFd9xEhqmvVNXpx9l2t3lCDFJd6NMOSM/6JmRbYjXxGBDEIKv0IFR
         lt+Vi+zYc6McO3IlF5Aoc4dXd3/kKcY2m/BR7YhgYVCmCbuiEz9srOw2/auM0vssfHNs
         oQEjRRZlliDOki9vQtHMzNhRrCjsPYVVYc6Ydp9TmFAMb0RQLoKyBIa2tnQXlO+UML9X
         fneQeaV93GfKa+/Pkm87ocvu2Utw+nsT5z1etjCRC0hrZm5QSFtvjB13jTZMxaJkWnB8
         tL0A==
X-Gm-Message-State: AC+VfDz6GZK7bK1qSNrMt356iEoqS4CayumB5T20wdMHX6GbogwWloBI
        dmvrhUw2yUoYzr/IC7nhdPU=
X-Google-Smtp-Source: ACHHUZ5/jVczCOvTj0ujwU2RCL/cBkmLhK9+lxiAtMwXxjwFb/GUIB70AgI7OmEAsM0Ry99cY2cWUA==
X-Received: by 2002:a05:600c:22d6:b0:3eb:42fc:fb30 with SMTP id 22-20020a05600c22d600b003eb42fcfb30mr4400956wmg.32.1685542384560;
        Wed, 31 May 2023 07:13:04 -0700 (PDT)
Received: from localhost (host81-154-179-160.range81-154.btcentralplus.com. [81.154.179.160])
        by smtp.gmail.com with ESMTPSA id x11-20020a1c7c0b000000b003f50876905dsm20954539wmc.6.2023.05.31.07.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 07:13:03 -0700 (PDT)
Date:   Wed, 31 May 2023 15:10:53 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     David Howells <dhowells@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4 1/3] mm: Don't pin ZERO_PAGE in pin_user_pages()
Message-ID: <0e307b3f-d367-4bb2-9506-93a3d70b3e97@lucifer.local>
References: <492558dc-1377-fc4b-126f-c358bb000ff7@redhat.com>
 <cbd39f94-407a-03b6-9c43-8144d0efc8bb@redhat.com>
 <20230526214142.958751-1-dhowells@redhat.com>
 <20230526214142.958751-2-dhowells@redhat.com>
 <510965.1685522152@warthog.procyon.org.uk>
 <703628.1685541335@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <703628.1685541335@warthog.procyon.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 31, 2023 at 02:55:35PM +0100, David Howells wrote:
> David Hildenbrand <david@redhat.com> wrote:
>
> > Yes, it would be clearer if we would be using "pinned" now only for FOLL_PIN
>
> You're not likely to get that.  "To pin" is too useful a verb that gets used
> in other contexts too.  For that reason, I think FOLL_PIN was a poor choice of
> name:-/.  I guess the English language has got somewhat overloaded.  Maybe
> FOLL_PEG? ;-)
>

Might I suggest FOLL_FOLL? As we are essentially 'following' the page once
'pinned'. We could differentiate between what is currently FOLL_GET and
FOLL_PIN by using FOLL_FOLL and FOLL_FOLL_FOLL.

Patch series coming soon...

> > and everything else is simply "taking a temporary reference on the page".
>
> Excluding refs taken with pins, many refs are more permanent than pins as, so
> far as I'm aware, pins only last for the duration of an I/O operation.
>
> > >> "Note that the refcount of any zero_pages returned among the pinned pages will
> > >> not be incremented, and unpin_user_page() will similarly not decrement it."
> > > That's not really right (although it happens to be true), because we're
> > > talking primarily about the pin counter, not the refcount - and they may be
> > > separate.
> >
> > In any case (FOLL_PIN/FOLL_GET) you increment/decrement the refcount. If we
> > have a separate pincount, we increment/decrement the refcount by 1 when
> > (un)pinning.
>
> FOLL_GET isn't relevant here - only FOLL_PIN.  Yes, as it happens, we count a
> ref if we count a pin, but that's kind of irrelevant; what matters is that the
> effect must be undone with un-PUP.
>
> It would be nice not to get a ref on the zero page in FOLL_GET, but I don't
> think we can do that yet.  Too many places assume that GUP will give them a
> ref they can release later via ordinary methods.
>
> David
>
