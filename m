Return-Path: <linux-fsdevel+bounces-48959-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C422AB6A8E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 13:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDCD8860B30
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 11:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A33A2749E5;
	Wed, 14 May 2025 11:52:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C382749D9
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 11:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747223556; cv=none; b=qsjVdI8arrpQD1euFRI9YCJIvtArXLWXCUuDFv8iYbUtjlZ4NbfUey3FHjK+851buc4t/0fYO9ITrUBt5h2ROl3+tgFlPAzZ+4D+tpzKYwyesC6u8En7yhv+zn6yuTlAs66pOyZjJeGX+OzIm6er4FTtaPLvAEZBrpEPFZu9dtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747223556; c=relaxed/simple;
	bh=pI7OHw+XgKtV3gEI9hZrPZaVBBxpKFZqQrAGBXAQ4HE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZioYNJytmiJDnsjUpkqpJeNHMgH3AD1ahq+kfHhJoz/bwApLHn+Y/8TDPW0DQayeByxb2HGfJ/IeZbsUCU9Ana6+DL046uMWsl7FZDAer4VLfP3Gp6dy3jl/AaK4eFPzGB2xAhC1cYwM1QVr/JXwlXGBj/Th3KpHGRKHMuFacA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-112-151.bstnma.fios.verizon.net [173.48.112.151])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 54EBqBbZ012749
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 07:52:12 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 74E822E00DC; Wed, 14 May 2025 07:52:11 -0400 (EDT)
Date: Wed, 14 May 2025 07:52:11 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: =?utf-8?B?6ZmI5rab5rab?= Taotao Chen <chentaotao@didiglobal.com>
Cc: "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 2/3] ext4: implement IOCB_DONTCACHE handling in write
 operations
Message-ID: <20250514115211.GC9943@mit.edu>
References: <20250421105026.19577-1-chentaotao@didiglobal.com>
 <20250421105026.19577-3-chentaotao@didiglobal.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250421105026.19577-3-chentaotao@didiglobal.com>

On Mon, Apr 21, 2025 at 10:50:30AM +0000, 陈涛涛 Taotao Chen wrote:
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 94c7d2d828a6..787dd152a47e 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -1147,16 +1147,22 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
>  {
>  	struct inode *inode = mapping->host;
>  	int ret, needed_blocks;
> +	int iocb_flag;
>  	handle_t *handle;
>  	int retries = 0;
>  	struct folio *folio;
>  	pgoff_t index;
> +	fgf_t fgp = FGP_WRITEBEGIN;
>  	unsigned from, to;
>  
>  	ret = ext4_emergency_state(inode->i_sb);
>  	if (unlikely(ret))
>  		return ret;
>  
> +	iocb_flag = (int)(uintptr_t)(*fsdata);
> +	if (iocb_flag & IOCB_DONTCACHE)
> +		fgp |= FGP_DONTCACHE;
> +

See my comment against the first patch in this series.  It *should* be
possible to solve the problem just for ext4 by adding this line here:

	*fsdata = (void *)0;

The problem is that it's super-fragile, since how *fsdata gets used
changes at different points in time, so it makes code review and
maintenance more difficult.  (As evidenced by the fact that you missed
this; this is not a criticism on your programming ability, but rather
for the design choise of overloading the use of *fsdata.  This is a
trap that someone else might fall into when doing future code
changes.)

And of course, the question is whether PATCH 1/3 could potentially
break other file systems.  We would need audit all of the other
*_write_begin() functions, and then document this for the sake of
future file system developers that might want to change their
write_begin() function.

This is why my preference would be to add an extra flags paramter to
write_begin(), but that is going to be a lot more work.

Cheers,

						- Ted

