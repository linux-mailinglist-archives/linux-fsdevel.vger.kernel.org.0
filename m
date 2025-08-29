Return-Path: <linux-fsdevel+bounces-59627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 483CFB3B792
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 11:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03972200E59
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 09:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8452F4A12;
	Fri, 29 Aug 2025 09:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Futjb47b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB4427587E
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 09:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756460180; cv=none; b=TnD2InKqqIGpjLQSdXhtNIHBSQ+Y82YPWi6ROTb6q8/d8OGOrGCl9yiZeARhc27qioHnPRDWVaJOqNv+/SoOyd5Z7CK5PftEx36ZkaBkTXppDy11ZjeV6Oi19RQ9DyG35pd3PdD5T82X9l7oFmm7+gYEgxC/IIXEelyxN3pcA9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756460180; c=relaxed/simple;
	bh=fQkfpmLakVR8TBAul9808wWECjr1KhWDC5ssSn54a40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cgYsvjoOaPQ8z2nkW7dll/uATF0MSlbtpqC9n8TnwF+ad1vIW1jZKMNZSJy2S6EXmG91suWcdG9grmB5oTG0DQWvuuKB9hntwTOl7nYwDlbHs97tL4RPcw7c8AxxKiPTzjNVv30K+bynwnJ4DPp88+aesTwiit9+/Wb2aybuP0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Futjb47b; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756460177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZqS4Bkc3I0NVeANvpIab5dENRqxqrs5p3VIvl6dIMa8=;
	b=Futjb47bvfN1NaRx2DU4rEPHdS6Y3sdfaMaRIQzRuffBDPfbcvMGg5aH5fBDMRZ9CmKX4P
	T+kcXZjVqRrXvfTSeIFTB63wj+vg0l9XAa5voS0Y5li2Tt4XPF50QW3OyQn4X6h5RtpN8s
	P4oEZ2MDRoQH/Ovh/5MXX+ZW+XyuvB8=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-uRe8JI6AMSq4UiDXEY1_kw-1; Fri, 29 Aug 2025 05:36:15 -0400
X-MC-Unique: uRe8JI6AMSq4UiDXEY1_kw-1
X-Mimecast-MFC-AGG-ID: uRe8JI6AMSq4UiDXEY1_kw_1756460174
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-54494477f93so305688e0c.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 02:36:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756460174; x=1757064974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZqS4Bkc3I0NVeANvpIab5dENRqxqrs5p3VIvl6dIMa8=;
        b=X9V8c16buKxL5gRSzsU1tMXb2CxTdDf5o/XnULF4iFz33mrSusIoZMmlid0ONtjsb6
         jIvH+cSH78B9aoq0/wWGavOkJ5ewhIzRLBWa1xxr37sdq3tPBKhvqAi/f+lr0aP9HqFt
         UJHnr1A7Poj0VC9uoZtarQug00pAHDmyRGKg0NACZyPAX3o1k3wdBBlAiyt5ohcFEzfr
         54UJKRjAN94SukHvVz3yAwXL7baKA1Bcc4LC3YBM1FRW0ruc5Yut1N/S3Wa6Tydi6a6M
         ZT/S2zJqoAAeh+kdDGwHu/JNnQW1gQTHpWGn/Hv6fhUYd1r7LfDUxy+9XVAWz6umSRP5
         IqJA==
X-Forwarded-Encrypted: i=1; AJvYcCXelpcGiW0AnGzjxsH3rl/nBppOo5dphJOGO53EHBv0avD2SpibL4uagQRpoSwCeFd8mVWHVffYapyA71T0@vger.kernel.org
X-Gm-Message-State: AOJu0YyFQ+nYxYJ4URCACZJ33JG8d2cUNbjnpsccRk5sGPC9OF/hqDiR
	RwoEJS0cA3AFQAcQTa2Ahl6WLJBN979H6mY6JRw9Ib/kc98eblCzLnJ90RNarJnQeVP6sEqJOzx
	wfJJNH+p2inLcwByFq9AQoBqv71j/0dqD8PsxGk3H5izYYU+ZeW32tSIQZp3ROnX1+GavHyKAKo
	uJ18oTu1eE+OBsCkLGF27WpfFI56RLXlf7jripCDNl6Q==
X-Gm-Gg: ASbGnctIEtRDlQFMGRiQ/QuQVIeLu1FWrmWMqtDeZ2nj9ofR16mpbs/sRDEd9j6+j9V
	lmj7L8gf9/JwqH0IzQbiwZaIGT4EIWo9Tr9aX1eMmVe8d27BEKb8b2cevvYoO8vfGXlDiNrBq4C
	/RQAH1ELFo7CDGrUWH5miIqUULQkgINq/EH0bf92U=
X-Received: by 2002:a05:6122:801a:20b0:544:9147:52 with SMTP id 71dfb90a1353d-54491470524mr301440e0c.5.1756460174377;
        Fri, 29 Aug 2025 02:36:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1iToO96wAeCdOEEwKrA8/gDyY87Iy/xg2/A0fn48S5IH+AgPRuSVKQE9N7BA4e2+T0JB5rtS1xZVbrS33GkA=
X-Received: by 2002:a05:6122:801a:20b0:544:9147:52 with SMTP id
 71dfb90a1353d-54491470524mr301435e0c.5.1756460174080; Fri, 29 Aug 2025
 02:36:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828184441.83336-2-slava@dubeyko.com>
In-Reply-To: <20250828184441.83336-2-slava@dubeyko.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Fri, 29 Aug 2025 12:36:01 +0300
X-Gm-Features: Ac12FXxfvqq3UfxdkD_792piihHsjv5TRejTfdpLuR5jpE7R_lciWBSBxLK59NY
Message-ID: <CAO8a2SgP6gK_jBkOFcMNbc4T5oWvnHi_OfM3QQ0JeUeLa8CGjQ@mail.gmail.com>
Subject: Re: [PATCH v2] ceph: fix potential NULL dereferenced issue in ceph_fill_trace()
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com, 
	linux-fsdevel@vger.kernel.org, pdonnell@redhat.com, Slava.Dubeyko@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Markuze amarkuze@redhat.com

On Thu, Aug 28, 2025 at 9:45=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko.c=
om> wrote:
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
> v2
> Alex Markuze suggested to add unlikely macro
> in the checking condition.
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
> index fc543075b827..8ef6b3e561cf 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -1739,6 +1739,11 @@ int ceph_fill_trace(struct super_block *sb, struct=
 ceph_mds_request *req)
>                         goto done;
>                 }
>
> +               if (unlikely(!in)) {
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
> +               if (unlikely(!in)) {
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


