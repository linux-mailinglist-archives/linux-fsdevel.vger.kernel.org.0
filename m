Return-Path: <linux-fsdevel+bounces-59473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DC2B39848
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 11:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3FF65E88B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 09:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B352EB876;
	Thu, 28 Aug 2025 09:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QQjMW8bq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3C12DF6F4
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 09:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756373313; cv=none; b=P0qncYns4+nokBeYnMnXk9cpSlvwceQxecgaVX0llZdSrsn+6G72SkVNs1i7/j5fvbbkTawUFp/B3VigbrAcqjNUCrnAIiM2baPx71qvGKAFl+PyvHQ/veIXnL2yJ6ZIPgJTyedeVK/gOhO60Xb6QlIU4em8H5PW741JOzxJ9vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756373313; c=relaxed/simple;
	bh=41vsgwcYkQ4IUFYJ2M85ThOCWhadNmIJp+OoxRrHBUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QS7MbSj2r2tvdrSC7WWVodof6M3Dk1s3NJkOiDak8gZ/4xs34YeFl4SA8r5jw8B+qMVZgYHFlY9WXUxKypAud/NuRP1rP7wX5jOPrTy5EUJdtxfURJb3oi7IjhGh61Al1jCH7y9v0eQmHxrDzdqGx9h4trFVUSdOMrehfkKPqYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QQjMW8bq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756373310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GZjQmtd/MKJDkd12hmfrf8B5oKv442M44MRUvmxo1TY=;
	b=QQjMW8bqL5fzXbmEy6eZZcUD4CP700914RQqHZ4eVAhFa+8L7Um8ecm00/cCaOOtBGpjXj
	FEkoe1wTrI5KJnaM+ZslzroFQF6dQGx0QCqzJgc6WK4ORNHjrGJoO9jYLXtG5IVjgPfpN6
	qMmpSIBauGUCnSRpgR7zTjCDpSXc1/Q=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-vdkqBXY8O8i0ADxzlQoKPg-1; Thu, 28 Aug 2025 05:28:28 -0400
X-MC-Unique: vdkqBXY8O8i0ADxzlQoKPg-1
X-Mimecast-MFC-AGG-ID: vdkqBXY8O8i0ADxzlQoKPg_1756373308
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-893b748608eso1096322241.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 02:28:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756373308; x=1756978108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GZjQmtd/MKJDkd12hmfrf8B5oKv442M44MRUvmxo1TY=;
        b=hsOfHTP5Do1rQEEoWNke8eLYA8KSb0XI9Ww55YEREL4d8S4SiKCpU28oUU5hvIw2WO
         5Xj0j8WWhZAr5dEE6TlLpgTH1vB7dgEKYdGghqncX0xmLonVbjtj+cbKx+Pv4AauIgJB
         PaxGOvg4FI/YmStptGMF48fqTuvoIEc1s2+KAVfd14iMcIaqS8uBmaF5Vq+khofzmQcG
         99Ze6ZkuldCzD21CfaABwOkNvOarQMlCrmduKE/PcgmAeWD0UJqvqdsHXSVdOTfc3Nga
         eYiggreQWilftC76pE7QgidKlslCiYxmfL2bd7wJF6jz1K6Q7zrD7Jl1XiS/kcYgE/66
         9P/w==
X-Forwarded-Encrypted: i=1; AJvYcCVPHUzGM41tiFWq2N3xck7MldLMzpzMDknFTN3JHJExLb3tOZo/8FNb07l+BxoW+CbmKuIgs6qnTaZRULfX@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu3YEtnROpSCDWQHM+Bfh0+vGZirQoaBqcmSJ7IEVJRnGLPpky
	tH3pt80Gq1rwrLzLsTSQQxxUWE548MIdxfTURtI2i0YYjcSTayz4KVFoRkLCuhZSssEzGGLV8Tx
	8XPNVOg8MkRU5i7h01CLAZWhQy57YSOvdYz5eBEVi7Jp1NqJrcaa3BTjMSTuMXTrIDN1MslU6Ef
	KvJbWJW4CJVACIpkv95lVMs0BiB4X4h7K1SvesJoC6XA==
X-Gm-Gg: ASbGncvhBHTLdoaFmXYFq+wtHZ7wUvN90kdcv+zLxmQFfjjho8qaMFmUlsKt5gP0NsG
	IVG8v1+NPNQrgARHP05IfBtohIDVsEAcUkFeCdWPPohWorqV/Yh8dZUZf3DRUUhRK8+z9CRDo06
	Xk8o9sfxooocTO2evOn3uzPQ==
