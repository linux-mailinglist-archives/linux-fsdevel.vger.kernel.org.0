Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4762864B567
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 13:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235196AbiLMMrN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 07:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiLMMrK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 07:47:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681062EE;
        Tue, 13 Dec 2022 04:47:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F4237614C8;
        Tue, 13 Dec 2022 12:47:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 719CBC433D2;
        Tue, 13 Dec 2022 12:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670935625;
        bh=TAaNkCOgM1asqcXO/g5N+4KvMGb9eBkyQa4Gy0QTAeg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=LB0wP0EAfGMsyh70AKPRTKds55kqMiQIsqJKkh0dxs3QvC1UYNplh24NhvqbPQQKG
         r19WqwYZHP36yRMG9TqlJFC8oEeivE+GQpl8N2UwttE+cWmSyXxkyRDi8BFtagcp2+
         UA+BfPbKNOL3LN/Cbme1GZBFkqTtyB7y7MnA03NZ3AVvDS2tQUs8pDWN2YaD1Yk1oK
         ERllxGmc9pqYAkKaX3IKJUtJuuH+bGMFE6k9XTTXsBC5msAn2QOl3PSsDt8JBS2bQF
         9oo+JqrWp4ySY4yfydHomfCLqF7ulBRgQHnaT55mEkbulvF5jWes6LUXVDFoXDqxDd
         3zTUC8L+S1Pew==
Message-ID: <f71ab29339c88eb2cfa8f7294d03777d7a227907.camel@kernel.org>
Subject: Re: [PATCH v4 0/2] ceph: fix the use-after-free bug for file_lock
From:   Jeff Layton <jlayton@kernel.org>
To:     xiubli@redhat.com, idryomov@gmail.com, ceph-devel@vger.kernel.org
Cc:     mchangir@redhat.com, lhenriques@suse.de, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Tue, 13 Dec 2022 07:47:03 -0500
In-Reply-To: <20221213121103.213631-1-xiubli@redhat.com>
References: <20221213121103.213631-1-xiubli@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2022-12-13 at 20:11 +0800, xiubli@redhat.com wrote:
> From: Xiubo Li <xiubli@redhat.com>
>=20
> Changed in V4:
> - repeat the afs in fs.h instead of adding ceph specific header file
>=20
> Changed in V3:
> - switched to vfs_inode_has_locks() helper to fix another ceph file lock
> bug, thanks Jeff!
> - this patch series is based on Jeff's previous VFS lock patch:
>   https://patchwork.kernel.org/project/ceph-devel/list/?series=3D695950
>=20
> Changed in V2:
> - switch to file_lock.fl_u to fix the race bug
> - and the most code will be in the ceph layer
>=20
> Xiubo Li (2):
>   ceph: switch to vfs_inode_has_locks() to fix file lock bug
>   ceph: add ceph specific member support for file_lock
>=20
>  fs/ceph/caps.c     |  2 +-
>  fs/ceph/locks.c    | 24 ++++++++++++++++++------
>  fs/ceph/super.h    |  1 -
>  include/linux/fs.h |  3 +++
>  4 files changed, 22 insertions(+), 8 deletions(-)
>=20

Both patches look good to me. You can add:

Reviewed-by: Jeff Layton <jlayton@kernel.org>
