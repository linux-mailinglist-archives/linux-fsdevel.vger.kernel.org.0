Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C8A50FEF7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Apr 2022 15:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241727AbiDZN2H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Apr 2022 09:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbiDZN2E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:28:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DA2B1189BDC
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Apr 2022 06:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650979495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qM5da8UlP3PBXWwzR2qkYcIQ1ttzUQO+1UTjPoiTGf8=;
        b=A10XhoCJGAGLSxuzZVUI4QUIyPThbx8wMXQ++wTcjc4duc/9cuqVWIWpv5UpoAiVLZNPgc
        KHpYRktIsgSWzSYKokoou+jyEGMxyPteb48839tmEkWwAM7WayIVk006F7aDMGrxHkAESX
        Cd0mowMOHkIaQdZGcybP3icQB/CE0Wg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-425-c0CFsn_dOpSEOuYGWY8HiQ-1; Tue, 26 Apr 2022 09:24:52 -0400
X-MC-Unique: c0CFsn_dOpSEOuYGWY8HiQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BA92B8001EA;
        Tue, 26 Apr 2022 13:24:51 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.210])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A69F841373D;
        Tue, 26 Apr 2022 13:24:51 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 6274C22067F; Tue, 26 Apr 2022 09:24:51 -0400 (EDT)
Date:   Tue, 26 Apr 2022 09:24:51 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Dharmendra Singh <dsingh@ddn.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        German Maglione <gmaglione@redhat.com>,
        Sergio Lopez <slp@redhat.com>
Subject: Re: [PATCH] fuse: Apply flags2 only when userspace set the
 FUSE_INIT_EXT flag
Message-ID: <Ymfyo9W6rLsIQm20@redhat.com>
References: <165002363635.1457422.5930635235733982079.stgit@localhost>
 <CAJfpegs=_bzBrmPSv_V3yQWaW7NR_f9CviuUTwfbcx9Wzudoxg@mail.gmail.com>
 <YmUKZQKNAGimupv7@redhat.com>
 <CAJfpegsUfANp4a4gmAKLjenkdjoA-Gppja=LmwdF_1Gh3wdL4g@mail.gmail.com>
 <YmftOLZ59j359zGG@redhat.com>
 <CAJfpegv3UfJbzkXTk0V80hiY-d4hRBbrn67DMnTR6Svw8+11cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegv3UfJbzkXTk0V80hiY-d4hRBbrn67DMnTR6Svw8+11cw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 26, 2022 at 03:13:50PM +0200, Miklos Szeredi wrote:
> On Tue, 26 Apr 2022 at 15:01, Vivek Goyal <vgoyal@redhat.com> wrote:
> 
> > Agree that it probably is a nice change if we had introduced this in the
> > beginning itself. Its like extra saftey net. But now if we add it, it
> > will break things which is not nice. So at this point of time, it probably
> > is better to fix fuse servers instead and set ->flags2 to zero, IMHO.
> 
> I think the question is whether the "unfixed" virtiofsd
> implementations made it into any sort of release or not.

Existing unfixed versions are already released in various releses. C version
of virtiofsd is already being used in RHEL8 release and some fedora releases.
And rust version of virtiofsd is supposed to be in RHEL9 beta.

Hence if we change it now, it is possible older virtiofsd (unfixed one)
is running on host and trying to boot a newer guest kernel and that
leads to breaking things.

Thanks
Vivek

> 
> If not, then I think it's fine to break unreleased versions, since
> they are ephemeral anyway.

> 
> Thanks,
> Miklos
> 

