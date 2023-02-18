Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB37369BBB2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Feb 2023 20:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjBRT61 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Feb 2023 14:58:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjBRT60 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Feb 2023 14:58:26 -0500
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F4F113D4;
        Sat, 18 Feb 2023 11:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=C8XrL9CNyt1HtqjywXrajg6YUETn7qZRDBR+dZ8edfQ=; b=b/60iRsAukh4dG7k7Zp5PgccNg
        zOrp2y6rl8UEEKsw5gVWHBlOWdwAMYiVXbhfg7ErOV6J/Bk54gZjM2wtazC+fjNZV2C8Qr/lII3rO
        T3XR93FLw6ZqZE/216m2yb9dbIDvWMgGqIhqM/XK1HgduHPX+029kJ58y0rYjrGtbJg+JAnYjj4k8
        2TMWU7IEa3iGzfsY1UgexiuEItdctYQqwoSEL8RDn4eIa71kh6qOv1CSMnfLWlatFp0lYmz8wRrvm
        I3NBXYbU0uA8ZmFklItY22Vz9fvpfQ5ofcU9PexN23zgV65lYon4fFjoRlh2T4Ld2i/ScZfxAsNk5
        nmlxjttttg9q2ZFDvGc/NA4cCztzK8+JdrXV0DThcy335V36V3BDcUaTfRgNYR53pIUETRbO2zviQ
        +7BUwc1yCElc0GJxXoEqyrgaAKR9Z3fxd7R/epBEjAM0pidrn9cJcN03qEj8kTrgXfEsdu08rc8pJ
        YdhbPjS/PAXllgh3O5TdFs0a5r8IoKVDXta8KStjc5toU3gll+Clun+CAp7I5hnI4vPTyTv1dPLsF
        iuN+1qvFZq7L/QnsqAwu5ElnpZHv2cAy/AY2Hcqxdz1M9Z9BkxD45/yUV8s1DyU2+nKqivU/BfNZ0
        sGmUC4v526CiaV3vjOoHVxR3ZKHXuCeAV7f7HghxM=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     Eric Van Hensbergen <ericvh@kernel.org>, asmadeus@codewreck.org
Cc:     v9fs-developer@lists.sourceforge.net, rminnich@gmail.com,
        lucho@ionkov.net, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 10/11] fs/9p: writeback mode fixes
Date:   Sat, 18 Feb 2023 20:58:08 +0100
Message-ID: <1983433.kCcYWV5373@silver>
In-Reply-To: <Y/Ch8o/6HVS8Iyeh@codewreck.org>
References: <20230124023834.106339-1-ericvh@kernel.org>
 <20230218003323.2322580-11-ericvh@kernel.org>
 <Y/Ch8o/6HVS8Iyeh@codewreck.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Saturday, February 18, 2023 11:01:22 AM CET asmadeus@codewreck.org wrote:
> Eric Van Hensbergen wrote on Sat, Feb 18, 2023 at 12:33:22AM +0000:
> > This fixes several detected problems from preivous
> > patches when running with writeback mode.  In
> > particular this fixes issues with files which are opened
> > as write only and getattr on files which dirty caches.
> > 
> > This patch makes sure that cache behavior for an open file is stored in
> > the client copy of fid->mode.  This allows us to reflect cache behavior
> > from mount flags, open mode, and information from the server to
> > inform readahead and writeback behavior.
> > 
> > This includes adding support for a 9p semantic that qid.version==0
> > is used to mark a file as non-cachable which is important for
> > synthetic files.  This may have a side-effect of not supporting
> > caching on certain legacy file servers that do not properly set
> > qid.version.  There is also now a mount flag which can disable
> > the qid.version behavior.
> > 
> > Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
> 
> Didn't have time to review it all thoroughly, sending what I have
> anyway...
> 
> > diff --git a/Documentation/filesystems/9p.rst b/Documentation/filesystems/9p.rst
> > index 0e800b8f73cc..0c2c7a181d85 100644
> > --- a/Documentation/filesystems/9p.rst
> > +++ b/Documentation/filesystems/9p.rst
> > @@ -79,18 +79,14 @@ Options
> >  
> >    cache=mode	specifies a caching policy.  By default, no caches are used.
> >  
> > -                        none
> > -				default no cache policy, metadata and data
> > -                                alike are synchronous.
> > -			loose
> > -				no attempts are made at consistency,
> > -                                intended for exclusive, read-only mounts
> > -                        fscache
> > -				use FS-Cache for a persistent, read-only
> > -				cache backend.
> > -                        mmap
> > -				minimal cache that is only used for read-write
> > -                                mmap.  Northing else is cached, like cache=none
> > +			=========	=============================================
> > +			none		no cache of file or metadata
> > +			readahead	readahead caching of files
> > +			writeback	delayed writeback of files
> > +			mmap		support mmap operations read/write with cache
> > +			loose		meta-data and file cache with no coherency
> > +			fscache		use FS-Cache for a persistent cache backend
> > +			=========	=============================================
> 
> perhaps a word saying the caches are incremental, only one can be used,
> and listing them in order?
> e.g. it's not clear from this that writeback also enables readahead,
> and as a user I'd try to use cache=readahead,cache=writeback and wonder
> why that doesn't work (well, I guess it would in that order...)

+1 on docs

The question was also whether to make these true separate options before being
merged.

I give these patches a spin tomorrow.



