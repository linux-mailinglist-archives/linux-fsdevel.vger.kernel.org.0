Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C36F6F05C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Apr 2023 14:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243987AbjD0M2o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Apr 2023 08:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243996AbjD0M2h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Apr 2023 08:28:37 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DE15BB7;
        Thu, 27 Apr 2023 05:28:35 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-77217c862b3so2620299241.3;
        Thu, 27 Apr 2023 05:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682598514; x=1685190514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c4upoSGz+k+e+el5zscXUKPfxUEDiAW8o9zGPiapxio=;
        b=DPnim84Ki8Z5lVy0hY7rTRJQ17k6jHg37OMO7mxe19JyrOc2XGr+8vD5AN0jNAiNA4
         FkBTmCDOdHhnXz/kNZkbfCIssDVpSVhkpWJL81ToU1eQa4vIxRJnNsw1s8cHQozj5j6S
         /1N60U8POemboyMsf5Ks2QHaSQN386N0LTFzwStylM6p2n83XosvIgG4q7gmgKvfz/sH
         WOPBCpXI1AIel1RmDPTX7zYSybJA4ZrURGdH+HrQXfwqyP/N8IFqGcs/Z16imtzHZQ2n
         xcULxnlzz4J0IIEQsRT2l6nbxBx0iXU14m51RSqaAjWK+xX1G8RX8dkemsikMXqwS7Zw
         G9+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682598514; x=1685190514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c4upoSGz+k+e+el5zscXUKPfxUEDiAW8o9zGPiapxio=;
        b=YatOIi1xlaO8SRoM8bT0nC45tOpgeTO+UUEGfZfyHow8DURcmWFH3nJGI20Ch9XeQd
         QeA2QxcwJ/LEP2Nuh7jYXiJ8Qv0QsW3dcDXGlEbiXRg1OLce5GoDeunahMaKXuGWC8BR
         JY+L8vKOZljb5JBFwWsgDGux/11kxshj9gsAq06ogGh0MZErxcjPs9F+ocMtZaCvV1nc
         M1XgxFfZVdH/hMq8RopSt9CtCzztmVZ+WECRNtc5u5hZABHaNzbNquHImoP0LG0eq5Cl
         dy9k0G1WUDGdqn+Buqn00SOaojsXm0uCjHpdJys5ykqbqyboenawC6FNY5Ltkr2uBVIv
         Dmcw==
X-Gm-Message-State: AC+VfDyGdzbSxzLTrV0es+Pc+PoKkrLpDewATUSVlojipVoY83PWTKE2
        W56SdtPRephnMDI5oBjO2+oCH2NHCAge/3DkG0s=
X-Google-Smtp-Source: ACHHUZ7TC6YiCnC1CVuW7jNBUZeaZU1KaGfmdmSZ85GStKkw/Otlm49DYVKQPEfWGI7TnFZ+UfpZEJkXpENk762lBh4=
X-Received: by 2002:a05:6102:3579:b0:42f:ec21:1c18 with SMTP id
 bh25-20020a056102357900b0042fec211c18mr589937vsb.35.1682598514273; Thu, 27
 Apr 2023 05:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230425130105.2606684-1-amir73il@gmail.com> <20230425130105.2606684-5-amir73il@gmail.com>
 <20230427114849.cv3kzxk7rvxpohjc@quack3>
In-Reply-To: <20230427114849.cv3kzxk7rvxpohjc@quack3>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 27 Apr 2023 15:28:23 +0300
Message-ID: <CAOQ4uxhBaZ4_c5Ko6jZ6UzqtB-4spE_xiRC=TNMO8+bwnYMSnA@mail.gmail.com>
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

s_export_op

On Thu, Apr 27, 2023 at 2:48=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 25-04-23 16:01:05, Amir Goldstein wrote:
> > fanotify users do not always need to decode the file handles reported
> > with FAN_REPORT_FID.
> >
> > Relax the restriction that filesystem needs to support NFS export and
> > allow reporting file handles from filesystems that only support ecoding
> > unique file handles.
> >
> > For such filesystems, users will have to use the AT_HANDLE_FID of
> > name_to_handle_at(2) if they want to compare the object in path to the
> > object fid reported in an event.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ...
> > diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fa=
notify_user.c
> > index 8f430bfad487..a5af84cbb30d 100644
> > --- a/fs/notify/fanotify/fanotify_user.c
> > +++ b/fs/notify/fanotify/fanotify_user.c
> > @@ -1586,11 +1586,9 @@ static int fanotify_test_fid(struct dentry *dent=
ry)
> >        * We need to make sure that the file system supports at least
> >        * encoding a file handle so user can use name_to_handle_at() to
> >        * compare fid returned with event to the file handle of watched
> > -      * objects. However, name_to_handle_at() requires that the
> > -      * filesystem also supports decoding file handles.
> > +      * objects, but it does not need to support decoding file handles=
.
> >        */
> > -     if (!dentry->d_sb->s_export_op ||
> > -         !dentry->d_sb->s_export_op->fh_to_dentry)
> > +     if (!dentry->d_sb->s_export_op)
> >               return -EOPNOTSUPP;
>
> So AFAICS the only thing you require is that s_export_op is set to
> *something* as exportfs_encode_inode_fh() can deal with NULL ->encode_fh
> just fine without any filesystem cooperation. What is the reasoning behin=
d
> the dentry->d_sb->s_export_op check? Is there an implicit expectation tha=
t
> if s_export_op is set to something, the filesystem has sensible
> i_generation? Or is it just a caution that you don't want the functionali=
ty
> to be enabled for unexpected filesystems?

A little bit of both.
Essentially, I do not want to use the generic encoding unless the filesyste=
m
opted-in to say "This is how objects should be identified".

The current fs that have s_export_op && !s_export_op->encode_fh
practically make that statement because they support NFS export
(i.e. they implement fh_to_dentry()).

I don't like the implicit fallback to generic encoding, especially when
introducing this new functionality of encode_fid().

Before posting this patch set I had two earlier revisions.
One that changed the encode_fh() to mandatory and converted
all the INO32_GEN fs to explicitly set
s_export_op.encode_fh =3D generic_encode_ino32_fh,
And one that marked all the INO32_GEN fs with
s_export_op.flags =3D EXPORT_OP_ENCODE_INO32_GEN
in both cases there was no blind fallback to INO32_GEN.

But in the end, these added noise without actual value so
I dropped them, because the d_sb->s_export_op check is anyway
a pretty strong indication for opt-in to export fids.

CC exportfs maintainers in case they have an opinion one
way or the other.

> In either case it would be good
> to capture the reasoning either in a comment or the changelog...
>

Will do.

Thanks,
Amir.
