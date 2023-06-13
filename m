Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793E072E662
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 16:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240080AbjFMO4t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 10:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242948AbjFMOyw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 10:54:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA411984
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jun 2023 07:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686668044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5kYi3lnAvbIoZ+IuD9r3AQ39q/LTNfxjUfxJrf2aeuI=;
        b=CdG4fuBIOnz/v0IDLCS2NxcYYPxfqilSLtZl0DT095UOi9DluMuBBCho8mWvTOZ8+k5X9D
        JhLHp/dTebygbJ+/SRRShgmzozCZrY6c4o5mVfK4DY3uz8XkVtyxqzZjpMLlcPkd6l0pwr
        i3w4PdJNEN5pjvXhbRuIoc9LMquV3NY=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-8wlCrb0hPJ6dySIshYDP0A-1; Tue, 13 Jun 2023 10:54:02 -0400
X-MC-Unique: 8wlCrb0hPJ6dySIshYDP0A-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2b1bd925c39so45042541fa.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jun 2023 07:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686668041; x=1689260041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5kYi3lnAvbIoZ+IuD9r3AQ39q/LTNfxjUfxJrf2aeuI=;
        b=YGWBxHQImXtaKvmfPeR+NmrPn/rv6G4TQ2zHK46k/qol1IPR4OruVwvOvazFtgIWd9
         HO9Yycqg3XLK6rhVB9/axB274Sc8+k4a0Dujuh5QmbRgC41goj3/tWLB0uDcy1lY1wfu
         nHFsXU/cIIYjgNbmS37yJYKv608IpPqKufCECaO+Jnncqahbo7u+5wObW+1LdaahfGHL
         iUMQXwbQ7H48t3mJ24tJkMThPRKfxnF3e4DkvPJvK+RQR1cCd9DxNhpkokA1uxnqHqBd
         S4a2TXekld+kAcJCK0FZuRnjPDIBML90DVsPOIxaSAYoJ8kVJrl8D815VkllCocnzJ03
         B1hw==
X-Gm-Message-State: AC+VfDzj9ieaQ6SDbIxBuo2480JuxwV3IUnTobtvN6jRl79+cXkH9UMV
        7x+i0NLm7e0VIjoxTAiT+WBwJTwkcEXKKHjQ3ICeZcqysBOdf26Kw/UmmO1fRG8BjHC3FOv3M1r
        oBcgR2zAxGiOcU5tctLhfNl3zValpDdDIRjCbzBHQzg==
X-Received: by 2002:a2e:9c0f:0:b0:2b3:31c1:c743 with SMTP id s15-20020a2e9c0f000000b002b331c1c743mr2076148lji.52.1686668040992;
        Tue, 13 Jun 2023 07:54:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4Jimeix5ATVtwBo6swnEjvDAX4j7ipPaK7KhKMTJ1PrQ9ynlAq4PKUmvyjKXIcnKI47WwzkP4fprMY5h3d9u4=
X-Received: by 2002:a2e:9c0f:0:b0:2b3:31c1:c743 with SMTP id
 s15-20020a2e9c0f000000b002b331c1c743mr2076130lji.52.1686668040451; Tue, 13
 Jun 2023 07:54:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230608154256.562906-1-aleksandr.mikhalitsyn@canonical.com>
 <f3864ed6-8c97-8a7a-f268-dab29eb2fb21@redhat.com> <CAEivzxcRsHveuW3nrPnSBK6_2-eT4XPvza3kN2oogvnbVXBKvQ@mail.gmail.com>
 <20230609-alufolie-gezaubert-f18ef17cda12@brauner> <CAEivzxc_LW6mTKjk46WivrisnnmVQs0UnRrh6p0KxhqyXrErBQ@mail.gmail.com>
 <ac1c6817-9838-fcf3-edc8-224ff85691e0@redhat.com>
In-Reply-To: <ac1c6817-9838-fcf3-edc8-224ff85691e0@redhat.com>
From:   Gregory Farnum <gfarnum@redhat.com>
Date:   Tue, 13 Jun 2023 07:53:48 -0700
Message-ID: <CAJ4mKGby71qfb3gd696XH3AazeR0Qc_VGYupMznRH3Piky+VGA@mail.gmail.com>
Subject: Re: [PATCH v5 00/14] ceph: support idmapped mounts
To:     Xiubo Li <xiubli@redhat.com>,
        Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Christian Brauner <brauner@kernel.org>
