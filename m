Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9CCD705965
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 23:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjEPVWf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 17:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjEPVWe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 17:22:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBBB4698;
        Tue, 16 May 2023 14:22:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 413E563F81;
        Tue, 16 May 2023 21:22:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21B36C433D2;
        Tue, 16 May 2023 21:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684272152;
        bh=nsnbvkz4IM+E5OVmBDfoHg+keBdzLU5YbNR/tm3g7OQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=fVXrZ6Pzte2LrlJ35tCPQClTqIj2qf1mGNleN9w2S76B5CithTjwvsjQgYvlTF5je
         AiyEBY0upq/Q8eORu/CeBQrCi5idgJBi48Me2IbxPluKiFvX15DmKWPnqcGphPYSdu
         DcMw3GaQWvUECk4kqHO2/fbHcmpCPASdoW8XiwC/0MfN2kkgudrEiI/6maefS6v2AV
         4mXN8GmNAx4swLN88pXHh/AJAC3b5Px2SfjgwGmpAMmlqD2YDiROuI/v+Ez+zC2f/3
         QHPSIDMlAVNYUmu9YZhmuICTnMKjVbUPC7l4l8f+/GXMIy4hIZ3E/B4061NSJQGAWF
         sM9XX/aqz5Lfw==
Message-ID: <cc4317d9cb8f10aa0b3750bdb6db8b4e77ff26f8.camel@kernel.org>
Subject: Re: A pass-through support for NFSv4 style ACL
From:   Jeff Layton <jlayton@kernel.org>
To:     Ondrej Valousek <ondrej.valousek.xm@renesas.com>,
        Christian Brauner <brauner@kernel.org>
Cc:     "trondmy@hammerspace.com" <trondmy@hammerspace.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Tue, 16 May 2023 17:22:30 -0400
In-Reply-To: <TYXPR01MB18549D3A5B0BE777D7F6B284D9799@TYXPR01MB1854.jpnprd01.prod.outlook.com>
References: <20230516124655.82283-1-jlayton@kernel.org>
         <20230516-notorisch-geblickt-6b591fbd77c1@brauner>
         <TYXPR01MB18549D3A5B0BE777D7F6B284D9799@TYXPR01MB1854.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2023-05-16 at 20:50 +0000, Ondrej Valousek wrote:
>=20
> Hi Christian,
>=20
> Would it be possible to patch kernel the way it accepts native (i.e no
> conversion to Posix ACL) NFSv4 style ACLs for filesystems that can
> support them?
> I.E. OpenZFS, NTFS, could be also interesting for Microsofts WSL2=A0 or
> Samba right?
>=20
> I mean, I am not trying to push richacl again knowing they have been
> rejected, but just NFS4 style Acls as they are so similar to Windows
> ACLs.
>=20

Erm, except you kind of are if you want to do this. I don't see how this
idea works unless you resurrect RichACLs or something like them.

> The idea here would be that we could
> - mount NTFS/ZFS filesystem and inspect ACLs using existing tools
> (nfs4_getacl)
> - share with NFSv4 in a pass through mode
> - in Windows WSL2 we could inspect local filesystem ACLs using the
> same tools
>=20
> Does it make any sense or it would require lot of changes to VFS
> subsystem or its a nonsense altogether?
>=20

Eventually you have to actually enforce the ACL. Do NTFS/ZFS already
have code to do this? If not then someone would need to write it.

Also windows and nfs acls do have some differences, so you'll need a
translation layer too.
--=20
Jeff Layton <jlayton@kernel.org>
