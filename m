Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C29704DA4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 14:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbjEPMVT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 08:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbjEPMVS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 08:21:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48C94698
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 May 2023 05:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684239636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E0FZtsxQz3Rjm7C2/u5FO2j69Qx91RmAS6xW6uxmtbs=;
        b=aLIIJUax4tVmCJObE2hs7vpWNq6FtPauhn2XTVx3ITImEctPRhCKkGUi05tOIbqpY2N/Q1
        Oi0bPJqubTmNaC6eXU2Vg9cWzdtiI+0VqwotIp65pWCmzfk6V/tpVjtt/kJ7CJ/BgjfqNU
        m3jS03mNj2XFGQxU3+A6G7ZGK7pfx1Q=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-SoIIL50RPpaSFgsLisuG4Q-1; Tue, 16 May 2023 08:20:35 -0400
X-MC-Unique: SoIIL50RPpaSFgsLisuG4Q-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-61b62c71a61so187653926d6.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 May 2023 05:20:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684239635; x=1686831635;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E0FZtsxQz3Rjm7C2/u5FO2j69Qx91RmAS6xW6uxmtbs=;
        b=UFiKxI6MxFRYiZGAWjpDEKsoYcYbwLzY0EmXtVmP6LUuBpw4RZTC9lg5kEUieNmvFB
         qU8Mo02iC2a4j31JCwosAG6EYwiIP3KOzqX2TVzcUD9Fj0G/LvKFU6ZiKm1pe06KUIpK
         /0/5BFb8X2A6xi4T016cibdIP8JMaTQYWg7T0TsiWZCqYulvfybW7WjgmPiJXFL/EZCD
         Pf3h87hX13EJBT/ELbpwWIFQr+uvN181HiLu3j9Ed61MfO5bGjR30JI0GI6aEZwx3gb6
         TlhXKVdpHYda9FxddvrKJYdDQbQXgjAzvGrCdq/B+ijrJrIXmDDDILYDTSRsUNqH9QNs
         XTZg==
X-Gm-Message-State: AC+VfDyfKuCPdjgEnNI7XeUzIRheMlpS9D0TTr+WKhR/Od6u+1fGSSvf
        3Eue67YSfrGxYSf+yN08IrQUti+J5j3qHJaaSD5/wiPb6qOcK75L5G9124LwY51uH9T/AY7lBJ1
        wEFanemk8ZvRS8T9WKuwI4dY2Ag==
X-Received: by 2002:ad4:5cce:0:b0:61b:7383:798d with SMTP id iu14-20020ad45cce000000b0061b7383798dmr63602838qvb.40.1684239635146;
        Tue, 16 May 2023 05:20:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5ItUHbySneQ59sTCRzmPR4UnU0PyajUWJ+MBcZ/7Bg8t+g7UugkdXD+80X50kOnePk3/gsyw==
X-Received: by 2002:ad4:5cce:0:b0:61b:7383:798d with SMTP id iu14-20020ad45cce000000b0061b7383798dmr63602787qvb.40.1684239634701;
        Tue, 16 May 2023 05:20:34 -0700 (PDT)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id h10-20020a0cf20a000000b0061b5c45f970sm5594360qvk.74.2023.05.16.05.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 05:20:34 -0700 (PDT)
Message-ID: <b4f836aa654acef4825dc8e502afe415a6956ffb.camel@redhat.com>
Subject: Re: [PATCH] fix NFSv4 acl detection on F39
From:   Jeff Layton <jlayton@redhat.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "eggert@cs.ucla.edu" <eggert@cs.ucla.edu>,
        "bruno@clisp.org" <bruno@clisp.org>,
        "ondrej.valousek.xm@renesas.com" <ondrej.valousek.xm@renesas.com>,
        "bug-gnulib@gnu.org" <bug-gnulib@gnu.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Date:   Tue, 16 May 2023 08:20:33 -0400
In-Reply-To: <20230516-distanz-abkommen-95e565ba928b@brauner>
References: <20230501194321.57983-1-ondrej.valousek.xm@renesas.com>
         <c955ee20-371c-5dde-fcb5-26d573f69cd9@cs.ucla.edu>
         <TYXPR01MB1854B3C3B8215DD0FA7B83CCD96D9@TYXPR01MB1854.jpnprd01.prod.outlook.com>
         <17355394.lhrHg4fidi@nimes>
         <32edbaf1-d3b1-6057-aefc-d83df3266c20@cs.ucla.edu>
         <4f1519d8-bda1-1b15-4a78-a8072ba1551a@cs.ucla.edu>
         <TYXPR01MB18547A591663A4934B5D4D82D9789@TYXPR01MB1854.jpnprd01.prod.outlook.com>
         <fb005d7e29f1167b83acf7b10800ff3124ee2a50.camel@redhat.com>
         <f967cbcc1620d1a5e68d7f005571dc569c8b5bb4.camel@hammerspace.com>
         <d4e26d9e4d9113f8da20425f5bf7ad91c786f381.camel@redhat.com>
         <20230516-distanz-abkommen-95e565ba928b@brauner>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2023-05-16 at 11:17 +0200, Christian Brauner wrote:
