Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A9A703A92
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 19:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244952AbjEORwk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 13:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244847AbjEORwV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 13:52:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869D11642C
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 May 2023 10:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684172965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iK/+txc5klXi+z7XErjcTrOlSl0WWJNlg61QJBSSw2w=;
        b=EK9WbJZwF4qhdJWoOuouiORRV/syILIL2MKXW6HRFphPE+uojcR1qVs7GQL0UuQ4xM3zxr
        fW2l3NsQOCB+X1/JQhKvoPLlgXBwRZg063dBW1mVoK5Q2BEkN5zZUKvd15bgHz35SFITke
        SygWq6ZPizlE38FMRzQX2PcF9I8UDfk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-M2Rxp9pSNSKqaz3e9PaXFQ-1; Mon, 15 May 2023 13:49:23 -0400
X-MC-Unique: M2Rxp9pSNSKqaz3e9PaXFQ-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-61a6bb9f808so66817046d6.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 May 2023 10:49:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684172963; x=1686764963;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iK/+txc5klXi+z7XErjcTrOlSl0WWJNlg61QJBSSw2w=;
        b=SpqUMUG/Yup5MHD/RT0WjYEBOfeFzeVtGaeO5pItYRDiqJKWzxG9mpE77f5TJDjc6g
         sWRlYWpsEgdBtf6IopHJkmzPjX7ggewgFKY8fJqRM3YlTylnU0B4sz1KwzG7I4nq9zbW
         NyS7cYSDihZG4hF5Bjn9dNXv9i3HOlTs7fM5skgsi/yyZK5dlwxhCVm1h7+/aVku1Vl4
         0/tIsG1i+rYS5tOTTolcYOomGYZwGag/TgaBUbQtTEodIae1GMvqI7+yUiSM/bV3bRa8
         5E8fO4LOKS6D7PI91DLO7wn+7WjbW1nMzAZrR2EHg9abwFJbXvub25ohuzCV1GBxci3S
         hf9w==
X-Gm-Message-State: AC+VfDz5v61U1RPOGgR91idHnJCivs5OQA3zLfjT1iG/XHMgzITxkzaH
        4XjV52y5ogWvp0DVB86OJeWY2J/qTUWUY9blP0rNT3e60TQATPJRgmHNBZoQA1ufM2rL7NDcuw0
        VKLvAUJpFSnlKRR3a07IKlzOg8PUHaCNQJg==
X-Received: by 2002:a05:6214:29ca:b0:623:64cd:941d with SMTP id gh10-20020a05621429ca00b0062364cd941dmr6146384qvb.2.1684172963118;
        Mon, 15 May 2023 10:49:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6t/j9z84nPYJuJ91AB8G0tMbZ0MjPIfB+8QSEt4cwP0Kmhw7bw2URLfhsaTjzMhsAAOmjsxg==
X-Received: by 2002:a05:6214:29ca:b0:623:64cd:941d with SMTP id gh10-20020a05621429ca00b0062364cd941dmr6146357qvb.2.1684172962837;
        Mon, 15 May 2023 10:49:22 -0700 (PDT)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id b7-20020a0ccd07000000b006211b7c1035sm3612061qvm.144.2023.05.15.10.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 10:49:22 -0700 (PDT)
Message-ID: <d4e26d9e4d9113f8da20425f5bf7ad91c786f381.camel@redhat.com>
Subject: Re: [PATCH] fix NFSv4 acl detection on F39
From:   Jeff Layton <jlayton@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "eggert@cs.ucla.edu" <eggert@cs.ucla.edu>,
        "bruno@clisp.org" <bruno@clisp.org>,
        "ondrej.valousek.xm@renesas.com" <ondrej.valousek.xm@renesas.com>,
        "brauner@kernel.org" <brauner@kernel.org>
