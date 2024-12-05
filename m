Return-Path: <linux-fsdevel+bounces-36534-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF04A9E5720
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 14:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EDD12870A2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 13:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA935219A92;
	Thu,  5 Dec 2024 13:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4uRJxMz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BB6217F36
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Dec 2024 13:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733405320; cv=none; b=R4l/OjGJCUYYJNJHG+xrvJ7bG3bxrTIFGGqCVyJQ6JeLyhgz10kckvu6IySZ5tDUvW+ApDdSDcGF9K13x/vJ00i/ZLv1EgqXrHrDuN0dz4uXcAnrZqcFXwPIdwdAKFwgR3NVZHcmMB7bkC2D831bVG/QvFE5bN9XyyDhdftcE2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733405320; c=relaxed/simple;
	bh=OAdmKoE7OClq85YvTdKv3yrfsYTy8qOyw/wp/PvRk2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=av/+JrJlgyl0J7PslHb6OJxn+w0zUw8NFq5pU26Y5OVxZTz7SZCJmVtAyzJ61+ChoZQzUXlSLiHhwU/6bogAlaDxxIA0Aue8IQRPj2LNFJ0GeON5lSdQF37MJrRxkRI/h91kkxJt/0l2/YmGbCSZDMherlE0EoMwWRF3ReRr34A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4uRJxMz; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa62f5cbcffso52476066b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Dec 2024 05:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733405317; x=1734010117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OAdmKoE7OClq85YvTdKv3yrfsYTy8qOyw/wp/PvRk2s=;
        b=F4uRJxMzSjEKCz+DUvlRJhMGyFpOzjMGsdEXeAEjdP4GrX1lA0rK9pABh90LrnfaCD
         UGppY3q1D5q913d5jHT8HVncisKuUUjkiCUI61YSJTiFo+a3Yo0CnqBQADJVifHDky7Y
         7i+CnpWZaxfL7+GnSJEJy6BqJidP4I4AmINWH03HCgoTKRMQpWO2xp5QyZct7hprjxWF
         td5vWifgnuX1BVqSExBGMHSM7NmQeqtbQ2LmHqc5dsu2h95cY5b8g7O8ueMNKTfZgafN
         DEkujv8ZxNCLsmJnSoA+T1DLJC7+6fCmHAjsCRKkzt0bO67oKLwlL1hpMtAbXMCdOZ6n
         nUcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733405317; x=1734010117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OAdmKoE7OClq85YvTdKv3yrfsYTy8qOyw/wp/PvRk2s=;
        b=pTsSnsXX/WjhCpgOD9lc5nS3seRfJ6R5aQ/M+JyOM5ACQvtZ9uazRUOqXNCqu6L46J
         fBXbtYAD8Bhctuxbj+QcgRd4ftR5qSGIXq4wVoag8cCsBYbWbfSUN+lqpMmQpWIsGdGZ
         b3RgrE3AdfCTzM4iHCEOKf+Pr68IreH26U+YuJBPzXr88ft1xJrsBTI9ke8eY5ksZYUm
         qWj8sLMBUaaz6CQIg2/IwAZsul/muwzGDT7phh0H5+4Z4MmrqZ1NFCHLyE8O4nwPXfFV
         rmez1i93JZhvZpY7kRuOsbp0QYkGXOwzQy1xzxWxpcOJEsrpr3PI1B7wBl4YzVSj62nx
         SxXw==
X-Forwarded-Encrypted: i=1; AJvYcCXoY3UbIsaZ6JzeihIk/ILWcpKjsn3PaeswC5Ta+9BSbihU/AjspAXo/NuI2uZxzmVbEDxw7uVsKo2xjRlt@vger.kernel.org
X-Gm-Message-State: AOJu0YzV+hyPQ6+3q3ELj8cVc8fTjkNOqt31BBvBN3u/GvY0HEtaxtgw
	qs2JlWstu93iGL490ZzJLaupRwFnuBGounPyLbvfhmrMAbb+XAiLVf/9h/eOEVz7JQjjr0IcN0g
	LdCcuRqmrifmAmgUw/bzdWkFcfbU=
X-Gm-Gg: ASbGncsZz/pNNAZXWd4/n9xlDk+/0gv4vRNaVVpMU7DwozlUz+sqgi1KRa/A2brC0SJ
	CuksLlqe3H0/gmC1DubkmTVa7pCL0afM=
X-Google-Smtp-Source: AGHT+IFQtnckRIaoRN79JsA2kgYyftNjiNxDtFVTes/oFbOO/3ussEhO0LHH61DTA0KQCnNA5EJee0o5CpteG4sU+MU=
X-Received: by 2002:a17:906:3cb2:b0:aa5:3663:64c5 with SMTP id
 a640c23a62f3a-aa62196c3abmr290397266b.22.1733405316412; Thu, 05 Dec 2024
 05:28:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128142532.465176-1-amir73il@gmail.com> <20241205125543.gxqjzyeakwbugqwk@quack3>
In-Reply-To: <20241205125543.gxqjzyeakwbugqwk@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 5 Dec 2024 14:28:25 +0100
Message-ID: <CAOQ4uxjyFOy0JCPJ2y4Sm-goRK9xtf_6jkWEEq_vzxPO-FmnCA@mail.gmail.com>
Subject: Re: [PATCH] fs: don't block write during exec on pre-content watched files
To: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 1:55=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 28-11-24 15:25:32, Amir Goldstein wrote:
> > Commit 2a010c412853 ("fs: don't block i_writecount during exec") remove=
d
> > the legacy behavior of getting ETXTBSY on attempt to open and executabl=
e
> > file for write while it is being executed.
> >
> > This commit was reverted because an application that depends on this
> > legacy behavior was broken by the change.
> >
> > We need to allow HSM writing into executable files while executed to
> > fill their content on-the-fly.
> >
> > To that end, disable the ETXTBSY legacy behavior for files that are
> > watched by pre-content events.
> >
> > This change is not expected to cause regressions with existing systems
> > which do not have any pre-content event listeners.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> OK, I've picked up the patch to fsnotify_hsm branch with Christian's ack
> and updated comments from Amir. Still waiting for Josef to give this a
> final testing from their side but I've pulled the branch into for_next so
> that it gets some exposure in linux-next as well.

Cool. I just pushed a test to my LTP fan_hsm branch for ETXTBSY.

It checks for the expected ETXTBSY with yes or no pre-content watchers,
but it checks failure to execute a file open for write, not actually to ope=
n
a file for write in the context of PRE_ACCESS event during execution.

So yeh, a test of the actual use case of large lazy populated
executables from Josef
is required, but at least we have basic sanity test coverage and now we wil=
l get
some extra linux-next testing coverage which is great.

Thanks,
Amir.

