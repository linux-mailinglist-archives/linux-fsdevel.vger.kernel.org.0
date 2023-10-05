Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13717BA31B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Oct 2023 17:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbjJEPvz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Oct 2023 11:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234221AbjJEPvC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:51:02 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EC527561;
        Thu,  5 Oct 2023 06:22:32 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-7abe4fa15ceso641635241.1;
        Thu, 05 Oct 2023 06:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696512152; x=1697116952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UgIhftH4G92rOIHpCooz7/tVkwHfE/wjVpyKVopiGpI=;
        b=ntcgJJ1UNSxJGXx6LBJ/OsMYY2jFeoJxeNiZeTCdNgTCd2qapsg3UTRAob6ViImc8i
         L57KWropAC/BWrXzX0istrLxOPSZKQV+Plog0HGevXapNYQ3nZXayP3Xo49YWd8UAYes
         OLYR5SZUIwa26OmbVuGo/zqH25egNSI72zCnpP6vIV5t9yVoEsSSk6PdQROTm33zCtXP
         LnwYUqMYpl7IHLjkSG+t78LsLHihoAvHjYJLslxhTFkkMUzvryfziX9PMAWCE+UG79Pw
         m6TP715KmeTAiRqrSopjBkuMonXFGGcSgVL1ceCSF33jzZu1POXAya8S8O+GwBc+UH7i
         qvHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696512152; x=1697116952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UgIhftH4G92rOIHpCooz7/tVkwHfE/wjVpyKVopiGpI=;
        b=pyHY07xj79IwqF2iZzUEIEAjGz39SF/dIDjF41p2MK5IRZqns3JdqhZSyG8/XkqNlc
         ik8zsWHjJx/ptnqefXbSYppTy1O+H95eLhncPPRXOixvKNHyqmdsbD8PDRG2zdW+ye5q
         j4KfywSReHNjjmx6qQI2FEqFNuxEqc/7GbVjjcNPwc4KKBIIGnMXdthJfPHicg0SDgv8
         gOw+R9vd9khpRY4g21yxHuc2hX4XjRJ71l/LF/L1Uqh7VF79hIbdKMTprSuaJAZRJ4pq
         YriGSVCZKFrxn4WCAeqEcqpvsVMN5RN4aHSrawSxXqVthGggVKiHkCTSw9XqVsx+EbxG
         6DyQ==
X-Gm-Message-State: AOJu0Yx5pMlQQLuZgWDjhMD8qZjC5w3kCxZTK4DGsOSGC9QVvrcoWXnA
        3jj+4evGWbrPun1T+AyI+6Y2CpiGtIJD6Yl9a0Q=
X-Google-Smtp-Source: AGHT+IEAaoXvXyAHbtej0tnlxnEefZxsl35/d3/bkcRzxXHlDTbd63Hu1Wx/seqMYJSPAmspgFgWwlCBgqV9VufIEb4=
X-Received: by 2002:a05:6122:1817:b0:496:80b6:2fd1 with SMTP id
 ay23-20020a056122181700b0049680b62fd1mr807887vkb.5.1696512151811; Thu, 05 Oct
 2023 06:22:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxhbNyDzf0_fFh1Yy5Kz2Coz=gTrfOtsmteE0=ncibBnpw@mail.gmail.com>
 <0000000000001081fc0606f52ed9@google.com> <CAOQ4uxjw_XztGxrhR9LWtz_SszdURkM+Add2q8A9BAt0z901kA@mail.gmail.com>
 <25f6950a67be079e32ad5b4139b1e89e367a91ba.camel@linux.ibm.com>
In-Reply-To: <25f6950a67be079e32ad5b4139b1e89e367a91ba.camel@linux.ibm.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 5 Oct 2023 16:22:20 +0300
Message-ID: <CAOQ4uxgfJ4owqzh99t65MyT5A99BbwkLQ-sHumCUWyqSw-Rd5g@mail.gmail.com>
Subject: Re: [syzbot] [integrity] [overlayfs] possible deadlock in
 mnt_want_write (2)
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     syzbot <syzbot+b42fe626038981fb7bfa@syzkaller.appspotmail.com>,
        hdanton@sina.com, linux-fsdevel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, mszeredi@redhat.com,
        syzbot@syzkalhler.appspotmail.com, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
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

On Thu, Oct 5, 2023 at 4:14=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wro=
te:
>
> On Thu, 2023-10-05 at 13:26 +0300, Amir Goldstein wrote:
> > On Thu, Oct 5, 2023 at 12:59=E2=80=AFPM syzbot
> > <syzbot+b42fe626038981fb7bfa@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot tried to test the proposed patch but the build/boot failed:
> >
> > My mistake. Please try again:
> >
> > #syz test: https://github.com/amir73il/linux ima-ovl-fix
>
> Thanks, Amir.   "mutext_init(&iint->mutex); moved, but the status
> initialization lines 161-166 were dropped.   They're needed by IMA-
> appraisal for signature verification.
>
>         iint->ima_file_status =3D INTEGRITY_UNKNOWN;
>         iint->ima_mmap_status =3D INTEGRITY_UNKNOWN;
>         iint->ima_bprm_status =3D INTEGRITY_UNKNOWN;
>         iint->ima_read_status =3D INTEGRITY_UNKNOWN;
>         iint->ima_creds_status =3D INTEGRITY_UNKNOWN;
>         iint->evm_status =3D INTEGRITY_UNKNOWN;
>

They are dropped from iint_init_once()
They are not needed there because there are now set
in every iint allocation in iint_init_always()
instead of being set in iint_free()

This is the standard practice for slab objects.
See inode_init_once()/inode_init_always().

Thanks,
Amir.
