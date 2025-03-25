Return-Path: <linux-fsdevel+bounces-45018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 619E0A702A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 14:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EC50167991
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 13:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60371C7015;
	Tue, 25 Mar 2025 13:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J18zWqva"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9995B1DB13E
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Mar 2025 13:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742910245; cv=none; b=Ftq58tGasWLy2hejqfE5rSA1ITNddMRg19JBzCIJLcxCLg+Pdoa4rBz0//ojCKjCgfmm53pnJdmmywuADJpc85h7I3Tq6yngcNRectQv84aJanPkL1BcmOgWz876T1MTOu+SJYUN1vEYV10U7z5cVQ9TxRaEuWYQsJwZGrQvwqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742910245; c=relaxed/simple;
	bh=8KIudKE6VvJiOdj4gr0OO++CrR3zbC/m+Ov/oFgj6E4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ujNowA9/e45UJiln7Dp37GV3GhbS1eQb+jSllwrsippIfMZADipHGxuhfi6QNsMP9+H996NXX5JseoZLr3XUKwRT/Y5WV++De7NqSgEcHTFnKmka7vRSPeGnN3qiIo7pKCCywPcIRUMQcHsLCuYml/Xs+JdEwGvWRXZ8LsbLDSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J18zWqva; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742910242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yWXvvnLse6UgXyUHy/THOGh38nsz/8p45DMcYfJmDXk=;
	b=J18zWqvaexRNOK/DWnPsrFUcvAIZXXrJHgQtFzm7F9OQ5Xaxlxchs7brtiuoQXiWdlhDqk
	6egkVBYM7ouA4zTkIOXxGhiHb4Z4CL6DASUqYOtNnIR9q849SzIqOaYwWJJwgyufmIF0S5
	xq262hze2P6B+kOfmBaHwlWQ8PrA0eY=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-g663jI9YN5mWncyYMroNfQ-1; Tue, 25 Mar 2025 09:44:00 -0400
X-MC-Unique: g663jI9YN5mWncyYMroNfQ-1
X-Mimecast-MFC-AGG-ID: g663jI9YN5mWncyYMroNfQ_1742910239
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-54994e431dcso2576185e87.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Mar 2025 06:44:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742910239; x=1743515039;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yWXvvnLse6UgXyUHy/THOGh38nsz/8p45DMcYfJmDXk=;
        b=CHf9K2pbGVIlALxsxyIjGh2EOP/hoIxeO9SoLsEF28QolsD4h9SHwBWIVxg03bULPG
         /g1ldQS8kyv5rViJRgkPI7QyS0+OOI1T3rwwjFD0RBQnEjcPH7TPoOafywMDXhoyA+2Q
         otva1XSnEZlIPwl24+UUWBwzQbXVOGaBgBUpLdBtUeMt/nI0a6mL5gexzg/vdBxHHPb3
         VJ5Pj75D+1OVEDuh1etGUc/sr+RZXeGp/l95fpSpCEiTVxmi/7b0V4aJEyomm7FpTvYT
         30F053Ykq97Zq0ELYwQKdCHJ86x3uggovdM7y4lKsvwaPRjMaQiBoSobAwSYNfYAx6/r
         Spzg==
X-Forwarded-Encrypted: i=1; AJvYcCWX8Pb9Dy6LmbSRCeDpwZDiuCb5wcuMTrwhV2ifC1rg2sHHmmYdEVHl//qxrk1iWAFYORcV6fddeYfWfMye@vger.kernel.org
X-Gm-Message-State: AOJu0YzfvoafAq2kAFIK+bwD7dyWI7Zt4NlX0wYTydCXLaRZnwMRxt1/
	dMOraM+U29Inl2JzG2PGEFpUsv+D+L7AmFZc9fa0QOTTAhltwAmgQYshLoQbM4kH84oYtkA70+L
	wZD/zGOJIqKR8qvxqka+Twf3QYiitZ0Rf+cOgeS1Xrio/Gq0pRQeQ5Tp9L+FjGus=
