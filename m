Return-Path: <linux-fsdevel+bounces-20756-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7C58D78CF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 00:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50651281053
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jun 2024 22:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BEF77118;
	Sun,  2 Jun 2024 22:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="xYsymsIj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE063374C4
	for <linux-fsdevel@vger.kernel.org>; Sun,  2 Jun 2024 22:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717366985; cv=none; b=LHa1+e/l4C5IatY1cP64ktBh5LRGCJ+6Z+kE56azDfAqWaLVXrV52pZiMP4wCkOwo8wtXC0AXz85U83xoZ073w619g9KfDbqs7OnV8VS3J6/qdTtZE1uy7+K+/D1TFvBOKz6pNsPyvrIzMxkeWv4GpiPNZkD5T1VnMpUFgLCEAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717366985; c=relaxed/simple;
	bh=Mr00QLpO9fhnocd3iU/6Fo0RO4Ha+r/BVCnA46PTjNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bX3bxSTP1aBLklIxJ6ZhLTcj+ZgD82/Jn5vxoTW/VyIK0kSiWtkmsplx+08/sL+06baz/Dc2n5FWIr4/TO1ZPODvyIRjQqFeBvkbtuhPMq/mnlsCT0qaEh20aXUCiubaUwoqaA+FTqXTPFotTBwEYk1hGFGPYC8nezF1hrDSpnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=xYsymsIj; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70249c5fb36so1768901b3a.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 02 Jun 2024 15:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1717366983; x=1717971783; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r+qHiu1fDaio4iw1wa2Jj3WFs3uLLPp8LW1eRWXiQiw=;
        b=xYsymsIjgQQ4SImF4UsQ8LiDYHY2Jrcjbd+APZ/ar9UOse2vEAD5DUQkYggC83uFNU
         vT9MzDV4W/X56ScTzMKBrxPyHVSFuxv7qYmfBuTXm/SojS+yBWGiASThN1knBPnhptn8
         bIBQThcWWmIMIL9FFkbx0r2B22AduZJhEWlEYp8b0aMIJxeGEdsipcjmN/TSJTUAu+z5
         BYfjBCEa8dXYWF9PpBpgyCmNGNFWwKoo6ggMhB/4+81yr35GEQuIGEYgnPE4uogRSr9t
         Rcn56RenSfb/ioyI/Gv3Q2//gbZevgjQ19f9pIaF+lbOn7PBJLiAskWnKKEe4j6RJmRj
         woNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717366983; x=1717971783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+qHiu1fDaio4iw1wa2Jj3WFs3uLLPp8LW1eRWXiQiw=;
        b=nr5g+/TPawT42106prZ5pRragdNSz1sEKgmUDHZQDXICEUs3QyLOoJ7CdAaH+cnwEj
         UXwBT2+ASrpTlbIEzGSZ+hEMd/XrLLInrLa6pozWBaFyoHsB6Bb/BXyJwMWdNUrYuRid
         LZRxTyYBPsqah7Xw/zqyhi/nl5rX+yRKaoxbRVwvsY12VH8qDjRn87yDNYyiHI0AJ36E
         uT8zEAnSPuYbwBloWdFFa7ua9PRC3RWnpYzOm4PmvzaIPhpw/AVCO643Rf6CugQkxiiv
         GPGlDES2syYdQSMdIabkf0kCjzqKGOFIuzFwdIisk/ZGnFf4q+gPkug14nd29X4I/gYc
         DRYw==
X-Forwarded-Encrypted: i=1; AJvYcCWbkInNYZjd60Agh49jcON+gOR/xHQZkLLjeArztEOjGYcd4wA9X8HTsESx34qmDnM8f2/g+Z46m/oB2v9KWs7rt7GohAhc+hzyCbz6mQ==
X-Gm-Message-State: AOJu0YxWO4G3RTgv+ulRt1fY/H9ckwrKF7ynojn1vcKJRbQrz4J/rllC
	FEx1VaBzYY8JMScl9pB8g7thWMmeU/AAucJaFvjpKI9hPGUOB1CtDYrxbPIJhxE=
X-Google-Smtp-Source: AGHT+IGlLMT/Ad2Llvr+dKbboOwJ86GzWZO1YxG5Eo5zvzgrGONcQzWNz/muZMPZfiuyr+gm8sesBw==
X-Received: by 2002:a05:6a00:4b53:b0:702:6022:ff8b with SMTP id d2e1a72fcca58-7026023009dmr3771225b3a.30.1717366982930;
        Sun, 02 Jun 2024 15:23:02 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242b300e8sm4340433b3a.210.2024.06.02.15.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 15:23:02 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sDtbO-002AE0-1s;
	Mon, 03 Jun 2024 08:22:58 +1000
Date: Mon, 3 Jun 2024 08:22:58 +1000
From: Dave Chinner <david@fromorbit.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Zhang Yi <yi.zhang@huaweicloud.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	djwong@kernel.org, brauner@kernel.org, chandanbabu@kernel.org,
	jack@suse.cz, willy@infradead.org, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [RFC PATCH v4 1/8] iomap: zeroing needs to be pagecache aware
Message-ID: <Zlzwwi6xO7TFSUp4@dread.disaster.area>
References: <20240529095206.2568162-1-yi.zhang@huaweicloud.com>
 <20240529095206.2568162-2-yi.zhang@huaweicloud.com>
 <ZlnMfSJcm5k6Dg_e@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlnMfSJcm5k6Dg_e@infradead.org>

On Fri, May 31, 2024 at 06:11:25AM -0700, Christoph Hellwig wrote:
> On Wed, May 29, 2024 at 05:51:59PM +0800, Zhang Yi wrote:
> > XXX: how do we detect a iomap containing a cow mapping over a hole
> > in iomap_zero_iter()? The XFS code implies this case also needs to
> > zero the page cache if there is data present, so trigger for page
> > cache lookup only in iomap_zero_iter() needs to handle this case as
> > well.
> 
> If there is no data in the page cache and either a whole or unwritten
> extent it really should not matter what is in the COW fork, a there
> obviously isn't any data we could zero.
> 
> If there is data in the page cache for something that is marked as
> a hole in the srcmap, but we have data in the COW fork due to
> COW extsize preallocation we'd need to zero it, but as the
> xfs iomap ops don't return a separate srcmap for that case we
> should be fine.  Or am I missing something?

If the data extent is a hole, xfs_buffered_write_iomap_begin()
doesn't even check the cow fork for extents if IOMAP_ZERO is being
done. Hence if there is a pending COW extent that extends over a
data fork hole (cow fork preallocation can do that, right?), then we
may have data in the page cache over an unwritten extent in the COW
fork.

This code:

	/* We never need to allocate blocks for zeroing or unsharing a hole. */
        if ((flags & (IOMAP_UNSHARE | IOMAP_ZERO)) &&
            imap.br_startoff > offset_fsb) {
                xfs_hole_to_iomap(ip, iomap, offset_fsb, imap.br_startoff);
                goto out_unlock;
        }

The comment, IMO, indicates the issue here:  we're not going to
allocate blocks in IOMAP_ZERO, but we do need to map anything that
might contain page cache data for the IOMAP_ZERO case. If "data
hole, COW unwritten, page cache dirty" can exist as the comment in
xfs_setattr_size() implies, then this code is broken and needs
fixing.

I don't know what that fix looks like yet - I suspect that all we
need to do for IOMAP_ZERO is to return the COW extent in the srcmap,
and then the zeroing code should do the right thing if it's an
unwritten COW extent...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

