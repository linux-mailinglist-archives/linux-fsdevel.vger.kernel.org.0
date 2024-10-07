Return-Path: <linux-fsdevel+bounces-31214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF888993118
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 17:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B894B28112
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 15:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A93E1D88B8;
	Mon,  7 Oct 2024 15:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBCexcjl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0371D7E29;
	Mon,  7 Oct 2024 15:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728314789; cv=none; b=DhdnUsYoXYEVo4zjTgmzR8QUMyTjckzRFHrFSWL9gKAvgXMK9FN3urnv3OOjBj5ZQu6X05ZpsMQhd99tnjB79WMn1q4AJP5kCIC/y5WhoXH9vqsCc57dVKGFs+32MvniaCc/IjXSpoucfo+OtGGLpsAdRZQsj4x4lktdAbtWKOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728314789; c=relaxed/simple;
	bh=tqhQdLOOeOAK8WLwL/w8AuETdmPpVw9N31z87Qb2Yp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=chS6EkdPXSWHCxRcSOxg0Od/mBIpGjKPX2CMTfQoEV3NtPez7nHkW+IXis+QcPJt5iEY91JRLF8lvz0Q/4bDgJJUE+MZTpF8tbFZaSLvAYd/Mq8t/W8JPT/F3OJjTsOdeCmizu4AUGY6VhmH5MHbFsKDavehYBG+QNHVATzJA6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mBCexcjl; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7a9aa913442so419206985a.1;
        Mon, 07 Oct 2024 08:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728314787; x=1728919587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tqhQdLOOeOAK8WLwL/w8AuETdmPpVw9N31z87Qb2Yp8=;
        b=mBCexcjlCVos6eCZk0cP+yGr76FUUe/bm4YAd5i7n17TQwglCHeFNzn+HRsxtaSJ8J
         RN2yPSwSGQ2zTJDG4gdUQ1/LJ8ahuYtssO0HZKIxcIOumxhneKdBe3BTHOT7Ey9f82Qo
         jtMQ76bvBjMFWYUNR0GZldpBzRTq5zeWjwqCZ+P32JCVbyoY7U0hyFEWsoNS4belTYIb
         77lB43OLVduuOLlInsiNEP6iERMGSXojImiR5Yr9emOpBpLAn/a9FT2Lrr2+U7ECdKxU
         DzJhkPcLZCZmvFTFt0PDsDrYhxXxw8yNPcCzVHRvz9l3eMS8Z3iseMMOKuG1mUsLlkK0
         uR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728314787; x=1728919587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tqhQdLOOeOAK8WLwL/w8AuETdmPpVw9N31z87Qb2Yp8=;
        b=sZ2s8xZwVJob7Q+jPG2Gy807MenVwRFFZmkH/Uf4z7YrSXmlTppcPYSzd0sgHK/VAV
         by+EtqeOKcebofoF8EMhMNkIrJmCb3uQHW6CYSC9R+LKN4Yrl9aKOrier+/tlyCFQ5GK
         4brmJJPPHk24xE+PPupEEhw0wY/+o/bhIP3Lsh/xohQZE52QBjyuDknEdxSWHWwZnOE7
         UI61jC87KbfMrxZL+qSrsoFRqBEZ0nIRFCPEXoXScn8MNqRkm+nrPUSNrP9HwvMqFsDP
         7l//JXQ5XguMD0ktA425kCkNAlNX5A+PkDRXRdQjMyS1q/7SR5fkLLjfpnTj/7bvtL+m
         /R6g==
X-Forwarded-Encrypted: i=1; AJvYcCVu6iWJ7jCXpu6Z6kH1uuq9ifL7hYG8kxX40lsNKv54nb+IuxnJ+gvM7E2A4uizWrOY9fxMwwfdclXP5cUB@vger.kernel.org, AJvYcCXopNHyAgs8X1wfqQMl3cTNU0DJyInz6Qv1a5UryL19/U/vVdDNqou7KfNIN7C7CmvLx4sUHAmEiLIA@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu580nJD5p6jzzX8XiO13JaIFhoFsbJX4T3UZltEtxg8ODT0zS
	qfdpdEcDz5Ufy+WE5uv7sKM+7aGinHp1NZYJyXBqkGJ+Zyg3GiTkBrTACLvc/LI4yf55dHTp5El
	/3GocyESqcJe3hUV42u22cJoTmwQoZfwO
X-Google-Smtp-Source: AGHT+IEiLN0pTYpDRysfU8FdyPgnhtod8Dv1ghDYNdCO91VgYNpQ+apBOR5y+d3sYwd7sXNmcwnuXNHmFCifDYrSMgg=
X-Received: by 2002:a05:620a:d83:b0:7a8:325:5309 with SMTP id
 af79cd13be357-7ae6f421cdamr1877576385a.12.1728314787308; Mon, 07 Oct 2024
 08:26:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923082829.1910210-1-amir73il@gmail.com> <20240925-seeufer-atheismus-6f7e6ab4965f@brauner>
In-Reply-To: <20240925-seeufer-atheismus-6f7e6ab4965f@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 7 Oct 2024 17:26:15 +0200
Message-ID: <CAOQ4uxiBwtEs_weg67MHP4TOsXN7hVi0bDCUe_C7b2tHqohtAQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] API for exporting connectable file handles to userspace
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 11:14=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> > open_by_handle_at(2) does not have AT_ flags argument, but also, I find
> > it more useful API that encoding a connectable file handle can mandate
> > the resolving of a connected fd, without having to opt-in for a
> > connected fd independently.
>
> This seems the best option to me too if this api is to be added.

Thanks.

Jeff, Chuck,

Any thoughts on this?

Thanks,
Amir.

