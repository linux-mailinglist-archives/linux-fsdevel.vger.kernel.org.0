Return-Path: <linux-fsdevel+bounces-30426-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EE598B094
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 00:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB13D2826F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 22:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B3018952B;
	Mon, 30 Sep 2024 22:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmK8S4jc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DE421373;
	Mon, 30 Sep 2024 22:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727737123; cv=none; b=lb0O8PM6pyXbScmUtxqZrqbEk82QGlrbEx0cKesCq7mbO3JS//8D0+reg7NaTqiBq4jW5WnMDN0xLnCLDjcJRjbQFMHsiFWxbeS5fG+rFZTh4vXyq1fLN/TA5zTeh8MWLYC9E37prCXaS1ZaIRvCWKk8KxFuAn2j663DtPaOkDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727737123; c=relaxed/simple;
	bh=MFG/hKEGiIm7gD4UtzPR9o5FvknYmjbixdWJbVryyLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2nBDvT0FcTtiCai7eLfDBrAzVS56Dlvnf5ba9laSvlJzs36PSSAPgMhmlmtn/lVxIYNTWfUsrqROcIDPSE6VOBpzdYAz/1i2QMW+qoisDsbGAx/HIOkToRSMW0yo3Ug4OTTVnUdzuLHSDiGMUKPAq0BUyXfMSNJ3DFtJYmiUA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmK8S4jc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 946CFC4CEC7;
	Mon, 30 Sep 2024 22:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727737122;
	bh=MFG/hKEGiIm7gD4UtzPR9o5FvknYmjbixdWJbVryyLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AmK8S4jcmacgW3nxCQGf39B6DLurLzrRW2UoNTUquIt9BYul23uLhgSQF4pSjXlxV
	 SqJfazNTX3FjcWVBLBds7K5/NA9xZGt7Dppv9Ure8AW6fPs70mhaKT9bvFM3M8iHks
	 Ql/pAenPCrTGFr8Ptwhid1l5DT9b+QES/yVzszfJsyOOI1esnUCDooGmQmYUgy6U53
	 2FrKs1em64GBX92a2ZcTDf7I2QJHWzgL/zpNMq8PtgQHcX2q9tz6raha/EtAbugzyv
	 Zh68nAdAwsD4wKclyiyXCn1G3BRCwNSjc4Uqv1LmyzhZtOLNfWX88C5K+0of4z4M3a
	 x8uOUhrp3hmqQ==
Date: Mon, 30 Sep 2024 22:58:39 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	Theodore Ts'o <tytso@mit.edu>, Chao Yu <chao@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Josef Bacik <josef@toxicpanda.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
	akpm@linux-foundation.org, Christian Brauner <brauner@kernel.org>,
	Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.cz>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	cgroups@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, mcgrof@kernel.org,
	gost.dev@samsung.com, linux-doc@vger.kernel.org,
	linux-xfs@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH] fs/writeback: convert wbc_account_cgroup_owner to take a
 folio
Message-ID: <ZvstH7UHpdnnDxW6@google.com>
References: <20240926140121.203821-1-kernel@pankajraghav.com>
 <ZvVrmBYTyNL3UDyR@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvVrmBYTyNL3UDyR@casper.infradead.org>

On 09/26, Matthew Wilcox wrote:
> On Thu, Sep 26, 2024 at 04:01:21PM +0200, Pankaj Raghav (Samsung) wrote:
> > Convert wbc_account_cgroup_owner() to take a folio instead of a page,
> > and convert all callers to pass a folio directly except f2fs.
> > 
> > Convert the page to folio for all the callers from f2fs as they were the
> > only callers calling wbc_account_cgroup_owner() with a page. As f2fs is
> > already in the process of converting to folios, these call sites might
> > also soon be calling wbc_account_cgroup_owner() with a folio directly in
> > the future.
> 
> I was hoping for more from f2fs.  I still don't have an answer from them
> whether they're going to support large folios.  There's all kinds of
> crud already in these functions like:
> 
>         f2fs_set_bio_crypt_ctx(bio, fio->page->mapping->host,
>                         page_folio(fio->page)->index, fio, GFP_NOIO);
> 
> and this patch is making it worse, not better.  A series of patches
> which at least started to spread folios throughout f2fs would be better.
> I think that struct f2fs_io_info should have its page converted to
> a folio, for example.  Although maybe not; perhaps this structure can
> carry data which doesn't belong to a folio that came from the page cache.
> It's very hard to tell because f2fs is so mind-numbingly complex and
> riddled with stupid abstraction layers.

Hah, I don't think it's too complex at all tho, there's a somewhat complexity to
support file-based encryption, compression, and fsverity, which are useful
for Android users. Well, I don't see any strong needs to support large folio,
but some requests exist which was why we had to do some conversion.

> 
> But I don't know what the f2fs maintainers have planned.  And they won't
> tell me despite many times of asking.

