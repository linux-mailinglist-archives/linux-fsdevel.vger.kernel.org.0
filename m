Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B05B51A286
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 May 2022 16:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351494AbiEDOvH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 May 2022 10:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351491AbiEDOu7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 May 2022 10:50:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 03E142250A
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 May 2022 07:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651675641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=83XwaEEfaZ3NQ5qpNsHQ3HrAzlX9bBiaOk5M25qS4NI=;
        b=eXWi63bbWA1IlNJiqcLS0erxmn62SqPB25gnF5be1qt5oOpHCqY8YLM0XAw53hCVI4Z7OC
        4FIxf2gNw7pBxWUscKUCP5fKpePCSEXActISVKsA+BXMQv6dPHwtE7L71Q2TjGq9eaiHYS
        UfzTQC6ZhOPFcg4WgXYxDlf6tk2IExk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-322-AdMMV6ByMUapoIn0_ZJ4qg-1; Wed, 04 May 2022 10:47:17 -0400
X-MC-Unique: AdMMV6ByMUapoIn0_ZJ4qg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 12BC3397968D;
        Wed,  4 May 2022 14:47:17 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.16.200])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C4B309E8E;
        Wed,  4 May 2022 14:47:16 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 7A9B0220463; Wed,  4 May 2022 10:47:16 -0400 (EDT)
Date:   Wed, 4 May 2022 10:47:16 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Dharmendra Hans <dharamhans87@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org, Bernd Schubert <bschubert@ddn.com>,
        Dharmendra Singh <dsingh@ddn.com>
Subject: Re: [PATCH v4 1/3] FUSE: Implement atomic lookup + create
Message-ID: <YnKR9CFYPXT1bM1F@redhat.com>
References: <20220502102521.22875-1-dharamhans87@gmail.com>
 <20220502102521.22875-2-dharamhans87@gmail.com>
 <YnGIUOP2BezDAb1k@redhat.com>
 <CACUYsyGoX+o19u41cZyF92eDBO-9rFN_EEWBvWBGrEMuNn29Mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACUYsyGoX+o19u41cZyF92eDBO-9rFN_EEWBvWBGrEMuNn29Mw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 04, 2022 at 09:56:49AM +0530, Dharmendra Hans wrote:
> On Wed, May 4, 2022 at 1:24 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > On Mon, May 02, 2022 at 03:55:19PM +0530, Dharmendra Singh wrote:
> > > From: Dharmendra Singh <dsingh@ddn.com>
> > >
> > > When we go for creating a file (O_CREAT), we trigger
> > > a lookup to FUSE USER SPACE. It is very  much likely
> > > that file does not exist yet as O_CREAT is passed to
> > > open(). This lookup can be avoided and can be performed
> > > as part of create call into libfuse.
> > >
> > > This lookup + create in single call to libfuse and finally
> > > to USER SPACE has been named as atomic create. It is expected
> > > that USER SPACE create the file, open it and fills in the
> > > attributes which are then used to make inode stand/revalidate
> > > in the kernel cache. Also if file was newly created(does not
> > > exist yet by this time) in USER SPACE then it should be indicated
> > > in `struct fuse_file_info` by setting a bit which is again used by
> > > libfuse to send some flags back to fuse kernel to indicate that
> > > that file was newly created. These flags are used by kernel to
> > > indicate changes in parent directory.
> >
> > Reading the existing code a little bit more and trying to understand
> > existing semantics. And that will help me unerstand what new is being
> > done.
> >
> > So current fuse_atomic_open() does following.
> >
> > A. Looks up dentry (if d_in_lookup() is set).
> > B. If dentry is positive or O_CREAT is not set, return.
> > C. If server supports atomic create + open, use that to create file and
> >    open it as well.
> > D. If server does not support atomic create + open, just create file
> >    using "mknod" and return. VFS will take care of opening the file.
> >
> > Now with this patch, new flow is.
> >
> > A. Look up dentry if d_in_lookup() is set as well as either file is not
> >    being created or fc->no_atomic_create is set. This basiclally means
> >    skip lookup if atomic_create is supported and file is being created.
> >
> > B. Remains same. if dentry is positive or O_CREATE is not set, return.
> >
> > C. If server supports new atomic_create(), use that.
> >
> > D. If not, if server supports atomic create + open, use that
> >
> > E. If not, fall back to mknod and do not open file.
> >
> > So to me this new functionality is basically atomic "lookup + create +
> > open"?
> >
> > Or may be not. I see we check "fc->no_create" and fallback to mknod.
> >
> >         if (fc->no_create)
> >                 goto mknod;
> >
> > So fc->no_create is representing both old atomic "create + open" as well
> > as new "lookup + create + open" ?
> >
> > It might be obvious to you, but it is not to me. So will be great if
> > you shed some light on this.
> >
> 
> I think you got it right now. New atomic create does what you
> mentioned as new flow.  It does  lookup + create + open in single call
> (being called as atomic create) to USER SPACE.mknod is a special case

Ok, naming is little confusing. I think we will have to put it in
commit message and where you define FUSE_ATOMIC_CREATE that what's
the difference between FUSE_CREATE and FUSE_ATOMIC_CREATE. This is
ATOMIC w.r.t what?

May be atomic here means that "lookup + create + open" is a single operation.
But then even FUSE_CREATE is atomic because "creat + open" is a single
operation.

In fact FUSE_CREATE does lookup anyway and returns all the information
in fuse_entry_out. 

IIUC, only difference between FUSE_CREATE and FUSE_ATOMIC_CREATE is that
later also carries information in reply whether file was actually created
or not (FOPEN_FILE_CREATED). This will be set if file did not exist
already and it was created indeed. Is that right?

I see FOPEN_FILE_CREATED is being used to avoid calling
fuse_dir_changed(). That sounds like a separate optimization and probably
should be in a separate patch.

IOW, I think this patch should be broken in to multiple pieces. First
piece seems to be avoiding lookup() and given the way it is implemented,
looks like we can avoid lookup() even by using existing FUSE_CREATE
command. We don't necessarily need FUSE_ATOMIC_CREATE. Is that right?

And once that is done, a separate patch should probably should explain
the problem and say fuse_dir_changed() call can be avoided if we knew
if file was actually created or it was already existing there. And that's
when one need to introduce a new command. Given this is just an extension
of existing FUSE_CREATE command and returns additiona info about
FOPEN_FILE_CREATED, we probably should simply call it FUSE_CREATE_EXT
and explain how this operation is different from FUSE_CREATE.

Thanks
Vivek

> where the file system does not have a create call implemented. I think
> its legacy probably goes back to Linux 2.4 if I am not wrong. We did
> not make any changes into that.

> 
> Second patch avoids lookup for open calls. 3rd patch avoids lookup in
> de_revalidate() but for non-dir. And only in case when default
> permissions are not enabled.
> 

