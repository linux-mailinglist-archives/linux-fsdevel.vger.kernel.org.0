Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9249D2D0A84
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 07:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725960AbgLGGEX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 01:04:23 -0500
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25329 "EHLO
        sender2-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725773AbgLGGEW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 01:04:22 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1607320954; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=nNjPgyWZuQems30uAjW1VvUjLTlB330Ug51pLPJDZScD2h75Z2BY9tDW8t3lTAyz3S4evD+itbRcGWFi1+AnpRfeYVqQw3SZg8xaHzOyNt77PCLw6XdcX0sk4tw9x6rW+nGt4LMSvWkuibGeidDqf9o0CktYYAaXCELQ/FWXm4g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1607320954; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=oUSs20Tqr87VJ4Dr8Z9/uo0+fp+3MgSiNTywC26Lu8U=; 
        b=SrGuIFodK86OSKqbdTj4MBgwC04kOIQS+LWXFAbVqApTIGhyBl0FXLaZOuM0PZWsWFEwGOCU2zYco/m+yTDfjuU9Mo0/nhqcaa8p+7PXu2xOIYKA5KCx+diyrhD5YG0DO/VXv/oZGy5Qyy13PPFY5G1LP5gf/QOUo0vyNILLO14=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1607320954;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=oUSs20Tqr87VJ4Dr8Z9/uo0+fp+3MgSiNTywC26Lu8U=;
        b=QiAKmotU2fjAqoVADG4xD9LP77gn1weSBFvbBkdKls/Gr4i7AiXnhHOeWBrD8eLE
        2gyAQfOKsN8z7UN7+qDLAIEUhZfLIn+u9bQpv+CEGHmABRNUc7FzJetf52vEY0Xan4h
        khiSqvUykQJq+4aUQTjYPoc5N6vX7mXGvOetTIJk=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1607320951696384.7763970692308; Mon, 7 Dec 2020 14:02:31 +0800 (CST)
Date:   Mon, 07 Dec 2020 14:02:31 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Dominique Martinet" <asmadeus@codewreck.org>
Cc:     "ericvh" <ericvh@gmail.com>, "lucho" <lucho@ionkov.net>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "v9fs-developer" <v9fs-developer@lists.sourceforge.net>
Message-ID: <1763bcb5b8e.da1e98e51195.9022463261101254548@mykernel.net>
In-Reply-To: <20201206205318.GA25257@nautica>
References: <20201205130904.518104-1-cgxu519@mykernel.net>
 <20201206091618.GA22629@nautica> <20201206205318.GA25257@nautica>
Subject: Re: [V9fs-developer] [RFC PATCH] 9p: create writeback fid on shared
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

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=B8=80, 2020-12-07 04:53:18 Dominique =
Martinet <asmadeus@codewreck.org> =E6=92=B0=E5=86=99 ----
 > Dominique Martinet wrote on Sun, Dec 06, 2020:
 > > Chengguang Xu wrote on Sat, Dec 05, 2020:
 > > > If vma is shared and the file was opened for writing,
 > > > we should also create writeback fid because vma may be
 > > > mprotected writable even if now readonly.
 > >=20
 > > Hm, I guess it makes sense.
 >=20
 > I had a second look, and generic_file_readonly_mmap uses vma's
 > `vma->vm_flags & VM_MAYWRITE` instead (together with VM_SHARED),
 > while mapping_writably_mapped ultimately basically only seems to
 > validate that the mapping is shared from a look at mapping_map_writable
 > callers? It's not very clear to me.
 >=20
 > , VM_MAYWRITE is set anytime we have a shared map where file has
 > been opened read-write, which seems to be what you want with regards to
 > protecting from mprotect calls.
 >=20
 > How about simply changing check from WRITE to MAYWRITE?

It would be fine and based on the code in do_mmap(), it  seems we even don'=
t
need extra check here.  The condition (vma->vm_flags & VM_SHARED) will be e=
nough.
Am I missing something?

Thanks,
Chengguang

 >=20
 >      v9inode =3D V9FS_I(inode);
 >      mutex_lock(&v9inode->v_mutex);
 >      if (!v9inode->writeback_fid &&
 >          (vma->vm_flags & VM_SHARED) &&
 > -        (vma->vm_flags & VM_WRITE)) {
 > +        (vma->vm_flags & VM_MAYWRITE)) {
 >          /*
 >           * clone a fid and add it to writeback_fid
 >           * we do it during mmap instead of