> On Mon, May 15, 2023 at 01:49:21PM -0400, Jeff Layton wrote:
> > On Mon, 2023-05-15 at 17:28 +0000, Trond Myklebust wrote:
> > > On Mon, 2023-05-15 at 13:11 -0400, Jeff Layton wrote:
> > > > On Mon, 2023-05-15 at 11:50 +0000, Ondrej Valousek wrote:
> > > > > Hi Paul,
> > > > >=20
> > > > > Ok first of all, thanks for taking initiative on this, I am unabl=
e
> > > > > to proceed on this on my own at the moment.
> > > > > I see few problems with this:
> > > > >=20
> > > > > 1. The calculation of the 'listbufsize' is incorrect in your patc=
h.
> > > > > It will _not_work as you expected and won't limit the number of
> > > > > syscalls (which is why we came up with this patch, right?). Check
> > > > > with my original proposal, we really need to check for
> > > > > 'system.nfs4' xattr name presence here
> > > > > 2. It mistakenly detects an ACL presence on files which do not ha=
ve
> > > > > any ACL on NFSv4 filesystem. Digging further it seems that kernel
> > > > > in F39 behaves differently to the previous kernels:
> > > > >=20
> > > > > F38:=20
> > > > > # getfattr -m . /path_to_nfs4_file
> > > > > # file: path_to_nfs4_file
> > > > > system.nfs4_acl=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <---- only
> > > > > single xattr detected
> > > > >=20
> > > > > F39:
> > > > > # getfattr -m . /path_to_nfs4_file
> > > > > # file: path_to_nfs4_file
> > > > > system.nfs4_acl
> > > > > system.posix_acl_default
> > > > > /* SOMETIMES even shows this */
> > > > > system.posix_acl_default
> > > >=20
> > > > (cc'ing Christian and relevant kernel lists)
> > > >=20
> > > > I assume the F39 kernel is v6.4-rc based? If so, then I think that'=
s
> > > > a
> > > > regression. NFSv4 client inodes should _not_ report a POSIX ACL
> > > > attribute since the protocol doesn't support them.
> > > >=20
> > > > In fact, I think the rationale in the kernel commit below is wrong.
> > > > NFSv4 has a listxattr operation, but doesn't support POSIX ACLs.
> > > >=20
> > > > Christian, do we need to revert this?
> > > >=20
> > > > commit e499214ce3ef50c50522719e753a1ffc928c2ec1
> > > > Author: Christian Brauner <brauner@kernel.org>
> > > > Date:=A0=A0 Wed Feb 1 14:15:01 2023 +0100
> > > >=20
> > > > =A0=A0=A0 acl: don't depend on IOP_XATTR
> > > > =A0=A0=A0=20
> > > >=20
> > >=20
> > >=20
> > > No. The problem is commit f2620f166e2a ("xattr: simplify listxattr
> > > helpers") which helpfully inserts posix acl handlers into
> > > generic_listxattr(), and makes it impossible to call from
> > > nfs4_listxattr().
> > >=20
> >=20
> >=20
> > Ahh ok. Looking at that function though, it seems like it'd only report
> > these for mounts that set SB_POSIXACL. Any reason that we have that
> > turned on with v4 mounts?
>=20
> You seem to just be calling generic_listxattr() in fs/nfs/nfs4proc.c and
> not using it as an inode operation.
>=20

Correct, but even if we were, this would be doing the wrong thing. As
Trond pointed out, f2620f166e2a changed the behavior of
generic_listxattr to make it include the POSIX ACL entries.

> So imho just add a tiny helper into
> fs/xattr.c that takes a boolean argument and skips over POSIX ACLs that
> you can call in nfs4. That should be enough, no?
>=20

The only other user of generic_listxattr is HFS, and I don't think it
supports POSIX ACLs either. I think we should probably just remove the
call to posix_acl_listxattr from generic_listxattr.
--=20
Jeff Layton <jlayton@redhat.com>

