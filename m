Return-Path: <linux-fsdevel+bounces-73174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE73D0F8FC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jan 2026 19:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B60013046105
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jan 2026 18:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA17C34D4E8;
	Sun, 11 Jan 2026 18:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fD6DZ4g7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A200434D4CD
	for <linux-fsdevel@vger.kernel.org>; Sun, 11 Jan 2026 18:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768155877; cv=none; b=CURLd2g342+Hgj6fYcCuCRMZizMJgvSt14D7GTx+KaUZiOd9rPpGQw8Wg6Sf5Yi27jtZIz4GSJXdv6j0S6zlT7Yb6BYDXSzR6McbYnQYFAxZkOqSz/gKi0NJwuOvkTbNFUjO9OhwJvRaYc99BfWL1PTOmZnY5ZRMuaL2qZYtBvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768155877; c=relaxed/simple;
	bh=wuZGY6SRlUzNFhhRYK2DoKN94QfIw6eNulOP0xDDvY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPrGRM/XL0Muw7FqNiYhUm5IMv/3jtFFVi6vPLbKBhVgKZITcDIxdGmtcqEHlgzmp03As1Dvnic+VqO8JuK3Ot4kkFGTsHS8jvbFsmwRf8Ur8rjvnL4BKI1zvT7pwJjRoOzMZLTmiJTe8DnlL+JIQ4XjrT09jF226DJCUZqSSJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fD6DZ4g7; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-65e943048afso1949149eaf.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Jan 2026 10:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768155872; x=1768760672; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R+GSc2GBWlyyKLR953NpzcUC6v/+T5KZ51y3NFrwZfA=;
        b=fD6DZ4g7gNAjBngOltJ00A8QVXfV02G58R55KJB/NEcXZw738j6DJIKDDzlr1wVvdi
         0S2wcMcX1vEiRATRpyEVPjF2tn277Zqrw8+342E8rm+WlXB1mQ45dwujuTfdHcGonnc1
         L1L8LGOQDBH5rnrEzH5WfPv1NM+RtPKoTOmf1n3zIOFzv7NDjstCDKveuMSHaYkIGf+G
         JJmDwh/qXfqHwtHr/v+/r1zfKJIYNfwJ2XgmBD+QndIxpQe8ioSAtz3ezVwDkrRNHRDW
         wOEY1V73tcV+gpWguNsaSMGS9nVNOB00tcki+vp7YnYvYv53kIglsl0FMsmdHVIOeuZV
         jFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768155872; x=1768760672;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R+GSc2GBWlyyKLR953NpzcUC6v/+T5KZ51y3NFrwZfA=;
        b=doSavKzjTID2OTU1HPV+hwsmZEdKzNp2UGBhAi3FR5hwrxpioeAJ4WKHVQ3ln0PH4n
         cBrseQOARp6gglqJaL0LfqBestz8nTxzBXBPfq4Ajj9UjkWpu1Ss96VtFZE9fTmE89uE
         hcOZqRw17G1JobecY9eAwvmsVhfTB9AFSKJ17euIETxq6Qlt2hFx+CLvaxPxN8kbzUfT
         XySd7X01ymZ1316IJq21Ax28hmKLmXNKRQaIYZW0C2Ojv1PGw1mF14wnYSrT84KU9f3V
         03QkCmzXgLw7xq1aSdhmdYsv+r4oAM74HVxuZTGm+Rd0ejWvTZjXGOocWi2xeWNuUqaZ
         2hHg==
X-Forwarded-Encrypted: i=1; AJvYcCULSh5CTwnzdFJdHFAjn+oFG23qCnUyslh4CTr3+qZE6mZyICmp27/0UwGnkxNMgxuDaO0fA1B6ajCm+6ep@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0SOgIIGPdPGHVNIBG1dA3ZJychWcYunBAUXdZqzlwlk6kvtbB
	/sA8bGK45+vVFcXBjruBIF3YkRA7wi6xso6OsOuc9SFMryE+zzChEbst
