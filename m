Return-Path: <linux-fsdevel+bounces-9670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDD484435A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 16:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69A3828872C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 15:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4E112AAE1;
	Wed, 31 Jan 2024 15:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIfIe8IH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12046129A90;
	Wed, 31 Jan 2024 15:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706716067; cv=none; b=hOx1pRuRpEBDeiphdr1RYxbxOa1QVUVvCjxrZ6XSCv8EanrQTcGC7q5SqU5akrNYmxuYgxX9cewXpuQ/PEgSeHYic47bPn+XGdGeFb6NupykYoDRwU8tJj2sUr4e+5xXElEb+LOweLh/fKPBVP9/XUe9P+txoxE5U4b06jIa3KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706716067; c=relaxed/simple;
	bh=kcvtLaH8tgDWu8daM4FrjIXLhnfcpyDWdLSIcNR9BMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YmsRFeKA2DwL/LOJ89nDPbRj1Gdxr9nBhSrS+iH6/l90Aw4e9hZo+em7BpsjyNX35t1nvOJQjNmUYROooGpembhe1auxOG9+W6vmopp3kjg4fq0t8TT7TdddQempoNPz9fl5epAvHY+E6CJWXjkk/hDBusoNbixjE0JWA7hwhP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CIfIe8IH; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-68c41c070efso6975916d6.0;
        Wed, 31 Jan 2024 07:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706716065; x=1707320865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcvtLaH8tgDWu8daM4FrjIXLhnfcpyDWdLSIcNR9BMI=;
        b=CIfIe8IHwfQrbWtmAN535k+JCR6rVp+V7gZqIGEKE0Z7lHxrsy3mNrVJirum+BVSlB
         H6hin6y8hGoaldmynJL56gJztdb1qZG1kwPv6bNtzuuBdzxx8iggtP0oJq14dJCv9lw2
         fjqnc6CVcOjHJO7VJs551DIDC2UNnFQnK3UmpiUIFeu5+RqaBlo8fx0Nuw+qutAxxxq3
         80/CDIV8dox+xSN4tVeSEG0/PjcTpbvc3sm+XRxtiYlsfWiABj5ET4SJ1YICD7DIOA9C
         +tj8eKwMmtUrVkTExNIAUbwXymKPIEgVVgme4KmW/gnFC6keirqxHqHfBpa6A6wKpscZ
         Oebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706716065; x=1707320865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kcvtLaH8tgDWu8daM4FrjIXLhnfcpyDWdLSIcNR9BMI=;
        b=BiFrOMBClAP5JubdJKwbScYMXhHTGFTcsUKltKccdMHvz9/B5gB5oIfLMq6Pa5gSbK
         ofMXcZ+i9CqZsPN8AolX49ilrI4Iw6FfltAneoOlrWRgmOAgNFDBipY8Oi1stdkmN+2T
         ht0pS0PI5I80rKv84TQHhLJYPTymCPE1fYeG/WecqsO3wxHK3V6oWhq2OPo2pjsJjoAD
         HvdSTOPRYwNA/aymfyqUSpkBmS228sqLPKVsX5rn6qUDkvYsoHLy/AnFED0sH6XcdTz8
         GSno8uM9NHI5T5gq3iIOKnSW+Eq6JlwlZ0Sa1AdjCfTtYvuNJt9SZ3C0t7ysug9qGgWQ
         iY8g==
X-Gm-Message-State: AOJu0YxwswrdvUl96MnCsO4J0CD9yzhDZYoLJksQAuHHDGEJXSFBHkWL
	Sddt4MFFwt2716b503nmAMH4JaVCXy3znNg7Hb1TCQ6hlz0gd4dfNIit1JRL8lmG3p/ONXioCf9
	2PMMzmnA8jFiMGN7/x9D433ZyNV0=
X-Google-Smtp-Source: AGHT+IHQqAgRfXqPSmq7iWifa1xzg0IGtYsDAfOxUUbc14RP6DBVnAdj5gYQaGlZTXyn6lwVnaxg1nJlxJqTr4b244A=
X-Received: by 2002:a05:6214:226e:b0:682:bfd0:d79e with SMTP id
 gs14-20020a056214226e00b00682bfd0d79emr2330095qvb.27.1706716064959; Wed, 31
 Jan 2024 07:47:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202401312229.eddeb9a6-oliver.sang@intel.com>
In-Reply-To: <202401312229.eddeb9a6-oliver.sang@intel.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 31 Jan 2024 17:47:33 +0200
Message-ID: <CAOQ4uxiwCGxBBbz3Edsu-aeJbNzh5b-+gvTHwtBFnCvbto2v-g@mail.gmail.com>
Subject: Re: [linus:master] [remap_range] dfad37051a: stress-ng.file-ioctl.ops_per_sec
 -11.2% regression
To: kenel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 4:13=E2=80=AFPM kenel test robot <oliver.sang@intel=
.com> wrote:
>
>
>
> Hello,
>
> kernel test robot noticed a -11.2% regression of stress-ng.file-ioctl.ops=
_per_sec on:
>
>
> commit: dfad37051ade6ac0d404ef4913f3bd01954ee51c ("remap_range: move perm=
ission hooks out of do_clone_file_range()")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>

Can you please try this fix:

 7d4213664bda remap_range: move sanity checks out of do_clone_file_range()

from:

https://github.com/amir73il/linux ovl-fixes

Thanks,
Amir.

