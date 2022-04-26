Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946AB50FE2F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Apr 2022 15:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241669AbiDZNFE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Apr 2022 09:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350429AbiDZNFB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:05:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 83EF23123D
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Apr 2022 06:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650978113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jn5bfW8Qoe1EPltgEBX2gNmQenuldIkB/VjZHkhsP1o=;
        b=fokRSMkyHvJQ+M6hecnTgGMf1kYwXw71Ml2CiFlToTSAEDPi4kXOjy7sEO8BKhY8TfgNt8
        bZixub0Xfv9O6RA2wCfXbX2+TlY4jf3D2eTqXMNbJoLi8+9fzGoKNweAPd8ryHfzOser+v
        450h1pUIptl4wcojmKg0L6Ghrq1q4+c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-iZWSpHQFOqSPoBA_tiI2VA-1; Tue, 26 Apr 2022 09:01:47 -0400
X-MC-Unique: iZWSpHQFOqSPoBA_tiI2VA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0D5A819711D0;
        Tue, 26 Apr 2022 13:01:45 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.210])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8597EC27EAB;
        Tue, 26 Apr 2022 13:01:44 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 4037222067F; Tue, 26 Apr 2022 09:01:44 -0400 (EDT)
Date:   Tue, 26 Apr 2022 09:01:44 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Dharmendra Singh <dsingh@ddn.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        German Maglione <gmaglione@redhat.com>
Subject: Re: [PATCH] fuse: Apply flags2 only when userspace set the
 FUSE_INIT_EXT flag
Message-ID: <YmftOLZ59j359zGG@redhat.com>
References: <165002363635.1457422.5930635235733982079.stgit@localhost>
 <CAJfpegs=_bzBrmPSv_V3yQWaW7NR_f9CviuUTwfbcx9Wzudoxg@mail.gmail.com>
 <YmUKZQKNAGimupv7@redhat.com>
 <CAJfpegsUfANp4a4gmAKLjenkdjoA-Gppja=LmwdF_1Gh3wdL4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegsUfANp4a4gmAKLjenkdjoA-Gppja=LmwdF_1Gh3wdL4g@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 25, 2022 at 10:09:48AM +0200, Miklos Szeredi wrote:
> On Sun, 24 Apr 2022 at 10:29, Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > On Thu, Apr 21, 2022 at 05:36:02PM +0200, Miklos Szeredi wrote:
> > > On Fri, 15 Apr 2022 at 13:54, Bernd Schubert <bschubert@ddn.com> wrote:
> > > >
> > > > This is just a safety precaution to avoid checking flags
> > > > on memory that was initialized on the user space side.
> > > > libfuse zeroes struct fuse_init_out outarg, but this is not
> > > > guranteed to be done in all implementations. Better is to
> > > > act on flags and to only apply flags2 when FUSE_INIT_EXT
> > > > is set.
> > > >
> > > > There is a risk with this change, though - it might break existing
> > > > user space libraries, which are already using flags2 without
> > > > setting FUSE_INIT_EXT.
> > > >
> > > > The corresponding libfuse patch is here
> > > > https://github.com/libfuse/libfuse/pull/662
> > > >
> > > >
> > > > Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> > >
> > > Agreed, this is a good change.  Applied.
> > >
> > > Just one comment: please consider adding  "Fixes:" and "Cc:
> > > <stable@....>" tags next time.   I added them now.
> >
> > I am afraid that this probably will break both C and rust version of
> > virtiofsd. I had a quick look and I can't seem to find these
> > implementations setting INIT_EXT flag in reply to init.
> >
> > I am travelling. Will check it more closely when I return next week.
> > If virtiofsd implementations don't set INIT_EXT, I would rather prefer
> > to not do this change and avoid breaking it.
> 
> Okay, let's postpone this kernel patch until libfuse and virtiofsd
> implementations are updated.

Ok. I will work on fixing virtiofsd implementation. Even if we fix it,
then older versions will still be broken with newer kernels. I am
wondering, which clients are not setting flags2 to zero. And if they are
not setting it to zero, it sounds like a bug to me in fuse servers
instead and should probably be fixed there without breaking things for
existing users.

Agree that it probably is a nice change if we had introduced this in the
beginning itself. Its like extra saftey net. But now if we add it, it
will break things which is not nice. So at this point of time, it probably
is better to fix fuse servers instead and set ->flags2 to zero, IMHO.

Thanks
Vivek

