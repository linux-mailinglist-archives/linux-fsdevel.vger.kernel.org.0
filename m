Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F507BD4CE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 10:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345469AbjJIIDi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 04:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345459AbjJIIDh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 04:03:37 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8469F;
        Mon,  9 Oct 2023 01:03:35 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-65d0da28fa8so26480546d6.0;
        Mon, 09 Oct 2023 01:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696838614; x=1697443414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q1nIHKqURNgS6hsXoVPp4SWJQjc4XuiXJwYAaygJdUs=;
        b=O+VS9DfjTBT0svlWaMSsLAm5iuR/plADJ3kEeUsUeDrYY/EUJcICy7/zaOfc251zvE
         ay2wXPUBQKfvXSbPgyD5M3aoMRkYaom618l1oqT/l1my5bW+A9UU/Fj2Va1Q/xL+G9uq
         pyig8DbWfExhZwr4vZQTy7GoNCld1JyhjiozxNrpOU3mX7uiPP9kIsyEn5oSfFYnol1L
         SGw/hfdOiVnYRJy2pubCm3sd+aCJHvRlic2BVVD32pX7tgGcXYGIrGZUe+Vl9oiy50qX
         npUrKAVbFhtiawvJZ7P6M4Mz9OTUzA26JXRbGh9ioB8BJQ+3Zu+FmqNKX3hw6fs49MAX
         bb0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696838614; x=1697443414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q1nIHKqURNgS6hsXoVPp4SWJQjc4XuiXJwYAaygJdUs=;
        b=V7GOhFbIWgHY0uuN0S2Ns+pQrrqd5vbp9+Q6W9ppn9ZcCvjBklvpUothJUnnpeoABz
         HpFRL32UVUBeDbGNi7sxvoocUhJlbCZ8Kypgq7Iz5vMzlc3aIpxREq3pnZVs9vZmzSra
         WW/kNVlmy3FBwBdC2eSFVtqWI8I7mfKK175z4DS3AZLF+UkIFMAIeWYqHsti3D2O7shm
         Nk2NOa8egLsOXsqaJoGD0nqZDIWO9e43lFeJG+gpjV1OjnuMsMfjXA/b5uMB848Nrqou
         hXPfN81ZU+hV0kwLP9iZl1cskZYE7EFslXAizQmZCTeZa40twhrA/Yx5tMnEsiER25+Z
         3hMg==
X-Gm-Message-State: AOJu0Yz3OEyxiZKgGdaEaKrhgIMQRyZ4FoxPagKVMzgd7bqHbvrdukkI
        IzjKK4iJxb+cWh53yg89Z4HaloHy/2M4Rev1U34=
X-Google-Smtp-Source: AGHT+IE3M5JCzAidNsX/AQ9FXIbzJ83NQTWibMotfaF+6g7HMZ3CNVIDHqyBp98AfSy75fSkxRcBkyLOhesTIUqOS20=
X-Received: by 2002:a0c:e804:0:b0:656:2696:9947 with SMTP id
 y4-20020a0ce804000000b0065626969947mr14927806qvn.18.1696838614572; Mon, 09
 Oct 2023 01:03:34 -0700 (PDT)
MIME-Version: 1.0
References: <20231007084433.1417887-1-amir73il@gmail.com> <20231007084433.1417887-2-amir73il@gmail.com>
 <20231009064330.GF800259@ZenIV>
In-Reply-To: <20231009064330.GF800259@ZenIV>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 9 Oct 2023 11:03:23 +0300
Message-ID: <CAOQ4uxj76yH+L6fE+XWsnXGx-ZFC+CCTxD0BZ9NO6UN7trSRZw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] fs: get mnt_writers count for an open backing
 file's real path
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
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

On Mon, Oct 9, 2023 at 9:43=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> On Sat, Oct 07, 2023 at 11:44:31AM +0300, Amir Goldstein wrote:
> > +static inline void file_put_write_access(struct file *file)
> > +{
> > +     put_write_access(file->f_inode);
> > +     mnt_put_write_access(file->f_path.mnt);
> > +     if (unlikely(file->f_mode & FMODE_BACKING)) {
> > +             struct path *real_path =3D backing_file_real_path(file);
> > +
> > +             if (real_path->mnt)
> > +                     mnt_put_write_access(real_path->mnt);
>
> IDGI.  Where do we get FMODE_BACKING combined with NULL real_path.mnt *AN=
D*
> put_file_access() possibly called?  Or file_get_write_access(), for
> that matter...

Right.
I was being over prudent here.

>
> FMODE_BACKING is set only in alloc_empty_backing_file().  The only caller
> is backing_file_open(), which immediately sets real_path to its third
> argument.  That could only come from ovl_open_realfile().  And if that
> had been called with buggered struct path, it would have already blown
> up on mnt_idmap(realpath->mnt).
>
> The only interval where such beasts exist is from
>         ff->file.f_mode |=3D FMODE_BACKING | FMODE_NOACCOUNT;
>         return &ff->file;
> in alloc_empty_backing_file() through
>
>         f->f_path =3D *path;
>         path_get(real_path);
>         *backing_file_real_path(f) =3D *real_path;
>
> in backing_file_open().  Where would that struct file (just allocated,
> never seen outside of local variables in those two scopes) be passed
> to get_file_write_access() or put_file_access()?
>
> Or am I misreading something?

No. You are right.
I admit that I did consider adding use cases in the future
where a backing_file real_path is initialized lazily, but that
is not the case with current overlayfs code, so we don't
need to worry about that now.

Thanks,
Amir.
