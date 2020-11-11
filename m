Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B53A82AF5D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Nov 2020 17:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgKKQJn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Nov 2020 11:09:43 -0500
Received: from sender21-pp-o92.zoho.com.cn ([118.126.63.251]:25331 "EHLO
        sender21-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726702AbgKKQJm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Nov 2020 11:09:42 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1605110945; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=j+/QIPIaCTp/0QIDvqHFJvOerTPBvS9IglM8V8C0dfi8ouHSARyRXs49N0pgHyxvlnfI6X1JtRyTfIOzJowg9MRM00KhYhWvznXv8Zf3ASd/c1zJzL0Pi4bpWTM5t7noppsBiEwYsuVmeqsOPMwwWzkHGd6FR88U8jdq9uhZOXU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1605110945; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=s1aqp/Y3chJfN+xDBLg0x7/Y4Bgq70OXvdHSRA/al+Y=; 
        b=nmfx1dd+kjfblmulE/qgg6aecoCy/qPV/JTc1p02YngGSw8vo/jk3fK7JA24mAyFjFU9QnkF8dAFKZ0fgpSPQAiRKCmShtmMt7sHi4nEG8N6uqOLuLRgf9O4jXEpAAePHo7eZUNizfsvFsc92V28yLJYwXhGTqYVArVxM0IsYb4=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1605110945;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=s1aqp/Y3chJfN+xDBLg0x7/Y4Bgq70OXvdHSRA/al+Y=;
        b=Py+j5uNmNO8Y2PaN76cN7V8tT0vldjLeaYNi5HdobDzP1WXoQKT3UNb0yOX/3ifR
        hRezBDWSosPGSnYTWjP7WU6doT1TVQJVbcO3stOgxzNS3TmjhdwmCpvU+JMaHE2r6SU
        5tQZIAynpcACkP+C3odWNYaE9yROsqVcb/S7YlAQ=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1605110943133886.9861480460913; Thu, 12 Nov 2020 00:09:03 +0800 (CST)
Date:   Thu, 12 Nov 2020 00:09:03 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Amir Goldstein" <amir73il@gmail.com>
Cc:     "miklos" <miklos@szeredi.hu>, "jack" <jack@suse.cz>,
        "linux-unionfs" <linux-unionfs@vger.kernel.org>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>
Message-ID: <175b8114d9a.d35f90865969.6295508804432147693@mykernel.net>
In-Reply-To: <CAOQ4uxhG__saz3qWpDUzXUNkBuueAAMzBoXXXOnmnAL2JMSKjQ@mail.gmail.com>
References: <20201108140307.1385745-1-cgxu519@mykernel.net>
 <20201108140307.1385745-7-cgxu519@mykernel.net> <175b769393e.da9339695127.2777354745619336639@mykernel.net> <CAOQ4uxhG__saz3qWpDUzXUNkBuueAAMzBoXXXOnmnAL2JMSKjQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 06/10] ovl: mark overlayfs' inode dirty on shared
 mmap
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: ZohoCN Mail
X-Mailer: ZohoCN Mail
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=B8=89, 2020-11-11 23:20:56 Amir Golds=
tein <amir73il@gmail.com> =E6=92=B0=E5=86=99 ----
 > On Wed, Nov 11, 2020 at 3:05 PM Chengguang Xu <cgxu519@mykernel.net> wro=
te:
 > >
 > >  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E6=97=A5, 2020-11-08 22:03:03 Cheng=
guang Xu <cgxu519@mykernel.net> =E6=92=B0=E5=86=99 ----
 > >  > Overlayfs cannot be notified when mmapped area gets dirty,
 > >  > so we need to proactively mark inode dirty in ->mmap operation.
 > >  >
 > >  > Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
 > >  > ---
 > >  >  fs/overlayfs/file.c | 2 ++
 > >  >  1 file changed, 2 insertions(+)
 > >  >
 > >  > diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
 > >  > index efccb7c1f9bc..662252047fff 100644
 > >  > --- a/fs/overlayfs/file.c
 > >  > +++ b/fs/overlayfs/file.c
 > >  > @@ -486,6 +486,8 @@ static int ovl_mmap(struct file *file, struct v=
m_area_struct *vma)
 > >  >          /* Drop reference count from new vm_file value */
 > >  >          fput(realfile);
 > >  >      } else {
 > >  > +        if (vma->vm_flags & (VM_SHARED|VM_MAYSHARE))
 > >
 > > Maybe it's better to mark dirty only having upper inode.
 > >
 >=20
 > Yeh.
 >=20
 > And since mapping_map_writable() is only called if VM_SHARED flag
 > is set (and not VM_MAYSHARE), we are not going to re-dirty an inode on
 > account of VM_MAYSHARE alone, so I wonder why we need to mark it
 > dirty here on account of VM_MAYSHARE?
 >=20

Yeah, you are right. It just means the pages in this memory region can be m=
apped
by other process with shared+write mode and this is actually meaningless in=
 our case.
So let's just ignore it. :-)


Thanks,
Chengguang



