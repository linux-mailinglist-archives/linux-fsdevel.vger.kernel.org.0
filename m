Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3D372B867
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 09:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbjFLHBy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 03:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbjFLHBv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 03:01:51 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BD91995;
        Sun, 11 Jun 2023 23:56:51 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-7607919000aso41565185a.3;
        Sun, 11 Jun 2023 23:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686552795; x=1689144795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F4exatAjzA6+D9Buih0I3sDbrZV0bAmcGM6sRCZZP0s=;
        b=HYmiP8Ge9spCsZn2rUdiKU7IDYwkgxcmKXOVO8k1XBUUmcLH01EUrGubVCscjjflZz
         Tg+h7pVWldJMw8vF+mZpJK9enuKkMYEi55FIUYyE5yP+xWIpq7fkGqe6kNLk9gxYz13e
         gS4rTx2vKRPbTZtQIbNXx4GRF3al8sHLpYYvHenq2rc2aD9xb4F0FbMIHX6MVctKcGNJ
         gRzZDFHCXbzruRkO8RmZF4CUQ/LVzNO5VFziVl7uniyw25E3eATD2eR9mc1+cxRxQrW1
         gUTZKmRj0nd/uw7OdJMJS8ut3iX5Fc+LCA++R5GgAX1QmvjR9CemYexZlkuVe0WvrU5D
         X30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686552795; x=1689144795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F4exatAjzA6+D9Buih0I3sDbrZV0bAmcGM6sRCZZP0s=;
        b=eQ81vNPrnMVkLyx/Mr5PVXdmK4xjuCJdLqzZuZ8Twcsj0Fg7AU7pDqCIc8ZQ3tsRJH
         siOnhEfss1K7iIY5LzxDDl2kiGkZ1kZoWhABM3mkUJIEqACYCHBkqaF7KqFrdOP53Xiw
         Uu0hQioremv1zArCx2KihpC/LJvtJCFUBv7E4r5XSGK710sEz/J7fBbuIhaaSaNSdt2C
         0ytJZ1TlCZw4pPTrdOhpgB5WJX7eU/5PqGmCuBRS1+9KqHhU7RKnhQAHLwLEVIPVpchp
         xK55lZz+2eO2ANCaDDubaKitWb+B6USbYyKuUFLbgf8vk1RLzLgxgtg/TmqcP2pjMxvt
         G/pw==
X-Gm-Message-State: AC+VfDwZM5K8DWyzaIbvhtGoIvY02iuebfuXJqzmRMfme4TEO2p/oINW
        ykaH2QfClDWmJLU9SBB9DCDsv+pHcN6RDPYjc9Ic3SlgJjQ=
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
