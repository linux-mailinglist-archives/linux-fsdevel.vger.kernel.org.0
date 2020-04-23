Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3541B5C62
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 15:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbgDWNU6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 09:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728183AbgDWNU5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 09:20:57 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DF5C08ED7D
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2020 06:20:57 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id r2so5482882ilo.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2020 06:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NgS2H/D6EFVvTgVCCRzMf0kZXkLuo7JGo1bOkKa4VT4=;
        b=tXHk9KyW4695SjgQh6Gf5ACKijIKr4ExQm2aGyvyaSiH2lLWOJvTiGW1WUVVctTYPX
         4OFK9aiX6pSBVHNm5vehFA9nFKY49p1yBac9tl+pVVJo7zpt4Ts2/q4/6f//NmZUJhri
         A4bWwwh0IrvE3QZnOw+sf2r2TSWsPhs+YmPlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NgS2H/D6EFVvTgVCCRzMf0kZXkLuo7JGo1bOkKa4VT4=;
        b=ngDx9kXp7fKZ3PVA/1ZI/JNj0UNoez8wjPzgswE7EqVXrXVA1pf3AUGXT8F698oTfQ
         1BzTqD17J8jloTmPm9P4y9YcXZcJ+lR2r2wMWPfgKjO4AkG932v50qcd8u7slX4SOx9I
         hbQ49+M1UkfAfWxgSwyzoJ3E1/qkUpyF4AzThyZXlqCrJEjzAZTPavkhMkZG0o2otVNT
         sRUy/E6LllMLggtgEq6SjQJ/NcGFOxvG6GTWELRcrX4reDRC0K1XmKCeT4muUeslK8cU
         L2NyQc9AxoNF3DyKLDUDpVMHutpcapaditrkBWRenK+zfycnHXWv9Kg6Kieu/+iGxua8
         Y4TQ==
X-Gm-Message-State: AGi0PuYETbERiZ8Gy2hXURNOFlJjJngVbBnDRMEtu45o+lDeglfprvGx
        QjEyjb80+5QLAgcaszMqBwvV+QMN6ZYkl3jihVBJmA==
X-Google-Smtp-Source: APiQypLms0zA6WvQAmVajcVRHgGwKdiDMidAforqu2S1QdJ4CrC95Xeb65YBLvCVe4Hc058EHhVGldBcSMl+12/fOWY=
X-Received: by 2002:a05:6e02:80e:: with SMTP id u14mr3522969ilm.176.1587648056689;
 Thu, 23 Apr 2020 06:20:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200423044050.162093-1-joel@joelfernandes.org> <20200423114008.GB13910@bombadil.infradead.org>
In-Reply-To: <20200423114008.GB13910@bombadil.infradead.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 23 Apr 2020 09:20:45 -0400
Message-ID: <CAEXW_YTwHApBgUBS1-GBUQ4i7iNHde1k5CxVVEqHPQfAV+51HQ@mail.gmail.com>
Subject: Re: [RFC] fs: Use slab constructor to initialize conn objects in fsnotify
To:     Matthew Wilcox <willy@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 23, 2020 at 7:40 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Apr 23, 2020 at 12:40:50AM -0400, Joel Fernandes (Google) wrote:
> > While reading the famous slab paper [1], I noticed that the conn->lock
> > spinlock and conn->list hlist in fsnotify code is being initialized
> > during every object allocation. This seems a good fit for the
> > constructor within the slab to take advantage of the slab design. Move
> > the initializtion to that.
>
> The slab paper was written a number of years ago when CPU caches were
> not as they are today.  With this patch, every time you allocate a
> new page, we dirty the entire page, and then the dirty cachelines will
> gradually fall out of cache as the other objects on the page are not used
> immediately.  Then, when we actually use one of the objects on the page,
> we bring those cachelines back in and dirty them again by initialising
> 'type' and 'obj'.  The two stores to initialise lock and list are almost
> free when done in fsnotify_attach_connector_to_object(), but are costly
> when done in a slab constructor.

Thanks a lot for this reasoning. Basically, you're saying when a slab
allocates a page, it would construct all objects which end up dirtying
the entire page before the object is even allocated. That makes sense.

There's one improvement (although probably verys small) that the paper mentions:
Also according to the paper you referenced, the instruction cache is
what would also benefit. Those spinlock and hlist initialization
instructions wouldn't cost L1 I-cache footprint for every allocation.

> There are very few places where a slab constructor is justified with a
> modern CPU.  We've considered removing the functionality before.

I see, thanks again for the insights.

 - Joel

>
> > @@ -479,8 +479,6 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
> >       conn = kmem_cache_alloc(fsnotify_mark_connector_cachep, GFP_KERNEL);
> >       if (!conn)
> >               return -ENOMEM;
> > -     spin_lock_init(&conn->lock);
> > -     INIT_HLIST_HEAD(&conn->list);
> >       conn->type = type;
> >       conn->obj = connp;
> >       /* Cache fsid of filesystem containing the object */
> > --
> > 2.26.1.301.g55bc3eb7cb9-goog