Cc:     stgraber@ubuntu.com, linux-fsdevel@vger.kernel.org,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 12, 2023 at 6:43=E2=80=AFPM Xiubo Li <xiubli@redhat.com> wrote:
>
>
> On 6/9/23 18:12, Aleksandr Mikhalitsyn wrote:
> > On Fri, Jun 9, 2023 at 12:00=E2=80=AFPM Christian Brauner <brauner@kern=
el.org> wrote:
> >> On Fri, Jun 09, 2023 at 10:59:19AM +0200, Aleksandr Mikhalitsyn wrote:
> >>> On Fri, Jun 9, 2023 at 3:57=E2=80=AFAM Xiubo Li <xiubli@redhat.com> w=
rote:
> >>>>
> >>>> On 6/8/23 23:42, Alexander Mikhalitsyn wrote:
> >>>>> Dear friends,
> >>>>>
> >>>>> This patchset was originally developed by Christian Brauner but I'l=
l continue
> >>>>> to push it forward. Christian allowed me to do that :)
> >>>>>
> >>>>> This feature is already actively used/tested with LXD/LXC project.
> >>>>>
> >>>>> Git tree (based on https://github.com/ceph/ceph-client.git master):
> >>> Hi Xiubo!
> >>>
> >>>> Could you rebase these patches to 'testing' branch ?
> >>> Will do in -v6.
> >>>
> >>>> And you still have missed several places, for example the following =
cases:
> >>>>
> >>>>
> >>>>      1    269  fs/ceph/addr.c <<ceph_netfs_issue_op_inline>>
> >>>>                req =3D ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_GE=
TATTR,
> >>>> mode);
> >>> +
> >>>
> >>>>      2    389  fs/ceph/dir.c <<ceph_readdir>>
> >>>>                req =3D ceph_mdsc_create_request(mdsc, op, USE_AUTH_M=
DS);
> >>> +
> >>>
> >>>>      3    789  fs/ceph/dir.c <<ceph_lookup>>
> >>>>                req =3D ceph_mdsc_create_request(mdsc, op, USE_ANY_MD=
S);
> >>> We don't have an idmapping passed to lookup from the VFS layer. As I
> >>> mentioned before, it's just impossible now.
> >> ->lookup() doesn't deal with idmappings and really can't otherwise you
> >> risk ending up with inode aliasing which is really not something you
> >> want. IOW, you can't fill in inode->i_{g,u}id based on a mount's
> >> idmapping as inode->i_{g,u}id absolutely needs to be a filesystem wide
> >> value. So better not even risk exposing the idmapping in there at all.
> > Thanks for adding, Christian!
> >
> > I agree, every time when we use an idmapping we need to be careful with
> > what we map. AFAIU, inode->i_{g,u}id should be based on the filesystem
> > idmapping (not mount),
> > but in this case, Xiubo want's current_fs{u,g}id to be mapped
> > according to an idmapping.
> > Anyway, it's impossible at now and IMHO, until we don't have any
> > practical use case where
> > UID/GID-based path restriction is used in combination with idmapped
> > mounts it's not worth to
> > make such big changes in the VFS layer.
> >
> > May be I'm not right, but it seems like UID/GID-based path restriction
> > is not a widespread
> > feature and I can hardly imagine it to be used with the container
> > workloads (for instance),
> > because it will require to always keep in sync MDS permissions
> > configuration with the
> > possible UID/GID ranges on the client. It looks like a nightmare for sy=
sadmin.
> > It is useful when cephfs is used as an external storage on the host, bu=
t if you
> > share cephfs with a few containers with different user namespaces idmap=
ping...
>
> Hmm, while this will break the MDS permission check in cephfs then in
> lookup case. If we really couldn't support it we should make it to
> escape the check anyway or some OPs may fail and won't work as expected.

I don't pretend to know the details of the VFS (or even our linux
client implementation), but I'm confused that this is apparently so
hard. It looks to me like we currently always fill in the "caller_uid"
with "from_kuid(&init_user_ns, req->r_cred->fsuid))". Is this actually
valid to begin with? If it is, why can't the uid mapping be applied on
that?

As both the client and the server share authority over the inode's
state (including things like mode bits and owners), and need to do
permission checking, being able to tell the server the relevant actor
is inherently necessary. We also let admins restrict keys to
particular UID/GID combinations as they wish, and it's not the most
popular feature but it does get deployed. I would really expect a user
of UID mapping to be one of the *most* likely to employ such a
facility...maybe not with containers, but certainly end-user homedirs
and shared spaces.

Disabling the MDS auth checks is really not an option. I guess we
could require any user employing idmapping to not be uid-restricted,
and set the anonymous UID (does that work, Xiubo, or was it the broken
one? In which case we'd have to default to root?). But that seems a
bit janky to me.
-Greg

> @Greg
>
> For the lookup requests the idmapping couldn't get the mapped UID/GID
> just like all the other requests, which is needed by the MDS permission
> check. Is that okay to make it disable the check for this case ? I am
> afraid this will break the MDS permssions logic.
>
> Any idea ?
>
> Thanks
>
> - Xiubo
>
>
> > Kind regards,
> > Alex
> >
>

