Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C86DA2AAFF8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Nov 2020 04:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728866AbgKIDeS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Nov 2020 22:34:18 -0500
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25369 "EHLO
        sender2-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728038AbgKIDeS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Nov 2020 22:34:18 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1604892838; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=kBlhXktWR+Qe1wFN+TDLfgEUQha2sZ8VH3Fp41EClbH3oREJEalKrjjPSsjzdtBvifOj/zagCfjBGOzLo6YB8ZpymEMoF29GF+B7KBcFSgfuwCmsR6TGO3ogCrQ9RniOtWnlJlw1g1ShF7+41OCR45d3EfCqspX1d5ulpGjd5K0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1604892838; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=2FYXm/brPVetiXORzb8kEOXQkLAdKQUH2WjsHHLMans=; 
        b=InydZBUy/KxT47H18mjPg2WsL504WwfjrnV2GusBVcIXWQLVXNkcVDME7NhWR90pSgrK4VwDtABL2t6Yqo5B71TDsrVAlFUGRu+tceP3htYu7VHDiW4S1BWLT0FErI9Ww/28XPhxCwWU9m6lQQ1g7sCT1m0ddLZGYagAjLIRP0k=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1604892838;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=2FYXm/brPVetiXORzb8kEOXQkLAdKQUH2WjsHHLMans=;
        b=KwsnJKvpd2hCXIdOgQQQDLUPTq/7kNrnqj/5PeoM9MbmvXHbDDnpZKrZ1LEBit3k
        AHGm06odJ9C2dclqnlYLXcal3YFt0MjBvVAEuKAG1YE6jmZxbmsPdP/mUhya2QCF2Hm
        K7WVJsvVkcJtJNu+yNB8oyk6gqeYBI61hxF33Ujo=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1604892837359899.1502857498393; Mon, 9 Nov 2020 11:33:57 +0800 (CST)
Date:   Mon, 09 Nov 2020 11:33:57 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Chengguang Xu" <cgxu519@mykernel.net>
Cc:     "miklos" <miklos@szeredi.hu>, "jack" <jack@suse.cz>,
        "amir73il" <amir73il@gmail.com>,
        "linux-unionfs" <linux-unionfs@vger.kernel.org>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>
Message-ID: <175ab1145ed.108462b5a912.9181293177019474923@mykernel.net>
In-Reply-To: <20201108140307.1385745-10-cgxu519@mykernel.net>
References: <20201108140307.1385745-1-cgxu519@mykernel.net> <20201108140307.1385745-10-cgxu519@mykernel.net>
Subject: =?UTF-8?Q?=E5=9B=9E=E5=A4=8D:[RFC_PATCH_v3_09/10]_ovl:_introduce_?=
 =?UTF-8?Q?helper_of_syncfs_writeback_inode_waiting?=
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: ZohoCN Mail
X-Mailer: ZohoCN Mail
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E6=97=A5, 2020-11-08 22:03:06 Chengguang=
 Xu <cgxu519@mykernel.net> =E6=92=B0=E5=86=99 ----
 > Introduce a helper ovl_wait_wb_inodes() to wait until all
 > target upper inodes finish writeback.
 >=20
 > Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
 > ---
 >  fs/overlayfs/super.c | 30 ++++++++++++++++++++++++++++++
 >  1 file changed, 30 insertions(+)
 >=20
 > diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
 > index e5607a908d82..9a535fc11221 100644
 > --- a/fs/overlayfs/super.c
 > +++ b/fs/overlayfs/super.c
 > @@ -255,6 +255,36 @@ static void ovl_put_super(struct super_block *sb)
 >      ovl_free_fs(ofs);
 >  }
 > =20
 > +void ovl_wait_wb_inodes(struct ovl_fs *ofs)
 > +{
 > +    LIST_HEAD(tmp_list);
 > +    struct ovl_inode *oi;
 > +    struct inode *upper;
 > +
 > +    spin_lock(&ofs->syncfs_wait_list_lock);
 > +    list_splice_init(&ofs->syncfs_wait_list, &tmp_list);
 > +
 > +    while (!list_empty(&tmp_list)) {
 > +        oi =3D list_first_entry(&tmp_list, struct ovl_inode, wait_list)=
;
 > +        list_del_init(&oi->wait_list);
 > +        ihold(&oi->vfs_inode);

Maybe I overlooked race condition with inode eviction, so still need to int=
roduce
OVL_EVICT_PENDING flag just like we did in old syncfs efficiency patch seri=
es.


Thanks=EF=BC=8C
Chengguang
