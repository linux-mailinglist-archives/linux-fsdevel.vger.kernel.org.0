Return-Path: <linux-fsdevel+bounces-13558-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69872870FB0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 23:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 253C8283421
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 22:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95E07B3D8;
	Mon,  4 Mar 2024 22:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Do90Iayl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2541C6AB
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Mar 2024 22:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709589755; cv=none; b=clxjzCiSibT/wOl6UD4kpXEdK/9Y9vSgoxoClNKIYEkVJjTsp52CbCFd8IL8b9xyzSBmDES2UWScJ5K+iJwDtVvU9thgqu4MC62OO5rtWx64hQpFLBVxQvrqJQS44gBMmNS7mHnWDanrm0pSQwJGpPy4LmpyfomlzkrkaziKtnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709589755; c=relaxed/simple;
	bh=PxgCv1xzZmhxk+5KTIdHqPhvX38K1jPFDD1q6fBjSeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fYKTbRCDo92Sbq2/ujChtIDu+uq7cg9/ngOQM+0jA7XAcd7Vjd5DnzdbltIg2S0hUL5SM+E0W9eG/GBmcp+SxO1TSc/nh9OaNXY2kMhP1ZEBFFEa8Hdj/M6G7bgpE6P6hx7BkOx0U83K1VGFACUGEKPnNRF4WPiMmBiOUfqAaY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=Do90Iayl; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5dbcfa0eb5dso4665200a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Mar 2024 14:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1709589753; x=1710194553; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UPT7qKYJtYEG14x2vaIsLF4YqSY7OCBjPVkjFmTBKcA=;
        b=Do90Iayl87GoPEWahOTVj8Y1dE3h4eIpO+WzO9RuCdYlzzhrWOtrIzvsr00lXqHKdf
         cnd6UovWA4OKcVIRijG8s00r1uyH8IsCZ9O6OEOqxAiQjHY36FOu4BCym3d3jrTTRFNP
         xjqYBzoKacEr1MgGVI+AoqUhWUKA8vmWLkOAUqbQ52Uw4t8ZL8JcjC52wfyCzDA2l6Yq
         1M1atTJyEnU/bMUZ6qPLJpwNT08lzmVmZCMLcPVVw+L8QqVaLkvDCQQVzmGsGN1lyAAe
         FEHH1nhjruZBYF0jdMmIVQir++ZWCtNUp7bXrSqvkTDRrIluLdp6z6B7seYICeFKjXkx
         Wf2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709589753; x=1710194553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UPT7qKYJtYEG14x2vaIsLF4YqSY7OCBjPVkjFmTBKcA=;
        b=Nu7fPPMg0Sqva0I3fQIj5Dw3dBwJZ6R3O7Wi9iFj9lfrPcd87RpX+9RqbSktIWnK+8
         pxyNpAzj/iwVK+pQtwHCbyXWIN6WnplEnzpL95IY+bZYHGDlEc5YiWwA3694jlqCBxSf
         7E7Wn23mveFNAJTgzJYdvoWy8NzuXGTKqCnXtA7gg+64eH+cJD5fqo9e/aq4n7C75Xhj
         50EvptAzDjSv17w5J+AHaNn8VOQO7B5XOWKCi2ZIo0OXdYFAzzLs38M9XLC+tjLW5jR8
         fSfc8voG3xgTfBInUtmB2VP+nTxXbEv27x0NQP/S+RC26dvBkBsCWNu1Iy+x6HxIFhx2
         BEFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxseWWFDKiJddpjuPK8Zkx53RzlkGF0Thd2+BVivfmnqZyuRLlWLBgo6U+5jyCfqoLMvGQwzR9nnsjCaEZiP+lRag0m4Jzk6hwVLOUKw==
X-Gm-Message-State: AOJu0YwPjeeEeQ+CG52NAPGX2VvsQTTOVcuMQ2Qdn8Hazl6bF6zebjkb
	Ux5UlKHv0e2VdoCsYC9DQtWUHT/2vhTzOIMNZNfFgTdRX7FL4wE7grqVNaNN/dU=
X-Google-Smtp-Source: AGHT+IGDKaW+p6accsX8sBx9qWgSKW+7eoGdeRhzoClzdXXlDHiVc8S03Pq0PKUsaAYZVYzRmItX2Q==
X-Received: by 2002:a17:90a:ca8e:b0:29b:4dfc:7107 with SMTP id y14-20020a17090aca8e00b0029b4dfc7107mr3360884pjt.38.1709589752932;
        Mon, 04 Mar 2024 14:02:32 -0800 (PST)
