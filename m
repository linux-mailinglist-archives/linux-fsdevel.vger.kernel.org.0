Return-Path: <linux-fsdevel+bounces-32466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A909A65B3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 13:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5F46B2EA4D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 10:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095711EE036;
	Mon, 21 Oct 2024 10:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="hInj7tL3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB901E6325
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2024 10:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729507466; cv=none; b=Tih94yhYyeydMXrMXgN/inNT5IfxsOoRTHyaUObTVPfFUTszABa2aw9+hICAXLts0CeN3b8i3PP6oU3zxaET7kduyIIt4ozczcAMFtJIgxb/rKlfs6wXHD3RucSvBDa+ZdpphmwvN3QP8PS/JNO117t4YRCrKfskrA8FttmkhRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729507466; c=relaxed/simple;
	bh=H2b5ATnt5E1Bo99qJUPFpUnk+M1Jkx9D2jNgd7IjZq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=czrlQEIWC1/zwlC+B71DYw+LcfoRZlh9ItEvh1MfP2Lkm/OI69mPvBKccSP051TqVgdmIsvNZ2Vo540wYUUWZxuOzDd+FU+JhgBGNtFwb4uwTr3TIg8tfpKzpySm0BDXH68hBNmCLRbOO7z5G5KigRtsb2EGTkMWoUbD1OtNd+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=hInj7tL3; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e292926104bso3676401276.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2024 03:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1729507463; x=1730112263; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vs3ZdfEcKn0zVCu2kMdMdXvQgCQLkEnwi8nZT4fN4jU=;
        b=hInj7tL3sbvSYbaqfa+woB+0wOehgZ3iIBiPQnzI+A9J8yxd56/WGDPc1f24IJmgGG
         Wt+SK6p2HTk/5nVEJj7v+pqeY6ZySHj89yRBLOnmP7rm39skuDD5vU1lclwEHPIwOwfK
         pL38N5GPaLZqdG50ilz+muaGfLYU+TxhoLs8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729507463; x=1730112263;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vs3ZdfEcKn0zVCu2kMdMdXvQgCQLkEnwi8nZT4fN4jU=;
        b=NEZRreid+Eyq+/kt4YyxDa0oEPYgZ/4dQBwd5LvFG4mRbrpMg7ftzdyta8Nlte1/R6
         +etydUCyVL14G0GDYC2QCbNCJu6GEp/0hoeSs7NuxISVz4bZU/UP41uC9I24q7v2FQVB
         6E5rbWfozfEPEswerb3ara2mTfekHRN/wsJ3BQKjkH90sOKkOK311uvUKa+p6X2m86++
         Av4v3ji7+udaIZ9GPFFHQLJ1huoc+Rioz6U7mXgoku1ohbf3wj48F1J1ULDUd9TLJj5p
         eoGjnqIKLAOnFYasPcjkStPHW53QMqZVnVWyBfPSHDlN3f5caeHjchEqSoR+6G5uDIkF
         LHUg==
X-Forwarded-Encrypted: i=1; AJvYcCVkcMh3D6OxuAHiNC8sQ1r/BsbPEEt8rZZRPwdM6FTce+BQJWwFeJIFF1FsJjNDteA4ZJ/UBq9MCpbRnBX5@vger.kernel.org
X-Gm-Message-State: AOJu0YycHH9DF165kOiVg711jz1f9Tpa9m3PYBFixb/Tt/qk8wxEO+R0
	abj/v5zAGSRwCQUU9hd6siN/CzEuqhGcWvXEVmQwi8N0+6y9wnjA4tZyBXACtBY0pIPpGQ3qTCv
	+6qbNnuc0vfw8QCoodaU8y/JsSaOdW7ByYvkZtw==
X-Google-Smtp-Source: AGHT+IE5yZTlevVj1gZ0L4e8USuUUJStmlno7fmxxSe+Cq60ncfQcAuXIHI98/H4B2hU2sPtzF8Qa3zYhBs6Q0vxqhU=
X-Received: by 2002:a05:6902:2848:b0:e22:65ee:9a17 with SMTP id
 3f1490d57ef6-e2bb168d098mr9421782276.44.1729507463548; Mon, 21 Oct 2024
 03:44:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015133141.70632-1-mszeredi@redhat.com> <CAOQ4uxh-3H4QkTEihujFgz53ajeArWH9u_yj4kaWByVJAGmgrw@mail.gmail.com>
 <CAJfpegsfMf_On1qAmv1Qeud2MkFJcL1Q0Kk_i58h7YcOoVbpgw@mail.gmail.com> <CAOQ4uxi_ir+KdiAHhLC6_J617KJQo9Ve2rscQXJ1ws6EVg43cQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxi_ir+KdiAHhLC6_J617KJQo9Ve2rscQXJ1ws6EVg43cQ@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 21 Oct 2024 12:44:13 +0200
Message-ID: <CAJfpeguaf99y1QdvXzNXuxJJAw_UaMrpYoXrB=ZuSb8+EAf9Og@mail.gmail.com>
Subject: Re: [RFC PATCH] backing-file: clean up the API
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Oct 2024 at 20:57, Amir Goldstein <amir73il@gmail.com> wrote:

> But I think that if we aim for a cleaner interface then the arguments of
> backing_file_splice_{read,write}() should be similar and so should the
> arguments of ->{end_write,access}(), so we should change
> ->access(file *) to ->end_read(iocb *)

Changing ->access() to iocb would mean having to manufature an iocb
for mmap(), which would be unnatural.   So I didn't touch that.

Thanks,
Miklos

