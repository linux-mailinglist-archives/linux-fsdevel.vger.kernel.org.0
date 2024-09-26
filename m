Return-Path: <linux-fsdevel+bounces-30188-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCB4987773
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 18:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55318B2696C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 16:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CC215B10E;
	Thu, 26 Sep 2024 16:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BtcMOiNb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276BF34CC4;
	Thu, 26 Sep 2024 16:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727367565; cv=none; b=SRAG4z8lWQWz1XV08IfR4Iw2gFP9YKcWWTVzbkdQ6xKEhEY4GDTmYads+1Xy0yEtWrBGPqYseQgNPqvRAnZ7h2GwV6HOXkeUVzf0GH2UU4wTktLKooOhd+MuG3qFbL82So4Md1AW6Tq4ezi5aBv9akfgOioZFZpp96hOtlrALuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727367565; c=relaxed/simple;
	bh=lqXmhMEXuZKcNpBi/56TghcTSSMM2Wi1sUMY+o2nTWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fbnu8uPVPQ63XMkuOM/UYTBkSYPPc9NiKo9ORcTwuymIaLRSpTiDf+3eKgOawFF8A7xVuZWb5eUoVdvaikCrMBw2H2JDfehXlRyywat7FfZ90YveQFIWgeDaKKP+muMGCS+Os0hXLgsch1N5qXzltl0pWqXOtpO0iLriV+5MCyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BtcMOiNb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD817C4CEC5;
	Thu, 26 Sep 2024 16:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727367564;
	bh=lqXmhMEXuZKcNpBi/56TghcTSSMM2Wi1sUMY+o2nTWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BtcMOiNb/9SmfFSSi/zUiW/TWgAPJ3p6Us5pPzmDB0PGq6xxSKB82IIHHbnFIFE6L
	 xWmHcSFWdTxpmSYgzhjgK1Q9juzsfMnqicS31CNyR7eJolSZCElsQ05PiCPmW0mlOY
	 I12iukt5rTiHGJZgUqzQeljNJORYRJ8nm15fgLyuo+iM5fRD/Gebl41T47t1aoxBtM
	 FIg49JKG71a6fLQONoo5jfcuu493Edjp7UVvBI3lPAHEU5fDk8AcDO9AOuqAUncX1K
	 mdhk8p+G3EjlGTzBn8A1yhDbs82Z6qma2s22OYIKBJG+bfKVfwv6ISbxlOjf5D1qCL
	 UJGSe2etyLwMw==
Date: Thu, 26 Sep 2024 06:19:23 -1000
From: Tejun Heo <tj@kernel.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Chao Yu <chao@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, willy@infradead.org,
	Josef Bacik <josef@toxicpanda.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>, akpm@linux-foundation.org,
	Christian Brauner <brauner@kernel.org>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	cgroups@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, mcgrof@kernel.org,
	gost.dev@samsung.com, linux-doc@vger.kernel.org,
	linux-xfs@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH] fs/writeback: convert wbc_account_cgroup_owner to take a
 folio
Message-ID: <ZvWJiyEREyfZN-NW@slm.duckdns.org>
References: <20240926140121.203821-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926140121.203821-1-kernel@pankajraghav.com>

On Thu, Sep 26, 2024 at 04:01:21PM +0200, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> Most of the callers of wbc_account_cgroup_owner() are converting a folio
> to page before calling the function. wbc_account_cgroup_owner() is
> converting the page back to a folio to call mem_cgroup_css_from_folio().
> 
> Convert wbc_account_cgroup_owner() to take a folio instead of a page,
> and convert all callers to pass a folio directly except f2fs.
> 
> Convert the page to folio for all the callers from f2fs as they were the
> only callers calling wbc_account_cgroup_owner() with a page. As f2fs is
> already in the process of converting to folios, these call sites might
> also soon be calling wbc_account_cgroup_owner() with a folio directly in
> the future.
> 
> No functional changes. Only compile tested.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

From cgroup writeback POV:

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

