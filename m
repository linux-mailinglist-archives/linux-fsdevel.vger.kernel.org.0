Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44ED472A2F7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 21:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjFITRr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 15:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjFITRq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 15:17:46 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC46E62;
        Fri,  9 Jun 2023 12:17:45 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-46288dcacb5so786148e0c.3;
        Fri, 09 Jun 2023 12:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686338265; x=1688930265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QTpAhYr/4SWBwdoc645/a6gvU9OMzI9hu9GqIUUcEyA=;
        b=oe3zFaboLx6jZWtQbdnniif0zJ4t0rl3RO/fDECVxMAL1P1lZ8Qf228Z5yHsNtSHZO
         CvfB3MdVEiR//utwFdbdKaZyN8D2D0G5GXKvXD3rTG3KuWkGDmfVg/BF6KTWu6cpazqG
         oVBGJlPujY4clVtl1KZVP1oGd8pCZ7+Ftw3DjL60Mkn9+TUWSh9HY9J/YO0biB2sCRc+
         wmuxUSMVBlt2lc1k3rhPTnsWwo5Tpkvad4cMUm7sgTweiOi/JpLqgqBzaNDUFwMclIC1
         jx6CeIhT7bNJyAdmc8yLw7pGWeiA0n3R6e6H+CkYKWEu7sxH204CErEraZ3H0HNkgsmG
         6XEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686338265; x=1688930265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QTpAhYr/4SWBwdoc645/a6gvU9OMzI9hu9GqIUUcEyA=;
        b=LH/phrhPuOt6awoNIrsSkwqH92R3PSqySpgdiQDrsik2uToJnOtyAElYSVNVjOU8vZ
         OHOgac08l4eEak4ODYyuwfCVUsieE5v6wHdcfku5GA6Ryhz1J/0/WLC68yWsDvutuLH9
         mZvKK4lyHSogZ0xKmjN7NsDFbsj+8usc2O3eUGf2053Uy83TXmBDY/R0Mm9LkP2tLKp9
         +24XM0WLS2Hrw7vvEBW5JnOrBiscKG1EJOeeRKvKVMzqKyGtTkIdpQ1aq2GmONLL4aMc
         ebsZyyUwjzzfvG2Jk9BLXOXrBy12+GCb8wNyz/gfsSpMiqetSltWr7UXHEU5R0C8hz2x
         TJOg==
X-Gm-Message-State: AC+VfDxi3mNwuYTlM1W5qQTP4ZTyIsTxWzSwQ9CF0Z0IJD/M4KH26DKN
        VLfQL39DvZvuMa5+d2LMy+xGxIaR3b5d+5uaWFlMs0io
X-Google-Smtp-Source: ACHHUZ5g0lK3dLlev8cKhG/uYZQcx8WLC8vUtk13xzusPWT11LsltX2KV6Tuh5IVT/c9L2XcgkpZa/8JXoM6GHNVMO8=
X-Received: by 2002:a67:eac6:0:b0:43d:c1a4:c166 with SMTP id
 s6-20020a67eac6000000b0043dc1a4c166mr1646124vso.13.1686338264789; Fri, 09 Jun
 2023 12:17:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230609073239.957184-1-amir73il@gmail.com> <CAJfpegvDoSWPRaoa_i_Do3JDdaXrhohDtfQNObSJ7tNhhuHAKw@mail.gmail.com>
 <CAOQ4uxh=KfY2mNW1jQk6-wjoGWzi5LdCN=H9LzfCSx2o69K36A@mail.gmail.com>
 <CAOQ4uxgk3sAubfx84FKtNSowgT-aYj0DBX=hvAApre_3a8Cq=g@mail.gmail.com> <CAJfpegtt48eXhhjDFA1ojcHPNKj3Go6joryCPtEFAKpocyBsnw@mail.gmail.com>
In-Reply-To: <CAJfpegtt48eXhhjDFA1ojcHPNKj3Go6joryCPtEFAKpocyBsnw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 9 Jun 2023 22:17:33 +0300
Message-ID: <CAOQ4uxhup_bzfJzVgcFx4GBO-BUSmjkzK=ozYAzDhJtg7gH=Dg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Reduce impact of overlayfs fake path files
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Paul Moore <paul@paul-moore.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>
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