X-Received: by 2002:a05:6102:50a9:b0:4e9:963f:286a with SMTP id ada2fe7eead31-5248bbc85b1mr2551655137.5.1756373307749;
        Thu, 28 Aug 2025 02:28:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEm4A6m5qS0r2rDm6mJAmMGLAW1wODkxU8Jua/Ytk8QtlvJstKwpAv88Zef4Dv97F7VVvFIWy1VDwj3wGe/xM8=
X-Received: by 2002:a05:6102:50a9:b0:4e9:963f:286a with SMTP id
 ada2fe7eead31-5248bbc85b1mr2551646137.5.1756373307388; Thu, 28 Aug 2025
 02:28:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827190122.74614-2-slava@dubeyko.com>
In-Reply-To: <20250827190122.74614-2-slava@dubeyko.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Thu, 28 Aug 2025 12:28:15 +0300
X-Gm-Features: Ac12FXxTATopapzxEeYLFAQyFqACGNij-rBWX3RuRiINATrRYSK_I8XLw7mJ33o
Message-ID: <CAO8a2Sj1QUPbhqCYftMXC1E8+Dd=Ob+BrdTULPO7477yhkk39w@mail.gmail.com>
Subject: Re: [PATCH] ceph: fix potential NULL dereferenced issue in ceph_fill_trace()
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com, 
	linux-fsdevel@vger.kernel.org, pdonnell@redhat.com, Slava.Dubeyko@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Considering we hadn't seen any related issues, I would add an unlikely
macro for that if.

On Wed, Aug 27, 2025 at 10:02=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko.=
com> wrote:
>
> From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
>
> The Coverity Scan service has detected a potential dereference of
> an explicit NULL value in ceph_fill_trace() [1].
>
> The variable in is declared in the beggining of
> ceph_fill_trace() [2]:
>
> struct inode *in =3D NULL;
>
> However, the initialization of the variable is happening under
> condition [3]:
>
> if (rinfo->head->is_target) {
>     <skipped>
>     in =3D req->r_target_inode;
>     <skipped>
> }
>
> Potentially, if rinfo->head->is_target =3D=3D FALSE, then
> in variable continues to be NULL and later the dereference of
> NULL value could happen in ceph_fill_trace() logic [4,5]:
>
> else if ((req->r_op =3D=3D CEPH_MDS_OP_LOOKUPSNAP ||
>             req->r_op =3D=3D CEPH_MDS_OP_MKSNAP) &&
>             test_bit(CEPH_MDS_R_PARENT_LOCKED, &req->r_req_flags) &&
>              !test_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags)) {
> <skipped>
>      ihold(in);
>      err =3D splice_dentry(&req->r_dentry, in);
>      if (err < 0)
>          goto done;
> }
>
> This patch adds the checking of in variable for NULL value
> and it returns -EINVAL error code if it has NULL value.
>
> [1] https://scan5.scan.coverity.com/#/project-view/64304/10063?selectedIs=
sue=3D1141197
> [2] https://elixir.bootlin.com/linux/v6.17-rc3/source/fs/ceph/inode.c#L15=
22
> [3] https://elixir.bootlin.com/linux/v6.17-rc3/source/fs/ceph/inode.c#L16=
29
> [4] https://elixir.bootlin.com/linux/v6.17-rc3/source/fs/ceph/inode.c#L17=
45
> [5] https://elixir.bootlin.com/linux/v6.17-rc3/source/fs/ceph/inode.c#L17=
77
>
> Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> cc: Alex Markuze <amarkuze@redhat.com>
> cc: Ilya Dryomov <idryomov@gmail.com>
> cc: Ceph Development <ceph-devel@vger.kernel.org>
> ---
>  fs/ceph/inode.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index fc543075b827..dee2793d822f 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -1739,6 +1739,11 @@ int ceph_fill_trace(struct super_block *sb, struct=
 ceph_mds_request *req)
>                         goto done;
>                 }
>
> +               if (!in) {
> +                       err =3D -EINVAL;
> +                       goto done;
> +               }
> +
>                 /* attach proper inode */
>                 if (d_really_is_negative(dn)) {
>                         ceph_dir_clear_ordered(dir);
> @@ -1774,6 +1779,12 @@ int ceph_fill_trace(struct super_block *sb, struct=
 ceph_mds_request *req)
>                 doutc(cl, " linking snapped dir %p to dn %p\n", in,
>                       req->r_dentry);
>                 ceph_dir_clear_ordered(dir);
> +
> +               if (!in) {
> +                       err =3D -EINVAL;
> +                       goto done;
> +               }
> +
>                 ihold(in);
>                 err =3D splice_dentry(&req->r_dentry, in);
>                 if (err < 0)
> --
> 2.51.0
>


