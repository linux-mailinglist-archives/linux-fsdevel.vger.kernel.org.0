Return-Path: <linux-fsdevel+bounces-32086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5B99A0655
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 12:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55416B224DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 10:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1AE1D0E08;
	Wed, 16 Oct 2024 10:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="cQS6sFHB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64EF18DF8E
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2024 10:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729072819; cv=none; b=kS/LoYioNhfZUyKeD3yL5NuWU4mA974pTpnNf9fA1Ck0zwhDAmhWR0C0NUWhxektf4iTB8FFYneRBtok/4zU7k/V41v7uiF2jlwLdnbZh3pPMcFYXTGTMQ6omFb49r5/5HaOG2Epm4V5CfUlK5JpeC/CMG9S7pYtrtWcYHFJLQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729072819; c=relaxed/simple;
	bh=dMrxfUN1wiuwiZ/jvCOYBYcOHUp5WB6FdI4oxksq5NQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VyVhD8lvkjxLRMo3XxcIrLmYmoSElgNYDhlEpEYUnTOX+UciExY7GpDjzkk3rRSUGgVDajsjhcIDkpAAN9L/xq+4iF0aoHOatyn8NEjkcecSezSeezNewSR4Avp7dAKEEvOgCerpVG9tko/zH/F8yl+PjlzOYiLoAO6JcM7aEb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=cQS6sFHB; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a99f1fd20c4so624428966b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2024 03:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1729072815; x=1729677615; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dMrxfUN1wiuwiZ/jvCOYBYcOHUp5WB6FdI4oxksq5NQ=;
        b=cQS6sFHBFZnzvs4AcGzuJGDIbrSdb/gc8vHGYDNsODj8f44/EIlPtDG9aC/imNbYRy
         vSb/GcrebD+bzpmvY34v2Hamdgmpjfsowdvl04NC4DHoYOIcwNlBymtMeY8XFEYl+wfy
         94A3RDufRUrYgD+CqLghkTVhojRBajeORybfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729072815; x=1729677615;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dMrxfUN1wiuwiZ/jvCOYBYcOHUp5WB6FdI4oxksq5NQ=;
        b=f2zIY6Z2mDZ2m5Gnm+8eW1NSizkoIqCLEA/A2PU11Vza53InzcxXoCN2lGmnF62kdM
         TdB4rmPyO0zoWjd+CoOetZzvWph+zbCbTa8pP9W++nF/AoNIL19/DA7cKT149lMnEtu5
         P02cRGVrLYfbgNFe+qxvlc+8ErUI29uy7T2nYXvBuYfj2DZ5eTpK9hN8z6zRpwiAw3zS
         t/7DdvrkHf7aBmLO663HwlsueRV1KAhpIetl+UIiB+1ZdXKWVs31ZM+lduaDLcpPTja8
         LrH2TUD4K7lW/KUwILn+l70Gb0pnlbM+LLyMgrdpAWqfvoTE/qOOJAJ984y7JrNhhN/A
         bhxw==
X-Forwarded-Encrypted: i=1; AJvYcCWBIMrOe/uCmPV9O4aHkDLvqW0Jwl79yLZWvNzBE+KwMSNfQdUyDhOQ/8OKeOEUHQHLQ06VdV2XAXq6btGC@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe3B23pac8Q2gmH66hseHQu9FCvIHkGusGPW7mLdoloXx6vYCY
	Wa7LpIkxElfvtJ/AkV8+BIMX+Ah/dIZkbWxTPAM70ZLl5rX1c0CZikbZg0z0kWArwdTFEOj3/Ku
	JbNPuXjuIoXycJjSjg/33fAxYyzKRGO662motuQ==
X-Google-Smtp-Source: AGHT+IGiBY+oilwRoHS2y4kYN7KUdr/0cvRISz2mg3pcgLWzMiF2f+87GXeMxuVqiTfz1s8e0sgvPCPlyf77r1HBqlY=
X-Received: by 2002:a17:906:dc8f:b0:a99:5cd5:5b9c with SMTP id
 a640c23a62f3a-a99f55087bfmr1200057466b.36.1729072815294; Wed, 16 Oct 2024
 03:00:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014182228.1941246-1-joannelkoong@gmail.com>
 <20241014182228.1941246-3-joannelkoong@gmail.com> <CAJfpegs+txwBQsJf8GhiKoG3VxLH+y9jh8+1YHQds11m=0U7Xw@mail.gmail.com>
 <02544610-05e4-49b3-a477-3ee35c0701ed@linux.alibaba.com>
In-Reply-To: <02544610-05e4-49b3-a477-3ee35c0701ed@linux.alibaba.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 16 Oct 2024 12:00:04 +0200
Message-ID: <CAJfpegsJKD4YT5R5qfXXE=hyqKvhpTRbD4m1wsYNbGB6k4rC2A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fuse: remove tmp folio for writebacks and internal
 rb tree
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
	josef@toxicpanda.com, bernd.schubert@fastmail.fm, hannes@cmpxchg.org, 
	shakeel.butt@linux.dev, linux-mm@kvack.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 16 Oct 2024 at 11:56, Jingbo Xu <jefflexu@linux.alibaba.com> wrote:

> FYI The posix sync(2) says, "The writing, although scheduled, is not
> necessarily complete upon return from sync()." [1]
>
> Thus hopefully it won't break the posix semantics of sync(2) down if we
> skip the waiting on the writeback of fuse pages.

Since this has been the case for fuse since day one and no one
complained, this is not a worry.

Thanks,
Miklos

