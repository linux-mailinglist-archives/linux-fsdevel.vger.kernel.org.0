Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4139869BD83
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Feb 2023 23:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjBRWYX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Feb 2023 17:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBRWYW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Feb 2023 17:24:22 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5554211156;
        Sat, 18 Feb 2023 14:24:21 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id w18so1120474wrv.11;
        Sat, 18 Feb 2023 14:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZuG2o2GL/RNJE8s44PFg/nieunuAxpEhxU6KAMrsGL4=;
        b=I2jVuYWJxksxcMHQQpuoXzhLieMj0S63A9cp7urpwrV1cDglutxDwlQEKR8DXJMYns
         2jFY8AEl5JSxMStjTx8xEmfbME9H8+hWdx/K6mhmNrjLqWDNkRjx3utbDI7yAJBK8CE5
         yL9XWi2+3vz0e9q5s4AvAAqmBl2KIMC39AgiQuvyq5pmIuaD5DfiRjlzvjp9FEuLH/tZ
         1plqInPGFLnv+q92zAAE4UyOSHtLqNwHVWF095NwhCFVlFCRIGATDIIMF1FNVoo0O6VW
         VE4NTLJTdz/GEa5hMJwYJiJRf33u4h1l4FgQ8T7lnUPeVfk0sImXmjSni8zBXWMw9jjT
         ZJ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZuG2o2GL/RNJE8s44PFg/nieunuAxpEhxU6KAMrsGL4=;
        b=Erfn3rxGKlI0L0hU5LGaVQt3mXOZoKG+pbZFz9ip8Sle/8XVj9kaFl+o8qIkFl/CK/
         ILtZd5gWtW5EohxKUJCewTwkjqYuA72a3FnRJq0taVoCvIVQTqOgiFp6mzsgHvY+HsvG
         ym4R0h0kW/uISpsDVmmh7Z/eKdpA+jZQ6DDoH0qPJyAfkwOtmKEKhcyHJBkZJWAvQBZ9
         gtivi5tlFA5gNhjepBac5h49+OUKnNv69QtzFB0pbWk7KxEoOxzi5meUwBS7Wbopv0jl
         Vh08nEHXPIWjniR8K+f+PdoQ0Mr3VckTn2xnIrJEQUQy+IJGp7d17OgjKDGooi4F/nPI
         n2UA==
X-Gm-Message-State: AO0yUKX+lumYHD18a4qqFi7BBEJfy5o2eNY2zL+oUOzNMVafOcpLYOfL
        /K3KEHVV5FKkRHw8k3zkMuJjH5eel5DU13lvgyGMRrrB
X-Google-Smtp-Source: AK7set/8C2BA2FqfnJj/e7X7zoX19p8JKyl+A/sZzeZ6ksu1sutnX7O97s6TC9bvDSG5NOVWYJZYRpzaP5aCtq9OU5c=
X-Received: by 2002:a5d:6e8a:0:b0:2c5:50db:e9fc with SMTP id
 k10-20020a5d6e8a000000b002c550dbe9fcmr60421wrz.674.1676759059334; Sat, 18 Feb
 2023 14:24:19 -0800 (PST)
MIME-Version: 1.0
References: <20230124023834.106339-1-ericvh@kernel.org> <20230218003323.2322580-11-ericvh@kernel.org>
 <Y/Ch8o/6HVS8Iyeh@codewreck.org> <1983433.kCcYWV5373@silver>
In-Reply-To: <1983433.kCcYWV5373@silver>
From:   Eric Van Hensbergen <ericvh@gmail.com>
Date:   Sat, 18 Feb 2023 16:24:08 -0600
Message-ID: <CAFkjPT=xhEEedeYcyn1FFcngqOJf_+8ynz4zeLbsXPOGoY6aqw@mail.gmail.com>
Subject: Re: [PATCH v4 10/11] fs/9p: writeback mode fixes
To:     Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     Eric Van Hensbergen <ericvh@kernel.org>, asmadeus@codewreck.org,
        v9fs-developer@lists.sourceforge.net, rminnich@gmail.com,
        lucho@ionkov.net, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Yeah, I guess it depends on what options we want to separate,
writeback == mmap so we can eliminate one option and just use mmap I
suppose.  I feel like readahead has value as it maintains the most
consistency on the host file system since it shouldn't be doing any
writeback buffering.  readahead and mmap are different than loose in
that they don't do any do any dir cache.  To your earlier comments (in
a different thread) it very well may be that eventually we separate
these into file_cache=[ readahead | mmap | loose ] and dir_cache = [
tight | temporal | loose ] and fscache is its own beast.  It struck me
as well with xattr enabled we may want to have separate caches for
xattr caching since it generates a load of traffic with security on.

On Sat, Feb 18, 2023 at 1:58 PM Christian Schoenebeck
<linux_oss@crudebyte.com> wrote:
>
> On Saturday, February 18, 2023 11:01:22 AM CET asmadeus@codewreck.org wrote:
> > Eric Van Hensbergen wrote on Sat, Feb 18, 2023 at 12:33:22AM +0000:
> > > This fixes several detected problems from preivous
> > > patches when running with writeback mode.  In
> > > particular this fixes issues with files which are opened
> > > as write only and getattr on files which dirty caches.
> > >
> > > This patch makes sure that cache behavior for an open file is stored in
> > > the client copy of fid->mode.  This allows us to reflect cache behavior
> > > from mount flags, open mode, and information from the server to
> > > inform readahead and writeback behavior.
> > >
> > > This includes adding support for a 9p semantic that qid.version==0
> > > is used to mark a file as non-cachable which is important for
> > > synthetic files.  This may have a side-effect of not supporting
> > > caching on certain legacy file servers that do not properly set
> > > qid.version.  There is also now a mount flag which can disable
> > > the qid.version behavior.
> > >
> > > Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
> >
> > Didn't have time to review it all thoroughly, sending what I have
> > anyway...
> >
> > > diff --git a/Documentation/filesystems/9p.rst b/Documentation/filesystems/9p.rst
> > > index 0e800b8f73cc..0c2c7a181d85 100644
> > > --- a/Documentation/filesystems/9p.rst
> > > +++ b/Documentation/filesystems/9p.rst
> > > @@ -79,18 +79,14 @@ Options
> > >
> > >    cache=mode       specifies a caching policy.  By default, no caches are used.
> > >
> > > -                        none
> > > -                           default no cache policy, metadata and data
> > > -                                alike are synchronous.
> > > -                   loose
> > > -                           no attempts are made at consistency,
> > > -                                intended for exclusive, read-only mounts
> > > -                        fscache
> > > -                           use FS-Cache for a persistent, read-only
> > > -                           cache backend.
> > > -                        mmap
> > > -                           minimal cache that is only used for read-write
> > > -                                mmap.  Northing else is cached, like cache=none
> > > +                   =========       =============================================
> > > +                   none            no cache of file or metadata
> > > +                   readahead       readahead caching of files
> > > +                   writeback       delayed writeback of files
> > > +                   mmap            support mmap operations read/write with cache
> > > +                   loose           meta-data and file cache with no coherency
> > > +                   fscache         use FS-Cache for a persistent cache backend
> > > +                   =========       =============================================
> >
> > perhaps a word saying the caches are incremental, only one can be used,
> > and listing them in order?
> > e.g. it's not clear from this that writeback also enables readahead,
> > and as a user I'd try to use cache=readahead,cache=writeback and wonder
> > why that doesn't work (well, I guess it would in that order...)
>
> +1 on docs
>
> The question was also whether to make these true separate options before being
> merged.
>
> I give these patches a spin tomorrow.
>
>
>
