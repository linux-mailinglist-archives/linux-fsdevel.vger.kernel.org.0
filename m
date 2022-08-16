Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A36D595DEB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 16:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235615AbiHPOCI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 10:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235349AbiHPOCH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 10:02:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D0B8E0CB;
        Tue, 16 Aug 2022 07:02:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1001360F71;
        Tue, 16 Aug 2022 14:02:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8990C433C1;
        Tue, 16 Aug 2022 14:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660658525;
        bh=pAcwh5O9TeaGizG6/W89TfYQE/PYQ+535HKNQKaLF6k=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=TXTYbIT676OcrZ5kTJuQroeMpqc/Jqe4DNvcQU+DnI2eguUbvmKLFeMjFP7wR8K0V
         q2HWE8GpVuJVI7xkuBTTh1GgAHUhJPQ4uvueN/9xPO2qNpf1qs33MeCIWYsgK+Eqje
         UDWF7ZYgsR0O+v2UZb4fpNkOLK7YNdKk99cbNO7+qbcEx2zRQniqOgyXvhhW4Q+qzA
         7WfA2ceUc/1+4zqFljBaQa7Z4zbJ5agaWUu0ssfwdrAI0XeEq9KhO6kt+c+eFJ6gUh
         Bs17dCBiEsYMPMD8HKgmkgQoiQUYfQgS+v/mfbbsdXWGRUnF5Q2bLKg062BrWyaepF
         rraKwYpDGTQBQ==
Message-ID: <ef692314ada01fd2117b730ef0afae50102974f5.camel@kernel.org>
Subject: Re: [PATCH 1/4] vfs: report change attribute in statx for
 IS_I_VERSION inodes
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>,
        Christian Brauner <brauner@kernel.org>
Cc:     viro@zeniv.linux.org.uk, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        ceph-devel@vger.kernel.org
Date:   Tue, 16 Aug 2022 10:02:03 -0400
In-Reply-To: <4066396.1660658141@warthog.procyon.org.uk>
References: <20220816134419.xra4krb3jwlm4npk@wittgenstein>
         <20220816132759.43248-1-jlayton@kernel.org>
         <20220816132759.43248-2-jlayton@kernel.org>
         <4066396.1660658141@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2022-08-16 at 14:55 +0100, David Howells wrote:
> Christian Brauner <brauner@kernel.org> wrote:
>=20
> > > +#define STATX_CHANGE_ATTR	0x00002000U	/* Want/got stx_change_attr */
> >=20
> > I'm a bit worried that STATX_CHANGE_ATTR isn't a good name for the flag
> > and field. Or I fail to understand what exact information this will
> > expose and how userspace will consume it.
> > To me the naming gives the impression that some set of generic
> > attributes have changed but given that statx is about querying file
> > attributes this becomes confusing.
> >=20
> > Wouldn't it make more sense this time to expose it as what it is and
> > call this STATX_INO_VERSION and __u64 stx_ino_version?
>=20
> I'm not sure that STATX_INO_VERSION is better that might get confused wit=
h the
> version number that's used to uniquify inode slots (ie. deal with inode n=
umber
> reuse).
>=20
> The problem is that we need fsinfo() or similar to qualify what this mean=
s.
> On some filesystems, it's only changed when the data content changes, but=
 on
> others it may get changed when, say, xattrs get changed; further, on some
> filesystems it might be monotonically incremented, but on others it's jus=
t
> supposed to be different between two consecutive changes (nfs, IIRC).
>=20

I think we'll just have to ensure that before we expose this for any
filesystem that it conforms to some minimum standards. i.e.: it must
change if there are data or metadata changes to the inode, modulo atime
changes due to reads on regular files or readdir on dirs.

The local filesystems, ceph and NFS should all be fine. I guess that
just leaves AFS. If it can't guarantee that, then we might want to avoid
exposing the counter for it.

--=20
Jeff Layton <jlayton@kernel.org>
