Return-Path: <linux-fsdevel+bounces-48491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A4BAAFF77
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 17:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 517C04A43D6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 15:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D74277006;
	Thu,  8 May 2025 15:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="q+E5/ezQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA242AE90
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 May 2025 15:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746719174; cv=none; b=g/ARcyrJyNSFYRULgxyvc7hfC/lgc8kYvNe5FQzcvZedm+6QlWgYHemtR2FeZlkjHIE3BAPUNHJlVbFUC4ubbUO836u0Ez1UT2eNGgGlPWjw95RVlSnRz7cwFvy1yQGAl30VCr9Mlwh6dJLnqzLK1NgXwsYW+gN65AeFr+PiqIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746719174; c=relaxed/simple;
	bh=AOp8ylAkNhWCjih+a4NJkT0aYorRQxCtdcajsiB/sxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pI6C6wHOyqlk+Tq2Lo3NSv1O40wsE0gXrZMWpKRlROEGfLaat/uFkxaoKlBHkG2OWDdEvS3IQUvpIc147rQ4eY2XV1DW6reZUdwl3FXtla1FZT/lxcw4TEW9ubr6Pi5dgKN46m6N+qvUx5dUJ7tojaaymb6XpC7rPpjpW3U7+7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=q+E5/ezQ; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-476a720e806so11074511cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 May 2025 08:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1746719170; x=1747323970; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ydwNYg0e9GXLbqx9lyShlZjlrvmX+J/qPZb/UZNzj8M=;
        b=q+E5/ezQ9viw4Jkq9NEBMLMwCuWP4bs1ln9LhOXGmZxXf3j9kLhEISNJUMmYW9KRsN
         GGkK6SMwdZd8o04PPjDTIrpE4wn4w0ZQYzx14ZlIECwnTkwg7ilY9x5ZOGOV0k9XcBkA
         bzlpJ5gdc5LEpPoO9D9HOPuQ7On53IWuQ4FbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746719170; x=1747323970;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ydwNYg0e9GXLbqx9lyShlZjlrvmX+J/qPZb/UZNzj8M=;
        b=rJTxk9V/bAD1zg1es7GkmlTKDt7QMTBs1cq4st/Upm49B+7FUmmak8i++qhZ1kYHQD
         oF3R02rY8STzdlX+AZrfvD7BwKPTgfMEuoyWUdz4geCSojbK8V3rje6GHHrf+XXGAEGM
         7JUUUprXd/9DLY0tydZYQ4GW41N7qRAE3lgtIh2qYNLNbsx6TnNUBUFYWUeTqmkVuMWA
         yZH2DaE6FHaTzpKkMKQD5rQCCVEb0fYDhmCWb4jMW80C72EP/h3LUU0oF+FoRcIpQzVN
         M79h5dlCmvJXq2V59X+j8cSFtWSnkQrRWs7TPxw6/I2zGhJYNlmpBTQO1UXGj2AfTqNF
         pAPg==
X-Gm-Message-State: AOJu0YzsQ/cqKvBrPCGho8n/54tUH3KlNl3cLFqb0LM3hRFhtkvtjwIJ
	lzk/rTBCqTRJu7R0hf0z6zga6R5VeOkjJgYCqeho4A2Iy27b4k12ZO0VsTL0RlrUgkNzGgm/8et
	LWI5xww30hjIh8IqNIbmh85wnRq68v1qqBnoL8A==
X-Gm-Gg: ASbGncsMDMJhoK+av8aZQo6Dz78j5N26hEp6bVtBQ24tATq5U0/5gu0YOuDb80PALkC
	OGjaenLEbEIR/7hht9fuPyD/C2A6bEBdnnmTGYZlK0xcf0bHXjaYi09j/igIzZw6pPPbdewdSrr
	suwjx0MgJto7ClA0o1nQinFshMMCAabrjqBfE=
X-Google-Smtp-Source: AGHT+IEVudiPQXHhYjx9aZ02OKglZ19CfAPzD2MAfz8k+gzTUNbbGCFE2Efbj64jpAb2ZjqUPUqh+xdChx2RZIiaSDk=
X-Received: by 2002:ac8:5a85:0:b0:48c:5c4d:68e7 with SMTP id
 d75a77b69052e-4922574d6a9mr115292411cf.6.1746719169928; Thu, 08 May 2025
 08:46:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegs+czRD1=s+o5yNoOp13xH+utQ8jQkJ9ec5283MNT_xmg@mail.gmail.com>
 <20250420044905.GR2023217@ZenIV>
In-Reply-To: <20250420044905.GR2023217@ZenIV>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 8 May 2025 17:45:59 +0200
X-Gm-Features: ATxdqUFFi2DT428ShRFkLRCWR0_ruu40A1_-aRcxPnVDCHwMdgljXW_S2t-L1Ls
Message-ID: <CAJfpegu+rP=ErU6ahjF-kd81=T7wgsk6n7tRXkYK2_UtPqQcrg@mail.gmail.com>
Subject: Re: bad things when too many negative dentries in a directory
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>, Ian Kent <raven@themaw.net>
Content-Type: text/plain; charset="UTF-8"

On Sun, 20 Apr 2025 at 06:49, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Fri, Apr 11, 2025 at 11:40:28AM +0200, Miklos Szeredi wrote:
>
> > Except for shrink_dcache_parent() I don't see any uses.  And it's also
> > a question whether shrinking negative dentries is useful or not.
>
> One-word answer: umount.

shink_dcache_sb() should work fine in that situation.

The only thing it can't do is hunt down spurious references to
dentries, but that's a debug thing and not something that is needed in
production.

Am I missing something?

Thanks,
Miklos

