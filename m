Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559FA53440E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 May 2022 21:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244049AbiEYTQR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 May 2022 15:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344385AbiEYTOx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 May 2022 15:14:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B4DD312AC7
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 May 2022 12:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653505947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BSlFh6scasINwURYqTNfAHrALafGW5UGEVKrCU1SoX0=;
        b=Rav0yTPoAE5j4rp+mP8O1KbXX66bze//IP0EJI7CAm5+/4PBkaZ2o34SacM/463HqEcnHd
        DRJ13hUe9O+kx8+0cDWApQoWRPN7ATd+WRnPqnftWhvFksklx1gFw3Dv+KdAhWS8W3b2AH
        2QAtTMA1Uj3b8vjwdbgY2KW4qdhzBPc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-358-rZ4sn0afPomx16jKnHmyrw-1; Wed, 25 May 2022 15:12:25 -0400
X-MC-Unique: rZ4sn0afPomx16jKnHmyrw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 541B08001EA;
        Wed, 25 May 2022 19:12:25 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.32.214])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3CA3C7AD8;
        Wed, 25 May 2022 19:12:25 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id EFB372208FA; Wed, 25 May 2022 15:12:24 -0400 (EDT)
Date:   Wed, 25 May 2022 15:12:24 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Bernd Schubert <bschubert@ddn.com>
Cc:     Dharmendra Singh <dharamhans87@gmail.com>, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Dharmendra Singh <dsingh@ddn.com>
Subject: Re: [PATCH v3 1/1] FUSE: Allow non-extending parallel direct writes
 on the same file.
Message-ID: <Yo5/mAtphbxSrhxS@redhat.com>
References: <20220520043443.17439-1-dharamhans87@gmail.com>
 <20220520043443.17439-2-dharamhans87@gmail.com>
 <Yo54Z4EQjzsQbMTp@redhat.com>
 <77b28772-b210-6597-eedd-fe7e0b5b1db9@ddn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77b28772-b210-6597-eedd-fe7e0b5b1db9@ddn.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 25, 2022 at 09:06:37PM +0200, Bernd Schubert wrote:
> 
> 
> On 5/25/22 20:41, Vivek Goyal wrote:
> > On Fri, May 20, 2022 at 10:04:43AM +0530, Dharmendra Singh wrote:
> > > From: Dharmendra Singh <dsingh@ddn.com>
> > > 
> > > In general, as of now, in FUSE, direct writes on the same file are
> > > serialized over inode lock i.e we hold inode lock for the full duration
> > > of the write request. I could not found in fuse code a comment which
> > > clearly explains why this exclusive lock is taken for direct writes.
> > > Our guess is some USER space fuse implementations might be relying
> > > on this lock for seralization and also it protects for the issues
> > > arising due to file size assumption or write failures.  This patch
> > > relaxes this exclusive lock in some cases of direct writes.
> > > 
> > > With these changes, we allows non-extending parallel direct writes
> > > on the same file with the help of a flag called FOPEN_PARALLEL_WRITES.
> > > If this flag is set on the file (flag is passed from libfuse to fuse
> > > kernel as part of file open/create), we do not take exclusive lock instead
> > > use shared lock so that all non-extending writes can run in parallel.
> > > 
> > > Best practise would be to enable parallel direct writes of all kinds
> > > including extending writes as well but we see some issues such as
> > > when one write completes and other fails, how we should truncate(if
> > > needed) the file if underlying file system does not support holes
> > > (For file systems which supports holes, there might be a possibility
> > > of enabling parallel writes for all cases).
> > > 
> > > FUSE implementations which rely on this inode lock for serialisation
> > > can continue to do so and this is default behaviour i.e no parallel
> > > direct writes.
> > > 
> > > Signed-off-by: Dharmendra Singh <dsingh@ddn.com>
> > > Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> > > ---
> > >   fs/fuse/file.c            | 33 ++++++++++++++++++++++++++++++---
> > >   include/uapi/linux/fuse.h |  2 ++
> > >   2 files changed, 32 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > > index 829094451774..1a93fd80a6ce 100644
> > > --- a/fs/fuse/file.c
> > > +++ b/fs/fuse/file.c
> > > @@ -1541,14 +1541,37 @@ static ssize_t fuse_direct_read_iter(struct kiocb *iocb, struct iov_iter *to)
> > >   	return res;
> > >   }
> > > +static bool fuse_direct_write_extending_i_size(struct kiocb *iocb,
> > > +					       struct iov_iter *iter)
> > > +{
> > > +	struct inode *inode = file_inode(iocb->ki_filp);
> > > +
> > > +	return (iocb->ki_flags & IOCB_APPEND ||
> > > +		iocb->ki_pos + iov_iter_count(iter) > i_size_read(inode));
> > > +}
> > 
> > Hi Dharmendra,
> > 
> > I have a question. What makes i_size stable. This is being read outside
> > the inode_lock(). Can it race with truncate. I mean we checked
> > i_size and decided to take shared lock. In the mean time another thread
> > truncated the file and now our decision to take shared lock is wrong
> > as file will be extended due to direct write?
> 
> Oh right, good catch! I guess we need to take a shared lock first, read the
> size and if it is an extending lock need to unlock/switch to an excluding
> lock. Theoretically could be a loop, but I guess that would be overkill.

Another possibility is that we need to check again after taking shared
lock if our decision to take shared lock was correct or not. If in
unlikely case something changed, then drop shared lock and go back to
exclusive lock, or drop the shared lock and re-evaluate which lock to take.

Thanks
Vivek

> 
> 
> Thanks for your review!
> 
> Cheers,
> Bernd
> 

