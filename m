Return-Path: <linux-fsdevel+bounces-73416-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7ACD187B6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 12:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE73230737A9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 11:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E976F38E126;
	Tue, 13 Jan 2026 11:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RCYTA6HG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lUkvtitZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1298738BDDD
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 11:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768303463; cv=none; b=Wbsifjl7faSHkCQAoLR3pR0T37nmDPivwBa+uYw534M6/hJGAKtCk8x0Kqz7xa+prrXshj39KBASFSXe7Gjjf6WSVD09EL4P2jYfliZQyLUVFy2iBMXaOVdKaBGzVSUzFE0rN4NPi5gD2vYguff5LTpXSEhHPKHIesECdVbho3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768303463; c=relaxed/simple;
	bh=XgIYMzGgW0gHescGH608mwN1JydkPpadmv8jvJ6FIdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bruo/4VEj8iYNaAhxA+MgsQ/+Ootu9LWXMfyA78YPyqcvmJim54+E+gcimR87iG0oZbKF4nEh/9SgAzDOhTSypXSSQih67K8U8drYpCDUiYL7t2AUI8XMGHh7CwBpgpNTbZR1rIQriABum+dxAELNQkB+g7paNW7Tsy/f3UgQRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RCYTA6HG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lUkvtitZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768303461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nRMkXI0DMI5p2B4y5x0zNltsIxM3cjoIg//7deRWL0Q=;
	b=RCYTA6HGIT+HolBnHwC9xDvFloF6Ga06tSPA+A75a12doitASZBP08liZP2sedS/49b7T4
	hs/HnpHwdQFqZBgR3YmE91YdLUcW6Khj6CvHiKOdCyIJ6haMIzI4mHh8ypzMj8TfME/JJf
	FCguJmBa0SYtyjzpRBGrxtBvSpQ+6b4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-6IXtUJVUPQmhEsX-Zwv8JQ-1; Tue, 13 Jan 2026 06:24:20 -0500
X-MC-Unique: 6IXtUJVUPQmhEsX-Zwv8JQ-1
X-Mimecast-MFC-AGG-ID: 6IXtUJVUPQmhEsX-Zwv8JQ_1768303459
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-430f8866932so6293416f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 03:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768303459; x=1768908259; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nRMkXI0DMI5p2B4y5x0zNltsIxM3cjoIg//7deRWL0Q=;
        b=lUkvtitZFJ/5hg8xZowKit+LCdSYFqebLSJf2P6GBPG6lTtHztyM72bBZnxYBeTHWo
         v3N4AtP5ogOvt7pGkRNhigYWbv8zvQHLOI751eUM7gO+vZr5Hhnwp8yHiBLW/MTCGwKN
         Wxm6Ojv4N3b9vPx5SyjUphmLbW5ZYSl7pxjnVk4VkOhAkM0j/MnL9yR2iO4WHdaeDSse
         +3wLAe9KA4zFaoAY3OniuGIXE9PWCVFMe6D/+o5zAu4aleU+6etCTLLegvFdtMXwLwVP
         QS0DicVL71YEjcnU2YCagnJv+a9G2F6RaD+NX9Ust4t5+DqWr3Uwb7tWziXwlz6RCHbo
         Ax6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768303459; x=1768908259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nRMkXI0DMI5p2B4y5x0zNltsIxM3cjoIg//7deRWL0Q=;
        b=fLYIewMJDyU5pGkUFNZn3ilKJdHsRZy/3HWuUXE/QskFztcpK0u7XAlyoFjxi6zJDS
         ivq+mtd10psu7vEYDuAr4Wr8zZcrhPOH4YyNVQRwzgA1KbdgVcwY0vsQWk2t24aepZEr
         vHNJ30YrEkkMkK6i0FWmUz2CP9XCffd+XSg65aHb2SG78xrwww4heVLZsHrn3qmKKYMf
         NN0ZcV/eUd7etKfrM+M9XlSPHGbJN0ya0yJXCyYzHZasEs1SbAg9cVN4cA5vLdgoagKP
         T4t3jAEDolnPxEXKlt4jrbINc+ozWnIOCUseUhXvfRmcKayT7AIZpQkGn4o4Ct2fa6Mm
         +fFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsJ4RFNGVoqTiew7Th0QUidJbGpiG38NL+i9GljnIsFqprHx8bU8aOlZex7ESznAAHEE4tXZme4fJyCsZ6@vger.kernel.org
