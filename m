Return-Path: <linux-fsdevel+bounces-15930-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD17895D90
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 22:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80BA31C22487
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 20:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54A515DBAE;
	Tue,  2 Apr 2024 20:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BSBlM3Qu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CA015D5CF
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Apr 2024 20:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712089640; cv=none; b=dA+of7sjpfrSWG9dy4fbE1SL0YivSHP2FYlQaU8BwNiGLjGY8E5FZh8E2I2ursgUk5p+Ux8ohJ97lrmsICsp7mawCDBvCgLAD8rsK7bXI1qyfSI3E30wDhO8zIhaPbeUmQ8UBjJLrm6VHOUhfuP64ztnePLw83aVVhgyrJh0J5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712089640; c=relaxed/simple;
	bh=s6ky1gVPxytbtkTyPWNowNTIcdWeLLjvFA3xBxpvjnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RFpfy3awt93VLSjD1fRJLHxd2HU7/VltTecm60dIy4GOM6fmcQrz88a/TrcRrSXdCY6owqDO9zHEkRfXRlFJXZMh3jY3p0czVGoh9j/49oDxWFyKpGw6fdQAx4qIeV2TZeYnTOlsn1H0TMey4NmZS2bIGu0Gd0FdPpaKsSxRlQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BSBlM3Qu; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-615053a5252so2695337b3.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Apr 2024 13:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1712089637; x=1712694437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sSKiNbrhkKPwkZGF1F1PMoUwyozDNbCp+fEhHpe15Ak=;
        b=BSBlM3QuaBcafX5e48Xt6lIy+/8kIFhLNsYzsZxBvg40IQQhItenVsiv84y8nZ6/ho
         a062AwsawfBwmkVfUMsVYUPS2doKAZLrRrB8z66OwCP3C9EicpKubUF5urtcXWfl7JBL
         9KR5NTtNSQKnAyGWoZt+pRlCoZPf4v7aUKL+1fWz1RrlZs+CQ+2D3rNtD2IC4DqGAtMr
         Em4tK161TgVH/WQZbRoq98k6MhYyXpDxG+GNfqEtJ6MlFwJUkwXWo4FpRp3IOQdMnfqN
         fS2CyRXOPbqX1mJw8xkdFL2/+3TwQ4MmJlZiXulnCdthOj+Jyjjep8UaCa8fEBtDRofn
         eyuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712089637; x=1712694437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sSKiNbrhkKPwkZGF1F1PMoUwyozDNbCp+fEhHpe15Ak=;
        b=BQwVwXVr/m7W437r08qXIy1czucJX+KGm6bYTXhcQWxU3gcqkXGbqP6HyU79mgXjac
         4bxgxI7rHsvwD6J9By8PNaCPfcBk7QKmAtqOZ9zb2v8L0H+0llBCufOgsjRGXXWRgCE9
         4jDois3jvMsR0bV1/IwcycIWnm/WJe8Ffy/evRUVnaJXyBOk0DwI2V2ZBlUDMw61P5ni
         GEMqHINk8ECfn4GjIjteXxQiXN05Qfkr25nVlzKP+fzDq+ySlE3G7Et/WOpKH1w2nE2N
         e6Z8C1yqIV3rAVJfpTW28ncpjVdNnnHeNlNVSqwkWzIC5/TaI3WZNgMyNIWK/sIDouSS
         HIWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkMmAt47xwnQ/4R3TQjTtO4wu7MraiiIOyEH6GvTNXOdet+DxTx/x0Bq/ve6vUJIydL2VKjWaYzAzjfjshdUpk9DXXLkUePGfFNWBEjQ==
X-Gm-Message-State: AOJu0Yw38TV6eRXpifw4g4JebAQbZsSUVP+WtQU7N7L5IWK2Z9telBxG
	bF42vyw9FoqJPc8JPhopmL68SAuk1ZNFXGxm0mAg495aIRo8tU+4qUoPG5oAIKlXMh4U4nZr1V1
	0cRU5zc8Hm93iWjuwHKfQEwr4Lw/S3WxD+hZ9
X-Google-Smtp-Source: AGHT+IG4IkbsE1gFNrj4qmWdvNUvjoza1Bpfb/hZWbk/SPHjZQl2nsTjX9zNjnk0qbmPSNWMHPo5652tpRBGw5tN7M0=
X-Received: by 2002:a81:9115:0:b0:615:2022:24d5 with SMTP id
 i21-20020a819115000000b00615202224d5mr547613ywg.2.1712089637626; Tue, 02 Apr
 2024 13:27:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402141145.2685631-1-roberto.sassu@huaweicloud.com> <CAHk-=wgepVMJCYj9s7J50_Tpb5BWq9buBoF0J5HAa1xjet6B8A@mail.gmail.com>
In-Reply-To: <CAHk-=wgepVMJCYj9s7J50_Tpb5BWq9buBoF0J5HAa1xjet6B8A@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 2 Apr 2024 16:27:06 -0400
Message-ID: <CAHC9VhTt71JUeef5W8LCASKoH8DvstJr+kEZn2wqOaBGSiiprw@mail.gmail.com>
Subject: Re: [GIT PULL] security changes for v6.9-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 3:39=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>

...

> But if we really want to do this ("if mknod creates a positive dentry,
> I won't see it in lookup, so I want to appraise it now"), then we
> should just deal with this in the generic layer with some hack like
> this:
>
>   --- a/security/security.c
>   +++ b/security/security.c
>   @@ -1801,7 +1801,8 @@ EXPORT_SYMBOL(security_path_mknod);
>     */
>    void security_path_post_mknod(struct mnt_idmap *idmap, struct dentry *=
dentry)
>    {
>   -     if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
>   +     struct inode *inode =3D d_backing_inode(dentry);
>   +     if (unlikely(!inode || IS_PRIVATE(inode)))
>                 return;
>         call_void_hook(path_post_mknod, idmap, dentry);
>    }

Other than your snippet wrapping both the inode/NULL and
inode/IS_PRIVATE checks with an unlikely(), that's what Roberto
submitted (his patch only wrapped the inode/IS_PRIVATE with unlikely).

--=20
paul-moore.com