X-Gm-Gg: AY/fxX5ebHWtLdvq/whssyjcp68Cq6Sy2rHqlmC7vz0CQLXlNR1eu/xy0huMMQxKedB
	kPcGVvbdpT1jg1hTiEbni2c7xQzFXdHD/kNfbosLB/kccDZfqPmunqYuNj48ar0xNp5zxrEJew6
	wQ3ONjyhH++Yfceq8diYnErSjx766i+Q9Q6/pydIb7V2sjz5LPNv6sfFEXR7dXyn4b5WhxPUS8m
	zpUXwL0IB1EqbqKCaUQ+U8RUJYQrbAsqb5DRF94YkhH5D47QzA9G+Q03dFw6CUtV98+W+R82aER
	/GGZgksjHcSs9JaqpaLxNvr2QE0PFQFyUdAqS1goshYKjiBMxdlF/eWWYy6W7WtNsZxthgZ2K76
	2SxmaM5AlDV/DcCYEQxsYhENbT/4SG9wGk0VjXWsrI1dOVpcP4vuHx4S3NEByjszr4HVt3+i+ht
	6YWxac0VDyTYe3/Bucm/RNjX6vG7YTaQ==
X-Google-Smtp-Source: AGHT+IEvvggI2mJmOtqFQTAS39y6eV7fvRie7hl/ldDRYe8R5GovPjr7x7SyKxaIKesqgZD+L7TFNA==
X-Received: by 2002:a05:6820:1694:b0:65f:6601:b342 with SMTP id 006d021491bc7-65f6601cbd8mr5456330eaf.7.1768155872287;
        Sun, 11 Jan 2026 10:24:32 -0800 (PST)
Received: from groves.net ([2603:8080:1500:3d89:cc0c:a1b0:fd82:1d57])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65f48bbc0desm6567999eaf.2.2026.01.11.10.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 10:24:31 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
Date: Sun, 11 Jan 2026 12:24:29 -0600
From: John Groves <John@groves.net>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	Dan Williams <dan.j.williams@intel.com>, Bernd Schubert <bschubert@ddn.com>, 
	Alison Schofield <alison.schofield@intel.com>, John Groves <jgroves@micron.com>, 
	Jonathan Corbet <corbet@lwn.net>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Stefan Hajnoczi <shajnocz@redhat.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Chen Linxuan <chenlinxuan@uniontech.com>, 
	James Morse <james.morse@arm.com>, Fuad Tabba <tabba@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, 
	Ackerley Tng <ackerleytng@google.com>, Gregory Price <gourry@gourry.net>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, venkataravis@micron.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V3 4/4] fuse: add famfs DAX fmap support
Message-ID: <2mr7vou7zeauqypqq3xay6wdmc6g2havk2e33cfphwylu7dnit@qk32hbe7zgy3>
References: <20260107153244.64703-1-john@groves.net>
 <20260107153443.64794-1-john@groves.net>
 <20260107153443.64794-5-john@groves.net>
 <20260108153148.00001e63@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108153148.00001e63@huawei.com>

On 26/01/08 03:31PM, Jonathan Cameron wrote:
> On Wed,  7 Jan 2026 09:34:43 -0600
> John Groves <John@Groves.net> wrote:
> 
> > Add new FUSE operations and capability for famfs DAX file mapping:
> > 
> > - FUSE_CAP_DAX_FMAP: New capability flag at bit 32 (using want_ext/capable_ext
> >   fields) to indicate kernel and userspace support for DAX fmaps
> > 
> > - GET_FMAP: New operation to retrieve a file map for DAX-mapped files.
> >   Returns a fuse_famfs_fmap_header followed by simple or interleaved
> >   extent descriptors. The kernel passes the file size as an argument.
> > 
> > - GET_DAXDEV: New operation to retrieve DAX device info by index.
> >   Called when GET_FMAP returns an fmap referencing a previously
> >   unknown DAX device.
> > 
> > These operations enable FUSE filesystems to provide direct access
> > mappings to persistent memory, allowing the kernel to map files
> > directly to DAX devices without page cache intermediation.
> > 
> > Signed-off-by: John Groves <john@groves.net>
> 
> 
> > ---
> >  include/fuse_common.h   |  5 +++++
> >  include/fuse_lowlevel.h | 37 +++++++++++++++++++++++++++++++++++++
> >  lib/fuse_lowlevel.c     | 31 ++++++++++++++++++++++++++++++-
> >  3 files changed, 72 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/fuse_common.h b/include/fuse_common.h
> > index 041188e..e428ddb 100644
> > --- a/include/fuse_common.h
> > +++ b/include/fuse_common.h
> > @@ -512,6 +512,11 @@ struct fuse_loop_config_v1 {
> >   */
> >  #define FUSE_CAP_OVER_IO_URING (1UL << 31)
> >  
> > +/**
> > + * handle files that use famfs dax fmaps
> > + */
> > +#define FUSE_CAP_DAX_FMAP (1UL<<32)
> 
> From the context above, looks like local style is spaces around <<

Fixed, thanks!

[ ... ]

John


