Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59231525136
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 May 2022 17:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355908AbiELPZA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 May 2022 11:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355895AbiELPY7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 May 2022 11:24:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD46E20E0A3
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 May 2022 08:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652369097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VH3REHakjNTgRKC3LbqfuuA6GdLQZCfJXpY/jhW2hW8=;
        b=aVVHBgSyYyrAVvhSNcLPGl0tr9V/R5mOX5nXUZ4ILH4xPV5QN5qs/NFLQah/M0b2eX34+A
        rvpqi5P3G7rfzY65mt/iRdnLvr9IeVSsTeYeiflnZ4YAjwve9NUQ+s5kYjbrA509JpX9qb
        g2SBFfq/Jq7nr+81Eocv0x/hVYJL4qQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-564-ETYdzzkIMTeXUkeMgPw9Hw-1; Thu, 12 May 2022 11:24:51 -0400
X-MC-Unique: ETYdzzkIMTeXUkeMgPw9Hw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6512B29324AE;
        Thu, 12 May 2022 15:24:51 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.210])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5384E7AE4;
        Thu, 12 May 2022 15:24:51 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 0E8AB220463; Thu, 12 May 2022 11:24:51 -0400 (EDT)
Date:   Thu, 12 May 2022 11:24:50 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Dharmendra Hans <dharamhans87@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Bernd Schubert <bschubert@ddn.com>,
        linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] FUSE: Implement atomic lookup + open/create
Message-ID: <Yn0mwjdOBPewes73@redhat.com>
References: <20220502102521.22875-1-dharamhans87@gmail.com>
 <YnLRnR3Xqu0cYPdb@redhat.com>
 <CACUYsyEsRph+iFC_fj3F6Ceqhq7NCTuFPH3up8R6C+_bGHktZg@mail.gmail.com>
 <YnPI6f2fRZUXbCFP@redhat.com>
 <882fbf7f-a56b-1e82-a158-9e2186ec7c4c@ddn.com>
 <YnQsizX5Q1sMnlI2@redhat.com>
 <CAJfpegseGaWHkjdQj7XiR=TQNFpPZzDF_rTXces2oRz=x0N7OA@mail.gmail.com>
 <YnvwiZ+s+y3VDUMW@redhat.com>
 <YnwOwS/bmUkbazeL@redhat.com>
 <CACUYsyGTR54tX8xqBqJ2LUfWO-rV0LqgBfy0xOv7f-dq65BX8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACUYsyGTR54tX8xqBqJ2LUfWO-rV0LqgBfy0xOv7f-dq65BX8Q@mail.gmail.com>
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

