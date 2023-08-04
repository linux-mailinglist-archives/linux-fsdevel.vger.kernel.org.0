Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9EA770573
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 18:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbjHDQAs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 12:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbjHDQAq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:00:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3D846B1;
        Fri,  4 Aug 2023 09:00:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2153E62094;
        Fri,  4 Aug 2023 16:00:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9E8DC433C7;
        Fri,  4 Aug 2023 16:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691164842;
        bh=ZGRZkL9j/a65VBX6IUFj1r1iHPQgJzVhn4+RJMNyhb4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=jDUlmBzKAG67l59gJhJXTCjFGZxUTKhGt4lRB76NexmMj5D3j0bk/Ma6cI3RS7XWM
         v7a4a2cc9Sm5TrC3pPZ13VZFYw4IY51G7RnAwq9oBfGVRCpYiHJY6H9JGZ1reKiKQq
         ejpVdZr/ki0V8XIIjXpTTM/IHWUv68r5Eu1Y+hhy4dCoiWZLg83/vvQRv0OB1E3t4w
         YPcQ7XXKFhh+++7Sp/EIC1bXhAqAPlOwurvUjdH4+tII6zuqO7rxPiPKuqDm2hVON9
         uBUllR3gPlFcIyTyyhqmiVIck+VbHouHrIDz6iZ0hMeEQocKUp+gtZiX9KWsxoLhiY
         SLEbKWUnTy42w==
Message-ID: <7a947cfaa00f9bfce32ef9fac7a9f46f5dfab52f.camel@kernel.org>
Subject: Re: [PATCH v6] vfs, security: Fix automount superblock LSM init
 problem, preventing NFS sb sharing
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Scott Mayhew <smayhew@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Date:   Fri, 04 Aug 2023 12:00:39 -0400
In-Reply-To: <2680108.1691162547@warthog.procyon.org.uk>
References: <2678222.1691162178@warthog.procyon.org.uk>
         <bac543537058619345b363bbfc745927.paul@paul-moore.com>
         <20230802-master-v6-1-45d48299168b@kernel.org>
         <2680108.1691162547@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2023-08-04 at 16:22 +0100, David Howells wrote:
> David Howells <dhowells@redhat.com> wrote:
>=20
> > IIRC, the issue is when you make a mount with an explicit context=3D se=
tting and
> > make another mount from some way down the export tree that doesn't have=
 an
> > explicit setting, e.g.:
> >=20
> > 	mount carina:/ /mnt -o context=3Dsystem_u:object_r:root_t:s0
> > 	mount carina:/nfs/scratch /mnt2
> >=20
> > and then cause an automount to walk from one to the other:
> >=20
> > 	stat /mnt/nfs/scratch/foo
>=20
> Actually, the order there isn't quite right.  The problem is with this or=
der:
>=20
> 	# mount carina:/ /mnt -o context=3Dsystem_u:object_r:root_t:s0
> 	# stat /mnt/nfs/scratch/bus
> 	  File: /mnt/nfs/scratch/bus
> 	  Size: 124160          Blocks: 248        IO Block: 1048576 regular fil=
e
> 	Device: 0,55    Inode: 131         Links: 1
> 	...
> 	# mount carina:/nfs/scratch /mnt2
> 	mount.nfs: /mnt2 is busy or already mounted or sharecache fail
>=20
> with the error:
>=20
> 	SELinux: mount invalid.  Same superblock, different security settings fo=
r (dev 0:52, type nfs4)
>=20

That seems like the correct behavior to me. You tried to mount the same
mount with a different sec context. If you want that, then you need to
use -o nosharecache.

I'll send a v7 in a bit.=20
--=20
Jeff Layton <jlayton@kernel.org>
