Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F543523D77
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 21:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346908AbiEKTbH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 May 2022 15:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346871AbiEKTam (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 May 2022 15:30:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 73AD621A94C
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 12:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652297415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G5azXxOWE111/EFfPUBN7PUx3Chajjhv4r8b0ykR4aQ=;
        b=axTzt0DUw1kGTMFoeymyeW5OQwFseneJ21y9Mc9aJrTkGEnpquWxp/1vQtYFs87jVKHtSQ
        3qMlOzilpS/2Tw3saNH+hYx/99UGPoZDzACboI1bNao9i2QcyLpyK+r4B9GE+Zj/QaH9WO
        7vIohW37UrwwpGLu2crHK1UH+gSI+5s=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-G3ZpW4pAPh23HfnJ9Ip6lA-1; Wed, 11 May 2022 15:30:10 -0400
X-MC-Unique: G3ZpW4pAPh23HfnJ9Ip6lA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D44C43C62B62;
        Wed, 11 May 2022 19:30:09 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.18.223])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B19E7C15D58;
        Wed, 11 May 2022 19:30:09 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 6D9EC220463; Wed, 11 May 2022 15:30:09 -0400 (EDT)
Date:   Wed, 11 May 2022 15:30:09 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Bernd Schubert <bschubert@ddn.com>,
        Dharmendra Hans <dharamhans87@gmail.com>,
        linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] FUSE: Implement atomic lookup + open/create
Message-ID: <YnwOwS/bmUkbazeL@redhat.com>
References: <20220502102521.22875-1-dharamhans87@gmail.com>
 <YnLRnR3Xqu0cYPdb@redhat.com>
 <CACUYsyEsRph+iFC_fj3F6Ceqhq7NCTuFPH3up8R6C+_bGHktZg@mail.gmail.com>
 <YnPI6f2fRZUXbCFP@redhat.com>
 <882fbf7f-a56b-1e82-a158-9e2186ec7c4c@ddn.com>
 <YnQsizX5Q1sMnlI2@redhat.com>
 <CAJfpegseGaWHkjdQj7XiR=TQNFpPZzDF_rTXces2oRz=x0N7OA@mail.gmail.com>
 <YnvwiZ+s+y3VDUMW@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YnvwiZ+s+y3VDUMW@redhat.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 11, 2022 at 01:21:13PM -0400, Vivek Goyal wrote:
> On Wed, May 11, 2022 at 11:40:59AM +0200, Miklos Szeredi wrote:
> > On Thu, 5 May 2022 at 21:59, Vivek Goyal <vgoyal@redhat.com> wrote:
> > 
> > > Oh, I have no issues with the intent. I will like to see cut in network
> > > traffic too (if we can do this without introducing problems). My primary
> > > interest is that this kind of change should benefit virtiofs as well.
> > 
> > One issue with that appears to be checking permissions.   AFAIU this
> > patchset only enables the optimization if default_permissions is
> > turned off (i.e. all permission checking is done by the server).  But
> > virtiofs uses the default_permissions model.
> 
> IIUC, only 3rd patch mentions that default_permission should be turned
> off. IOW, first patch where lookup + create + open is a single operation
> and second patch which does "lookup + open" in a single operation does
> not seem to require that default_permissions are not in effect.
> 
> So if first two patches work fine, I think virtiofs should benefit too.
> (IMHO, 3rd patch is too hacky anyway)
> 
> W.r.t permission checks, looks like may_open() will finally be called
> after ->atomic_open(). So even if we open the file, we should still be
> able to check whether we have permissions to open the file or not
> after the fact.
> 
> fs/namei.c
> 
> path_openat()
> {
> 	open_last_lookups()  <--- This calls ->atomic_open()
> 	do_open()  <--- This calls may_open()
> }

Actually I am not sure about it. I was playing with 

open(foo.txt, O_CREAT | O_RDWR, O_IRUSR)

This succeeds if file is newly created but if file already existed, this
fails with -EACCESS

So man 2 open says following. Thanks to Andy Price for pointing me to it.

    Note that mode applies only to future accesses of the newly cre‐
    ated  file;  the  open()  call that creates a read-only file may
    well return a read/write file descriptor.


Now I am wondering how will it look like with first patch. Assume file
already exists on the server (But there is no negative dentry present)
and I do following. And assume file only has read permission for user
and I am trying to open it read-write.

open(foo.txt, O_CREAT | O_RDWR, O_IRUSR)

In normal circumstances, user will expect -EACCESS as file is read-only
and user is trying to open it read-write.

I am wondering how will it look like with this first patch.

Current fuse ->atomic_open() looks up the dentry and does not open
the file if dentry is positive.

New implementation will skip lookup and open the file anyway and
set file->f_mode |= FMODE_CREATED; (First patch in series)

So first of all this seems wrong. I thought FMODE_CREATED should be
set only if file was newly created. Is that a correct understanding.

And I am looking at do_open() code. It does bunch of things based
on FMODE_CREATED flag. One of the things it does is reset acc_mode =0

        if (file->f_mode & FMODE_CREATED) {
                /* Don't check for write permission, don't truncate */
                open_flag &= ~O_TRUNC;
                acc_mode = 0;
	}
	error = may_open(mnt_userns, &nd->path, acc_mode, open_flag);

I suspect this is the code which allows opening a newly created read-only
file as O_RDWR. (Though I am not 100% sure).

I suspect with first patch this will be broken. We will set FMODE_CREATED
even if file already existed and VFS will assume a new file has been
created and do bunch of things which is wrong.

So looks like fuse ->atomic_open() should set FMODE_CREATED only if
it really created the file.

Thanks
Vivek

