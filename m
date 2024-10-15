Return-Path: <linux-fsdevel+bounces-32029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C99A099F6AC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 21:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66E221F24CB7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 19:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8EE31FC7E6;
	Tue, 15 Oct 2024 18:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alEJFlDf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E295B1F5848;
	Tue, 15 Oct 2024 18:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729018659; cv=none; b=Qd2234+YzexFNMB+rt3CodBhbYSmx8CB0yKmjVE88SOm33U7svbaX/OKNhtKmXTQlC+xCi4ejwllSN7JCBgWGYXmrMGSMo+7XWObJFZz2NJ54SzUyA5MX0z5PMZ3oU23DCjVs9qFXdFVyTHCakUGdoArvjl3/dz8Ab+MzeKyJ1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729018659; c=relaxed/simple;
	bh=GokVpolgtgsMr74kYooLRDx5SNt1tvUbUlK3NlYMJkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F8q+REInNYfFVXYQ9vafdaNOuBObJDtYuPTcjs2ALJ7WgXSk+9yCIkC6PRGZPcGCVq4EMN+UOyGSpbDxM/H8HaWzKll1LE4lHqPdan7XP+W9mwDejatvZTAmkvtjW0Vxv25EU7Q5Lq/z9I7hlN5oZsqr3DgbaIERwRPAlfzcq8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=alEJFlDf; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-50d479aef64so780222e0c.0;
        Tue, 15 Oct 2024 11:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729018657; x=1729623457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thgX4UfZksBLSVw+VeRAPPbcUE7nq++tjS96X+94e2c=;
        b=alEJFlDfld6zD88CtvhVaQoK8sK3soHWAfRlsoeRcZcb6dKWknJMk4kVBw9cRx/hoa
         ZnFBTGADNSCq2TpDTqC8mka3uYISjdmqIMRORSemiFRgI72zwO/k29YL2tSV5U5NFIZn
         ZYPYtPwiOTy2znyS4tWr+nnL2Phaeus4YIHHEyOMLr8chQG3tSOK+4+lmw95uBSg2xH2
         yXi3Jx83evfFyzYchwRRlqcel0QbnDUC/KzfKIG64s+09xWArfNzzFYgGHOJLrS5yz73
         xHZMH0x5+qYnlPtuDJ0vQTJci5OvYNIhq1DDBMDkEd42NVUKOQJKlsDXORQ/SGBbm2NC
         7uPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729018657; x=1729623457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=thgX4UfZksBLSVw+VeRAPPbcUE7nq++tjS96X+94e2c=;
        b=n7hk1s6YAklXuvEPpsF5B3nbTBn6KHIxwWeeiWiLV0XOOjMkcNGh65L8lwcPW9v1ZF
         tCP8my2vtGV1Lc84hMiUryfEb93vLAsOu/mguRVZzrN3cZazp2DE+lM/ts4EG85B2MUt
         pFzg1IYnUPbv1Ez3atSLvatjxoSnvJ5wN94MAk2j2bvFsObVE+CoV4GaDC9iCunvKQQE
         fODMMMfJ5mbgSI24QTZ2DVQaCnPNxiQzfqzrfrVlSo2NCm4r7wwn/Jy8/bEd1OjuyY/l
         n8LaPch5c1VWZsX4rilMZgnnrE08gqlu3aaK2mgKXUWKu0qs7JdGcVpUOj7ZyWuKrXgp
         zLqQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3eoZUpkuKwZDEh/gKViHexdqCa9gGtdoPNek3Pj/M9DxBsIEHn7DlaXcu0pO5hzNsku6VdVYu2enLeEXk@vger.kernel.org, AJvYcCUBbBLpEAvV9275bTmSzmbceQdbP8E6uBAunguwZ+uF2wvcxICn/2PZqYmshDv8oH6v5WUT8VcOpzxlHk1Fzw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwoOGaERFtC7llawBNZKdMxOmIO2sEFhED3s6gOuUiSri/JOuFc
	Fh4taQyrP9Eg6hX5V8bxeN/dwxmDF/PbNZL2PN1V2+scKcz6scITCdSbAs291hsMkJdcPeqfpMM
	r/Z+tC8XTOa3+w5jgBpsCsHvwA4U=
X-Google-Smtp-Source: AGHT+IGZYFd73dYBq23JFDtKhoTV4EpTEOO6U84cj3oC1qrtsjd2dZ3J+pgA0q/iEFs45j6PweFmZBKAwtlxU4X2TkY=
X-Received: by 2002:a05:6122:378d:b0:50d:5ca8:77 with SMTP id
 71dfb90a1353d-50d5ca80fa7mr5830942e0c.0.1729018656652; Tue, 15 Oct 2024
 11:57:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015133141.70632-1-mszeredi@redhat.com> <CAOQ4uxh-3H4QkTEihujFgz53ajeArWH9u_yj4kaWByVJAGmgrw@mail.gmail.com>
 <CAJfpegsfMf_On1qAmv1Qeud2MkFJcL1Q0Kk_i58h7YcOoVbpgw@mail.gmail.com>
In-Reply-To: <CAJfpegsfMf_On1qAmv1Qeud2MkFJcL1Q0Kk_i58h7YcOoVbpgw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 15 Oct 2024 20:57:24 +0200
Message-ID: <CAOQ4uxi_ir+KdiAHhLC6_J617KJQo9Ve2rscQXJ1ws6EVg43cQ@mail.gmail.com>
Subject: Re: [RFC PATCH] backing-file: clean up the API
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 5:49=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Tue, 15 Oct 2024 at 17:32, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > If this cleanup is acceptable then perhaps squash it with the above com=
mit?
>
> I didn't want to do that, because for the backport your version is the
> simplest and easiest to review.
>
> > This seems wrong to me, that the callback gets an iocb
> > that was not initialized by the caller of backing_file_*().
>
> That's only true for backing_file_splice_write().   Would passing an
> iocb into that function fix your concern?
>

I suppose that would be better, only then passing iocb and a separate
ppos would be weird, or did you have something else in mind?

But I think that if we aim for a cleaner interface then the arguments of
backing_file_splice_{read,write}() should be similar and so should the
arguments of ->{end_write,access}(), so we should change
->access(file *) to ->end_read(iocb *)

This way we could call fuse_read_update_size() or something
from ->end_read() if we wanted to.

Thanks,
Amir.

