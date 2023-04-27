Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7986F0801
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Apr 2023 17:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244040AbjD0PNm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Apr 2023 11:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243846AbjD0PNl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Apr 2023 11:13:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5574C03;
        Thu, 27 Apr 2023 08:13:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFF1363DC1;
        Thu, 27 Apr 2023 15:13:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B3A1C433EF;
        Thu, 27 Apr 2023 15:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682608415;
        bh=xIKi8jLY0vxOMas6x/harDM6S0zzfhtutjgMMWr5cQ8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=P1fPYEdTu5f8pI6jhRC+YLNFjYMSwb03tVfJcmdHjZ8BRfG1JgpWfhRW87RfyclI7
         mEGqhIV7k5cNqKXTjsr1477oaUd45z2gAUpEzhnUbyz1xbRYfwrcU0wLaEzTvQEZA3
         KxfMCeiJq64BZmo5yb+QqV0j3J/sP9urYJvV+7RaRNnnb/1/WJav/g91ZuwksixDyc
         Qq9bWW6twe4a1gQ84Rvxn7HRXEBHY6E7Ju8jDaYSC4YTRrsobjTa0uh3YmImk4d7tW
         +Lvtt8Kbb2/zbkTS9ViAiFRvrTEgO/IT3/jUNgu1SexSkopi4066Z1Pi173MgJODuX
         HjMWgkhbQ4QXw==
Message-ID: <dafbff6baa201b8af862ee3faf7fe948d2a026ab.camel@kernel.org>
Subject: Re: [RFC][PATCH 0/4] Prepare for supporting more filesystems with
 fanotify
From:   Jeff Layton <jlayton@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Date:   Thu, 27 Apr 2023 11:13:33 -0400
In-Reply-To: <20230425130105.2606684-1-amir73il@gmail.com>
References: <20230425130105.2606684-1-amir73il@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2023-04-25 at 16:01 +0300, Amir Goldstein wrote:
> Jan,
>=20
> Following up on the FAN_REPORT_ANY_FID proposal [1], here is a shot at an
> alternative proposal to seamlessly support more filesystems.
>=20
> While fanotify relaxes the requirements for filesystems to support
> reporting fid to require only the ->encode_fh() operation, there are
> currently no new filesystems that meet the relaxed requirements.
>=20
> I will shortly post patches that allow overlayfs to meet the new
> requirements with default overlay configurations.
>=20
> The overlay and vfs/fanotify patch sets are completely independent.
> The are both available on my github branch [2] and there is a simple
> LTP test variant that tests reporting fid from overlayfs [3], which
> also demonstrates the minor UAPI change of name_to_handle_at(2) for
> requesting a non-decodeable file handle by userspace.
>=20
> Thanks,
> Amir.
>=20
> [1] https://lore.kernel.org/linux-fsdevel/20230417162721.ouzs33oh6mb7vtft=
@quack3/
> [2] https://github.com/amir73il/linux/commits/exportfs_encode_fid
> [3] https://github.com/amir73il/ltp/commits/exportfs_encode_fid
>=20
> Amir Goldstein (4):
>   exportfs: change connectable argument to bit flags
>   exportfs: add explicit flag to request non-decodeable file handles
>   exportfs: allow exporting non-decodeable file handles to userspace
>   fanotify: support reporting non-decodeable file handles
>=20
>  Documentation/filesystems/nfs/exporting.rst |  4 +--
>  fs/exportfs/expfs.c                         | 29 ++++++++++++++++++---
>  fs/fhandle.c                                | 20 ++++++++------
>  fs/nfsd/nfsfh.c                             |  5 ++--
>  fs/notify/fanotify/fanotify.c               |  4 +--
>  fs/notify/fanotify/fanotify_user.c          |  6 ++---
>  fs/notify/fdinfo.c                          |  2 +-
>  include/linux/exportfs.h                    | 18 ++++++++++---
>  include/uapi/linux/fcntl.h                  |  5 ++++
>  9 files changed, 67 insertions(+), 26 deletions(-)
>=20

This set looks fairly benign to me, so ACK on the general concept.

I am starting to dislike how the AT_* flags are turning into a bunch of
flags that only have meanings on certain syscalls. I don't see a cleaner
way to handle it though.
--=20
Jeff Layton <jlayton@kernel.org>
