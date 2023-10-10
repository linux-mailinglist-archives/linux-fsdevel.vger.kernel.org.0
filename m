Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432307C032F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 20:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233829AbjJJSOa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Oct 2023 14:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbjJJSO3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Oct 2023 14:14:29 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2869D
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Oct 2023 11:14:28 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-534659061afso9944138a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Oct 2023 11:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1696961666; x=1697566466; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z6oXJ5/osR28vOIjclD1LhvIDMED+yl0ZCE2WtfM0JA=;
        b=QM79X0oTOTqEF8PGrgQ3BpZoe9ArmiUts/vu0paz8o5DT5GdPrFEQNizJyP1lmaRBe
         V7IXVfFYd/dCz72zeuLZxOywu20x/o12W7gX8FA3oSZ91zmF4oMWlcJBFv+uJby4BJcH
         fvayuMIDbCyQ4erXVxUwNe3vTLBe1ZqStel2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696961666; x=1697566466;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z6oXJ5/osR28vOIjclD1LhvIDMED+yl0ZCE2WtfM0JA=;
        b=In4w6q74YAPs1BMRyxKKUUGDOOR1qaq6OSgtd2LLj7cv6rxSfZ9SOXZENJHkqfgmGA
         37+VvY3Idp34uh/91TOJQWl1wVvyUZm2hax6fBkSsf0f6GoxXE6Z+ZxEEHO5Knv5PMHn
         yHs5kL+AXBObv2dao+B9wPvajO8YXtIEMJdIlYboEJbp3YnlnJ6S1vkdr6A3S+FW12q8
         X4aG7t7OF4zcvVKSDeleHhaY9dP/ldlB/nqiqFnOuxLG1/xJObTKtOzi8r2dkFKn66/O
         1YS9XGmybBuClE00zs62lsUDctHRHpEWi5hoDMogvLT7k+j/jTflYzVy5sG8M6H+wvhg
         9r5g==
X-Gm-Message-State: AOJu0YyKZaHFWeuHaWWVY2Z9mVOI8CsVzmmODhXDds29pTeCCqeT85ha
        OYlM0Q88NPlvZrZCag8CDKPIwCApDKUtKs+J8v3l4w==
X-Google-Smtp-Source: AGHT+IFu9tcAdt3cR1qhCtS2ky4YCRUrly0EnA7bD8oRuEElqbkPIUv6N2kIYYU1k45MrN3bW3bbvqPq6sJ/0l4ssUU=
X-Received: by 2002:a17:906:3188:b0:9ae:594d:d3fc with SMTP id
 8-20020a170906318800b009ae594dd3fcmr15250590ejy.17.1696961666408; Tue, 10 Oct
 2023 11:14:26 -0700 (PDT)
MIME-Version: 1.0
References: <20231009153712.1566422-1-amir73il@gmail.com> <20231009153712.1566422-4-amir73il@gmail.com>
 <CAJfpegtcNOCMp+QBPFD5aUEok6u7AqwrGqAqMCZeeuyq6xfYFw@mail.gmail.com>
 <CAOQ4uxiAHJy6viXBubm0y7x3J3P7N5XijOU8C340fi2Dpc7zXA@mail.gmail.com>
 <CAOQ4uxipA5oCQXn1-JZ+TbXw2-5O+_++FfNHC6fKqhNXfR7C0w@mail.gmail.com>
 <CAJfpeguEf71ZknP5rGU9YNtJTp1wBGBKyv6M0JZ=5ETuaipDxQ@mail.gmail.com>
 <20231010165504.GP800259@ZenIV> <20231010174146.GQ800259@ZenIV>
In-Reply-To: <20231010174146.GQ800259@ZenIV>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 10 Oct 2023 20:14:15 +0200
Message-ID: <CAJfpegtbOG0DqyuQ=xt2KDh5WDaZBb0tLJuhqa2jyQfHSMfO-w@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] fs: store real path instead of fake path in
 backing file f_path
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 10 Oct 2023 at 19:41, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Tue, Oct 10, 2023 at 05:55:04PM +0100, Al Viro wrote:
> > On Tue, Oct 10, 2023 at 03:34:45PM +0200, Miklos Szeredi wrote:
> > > On Tue, 10 Oct 2023 at 15:17, Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > > Sorry, you asked about ovl mount.
> > > > To me it makes sense that if users observe ovl paths in writable mapped
> > > > memory, that ovl should not be remounted RO.
> > > > Anyway, I don't see a good reason to allow remount RO for ovl in that case.
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
> The only caller of backing_file_open() gets &file->f_path as user_path; how
> about passing file instead, and having backing_file_open() do get_file()
> on it and stash the sucker into your object?
>
> And have put_file_access() do
>         if (unlikely(file->f_mode & FMODE_BACKING))
>                 fput(backing_file(file)->file);
> in the end.

That's much nicer, I like it.

Thanks,
Miklos
