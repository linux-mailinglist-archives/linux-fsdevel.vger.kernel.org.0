Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD4B51AC67
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 May 2022 20:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376311AbiEDSN3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 May 2022 14:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376820AbiEDSNT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 May 2022 14:13:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A59BE7FF6C
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 May 2022 10:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651685474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=joehKCGQgUtB5bm9SSiCyxnpdmxIgMPc6V/OebR+v8M=;
        b=C5AJcstFFPYdyUe4tcA3IjnrYqT0Da2LH/jURefGvwUlSmJIa5FGlhs0tzRL9FuYff83pv
        dLqHaund8jr5GXOD8Qv60Z6fjTpKINe72Qf3l6vTjUDdf9yk/q24po34dNjCm5hSlvOnFy
        0ZDLKs0BkRonXrcBbe+Xb0C/+zf8XZc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-393-rk43vzTnOBWIVmvA9gJnVw-1; Wed, 04 May 2022 13:31:11 -0400
X-MC-Unique: rk43vzTnOBWIVmvA9gJnVw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8CE0E380451D;
        Wed,  4 May 2022 17:31:09 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.16.200])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 45A0A111DCF2;
        Wed,  4 May 2022 17:31:09 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 094EC220463; Wed,  4 May 2022 13:31:09 -0400 (EDT)
Date:   Wed, 4 May 2022 13:31:08 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Bernd Schubert <bschubert@ddn.com>
Cc:     Dharmendra Hans <dharamhans87@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org, Dharmendra Singh <dsingh@ddn.com>
Subject: Re: [PATCH v4 1/3] FUSE: Implement atomic lookup + create
Message-ID: <YnK4XIk0M3Dx5RP+@redhat.com>
References: <20220502102521.22875-1-dharamhans87@gmail.com>
 <20220502102521.22875-2-dharamhans87@gmail.com>
 <YnGIUOP2BezDAb1k@redhat.com>
 <CACUYsyGoX+o19u41cZyF92eDBO-9rFN_EEWBvWBGrEMuNn29Mw@mail.gmail.com>
 <YnKR9CFYPXT1bM1F@redhat.com>
 <8003098d-6b17-5cdf-866d-06fefdf1ca31@ddn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8003098d-6b17-5cdf-866d-06fefdf1ca31@ddn.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 04, 2022 at 05:46:27PM +0200, Bernd Schubert wrote:
> 
> 
> On 5/4/22 16:47, Vivek Goyal wrote:
> 
> > Ok, naming is little confusing. I think we will have to put it in
> > commit message and where you define FUSE_ATOMIC_CREATE that what's
> > the difference between FUSE_CREATE and FUSE_ATOMIC_CREATE. This is
> > ATOMIC w.r.t what?
> > 
> > May be atomic here means that "lookup + create + open" is a single operation.
> > But then even FUSE_CREATE is atomic because "creat + open" is a single
> > operation.
> > 
> > In fact FUSE_CREATE does lookup anyway and returns all the information
> > in fuse_entry_out.
> > 
> > IIUC, only difference between FUSE_CREATE and FUSE_ATOMIC_CREATE is that
> > later also carries information in reply whether file was actually created
> > or not (FOPEN_FILE_CREATED). This will be set if file did not exist
> > already and it was created indeed. Is that right?
> > 
> > I see FOPEN_FILE_CREATED is being used to avoid calling
> > fuse_dir_changed(). That sounds like a separate optimization and probably
> > should be in a separate patch.
> > 
> > IOW, I think this patch should be broken in to multiple pieces. First
> > piece seems to be avoiding lookup() and given the way it is implemented,
> > looks like we can avoid lookup() even by using existing FUSE_CREATE
> > command. We don't necessarily need FUSE_ATOMIC_CREATE. Is that right?
> 
> The initial non-published patches had that, but I had actually asked not to
> go that route, because I'm scared that some user space file system
> implementations might get broken.

> Right now there is always a lookup before
> fuse_create_open() and when the resulting dentry is positive
> fuse_create_open/FUSE_CREATE is bypassed. I.e. user space implementations
> didn't need to handle existing files.

Hmm..., So if dentry is positive, we will call FUSE_OPEN instead in 
current code.

Now with this change, we will call FUSE_CREATE and file could still
be present. If it is a shared filesystem, file could be created by
another client anyway after lookup() completed and returned a non-existent
file. So server can still get FUSE_CREATE and file could be there.

But I understand that risk of regression is not zero. 

Given we are going to implement FUSE_CREATE_EXT in the same patch
series, I guess we could fix it easily by switching to FUSE_CREATE_EXT.

So that's my take. I will be willing to take this chance. Until and
unless ofcourse Miklos disagrees. :-)

Thanks
Vivek

> Out of the sudden user space
> implementations might need to handle it and some of them might get broken
> with that kernel update. I guess even a single broken user space
> implementation would count as regression.
> So I had asked to change the patch to require a user space flag.
> 
> -- Bernd
> 

