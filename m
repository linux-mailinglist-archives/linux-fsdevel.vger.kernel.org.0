Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9D951BB49
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 May 2022 10:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345275AbiEEJCT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 May 2022 05:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234570AbiEEJCS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 May 2022 05:02:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FBA4AE32
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 May 2022 01:58:38 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1FFF21F460;
        Thu,  5 May 2022 08:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651741117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6ZvMxhMSxDhFd60UKohso8OE5hMNukzJzBlYznqPb6E=;
        b=S9bLQMbcKOo8WcBUh95h9/TgyoI5TqKgYb78yNbNdt2Ce9su3ixAKkqjzXFD9Jn86Y5mlj
        JFaSNcOv3PFckpPtKpX9ZigRYD/m+jDpmWl5qSSjL3PU+FSsvIkuchCu+SSsykX0F+d9tC
        8iVHZv42g4zwQ/vI+RKVwdbskBESSJw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651741117;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6ZvMxhMSxDhFd60UKohso8OE5hMNukzJzBlYznqPb6E=;
        b=HGz/vAYq2nU98IzxOGYKWVLnUOaYg8CNLeaj72FBvja7YXQWYkLOB5f4U8QbKZDHOKANzg
        I/jdCJ0x9WIYEfBg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0D7452C141;
        Thu,  5 May 2022 08:58:37 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 882ACA0627; Thu,  5 May 2022 10:58:36 +0200 (CEST)
Date:   Thu, 5 May 2022 10:58:36 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, David Howells <dhowells@redhat.com>
Subject: Re: adding mount notification to fanotify?
Message-ID: <20220505085836.asvqonkv4efxugsk@quack3.lan>
References: <CAJfpegvq2yNtuFWOYWJ-QNGCXFni_SfunQLEQzrErNpjZ0Tk-w@mail.gmail.com>
 <CAOQ4uxjqu4Ca1LTr2d5wB791Hd2FitOUyXdMQa95O2ttEjW-Gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjqu4Ca1LTr2d5wB791Hd2FitOUyXdMQa95O2ttEjW-Gw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 05-05-22 08:41:09, Amir Goldstein wrote:
> On Thu, May 5, 2022 at 7:28 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > Here's David's patch, which introduces new infrastructure for this purpose:
> >
> > https://lore.kernel.org/all/158204559631.3299825.5358385352169781990.stgit@warthog.procyon.org.uk/
> >
> > I'm wondering if this could be added to fsnotify/fanotify instead?
> 
> I suppose we could.

I'm not so sure. We could definitely add fanotify event for changes in the
superblock (like watch for RO vs RW state, mount option changes, etc. of a
particular sb). However the general "was anything mounted/unmounted in the
subtree of this mount" seems to have rather different properties than
common fanotify events. For fanotify if would be natural to have events
like "was anything mounted on this dir?" or "was anything mounted on some
dir of this superblock?". Besides this philosophical objection,
communicating general "something got mounted in the subtree" through
fanotify has the problem that we would have hard time gathering and
reporting what has changed and where information - that would basically
require completely separate info structures attached to events. So there is
some overlap but I'm not sure it is large enough.

>  Speaking of David's patch, I think that getting
> fanotify events via watch_queue instead of read() could also be a nice
> improvement.

What would be advantages?

> > After all, the events are very similar, except it's changes to the
> > mount tree, not the dentry tree that need to be reported.
> >
> 
> There is already one precedent to event on mount tree change in fsnotify -
> inotify IN_UNMOUNT

Yes, events for superblock have precedent. But since fanotify is all build
around watches on objects, I'm not sure general mount notification really
fits well.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
