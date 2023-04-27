Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0C16F078E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Apr 2023 16:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243883AbjD0Oe3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Apr 2023 10:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243466AbjD0Oe2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Apr 2023 10:34:28 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EC51BF9;
        Thu, 27 Apr 2023 07:34:27 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id ada2fe7eead31-43278f6d551so173760137.1;
        Thu, 27 Apr 2023 07:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682606066; x=1685198066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ghkJg/SBYWrrJ/Yr0EU7fpo3jGyK1p4tvs7lO0HzOsE=;
        b=nwIuEX3dAoRnsr1srxXP1Pp15n8Yiy5r0tIBkCNmsAYiM3RGw1BGXD5rroFCPlcuwJ
         pyISDGaV4mne8OzIlTM7GLYPWCIcry3p4EQFyJ3Q6pqMKf+QUu3dqPcaKwlYgaLN5uA4
         sXT65PP2+9n+m15+gjdWKfKnquECx2a/pn+PlfuH3tqnIBnmcO0PvV21DAwV98+A/IdJ
         YoFbl1V4Sd6G0NCU1fB7cq4p6k01AdDCAImhxxMWfn7zNl5kSFiSSL8bMNr82gwTkddR
         gUy5cxj5P4RobG9NyYk/8i0Q77eb5bJRSSH5xmCsr94uGUk9nlbhxmd/Nx0LYfwj/BUb
         vzuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682606066; x=1685198066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ghkJg/SBYWrrJ/Yr0EU7fpo3jGyK1p4tvs7lO0HzOsE=;
        b=jabugJwla3nxYlkUMg+wrYRbfqwOJ3Wcd2l0wRsAZJRZPB+/frDs3XdizkWIyoxv4H
         XD3uY1HX7p/CzBb+O03qA+qx4gCvzf5Gjof4SwLeOpyGNeqTwdVXJg2Pjyxgi6M67TCg
         YRuA8xlZTjmb6qqyh48L8OeCCpGTCiUD5f+Rsw/JEH9q2wc5x2y6R1Io07EBG+eOFlYT
         TGxH0BEyNcCwPAFMWI3nAGoRl/LdoVbTajkA2ACUVFP1GM/KEUC8TmkgOUQDJxsIAb+9
         2svy9voW+Vh7bQn019Ih+L1RqCOjdC5bEsNK8UOC0n9mOLPChrhnuyb2YB+RSaKUU1o6
         d7jw==
X-Gm-Message-State: AC+VfDwqYXcrJCjGQNJgFU2n64oRbXLJiQabNA5nU6nhUrxrW7ctThYf
        NLc+D8flg2yHgnMN8b5oa3WlxSR/8nQfGTYFthlheGj1gBU=
X-Google-Smtp-Source: ACHHUZ7qloGjLp00svzfuX20gElKoePosakZQACAS1YIoOhBgT2kHahYwIU+/6WprIoTrQquwSVWmdDTomRNsPF+Ol4=
X-Received: by 2002:a67:b10c:0:b0:42e:5aa9:406e with SMTP id
 w12-20020a67b10c000000b0042e5aa9406emr930268vsl.10.1682606066231; Thu, 27 Apr
 2023 07:34:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230425130105.2606684-1-amir73il@gmail.com> <20230425130105.2606684-5-amir73il@gmail.com>
 <20230427114849.cv3kzxk7rvxpohjc@quack3> <CAOQ4uxhBaZ4_c5Ko6jZ6UzqtB-4spE_xiRC=TNMO8+bwnYMSnA@mail.gmail.com>
