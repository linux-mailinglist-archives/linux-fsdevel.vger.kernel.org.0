Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791AD6B3D95
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Mar 2023 12:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjCJLXg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Mar 2023 06:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCJLXe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Mar 2023 06:23:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78346EB96
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Mar 2023 03:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678447365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dN7k3B6BEud1duRFuYX92Z8qXcuxs3rcZhY8CwxCvGc=;
        b=TG7CEf6JXKnW1Dhign6RBQuvRjRR98/X1TGsfdRvJf0fbiYABZ9El/I6nzfnrvGz2pSfPc
        mG55PcfNMxsViOmNIhGY81qU+WO9KUA80boj6jnIdu79xX8SidZAStI5cM3CrKibUIV4n8
        qs95GvR0c2qYTBtXKEuxeIVQmqKCRBc=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-XAvV9fyIMLOYKVISigvTig-1; Fri, 10 Mar 2023 06:22:44 -0500
X-MC-Unique: XAvV9fyIMLOYKVISigvTig-1
Received: by mail-il1-f199.google.com with SMTP id v14-20020a92c80e000000b0031faea6493cso2439329iln.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Mar 2023 03:22:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678447364;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dN7k3B6BEud1duRFuYX92Z8qXcuxs3rcZhY8CwxCvGc=;
        b=HMNc91g83KegNbA/sP0Irmf8LMTOzvKi9vHOvQZlw1RgnEitym1ohokapKDeKo7EM2
         dwejhUy4sJEvN7EfHZEpcTbd/d5LsBgNVM6W4NwFKdokRhMoJikuzH3SDJD0eLLYkwak
         CDBP8Hvr4zzGYutpseePtgzUPRNxw8XMDDf+iEKZO8HAiblf3p6IzDfPoKc+d6GeElsn
         GNLFRdFzG+kd68XTqRCqQ72oKzq1Y/vt2dvN9rA9fItqILwPfIG7L8J1zyDETwkBk12S
         WJsDc+DSjXLYUV3pMm4yeszmoNCTIRi6h8PJ+4Tc3jB7y8SaYk4TXkZ8SUvSMgrp2K+w
         ir/g==
X-Gm-Message-State: AO0yUKXMyhEeA+p6JoXo+ifJ9K2kOBfTKRS5bDJyIZ6ItAQ3cItIkQkL
        87sH7RX9THI2461FClgkwf+cU64HMo+zd9iJqpc97iJnj2WkwZeVfqng/Ga+rtb9UmmOILsjDz7
        J7lZBJBH2tW4BrtAO2P82ofFwe87w3Q5AsKY9wfZx6A==
X-Received: by 2002:a05:6e02:934:b0:315:9a9a:2cd with SMTP id o20-20020a056e02093400b003159a9a02cdmr12215481ilt.4.1678447364037;
        Fri, 10 Mar 2023 03:22:44 -0800 (PST)
X-Google-Smtp-Source: AK7set+KZ6+bfI5eypR0lIdFPqQXXMOqzThHSfVh9eBO8gh3nF07qpSRuTxfruW3zUArP4zZ4RSKwn5+5hXYmFoH5Jk=
X-Received: by 2002:a05:6e02:934:b0:315:9a9a:2cd with SMTP id
 o20-20020a056e02093400b003159a9a02cdmr12215475ilt.4.1678447363815; Fri, 10
 Mar 2023 03:22:43 -0800 (PST)
MIME-Version: 1.0
References: <CAL7ro1GQcs28kT+_2M5JQZoUN6KHYmA85ouiwjj6JU+1=C-q4g@mail.gmail.com>
In-Reply-To: <CAL7ro1GQcs28kT+_2M5JQZoUN6KHYmA85ouiwjj6JU+1=C-q4g@mail.gmail.com>
From:   Alexander Larsson <alexl@redhat.com>
Date:   Fri, 10 Mar 2023 12:22:32 +0100
Message-ID: <CAL7ro1F9Zu-m4PvHaeGvYAnFE7VaLp=Ykz8zadUWVPX-qjS7dQ@mail.gmail.com>
Subject: Re: WIP: verity support for overlayfs
To:     Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 8, 2023 at 4:28=E2=80=AFPM Alexander Larsson <alexl@redhat.com>=
 wrote:
>
> As was recently discussed in the various threads about composefs we
> want the ability to specify a fs-verity digest for metacopy files,
> such that the lower file used for the data is guaranteed to have the
> specified digest.
>
> I wrote an initial version of this here:
>
>   https://github.com/alexlarsson/linux/tree/overlay-verity

After some discussions with Amir in github I updated the branch. In
this new version there are four verity modes with this behaviour:

Unless you explicitly disable it ("verity=3Doff") all existing xattrs
are validated before use. This is all that happens by default
("verity=3Dvalidate"), but, if you turn on verity ("verity=3Don") then
during metacopy we generate verity xattr in the upper metacopy file (if
the source file has verity enabled). This means later accesses can
guarantee that the correct data is used.

Additionally you can use "verity=3Drequire". In this mode all metacopy
files must have a valid verity xattr. For this to work metadata
copy-up must be able to create a verity xattr (so that later accesses
are validated). Therefore, in this mode, if the lower data file
doesn't have fs-verity enabled we fall back to a full copy rather than
a metacopy.

In addition I changed the code so that validation of lowerdata happens
during lookup. Previously I was trying to do this lazily at use-time,
but that was only done partially right. Amir is doing some general
work on making lookups lazy, so the idea is to migrate the verity
validation to that later.

--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D
 Alexander Larsson                                Red Hat, Inc
       alexl@redhat.com         alexander.larsson@gmail.com

