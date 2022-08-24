Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744B959F744
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Aug 2022 12:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236423AbiHXKR1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Aug 2022 06:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbiHXKRZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Aug 2022 06:17:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E19072ECD;
        Wed, 24 Aug 2022 03:17:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9966F618C9;
        Wed, 24 Aug 2022 10:17:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B228C433C1;
        Wed, 24 Aug 2022 10:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661336244;
        bh=Q/sJyEIBeFaiOK2DLVudYTgdQk3CzzSDuKuPyWzoMfA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Ty2H/OJjltsYMMYRlq8ferSZILE2V/1ku703OF1EGmXBIY88vJ3YChurbN8Sndb2s
         RYedY5SvWseSldIgp7gKvIDiT0pYfXFLSK+IdjYkxmVTah4lOwt4aqj5P/QviduCtX
         YqKWkvRkJMSXspsGwS5Nk/nzrc7VyVs0brHNjQ8ps9SCxYkxOvQN5TQooTUIvWEEqf
         WgWOUO1kgp2QJHW4uF74AMbb8yfjVVH0307sw37+vUIR29L/xHsLwERTwT6Vc8Y2CF
         TCXXbY42hfHUcnUXPnli5k2hiscx2MwVWXOf+Tlrshc8ZpKjn52gGlqI8wNf5oubKp
         RzKdmNbpZW/+w==
Message-ID: <7901f60f7ea67d757caa5ba26588f01f308caaac.camel@kernel.org>
Subject: Re: [PATCH] vfs: report an inode version in statx for IS_I_VERSION
 inodes
From:   Jeff Layton <jlayton@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     viro@zeniv.linux.org.uk, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Frank Filz <ffilzlnx@mindspring.com>
Date:   Wed, 24 Aug 2022 06:17:22 -0400
In-Reply-To: <20220823215333.GC3144495@dread.disaster.area>
References: <20220819115641.14744-1-jlayton@kernel.org>
         <20220823215333.GC3144495@dread.disaster.area>
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

On Wed, 2022-08-24 at 07:53 +1000, Dave Chinner wrote:
> On Fri, Aug 19, 2022 at 07:56:41AM -0400, Jeff Layton wrote:
> > From: Jeff Layton <jlayton@redhat.com>
> >=20
> > The NFS server and IMA both rely heavily on the i_version counter, but
> > it's largely invisible to userland, which makes it difficult to test it=
s
> > behavior. This value would also be of use to userland NFS servers, and
> > other applications that want a reliable way to know if there was an
> > explicit change to an inode since they last checked.
> >=20
> > Claim one of the spare fields in struct statx to hold a 64-bit inode
> > version attribute. This value must change with any explicit, observeabl=
e
> > metadata or data change. Note that atime updates are excluded from this=
,
> > unless it is due to an explicit change via utimes or similar mechanism.
> >=20
> > When statx requests this attribute on an IS_I_VERSION inode, do an
> > inode_query_iversion and fill the result in the field. Also, update the
> > test-statx.c program to display the inode version and the mountid.
> >=20
> > Cc: David Howells <dhowells@redhat.com>
> > Cc: Frank Filz <ffilzlnx@mindspring.com>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
>=20
> NAK.
>=20
> THere's no definition of what consitutes an "inode change" and this
> exposes internal filesystem implementation details (i.e. on disk
> format behaviour) directly to userspace. That means when the
> internal filesystem behaviour changes, userspace applications will
> see changes in stat->ino_version changes and potentially break them.
>=20
> We *need a documented specification* for the behaviour we are exposing to
> userspace here, and then individual filesystems needs to opt into
> providing this information as they are modified to conform to the
> behaviour we are exposing directly to userspsace.
>=20
> Jeff - can you please stop posting iversion patches to different
> subsystems as individual, unrelated patchsets and start posting all
> the changes - statx, ext4, xfs, man pages, etc as a single patchset
> so the discussion can be centralised in one place and not spread
> over half a dozen disconnected threads?
>=20


Sure. Give me a few days and I'll post a more coherent set of patches.

Thanks,
--=20
Jeff Layton <jlayton@kernel.org>
