Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24647C031C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 19:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343490AbjJJR5g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Oct 2023 13:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbjJJR5f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Oct 2023 13:57:35 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F136A99;
        Tue, 10 Oct 2023 10:57:33 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3ae2ec1a222so4184497b6e.2;
        Tue, 10 Oct 2023 10:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696960653; x=1697565453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zptPlzUl3SgFeV2lVFZadrHTiGGbcD/SfNgiR3FjtuE=;
        b=if2zkc7l7N8cb7jX/Z7qnQzsDkHECYGwXFg+5nOIWQlxg6zdlVMlBxStlUDZXk5JRu
         VLnwmSjUcJKDvUG2Sh23tTpvufYLWvflC8rmMCRgBm15XwSKzDyw1rDEXiHCIxNYqwYX
         QxSw0c9JUQ1gSb5AqJ6jlRrCSs5sbBCEOKEcghFH/G3eK/aCpvsPV7uz07bZK8lcT91e
         pw7W8ChA7jdue0BQbPfTlsQuuu++pTadVQDin+88I+RVIbnc1HuBRkAYMFgfqIi89TyA
         wOTTd3fZhAkZdN7+zB6X1PbOpyl7S7pC15YOEIkteIHYjb56NorV9DJLJjOFxDZzJso3
         iHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696960653; x=1697565453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zptPlzUl3SgFeV2lVFZadrHTiGGbcD/SfNgiR3FjtuE=;
        b=GFeiiDc1PKketJTbUj68yKtUZSbGI3WoIB/PhzsK0TBSpQyMK5PMrrmxdjSN0b/9TT
         EsV6ZfE+p5om0q8BEtxKPVIiu5hZ35CX62NK1am3EhDCGZB9nVrq0ZQOwdg3qSAHVA/L
         hD2tXu+wRZDZQfsLHutuUkLhIT1I7iBSAjf/PDdRGLzwkCkxpOwBIgp3bBceQcsmNhyv
         sLRKdgRBxcIDCoqKQxUIn/YaOefPzR8AX00bSHtxWkNudVcKSwq9d/3vEB/2gCB1ttqq
         GQRcF6EpvByowVPCMxvOwLlePYROdas+FLlVH03imiQm+SroBHkHVUmhhYRt2dYjriQA
         oGaA==
X-Gm-Message-State: AOJu0YxdD8Oa9k/Bk+rh6I2Vwxu12Nfn/k+PP4IC9a2G+YVrGu8FLNu9
        kYKpOkR8v0QVuyAuN3Ds/Gdh/lrQRnErSKDF2QPt4CYcjaw=
X-Google-Smtp-Source: AGHT+IGBRwJnC5g/Bzo6dY5sekSpwV0DhzJ+x9+W5bNNFYTYyyGTfT7YovLk1qrPMZaaDEcjbhNVbibVTmxI4mzvhNw=
X-Received: by 2002:a05:6808:2918:b0:3a7:6d64:aa68 with SMTP id
 ev24-20020a056808291800b003a76d64aa68mr19757727oib.18.1696960653173; Tue, 10
 Oct 2023 10:57:33 -0700 (PDT)
MIME-Version: 1.0
References: <20231009153712.1566422-1-amir73il@gmail.com> <20231009153712.1566422-4-amir73il@gmail.com>
 <CAJfpegtcNOCMp+QBPFD5aUEok6u7AqwrGqAqMCZeeuyq6xfYFw@mail.gmail.com>
 <CAOQ4uxiAHJy6viXBubm0y7x3J3P7N5XijOU8C340fi2Dpc7zXA@mail.gmail.com>
 <CAOQ4uxipA5oCQXn1-JZ+TbXw2-5O+_++FfNHC6fKqhNXfR7C0w@mail.gmail.com>
 <CAJfpeguEf71ZknP5rGU9YNtJTp1wBGBKyv6M0JZ=5ETuaipDxQ@mail.gmail.com>
 <20231010165504.GP800259@ZenIV> <20231010174146.GQ800259@ZenIV>
In-Reply-To: <20231010174146.GQ800259@ZenIV>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 10 Oct 2023 20:57:21 +0300
Message-ID: <CAOQ4uxjHKU0q8dSBQhGpcdp-Dg1Hx-zxs3AurXZBQnKBkV7PAw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] fs: store real path instead of fake path in
 backing file f_path
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 10, 2023 at 8:41=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Tue, Oct 10, 2023 at 05:55:04PM +0100, Al Viro wrote:
> > On Tue, Oct 10, 2023 at 03:34:45PM +0200, Miklos Szeredi wrote:
> > > On Tue, 10 Oct 2023 at 15:17, Amir Goldstein <amir73il@gmail.com> wro=
te:
> > >
> > > > Sorry, you asked about ovl mount.
> > > > To me it makes sense that if users observe ovl paths in writable ma=
pped
> > > > memory, that ovl should not be remounted RO.
> > > > Anyway, I don't see a good reason to allow remount RO for ovl in th=
at case.
> > > > Is there?
> > >
> > > Agreed.
> > >
> > > But is preventing remount RO important enough to warrant special
> > > casing of backing file in generic code?  I'm not convinced either
> > > way...
> >
> > You definitely want to guarantee that remounting filesystem r/o
> > prevents the changes of visible contents; it's not just POSIX,
> > it's a fairly basic common assumption about any local filesystems.
>
> Incidentally, could we simply keep a reference to original struct file
> instead of messing with path?
>
> The only caller of backing_file_open() gets &file->f_path as user_path; h=
ow
> about passing file instead, and having backing_file_open() do get_file()
> on it and stash the sucker into your object?
>
> And have put_file_access() do
>         if (unlikely(file->f_mode & FMODE_BACKING))
>                 fput(backing_file(file)->file);
> in the end.
>
> No need to mess with write access in any special way and it's closer
> to the semantics we have for normal mmap(), after all - it keeps the
> file we'd passed to it open as long as mapping is there.
>
> Comments?

Seems good to me.
It also shrinks backing_file by one pointer.

I think this patch can be an extra one after
"fs: store real path instead of fake path in backing file f_path"

Instead of changing storing of real_path to storing orig file in
one change?

If there are no objections, I will write it up.

Thanks,
Amir.
