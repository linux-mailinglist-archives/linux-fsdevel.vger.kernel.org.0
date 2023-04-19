Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4956E7590
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Apr 2023 10:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbjDSIny (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Apr 2023 04:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbjDSInv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Apr 2023 04:43:51 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D8D8A6F
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Apr 2023 01:43:48 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id xi5so79592599ejb.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Apr 2023 01:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1681893826; x=1684485826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PoaJl359qZUYDJa00LijMCBeZ9q8sK607R/iQiV1/HA=;
        b=BXBbL/9e5Z/e16fIKN825T7HQfMsjkYbzeD1Ok1tQbttzq1uDjBEhUIzju71+s/hTN
         rSAQWcYuMavpcUUu2pIa6yqOy4VCUfocRm2PqBjocjDOiY/Nn0C/NAcYLsA1n4HzXYqT
         iDBMJfHWKMMd8eA7xrCuf3JxLrqq9V7YU4E2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681893826; x=1684485826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PoaJl359qZUYDJa00LijMCBeZ9q8sK607R/iQiV1/HA=;
        b=Efaph731HkeCrkEVlM5mL1gntzXXqQH1/faQT+1s9TPwBO99LeNgcvEqeoux68USFO
         taPZxjRQXLGNEf3/WRvsigD7hI7oIcABEQZgGi4rVDdFHpw3PI0G4ttvJBNtSPdzwIse
         k1pk4wFxM5WU/w2WCtM/ryHDBuN55LDCqpxMT10WbtjyW2uI9AKmzZpxTLGUmitb+g52
         +iQnYhqJk6fLBlDV2q7QDduSXTe4/+dFKFww0pSvoC6ggTYCZBNVwGsctCRVOjfFG16c
         NJdM817FFK0BPnSdE2BfH07vq+jaQzqvPYAJQfrps5TmKyXYqdhthNUHNmqRbTTOTB8c
         qxaQ==
X-Gm-Message-State: AAQBX9f1QY6DVFjERO8PCln5Q9PhYKwWxVXCzFJGbnHN03uHYKLjkzg1
        mRr7qi/pVISl7FVjnYNgKXamn10lOLT12F/JlEL52Q==
X-Google-Smtp-Source: AKy350akRy72DX1DUVKexX0fDjnJbHEwbEfB+W1QMyjRxbW6iLu1mB89PVLcrbsjXK09tOFrkIAFDKqDPmOTywH4kd8=
X-Received: by 2002:a17:906:3a4b:b0:94e:d72b:d10c with SMTP id
 a11-20020a1709063a4b00b0094ed72bd10cmr13302303ejf.40.1681893826528; Wed, 19
 Apr 2023 01:43:46 -0700 (PDT)
MIME-Version: 1.0
References: <YnEeuw6fd1A8usjj@miu.piliscsaba.redhat.com> <e57733cd-364d-84e0-cfe0-fd41de14f434@bytedance.com>
 <CAJfpegsVsnjUy2N+qO-j4ToScwev01AjwUA0Enp_DxroPQS30A@mail.gmail.com>
 <CAOQ4uxhYi2823GiVn9Sf-CRGrcigkbPw2x1VQRV3_Md92gJnrw@mail.gmail.com>
 <CAJfpegsLD-OxYfqPR7AfWbgE1EAPfWs672omt+_u8sYCMFB5Fg@mail.gmail.com>
 <CAOQ4uxhz7g=N0V8iGiKa2+vupEuH_m9_27kas++6c0bLL2qRyA@mail.gmail.com>
 <CAJfpegt38gHcNeEt1mwOYHeMYdVEbj0RhZEs-4iYG7VPJhYDzQ@mail.gmail.com> <CAOQ4uxgzJTg61UOnYQOWggPUX9347gJRafUmQTd=rxxFMEdzrg@mail.gmail.com>
In-Reply-To: <CAOQ4uxgzJTg61UOnYQOWggPUX9347gJRafUmQTd=rxxFMEdzrg@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 19 Apr 2023 10:43:35 +0200
Message-ID: <CAJfpegv9=FKb=hUWOMb0-X_7yP8x8qfeCUvm9VTSpg5SCWAOng@mail.gmail.com>
Subject: Re: [LSF/MM TOPIC] fsinfo and mount namespace notifications
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Abel Wu <wuyun.abel@bytedance.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        lsf-pc <lsf-pc@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 19 Apr 2023 at 10:18, Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Tue, Apr 18, 2023 at 9:57 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Tue, 18 Apr 2023 at 17:57, Amir Goldstein <amir73il@gmail.com> wrote=
:
> > >
> > > On Tue, Apr 18, 2023 at 11:54=E2=80=AFAM Miklos Szeredi <miklos@szere=
di.hu> wrote:
> >
> > > > - mount ID's do not uniquely identify a mount across time
> > > >   o when a mount is deleted, the ID can be immediately reused
> > > >
> > > > The following are the minimal requirements needed to fix the above =
issues:
> > > >
> > > > 1) create a new ID for each mount that is unique across time; lets
> > > > call this umntid
> > > >
> > >
> > > Do you reckon we just stop recycling mntid?
> > > Do we also need to make it 64bit?
> > > statx() has already allocated 64bit for stx_mnt_id.
> > > In that case, should name_to_handle_at() return a truncated mnt_id?
> >
> > I'm not sure it's realistic to implement the new 64bit ID such that
> > the truncated value retains the properties of the previous mount ID
> > implementation.
> >
> > I think the only sane option is to leave the old mnt_id alone and add
> > a new 64bit one that is assigned from an atomic counter at allocation
> > and looked up using a hash table.
> >
>
> At the risk of shoehorning, that sounds a bit like file_handle of a mount=
.
> Meaning that it could be the result of
>
> name_to_handle_at(...,&mount_handle, &mount_id, AT_MNTID)
>
> We can possibly use open_by_handle_at() to get a mountfd from
> mount_handle - not sure if that makes sesnse.
>

There are conceptual similarities, yes.  Whether reusing the file
handle interfaces makes sense or not is another question.


> [...]
>
> > > > 3) allow querying mount parameters via umntid
>
> I forgot to mention in the context of this topic, that there was a
> topic proposal
> about using "BFP iterator" [1] to query fs/mount info.
>
> I don't know if that can be used to get namespace change notifications
> or if it meets other requirements (i.e. permissions), but wanted to
> mention it here.
>
> I think we can discuss both topics in the same session.

Okay.

Thanks,
Miklos
