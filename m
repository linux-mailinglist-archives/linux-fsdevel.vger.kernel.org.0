Return-Path: <linux-fsdevel+bounces-50928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5B5AD12D7
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jun 2025 17:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9E2B168600
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jun 2025 15:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5962505AF;
	Sun,  8 Jun 2025 15:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="agJPm68L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F57078C9C
	for <linux-fsdevel@vger.kernel.org>; Sun,  8 Jun 2025 15:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749395178; cv=none; b=NtTWl7C2McZgSRajTftAkLcCF1VwzLsTth9N9mGY2HVi3UA6BvBOhBnQPTTumigDsZGuLZlrohyW0m2MfY6CYylx/jV5yyJ1DvsnYNtGxV+04yEGZ0O8LrKINhS2cQCUOTNIALo+wLGJjF7SjwsC1IWLC6UG5MnxVJYuxSaU9Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749395178; c=relaxed/simple;
	bh=zH9Nns8vl1kmmowzSYl8+S7pPdIbY/kcxjDKUjVu7OA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U6rIpH7xc1HJOaGUfqbL4neJs4rv8CC8jK6niUVQp7DLcBlUqkHHCP9mF5++KnN7QXMsKkcXz2BXSVqhaYvhjfOIhMGa3BIuq1AHCy682x05vVmiqxCljdbT2VrkdXc+/DoiWMIq+y03atolWqlNBgpQLBDGIANdpCBJ9iNNBCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=agJPm68L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749395175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jH7Re9mkdM+xpLTZAXbA6I8rMlizU4DOWxxreJlevxc=;
	b=agJPm68LwayWlTmXkqLEep0f8rPk5uRVAKlukwKtp93dsQ1L021/q9DmnHCEY9e9gXlEbZ
	3HCyQiMlk5kg8KMsvaGwC2W5soi8vG2sfndVVyXw6OsZC9E+A1ZNnkchqm0ofcy7wuOdTO
	0eRdL72g7M2mCePgXompjNHoP8eKtys=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-a6Co-xb1NXuT1z_HhlRtFw-1; Sun, 08 Jun 2025 11:06:13 -0400
X-MC-Unique: a6Co-xb1NXuT1z_HhlRtFw-1
X-Mimecast-MFC-AGG-ID: a6Co-xb1NXuT1z_HhlRtFw_1749395173
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7caef20a528so905974985a.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Jun 2025 08:06:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749395173; x=1749999973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jH7Re9mkdM+xpLTZAXbA6I8rMlizU4DOWxxreJlevxc=;
        b=nidYKoVJ1Yz4WpzaucySxTwQjRzgmrOEV+PybedhlBoPhW0o6giAAg9UREwvViGuH6
         wurfR+nM6ZNRZtPEhGzcupHO8aXBPMwF8C/1NaJqYxCvV2qK6YsC3MFFEuI+BSmbw51K
         qfaXP3Wo2sKcWA0sKuvM1pEHFq8NUPipmt2fHPOF5rLtr+HiPW0WgKyxlK8SkN51xFQn
         nS/+K1/OgKGpFuIXnrh6e/6pp/AHDUiPDeFY7/sL2vXRCuhmGbSH3janwHGhcpR5+GXb
         Zdr29F5BxcHcwAJgtLJZR6gpTLHzLNAkRnVOdPl+KJnzPTfk+pgbb3XzMOFVMGHpdWnz
         x7yQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNmLfW3iHEdK+O1ZVx1Z2Mm7qKHZTsQGQe2CRVl6af+c8ZlGHhNoa15Rpa9xKCn9P2fcSrLO5E4r/h7Ddd@vger.kernel.org
X-Gm-Message-State: AOJu0YzKrJPxTfjm/iQdPWGdfOtHHR+mWTIPYpQrhd/0g0xBs2d5cHxA
	iL4K3Z5zn0V9kAOY8zzUX9B9QbCz0fTmnaywRbyWy59n2HGp3RJFl8z7qk0Ub+tmT9/ay62lp1c
	ZMez8KCShw2wCwuGtvM2sJ8+pgfwKMAie7ZlO73UqrqSZY1lJHY1oA/CejHgNTLo/0SFYMgrNOp
	MkwJvf0JscxNu4l+6Y7YNQXe3btgywyVLkF8KqWMU2Iw==
