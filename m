Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D517AB318
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Sep 2023 15:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234202AbjIVNwk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Sep 2023 09:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234097AbjIVNwf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Sep 2023 09:52:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE26392;
        Fri, 22 Sep 2023 06:52:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF2F0C433C7;
        Fri, 22 Sep 2023 13:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695390749;
        bh=I3wxew2R83ErU8B71fa76/M6GNlN/bf+I15REwBNzGY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=I6vweqFa6teue4NRHYc36l0I1yh39CxkkIFYIpXt/mUXtsjSjKEnnnVV+mnXaiUKS
         DdyfW8oYgdYXTKzXb9DgbdSHBPA+wr8WohBuKuXu6aimmSRoSqmNf2bXx+UrFn1VIX
         5wxp26DUWvKj/hYMH78ZALmlleijovB+L37euuPpxZDOVXudbTz8DlWh+PqAXqZhVg
         ZH34UcB2Ot1g7fotXNiAnbPfcxaVqspdWVGMm3cmZv3UY73SfwYbW+Y/q6wsyOORT8
         GviNP5FwfuLLvBXYcIDTjl2U6MUumM7YCJnbOHYvk3HT8p6VQU65ARXncxWwZupRQ8
         48Rb8Ty/LgH7A==
Message-ID: <d188250d3feb3926843f76ef3ca49e9d5baa97a7.camel@kernel.org>
Subject: Re: [PATCH] overlayfs: set ctime when setting mtime and atime
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Nathan Chancellor <nathan@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Date:   Fri, 22 Sep 2023 09:52:27 -0400
In-Reply-To: <20230914-hautarzt-bangen-f9ed9a2a3152@brauner>
References: <20230913-ctime-v1-1-c6bc509cbc27@kernel.org>
         <20230914-hautarzt-bangen-f9ed9a2a3152@brauner>
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

On Thu, 2023-09-14 at 10:39 +0200, Christian Brauner wrote:
> On Wed, 13 Sep 2023 09:33:12 -0400, Jeff Layton wrote:
> > Nathan reported that he was seeing the new warning in
> > setattr_copy_mgtime pop when starting podman containers. Overlayfs is
> > trying to set the atime and mtime via notify_change without also
> > setting the ctime.
> >=20
> > POSIX states that when the atime and mtime are updated via utimes() tha=
t
> > we must also update the ctime to the current time. The situation with
> > overlayfs copy-up is analogies, so add ATTR_CTIME to the bitmask.
> > notify_change will fill in the value.
> >=20
> > [...]
>=20
> Applied to the vfs.ctime branch of the vfs/vfs.git tree.
> Patches in the vfs.ctime branch should appear in linux-next soon.
>=20
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
>=20
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
>=20
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
>=20
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs.ctime
>=20
> [1/1] overlayfs: set ctime when setting mtime and atime
>       https://git.kernel.org/vfs/vfs/c/f8edd3368615

Christian, are you still planning to pick up this patch? I saw that it
was dropped from linux-next. Since the mgtime patches have been reverted
for now, it may be best for this to go in via the overlayfs tree ?

Thanks,
--=20
Jeff Layton <jlayton@kernel.org>