Cc:     "bug-gnulib@gnu.org" <bug-gnulib@gnu.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Date:   Mon, 15 May 2023 13:49:21 -0400
In-Reply-To: <f967cbcc1620d1a5e68d7f005571dc569c8b5bb4.camel@hammerspace.com>
References: <20230501194321.57983-1-ondrej.valousek.xm@renesas.com>
         <c955ee20-371c-5dde-fcb5-26d573f69cd9@cs.ucla.edu>
         <TYXPR01MB1854B3C3B8215DD0FA7B83CCD96D9@TYXPR01MB1854.jpnprd01.prod.outlook.com>
         <17355394.lhrHg4fidi@nimes>
         <32edbaf1-d3b1-6057-aefc-d83df3266c20@cs.ucla.edu>
         <4f1519d8-bda1-1b15-4a78-a8072ba1551a@cs.ucla.edu>
         <TYXPR01MB18547A591663A4934B5D4D82D9789@TYXPR01MB1854.jpnprd01.prod.outlook.com>
         <fb005d7e29f1167b83acf7b10800ff3124ee2a50.camel@redhat.com>
         <f967cbcc1620d1a5e68d7f005571dc569c8b5bb4.camel@hammerspace.com>
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

On Mon, 2023-05-15 at 17:28 +0000, Trond Myklebust wrote:
> On Mon, 2023-05-15 at 13:11 -0400, Jeff Layton wrote:
> > On Mon, 2023-05-15 at 11:50 +0000, Ondrej Valousek wrote:
> > > Hi Paul,
> > >=20
> > > Ok first of all, thanks for taking initiative on this, I am unable
> > > to proceed on this on my own at the moment.
> > > I see few problems with this:
> > >=20
> > > 1. The calculation of the 'listbufsize' is incorrect in your patch.
> > > It will _not_work as you expected and won't limit the number of
> > > syscalls (which is why we came up with this patch, right?). Check
> > > with my original proposal, we really need to check for
> > > 'system.nfs4' xattr name presence here
> > > 2. It mistakenly detects an ACL presence on files which do not have
> > > any ACL on NFSv4 filesystem. Digging further it seems that kernel
> > > in F39 behaves differently to the previous kernels:
> > >=20
> > > F38:=20
> > > # getfattr -m . /path_to_nfs4_file
> > > # file: path_to_nfs4_file
> > > system.nfs4_acl=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <---- only
> > > single xattr detected
> > >=20
> > > F39:
> > > # getfattr -m . /path_to_nfs4_file
> > > # file: path_to_nfs4_file
> > > system.nfs4_acl
> > > system.posix_acl_default
> > > /* SOMETIMES even shows this */
> > > system.posix_acl_default
> >=20
> > (cc'ing Christian and relevant kernel lists)
> >=20
> > I assume the F39 kernel is v6.4-rc based? If so, then I think that's
> > a
> > regression. NFSv4 client inodes should _not_ report a POSIX ACL
> > attribute since the protocol doesn't support them.
> >=20
> > In fact, I think the rationale in the kernel commit below is wrong.
> > NFSv4 has a listxattr operation, but doesn't support POSIX ACLs.
> >=20
> > Christian, do we need to revert this?
> >=20
> > commit e499214ce3ef50c50522719e753a1ffc928c2ec1
> > Author: Christian Brauner <brauner@kernel.org>
> > Date:=A0=A0 Wed Feb 1 14:15:01 2023 +0100
> >=20
> > =A0=A0=A0 acl: don't depend on IOP_XATTR
> > =A0=A0=A0=20
> >=20
>=20
>=20
> No. The problem is commit f2620f166e2a ("xattr: simplify listxattr
> helpers") which helpfully inserts posix acl handlers into
> generic_listxattr(), and makes it impossible to call from
> nfs4_listxattr().
>=20


Ahh ok. Looking at that function though, it seems like it'd only report
these for mounts that set SB_POSIXACL. Any reason that we have that
turned on with v4 mounts?

This patch fixes the bug for me, but I haven't done any testing with it:

---------------8<-----------------

[RFC PATCH] nfs: don't set SB_POSIXACL on NFSv4 mounts

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/super.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 30e53e93049e..cbb8de6e25dc 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1057,7 +1057,6 @@ static void nfs_fill_super(struct super_block *sb, st=
ruct nfs_fs_context *ctx)
 		sb->s_export_op =3D &nfs_export_ops;
 		break;
 	case 4:
-		sb->s_flags |=3D SB_POSIXACL;
 		sb->s_time_gran =3D 1;
 		sb->s_time_min =3D S64_MIN;
 		sb->s_time_max =3D S64_MAX;
--=20
2.40.1