X-Gm-Message-State: AOJu0YwFyUaRUxfWe5rENzIlA1aP3R+oPB7t/fAgwLo9KfV42KIwwonX
	RxbrB8q+ph4pRjKXp1UoJh2nqNk/nqRzusSAWZV1+hrk4Dcb9XqdMBXrIQ7oUay1WJMh3f/l7pe
	QVqXiP9QASuXBLzBIL78WSPQB/KDZTVu3BH/K5e6Sh+NywnyZDBNwlKulEyAXMmxsXw==
X-Gm-Gg: AY/fxX5P1tLFoiSHo4KmfJy4bjStmW8651aaCR0fmL3snf9OgL3SAuLOi4kQ4nGSo+K
	X2havxz8fwhF9aZODm2p9bWMekuWsEEtEF3RBOcuplJAsEhjqXuGSFomXp8aJgnOHWJYBvUtVKc
	uMuf1qof+elPLIFcw5lAViPsgKQbu5Zer5mCsTJZ5pIbuW4hage+MmcXSsL+SosE9EdUxgFeEU1
	Jbteg+16bmLf7A+/LwyL6D8yWooXADSCAVk7VKA+5ztz4+hiZW0OtTlmz3IFfexF/hCUNRzwzfD
	tE6ZfhX/KV7PDdl1qbsYX2XKFE7DivBTS6xHu+HdVRvNwcucxsgdx0LHSMYgBxR+slX7B3cYBvQ
	=
X-Received: by 2002:a05:6000:3106:b0:432:c0b8:ee58 with SMTP id ffacd0b85a97d-432c3617c2cmr21757756f8f.0.1768303458661;
        Tue, 13 Jan 2026 03:24:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrM747jJuZXqfgIkrgmr5TDL+50UKoPdv4m4RQQMEuwrd6aGEzUqe3Sgbk9CxIB87OJxTBug==
X-Received: by 2002:a05:6000:3106:b0:432:c0b8:ee58 with SMTP id ffacd0b85a97d-432c3617c2cmr21757724f8f.0.1768303458178;
        Tue, 13 Jan 2026 03:24:18 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e199bsm43351636f8f.16.2026.01.13.03.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 03:24:17 -0800 (PST)
Date: Tue, 13 Jan 2026 12:24:17 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, 
	ebiggers@kernel.org, linux-fsdevel@vger.kernel.org, aalbersh@kernel.org, 
	david@fromorbit.com, hch@lst.de
Subject: Re: [PATCH v2 12/22] xfs: introduce XFS_FSVERITY_CONSTRUCTION inode
 flag
Message-ID: <64sjr2cxebvpupkhqi7hjcu4uy5xv6x5xxucrskh4dn4b5g2jk@kryfgma557js>
References: <cover.1768229271.patch-series@thinky>
 <bfcg5hug75qtvc2psw5yymfoudnz2uda3gg5dfzgnze46hwt6n@u67n3rdzzuo4>
 <20260112224213.GN15551@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112224213.GN15551@frogsfrogsfrogs>

On 2026-01-12 14:42:13, Darrick J. Wong wrote:
> On Mon, Jan 12, 2026 at 03:51:16PM +0100, Andrey Albershteyn wrote:
> > Add new flag meaning that merkle tree is being build on the inode.
> > 
> > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> 
> Seems fine to me, with one nit below
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

Thanks!

> 
> --D
> 
> > ---
> >  fs/xfs/xfs_inode.h | 6 ++++++
> >  1 file changed, 6 insertions(+), 0 deletions(-)
> > 
> > diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
> > index f149cb1eb5..9373bf146a 100644
> > --- a/fs/xfs/xfs_inode.h
> > +++ b/fs/xfs/xfs_inode.h
> > @@ -420,6 +420,12 @@
> >   */
> >  #define XFS_IREMAPPING		(1U << 15)
> >  
> > +/*
> > + * fs-verity's Merkle tree is under construction. The file is read-only, the
> > + * only writes happening is the ones with Merkle tree blocks.
> 
> "..the only writes happening are for the fsverity metadata."
> 
> since fsverity could in theory someday write more than just a merkle
> tree and a descriptor.

changed

-- 
- Andrey


