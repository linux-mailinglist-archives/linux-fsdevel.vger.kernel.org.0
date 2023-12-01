Return-Path: <linux-fsdevel+bounces-4610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5DF801491
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 21:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A06F41F20FD2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 20:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B3857880
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 20:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SjbcpQoo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FB510FD
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 11:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701457714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4yP5LXrBdJ83hVGYEINivD3VqyTv5M52Z9KIeiI+aKM=;
	b=SjbcpQoovl24o4XsmQtKDnmo0eDP7lkXhwmBnGyvN1BPq1ByIjUYmSEVNu23sXqt72s4Kt
	3M6v900kDZU7g/DFak7PFQD1rDIulpEhuOTq81zhLS9K0tu/ooCUE0WTGDaY4YewHtcO8g
	UFFOPSDKOW/oBXxB5aGbXpg+McHtV6s=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-7-Eu7pn002Mm6fsQd4by_TDA-1; Fri,
 01 Dec 2023 14:08:28 -0500
X-MC-Unique: Eu7pn002Mm6fsQd4by_TDA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7634B3C0C880;
	Fri,  1 Dec 2023 19:08:28 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.16.207])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 386E910E46;
	Fri,  1 Dec 2023 19:08:28 +0000 (UTC)
Received: by fedora.redhat.com (Postfix, from userid 1000)
	id BE3742703C7; Fri,  1 Dec 2023 14:08:27 -0500 (EST)
Date: Fri, 1 Dec 2023 14:08:27 -0500
From: Vivek Goyal <vgoyal@redhat.com>
To: Hangyu Hua <hbh25y@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, jefflexu@linux.alibaba.com
Subject: Re: [PATCH] fs: fuse: dax: set fc->dax to NULL in
 fuse_dax_conn_free()
Message-ID: <ZWovK12GaC-_Ya0Z@redhat.com>
References: <20231116075726.28634-1-hbh25y@gmail.com>
 <CAJfpegvN5Rzy1_2v3oaf1Rp_LP_t3w6W_-Ozn1ADoCLGSKBk+Q@mail.gmail.com>
 <27ad4e0d-ba00-449b-84b9-90f3ba7e4232@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27ad4e0d-ba00-449b-84b9-90f3ba7e4232@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On Fri, Dec 01, 2023 at 10:42:53AM +0800, Hangyu Hua wrote:
> On 30/11/2023 18:54, Miklos Szeredi wrote:
> > On Thu, 16 Nov 2023 at 08:57, Hangyu Hua <hbh25y@gmail.com> wrote:
> > > 
> > > fuse_dax_conn_free() will be called when fuse_fill_super_common() fails
> > > after fuse_dax_conn_alloc(). Then deactivate_locked_super() in
> > > virtio_fs_get_tree() will call virtio_kill_sb() to release the discarded
> > > superblock. This will call fuse_dax_conn_free() again in fuse_conn_put(),
> > > resulting in a possible double free.
> > > 
> > > Fixes: 1dd539577c42 ("virtiofs: add a mount option to enable dax")
> > > Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> > > ---
> > >   fs/fuse/dax.c | 1 +
> > >   1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
> > > index 23904a6a9a96..12ef91d170bb 100644
> > > --- a/fs/fuse/dax.c
> > > +++ b/fs/fuse/dax.c
> > > @@ -1222,6 +1222,7 @@ void fuse_dax_conn_free(struct fuse_conn *fc)
> > >          if (fc->dax) {
> > >                  fuse_free_dax_mem_ranges(&fc->dax->free_ranges);
> > >                  kfree(fc->dax);
> > > +               fc->dax = NULL;
> > 
> > Is there a reason not to simply remove the fuse_dax_conn_free() call
> > from the cleanup path in fuse_fill_super_common()?
> 
> I think setting fc->dax to NULL keeps the memory allocation and release
> functions together in fuse_fill_super_common more readable. What do you
> think?

I agree with this. fuse_fill_super_common() calls fuse_dax_conn_alloc()
which in-turn initializes fc->dax. If fuse_fill_super_common() fails
later after calling fuse_dax_conn_alloc(), then cleanup of fc->dax
and other associated stuff in same function makes sense.

As a code reader I would like to know how fc->dax is being freed in
case of error and its right there in the error path (err_free_dax:).

I think I set the fc->dax upon initialization. Upon failure I freed
the data structures but did not set fc->dax back to NULL.

To me, this patch looks reasonable.

Acked-by: Vivek Goyal <vgoyal@redhat.com>

Thanks
Vivek

> 
> Thanks,
> Hangyu
> 
> > 
> > Thanks,
> > Miklos
> > 
> > 
> > >          }
> > >   }
> > > 
> > > --
> > > 2.34.1
> > > 
> 


