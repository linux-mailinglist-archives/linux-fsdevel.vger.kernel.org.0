Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 621453C5D24
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 15:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbhGLNY5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 09:24:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:50492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229978AbhGLNY4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 09:24:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D140E60FE3;
        Mon, 12 Jul 2021 13:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626096128;
        bh=2n+/KxcQvGM7mFI1P39IHXxYavZRDtXP5ygdwdIhhM0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=IewmfISieYz+qgFvJQ/sBBzPI2rLrn7HTBRgb8wWGgrnLgyMT7MRkJpheeVOqfNnR
         AZYea+PMuyUx9zzGpsjj+5f1vUZzZC9OxiomwLlj2b3NeNDFqUzXHf6WO+7cQF0ptF
         Q74LgiuFMQuJTGPrWb3CTfvQpEdpy8n6kOCqvyeST27Fsh94ub4cAhOZ9EikC8oiu0
         26PTeXKgdmsh+bpJblpejlp2wA41D9xF2o4jOpIEfG2Gd0ZAOuIkcVqwWkTRT7Jotp
         OQPqRshpd7MwO0nrWSdLjuYJZXDHPjyNpPGSnGbfHwia5xKG+n8wjays+FK9A/HGol
         iPiC+4OJJz4XQ==
Message-ID: <1e16ba2b69dd03c61e7c9db6ee124aa53ce60f3b.camel@kernel.org>
Subject: Re: [RFC PATCH v7 07/24] ceph: add fscrypt_* handling to caps.c
From:   Jeff Layton <jlayton@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     ceph-devel@vger.kernel.org, lhenriques@suse.de, xiubli@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        dhowells@redhat.com
Date:   Mon, 12 Jul 2021 09:22:06 -0400
In-Reply-To: <YOt38ayEMpECKQeP@quark.localdomain>
References: <20210625135834.12934-1-jlayton@kernel.org>
         <20210625135834.12934-8-jlayton@kernel.org>
         <YOt38ayEMpECKQeP@quark.localdomain>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.2 (3.40.2-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 2021-07-11 at 18:00 -0500, Eric Biggers wrote:
> On Fri, Jun 25, 2021 at 09:58:17AM -0400, Jeff Layton wrote:
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/ceph/caps.c | 62 +++++++++++++++++++++++++++++++++++++++-----------
> >  1 file changed, 49 insertions(+), 13 deletions(-)
> > 
> > diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> > index 038f59cc4250..1be6c5148700 100644
> > --- a/fs/ceph/caps.c
> > +++ b/fs/ceph/caps.c
> > @@ -13,6 +13,7 @@
> >  #include "super.h"
> >  #include "mds_client.h"
> >  #include "cache.h"
> > +#include "crypto.h"
> >  #include <linux/ceph/decode.h>
> >  #include <linux/ceph/messenger.h>
> >  
> > @@ -1229,15 +1230,12 @@ struct cap_msg_args {
> >  	umode_t			mode;
> >  	bool			inline_data;
> >  	bool			wake;
> > +	u32			fscrypt_auth_len;
> > +	u32			fscrypt_file_len;
> > +	u8			fscrypt_auth[sizeof(struct ceph_fscrypt_auth)]; // for context
> > +	u8			fscrypt_file[sizeof(u64)]; // for size
> >  };
> 
> The naming of these is confusing to me.  If these are the fscrypt context and
> the original file size, why aren't they called something like fscrypt_context
> and fscrypt_file_size?
> 
> Also does the file size really need to be variable-length, or could it just be a
> 64-bit integer?
> 

Fscrypt is really a kernel client-side feature. Both of these new fields
are treated as opaque by the MDS and are wholly managed by the client.

We need two fields because they are governed by different cephfs
capabilities (aka "caps"). AUTH caps for the context and FILE caps for
the size. So we have two new fields -- fscrypt_file and fscrypt_auth. 

The size could be a __le64 or something, but I think it makes sense to
allow it to be opaque as we aren't certain what other info we might want
to keep in there. We might also want to encrypt the fscrypt_file field
to cloak the true size of a file from anyone without the key.

Now, all that said, the fact that the MDS largely handles truncation
poses some special challenges for the content encryption piece. We may
ultimately end up making this more special-purpose than it is now.
-- 
Jeff Layton <jlayton@kernel.org>

