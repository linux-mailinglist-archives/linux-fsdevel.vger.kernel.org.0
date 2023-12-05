Return-Path: <linux-fsdevel+bounces-4818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EB6804375
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 01:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 469D71C20998
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 00:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CD74A02
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 00:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Wj8UeFAm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A236107
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Dec 2023 16:20:22 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1d0aaa979f0so10416175ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Dec 2023 16:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1701735621; x=1702340421; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0S1UEF2YyAX6G3igmkROaOCkVf7zG8Kt7ZNcHaiM/7U=;
        b=Wj8UeFAmWnHXto01ei01WM0JspO9IHHCz8ce+MzVTCOzE7VIrTthCxv0PSOBrkv1ee
         T5oP3NByIftdornUyof1njAElMthRK2qGs/92mGvcj+qyp1cqhmG57fSCwlpaO9LPJli
         ET7pb0aCt1W3fCp040KJvc3DZoKUW8Kg8DG4WAUBXe6sFLHwr75lqiCtAO0/jWu1Fawh
         ArZvYb5qLBb03fL0zz8xA1TZiAcL4el+eeOVHnCAEw7UosOWd6Midapj6gtHeOhyMufJ
         Mh/UnSxYwC1CaFtt139Otx9auWbe5EF0RJMrOkLsfd22eIXOONjPycjOYwa9QnMHqmq0
         PAaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701735621; x=1702340421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0S1UEF2YyAX6G3igmkROaOCkVf7zG8Kt7ZNcHaiM/7U=;
        b=GrJAN/Ppi3uDSiTZCyL8WJ7lNuDtaXuosTZYmkv/0DvAjP8hbrva5IWIRRJJg6h48e
         hOuT4fJDzX0n4r3Bov8ep7DvFW97twe71le4SyYgMAm+T5iHvuP8ttPsoOEvOplC7cKz
         N3/6m1sBioUPRykGXRTeqmNgRKmp05BdW51wuluVfC2fM4HZLRtNzfIWaMq5D/lh6fKX
         w+fiEkq+yxsTAraKlZyE8XqSp1Q6UQVCCdJ7cFwxWLKMT6yxeWpmhljr7jULCJZg2uc6
         Klg8G/1xVAXeip0OYzKINqbozgWqvffS7Ry/IEvNmMkNpjObh7Nv5bmN/xqIgZNqk97H
         3R4Q==
X-Gm-Message-State: AOJu0YynnIOf0AMBZtk280p/YnuhVUX41cl5KeI9mCQIUYGeFHk/gPea
	ybXKtf5bYJ6gsg+c+bg6RJH5wA==
X-Google-Smtp-Source: AGHT+IG6o4lI52BlB5GUEIT3TVt2J+H+u5Y/PhuRO647sp9sdHbA3yjRuBLu7rfx91DSE0IxdNRvqw==
X-Received: by 2002:a17:902:988c:b0:1d0:6ffd:ae22 with SMTP id s12-20020a170902988c00b001d06ffdae22mr1930912plp.137.1701735621280;
        Mon, 04 Dec 2023 16:20:21 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id h5-20020a170902748500b001d0b410271fsm1785149pll.218.2023.12.04.16.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 16:20:20 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rAJAf-003x1T-2z;
	Tue, 05 Dec 2023 11:20:17 +1100
Date: Tue, 5 Dec 2023 11:20:17 +1100
From: Dave Chinner <david@fromorbit.com>
To: David Howells <dhowells@redhat.com>
Cc: Steve French <sfrench@samba.org>,
	Xiaoli Feng <fengxiaoli0714@gmail.com>,
	Shyam Prasad N <nspmangalore@gmail.com>,
	Rohith Surabattula <rohiths.msft@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Darrick Wong <darrick.wong@oracle.com>, fstests@vger.kernel.org,
	linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cifs: Fix non-availability of dedup breaking generic/304
Message-ID: <ZW5swS8fUXFIeu1F@dread.disaster.area>
References: <250053.1701698519@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <250053.1701698519@warthog.procyon.org.uk>

On Mon, Dec 04, 2023 at 02:01:59PM +0000, David Howells wrote:
> Deduplication isn't supported on cifs, but cifs doesn't reject it, instead
> treating it as extent duplication/cloning.  This can cause generic/304 to go
> silly and run for hours on end.

This should also mention that it cloning rather than comparing data
can cause server-side data corruption in the destination file for
the benefit of anyone trying to track down weird data corruption
problems....

> Fix cifs to indicate EOPNOTSUPP if REMAP_FILE_DEDUP is set in
> ->remap_file_range().
> 
> Note that it's unclear whether or not commit b073a08016a1 is meant to cause
> cifs to return an error if REMAP_FILE_DEDUP.
>
> Fixes: b073a08016a1 ("cifs: fix that return -EINVAL when do dedupe operation")
> Suggested-by: Dave Chinner <david@fromorbit.com>
> cc: Steve French <sfrench@samba.org>
> cc: Xiaoli Feng <fengxiaoli0714@gmail.com>
> cc: Shyam Prasad N <nspmangalore@gmail.com>
> cc: Rohith Surabattula <rohiths.msft@gmail.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: Darrick Wong <darrick.wong@oracle.com>
> cc: fstests@vger.kernel.org
> cc: linux-cifs@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> Link: https://lore.kernel.org/r/3876191.1701555260@warthog.procyon.org.uk/
> ---
>  fs/smb/client/cifsfs.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
> index 4d8927b57776..96a65cf9b5ec 100644
> --- a/fs/smb/client/cifsfs.c
> +++ b/fs/smb/client/cifsfs.c
> @@ -1276,7 +1276,9 @@ static loff_t cifs_remap_file_range(struct file *src_file, loff_t off,
>  	unsigned int xid;
>  	int rc;
>  
> -	if (remap_flags & ~(REMAP_FILE_DEDUP | REMAP_FILE_ADVISORY))
> +	if (remap_flags & REMAP_FILE_DEDUP)
> +		return -EOPNOTSUPP;
> +	if (remap_flags & ~REMAP_FILE_ADVISORY)
>  		return -EINVAL;
>  
>  	cifs_dbg(FYI, "clone range\n");

Apart from updating the commit message, the fix looks fine to me.

Reviewed-by: Dave Chinner <dchinner@redhat.com>
-- 
Dave Chinner
david@fromorbit.com

