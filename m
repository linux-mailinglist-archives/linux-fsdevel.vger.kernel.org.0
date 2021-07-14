Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91F5D3C7E86
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jul 2021 08:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238053AbhGNG25 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 02:28:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:48732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237948AbhGNG25 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 02:28:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B77561167;
        Wed, 14 Jul 2021 06:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626243966;
        bh=A+DueB8RZnnDf20x/Zs0rFENTdUEg9ZDVqqyXRCoE8s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H8xCkkWaCdUsHNvzj+d/YVA3He4CE47C8xXtfm8s0H3g0vylkhHUZulKtFJBOwRVb
         bm0Xbkjc4pTGpAqGWGttzrADK725om+KQpEbQbRBJPK433HCAp2EJoSYO4HscQYgoW
         vul8dWUDXJ9kxNjvHi83t8yss5k51DCeBjb5337vWogszcb2ByV3WZKTM8Es4iSOxu
         8URAKkJxtyPrQA+nXEEUM+TE8ov5wvwqyMuMEjsPpptqVt5VHmCiy0t7riabl6+0nP
         vANnh///BHw48sKxCahLkXtY4jnmVq5mhSaZ68TzUnSsf1X+dDtgBlTWg3P167X/RY
         YXxH3Q1pH0m3w==
Date:   Wed, 14 Jul 2021 09:26:02 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Yanko Kaneti <yaneti@declera.com>, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [5.14-rc1 regression] 7fe1e79b59ba configfs: implement the
 .read_iter and .write_iter methods - affects targetcli restore
Message-ID: <YO6DenDIUy0I3fXh@unreal>
References: <9e3b381a04fd7f7dfbf5e2395d127ab4ef554f99.camel@declera.com>
 <070508e7-d7d1-cec7-8dda-28dca3dc2f63@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <070508e7-d7d1-cec7-8dda-28dca3dc2f63@acm.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 12, 2021 at 05:35:16PM -0700, Bart Van Assche wrote:
> On 7/12/21 12:10 PM, Yanko Kaneti wrote:
> > Bisected a problem that I have with targetcli restore to:
> >=20
> > 7fe1e79b59ba configfs: implement the .read_iter and .write_iter methods
> >=20
> > With it reads of /sys/kernel/config/target/dbroot  go on infinitely,
> > returning  the config value over and over again.
> >=20
> > e.g.
> >=20
> > $ modprobe target_core_user
> > $ head -n 2 /sys/kernel/config/target/dbroot
> > /etc/target
> > /etc/target
> >=20
> > Don't know if that's a problem with the commit or the target code, but
> > could perhaps be affecting other places.
>=20
> The dbroot show method looks fine to me:
>=20
> static ssize_t target_core_item_dbroot_show(struct config_item *item,
> 					    char *page)
> {
> 	return sprintf(page, "%s\n", db_root);
> }
>=20
> Anyway, I can reproduce this behavior. I will take a look at this.

The problem exists for all configs users, we (RDMA) experience the same
issue with default_roce_mode and default_roce_tos files.

The configfs_read_iter() doesn't indicate to the upper layer that it
should stop reread. In my case, the iov_iter_count(to) is equal to 131072,
which is huge comparable to real buffer->count.

=2E...
[  192.077873] configfs: configfs_read_iter: count =3D 131072, pos =3D 1588=
0, buf =3D RoCE v2
[  192.078146] configfs: configfs_read_iter: count =3D 131072, pos =3D 1588=
8, buf =3D RoCE v2
[  192.078510] configfs: configfs_read_iter: count =3D 131072, pos =3D 1589=
6, buf =3D RoCE v2
=2E...

Thanks

>=20
> Bart.
