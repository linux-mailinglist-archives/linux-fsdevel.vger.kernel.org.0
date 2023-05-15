Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667B47036DA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 19:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243816AbjEOROf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 13:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243775AbjEOROU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 13:14:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09DDAD20
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 May 2023 10:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684170691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B0VQV6r8AYh45PqzQsI13Ira1377ExJZY+6kun+twe0=;
        b=JkxmJVpN8n+6eh/UVuIf89FGxmL8WyXylsASa0SnyVdslzTKDZS3q+vIa32bj4Wy2xTcYn
        I6VnJJWr/J6/UFgWNhSiV4tmK82K9FPyzo4fkrf/iI4t0cVwHG37fNW2YrKxXIXBW4Gs56
        l7lllWWZqt5LXBScls3K+geFf8vCens=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-KQbYEC7MOdq1kQjNJemo2Q-1; Mon, 15 May 2023 13:11:29 -0400
X-MC-Unique: KQbYEC7MOdq1kQjNJemo2Q-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-61e209243f7so65548766d6.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 May 2023 10:11:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684170689; x=1686762689;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B0VQV6r8AYh45PqzQsI13Ira1377ExJZY+6kun+twe0=;
        b=c5ipc7PyWdU8WiDYbCeegtjdGKh6VsL6KfgNNSY7t6Pp/dV2eLOgIbAcfEzdJPUNsb
         bmpDYYE+3sa125+KayBlJBaTy3PxHLULnxx0F+/hT8uQSGO9B6+f/XR2rWDl+y8/joE9
         1aqCMhCbiQpC9S04Dmtj6/OYhHN1R10/5+RTRL02ef6x98lz80a2Er2lcj1OpPXZ8qiU
         KRerm5D5gyEBWiYe5tuXniiGcSgkUkIaID7rOL5W8ap20aB3z6C+pBJBo7LwwdhkdaV5
         nBBlCr6/G3MMcd3nfp7PTf3YT8GfWJNYTrg8+vfg3niKwGmAJOOfufhuPG0dddsfpU8k
         1+xw==
X-Gm-Message-State: AC+VfDz9FOQl3m3C2lfHDxGyI08n48c+PDHzm7Hb51J6aicOP3z1q+us
        2OYZElDVCGwwePcAVGq1znHCkH83heLgIUEgaTipjo4sJjswLjMRHNNPf1O4CreO2v9nIQ+QpkI
        Y4B0rvVBXsATVDmPd48RELxJOBuZViw8k2Q==
X-Received: by 2002:ad4:5be1:0:b0:623:44bf:c41f with SMTP id k1-20020ad45be1000000b0062344bfc41fmr13483333qvc.17.1684170688729;
        Mon, 15 May 2023 10:11:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4zrtsD09R7XFx/jpOy5e7xJUOfRnJ+UlDpdJUF6fpginznv6eVOpZ0LpRmkUGSJGRUVwZ3+g==
X-Received: by 2002:ad4:5be1:0:b0:623:44bf:c41f with SMTP id k1-20020ad45be1000000b0062344bfc41fmr13483290qvc.17.1684170688434;
        Mon, 15 May 2023 10:11:28 -0700 (PDT)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id a3-20020a05620a102300b00759240a4771sm53672qkk.130.2023.05.15.10.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 10:11:27 -0700 (PDT)
Message-ID: <fb005d7e29f1167b83acf7b10800ff3124ee2a50.camel@redhat.com>
Subject: Re: [PATCH] fix NFSv4 acl detection on F39
From:   Jeff Layton <jlayton@redhat.com>
To:     Ondrej Valousek <ondrej.valousek.xm@renesas.com>,
        Paul Eggert <eggert@cs.ucla.edu>,
        Bruno Haible <bruno@clisp.org>,
        Christian Brauner <brauner@kernel.org>
