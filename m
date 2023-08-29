Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35A678C468
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 14:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235521AbjH2Mm4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 08:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjH2MmZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 08:42:25 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4467D2
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Aug 2023 05:42:22 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99c1f6f3884so542343466b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Aug 2023 05:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1693312941; x=1693917741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TemF0jUjMAO+8hJZS7nEbVsze7Vi55cm3C8VYiV8NKU=;
        b=Nl87rNoPS83EQR+PwTR149vZ4Vsgd3FN2ceLP6dCGbu6jfFoRQfLtj51aVW18OJVcN
         9kCDN7t6xwjd78J9iebgDJ54KGnkhyUJiAGoj6NWfxx/WBIeTYgLSonZBS24TY0+SwqU
         AMC36Nu54zR//2pHgzHsGqmAWBQVs4wjHn2hs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693312941; x=1693917741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TemF0jUjMAO+8hJZS7nEbVsze7Vi55cm3C8VYiV8NKU=;
        b=S/vZDfL/85wm2+N4/LkreD9vxwpEtHIaVSSHtqlsva0tu8tBn4RdkdQVsmGpxZoZwG
         ZGh3vEOT9u5mFl+8V1SzTunR8SlsMh7zaU+T3rLz1tHeHS/Czz6KdctYmVoRTO/X5vro
         EylNW2UM/WI4JRat1+XDxS9PpwyslmtXC2RmY3q5eMsiFJRcQwHi/1cDtN/8L4x5Fa30
         UyM7ylaPB6a+36S1B3Dq8jLKtT4h8yR+nQcX/aQv31vqk6ww6xsJG+cbmjXOTRfBPH97
         2FOmwN2pafMhrauANE2YicPMT3HEOk0Xcm1Bnr0Agj0+Onucq/hQwVCV/4TSM0lcUYn7
         BJTg==
X-Gm-Message-State: AOJu0Yz9Gue/y1mwaPy5Z4O5DBIREFinro4JajR2zNS3QMiEsrWrCYOD
        tijpaT0LxKFkXWKufrIEIg9HdPrD80bZX0tGCJNYug==
X-Google-Smtp-Source: AGHT+IGJ0ydHLDAokapfFjVf0X192kt5yyGqnkaENd6kAcH7qyGwUNEfb3IGvy5ZcA06uzhmDt10c0bFuIQTtJwCU3Y=
X-Received: by 2002:a17:906:1dd:b0:99b:dd1d:bc58 with SMTP id
 29-20020a17090601dd00b0099bdd1dbc58mr23749885ejj.41.1693312941245; Tue, 29
 Aug 2023 05:42:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230519125705.598234-1-amir73il@gmail.com> <20230519125705.598234-6-amir73il@gmail.com>
 <CAJfpeguhmZbjP3JLqtUy0AdWaHOkAPWeP827BBWwRFEAUgnUcQ@mail.gmail.com>
 <CAOQ4uxhYZqe0-r9knvdW_BWNvfeKapiwReTv4FWr_Px+CB+ENw@mail.gmail.com>
 <CAOQ4uxhBeFSV7TFuWXBgJZuu-eJBjKcsshDdxCz-fie0MqwVcw@mail.gmail.com>
 <CAOQ4uxirdrsaHPyctxRgSMxb2mBHJCJqB12Eof02CnouExKgzQ@mail.gmail.com>
 <CAJfpegth3TASZKvc_HrhGLOAFSGiAriiqO6iCN2OzT2bu62aDA@mail.gmail.com> <CAOQ4uxgzYevVCaGBjjckOr1vv0gKvVPYiOAL6E_KQY-YQx_7hg@mail.gmail.com>
In-Reply-To: <CAOQ4uxgzYevVCaGBjjckOr1vv0gKvVPYiOAL6E_KQY-YQx_7hg@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 29 Aug 2023 14:42:09 +0200
Message-ID: <CAJfpeguDP8T8P4u6ipdwhJmiV3C40Okq+y6AkVs3A1eWFzSsvA@mail.gmail.com>
Subject: Re: [PATCH v13 05/10] fuse: Handle asynchronous read and write in passthrough
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@android.com>,
        fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 24 Aug 2023 at 14:12, Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Tue, Aug 22, 2023 at 2:03=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu=
> wrote:
> >
> > On Tue, 22 Aug 2023 at 12:18, Amir Goldstein <amir73il@gmail.com> wrote=
:
> > >
> > > On Mon, Aug 21, 2023 at 6:27=E2=80=AFPM Amir Goldstein <amir73il@gmai=
l.com> wrote:
> >
> > > > Getting back to this.
> > > > Did you mean something like that? (only compile tested)
> > > >
> > > > https://github.com/amir73il/linux/commits/backing_fs
> > > >
> > > > If yes, then I wonder:
> > > > 1. Is the difference between FUSE_IOCB_MASK and OVL_IOCB_MASK
> > > >     (i.e. the APPEND flag) intentional?
> >
> > Setting IOCB_APPEND on the backing file doesn't make a difference as
> > long as the backing file is not modified during the write.
> >
> > In overlayfs the case of the backing file being modified is not
> > defined, so I guess that's the reason to omit it.  However I don't see
> > a problem with setting it on the backing file either, the file
> > size/position is synchronized after the write, so nothing bad should
> > happen if the backing file was modified.
> >
>
> That raises the question if FUSE passthrough behavior is defined when
> backing file is being modified. Should it be any different than ovl?
> I don't really care if we set IOCB_APPEND or not, just if we need
> a different mask for ovl and FUSE.

Dunno.

I feel that instead of making the behavior defined when file is
modified behind fuse's back, there should be some mechanism between
the server and the client (userspace and kernel) that allows proper
handling of "remote" modification (oplocks/leases/younameit).

I thought about this quite a bit, and even have some patches for the
read-only lease case.  But this is far from trivial.

In the meantime just setting IOCB_APPEND is quite harmless, so I think
we should do it for both overlayfs and fuse for consistency.

>
> > > > 2. What would be the right way to do ovl_copyattr() on io completio=
n?
> > > >     Pass another completion handler to read/write helpers?
> > > >     This seems a bit ugly. Do you have a nicer idea?
> > > >
> >
> > Ugh, I missed that little detail.   I don't have a better idea than to
> > use a callback function.
> >
>
> Ok. added the cleanup callback.
> I think it's not that bad?
>
> https://github.com/amir73il/linux/commits/backing_fs

Looks good.


>
> > >
> > > Hmm. Looking closer, ovl_copyattr() in ovl_aio_cleanup_handler()
> > > seems a bit racy as it is not done under inode_lock().
> > >
>
> Decided to fix that by taking ovl inode spinlock inside ovl_copyattr()
> and did the same for ovl_file_accessed() for read ops.
>
> I've found and fixed two other issues with aio completion on this branch,
> one of them is a fix for a possible realfile refcount leak, so will proba=
bly
> need to backport this one.

Great.  Thanks.

Miklos
