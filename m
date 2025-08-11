Return-Path: <linux-fsdevel+bounces-57409-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8D2B213C3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 19:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 921281A22D2C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 17:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FEE2D6E7A;
	Mon, 11 Aug 2025 17:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HyfUCPlq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B742D6E63
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 17:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754935154; cv=none; b=ozCyFjJilUegQMhYHVOxAFhlM4WCTBDuGkNyH21Z4+AWNYRdfSv6hU2+MiHEG6TlMkbDGCpeBQdXTac3IWunCAnS4IFaz+s98JL2gPDWIp+FbyXJ7Ib15+8rp5g3PuSf8MpJuqUipN7UICI/vxjwe0dx4UF2keE9XD//KBwveNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754935154; c=relaxed/simple;
	bh=ef0lHlV8whRhwcKFAPcJboYQ2/ttMtt8/9vQeKgW1zA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bkepkUiCd2Nu8Z2ulHAqHSHrgHLy+Ohp5tnTLBGMz9oJrWC0V8fY+DIdR/fphxWbSFvbsC/c8IgbBQbcRzVWB0dRbv2kCwmAHk3AGOuuDhUmsFAYx6bDtcS89QJ4ZCUDexYSbFh5EHJemU8dvLW9P6kq/BkpFLlFAPUmfBLGLck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HyfUCPlq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754935151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+M89Chwaj/xYrETNJmbtBCPqSQalO6L7Aetkbd+RPKg=;
	b=HyfUCPlqDYrCwJwHX0korH7QbpjOyLVdMCndSafPL8evHPaXVp8AqzcQPsCsIUBtUfJXNi
	vG8kJeL0U0Lx+ZGOLPNDLSbSu7hkquYnZfL4hw/9JKniW3DI0IotcpuNzN+RZnkfTwKYUG
	uofMrHZiG++ULgxTr1sRDPE5Iwx7Pqg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-TuQbVr1JOZiwkWLZGtQFmQ-1; Mon, 11 Aug 2025 13:59:09 -0400
X-MC-Unique: TuQbVr1JOZiwkWLZGtQFmQ-1
X-Mimecast-MFC-AGG-ID: TuQbVr1JOZiwkWLZGtQFmQ_1754935148
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-459d7ae12b8so33267715e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 10:59:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754935148; x=1755539948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+M89Chwaj/xYrETNJmbtBCPqSQalO6L7Aetkbd+RPKg=;
        b=tQZxlHRQWIfogZUlEub+iUG/rG+ISAOPPhl+yCNQxf4pQpfJp9fhBZGQdPa1osoo0H
         gZ3DGf0YapVxGcDR363dX/oTlfivkP/tLiUX/DF/yX/j+33p/5tOTzBdbB31Pd+kc4/y
         S7SgMkAK4tZ2NwvZBTg8XWyNMZkTvpGrJZ/7D4s+7ocBv1Ysv8H6ovjgwkbpaYVFRMoR
         bJGrQlZDk07o+y323/8fSiVdRniBlTciR2fKAjNBYq2CnTItb5Vt3l1nTk/ULcArsUad
         5aBR48SkhTiF/uziqQfnDZSY1E1iJdiGRjgJFqz7IaYpvZRNS/46T6BgtVeMz4By5Pf5
         +U5A==
X-Forwarded-Encrypted: i=1; AJvYcCUChpP+qPpyTuUi7gpLQz3QDwYIcLDDZE02OlS5a2yPlLVj6kHraSlKW0siPChB9XnfltOUuTCxAIZOzzxl@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9yDJLGcTSy3JT1EwLTaQj9XgsSMA4jDHeGxbxI9Sv6Ry7/Pfa
	5tLHDHPGajX+Qjx5laxQRW0N03Irc3Jk+7acuply92j4NbWU6aRoOY391CPGsFUQY1r3n5NcOdd
	zxJiRV35DGiaxdgW0DfULIx7wOXO4V/83DFfN24TNaoha66bvjh21rDgLBcPXROXSlw==
X-Gm-Gg: ASbGncu9wcsEF3hcLNgGDScjtq7a3TbNXgHBPXw9shtPRW1fhSe6uQ/9FfIUNNIQfWT
	Jgx6yhl1PvUO1YZwySEhbQBeUfZZzAqDm7ffewnP46mrVrvw+VlmEJkRFDltetBNzjQvv31+Fdj
	ELL7WTfd50fasteExeaCXG83BiXbeAdNP4ZVVEgYEF1fZXpqt4RRaaBMtlVn88wWG0Z+NRaDw5D
	3LXzHnH/9hsMvPnV8QnblgljvHqtqo6t9ZLmVAhLMNJ28pV8fpH96Lga6q9xKDCFiRESEd8HYMK
	amVAy7eNrF02K01fL/CuCJx5XjZfWHEc0xFARZDUQkSebrg/9GSO5Dzh9pc=