Received: from dread.disaster.area (pa49-181-192-230.pa.nsw.optusnet.com.au. [49.181.192.230])
        by smtp.gmail.com with ESMTPSA id q14-20020a17090aa00e00b0029b32b85d3dsm4730701pjp.29.2024.03.04.14.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 14:02:32 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rhGOD-00F5Fv-1r;
	Tue, 05 Mar 2024 09:02:29 +1100
Date: Tue, 5 Mar 2024 09:02:29 +1100
From: Dave Chinner <david@fromorbit.com>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com, djwong@kernel.org
Subject: Re: [PATCH] xfs: allow cross-linking special files without project
 quota
Message-ID: <ZeZE9WtwyQq988yb@dread.disaster.area>
References: <20240304155013.115334-2-aalbersh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304155013.115334-2-aalbersh@redhat.com>

On Mon, Mar 04, 2024 at 04:50:14PM +0100, Andrey Albershteyn wrote:
> There's an issue that if special files is created before quota
> project is enabled, then it's not possible to link this file. This
> works fine for normal files. This happens because xfs_quota skips
> special files (no ioctls to set necessary flags). The check for
> having the same project ID for source and destination then fails as
> source file doesn't have any ID.
> 
> mkfs.xfs -f /dev/sda
> mount -o prjquota /dev/sda /mnt/test
> 
> mkdir /mnt/test/foo
> mkfifo /mnt/test/foo/fifo1
> 
> xfs_quota -xc "project -sp /mnt/test/foo 9" /mnt/test
> > Setting up project 9 (path /mnt/test/foo)...
> > xfs_quota: skipping special file /mnt/test/foo/fifo1
> > Processed 1 (/etc/projects and cmdline) paths for project 9 with recursion depth infinite (-1).
> 
> ln /mnt/test/foo/fifo1 /mnt/test/foo/fifo1_link
> > ln: failed to create hard link '/mnt/test/testdir/fifo1_link' => '/mnt/test/testdir/fifo1': Invalid cross-device link
> 
> mkfifo /mnt/test/foo/fifo2
> ln /mnt/test/foo/fifo2 /mnt/test/foo/fifo2_link
> 
> Fix this by allowing linking of special files to the project quota
> if special files doesn't have any ID set (ID = 0).

Reasonable.

> Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> ---
>  fs/xfs/xfs_inode.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> index 5ca561634164..641270f4d794 100644
> --- a/fs/xfs/xfs_inode.c
> +++ b/fs/xfs/xfs_inode.c
> @@ -1232,11 +1232,24 @@ xfs_link(
>  	 * the tree quota mechanism could be circumvented.
>  	 */
>  	if (unlikely((tdp->i_diflags & XFS_DIFLAG_PROJINHERIT) &&
> +		     !special_file(VFS_I(sip)->i_mode) &&
>  		     tdp->i_projid != sip->i_projid)) {
>  		error = -EXDEV;
>  		goto error_return;
>  	}
>  
> +	/*
> +	 * Don't allow cross-linking of special files. However, allow
> +	 * cross-linking if original file doesn't have any project.
> +	 */

The comment should explain why the code exists, not document what
the code does.

> +	if (unlikely((tdp->i_diflags & XFS_DIFLAG_PROJINHERIT) &&
> +				special_file(VFS_I(sip)->i_mode) &&
> +				sip->i_projid != 0 &&
> +				tdp->i_projid != sip->i_projid)) {
> +		error = -EXDEV;
> +		goto error_return;
> +	}

I think this would be better written as:

	/*
         * If we are using project inheritance, we only allow hard link
         * creation in our tree when the project IDs are the same; else
         * the tree quota mechanism could be circumvented.
         */
	if ((tdp->i_diflags & XFS_DIFLAG_PROJINHERIT) &&
	    tdp->i_projid != sip->i_projid) {
		/*
		 * Project quota setup skips special files which can
		 * leave inodes in a PROJINHERIT directory without a
		 * project ID set. We need to allow links to be made
		 * to these "project-less" inodes because userspace
		 * expects them to succeed after project ID setup,
		 * but everything else should be rejected.
		 */
		if (!special_file(VFS_I(sip)->i_mode) ||
		    sip->i_projid != 0) {
			error = -EXDEV;
			goto error_return;
		}
	}

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com

