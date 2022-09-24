Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F3B5E8D5C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Sep 2022 16:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbiIXOhK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Sep 2022 10:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbiIXOhJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Sep 2022 10:37:09 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F66B441C
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Sep 2022 07:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OocmR+ND18vsBzbq0vVV2IWlWaJvX+ya5EpokqkvB+4=; b=tnxrBN3ykSZJ/YQCpppzIfomfH
        UwVuTBTSuLoEhnY+hhgd1PmOs79e0UlS1aGBCnLZ50JKLaGUN0x40W1+RpqOkd2NLiOE/zPKEAps4
        gZ25eORhQA/iNCFOWAv8edByPPzZo0DHjK/p5VmFxZiwNmrSTm7BgGO1h6ZHNYv/VpmlDr4UVY0JT
        RNCKT0Lji2Jx+YXyaBe28RBzMnY7KtcJchDXbKUjvCAJ5DbqashkcpIbeJiCK6zHTHGg9HdA3fOQh
        pmcv0g5KHa9ua0tZ9oe7ILTEj4p5aYhGqSXcyeMuhmOAmd46Tu/Cdr9eBiYgCzCpDXbjalA6HzJMs
        XKUkGj/A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oc6HA-003Keo-30;
        Sat, 24 Sep 2022 14:37:05 +0000
Date:   Sat, 24 Sep 2022 15:37:04 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: Re: [PATCH v4 04/10] cachefiles: only pass inode to
 *mark_inode_inuse() helpers
Message-ID: <Yy8WELM+xEYhD/kU@ZenIV>
References: <20220922084442.2401223-1-mszeredi@redhat.com>
 <20220922084442.2401223-5-mszeredi@redhat.com>
 <YyyLyY3TUG6IaU3Y@ZenIV>
 <CAJfpegsEi8VSZOXJDbFatvHsKMjuXPCm42GApRG_s1EZobdCAg@mail.gmail.com>
 <Yy6OASz8zZIpBRNk@ZenIV>
 <CAJfpegv39g--QB=ks9oFRajbCveO+q0nwH3caZz1_Sw4TLiNww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegv39g--QB=ks9oFRajbCveO+q0nwH3caZz1_Sw4TLiNww@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 24, 2022 at 07:02:19AM +0200, Miklos Szeredi wrote:
> On Sat, 24 Sept 2022 at 06:56, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Fri, Sep 23, 2022 at 05:42:01PM +0200, Miklos Szeredi wrote:
> > > On Thu, 22 Sept 2022 at 18:22, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > > I would rather leave unobfuscating that to a separate patch,
> > > > if not a separate series, but since you are touching
> > > > cachefiles_unmark_inode_in_use() anyway, might as well
> > > > get rid of if (inode) in there - it's equivalent to if (true).
> > >
> > > Okay, pushed updated version (also with
> > > cachefiles_do_unmark_inode_in_use() un-open-coding) to:
> > >
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#fuse-tmpfile-v5
> >
> > OK...  I can live with that.  Could you
> > replace
> >         cachefiles_do_unmark_inode_in_use(object, file_inode(file));
> > with
> >         cachefiles_do_unmark_inode_in_use(object, inode);
> > in there and repush?  Or I could do cherry-pick and fix it up...
> 
> Done.  Head is now:
> 
> 7d37539037c2 ("fuse: implement ->tmpfile()")

Merged and pushed out.