X-Received: by 2002:a05:600c:1d0c:b0:453:2066:4a26 with SMTP id 5b1f17b1804b1-45a10be7d2bmr4990085e9.16.1754935147901;
        Mon, 11 Aug 2025 10:59:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzsgz1alcX9iZ1OGeIMnBeRHC4issJV1QBepTpHigMvpYiWbPyRpe1aEDnnFUPg8J84MI5HA==
X-Received: by 2002:a05:600c:1d0c:b0:453:2066:4a26 with SMTP id 5b1f17b1804b1-45a10be7d2bmr4989885e9.16.1754935147439;
        Mon, 11 Aug 2025 10:59:07 -0700 (PDT)
Received: from thinky (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458b8aab8c0sm398414305e9.19.2025.08.11.10.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 10:59:07 -0700 (PDT)
Date: Mon, 11 Aug 2025 19:59:06 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: aalbersh@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 4/4] xfs_db: use file_setattr to copy attributes on
 special files with rdump
Message-ID: <gi3zx7yt3jhq726vbcs5rpp7cpqp7fu5hkul4fbdxowxypa5kw@ii7tj7ckhyvs>
References: <20250808-xattrat-syscall-v1-0-48567c29e45c@kernel.org>
 <20250808-xattrat-syscall-v1-4-48567c29e45c@kernel.org>
 <20250811151427.GD7965@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811151427.GD7965@frogsfrogsfrogs>

On 2025-08-11 08:14:27, Darrick J. Wong wrote:
> On Fri, Aug 08, 2025 at 09:30:19PM +0200, Andrey Albershteyn wrote:
> > rdump just skipped file attributes on special files as copying wasn't
> > possible. Let's use new file_getattr/file_setattr syscalls to copy
> > attributes even for special files.
> > 
> > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> > ---
> >  db/rdump.c | 24 +++++++++++++++++++++---
> >  1 file changed, 21 insertions(+), 3 deletions(-)
> > 
> > diff --git a/db/rdump.c b/db/rdump.c
> > index 9ff833553ccb..5b9458e6bc94 100644
> > --- a/db/rdump.c
> > +++ b/db/rdump.c
> > @@ -17,6 +17,7 @@
> >  #include "field.h"
> >  #include "inode.h"
> >  #include "listxattr.h"
> > +#include "libfrog/file_attr.h"
> >  #include <sys/xattr.h>
> >  #include <linux/xattr.h>
> >  
> > @@ -152,10 +153,17 @@ rdump_fileattrs_path(
> >  	const struct destdir	*destdir,
> >  	const struct pathbuf	*pbuf)
> >  {
> > +	struct file_attr	fa = {
> > +		.fa_extsize	= ip->i_extsize,
> > +		.fa_projid	= ip->i_projid,
> > +		.fa_cowextsize	= ip->i_cowextsize,
> > +		.fa_xflags	= xfs_ip2xflags(ip),
> > +	};
> >  	int			ret;
> > +	int			at_flags = AT_SYMLINK_NOFOLLOW;
> 
> Why does this become a mutable variable?  AFAICT it doesn't change?
> 
> Otherwise things look good here.

ops, leftover from older version, will pass it in place

> 
> --D
> 
> >  
> >  	ret = fchmodat(destdir->fd, pbuf->path, VFS_I(ip)->i_mode & ~S_IFMT,
> > -			AT_SYMLINK_NOFOLLOW);
> > +			at_flags);
> >  	if (ret) {
> >  		/* fchmodat on a symlink is not supported */
> >  		if (errno == EPERM || errno == EOPNOTSUPP)
> > @@ -169,7 +177,7 @@ rdump_fileattrs_path(
> >  	}
> >  
> >  	ret = fchownat(destdir->fd, pbuf->path, i_uid_read(VFS_I(ip)),
> > -			i_gid_read(VFS_I(ip)), AT_SYMLINK_NOFOLLOW);
> > +			i_gid_read(VFS_I(ip)), at_flags);
> >  	if (ret) {
> >  		if (errno == EPERM)
> >  			lost_mask |= LOST_OWNER;
> > @@ -181,7 +189,17 @@ rdump_fileattrs_path(
> >  			return 1;
> >  	}
> >  
> > -	/* Cannot copy fsxattrs until setfsxattrat gets merged */
> > +	ret = file_setattr(destdir->fd, pbuf->path, NULL, &fa, at_flags);
> > +	if (ret) {
> > +		if (errno == EOPNOTSUPP || errno == EPERM || errno == ENOTTY)
> > +			lost_mask |= LOST_FSXATTR;
> > +		else
> > +			dbprintf(_("%s%s%s: file_setattr %s\n"), destdir->path,
> > +					destdir->sep, pbuf->path,
> > +					strerror(errno));
> > +		if (strict_errors)
> > +			return 1;
> > +	}
> >  
> >  	return 0;
> >  }
> > 
> > -- 
> > 2.49.0
> > 
> > 
> 

-- 
- Andrey


