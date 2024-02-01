Return-Path: <linux-fsdevel+bounces-9887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 559F0845BEA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 16:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04F8828D7FB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 15:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48833626AB;
	Thu,  1 Feb 2024 15:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="gcXOC10l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83932779EA
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Feb 2024 15:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706802196; cv=none; b=ax14kDsxX423n+5OagdSgMxyEnbq0RPPqwvrZ0tqh8Qz32NjYgXq2xhq2iRR66wo0i01L0aYlZa8NHD2nSx5JV1sC06gTuez4tdtljVadIJvPMCquNnYLu4ZrmnMydBwK9/iHfECvr+VWFJNxy9KNHd2JQYk04OH250jUhSfMWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706802196; c=relaxed/simple;
	bh=8+AqaIy9vK/jNBj8xSs/oJ0l081+bdXmDPl28bX2Yy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PmygSy3iivTIVNVil8t2ge0PKclHIlIrXGq4zd/s5YuQ4jt7i1B6G1WMcfDlORQUItpaTu9N6o0wmzbMUdoHRvEhzFN+aovkPnUjVFn8PA1GR9FkfKy3CAjaIIJHuZhoNT4+Bk3/Uu8/1lclsBIsCZkpRtxTBbOrDamzQvFJn1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=gcXOC10l; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-558f523c072so1558708a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Feb 2024 07:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1706802192; x=1707406992; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L7mxG5IbjMC8PfU8BAsgLKCRzohxErocVqm70LhKOYA=;
        b=gcXOC10lDpTs/IAAZLb4it2pRK4IFC5aXOtHy6VU5184kctXTlSznn4le7LNR0ZYAN
         eYwm9NEl6rYXK3CK6/E6QwDWuUmOeX6DoF4SF6PzWgwH2lHQMZ3Cnn0OJWv8BYah9YnJ
         TbDBkoB6myEUK1/CnrmpevRUtgIDi7bd8nj/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706802192; x=1707406992;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L7mxG5IbjMC8PfU8BAsgLKCRzohxErocVqm70LhKOYA=;
        b=bY4Irx2PKLibKOq/nX6aTJQzaqti8ZAxDcLtsaNXnHyTBF6NvRd003rNrPrpR/V1C5
         LBEY/tc4ctMV2ywESfXUOHi0QbTMS+LpnJWpBeFCMqEFnFLJ9xBzGX2uwylQQvCOhxd+
         Gbw6unw4PE20GpGxRKuW7h4+8YJILptx4mcBTk+ssQbBI1aPO9ErHGIENu3XqaC0ijCg
         voin3C5hN/a67pDGoPZ1/5G04Ha0SKKNXjfl7dcVjnK7++gLOdPTPEzFYnI6Y/AAuG0b
         4syRWnULSN8HHnJsJqZyvamGKGNYC0Wqsgpm1pxcHVAPwPY4zTH08xdJ4DcA4VK36CWH
         JKXw==
X-Gm-Message-State: AOJu0YzPaISAkpsXeP+sTMEVisNaOdUmIdCU2Ke3gp/xxyJa6Z+eyyns
	KARzcTuKj78ZIySb8kkDIu2VhK5P4pc0jNkhM8TCSjoMt6Ic+/lHy2WvhfLtcOLrdXIL5UJMAMO
	br4tGTFBT2A9cwscPtGeoNwAvdvVYuA8YR1nwUQ==
X-Google-Smtp-Source: AGHT+IGhTGLVHGSEya/v/5yYkwEmrSaSSd2HGxKNTWfJ7jHwT3dNDlM1L5VQ0CW36tS9DBg353WP9OyI6N+mibKwVb4=
X-Received: by 2002:a17:906:3c18:b0:a35:822f:f676 with SMTP id
 h24-20020a1709063c1800b00a35822ff676mr4093761ejg.39.1706802192743; Thu, 01
 Feb 2024 07:43:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131230827.207552-1-bschubert@ddn.com> <20240131230827.207552-2-bschubert@ddn.com>
 <CAJfpegsU25pNx9KA0+9HiVLzd2NeSLvzfbXjcFNxT9gpfogjjg@mail.gmail.com>
 <0d74c391-895c-4481-8f95-8411c706be83@fastmail.fm> <CAJfpegvRcpJCqMXpqdW5FtAtgO0_YTgbEkYYRHwSfH+7MxpmJA@mail.gmail.com>
 <95baad1f-c4d3-4c7c-a842-2b51e7351ca1@ddn.com>
In-Reply-To: <95baad1f-c4d3-4c7c-a842-2b51e7351ca1@ddn.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 1 Feb 2024 16:43:00 +0100
Message-ID: <CAJfpegtd1WehXkvLWfbBvFLVYO2nBgWSoq=3Zp-Kmr0spus4zQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] fuse: Fix VM_MAYSHARE and direct_io_allow_mmap
To: Bernd Schubert <bschubert@ddn.com>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Dharmendra Singh <dsingh@ddn.com>, 
	Hao Xu <howeyxu@tencent.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 Feb 2024 at 16:40, Bernd Schubert <bschubert@ddn.com> wrote:

> Given
> -N numops: total # operations to do (default infinity)
>
> How long do you think I should run it? Maybe something like 3 hours
> (--duration=$(3 * 60 * 60))?

I used -N1000000.  If there were any issues they usually triggered much earlier.

Thanks,
Miklos

