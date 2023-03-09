Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D9B6B2939
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 16:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbjCIP6f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 10:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbjCIP6c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 10:58:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4198F786F
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Mar 2023 07:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678377463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x/YMudSIAMWQkSvHaQfj0qGZSmFme8VRUADcoJ23XIE=;
        b=FYFw8kusokn3lcCDXFai/SPnrr3kSc59KwOy/c/8SsUY5ogUqTIq/c1eCC32FpVtuG8x3D
        wwFzzDKKvHRG9g1ULiMt/kkcBl1tV9pGs7/iCB3nGx1Yyw/Cn4JgY+Nx0MohzB1ZpBPcRV
        uzxm+3hGwl86wMoN0QjdSOhOMfhSBbg=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-a28sOe7zPF-AXxoqCuslTw-1; Thu, 09 Mar 2023 10:57:43 -0500
X-MC-Unique: a28sOe7zPF-AXxoqCuslTw-1
Received: by mail-il1-f198.google.com with SMTP id b4-20020a92c844000000b00317983ace21so1096290ilq.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Mar 2023 07:57:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678377462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x/YMudSIAMWQkSvHaQfj0qGZSmFme8VRUADcoJ23XIE=;
        b=sgibPgI/rh41QrcG+v5GSU9cFytHKQTWQpKa7ibsP1j9yosyizIp7pe8KPybFsKCgN
         /lNvOKhkDUgpiBW7pYO4heYqKB1UqtkK4mLtKuzaku1gazZmV2FhrasKdN5X+SH+FkI9
         vhVu8KdoSnDpkQDB/Vfj16NydEg8FtNy6NSTOMnwvniCvXpq5bf+9g56qaZ+VhpNYGAX
         KiWIkK7smtmiKTIt3XsNSXumiYCXqJk5I6n6RWXmAP5jkVB9ago019p07EEjQFnqsrEa
         DOf8PEpvHzeFc0z3Amaknxm4oTw1Jx5jP0UpWraXpLL1JqXy3PTOnX36Dw52rjfYeO2c
         Hn6Q==
X-Gm-Message-State: AO0yUKVRXtvXzjz/9TByZcDOnROfhq6LREi6Y9Ef5oIVIT41tULfwHKd
        wZi/ZDwnbugJhVUeSdsL60PopXHl7nXOlafCKhFtjieMZWf9f5mzPZQAN1I4cjcHZU03mfixxJU
        Q6bvMDw0dxiOzDIAEdDY4o80CoSDWtLzd2YW8FHkubi5uuEtb7g==
X-Received: by 2002:a6b:d609:0:b0:74e:7a27:d183 with SMTP id w9-20020a6bd609000000b0074e7a27d183mr3473204ioa.2.1678377462111;
        Thu, 09 Mar 2023 07:57:42 -0800 (PST)
X-Google-Smtp-Source: AK7set86fAfUQkKvpUK+xHJFUmAgxxlIToVNKF4WKExdqAu/b7y4cSEYxaCASiTA/FBQfNVCKsocZw69QbrVN1/07Js=
X-Received: by 2002:a6b:d609:0:b0:74e:7a27:d183 with SMTP id
 w9-20020a6bd609000000b0074e7a27d183mr3473195ioa.2.1678377461882; Thu, 09 Mar
 2023 07:57:41 -0800 (PST)
MIME-Version: 1.0
References: <CAL7ro1GQcs28kT+_2M5JQZoUN6KHYmA85ouiwjj6JU+1=C-q4g@mail.gmail.com>
 <CAJfpeguTqXKuBcR3ZBbpWTPTbhnLja0QkBz3ASa4mgaw+A4-rQ@mail.gmail.com> <b1ec4ce2-1be3-4aaa-9d43-86bcd66b88f0@app.fastmail.com>
In-Reply-To: <b1ec4ce2-1be3-4aaa-9d43-86bcd66b88f0@app.fastmail.com>
From:   Alexander Larsson <alexl@redhat.com>
Date:   Thu, 9 Mar 2023 16:57:30 +0100
Message-ID: <CAL7ro1E2eU9yVL+YW6qbi6jz4eG-hrqe9=Wi2AM-CfO-sTYcEA@mail.gmail.com>
Subject: Re: WIP: verity support for overlayfs
To:     Colin Walters <walters@verbum.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 9, 2023 at 4:26=E2=80=AFPM Colin Walters <walters@verbum.org> w=
rote:
>
>
>
> On Thu, Mar 9, 2023, at 9:59 AM, Miklos Szeredi wrote:
> > On Wed, 8 Mar 2023 at 16:29, Alexander Larsson <alexl@redhat.com> wrote=
:
> >>
> >> As was recently discussed in the various threads about composefs we
> >> want the ability to specify a fs-verity digest for metacopy files,
> >> such that the lower file used for the data is guaranteed to have the
> >> specified digest.
> >>
> >> I wrote an initial version of this here:
> >>
> >>   https://github.com/alexlarsson/linux/tree/overlay-verity
> >>
> >> I would like some feedback on this approach. Does it make sense?
> >>
> >> For context, here is the main commit text:
> >>
> >> This adds support for a new overlay xattr "overlay.verity", which
> >> contains a fs-verity digest. This is used for metacopy files, and
> >> whenever the lowerdata file is accessed overlayfs can verify that
> >> the data file fs-verity digest matches the expected one.
> >>
> >> By default this is ignored, but if the mount option "verity_policy" is
> >> set to "validate" or "require", then all accesses validate any
> >> specified digest. If you use "require" it additionally fails to access
> >> metacopy file if the verity xattr is missing.
> >>
> >> The digest is validated during ovl_open() as well as when the lower fi=
le
> >> is copied up. Additionally the overlay.verity xattr is copied to the
> >> upper file during a metacopy operation, in order to later do the valid=
ation
> >> of the digest when the copy-up happens.
> >
> > Hmm, so what exactly happens if the file is copied up and then
> > modified?  The verification will fail, no?
>
> I believe the intention here is to deploy this without a writable upper d=
ir by default, so there's no copy-up, the calling code just gets -EROFS.  T=
he intention is to also use this to push the podman/docker/kube style ecosy=
stem away from "mutable by default" container images i.e. to "readonlyRootF=
ilesystem" by default (xref https://kubernetes.io/docs/tasks/configure-pod-=
container/security-context/ )

That is indeed some of the primary usecases for this. However, that
doesn't mean it is not useful also for other usecases.

> But yes, some scenarios will still want a writable upper dir for default,=
 as long as that writable upper dir is discarded across reboots (to aid in =
anti-persistence).  Maybe this needs to be configurable; I could imagine pe=
ople wanting a writable upper dir, but to still enforce fs-verity for *exis=
ting* content.  Other cases may want the logic to just strip away the fsver=
ity xattr across copy-up in this case.

I've been chatting with amir in github about this, and yes, we can
have options that make this useful also with an upper. I'll try to
post a new version with this tomorrow.

--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D
 Alexander Larsson                                Red Hat, Inc
       alexl@redhat.com         alexander.larsson@gmail.com

