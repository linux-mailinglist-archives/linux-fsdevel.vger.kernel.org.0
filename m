Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684576DA192
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Apr 2023 21:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237442AbjDFTiF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 15:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237444AbjDFTh6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 15:37:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1104594;
        Thu,  6 Apr 2023 12:37:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C99E64BD8;
        Thu,  6 Apr 2023 19:37:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC7ECC433EF;
        Thu,  6 Apr 2023 19:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680809876;
        bh=sgAETLEuXyIGeAXVvg6ePMXon67bHi/EhQO67vdflcc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=cSUN+muBnUrFEcexB+K7gFE6aC4/xJ1eg6rryHWmzL12d1Vfkk0k8unW4RAysOlgF
         Mb4fG4itkjJj55h8b0zsA3M+0wbZniFEnRpsVIZc57DoZta9e9U4hGtFogWPVyx4EW
         LIdVzpWUElBQqCQyiDMpMxrEVFj7/AI7T0gYLHnjSIonOouiR+ybUITpdPepA1hdGl
         vzoy/teWoFY+x9TLi93J9zRFGP/3gMaFPzCjgGeQggmSxy2YiywSzXzzwOlw8c+lYW
         8HeskIE5Qzpc/KyBwREpsozS4CERAMLp1n9w/Dkiu+Q+9de05rrRRfCoZJCXDi7eEz
         iPOgvi3rBKtGw==
Message-ID: <60339e3bd08a18358ac8c8a16dc67c74eb8ba756.camel@kernel.org>
Subject: Re: [PATCH] overlayfs: Trigger file re-evaluation by IMA / EVM
 after writes
From:   Jeff Layton <jlayton@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        Christian Brauner <brauner@kernel.org>,
        Paul Moore <paul@paul-moore.com>
Cc:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        miklos@szeredi.hu, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        amir73il@gmail.com
Date:   Thu, 06 Apr 2023 15:37:53 -0400
In-Reply-To: <45a9c575-0b7e-f66a-4765-884865d14b72@linux.ibm.com>
References: <20230405171449.4064321-1-stefanb@linux.ibm.com>
         <20230406-diffamieren-langhaarig-87511897e77d@brauner>
         <CAHC9VhQsnkLzT7eTwVr-3SvUs+mcEircwztfaRtA+4ZaAh+zow@mail.gmail.com>
         <a6c6e0e4-047f-444b-3343-28b71ddae7ae@linux.ibm.com>
         <CAHC9VhQyWa1OnsOvoOzD37EmDnESfo4Rxt2eCSUgu+9U8po-CA@mail.gmail.com>
         <20230406-wasser-zwanzig-791bc0bf416c@brauner>
         <546145ecbf514c4c1a997abade5f74e65e5b1726.camel@kernel.org>
         <45a9c575-0b7e-f66a-4765-884865d14b72@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2023-04-06 at 15:11 -0400, Stefan Berger wrote:
>=20
> On 4/6/23 14:46, Jeff Layton wrote:
> > On Thu, 2023-04-06 at 17:01 +0200, Christian Brauner wrote:
> > > On Thu, Apr 06, 2023 at 10:36:41AM -0400, Paul Moore wrote:
>=20
> >=20
> > Correct. As long as IMA is also measuring the upper inode then it seems
> > like you shouldn't need to do anything special here.
>=20
> Unfortunately IMA does not notice the changes. With the patch provided in=
 the other email IMA works as expected.
>=20


It looks like remeasurement is usually done in ima_check_last_writer.
That gets called from __fput which is called when we're releasing the
last reference to the struct file.

You've hooked into the ->release op, which gets called whenever
filp_close is called, which happens when we're disassociating the file
from the file descriptor table.

So...I don't get it. Is ima_file_free not getting called on your file
for some reason when you go to close it? It seems like that should be
handling this.

In any case, I think this could use a bit more root-cause analysis.

> >=20
> > What sort of fs are you using for the upper layer?
>=20
> jffs2:
>=20
> /dev/mtdblock4 on /run/initramfs/ro type squashfs (ro,relatime,errors=3Dc=
ontinue)
> /dev/mtdblock5 on /run/initramfs/rw type jffs2 (rw,relatime)
> cow on / type overlay (rw,relatime,lowerdir=3Drun/initramfs/ro,upperdir=
=3Drun/initramfs/rw/cow,workdir=3Drun/initramfs/rw/work)
>=20

jffs2 does not have a proper i_version counter, I'm afraid. But, IMA
should handle that OK (by assuming that it always needs to remeasure
when there is no i_version counter).
--=20
Jeff Layton <jlayton@kernel.org>
