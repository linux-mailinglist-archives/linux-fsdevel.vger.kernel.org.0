Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18BA56780FF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 17:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbjAWQLX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 11:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjAWQLW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 11:11:22 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F3F2A176;
        Mon, 23 Jan 2023 08:11:16 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 03ED134142;
        Mon, 23 Jan 2023 16:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674490275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8yYf8wXkZ38Zo4et7x7UJVytFRxZegivrpGgXCLUEzE=;
        b=OjaJjWOMfa0hg31leW1LGDU+0Ur2Xa4pcr/1cTfws0QY+wjl28J7ppK3+B57yYzHMs11WR
        1jEHwwpTNHF8LtxJ+SSOpZvDlYk5FW++u93lbPeW04mO0l25VquT9F+WaPJMnh/WQEzd9m
        Pa3pu7bpwaQGTb2Puu9WhSXQZTvOk/k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674490275;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8yYf8wXkZ38Zo4et7x7UJVytFRxZegivrpGgXCLUEzE=;
        b=NGI+aSwtmD7fxvxgKZD0kKf6SuwPMFO33eaGBuSv6+IzKQzxG/cDju0/uoVWrGKk5mUeJ1
        yM7OxKxIcpbZG5DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DF660134F5;
        Mon, 23 Jan 2023 16:11:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kZOCNqKxzmMNbgAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 23 Jan 2023 16:11:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 47543A06B5; Mon, 23 Jan 2023 17:11:14 +0100 (CET)
Date:   Mon, 23 Jan 2023 17:11:14 +0100
From:   Jan Kara <jack@suse.cz>
To:     David Howells <dhowells@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org
Subject: Re: [PATCH v7 2/8] iov_iter: Add a function to extract a page list
 from an iterator
Message-ID: <20230123161114.4jv6hnnbckqyrurs@quack3>
References: <c742e47b-dcc0-1fef-dc8c-3bf85d26b046@redhat.com>
 <7bbcccc9-6ebf-ffab-7425-2a12f217ba15@redhat.com>
 <246ba813-698b-8696-7f4d-400034a3380b@redhat.com>
 <20230120175556.3556978-1-dhowells@redhat.com>
 <20230120175556.3556978-3-dhowells@redhat.com>
 <3814749.1674474663@warthog.procyon.org.uk>
 <3903251.1674479992@warthog.procyon.org.uk>
 <3911637.1674481111@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3911637.1674481111@warthog.procyon.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 23-01-23 13:38:31, David Howells wrote:
> David Hildenbrand <david@redhat.com> wrote:
> 
> > That would be the ideal case: whenever intending to access page content, use
> > FOLL_PIN instead of FOLL_GET.
> > 
> > The issue that John was trying to sort out was that there are plenty of
> > callsites that do a simple put_page() instead of calling
> > unpin_user_page(). IIRC, handling that correctly in existing code -- what was
> > pinned must be released via unpin_user_page() -- was the biggest workitem.
> > 
> > Not sure how that relates to your work here (that's why I was asking): if you
> > could avoid FOLL_GET, that would be great :)
> 
> Well, it simplifies things a bit.
> 
> I can make the new iov_iter_extract_pages() just do "pin" or "don't pin" and
> do no ref-getting at all.  Things can be converted over to "unpin the pages or
> doing nothing" as they're converted over to using iov_iter_extract_pages()
> from iov_iter_get_pages*().
> 
> The block bio code then only needs a single bit of state: pinned or not
> pinned.

I'm all for using only pin/unpin in the end. But you'd still need to handle
the 'put' for the intermediate time when there are still FOLL_GET users of
the bio infrastructure, wouldn't you?

> For cifs RDMA, do I need to make it pass in FOLL_LONGTERM?  And does that need
> a special cleanup?

FOLL_LONGTERM doesn't need a special cleanup AFAIK. It should be used
whenever there isn't reasonably bound time after which the page is
unpinned. So in case CIFS sets up RDMA and then it is up to userspace how
long the RDMA is going to be running it should be using FOLL_LONGTERM. The
thing is that pins can block e.g. truncate for DAX inodes and so longterm
pins are not supported for DAX backed pages.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
