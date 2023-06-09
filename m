Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB5E728F72
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 07:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236808AbjFIF4X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 01:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjFIF4V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 01:56:21 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF4030D1
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jun 2023 22:56:18 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51640b9ed95so2427049a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jun 2023 22:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1686290177; x=1688882177;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VupVkyyldj3e8IO4Koe24GCKsHPLjfD46bPsF2Yow8M=;
        b=ZzuS+g0Ua0ZGWsPaxM68/G8mzH8SNqXzxnzLMJ3dqWv7V3u5NXG4/n7mfHdk78vSof
         AeMa72WucWAeer+/srTKZgXmK2hz+n23ZEcu71mL3GJaVFpWMH7w8DllR8FkLkZs+/PF
         Hr9ONFl1U+eNJQv0F3oOd5NmLYOOApl8f3mcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686290177; x=1688882177;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VupVkyyldj3e8IO4Koe24GCKsHPLjfD46bPsF2Yow8M=;
        b=ZIPAqPSXrYaCfT3acfJWFCXY9QCuRLRAvmwgqMkWb3M8QCGdoCEx9smz3gliSbN1CG
         y2mNew5ng4zTVhIaGnN9cwHYi7g4uXgEBtBIqtwg2Rk9F26h6w2kLfSxgYXKgWetsITw
         +lehI2L9U6mMoOB2r/OJeaBPFuGpf05gC5paR050NdS52jJdFz/Ic0XkMEI7SUeLniuY
         U4BXpmp5ZbYXUus3q4CL+wKEa0/wUuW4zWCmIv/ahfdczgUowitBy0D7/LTvSVXY4VOv
         xHnFfMrDlS/g5pjo+k5ZqS+VQYIo/7BjvhFazIRdebSScNlBdNN6v5CJWNao7vIpKRJK
         x/SA==
X-Gm-Message-State: AC+VfDyQJdyiRFitCJ14ONiBRJnFGXE0p4zgHzeEzRjUwiHmNrHp/C07
        yv+DbctNPFVSkOc9o2gmeDnbf26D23i1uYFJcrXTnA==
X-Google-Smtp-Source: ACHHUZ4SStOXisvZlF4hGjjGeckwrenfL8kHVAEuJGDXeORY/5CLk9vIXCYAxE714A3mkmZ1WI8U7cgDAlu4fjbYIr4=
X-Received: by 2002:a17:906:9756:b0:977:95f4:5ce1 with SMTP id
 o22-20020a170906975600b0097795f45ce1mr951745ejy.20.1686290176747; Thu, 08 Jun
 2023 22:56:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230505081652.43008-1-hao.xu@linux.dev> <ef307cf6-6f3a-adf8-f4aa-1cd780a0afc6@linux.dev>
 <09200d9b-20cb-5864-c42f-e08035d07cd9@fastmail.fm>
In-Reply-To: <09200d9b-20cb-5864-c42f-e08035d07cd9@fastmail.fm>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 9 Jun 2023 07:56:05 +0200
Message-ID: <CAJfpegsd5YEZyzisnfiocVCAwxP64=jgSqhJ5-hurzFA0=-0nw@mail.gmail.com>
Subject: Re: [fuse-devel] [PATCH] fuse: add a new flag to allow shared mmap in
 FOPEN_DIRECT_IO mode
