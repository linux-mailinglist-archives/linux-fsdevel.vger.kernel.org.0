Return-Path: <linux-fsdevel+bounces-16798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7367E8A2E64
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 14:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13BBF1F23304
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 12:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671845915C;
	Fri, 12 Apr 2024 12:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="I2cTeQU7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA8358231
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Apr 2024 12:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712925395; cv=none; b=Z6YS9xMDjynOoXw0CFTKmMYvn4tJ8anRVY4TSTeUfwdbOrtZ/TXff4e1BRWpEj3hrILZ1q9r8cYDyIb+nv4vnF+jidJvAyVoPzKnvPnUWaa451gKvqzvA0hkXha3HhPzeSrY+linh3KEel/XVUfNwmn3iBoeeAtf0mPyB/fjKos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712925395; c=relaxed/simple;
	bh=q/zq68O6+sSBrl97NyQg0CjTsV0FrQQrptYSnKIK5qA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aYyum+uvQcBL+wXjBN9ZtacA87jXYDEwKDDX1znM3MJzSSs8i0ktM/2+uJdp2nobXmEm9bhuY80OXlzOkpJb9rJ+nXG6oLKtoKL3wPig1eym29aSWz45fLP/TPJ8ftvgqjfgmJHR6b26RY/KBWU5v9G0jQf9hdjg2oPrk7AJfb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=I2cTeQU7; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56fd7df9ea9so1002739a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Apr 2024 05:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1712925392; x=1713530192; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q9BoxTR1JROCUR8SnlVHtABNOhFI4wAk1SS2lfIXdDc=;
        b=I2cTeQU7a/6nht7u7IlFLRW8F3L9jO5d/Bl4jCCshuKL+u57vSgP/Zp2EOz5JH2LUw
         VqWgpOJR3euy+da4CXbTUaWGX3f5IDN3HCtPBZmyANHYpqymjtb1mELL/fxCq/czYe4l
         J3XfyR6j8PigD24xvPiQFbHh2gmrSC+kBtBJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712925392; x=1713530192;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q9BoxTR1JROCUR8SnlVHtABNOhFI4wAk1SS2lfIXdDc=;
        b=DsujEt0dldEMHR2JbvSrI+tssd1U8fTkUIH3F0BUSwiEov4P12PpgMRg8/YlPUv51c
         L4hrrFpLNbNXVXVObvLHJ9eoTTBwxEbZakiSmWJRsWntxeC8yPJMZhXanG7vshOkDImd
         FN26NeDM+JpN9XU+cXdmrih04ExlZqyy6hSUeEQpL84CU+h6MftDKrunlD/+au5U8wOZ
         iG/96Hv0wPHKJSKnvVj93X/Wh7Rx3VCkLRyS+B9OzWAtdwu6RaGD/YBU05WIrdog/UDy
         pKCSMyUGCU6jCEweorsRbpO0MEBahJr/rPrem1x5hmGNYuwdcgyAb2PovS7WqSSJ2bsW
         K0qQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxnBtBdfvJ1tR/IqojOQQ+TkYBM46aEhkN7MQ3dmfWMasa436EbuKzKJ6Y5j5y6iOLZmbBg/EHG6dh4Gd0x0Ta7t6h4AXzN1h76Hbzpw==
X-Gm-Message-State: AOJu0Yww1o0hsWNb2J4bqrpnC/02AKZfD1yYF3FrCBxVnN0uXUjCrMXX
	pozC1tlzTifIyCGqBIY7fvedC0nE3OcDH7CFouE7EaPjGIlr2yAGTH2+DSIpVJMUoB0sO0oBenV
	RfwGxX4yvESihcvqUkgwM2Cq0GWbjN8BnKx+7YQ==
X-Google-Smtp-Source: AGHT+IF0OXEoT3ZY3zlYrIJBP9t60HKo5W88sTuoOTax+N/wQVoD3KFVgeyr2E2zTF30Vq1n1+Eqqz1nG3Ytmq9tODw=
X-Received: by 2002:a17:907:94c1:b0:a51:e5c7:55b7 with SMTP id
 dn1-20020a17090794c100b00a51e5c755b7mr1811230ejc.47.1712925392535; Fri, 12
 Apr 2024 05:36:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403021808.309900-1-vinicius.gomes@intel.com>
In-Reply-To: <20240403021808.309900-1-vinicius.gomes@intel.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 12 Apr 2024 14:36:21 +0200
Message-ID: <CAJfpeguqW4mPE9UyLmccisTex_gmwq6p9_6_EfVm-1oh6CrEBA@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] overlayfs: Optimize override/revert creds
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: brauner@kernel.org, amir73il@gmail.com, hu1.chen@intel.com, 
	malini.bhandaru@intel.com, tim.c.chen@intel.com, mikko.ylinen@intel.com, 
	lizhen.you@intel.com, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Apr 2024 at 04:18, Vinicius Costa Gomes
<vinicius.gomes@intel.com> wrote:

>  - in ovl_rename() I had to manually call the "light" the overrides,
>    both using the guard() macro or using the non-light version causes
>    the workload to crash the kernel. I still have to investigate why
>    this is happening. Hints are appreciated.

Don't know.  Well, there's nesting (in ovl_nlink_end()) but I don't
see why that should be an issue.

I see why Amir suggested moving away from scoped guards, but that also
introduces the possibility of subtle bugs if we don't audit every one
of those sites carefully...

Maybe patchset should be restructured to first do the
override_creds_light() conversion without guards, and then move over
to guards.   Or the other way round, I don't have a preference.  But
mixing these two independent changes doesn't sound like a great idea
in any case.

Thanks,
Miklos

