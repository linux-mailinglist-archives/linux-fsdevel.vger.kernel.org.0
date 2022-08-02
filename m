Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D1A587EF6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Aug 2022 17:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236017AbiHBP3M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Aug 2022 11:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiHBP3L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Aug 2022 11:29:11 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBED23A
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 Aug 2022 08:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=H5h1BM9+VYmh+LGNPDQQetO1oxAe8Rzg/UP66GQ7BV0=; b=GmFNPGJtHGmmZbTGWHxISHmr20
        laXQdQHtGdkiSErl7h/J6GNnsjccpvhCjV2sDnUmfMPrEBK+pgAHdIpsgvfpd4/KYU8nG2rxyo2dl
        g0RFHyj9zNa+EWczbQuSY6KbZFN8q1EvHnXBHo20s79Lve0znYTZMPkWaX//pe7A+Uc9OG7VKH4Nr
        uAmXn9xVBfYqw6+bKA3uQL5nmgqazwFBCy7oPLX0rmcFduRXiLgYRBbBAF1HsiHF4baHDwKjOPUER
        MyrTRBV5iZjN6xGHLCtKXfd1S+ZG8+Ng/8Z9xweT97Migkj7IdU/7xqwz6d0yrnYU6zpij594MubK
        WLFbpcMQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oItpU-000aqv-5Y;
        Tue, 02 Aug 2022 15:29:08 +0000
Date:   Tue, 2 Aug 2022 16:29:08 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        syzbot+942d5390db2d9624ced8@syzkaller.appspotmail.com
Subject: Re: [PATCH] vfs_getxattr_alloc(): don't allocate buf on failure
Message-ID: <YulCxLl76A/vsu4/@ZenIV>
References: <20220802144236.1481779-1-mszeredi@redhat.com>
 <Yuk+32FgLeu6koHV@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yuk+32FgLeu6koHV@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 02, 2022 at 04:12:31PM +0100, Al Viro wrote:
> On Tue, Aug 02, 2022 at 04:42:36PM +0200, Miklos Szeredi wrote:
> > Some callers of vfs_getxattr_alloc() assume that on failure the allocated
> > buffer does not need to be freed.
> > 
> > Callers could be fixed, but fixing the semantics of vfs_getxattr_alloc() is
> > simpler and makes sure that this class of bugs does not occur again.
> > 
> > Reported-and-tested-by: syzbot+942d5390db2d9624ced8@syzkaller.appspotmail.com
> > Fixes: 1601fbad2b14 ("xattr: define vfs_getxattr_alloc and vfs_xattr_cmp")
> > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > ---
> >  fs/xattr.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/xattr.c b/fs/xattr.c
> > index e8dd03e4561e..1800cfa97411 100644
> > --- a/fs/xattr.c
> > +++ b/fs/xattr.c
> > @@ -383,7 +383,10 @@ vfs_getxattr_alloc(struct user_namespace *mnt_userns, struct dentry *dentry,
> >  	}
> >  
> >  	error = handler->get(handler, dentry, inode, name, value, error);
> > -	*xattr_value = value;
> > +	if (error < 0 && value != *xattr_value)
> > +		kfree(value);
> > +	else
> > +		*xattr_value = value;
> >  	return error;
> >  }
> 
> Think what happens if it had been called with non-NULL *xattr_value,
> found that it needed realloc, had krealloc() succeed (and free the
> original), only to fail in ->get().
> 
> Your variant will leave *xattr_value pointing to already freed
> object, with no way for the caller to tell that from failure before
> it got to krealloc().
> 
> IOW, that's unusable for callers with preallocated buffer - in
> particular, ones that call that thing in a loop.

FWIW, if we change calling conventions so that in some cases caller
need not kfree() whatever's in *xattr_value, about the only variant
I see is to have the damn thing freed and replaced with NULL on
*all* failure exits.  Might or might not make sense, not sure...
