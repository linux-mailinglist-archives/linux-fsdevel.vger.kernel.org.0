Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276B670A34C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 May 2023 01:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjESXZk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 19:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjESXZj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 19:25:39 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAC8E45
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 16:25:38 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5343c3daff0so2628058a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 16:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1684538737; x=1687130737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bKr1UB/0XkRzk2PihpADAJXUksvmnyVm9O5+fMmopFI=;
        b=vA8gjoc7KyrjW0i8bNRpNsG/byB9+2+EFP/q1UJwgQL6b9LmP3ic8xqFrMS68ZfB2a
         WehbkU1mXIYkJH+yPHJRYgtBv9Lr/z88H9y/wgBwJM4zrS8/hmtYoy1o33ROdc+2XBDG
         AGRBMGEHmOUYcxXjxYlLXmQ9Tq7m5BCITL4hAih1KWV4m4ijl4MKqR5T+OpVptWNax5K
         7uuHvNo+6iE2rzhe1RNZI/ZUPDov3wKU5K3B0nYy44b41aa8Y+13A4u0uWysUXq393aP
         tAONcDyw+WlJJWwnI1TumxivcIhCDJg+cR5Jhnt+PALu++aDnHXaXIEwIP80dx1smXis
         nhZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684538737; x=1687130737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bKr1UB/0XkRzk2PihpADAJXUksvmnyVm9O5+fMmopFI=;
        b=hvKYYd45mX2bfO09niOJWJdfbZBAaaDPUNWS4e63RiiBVgV0iffmhXQbpaIvBx5m7D
         +SzPgr6+gZGlo0X1a6Ovkbhs6svjU1DEoHFjX99HjkJNQbeRkwf1dDB8949vTfEbPBW7
         zXV08hdlTTVyvZDat2jgf26vSTYOev0y1XxEgR7HLXdNPur9uqfB8x96gJmWpGhWM35U
         IgJNugPkMVUEaeAsmq0+tkIH6uO6vrRrbsAjVrBXhpdR23p3zxtPB2pVJ4TwxdF58QVf
         6x0nag6fiCgR1satmk3gA4W3qD6RK44wmkfzHwhNnYQ7PmWwy2wM2Z1tJ3hCq/CfkXW2
         LLpw==
X-Gm-Message-State: AC+VfDwA6JYEuXXF8EPm06cbZ9QpEx0LoAHzrDe0AwR4eF55GKk6MFPs
        OJp10Y/9CRzBJm5xdNkteGXzww==
X-Google-Smtp-Source: ACHHUZ5A2G4STQpUdYeDUuTa75DYc03lsT9xU4W88afMcTm7115Rh7EEYQvinFgfBaG7xvb8ys1tRw==
X-Received: by 2002:a17:902:9686:b0:1a6:a6e7:8846 with SMTP id n6-20020a170902968600b001a6a6e78846mr3673960plp.40.1684538737548;
        Fri, 19 May 2023 16:25:37 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-188.pa.nsw.optusnet.com.au. [49.179.0.188])
        by smtp.gmail.com with ESMTPSA id ja7-20020a170902efc700b001ae4edacce5sm171280plb.94.2023.05.19.16.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 16:25:37 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q09Ta-001WpT-0w;
        Sat, 20 May 2023 09:25:34 +1000
Date:   Sat, 20 May 2023 09:25:34 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>, corbet@lwn.net,
        jake@lwn.net, hch@infradead.org, djwong@kernel.org,
        dchinner@redhat.com, ritesh.list@gmail.com, rgoldwyn@suse.com,
        jack@suse.cz, linux-doc@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        p.raghav@samsung.com, da.gomez@samsung.com, rohan.puri@samsung.com
Subject: Re: [PATCH] Documentation: add initial iomap kdoc
Message-ID: <ZGgFbmdCrlXtNFYS@dread.disaster.area>
References: <20230518144037.3149361-1-mcgrof@kernel.org>
 <ZGdBO6bmbj3sLlzp@debian.me>
 <731a3061-973c-a4ad-2fe5-7981c6c1279b@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <731a3061-973c-a4ad-2fe5-7981c6c1279b@infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 19, 2023 at 08:13:50AM -0700, Randy Dunlap wrote:
> 
> 
> On 5/19/23 02:28, Bagas Sanjaya wrote:
> >> +/**
> >> + * DOC:  Flags reported by the file system from iomap_begin
> >>   *
> >> - * IOMAP_F_NEW indicates that the blocks have been newly allocated and need
> >> - * zeroing for areas that no data is copied to.
> >> + * * IOMAP_F_NEW: indicates that the blocks have been newly allocated and need
> >> + *	zeroing for areas that no data is copied to.
> >>   *
> >> - * IOMAP_F_DIRTY indicates the inode has uncommitted metadata needed to access
> >> - * written data and requires fdatasync to commit them to persistent storage.
> >> - * This needs to take into account metadata changes that *may* be made at IO
> >> - * completion, such as file size updates from direct IO.
> >> + * * IOMAP_F_DIRTY: indicates the inode has uncommitted metadata needed to access
> >> + *	written data and requires fdatasync to commit them to persistent storage.
> >> + *	This needs to take into account metadata changes that *may* be made at IO
> >> + *	completion, such as file size updates from direct IO.
> >>   *
> >> - * IOMAP_F_SHARED indicates that the blocks are shared, and will need to be
> >> - * unshared as part a write.
> >> + * * IOMAP_F_SHARED: indicates that the blocks are shared, and will need to be
> >> + *	unshared as part a write.
> >>   *
> >> - * IOMAP_F_MERGED indicates that the iomap contains the merge of multiple block
> >> - * mappings.
> >> + * * IOMAP_F_MERGED: indicates that the iomap contains the merge of multiple block
> >> + *	mappings.
> >>   *
> >> - * IOMAP_F_BUFFER_HEAD indicates that the file system requires the use of
> >> - * buffer heads for this mapping.
> >> + * * IOMAP_F_BUFFER_HEAD: indicates that the file system requires the use of
> >> + *	buffer heads for this mapping.
> >>   *
> >> - * IOMAP_F_XATTR indicates that the iomap is for an extended attribute extent
> >> - * rather than a file data extent.
> >> + * * IOMAP_F_XATTR: indicates that the iomap is for an extended attribute extent
> >> + *	rather than a file data extent.
> >>   */
> > Why don't use kernel-doc comments to describe flags?
> > 
> 
> Because kernel-doc handles functions, structs, unions, and enums.
> Not defines.

So perhaps that should be fixed first?

I seriously dislike the implication here that we should accept
poorly/inconsistently written comments and code just to work around
deficiencies in documentation tooling.

Either modify the code to work cleanly and consistently with the
tooling (e.g. change the code to use enums rather than #defines), or
fix the tools that don't work with macro definitions in a way that
matches the existing code documentation standards.

Forcing developers, reviewers and maintainers to understand, accept
and then maintain inconsistent crap in the code just because some
tool they never use is deficient is pretty much my definition of an
unacceptible engineering process.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
