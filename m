Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F3268083F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jan 2023 10:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236117AbjA3JLh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Jan 2023 04:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235594AbjA3JLg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Jan 2023 04:11:36 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9452F9F
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jan 2023 01:11:35 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6CF0768BEB; Mon, 30 Jan 2023 10:11:32 +0100 (CET)
Date:   Mon, 30 Jan 2023 10:11:32 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH 05/12] erofs: drop posix acl handlers
Message-ID: <20230130091132.GA5178@lst.de>
References: <20230125-fs-acl-remove-generic-xattr-handlers-v1-0-6cf155b492b6@kernel.org> <20230125-fs-acl-remove-generic-xattr-handlers-v1-5-6cf155b492b6@kernel.org> <20230130064329.GF31145@lst.de> <20230130090008.zg5ddfanrgeommrv@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130090008.zg5ddfanrgeommrv@wittgenstein>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 30, 2023 at 10:00:08AM +0100, Christian Brauner wrote:
> > > +	if (xattr_dentry_list(handler, dentry))
> > > +		name = xattr_prefix(handler);
> > 
> > I'm not a huge fan of all this duplicate logic in the file systems
> > that is more verbose and a bit confusing.  Until we remove the
> 
> Yeah, it hasn't been my favorite part about this either.
> But note how the few filesystems that receive that change use the same
> logic by indexing an array and retrieving the handler and then clumsily
> open-coding the same check that is now moved into xattr_dentry_list().

At least it allows for an array lookup.  And of course switching
to xattr_dentry_list instead of open coding it is always a good idea.

> If we want the exact same logic to be followed as today then we need to
> keep the dummy struct posix_acl_{access,default}_xattr_handler around.
> I tried to avoid that for the first version because it felt a bit
> disappointing but we can live with this. This way there's zero code changes
> required for filesystems that use legacy array-based handler-indexing.

Yes, I'd just leave those as-is using the handlers.  I don't really
like the result, but the changes in the series doesn't really look
better and causes extra churn.  In the long run struct xattr_handler
needs to go away and we'll need separate handlers for each type
of xattrs, but that's going to take a while.  Do you know where the
capabilities conversion is standing?

> But we should probably still tweak this so that all these filesystems don't
> open-code the !h || (h->list && !h->list(dentry) check like they do now. So
> something like what I did below at [1]. Thoughts?

Yes, that part is useful.

> +static inline const char *erofs_xattr_prefix(unsigned int idx, struct dentry *dentry)

Overly long line here, though.
