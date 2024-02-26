Return-Path: <linux-fsdevel+bounces-12786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0657986727D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 12:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 990111F2F2FD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 11:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50B21DA53;
	Mon, 26 Feb 2024 11:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="NhlSJoG7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B891CFB6
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 11:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708945283; cv=none; b=byQ3ObwnV7/o5zVtF9KEL6idK2YmGH4tsQZUFcp8eq8KLroZ0L+UgbK2gdb+LEhEI/MHsfU3FbWsjN544yMsZjzC9Pz0rH1AFTQ4lOqsQBFk2xbjrKpgvC3nfo/zxP29yc/q+OPO6kKnp4b8aVlLsCMUTv5t2zcGqzIJ1s9L9Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708945283; c=relaxed/simple;
	bh=juxQVp3I/YjyYARAtGCN8X/19oTMac3vT+el0k1zlu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nFcKyIRKkdotiAKO6cMQnIEoFST2SCqg4PaLn1MqyWEUm8PgyZkYZ9S12297Xpt3eYPQVohwxGAl8KYk+uOJxg2QLvZ78ORPx7RGLydt8scylYkdRIN431S5diD7QTK4Sg46pGK2AsOEBSsZFc1CpXMvDG63bWMvftIrrGQsJ4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=NhlSJoG7; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a43488745bcso119864066b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 03:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1708945279; x=1709550079; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=atstUUlrLgN4yEFx8AxqTmKurc2j6JQEEGnl6tIdudM=;
        b=NhlSJoG79kZxTNqwc29mqmpmHIVQaBp0yymv5D1K5QuPa97iwGhGNQKc6EYLrjfdpN
         fuY6l/wPPN3D3F/RkPJiSBH4imVd0ISBdWiVQaj8Npnbk0DbCh+G1NdnIEsLRbpqgrCy
         QKDyps1GHACRJhdol3f+kG11M37okkuQDbVJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708945279; x=1709550079;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=atstUUlrLgN4yEFx8AxqTmKurc2j6JQEEGnl6tIdudM=;
        b=by1OIxNqMvUnUS/jq+nJoLSmaR8KXjLE2lP4wfKr0iz02clbhbiVVdA/BlFK39aHoW
         NjJY1LDpzFMO4D8dqnIPbXC03amA+9JoXD7yHK10hGqo1ivEoCxNL7g3/neGvfVBgzQW
         KxPzkcoteQUHe8br5efCH0nK9+skEVtl8ZN+EcFnh7Kg1rbUwdcfLmP6HvgnFRvWTpC8
         MYVHXzo4FVVVx/PCgQ+PUK6CIbInudVw/AihcjZ0LVJlZcP3csKD9eVLJzjGsgjbqep7
         QI5ho8ACa/WIWRvXwkT6fCvE5wVs7fhSyntfrH60mqB1NgvZO2b7uinfKEd5qSbClx+R
         6JCA==
X-Forwarded-Encrypted: i=1; AJvYcCUtMg7DTuWz8bBaE+Bht028xg41kHOLvEEJLt6Bkohm0DlslJ3l8AcABQqlauXFhu7xlXAcbT+RagHChSRXASbUCpjZjp/2uMlLZpvB4A==
X-Gm-Message-State: AOJu0YzJCWAVZyjM/AUyHX2qxTsCpPaYJA00FBauoiSSzPc6/M/reR+v
	f8TVIPRHycKZ2WwtfJ0DIMx1deBJ7EMPwOMdYIMLkRtwufCs+XyDt4FRHbZ0HSSxqeQL+4s7fR/
	Dj0IJWaDN9J9E4M++ByLzvlcScQ15tj1WhI3xVg==
X-Google-Smtp-Source: AGHT+IHMsjBbafkh6QL3dPH4Ad4HwgAUJtI9jWeU/cH6WDQzC7JP1FUcGOG9KpmIzU1vGmBATdAMeS6QuLd3vOjO3R4=
X-Received: by 2002:a17:906:5297:b0:a3f:14f5:2f87 with SMTP id
 c23-20020a170906529700b00a3f14f52f87mr4558182ejm.42.1708945278859; Mon, 26
 Feb 2024 03:01:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105152129.196824-1-aleksandr.mikhalitsyn@canonical.com> <20240105152129.196824-3-aleksandr.mikhalitsyn@canonical.com>
In-Reply-To: <20240105152129.196824-3-aleksandr.mikhalitsyn@canonical.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 26 Feb 2024 12:01:07 +0100
Message-ID: <CAJfpegsttFdeZnahAFQS=jG_uaw6XMHFfw7WKgAhujLaNszcsw@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] fuse: use GFP_KERNEL_ACCOUNT for allocations in fuse_dev_alloc
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: mszeredi@redhat.com, Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Jan 2024 at 16:21, Alexander Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:
>
> fuse_dev_alloc() is called from the process context and it makes
> sense to properly account allocated memory to the kmemcg as these
> allocations are for long living objects.

Are the rules about when to use __GFP_ACCOUNT and when not documented somewhere?

I notice that most filesystem objects are allocated with
__GFP_ACCOUNT, but struct super_block isn't.  Is there a reason for
that?

Thanks,
Miklos