To:     Bernd Schubert <bernd.schubert@fastmail.fm>
Cc:     Hao Xu <hao.xu@linux.dev>, fuse-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 8 Jun 2023 at 23:29, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
>
>
>
> On 6/8/23 09:17, Hao Xu wrote:
> > ping...
> >
> > On 5/5/23 16:16, Hao Xu wrote:
> >> From: Hao Xu <howeyxu@tencent.com>
> >>
> >> FOPEN_DIRECT_IO is usually set by fuse daemon to indicate need of strong
> >> coherency, e.g. network filesystems. Thus shared mmap is disabled since
> >> it leverages page cache and may write to it, which may cause
> >> inconsistence. But FOPEN_DIRECT_IO can be used not for coherency but to
> >> reduce memory footprint as well, e.g. reduce guest memory usage with
> >> virtiofs. Therefore, add a new flag FOPEN_DIRECT_IO_SHARED_MMAP to allow
> >> shared mmap for these cases.
> >>
> >> Signed-off-by: Hao Xu <howeyxu@tencent.com>
> >> ---
> >>   fs/fuse/file.c            | 11 ++++++++---
> >>   include/uapi/linux/fuse.h |  2 ++
> >>   2 files changed, 10 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> >> index 89d97f6188e0..655896bdb0d5 100644
> >> --- a/fs/fuse/file.c
> >> +++ b/fs/fuse/file.c
> >> @@ -161,7 +161,8 @@ struct fuse_file *fuse_file_open(struct fuse_mount
> >> *fm, u64 nodeid,
> >>       }
> >>       if (isdir)
> >> -        ff->open_flags &= ~FOPEN_DIRECT_IO;
> >> +        ff->open_flags &=
> >> +            ~(FOPEN_DIRECT_IO | FOPEN_DIRECT_IO_SHARED_MMAP);
> >>       ff->nodeid = nodeid;
> >> @@ -2509,8 +2510,12 @@ static int fuse_file_mmap(struct file *file,
> >> struct vm_area_struct *vma)
> >>           return fuse_dax_mmap(file, vma);
> >>       if (ff->open_flags & FOPEN_DIRECT_IO) {
> >> -        /* Can't provide the coherency needed for MAP_SHARED */
> >> -        if (vma->vm_flags & VM_MAYSHARE)
> >> +        /* Can't provide the coherency needed for MAP_SHARED.
> >> +         * So disable it if FOPEN_DIRECT_IO_SHARED_MMAP is not
> >> +         * set, which means we do need strong coherency.
> >> +         */
> >> +        if (!(ff->open_flags & FOPEN_DIRECT_IO_SHARED_MMAP) &&
> >> +            vma->vm_flags & VM_MAYSHARE)
> >>               return -ENODEV;
> >>           invalidate_inode_pages2(file->f_mapping);
> >> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> >> index 1b9d0dfae72d..003dcf42e8c2 100644
> >> --- a/include/uapi/linux/fuse.h
> >> +++ b/include/uapi/linux/fuse.h
> >> @@ -314,6 +314,7 @@ struct fuse_file_lock {
> >>    * FOPEN_STREAM: the file is stream-like (no file position at all)
> >>    * FOPEN_NOFLUSH: don't flush data cache on close (unless
> >> FUSE_WRITEBACK_CACHE)
> >>    * FOPEN_PARALLEL_DIRECT_WRITES: Allow concurrent direct writes on
> >> the same inode
> >> + * FOPEN_DIRECT_IO_SHARED_MMAP: allow shared mmap when
> >> FOPEN_DIRECT_IO is set
> >>    */
> >>   #define FOPEN_DIRECT_IO        (1 << 0)
> >>   #define FOPEN_KEEP_CACHE    (1 << 1)
> >> @@ -322,6 +323,7 @@ struct fuse_file_lock {
> >>   #define FOPEN_STREAM        (1 << 4)
> >>   #define FOPEN_NOFLUSH        (1 << 5)
> >>   #define FOPEN_PARALLEL_DIRECT_WRITES    (1 << 6)
> >> +#define FOPEN_DIRECT_IO_SHARED_MMAP    (1 << 7)
> >>   /**
> >>    * INIT request/reply flags
> >
> >
> >
>
> Sorry, currently get distracted by non-fuse work :/
>
> I think see the reply from Miklos on the initial question, which is on
> fuse-devel. Ah, I see you replied to it.
>
> https://sourceforge.net/p/fuse/mailman/message/37849170/
>
>
> I think what Miklos asks for, is to add a new FUSE_INIT reply flag and
> then to set something like fc->dio_shared_mmap. That way it doesn't need
> to be set for each open, but only once in the server init handler.
> @Miklos, please correct me if I'm wrong.

Yes, that's exactly what I suggested.

Thanks,
Miklos
