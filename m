Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889B77BD51E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 10:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234411AbjJIIZz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 04:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234427AbjJIIZw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 04:25:52 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8043CA;
        Mon,  9 Oct 2023 01:25:50 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-4181462ebf0so29016161cf.3;
        Mon, 09 Oct 2023 01:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696839950; x=1697444750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwxPdUcHaibsrxYvwpGbDBkqiW6VS81MmSdHxB6d/UU=;
        b=HOLrBlQ7vosFfuZRP9dLTHNuNbLt0XPMn8TEAVHVd+9eUT8t4CpPfGHJbl4nBAYnD7
         osTvbNN3zeTJABOxP/INCa9PUlCL7Jy2oXvs7/eJyLhqfue2F7DzpMTJv6iFJnB9heyl
         7VZSdC+rT9eL0qPXmrp/Z1sw/CctuigDCCcfJ7jU4qIK5XgYmhzluW0WskZe1oW6f2JA
         BflrMgV5P+1dga1TxkXiyiH8Qk/ygTacECAPmyqgf57xc5X8JL7pQ1a9Z5MQXwKFfGOU
         BlSHFU3hDfxIaJ+SjAr8RrsFMWfx25sK2GNT6M2tnNfBroWSP5fpa/Fq5i/frAqGOcFa
         JpYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696839950; x=1697444750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cwxPdUcHaibsrxYvwpGbDBkqiW6VS81MmSdHxB6d/UU=;
        b=EuQzdzOYfDOI6BtFcHHQFpj8rSbaFLLlck83c+5OfHg1gtpem/1Ui8pDFI99OodUVc
         1nYbjiNgk6qBGH08Dvcsw9rEtZ637ojih3Y2dvbAgyF09eJHaZo1NmG3mF5ZwN08Nl1J
         5Z1VAS8VrVkl/KstQiab7oVi1jMh5yA7ZllTGdTczhogzYbhaTGQ2HYCMub45OlyfsQt
         eNzS+bUA7khrhLdkMYSwQNgXG8sP8jqB4WJ5EJRM5OsOZUZMf7AvMsu9CApu90dv4xfl
         /aAr+3Vf1bPAMteflIZhwykL4V7vvPLx6vOvHkzAlG1qm+7TblzRqOBfGKdEzS8+dujH
         kDVg==
X-Gm-Message-State: AOJu0YwnYapSMfiR8HX1CGo/wtwkNDXb8ryWK6zn2v15rQEbPcm9wh8N
        KIe66aV7pZ6jjMLS1td9xi56XjReQ2X0f+/e6Qc=
X-Google-Smtp-Source: AGHT+IGrgWE0CV7sTHwHmJE4PpVAfm0gZ3v19NBFAecwIdkDVQ/0o7BfqjBhUXZiO1xinh8AH6pN2LwEgiIPCRrAFWU=
X-Received: by 2002:ac8:5b0e:0:b0:419:5146:115e with SMTP id
 m14-20020ac85b0e000000b004195146115emr18651114qtw.50.1696839949825; Mon, 09
 Oct 2023 01:25:49 -0700 (PDT)
MIME-Version: 1.0
References: <20231007084433.1417887-1-amir73il@gmail.com> <20231007084433.1417887-4-amir73il@gmail.com>
 <20231009074809.GH800259@ZenIV>
