Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441E1490BB2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jan 2022 16:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237298AbiAQPpI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jan 2022 10:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237294AbiAQPpH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jan 2022 10:45:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCDBC061574;
        Mon, 17 Jan 2022 07:45:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F183560FE6;
        Mon, 17 Jan 2022 15:45:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D570BC36AE3;
        Mon, 17 Jan 2022 15:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642434306;
        bh=9pS77Ri4doiZRhZlhU/7ZE+74d7wP8KT6W7H2Zwu2vM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=UrFDJYhG9TuIwXcPfsT9tCNBOKeCZAgUCBsrJfiZXFBYr68rdsG/bmg2fn3H765NM
         Fnw29RTjnjTJe7jNP96v9THDT56w2gNlX0aBg0mPziU64/+dDfVLsfRoR/NOZW0KUy
         XOyPZLg0EBoWHEDixi9YVdtAXe2q6LGLKgBm5ircBLIzemsmk+S8FvxeljEsKQ1F0y
         9hlxAXBUKBO4rOgz2mbW8nBx6wx6/E2bq+EU/ff4v3O4B/ydPln5Ls0UVv89nqOQH3
         kYVdeZOtieYbnhy/9cNs7Rqz5/evg89pVNGGLA8QaW9gDMNCDjd30HwV7b5Oz01fnz
         s1TPAgp/4pUAA==
Message-ID: <9c1fac5b5a11b5960b291f44f2c6baf56965b301.camel@kernel.org>
Subject: Re: [PATCH 1/3] ceph: Uninline the data on a file opened for writing
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Date:   Mon, 17 Jan 2022 10:45:04 -0500
In-Reply-To: <2807617.1642433067@warthog.procyon.org.uk>
References: <240e60443076a84c0599ccd838bd09c97f4cc5f9.camel@kernel.org>
         <164242347319.2763588.2514920080375140879.stgit@warthog.procyon.org.uk>
         <YeVzZZLcsX5Krcjh@casper.infradead.org>
         <2807617.1642433067@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2022-01-17 at 15:24 +0000, David Howells wrote:
> Jeff Layton <jlayton@kernel.org> wrote:
> 
> > On Mon, 2022-01-17 at 13:47 +0000, Matthew Wilcox wrote:
> > > This all falls very much under "doing it the hard way", and quite
> > > possibly under the "actively buggy with races" category.
> > > 
> > > read_mapping_folio() does what you want, as long as you pass 'filp'
> > > as your 'void *data'.  I should fix that type ...
> 
> 
> How much do we care about the case where we don't have either the
> CEPH_CAP_FILE_CACHE or the CEPH_CAP_FILE_LAZYIO caps?  Is it possible just to
> shove the page into the pagecache whatever we do?  At the moment there are two
> threads, both of which get a page - one attached to the page cache, one not.
> The rest is then common because from that point on, it doesn't matter where
> the folio resides.
> 

Well, the protocol says that if you don't have CEPH_CAP_FILE_CACHE (Fc)
then you're not allowed to do reads from the cache. I wouldn't care if
we stuffed the page into the mapping anyway, but that could potentially
affect mmap readers at the same time.

OTOH, mmap reads when we don't have Fc is somewhat racy anyway. Maybe it
doesn't matter... 
-- 
Jeff Layton <jlayton@kernel.org>