On Thu, May 12, 2022 at 01:46:12PM +0530, Dharmendra Hans wrote:
> On Thu, May 12, 2022 at 1:00 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > On Wed, May 11, 2022 at 01:21:13PM -0400, Vivek Goyal wrote:
> > > On Wed, May 11, 2022 at 11:40:59AM +0200, Miklos Szeredi wrote:
> > > > On Thu, 5 May 2022 at 21:59, Vivek Goyal <vgoyal@redhat.com> wrote:
> > > >
> > > > > Oh, I have no issues with the intent. I will like to see cut in network
> > > > > traffic too (if we can do this without introducing problems). My primary
> > > > > interest is that this kind of change should benefit virtiofs as well.
> > > >
> > > > One issue with that appears to be checking permissions.   AFAIU this
> > > > patchset only enables the optimization if default_permissions is
> > > > turned off (i.e. all permission checking is done by the server).  But
> > > > virtiofs uses the default_permissions model.
> > >
> > > IIUC, only 3rd patch mentions that default_permission should be turned
> > > off. IOW, first patch where lookup + create + open is a single operation
> > > and second patch which does "lookup + open" in a single operation does
> > > not seem to require that default_permissions are not in effect.
> > >
> > > So if first two patches work fine, I think virtiofs should benefit too.
> > > (IMHO, 3rd patch is too hacky anyway)
> > >
> > > W.r.t permission checks, looks like may_open() will finally be called
> > > after ->atomic_open(). So even if we open the file, we should still be
> > > able to check whether we have permissions to open the file or not
> > > after the fact.
> > >
> > > fs/namei.c
> > >
> > > path_openat()
> > > {
> > >       open_last_lookups()  <--- This calls ->atomic_open()
> > >       do_open()  <--- This calls may_open()
> > > }
> >
> > Actually I am not sure about it. I was playing with
> >
> > open(foo.txt, O_CREAT | O_RDWR, O_IRUSR)
> >
> > This succeeds if file is newly created but if file already existed, this
> > fails with -EACCESS
> >
> > So man 2 open says following. Thanks to Andy Price for pointing me to it.
> >
> >     Note that mode applies only to future accesses of the newly cre‐
> >     ated  file;  the  open()  call that creates a read-only file may
> >     well return a read/write file descriptor.
> >
> >
> > Now I am wondering how will it look like with first patch. Assume file
> > already exists on the server (But there is no negative dentry present)
> > and I do following. And assume file only has read permission for user
> > and I am trying to open it read-write.
> >
> > open(foo.txt, O_CREAT | O_RDWR, O_IRUSR)
> >
> > In normal circumstances, user will expect -EACCESS as file is read-only
> > and user is trying to open it read-write.
> >
> > I am wondering how will it look like with this first patch.
> >
> > Current fuse ->atomic_open() looks up the dentry and does not open
> > the file if dentry is positive.
> >
> > New implementation will skip lookup and open the file anyway and
> > set file->f_mode |= FMODE_CREATED; (First patch in series)
> >
> > So first of all this seems wrong. I thought FMODE_CREATED should be
> > set only if file was newly created. Is that a correct understanding.
> 
> You are right. we should mark in f_mode only if the file was actually created.
> Thanks for catching this. Appreciate your efforts:)
> 
> >
> > And I am looking at do_open() code. It does bunch of things based
> > on FMODE_CREATED flag. One of the things it does is reset acc_mode =0
> >
> >         if (file->f_mode & FMODE_CREATED) {
> >                 /* Don't check for write permission, don't truncate */
> >                 open_flag &= ~O_TRUNC;
> >                 acc_mode = 0;
> >         }
> >         error = may_open(mnt_userns, &nd->path, acc_mode, open_flag);
> >
> > I suspect this is the code which allows opening a newly created read-only
> > file as O_RDWR. (Though I am not 100% sure).
> 
> Correct. I could see it.
> 
> >
> > I suspect with first patch this will be broken. We will set FMODE_CREATED
> > even if file already existed and VFS will assume a new file has been
> > created and do bunch of things which is wrong.
> >
> > So looks like fuse ->atomic_open() should set FMODE_CREATED only if
> > it really created the file.
> 
> This looks like an obvious bug with new patches. But If I do not miss
> anything then its a bug on distributed file systems with current code
> as well.
> It could happen this way(Taking your example which is perfect to trace
> this on distributed systems):
> Lets start with File is non-existent yet on the file system. There
> comes the first client which does a lookup on the file, it does not
> find the file. Meanwhile another client created the file on the File
> system. Now  when this first client goes to create the file, before
> going down it sets FMODE_CREATED on the file handle and then goes down
> the lower layers. It comes back with inode but f->mode as
> FMODE_CREATED which is incorrect. This mode then results in acc_mode
> being set to zero which then allows access to the file as O_RDWR.

I think with current code (FUSE_CREATE), it is a race with shared
filesystems where multiple clients might be sharing this directory.

We are looking up dentry first and issue FUSE_CREATE only if dentry
is negative. Now it is possible that between lookup() + FUSE_CREATE,
another client dropped in same file in the directory. But one could
argue, that's something not detectable by this client. So from user's
perspective, this client created the file.

If we have a negative dentry, then we will not do the lookup and
assumption is that we created file (even if another client created
it between previous lookup and this creation).

So agreed, this is a race but might not be very harmful one because
looks like we are providing weaker coherency with FUSE as opposed
to local filesystems. In fact this case fuse server running on a
directory which is shared by multiple clients bothers me a lot. There
seem to be many corner cases where it is not clear what will happen
if another client is doing operation.

> 
> I think Miklos proposed to return the flag from user space if the file
> was actually created, this would solve two problems 1) this access
> problem and code execution going the wrong path 2) correct update if
> parent dir changed or not.

Agreed that we could use new command FUSE_ATOMIC_CREATE/FUSE_CREATE_EXT
to figure out if file was newly created or not and then set FMODE_CREATED
accordingly.

W.r.t dir change, I am assuming we are invalidating dir attributes just
because if we created file, it could change dir's mtime/ctime. So yes,
FUSE_ATOMIC_CREATE/FUSE_CREATE_EXT could return this info whether file
was actually crated or not and invalidate dir's attribute accordingly.

Thanks
Vivek