X-Gm-Gg: ASbGncuIWTSbvrxjH3bPaeM+iQQeYlhhikoZPi7WB8OMFR5rl2grM47wlaVY72wSHDj
	upSgtjLLaL/iw4VVM1TmtixdtOKMzo3sDbN/uJFQxFH3x4Y5ZkRNn/0Duok18ZgKaP+BeQJh7cW
	Sajxj5RM62O8Mx2vICaJg3CCKe87eUqmJKX4myMyanGIa/GKDN7efXe6keIPl3SnWTWK7oZMWqG
	n682H7mtc6TRPtfczCHO557uwCIna0KW0uj/qcNlRP8c1DvvXVgG+CQs3V00qTgjRfrpwBePGdP
	37C3a8snNWC3YUdvER/4hDuYHDMXWjcycEKpqaifN9BJ6FvhdCydVzg=
X-Received: by 2002:a05:6512:3f03:b0:549:6759:3982 with SMTP id 2adb3069b0e04-54ad64ef448mr6076307e87.37.1742910239217;
        Tue, 25 Mar 2025 06:43:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9q18eFyCOaGJ1t+z+GBKHu2RJGbCAkZIR6NhUEbbmrOsCPJ1/37sK95DPBH7K037653cJ4Q==
X-Received: by 2002:a05:6512:3f03:b0:549:6759:3982 with SMTP id 2adb3069b0e04-54ad64ef448mr6076299e87.37.1742910238760;
        Tue, 25 Mar 2025 06:43:58 -0700 (PDT)
Received: from [192.168.68.107] (c-85-226-167-233.bbcust.telenor.se. [85.226.167.233])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad6509736sm1514107e87.200.2025.03.25.06.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 06:43:57 -0700 (PDT)
Message-ID: <dc1cb5bd875491060a4f1eb1dae42865b95ae4df.camel@redhat.com>
Subject: Re: [PATCH v2 2/5] ovl: remove unused forward declaration
From: Alexander Larsson <alexl@redhat.com>
To: Miklos Szeredi <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org
Cc: Giuseppe Scrivano <gscrivan@redhat.com>, Amir Goldstein
 <amir73il@gmail.com>, 	linux-fsdevel@vger.kernel.org
Date: Tue, 25 Mar 2025 14:43:55 +0100
In-Reply-To: <20250325104634.162496-3-mszeredi@redhat.com>
References: <20250325104634.162496-1-mszeredi@redhat.com>
	 <20250325104634.162496-3-mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-03-25 at 11:46 +0100, Miklos Szeredi wrote:
> From: Giuseppe Scrivano <gscrivan@redhat.com>
>=20
> The ovl_get_verity_xattr() function was never added, only its
> declaration.
>=20
> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
> Fixes: 184996e92e86 ("ovl: Validate verity xattr when resolving
> lowerdata")
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

Reviewed-by: Alexander Larsson <alexl@redhat.com>

> =C2=A01 file changed, 2 deletions(-)
>=20
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index 0021e2025020..be86d2ed71d6 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -540,8 +540,6 @@ int ovl_set_metacopy_xattr(struct ovl_fs *ofs,
> struct dentry *d,
> =C2=A0bool ovl_is_metacopy_dentry(struct dentry *dentry);
> =C2=A0char *ovl_get_redirect_xattr(struct ovl_fs *ofs, const struct path
> *path, int padding);
> =C2=A0int ovl_ensure_verity_loaded(struct path *path);
> -int ovl_get_verity_xattr(struct ovl_fs *ofs, const struct path
> *path,
> -			 u8 *digest_buf, int *buf_length);
> =C2=A0int ovl_validate_verity(struct ovl_fs *ofs,
> =C2=A0			struct path *metapath,
> =C2=A0			struct path *datapath);

--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
=3D-=3D-=3D
 Alexander Larsson                                            Red Hat,
Inc=20
       alexl@redhat.com            alexander.larsson@gmail.com=20
He's a deeply religious vegetarian gentleman spy in drag. She's a=20
pregnant renegade politician on the trail of a serial killer. They
fight=20
crime!=20