X-Gm-Gg: ASbGncvNBmAfb/uZjmxwMjbpaprWGdt2whhtzlhpKIKEoGYz7fh/gudaET1vskJ9jsQ
	GRBd2M6jaqjyUXZoeaHgOz8CiW0mo05A/MoS88oKnJVJXntRks15ZFfTqGzq1wi3oKp0NEd/8f2
	0frOE=
X-Received: by 2002:a05:620a:4692:b0:7cd:43f5:8b27 with SMTP id af79cd13be357-7d229896812mr1581710785a.32.1749395173165;
        Sun, 08 Jun 2025 08:06:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0e/3eydri+PI3tWz3yWWM78Pu5wmvMpt57EqP3YQ+30eyMbjPkiS+v/audWIX2So6Pgfk4zp+ch993wnZlbQ=
X-Received: by 2002:a05:620a:4692:b0:7cd:43f5:8b27 with SMTP id
 af79cd13be357-7d229896812mr1581708585a.32.1749395172898; Sun, 08 Jun 2025
 08:06:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606190545.438240-1-slava@dubeyko.com>
In-Reply-To: <20250606190545.438240-1-slava@dubeyko.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Sun, 8 Jun 2025 18:06:02 +0300
X-Gm-Features: AX0GCFvLY3FJz9VLr5GAp5ze3kH5--skSoki5p1hsXZTfcG9gZVXZy6BN03XIyc
Message-ID: <CAO8a2Sga=KmyqSQFcwCoFXRjDx6ka8i-govhKfBxDSuqt+Qugg@mail.gmail.com>
Subject: Re: [PATCH] ceph: fix overflowed constant issue in ceph_do_objects_copy()
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com, 
	linux-fsdevel@vger.kernel.org, pdonnell@redhat.com, Slava.Dubeyko@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed by: Alex Markuze <amarkuze@redhat.com>

On Fri, Jun 6, 2025 at 10:05=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko.c=
om> wrote:
>
> From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
>
> The Coverity Scan service has detected overflowed constant
> issue in ceph_do_objects_copy() [1]. The CID 1624308
> defect contains explanation: "The overflowed value due to
> arithmetic on constants is too small or unexpectedly
> negative, causing incorrect computations. Expression bytes,
> which is equal to -95, where ret is known to be equal to -95,
> underflows the type that receives it, an unsigned integer
> 64 bits wide. In ceph_do_objects_copy: Integer overflow occurs
> in arithmetic on constant operands (CWE-190)".
>
> The patch changes the type of bytes variable from size_t
> to ssize_t with the goal of to be capable to receive
> negative values.
>
> [1] https://scan5.scan.coverity.com/#/project-view/64304/10063?selectedIs=
sue=3D1624308
>
> Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> ---
>  fs/ceph/file.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 851d70200c6b..e46ff9cb25c5 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -2883,7 +2883,7 @@ static ssize_t ceph_do_objects_copy(struct ceph_ino=
de_info *src_ci, u64 *src_off
>         struct ceph_object_id src_oid, dst_oid;
>         struct ceph_osd_client *osdc;
>         struct ceph_osd_request *req;
> -       size_t bytes =3D 0;
> +       ssize_t bytes =3D 0;
>         u64 src_objnum, src_objoff, dst_objnum, dst_objoff;
>         u32 src_objlen, dst_objlen;
>         u32 object_size =3D src_ci->i_layout.object_size;
> @@ -2933,7 +2933,7 @@ static ssize_t ceph_do_objects_copy(struct ceph_ino=
de_info *src_ci, u64 *src_off
>                                         "OSDs don't support copy-from2; d=
isabling copy offload\n");
>                         }
>                         doutc(cl, "returned %d\n", ret);
> -                       if (!bytes)
> +                       if (bytes <=3D 0)
>                                 bytes =3D ret;
>                         goto out;
>                 }
> --
> 2.49.0
>


