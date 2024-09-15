Return-Path: <linux-fsdevel+bounces-29397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39086979502
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Sep 2024 09:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8CE2B22C79
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Sep 2024 07:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062282556E;
	Sun, 15 Sep 2024 07:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="f+XCFuOk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21955DDCD;
	Sun, 15 Sep 2024 07:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726385021; cv=none; b=NoU6KrkzUx4QcyFT7ymJ9c0OU9plnO4t0Y3CW8lXUgEuRM/PzZ3TxrnATkxb6ukKIiSYcxeKWhG5EZOQyhydmbfm8PtX0oyk67RmUYeLphQfH4ly23H7RLa2w+98+CWgYH5VtUqEYe+gOPIKAfOXhctVFMxWe68rlmtF5Xr2xRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726385021; c=relaxed/simple;
	bh=/LN6+rKNmoQGtTt0uFoyaZGtZos5cWCC3ZF3U9Kp/Dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d28lC2PWE5CUhIMy9gDM4JMIYmXRvxqta7yLljtB+nqgPSYXWKOBgEnRkJ+sEbC87SIkqg5rZh4LjrJt2hkAxKJRr5veh+yT9TJ9c804iaxm/SeuvWbDlE3DWOsSJxWRjhimliXrUWmMibNSFfP1kpsXzR/jnnzTtrWPbOu6P5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=f+XCFuOk; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OLy4GDrTHMAiWDjgfJFwNqFOV+uatM8nRA6OZdxf68E=; b=f+XCFuOkbxtwqUDSweJNUGWw2t
	niJW5Q7et1z2OcXZCl3Ck2flEKK1bWRnPw+XazNvtN62tNujQMqLU2q2rIjs2xwalcrOzIdfMIO3M
	NkxCRxcXmoS2Xm6FkA7XSsOwldFz3XXgbUgh+UGnpzb9MJxldW91J0OR5EEAhyuZM6ue3VrnE5dDW
	CKKlOLgsVA+ptdzL+D6jyGx9ub6XBImVRHwEqeXTosIgecKosBL0LM7k6WPHs937Agy6l9TBd/nc0
	BkX6Y/GpbFJWVaqaOPKk4m/6bNbbmx/JW/yUZ+zSZ761TRQZN1pSTL2EbPGJRDzm9TVXjvaP+bjQp
	0sgZHXlQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1spjbc-0000000Cci7-1tB0;
	Sun, 15 Sep 2024 07:23:36 +0000
Date: Sun, 15 Sep 2024 08:23:36 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Daniel Yang <danielyangkang@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+e1c69cadec0f1a078e3d@syzkaller.appspotmail.com
Subject: Re: [PATCH] fs/exfat: resolve memory leak from
 exfat_create_upcase_table()
Message-ID: <20240915072336.GF2825852@ZenIV>
References: <20240915064404.221474-1-danielyangkang@gmail.com>
 <20240915070546.GE2825852@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240915070546.GE2825852@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Sep 15, 2024 at 08:05:46AM +0100, Al Viro wrote:

> 	Interesting...  How does the mainline manage to avoid the
> call of exfat_kill_sb(), which should call_rcu() delayed_free(), which
> calls exfat_free_upcase_table()?
> 
> 	Could you verify that your reproducer does *NOT* hit that
> callchain?  AFAICS, the only caller of exfat_load_upcase_table()
> is exfat_create_upcase_table(), called by __exfat_fill_super(),
> called by exfat_fill_super(), passed as callback to get_tree_bdev().
> And if that's the case, ->kill_sb() should be called on failure and
> with non-NULL ->s_fs_info...
> 
> 	Something odd is going on there.

	Yecchh...  OK, I see what's happening, and the patch is probably
correct, but IMO it's way too subtle.  Unless I'm misreading what's
going on there, you have the following:
	exfat_load_upcase_table() have 3 failure exits.

One of them is with -ENOMEM; no table allocated and we proceed to
exfat_load_default_upcase_table().

Another is with -EIO.  In that case the table is left allocated, the
caller of exfat_load_upcase_table() returns immediately and the normal
logics in ->kill_sb() takes it out.

Finally, there's one with -EINVAL.  There the caller proceeds to
exfat_load_default_upcase_table(), which is where the mainline leaks.
That's the case your patch adjusts.

Note that resulting rules for exfat_load_upcase_table()
	* should leave for ->kill_sb() to free if failing with -EIO.
	* should make sure it's freed on all other failure exits.

At the very least that needs to be documented.  However, since the
problem happens when the caller proceeds to exfat_load_default_upcase_table(),
the things would be simpler if you had taken the "need to free what we'd
allocated" logics into the place where that logics is visible.  I.e.

                        ret = exfat_load_upcase_table(sb, sector, num_sectors,
                                le32_to_cpu(ep->dentry.upcase.checksum));

                        brelse(bh);
                        if (ret && ret != -EIO) {
				/* clean after exfat_load_upcase_table() */
				exfat_free_upcase_table(sbi);
                                goto load_default;
			}
IMO it would be less brittle that way.  And commit message needs
the explanation of the leak mechanism - a link to reporter is
nice, but it doesn't explain what's going on.

