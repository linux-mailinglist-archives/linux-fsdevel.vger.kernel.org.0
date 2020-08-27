Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1E72544B7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 14:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbgH0MEK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 08:04:10 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:32919 "EHLO
        lizzy.crudebyte.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728802AbgH0MDP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 08:03:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=ogtPstPb1ulPuI+MYe+qZECIvcAeCa391mfvHOfGfkA=; b=ZwFo6cbsDqEAfz2cw82t5t4izF
        XgWb0vjQDE9ltxFK8Wdsxf45Rb9uaHekr9v3yJY0TxkcYFfv4EQlJ4QckL2pUt6AvcxNqiSS7UaK7
        xDsjqADgO3MrC6X7RRlUTcknIZnZaWV3hp+eHm2GnTJXwXcJahzGHQj8SqZ4QE27+IsqjKNgMsdL8
        jbM5D+RZCNtbgXgGeu5YKfrXj2r4V1yRSe4jKjPsFkd/qZdeWNdWCY/aZOIFi5RYS9y+O/wNWeGS7
        X/aAUMJicsrFDNAF5w27RbHIXxuvM75WwRoU9ikDWVF1ijpYc+YvpNUGJuP35odD/imaeqzK6sTvz
        BTf3nXmA==;
From:   Christian Schoenebeck <qemu_oss@crudebyte.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Frank van der Linden <fllinden@amazon.com>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Greg Kurz <groug@kaod.org>, linux-fsdevel@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: Re: file forks vs. xattr (was: xattr names for unprivileged stacking?)
Date:   Thu, 27 Aug 2020 14:02:42 +0200
Message-ID: <1803870.bTIpkxUbEX@silver>
In-Reply-To: <CAJfpegt9Pmj9k-qAaKxcBOjTNtV5XsTYa+C0s9Ui9W13R-dv8g@mail.gmail.com>
References: <20200824222924.GF199705@mit.edu> <3918915.AdkhnqkaGN@silver> <CAJfpegt9Pmj9k-qAaKxcBOjTNtV5XsTYa+C0s9Ui9W13R-dv8g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Dienstag, 25. August 2020 17:32:15 CEST Miklos Szeredi wrote:
> On Tue, Aug 25, 2020 at 5:12 PM Christian Schoenebeck
> 
> <qemu_oss@crudebyte.com> wrote:
> > I can give you another argument which might be more convincing to you: say
> > you maintain a middleware lib that takes a path as argument somewhere,
> > and that lib now gets path="/foo//bar". How could that lib judge whether
> > it should a) eliminate the double slash, or rather b) it was really meant
> > to be fork "bar" of file "foo" and hence shall pass the string as-is to
> > underlying
> > framework(s)? Simply: It can't, as it requires knowledge from either upper
> > or lower end that the lib in the middle might not have.
> 
> Nobody needs to care, only the level that actually wants to handle the
> alternative namespace.  And then that level absolutely *must* call
> into a level that it knows does handle the alternative namespace.
> 
> Yeah, it's not going to suddenly start to  work by putting "foo//bar"
> into an open file dialogue or whatever.   That's not the point, adding
> that  new interface is to enable *new* functionality not to change
> existing functionality.  That's the point that people don't seem to
> get.

I think you are underestimating the negative impact an n-times-slash delimiter 
would introduce. Middleware functionalities rely on unumbiguous path name 
resolution for being able to transform pathes without asking another level how 
it shall a) parse and b) interpret individual components of a path.

It would not be as simple as saying, they are now broken, let's fix them. 
Because path transformations happen so often on all levels on any system, that 
if you'd introduce a dependency for that (i.e. a simple path transformation 
would need to ask e.g. a storage backend for help), then it would slow down 
overall performance tremendously, especially as such requests are typically 
non-deterministic.

E.g. it is very common for a middleware function to transform a path into a 
list, and "/a/b//c/d" would now be ambiguous:

    "/a/b//c/d" -> [ "a", "b", "c", "d" ]

    or

    "/a/b//c/d" -> [ "a", "b", [ "c", "d" ] ]

You can't simply pass either one option to the next level, because it would 
break behaviour:

    foreach (dir_entry in [ "a", "b", "c", "d" ]) {
        dirAction(dir_entry)
    }

is different than:

    foreach (dir_entry in [ "a", "b" ]) {
        dirAction(dir_entry)
        foreach (fork_entry in [ "c", "d" ]) {
            forkAction(fork_entry)
        }
    }

Hence that simple path transformation would need to ask for help to resolve 
the ambiguity, which might take anything between few microseconds up to 
several seconds, then multiply that duration with the common amount of 
individual path transformations involved in just a very simple task.

---

What I could imagine as delimiter instead; slash-caret:

    /var/foo.pdf/^/forkname

I also like Microsoft's colon pick, as it would make shell interactions more 
slick:

	/var/foo.pdf:forkname

However I am aware that the colon would probably be too drastic, as colons are 
often used to separate individual pathes in a list for instance.

> > > The most important thing, I think, is to not fragment the interface
> > > further.  So O_ALT should allow not just one application (like ADS)
> > > but should have a top level directory for selecting between the
> > > various data sources.
> > 
> > Well, that's what name spaces are for IMO. So you would probably reserve
> > some prefixes for system purposes, like it is already done for Linux
> > xattrs. Or do you see any advantage for adding a dedicated directory
> > layer in between instead?
> 
> You mean some reserved prefixes for ADS?  Bleh.
> 
> No, xattr is not the model we should be following.

Maybe. I am actually unresolved about that. As that fs meta info PR recently 
showed, there might be other future use cases for this interface that one 
probably cannot foresee today; and a dedicated toplevel directory to choose 
between them would also make the kernel internal bindings more clean. So you 
might have for instance:

	/var/foo.pdf/^/alt/forkname   # for common ADS (incl. macOS data forks)

	/var/foo.pdf/^/res/forkname   # for mapping macOS resource forks

	/var/foo.pdf/^/meta/forkname  # for accessing fs implementation info

Best regards,
Christian Schoenebeck


