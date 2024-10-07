Return-Path: <linux-fsdevel+bounces-31163-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 090BE992A19
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 13:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBB61283223
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 11:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985FC199948;
	Mon,  7 Oct 2024 11:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="QgAwakk7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670E318BBB2
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Oct 2024 11:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728299770; cv=none; b=Jm3ql5E+ZsRVxoiaugHEG4mqv3HIl1DEHYMeqk2PA3a7V+6wNlW9ZJff6dFcymm1jzO2L3RN8A2tO6izpnH6nM1ozFTzo41lITKgqnTFsr4pLAOJ4L1qg2UUFc/+lgtwJL1mbl6NIBqCvWQESurfQTO+5LHwWSxV0lkwrI+aOyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728299770; c=relaxed/simple;
	bh=E8fRdAlJgiJme94BbN4pIOluZYOFhIbAZOVzz3VquwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HWNsbsqOQVJax7u0zZmb/a2Vp3gUrejS4nAAG+OxASgEYYnW6PxiT6hFlTfsMOoGcXOkCb+Op1jqUm0SZ+2pkSpTD1YSZwfQQkTwT883TRonMOhBZLpaO3a15hs7jORYvqroW+esCM5ZqQ4s1fM+dOjDlIY0dMGQ906Zv4phmso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=QgAwakk7; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a99415adecaso253513066b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Oct 2024 04:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1728299767; x=1728904567; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W0HQTGv3eqxjC2PrnLBuK91AoOyVLLFoAbV8Ry+Sw1Y=;
        b=QgAwakk7w9OSw2cpgW/mC9UMVyLlfVY/XZvbF+Sca4C0yh823AeXz0/RzE+7/5qaxG
         YWKIda/B9s2rck1dMByFxM3V/qLTqQpvCYRBLW4s7E8fTSEmbhI/zFJOKhcU8vZeKWrb
         YqTU6j+9AW73O4k8bn+/L2fBcnml9LT46Yj60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728299767; x=1728904567;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W0HQTGv3eqxjC2PrnLBuK91AoOyVLLFoAbV8Ry+Sw1Y=;
        b=pq/0SfXM/JdR5BB+ZwSbEHgqGE3bEsQCu0Ro/g8F8TyeNHU1IxevPzskR7WnDLbsdn
         cJK+Jo5ON8u8Qks8x207YgOO+g+5ajuLCWyIrUEEcyrh1LPgB8IF6ubOaWYMtkvV2a4p
         YlzF5Vu01KHnRM7WeWn5wmmDgwqE2aAgM+b7EZuqQ6VDKNH93u4Ili/b+ISDt+J2h6oH
         lUQorUA75EgQQ5WY0mVtUXtE32yceMRh4s5S4q9qPTHDcooiY9jkCPKwiRDMMWIeIqOw
         Lf25YgCpgd5L3eqyH7H0ImZO6sp6rmvx8+ebgIIpfydlQBmnX+xhrDOd3NHjFC6DceaZ
         Gu9g==
X-Forwarded-Encrypted: i=1; AJvYcCX1DGKnkqdfkZb3cyRVvMVyDgIzqc4Q5fPfU8H1R42Mh2yDwRBCRlrY+HlXUrU0QpqekAh76mm2HVcMGrg4@vger.kernel.org
X-Gm-Message-State: AOJu0YxQmJcA3Wmmww9sgW3BlprcsuquU4XRvuOGsgQTdigX/Eb71+YB
	CZteOTuZ8K9KAZwo+bKALf4gLiT8A0tHEpzMSXPyFcott1JjXeutuhRTSBa68og+74KB238gU55
	nhgYJOfkXEAyHo2Xu952hO1AuLIqfz9UdmDZdzw==
X-Google-Smtp-Source: AGHT+IFeWJONUHm3u6eVtymxYPEbVewyVDCoMmV+T2ZsewlRtBCaQBcWI5MoI2zkwzEl0J0t6OaEfsaXLMg4yr6DmUQ=
X-Received: by 2002:a17:906:ee82:b0:a8d:2281:94d9 with SMTP id
 a640c23a62f3a-a990a21d61emr1808778466b.23.1728299766818; Mon, 07 Oct 2024
 04:16:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241006082359.263755-1-amir73il@gmail.com> <CAJfpegsrwq8GCACdqCG3jx5zBVWC4DRp4+uvQjYAsttr5SuqQw@mail.gmail.com>
 <CAOQ4uxjxLRuVEXhY1z_7x-u=Yui4sC8m0NU83e0dLggRLSXHRA@mail.gmail.com>
 <CAJfpegvbAsRu-ncwZcr-FTpst4Qq_ygrp3L7T5X4a2YiODZ4yg@mail.gmail.com> <CAOQ4uxi0LKDi0VaYzDq0ja-Qn0D=Zg_wxraqnVomat29Z1QVuw@mail.gmail.com>
In-Reply-To: <CAOQ4uxi0LKDi0VaYzDq0ja-Qn0D=Zg_wxraqnVomat29Z1QVuw@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 7 Oct 2024 13:15:54 +0200
Message-ID: <CAJfpegtdL0R9BgbdMP7YzEVD0ZdWV=71cWSZtkCFhhOjXWOzrg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Stash overlay real upper file in backing_file
To: Amir Goldstein <amir73il@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Oct 2024 at 13:02, Amir Goldstein <amir73il@gmail.com> wrote:

> What I see after my patch is that ->private_data points to a singly
> linked list of length 1 to 2 of backing files.

Well, yeah.

Still, it's adding (arguably minimal) data and code to backing_file,
that is overlay specific.   If you show how this is relevant to fuse's
use of backing files, then that's a much stronger argument in favor.

> Well, this is not any worth that current ->private_data, but I could
> also make it, if you like it better:
>
>  struct backing_file {
>         struct file file;
>         struct path user_path;
> +       struct file *next;
>  };
>
> +struct file **backing_file_private_ptr(struct file *f)
> +{
> +       return &backing_file(f)->next;
> +}
> +EXPORT_SYMBOL_GPL(backing_file_next_ptr);

Yeah, that would solve type safety, but would make the infrastructure
less generic.

> Again, I am not terribly opposed to allocating struct ovl_file as we do
> with directory - it is certainly more straight forward to read, so that
> is a good enough argument in itself, and "personal dislike" is also a fair
> argument, just arguing for the sake of argument so you understand my POV.

I think readability is more important here than savings on memory or CPU.

Thanks,
Miklos

