Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8AF750D07A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Apr 2022 10:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238600AbiDXIce (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Apr 2022 04:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236221AbiDXIca (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Apr 2022 04:32:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC6CB1AF24
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Apr 2022 01:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650788969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DvuBEbxVeQMFrNqrajP+bUfmcZIF19P8LmKKdZhQFLk=;
        b=aRhE1YsRbCF7xsJ6JWcnCAaniUByIqlAKekwF9uBmD5/Xt4SvSs1a+9bySzbRbyDvxQ2VV
        giiDt0mHIT7aS4bA1Zxqj87bCX2sdPcvuuav2mMaeVoANMPIK44lhxtof5qmboBTnUrWFw
        E8TiIssn2+PsHQv1o8fRbsvRo8Yeat4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-652-eH5waQCuO_uW5r7mGERZiQ-1; Sun, 24 Apr 2022 04:29:28 -0400
X-MC-Unique: eH5waQCuO_uW5r7mGERZiQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CE577811E83;
        Sun, 24 Apr 2022 08:29:27 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.16.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 98EDB40336A;
        Sun, 24 Apr 2022 08:29:26 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 4CFC822067F; Sun, 24 Apr 2022 04:29:25 -0400 (EDT)
Date:   Sun, 24 Apr 2022 04:29:25 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Dharmendra Singh <dsingh@ddn.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        German Maglione <gmaglione@redhat.com>
Subject: Re: [PATCH] fuse: Apply flags2 only when userspace set the
 FUSE_INIT_EXT flag
Message-ID: <YmUKZQKNAGimupv7@redhat.com>
References: <165002363635.1457422.5930635235733982079.stgit@localhost>
 <CAJfpegs=_bzBrmPSv_V3yQWaW7NR_f9CviuUTwfbcx9Wzudoxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegs=_bzBrmPSv_V3yQWaW7NR_f9CviuUTwfbcx9Wzudoxg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 21, 2022 at 05:36:02PM +0200, Miklos Szeredi wrote:
> On Fri, 15 Apr 2022 at 13:54, Bernd Schubert <bschubert@ddn.com> wrote:
> >
> > This is just a safety precaution to avoid checking flags
> > on memory that was initialized on the user space side.
> > libfuse zeroes struct fuse_init_out outarg, but this is not
> > guranteed to be done in all implementations. Better is to
> > act on flags and to only apply flags2 when FUSE_INIT_EXT
> > is set.
> >
> > There is a risk with this change, though - it might break existing
> > user space libraries, which are already using flags2 without
> > setting FUSE_INIT_EXT.
> >
> > The corresponding libfuse patch is here
> > https://github.com/libfuse/libfuse/pull/662
> >
> >
> > Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> 
> Agreed, this is a good change.  Applied.
> 
> Just one comment: please consider adding  "Fixes:" and "Cc:
> <stable@....>" tags next time.   I added them now.

I am afraid that this probably will break both C and rust version of
virtiofsd. I had a quick look and I can't seem to find these
implementations setting INIT_EXT flag in reply to init.

I am travelling. Will check it more closely when I return next week.
If virtiofsd implementations don't set INIT_EXT, I would rather prefer
to not do this change and avoid breaking it.

Thanks
Vivek