In-Reply-To: <20231009074809.GH800259@ZenIV>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 9 Oct 2023 11:25:38 +0300
Message-ID: <CAOQ4uxhSEDF8G8_7Zr+OnMq7miNen6O=AXQV1-xAs7ABvXs0Mg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] fs: store real path instead of fake path in
 backing file f_path
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 9, 2023 at 10:48=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Sat, Oct 07, 2023 at 11:44:33AM +0300, Amir Goldstein wrote:
>
> > -             if (real_path->mnt)
> > -                     mnt_put_write_access(real_path->mnt);
> > +             if (user_path->mnt)
> > +                     mnt_put_write_access(user_path->mnt);
> >       }
> >  }
>
> Again, how can the predicates be ever false here?  We should *not*
> have struct path with NULL .mnt unless it's {NULL, NULL} pair.
>
> For the record, struct path with NULL .dentry and non-NULL .mnt
> *IS* possible, but only in a very narrow area - if, during
> an attempt to fall back from rcu pathwalk to normal one we
> have __legitimize_path() successfully validate (=3D=3D grab) the
> reference to mount, but fail to validate dentry.  In that
> case we need to drop mount, but not dentry when we get to
> cleanup (pretty much as soon as we drop rcu_read_lock()).
> That gets indicated by clearing path->dentry, and only
> while we are propagating the error back to the point where
> references would be dropped.  No filesystem code should
> ever see struct path instances in that state.
>
> Please, don't make the things more confusing; "incomplete"
> struct path like that are very much not normal (and this
> variety is flat-out impossible).
>
>

No problem.
I will remove the conditional.

> > @@ -34,9 +34,18 @@ static struct dentry *ovl_d_real(struct dentry *dent=
ry,
> >       struct dentry *real =3D NULL, *lower;
> >       int err;
> >
> > -     /* It's an overlay file */
> > +     /*
> > +      * vfs is only expected to call d_real() with NULL from d_real_in=
ode()
> > +      * and with overlay inode from file_dentry() on an overlay file.
> > +      *
> > +      * TODO: remove @inode argument from d_real() API, remove code in=
 this
> > +      * function that deals with non-NULL @inode and remove d_real() c=
all
> > +      * from file_dentry().
> > +      */
> >       if (inode && d_inode(dentry) =3D=3D inode)
> >               return dentry;
> > +     else
> > +             WARN_ON_ONCE(inode);
> >
> >       if (!d_is_reg(dentry)) {
> >               if (!inode || inode =3D=3D d_inode(dentry))
>                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>         BTW, that condition is confusing as hell (both before and
> after this patch).  AFAICS, it's a pointlessly obfuscated
>                 if (!inode)
> Look: we get to evaluating that test only if we hadn't buggered
> off on
>         if (inode && d_inode(dentry) =3D=3D inode)
>                 return dentry;
> above.  Which means that either inode is NULL (in which case the
> evaluation yields true as soon as we see that !inode is true) or
> it's neither NULL nor equal to d_inode(dentry).  In which case
> we see that !inode is false and proceed yield false *after*
> comparing inode with d_inode(dentry) and seeing that they
> are not equal.
>
> <checks history>
> e8c985bace13 "ovl: deal with overlay files in ovl_d_real()"
> had introduced the first check, and nobody noticed that the
> older check below could've been simplified.  Oh, well...
>

Absolutely right.
I can remove the pointless condition.

FWIW, the next step after dust from this patch set settles
is to make file_dentry(f) :=3D ((f)->f_path.dentry) and remove
the non-NULL inode case from ->d_real() interface altogether,
so this confusing check was going to go away soon anyway.

> > -static inline const struct path *file_real_path(struct file *f)
> > +static inline const struct path *f_path(struct file *f)
> >  {
> > -     if (unlikely(f->f_mode & FMODE_BACKING))
> > -             return backing_file_real_path(f);
> >       return &f->f_path;
> >  }
>
> Bad name, IMO - makes grepping harder and... what the hell do
> we need it for, anyway?  You have only one caller, and no
> obvious reason why it would be worse off as path =3D &file->f_path...

It's not important. I don't mind dropping it.

If you dislike that name f_path(), I guess you are not a fan of
d_inode() either...

FYI, I wanted to do a file_path() accessor to be consistent with
file_inode() and file_dentry(), alas file_path() is used for something
completely different.

I find it confusing that {file,dentry,d}_path() do not return a path
but a path string, but whatever.

Thanks,
Amir.
