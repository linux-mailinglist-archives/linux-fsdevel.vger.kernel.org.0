Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7B04C315C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 17:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiBXQcR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Feb 2022 11:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiBXQcQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Feb 2022 11:32:16 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AF737AA8
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Feb 2022 08:31:35 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id bd1so2162302plb.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Feb 2022 08:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=9pdKVdGgOkMZj/rMe0H1g8Nx4C5EJ0FhYBuM26imb1w=;
        b=RokpOp5tbzamDEc+IKS6EfAUSHKYkP5CI6pboSoD08qSmxmma+dcwV1tswSkN+4n2w
         uOSZ/9U2QLvB8//W85pnEoGufJRlNlckAFEVFzEXD0MUhoGvM144zrB0qfcQ6lhOtn8u
         OgttKsVEopodeiI+MVS4q6SHBHhaILRnO4DRzKDQyEHU9gxSqRDYMx+PR8xLduJPdr2c
         juiIZjRSUk5GXMajZQ+nTASvGG8GB/VFkJwMpRuNVloqBfOULKs9NB51jSHzFnCp1JHU
         tZLyF72L5f8td6h+6Vv6cdUNGHLGHh14H0KrORCtXNSvVaeyXo0PRahbivmXEYwp2KWA
         sEew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=9pdKVdGgOkMZj/rMe0H1g8Nx4C5EJ0FhYBuM26imb1w=;
        b=i0Yx+bIOSNpslXyXk2QE188g4uCD/LQLOnGhWldRP8VbtYFtPOTGFB6lVZVxMJSdvb
         zbsyI7vTIUpuZ5fBQOBZgAJ54xR1fxtilx7lk1z6gE6IDbdIGBlDnJuKt8cg4P+7I00p
         /dHPrNum4LLEFoljoo7pNNj4tNOy+xVMEjO/AMpDZYAUodsJaTOIti9w8NE5Li9ESLx/
         sIpkcQVCdSaj+H/Av6o1LqP+eILab/UWakb/7H5krF+5xK9EcIUsqOsdLTaDd01Wnk7N
         tzyOjMCThUioQeQ7ezgeVSfkfmHJYhgjXmRALE6zHmlKWr2Vcinpe3JfqP5a3ojqMJ8Q
         vbaA==
X-Gm-Message-State: AOAM532RIcin8sIKJzAQgg+IqfJiRja5xAzbrsyQdatHEJaM8wVx+Ekw
        //IF8CYFJh50/lzlZ1VdWpMBHA==
X-Google-Smtp-Source: ABdhPJwILxIiNBIe4uwvcJI4yA/KJvZUHTS4irgP1DwajEiSVZK6yJaUb60LC3vEkaTiOVWpKW+eog==
X-Received: by 2002:a17:902:bb93:b0:14f:3c15:566f with SMTP id m19-20020a170902bb9300b0014f3c15566fmr3393981pls.6.1645720291048;
        Thu, 24 Feb 2022 08:31:31 -0800 (PST)
Received: from smtpclient.apple (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id lp1sm118634pjb.17.2022.02.24.08.31.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 08:31:30 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Andreas Dilger <adilger@dilger.ca>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH/RFC] VFS: support parallel updates in the one directory.
Date:   Thu, 24 Feb 2022 09:31:28 -0700
Message-Id: <893053D7-E5DD-43DB-941A-05C10FF5F396@dilger.ca>
References: <164568221518.25116.18139840533197037520@noble.neil.brown.name>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Daire Byrne <daire@dneg.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>
In-Reply-To: <164568221518.25116.18139840533197037520@noble.neil.brown.name>
To:     NeilBrown <neilb@suse.de>
X-Mailer: iPhone Mail (19D52)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Feb 23, 2022, at 22:57, NeilBrown <neilb@suse.de> wrote:
>=20
>=20
> I added this:
> --- a/fs/xfs/xfs_icache.c
> +++ b/fs/xfs/xfs_icache.c
> @@ -87,6 +87,7 @@ xfs_inode_alloc(
>    /* VFS doesn't initialise i_mode or i_state! */
>    VFS_I(ip)->i_mode =3D 0;
>    VFS_I(ip)->i_state =3D 0;
> +    VFS_I(ip)->i_flags |=3D S_PAR_UPDATE;
>    mapping_set_large_folios(VFS_I(ip)->i_mapping);
>=20
>    XFS_STATS_INC(mp, vn_active);
>=20
> and ran my highly sophisticated test in an XFS directory:
>=20
> for i in {1..70}; do ( for j in {1000..8000}; do touch $j; rm -f $j ; done=
 ) & done
>=20
> This doesn't crash - which is a good sign.
> While that was going I tried
> while : ; do ls -l ; done
>=20
> it sometimes reports garbage for the stat info:
>=20
> total 0
> -????????? ? ?    ?    ?            ? 1749
> -????????? ? ?    ?    ?            ? 1764
> -????????? ? ?    ?    ?            ? 1765
> -rw-r--r-- 1 root root 0 Feb 24 16:47 1768
> -rw-r--r-- 1 root root 0 Feb 24 16:47 1770
> -rw-r--r-- 1 root root 0 Feb 24 16:47 1772
> ....
>=20
> I *think* that is bad - probably the "garbage" that you referred to?
>=20
> Obviously I gets lots of=20
> ls: cannot access '1764': No such file or directory
> ls: cannot access '1749': No such file or directory
> ls: cannot access '1780': No such file or directory
> ls: cannot access '1765': No such file or directory
>=20
> but that is normal and expected when you are creating and deleting
> files during the ls.

The "ls -l" output with "???" is exactly the case where the filename is
in readdir() but stat() on a file fails due to an unavoidable userspace=20
race between the two syscalls and the concurrent unlink(). This is
probably visible even without the concurrent dirops patch.=20

The list of affected filenames even correlates with the reported errors:
1764, 1765, 1769

It looks like everything is working as expected.=20

Cheers, Andreas