On Fri, Jun 9, 2023 at 6:00=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> w=
rote:
>
> On Fri, 9 Jun 2023 at 16:42, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Fri, Jun 9, 2023 at 5:28=E2=80=AFPM Amir Goldstein <amir73il@gmail.c=
om> wrote:
> > >
> > > On Fri, Jun 9, 2023 at 4:15=E2=80=AFPM Miklos Szeredi <miklos@szeredi=
.hu> wrote:
> > > >
> > > > On Fri, 9 Jun 2023 at 09:32, Amir Goldstein <amir73il@gmail.com> wr=
ote:
> > > > >
> > > > > Miklos,
> > > > >
> > > > > This is the solution that we discussed for removing FMODE_NONOTIF=
Y
> > > > > from overlayfs real files.
> > > > >
> > > > > My branch [1] has an extra patch for remove FMODE_NONOTIFY, but
> > > > > I am still testing the ovl-fsnotify interaction, so we can defer
> > > > > that step to later.
> > > > >
> > > > > I wanted to post this series earlier to give more time for fsdeve=
l
> > > > > feedback and if these patches get your blessing and the blessing =
of
> > > > > vfs maintainers, it is probably better that they will go through =
the
> > > > > vfs tree.
> > > > >
> > > > > I've tested that overlay "fake" path are still shown in /proc/sel=
f/maps
> > > > > and in the /proc/self/exe and /proc/self/map_files/ symlinks.
> > > > >
> > > > > The audit and tomoyo use of file_fake_path() is not tested
> > > > > (CC maintainers), but they both look like user displayed paths,
> > > > > so I assumed they's want to preserve the existing behavior
> > > > > (i.e. displaying the fake overlayfs path).
> > > >
> > > > I did an audit of all ->vm_file  and found a couple of missing ones=
:
> > >
> > > Wait, but why only ->vm_file?
>
> Because we don't get to intercept vm_ops, so anything done through
> mmaps will not go though overlayfs.   That would result in apparmor
> missing these, for example.
>
> > > We were under the assumption the fake path is only needed
> > > for mapped files, but the list below suggests that it matters
> > > to other file operations as well...
> > >
> > > >
> > > > dump_common_audit_data
> > > > ima_file_mprotect
> > > > common_file_perm (I don't understand the code enough to know whethe=
r
> > > > it needs fake dentry or not)
> > > > aa_file_perm
> > > > __file_path_perm
> > > > print_bad_pte
> > > > file_path
> > > > seq_print_user_ip
> > > > __mnt_want_write_file
> > > > __mnt_drop_write_file
> > > > file_dentry_name
> > > >
> > > > Didn't go into drivers/ and didn't follow indirect calls (e.g.
> > > > f_op->fsysnc).  I also may have missed something along the way, but=
 my
> > > > guess is that I did catch most cases.
> > >
> > > Wow. So much for 3-4 special cases...
> > >
> > > Confused by some of the above.
> > >
> > > Why would we want __mnt_want_write_file on the fake path?
> > > We'd already taken __mnt_want_write on overlay and with
> > > real file we need __mnt_want_write on the real path.
>
> It's for write faults on memory maps.   The code already branches on
> file->f_mode, I don't think it would be a big performance hit to check
> FMODE_FAKE_PATH.
>

Yes, but all those lower leven helpers are also called for read/write ops
on the same realfile object, where we do not want them to act on the
fake path. That's the reason I started with this conversion in the first
place. Maybe I am missing something in the big picture, but for now
the next steps are clear to me:

1. Store both real+fake paths in file_fake container
2. f_path remains fake now and maybe will be changed later
3. f_real_path() will be used now in fsnotify
4. Once we have a plan, we can start adding f_fake_path()
     calls for the mapped file code paths and one day, we may
     be able to let f_path be real

I will post v3 with steps 1-3.

Thanks,
Amir.