In-Reply-To: <CAOQ4uxhBaZ4_c5Ko6jZ6UzqtB-4spE_xiRC=TNMO8+bwnYMSnA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 27 Apr 2023 17:34:15 +0300
Message-ID: <CAOQ4uxjHOXX-gsEZTiRwXVbeqvyKi=O--hZxn9cRoVoPmf=zsg@mail.gmail.com>
Subject: Re: [RFC][PATCH 4/4] fanotify: support reporting non-decodeable file handles
To:     Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, Chuck Lever <cel@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 27, 2023 at 3:28=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> s_export_op
>
> On Thu, Apr 27, 2023 at 2:48=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> >
> > On Tue 25-04-23 16:01:05, Amir Goldstein wrote:
> > > fanotify users do not always need to decode the file handles reported
> > > with FAN_REPORT_FID.
> > >
> > > Relax the restriction that filesystem needs to support NFS export and
> > > allow reporting file handles from filesystems that only support ecodi=
ng
> > > unique file handles.
> > >
> > > For such filesystems, users will have to use the AT_HANDLE_FID of
> > > name_to_handle_at(2) if they want to compare the object in path to th=
e
> > > object fid reported in an event.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ...
> > > diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/=
fanotify_user.c
> > > index 8f430bfad487..a5af84cbb30d 100644
> > > --- a/fs/notify/fanotify/fanotify_user.c
> > > +++ b/fs/notify/fanotify/fanotify_user.c
> > > @@ -1586,11 +1586,9 @@ static int fanotify_test_fid(struct dentry *de=
ntry)
> > >        * We need to make sure that the file system supports at least
> > >        * encoding a file handle so user can use name_to_handle_at() t=
o
> > >        * compare fid returned with event to the file handle of watche=
d
> > > -      * objects. However, name_to_handle_at() requires that the
> > > -      * filesystem also supports decoding file handles.
> > > +      * objects, but it does not need to support decoding file handl=
es.
> > >        */
> > > -     if (!dentry->d_sb->s_export_op ||
> > > -         !dentry->d_sb->s_export_op->fh_to_dentry)
> > > +     if (!dentry->d_sb->s_export_op)
> > >               return -EOPNOTSUPP;
> >
> > So AFAICS the only thing you require is that s_export_op is set to
> > *something* as exportfs_encode_inode_fh() can deal with NULL ->encode_f=
h
> > just fine without any filesystem cooperation. What is the reasoning beh=
ind
> > the dentry->d_sb->s_export_op check? Is there an implicit expectation t=
hat
> > if s_export_op is set to something, the filesystem has sensible
> > i_generation? Or is it just a caution that you don't want the functiona=
lity
> > to be enabled for unexpected filesystems?
>
> A little bit of both.
> Essentially, I do not want to use the generic encoding unless the filesys=
tem
> opted-in to say "This is how objects should be identified".
>
> The current fs that have s_export_op && !s_export_op->encode_fh
> practically make that statement because they support NFS export
> (i.e. they implement fh_to_dentry()).
>
> I don't like the implicit fallback to generic encoding, especially when
> introducing this new functionality of encode_fid().
>
> Before posting this patch set I had two earlier revisions.
> One that changed the encode_fh() to mandatory and converted
> all the INO32_GEN fs to explicitly set
> s_export_op.encode_fh =3D generic_encode_ino32_fh,
> And one that marked all the INO32_GEN fs with
> s_export_op.flags =3D EXPORT_OP_ENCODE_INO32_GEN
> in both cases there was no blind fallback to INO32_GEN.
>
> But in the end, these added noise without actual value so
> I dropped them, because the d_sb->s_export_op check is anyway
> a pretty strong indication for opt-in to export fids.
>
> CC exportfs maintainers in case they have an opinion one
> way or the other.
>

BTW, the other reason I chose this requirement is circular -
this is the same requirement for exporting fids to user with
AT_HANDLE_FID and the two FAN_REPORT_FID should be
aligned with users ability to get fid with name_to_handle_at().

Another reasonable requirement would have been:
* !AT_HANDLE_FID requires ->fh_to_dentry (as current code)
* AT_HANDLE_FID requires either ->fh_to_dentry or encode_fh

Thanks,
Amir.