Cc:     "bug-gnulib@gnu.org" <bug-gnulib@gnu.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>
Date:   Mon, 15 May 2023 13:11:26 -0400
In-Reply-To: <TYXPR01MB18547A591663A4934B5D4D82D9789@TYXPR01MB1854.jpnprd01.prod.outlook.com>
References: <20230501194321.57983-1-ondrej.valousek.xm@renesas.com>
         <c955ee20-371c-5dde-fcb5-26d573f69cd9@cs.ucla.edu>
         <TYXPR01MB1854B3C3B8215DD0FA7B83CCD96D9@TYXPR01MB1854.jpnprd01.prod.outlook.com>
         <17355394.lhrHg4fidi@nimes>
         <32edbaf1-d3b1-6057-aefc-d83df3266c20@cs.ucla.edu>
         <4f1519d8-bda1-1b15-4a78-a8072ba1551a@cs.ucla.edu>
         <TYXPR01MB18547A591663A4934B5D4D82D9789@TYXPR01MB1854.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2023-05-15 at 11:50 +0000, Ondrej Valousek wrote:
> Hi Paul,
>=20
> Ok first of all, thanks for taking initiative on this, I am unable to pro=
ceed on this on my own at the moment.
> I see few problems with this:
>=20
> 1. The calculation of the 'listbufsize' is incorrect in your patch. It wi=
ll _not_work as you expected and won't limit the number of syscalls (which =
is why we came up with this patch, right?). Check with my original proposal=
, we really need to check for 'system.nfs4' xattr name presence here
> 2. It mistakenly detects an ACL presence on files which do not have any A=
CL on NFSv4 filesystem. Digging further it seems that kernel in F39 behaves=
 differently to the previous kernels:
>=20
> F38:=20
> # getfattr -m . /path_to_nfs4_file
> # file: path_to_nfs4_file
> system.nfs4_acl                                    <---- only single xatt=
r detected
>
> F39:
> # getfattr -m . /path_to_nfs4_file
> # file: path_to_nfs4_file
> system.nfs4_acl
> system.posix_acl_default
> /* SOMETIMES even shows this */
> system.posix_acl_default

(cc'ing Christian and relevant kernel lists)

I assume the F39 kernel is v6.4-rc based? If so, then I think that's a
regression. NFSv4 client inodes should _not_ report a POSIX ACL
attribute since the protocol doesn't support them.

In fact, I think the rationale in the kernel commit below is wrong.
NFSv4 has a listxattr operation, but doesn't support POSIX ACLs.

Christian, do we need to revert this?

commit e499214ce3ef50c50522719e753a1ffc928c2ec1
Author: Christian Brauner <brauner@kernel.org>
Date:   Wed Feb 1 14:15:01 2023 +0100

    acl: don't depend on IOP_XATTR
   =20
    All codepaths that don't want to implement POSIX ACLs should simply not
    implement the associated inode operations instead of relying on
    IOP_XATTR. That's the case for all filesystems today.
   =20
    For vfs_listxattr() all filesystems that explicitly turn of xattrs for =
a
    given inode all set inode->i_op to a dedicated set of inode operations
    that doesn't implement ->listxattr().  We can remove the dependency of
    vfs_listxattr() on IOP_XATTR.
   =20
    Removing this dependency will allow us to decouple POSIX ACLs from
    IOP_XATTR and they can still be listed even if no other xattr handlers
    are implemented. Otherwise we would have to implement elaborate schemes
    to raise IOP_XATTR even if sb->s_xattr is set to NULL.
   =20
    Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>


>=20
> Now I faintly recall there was an activity in to move POSIX acls calculat=
ion from userspace to kernel (now Jeff in CC will hopefully clarify this)
>=20

The POSIX<->NFSv4 ACL translation has always been in the kernel server.
It has to be, as the primary purpose is to translate v4 ACLs from the
clients to and from the POSIX ACLs that the exported Linux filesystems
support.

--=20
Jeff Layton <jlayton@redhat.com>

