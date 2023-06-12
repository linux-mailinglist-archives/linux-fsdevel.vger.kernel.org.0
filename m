Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD33072B844
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 08:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbjFLGqm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 02:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbjFLGql (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 02:46:41 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40191718;
        Sun, 11 Jun 2023 23:41:40 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6b160f3f384so2153310a34.3;
        Sun, 11 Jun 2023 23:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686551883; x=1689143883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F4exatAjzA6+D9Buih0I3sDbrZV0bAmcGM6sRCZZP0s=;
        b=qLKBCROEPFUb9xE+j3Fg+if0Gu9f1P3M6cbUbzaVVNu0v/GQZCpiPp2+7Z02T1EOYq
         UWAhFbTtovTme3h3e9O7aFNgetwuPjjdkhb0c95Wo+P5XqFIBnakGcUQ6rM63MpOC1Mu
         mFYyR9eso3IL5/pmMeAJJrwUwmp0hijrrDf5ILK/PzMOfWNKurMXEyNZucjoNOz/cRkf
         WrafNnMy24egyEIwxOVz6GKu2ZJblOn0RACF8XmFU/2f1Yjr8FEn0VPqjbIaA55f5XL3
         A7bkU6jquC4e9/cAfmD/V2Jz8b0vxYqyXvSelXs4w0P4hJ0atccg11npNOb2Y/5ZXhFY
         +Ltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686551883; x=1689143883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F4exatAjzA6+D9Buih0I3sDbrZV0bAmcGM6sRCZZP0s=;
        b=gD3of2468wuYfV67SSv82y4bJVMRYO3Dw9nMSLMYl1YngVZYGyX7GTKIO5INGnieBt
         Y5CQ8pOIoljM4xBO6CZHy1kqxcis+RbrwCR1njhAuEJEUqZX68FOWO8/YlyCnYeF9sgs
         lxNNHoD88HeVSxAPRh4Btc7w3iDgdAi5d+wLKnA9HOCpQe0CU6o+1PGWjNfinFPqV0ZJ
         r1noiB6cGY9/PL/2zFhPoz14MGkMJXDNZluAleYfUE8WMK5wQR6xNqQdQype1i+lXYKi
         exkSNKvsrnfnYfk86mdtAIFuOsMxgQLthNRN1ymdG+gms3H0F2EtePdGYINDBGQJuHcz
         wCqQ==
X-Gm-Message-State: AC+VfDwCKy+zC3JeOe+8VLYzi92Z8XQxY9kxpBq+IV+oAyEG/TLH3rTw
        kJ52a8TB/qAdXnvL1MaNfXDIjR7OefYPHhP3gFgA5Cfttu8=
X-Google-Smtp-Source: ACHHUZ5MqUvpUdY0rwaAId/Ti6yvLpoO7CSrnFVfnXENtwlYP8lB028tL69I1eya+xT8fE0v2bTS85eKcRtR4b1md8M=
X-Received: by 2002:a05:6358:c122:b0:129:b96d:1b0d with SMTP id
 fh34-20020a056358c12200b00129b96d1b0dmr3266805rwb.1.1686551882745; Sun, 11
 Jun 2023 23:38:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230611194706.1583818-1-amir73il@gmail.com> <20230611194706.1583818-2-amir73il@gmail.com>
 <ZIai+UWrU9o2UVcJ@infradead.org>
In-Reply-To: <ZIai+UWrU9o2UVcJ@infradead.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 12 Jun 2023 09:37:51 +0300
Message-ID: <CAOQ4uxj0WjQHNN6qHEnXfijYSoiaZkCucvNQYTL4LH0TPLt28A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] fs: use fake_file container for internal files
 with fake f_path
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 12, 2023 at 7:45=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Sun, Jun 11, 2023 at 10:47:05PM +0300, Amir Goldstein wrote:
> > Overlayfs and cachefiles use open_with_fake_path() to allocate internal
> > files, where overlayfs also puts a "fake" path in f_path - a path which
> > is not on the same fs as f_inode.
>
> But cachefs doesn't, so this needs a better explanation / documentation.
>
> > Allocate a container struct file_fake for those internal files, that
> > is used to hold the fake path along with an optional real path.
>
> The idea looks sensible, but fake a is a really weird term here.
> I know open_with_fake_path also uses it, but we really need to
> come up with a better name, and also good documentation of the
> concept here.
>
> > +/* Returns the real_path field that could be empty */
> > +struct path *__f_real_path(struct file *f)
> > +{
> > +     struct file_fake *ff =3D file_fake(f);
> > +
> > +     if (f->f_mode & FMODE_FAKE_PATH)
> > +             return &ff->real_path;
> > +     else
> > +             return &f->f_path;
> > +}
>
> two of the three callers always have FMODE_FAKE_PATH set, so please
> just drop this helper and open code it in the three callers.
>

I wanted to keep the container opaque
I can make __f_real_path not check the flag at all
and only f_real_path will check the flag

> > +
> > +/* Returns the real_path if not empty or f_path */
> > +const struct path *f_real_path(struct file *f)
> > +{
> > +     const struct path *path =3D __f_real_path(f);
> > +
> > +     return path->dentry ? path : &f->f_path;
> > +}
> > +EXPORT_SYMBOL(f_real_path);
>
> This is only needed by the few places like nfsd or btrfs send
> that directlycall fsnotify and should at very least be
> EXPORT_SYMBOL_GPL.  But I suspect with all the exta code, fsnotify_file
> really should move out of line and have an EXORT_SYMBOL_GPL instead.
>

fsnotify_file() inline is expected to avoid to call to fsnotify()
due to the optimization of zero s_fsnotify_connector
in fsnotify_parents() - this was observed as needed by some benchmarks.

> > +
> > +const struct path *f_fake_path(struct file *f)
> > +{
> > +     return &f->f_path;
> > +}
> > +EXPORT_SYMBOL(f_fake_path);
>
> .. and this helper is completely pointless.
>
> > +extern struct file *alloc_empty_file(int flags, const struct cred *cre=
d);
> > +extern struct file *alloc_empty_file_fake(int flags, const struct cred=
 *cred);
> > +extern struct path *__f_real_path(struct file *f);
>
> Please drop all the pointless externs while you're at it.

sure,

Thanks,
Amir.
