Return-Path: <linux-fsdevel+bounces-14196-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C928793BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 13:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81B591F2252C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 12:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9485D7B3D1;
	Tue, 12 Mar 2024 12:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eiHPFB1L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4024B79DC8
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Mar 2024 12:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710244982; cv=none; b=uv0Hdhrq0qNH8FY4omCnd/ebJ550UeA+rRv+uk0nKzIjSABvsaymvNsf+1jjR1WIIGT5HbYJkKrkmnAMiYjZTOmCXSEjDAOyl2/aR82gtOJWuh4wRhYW63iqAuV/a6VAzgS45GLLKG59++rKpIuCxN4H3viWnKvYfgHY6K6sUfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710244982; c=relaxed/simple;
	bh=gLJ7CIvGElJrM3FH8zc5Ikyx3f1w8B64p7eGgtgMKn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dGVoZiNGgJgR444BAPXp/P1FtFCBYLiFGXyJRn+u9/SluL+8v/MDsryU2Lhjbq+WiiajHAaUDD0pu9rgPe2QCryrpU754LiKvWxLAvKe3F2Je6zcuzXqzg1yccOpjgsXDA5noz+mzDvhCACgCe4XM3cUu97utcTGr1MCPgzD0Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eiHPFB1L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710244979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6ZNgBnphBVUjd2R20eoaYssWgOFygTeJ0L4LhcZX464=;
	b=eiHPFB1LFsxdyB3We+JPw62mMatNefwy90WeMg2etYFygZVuOhyCqOjXLeprtAzY9WDuRw
	DNIwb9GNkRFsYY+jeFIyrH3xjLbtUMRaC8470Z+7s6opJR70AD76w2e1e88vTWz/TKDDRX
	amtCD1KdOREY9ocbQzVrlzjUiyuj4hE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-Sx-fp8hwN1Gq4rf0C80zFQ-1; Tue, 12 Mar 2024 08:02:55 -0400
X-MC-Unique: Sx-fp8hwN1Gq4rf0C80zFQ-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-568653cff80so1124595a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Mar 2024 05:02:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710244974; x=1710849774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ZNgBnphBVUjd2R20eoaYssWgOFygTeJ0L4LhcZX464=;
        b=kyy/VGtcfkgEQVdvXEWkmpJpW8zUCQ75lDXQYuef2Ou9Um79xjFyrhl6k6r7xCQLzr
         TT3S4PJ3ZguJppzRV2V/19tOViGmp5tqJsJEIBN2r6Y+KBUMoOckhKI2Fs3y2bWu2PAq
         4ZiNaooAHIn1J2CLaSn9P1QSUGszk+SlU0/IItgamLdmgl1CiYJkD0lGB7GaWCHpmtSb
         HdVSzpxB615a4YztPav8ivxG7E6vZxLZGcLazU+cLVcSUeM9IkS8TryVjUJZPt7qA6K4
         IOIILpq7l58JwQ+Eeh8WxLIJNDN/tQNbFCbUu4JwRGIEZlGqplO11eQc++qKnbiieWJB
         92vQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrXlWYgBDjw44Bui4ZJ/c1W75CXSjaDvcZgQAyiHk3uzNb5k+wwKCWecSVBvZk1sGQFUcf1xlQ2k3z5W0VsUpKiGWiEBHyC+dvvsVNIA==
X-Gm-Message-State: AOJu0Yw+eEUJvpJnthiLSuxAh+gI/eV/f5YOwKAV5ulzIRyZ1M2zYQfm
	yKoaY44uukd6Gv5TRIdmLcZ681X6FXaV5rsKiaVs6jVybUGb3CtVIIy9Wo/t628Au8U+GkUZGHR
	3FWfBssbOhKQ4vPyd4XGEcnmDzvP7/5WzMYvywBVXtuIOfMWR8gzeiMZti3N/Qw==
X-Received: by 2002:a50:9fc1:0:b0:566:b0fc:1107 with SMTP id c59-20020a509fc1000000b00566b0fc1107mr7059713edf.24.1710244974516;
        Tue, 12 Mar 2024 05:02:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7xAfun2JnAHXUSEV9ZQaEmUy3Cd7FlaZLul69utVqZ8bARjrEBLt2760n9Q/glLHtlZR+Vw==
X-Received: by 2002:a50:9fc1:0:b0:566:b0fc:1107 with SMTP id c59-20020a509fc1000000b00566b0fc1107mr7059686edf.24.1710244973994;
        Tue, 12 Mar 2024 05:02:53 -0700 (PDT)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id x1-20020a056402414100b005683b6d8809sm3807014eda.19.2024.03.12.05.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 05:02:53 -0700 (PDT)
Date: Tue, 12 Mar 2024 13:02:52 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, chandan.babu@oracle.com, ebiggers@kernel.org
Subject: Re: [PATCH v5 20/24] xfs: disable direct read path for fs-verity
 files
Message-ID: <w23uzzjqhu7mt4qp532vwjd3c7triq6vfftzsmi6ofium34qic@fghx7nfarmke>
References: <20240304191046.157464-2-aalbersh@redhat.com>
 <20240304191046.157464-22-aalbersh@redhat.com>
 <20240307221108.GX1927156@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307221108.GX1927156@frogsfrogsfrogs>

On 2024-03-07 14:11:08, Darrick J. Wong wrote:
> On Mon, Mar 04, 2024 at 08:10:43PM +0100, Andrey Albershteyn wrote:
> > The direct path is not supported on verity files. Attempts to use direct
> > I/O path on such files should fall back to buffered I/O path.
> > 
> > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> > ---
> >  fs/xfs/xfs_file.c | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> > index 17404c2e7e31..af3201075066 100644
> > --- a/fs/xfs/xfs_file.c
> > +++ b/fs/xfs/xfs_file.c
> > @@ -281,7 +281,8 @@ xfs_file_dax_read(
> >  	struct kiocb		*iocb,
> >  	struct iov_iter		*to)
> >  {
> > -	struct xfs_inode	*ip = XFS_I(iocb->ki_filp->f_mapping->host);
> > +	struct inode		*inode = iocb->ki_filp->f_mapping->host;
> > +	struct xfs_inode	*ip = XFS_I(inode);
> >  	ssize_t			ret = 0;
> >  
> >  	trace_xfs_file_dax_read(iocb, to);
> > @@ -334,10 +335,18 @@ xfs_file_read_iter(
> >  
> >  	if (IS_DAX(inode))
> >  		ret = xfs_file_dax_read(iocb, to);
> > -	else if (iocb->ki_flags & IOCB_DIRECT)
> > +	else if (iocb->ki_flags & IOCB_DIRECT && !fsverity_active(inode))
> >  		ret = xfs_file_dio_read(iocb, to);
> > -	else
> > +	else {
> 
> I think the earlier cases need curly braces {} too.
> 
> > +		/*
> > +		 * In case fs-verity is enabled, we also fallback to the
> > +		 * buffered read from the direct read path. Therefore,
> > +		 * IOCB_DIRECT is set and need to be cleared (see
> > +		 * generic_file_read_iter())
> > +		 */
> > +		iocb->ki_flags &= ~IOCB_DIRECT;
> 
> I'm curious that you added this flag here; how have we gotten along
> this far without clearing it?
> 
> --D

Do you know any better place? Not sure if that should be somewhere
before. I've made it same as ext4 does it.

-- 
- Andrey


