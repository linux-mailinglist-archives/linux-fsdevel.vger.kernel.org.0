Return-Path: <linux-fsdevel+bounces-29913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3CD983A54
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 01:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01A05282D41
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 23:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61117130ADA;
	Mon, 23 Sep 2024 23:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDMhwB2k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190768C06;
	Mon, 23 Sep 2024 23:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727133438; cv=none; b=kUp5E+hnJ3OQiqZsg+vuB+3dEGi17XWwsq6EKLxdckrW0+DZCCavhtBOmwP+bGAgjTkKjsB8gxaHb9ZPuqca6Szc6EoE32etjCqzin3JJFPrQbTQEqsNXL1hyY3kzxGJvhO9RSOVquy77flNSy0YSnDv64RlGkkHQQWzrUA45Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727133438; c=relaxed/simple;
	bh=0nsbGQ5ZG+++6fMb6NiR0gGaP+XrX2RMKND9mwuNB3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ubX5kEb/PQGEe4HocS+d7jTYFklM06vFDR1ZmKGBOtdEqxV0MIjMRFvJvSnXHDw4PAEGtSTsLSnfxeN36zdAuSgKloDkJVvIbH/DxUYhDPCbFiDTgy9scZF/44po1Qa8ppjeXXQUWWpYxS0wHOYBkK/+8x8eiRO+O6cy0oFYWPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDMhwB2k; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c5b9d2195eso2927918a12.1;
        Mon, 23 Sep 2024 16:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727133434; x=1727738234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ngRtzW5JM4PktiK1i50Y+IhfPwDmKMxpAqupnEmiErk=;
        b=ZDMhwB2ke70yQ2Z32apIjRGlLZxCq8CUu2EXhROdU8PyJPDcKPMnRt2vTp9n9M0grH
         OodDi38OhhmrN0D1h2lpj3wWS4bkcF+eJJ5AbmLgnlZeEURHhPt7j/T5Hi9Aeaf5nT/7
         n8cDlnBg3FxsFwg7bE2uq6tT2vDJwhes27r0UMn+9VmtEy1z7i0HXTPFtNq7u+5QYSNy
         fDPhH5nm10wAk2tBDhlV/GJXO5o+nXWvglEQcv26SeBsNOwGlmi3hnldIpXQgYelOhpR
         klAWDnyzkMMvSaZb5bP0VTb6/uNySiAcdNJTk7mIGujSwGkE8v8HC3bah3Yll1B7bhr8
         LcSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727133434; x=1727738234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ngRtzW5JM4PktiK1i50Y+IhfPwDmKMxpAqupnEmiErk=;
        b=qn91G3z4ZZfdldf8wwk6uQWPyK+TzmX3c2HqG9lZABj6vsfY/tGvWWQVuyn6bay0t8
         rqdKBNzK6x9pyUFTpLte87M9qS28vHrLe+O4xiLEMKpQXxWxzFWvi0nH5Hq7GdOQODIE
         31QnhZGu3lakNXRuskpr9heQrskPDKhFiJTD/PE4WOW87UOFYgfFr5h5d4Rs3l3Z3kr4
         Z4536TS/35l+mUVCXVSbvTdpaQHaGgF01189LmWVv221vkS6m5ZOjQfhNnsyIw+KOWxf
         lEuIX/dMDyWzLbETGYO2Z88YM2pGowpbHnRL1/Ekr4bkkMGI5D+ZRuMMZl4EQeu+zhrY
         1nDg==
