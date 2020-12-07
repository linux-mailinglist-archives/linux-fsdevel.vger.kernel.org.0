Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B8A2D11A0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 14:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgLGNPh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 08:15:37 -0500
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25334 "EHLO
        sender2-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725850AbgLGNPh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 08:15:37 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1607346814; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=EIPjGMUQItKAOjOMk6h5MN62nMJSt2Rj0Bc42jFqzcyRtmnsXXvk8hIqF4NNmJ7w5skB/l9RjvDSUFrBcDlXpv0JZx7Ywozhm66fbQyl8MCP/Qx/gRhZQN9Q8s+jv2gG1YYgq7hpwEoAfrgmhrQE8WJHrd5AOBc0zf5Q9PXkPPA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1607346814; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=m1EXW9UrNenJ4Drup8QUGkjJFS4dJg1NixP1O1C1HGU=; 
        b=ihF8Uqu+wKoeIggK9To4iz6RgFX1t4n0YOk2icmDotGioXAGV2mO0qVRMhCpmLhDHGNaTXW+Xr3T+MfYctkyi6zyogBnKesdOEx1m4t7CWjcRZpkzmVlnDXFP7AcJ+f3zdwUhdY5GrXjoMMVedkpf6ln1PqsFjBKLFWhXvrHdDg=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1607346814;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=m1EXW9UrNenJ4Drup8QUGkjJFS4dJg1NixP1O1C1HGU=;
        b=VcZxE0Js8r+IaCwt/2qgxqNYtbB3qZIsCySg+PB2exioCrQk7NrBlD+B0APiFvOM
        D6JdhltnbIXAk3YUdeW8eiStMEH79Sl68kJTAKXKxxFkaIZ43E5mZZBwG8iuwkah/Tj
        pxvpeT51S2YrX75fXlwIuXM9Fr2NRGsHMsqx7qGY=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1607346811183256.91092767797534; Mon, 7 Dec 2020 21:13:31 +0800 (CST)
Date:   Mon, 07 Dec 2020 21:13:31 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Dominique Martinet" <asmadeus@codewreck.org>
Cc:     "ericvh" <ericvh@gmail.com>, "lucho" <lucho@ionkov.net>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "v9fs-developer" <v9fs-developer@lists.sourceforge.net>
Message-ID: <1763d55f12b.11abdd4431975.7848752990749710617@mykernel.net>
In-Reply-To: <20201207112410.GA26628@nautica>
References: <20201205130904.518104-1-cgxu519@mykernel.net>
 <20201206091618.GA22629@nautica>
 <20201206205318.GA25257@nautica>
 <1763bcb5b8e.da1e98e51195.9022463261101254548@mykernel.net> <20201207112410.GA26628@nautica>
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

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=B8=80, 2020-12-07 19:24:10 Dominique =
Martinet <asmadeus@codewreck.org> =E6=92=B0=E5=86=99 ----
 > Chengguang Xu wrote on Mon, Dec 07, 2020:
 > >  > , VM_MAYWRITE is set anytime we have a shared map where file has
 > >  > been opened read-write, which seems to be what you want with regard=
s to
 > >  > protecting from mprotect calls.
 > >  >=20
 > >  > How about simply changing check from WRITE to MAYWRITE?
 > >=20
 > > It would be fine and based on the code in do_mmap(), it  seems we even=
 don't
 > > need extra check here.  The condition (vma->vm_flags & VM_SHARED) will=
 be enough.
 > > Am I missing something?
 >=20
 > VM_MAYWRITE is unset if the file hasn't been open for writing (in which
 > case the mapping can't be mprotect()ed to writable map), so checking it
 > is a bit more efficient.
 >=20
 > Anyway I'd like to obsolete the writeback fid uses now that fids have a
 > refcount (this usecase can be a simple refcount increase), in which case
 > efficiency is less of a problem, but we're not there yet...
 >=20
 > Please resend with MAYWRITE if you want authorship and I'll try to take
 > some time to test incl. the mprotect usecase.
 >=20

Thanks for the review, I'll send revised version later.

Thanks,
Chengguang
