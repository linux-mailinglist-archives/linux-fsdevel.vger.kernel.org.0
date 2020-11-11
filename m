Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB0B32AF1ED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Nov 2020 14:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgKKNVI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Nov 2020 08:21:08 -0500
Received: from sender21-op-o12.zoho.com.cn ([118.126.63.243]:17149 "EHLO
        sender21-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726101AbgKKNVI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Nov 2020 08:21:08 -0500
X-Greylist: delayed 912 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Nov 2020 08:21:07 EST
ARC-Seal: i=1; a=rsa-sha256; t=1605099929; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=UgDYs3NvPCkNySRkbzGqu2P4aiMgyp4QyULKglvKH92dmV58qX1pbyQQffFFIrL706TvIRKO8Kdbsw3m19qHKlgwVvBN7KAR7lGxHfykxikb2yecQ/EfFLuLG3vbebJU6FcqqF6hyqWyJJUkjiIQszbPd9UPuHRIKQNk4RZKH9I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1605099929; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=k41+sYNAP9Kyu2Asxnn1o/eCrqBP14fWhJ4edoO7Dig=; 
        b=Y2B8r6gmgvnQi3oSKC0d94b+fDoGzt4dayMOhzBL5Ht1dj0RZRKJu1/AjLeDbx8PQKI94HzHiaTc6t4HteILq545dgmanwA5fK/t+/n3Y90ZFSQLFDBO1KXdcpOd87Dwl/PKccTSZDLyTIeq2i5jtWsYhoSXwHjWTyBiFTgY+Jc=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1605099929;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=k41+sYNAP9Kyu2Asxnn1o/eCrqBP14fWhJ4edoO7Dig=;
        b=WfoiIeBHwO0xOYkta5JV3kiNxDwGC+dEwt4dNSYznT3MSEkYE1Kv3ZVOMrh6wG4W
        wvAAmar6W9bXMKQXTx7EGpjIaSKd/XF4zYftpcXZ9iyP1QoCtdbQO8OeMie/P+qNVxu
        geAAodWQrUtHlmrg3mbTkFnBtvDctxePYNyPeGjU=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1605099927873724.93340982176; Wed, 11 Nov 2020 21:05:27 +0800 (CST)
Date:   Wed, 11 Nov 2020 21:05:27 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Chengguang Xu" <cgxu519@mykernel.net>
Cc:     "miklos" <miklos@szeredi.hu>, "jack" <jack@suse.cz>,
        "amir73il" <amir73il@gmail.com>,
        "linux-unionfs" <linux-unionfs@vger.kernel.org>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>
Message-ID: <175b769393e.da9339695127.2777354745619336639@mykernel.net>
In-Reply-To: <20201108140307.1385745-7-cgxu519@mykernel.net>
References: <20201108140307.1385745-1-cgxu519@mykernel.net> <20201108140307.1385745-7-cgxu519@mykernel.net>
Subject: =?UTF-8?Q?=E5=9B=9E=E5=A4=8D:[RFC_PATCH_v3_06/10]_ovl:_mark_o?=
 =?UTF-8?Q?verlayfs'_inode_dirty_on_shared_mmap?=
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: ZohoCN Mail
X-Mailer: ZohoCN Mail
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E6=97=A5, 2020-11-08 22:03:03 Chengguang=
 Xu <cgxu519@mykernel.net> =E6=92=B0=E5=86=99 ----
 > Overlayfs cannot be notified when mmapped area gets dirty,
 > so we need to proactively mark inode dirty in ->mmap operation.
 >=20
 > Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
 > ---
 >  fs/overlayfs/file.c | 2 ++
 >  1 file changed, 2 insertions(+)
 >=20
 > diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
 > index efccb7c1f9bc..662252047fff 100644
 > --- a/fs/overlayfs/file.c
 > +++ b/fs/overlayfs/file.c
 > @@ -486,6 +486,8 @@ static int ovl_mmap(struct file *file, struct vm_are=
a_struct *vma)
 >          /* Drop reference count from new vm_file value */
 >          fput(realfile);
 >      } else {
 > +        if (vma->vm_flags & (VM_SHARED|VM_MAYSHARE))

Maybe it's better to mark dirty only having upper inode.


 > +            ovl_mark_inode_dirty(file_inode(file));
 >          /* Drop reference count from previous vm_file value */
 >          fput(file);
 >      }
 > --=20
 > 2.26.2
 >=20
 >=20
 >=20