X-Forwarded-Encrypted: i=1; AJvYcCUDaTC20vLN4OrnQA4I4zNfXwmUkwB6K0cmSJv+BsQRrlxuzAPvIdsEVug6UnwmgzRjAHVXBUGvcQnQ@vger.kernel.org, AJvYcCUcvR3tXGgL9YvArsOblEDZMcUhvsmX1H5/fQ5sHuYDOmF3enSi0svdWY57A0QDXFx18ehOI6O4uvNu@vger.kernel.org, AJvYcCVPBEqpVcZPNOmLy2cPCJiizDq6r7riIPCyQzSniPcZj5K8ZYR3o3xajzz0nYgmTbuR4YuCA4RtVqDoNw==@vger.kernel.org, AJvYcCVlLXgK/VIf4NWsw0ECR+zuPL5W+PQO9YVnPGbospNLuI2UWNpgLO0ToNxYPEJqRGpcUVmlpI3ERXniPGWGyg==@vger.kernel.org, AJvYcCWDuHH4/mRADIINpPSp6WLBpWj24z16psjfwVvrQUxeUqOmxPhaD1Z+zPj0heLg00mq2lmsQwFybgrup6ag@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm82CJeUreG28o2EfFvQKlGqfsL3WAsDotnI4cMUlTEc9WSIMH
	4VcpzadhFw5S9PLsE6NxRZSmNJ9zCo//aAEXOQAsHcBplZ3ocoAr26D/zJ4gaLNHDdMJMnD7Vp2
	rpe2aSqQhqK7TVMgPTsJ8leiCdWA=
X-Google-Smtp-Source: AGHT+IH8LipBtLSxEtozQ2rg05n3Ixckwwsb8tD+R3wx/CmXcuSVcLfSG+Z/gs1ubLzXvUowuTAPkX6CdLZ8O6/puxQ=
X-Received: by 2002:a05:6402:3506:b0:5c5:c2a7:d53a with SMTP id
 4fb4d7f45d1cf-5c5c2a7d69amr3583016a12.12.1727133434103; Mon, 23 Sep 2024
 16:17:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923150756.902363-1-dhowells@redhat.com> <20240923150756.902363-2-dhowells@redhat.com>
In-Reply-To: <20240923150756.902363-2-dhowells@redhat.com>
From: Steve French <smfrench@gmail.com>
Date: Mon, 23 Sep 2024 18:17:00 -0500
Message-ID: <CAH2r5mv75LkMnB4ZAWO+sxQwjMne1gKb5EGC3i7kc7h=L0emSA@mail.gmail.com>
Subject: Re: [PATCH 1/8] netfs: Fix mtime/ctime update for mmapped writes
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>, Steve French <sfrench@samba.org>, 
	Marc Dionne <marc.dionne@auristor.com>, Paulo Alcantara <pc@manguebit.com>, 
	Jeff Layton <jlayton@kernel.org>, Matthew Wilcox <willy@infradead.org>, netfs@lists.linux.dev, 
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

added to cifs-2.6.git for-next since it is important as it fixes a
regression affecting cifs.ko

On Mon, Sep 23, 2024 at 10:08=E2=80=AFAM David Howells <dhowells@redhat.com=
> wrote:
>
> The cifs flag CIFS_INO_MODIFIED_ATTR, which indicates that the mtime and
> ctime need to be written back on close, got taken over by netfs as
> NETFS_ICTX_MODIFIED_ATTR to avoid the need to call a function pointer to
> set it.
>
> The flag gets set correctly on buffered writes, but doesn't get set by
> netfs_page_mkwrite(), leading to occasional failures in generic/080 and
> generic/215.
>
> Fix this by setting the flag in netfs_page_mkwrite().
>
> Fixes: 73425800ac94 ("netfs, cifs: Move CIFS_INO_MODIFIED_ATTR to netfs_i=
node")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202409161629.98887b2-oliver.sang@i=
ntel.com
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: Steve French <sfrench@samba.org>
> cc: Paulo Alcantara <pc@manguebit.com>
> cc: linux-cifs@vger.kernel.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/netfs/buffered_write.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
> index d7eae597e54d..b3910dfcb56d 100644
> --- a/fs/netfs/buffered_write.c
> +++ b/fs/netfs/buffered_write.c
> @@ -552,6 +552,7 @@ vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, s=
truct netfs_group *netfs_gr
>                 trace_netfs_folio(folio, netfs_folio_trace_mkwrite);
>         netfs_set_group(folio, netfs_group);
>         file_update_time(file);
> +       set_bit(NETFS_ICTX_MODIFIED_ATTR, &ictx->flags);
>         if (ictx->ops->post_modify)
>                 ictx->ops->post_modify(inode);
>         ret =3D VM_FAULT_LOCKED;
>
>


--=20
Thanks,

Steve

