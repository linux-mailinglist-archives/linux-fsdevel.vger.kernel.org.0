Return-Path: <linux-fsdevel+bounces-19997-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E98748CC035
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 13:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A26151F2187D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 11:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E072F8287E;
	Wed, 22 May 2024 11:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="eN/G7J8C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB9E824BC
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2024 11:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716377337; cv=none; b=UxIbqLtnzfd9Gikok0fuJfHdy4i1jqHOXdxKnLLcC/GPZq0RBdptAuMQJEBjuI4UXsBx7ZnaYCi+UDDfWRScDc+KtlVe96zr847DJXPJ5gMEzKkyvvnuLjHM/idCfWGlj0fGqswkD8LF9sflFZrXKjCOM3UW8IFPQfBGLAyNOEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716377337; c=relaxed/simple;
	bh=3bJdJ8HW1Na5LLk+AGH4z17x+8X++BBtE11tCH2eQoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y0vSd0rrHsoMypJuPQozIHIestbcST8i92/gDOX359TKgoaCwPLeHGJi7c9bqmQrHr19niQC2hN76A1AGWHf98HLyoQLFxQ4/dh9n/utPC+ue7BrCez2hMnXM0efE/9Je6BYfGs2qwbyC2M/tY6vB8qe/KZEmNrcDxCs/TyxBfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=eN/G7J8C; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a59e4136010so1028739666b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2024 04:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1716377334; x=1716982134; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KNstTbNFBCd+HhKurLCnuPWR0z0UVPvAuThP/LhWOd0=;
        b=eN/G7J8C84raWniw310y1EpLoZrKwLRk8mgg2G7az7jscCt1S0EKldbn0KOnIM0Wig
         FckEbk4wH6bxTI7stUKHNpy1VZ90169MBrB3fc/d0orV8/chSi6s1MkQCehitRS8qO95
         M49TXOAMAZwn+PCAl7RfhPgx4AH39pdgIndIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716377334; x=1716982134;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KNstTbNFBCd+HhKurLCnuPWR0z0UVPvAuThP/LhWOd0=;
        b=YEm6ETgVvE8mYGQYUsEIHxyvt7z3WqM+dimgoA06qXY62i/ylxMuAQ1/ecl0bFaAci
         Gfa31fz2K3q5YQHLD5EaW/5WY/wFqMUqDGMjSzjNxZD1fYogt3QrhticzFq76DmPHgaj
         HeRhLyvYMt+hTKyzrV4Ij0wwtmUmDwJiqKew7BPj7dgv55YYONHI5rhWpOBaCK+x4svJ
         nYVU0gKJ0+EL7VJH8bNIDo0A3c85imDsDOwBFDn5R9gjOgkHhYBxc23qx/+sfSwZQQDs
         9k1yTqqogJ+s4fie0h/c4f1wHqmTwBh5FSgG0nuBiELQjKx8dYnihFaS+k/PG1TfGGoQ
         oaLA==
X-Forwarded-Encrypted: i=1; AJvYcCVSttpm0M80dXrJLI9QXgps6MhoHhy0AK3IwwFhOXAZIu5Sefntz7P8OzprPbtYZIfkHL9XqZZuGRwKUza/4TubM0QMw946ZYIbALdB0Q==
X-Gm-Message-State: AOJu0YwrHCoO98uLuq6lTY/aBfJwfR9irdtF6cKI2Ea1twEjDjTVMWP4
	JSeqqb1/F8GpeDEelS0vCy2U5gD1EJ54nV0p3bi9fKlBTQ6Q7MTpnnPjzlNPAeSnAwk+6eUt73u
	577CT7QdWzJfbm7O2J7pWf03nPPiEwB3lYhpfDw==
X-Google-Smtp-Source: AGHT+IE5WaF87K/wVsaT0a6gSy0rGBzZLsdh108SeEf5aQ3zolCWJBW1NV7c9ET+Od7JRp7Fevvf53iJJIu4qKo7s5M=
X-Received: by 2002:a17:906:1589:b0:a59:c52b:993c with SMTP id
 a640c23a62f3a-a62281fc3b7mr84214066b.77.1716377334095; Wed, 22 May 2024
 04:28:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1708709155.git.john@groves.net> <CAOQ4uxiPc5ciD_zm3jp5sVQaP4ndb40mApw5hx2DL+8BZNd==A@mail.gmail.com>
 <CAJfpegv8XzFvty_x00UehUQxw9ai8BytvGNXE8SL03zfsTN6ag@mail.gmail.com>
 <CAOQ4uxg9WyQ_Ayh7Za_PJ2u_h-ncVUafm5NZqT_dt4oHBMkFQg@mail.gmail.com>
 <kejfka5wyedm76eofoziluzl7pq3prys2utvespsiqzs3uxgom@66z2vs4pe22v>
 <CAJfpegvQefgKOKMWC8qGTDAY=qRmxPvWkg2QKzNUiag1+q5L+Q@mail.gmail.com> <CAOQ4uxiY-qHSssaX82_LmFdjp5=mqgAhGgbkjAPSXcZ+yRecKw@mail.gmail.com>
In-Reply-To: <CAOQ4uxiY-qHSssaX82_LmFdjp5=mqgAhGgbkjAPSXcZ+yRecKw@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 22 May 2024 13:28:42 +0200
Message-ID: <CAJfpegvAuPtKzR1A4GdaZTB_EDqPu53wUf97D1QOUo9VKkTV9Q@mail.gmail.com>
Subject: Re: [RFC PATCH 00/20] Introduce the famfs shared-memory file system
To: Amir Goldstein <amir73il@gmail.com>
Cc: John Groves <John@groves.net>, John Groves <jgroves@micron.com>, 
	Jonathan Corbet <corbet@lwn.net>, Dan Williams <dan.j.williams@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Matthew Wilcox <willy@infradead.org>, linux-cxl@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, john@jagalactic.com, 
	Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@infradead.org>, dave.hansen@linux.intel.com, 
	gregory.price@memverge.com, Vivek Goyal <vgoyal@redhat.com>, 
	Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 May 2024 at 12:16, Amir Goldstein <amir73il@gmail.com> wrote:

> The first open would cache the extent list in fuse_inode and
> second open would verify that the extent list matches.
>
> Last file close could clean the cache extent list or not - that
> is an API decision.

Well, current API clears the mapping, and I would treat the fi->fb as
a just a special case of the extent list.  So by default I'd keep this
behavior, but perhaps it would make sense to optionally allow the
mapping to remain after the last close.  For now this is probably not
relevant...

Thanks,
Miklos

