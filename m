Return-Path: <linux-fsdevel+bounces-63309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EADEFBB48D7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 18:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5EF342353C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 16:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF49A265CB2;
	Thu,  2 Oct 2025 16:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="PnxaBL/W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44A52417C5;
	Thu,  2 Oct 2025 16:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759422874; cv=none; b=ZOpYHFZSILxWwuJyv5FUYwZyB3xrQ8V4bWi4vO+QeaVWyu/4trogkK/KEH0wj7/NFmEvEgYVuhhey6TBe3aNY/guLSui29/D0DuiafXoK6Aw870Q/zLoutiQApc/rhjOOt/HNrhR/HJzYg6h6xT85Ka/v3inhUZPyZ6Eyg3ly04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759422874; c=relaxed/simple;
	bh=y/UoQeiSPNyiZxcLPYRf9bzHn5ME6j4+Au+itf56ig0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b3YnxiKPGXPrVdc9TkPML8HoRLqtacbRvkQqfusDOn1KAHqbfwAV4CKaVhCrfgSRROr5xPtfEcVv3A2u2wkZ38Ar92BmY2XmgnxioioxZdrOyEEIw53s0B9eXccqWQW5p2lm8RxwkNB5mIsDrHM0cDGcWJjeYz7ziDm1i9uUu1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=PnxaBL/W; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2+eyHLnXeUwnNmSwFEEiwmR16Vny4759q83sAIs+XKQ=; b=PnxaBL/W8YyWgvp3j2zzlg5ZuA
	ChZ/YJqHvgt61f1FFud9YX7KolquaYCTr2p56JAvVBBFB1HnsYeClbVZMcFfI4TDPNZ0mcC1aS67w
	rYm8BCWET4PUHhh+O/Eovjv3Pn3Ze5MsHws5pXXRwEB/T0fZIaD9XgB9bmIy3ey/HYxoluw3a6NyY
	KzjJQ9Vm/+okEotydLW751XhGXeGSzumrejTuaf5iXQZQfEBgbrNej2PrJRnQuz/j/dwFi7pnA1DQ
	0opmQXYTXYV48FUR7rSGkiu7EzehojOg0M3blaLHHCmiCtoQomtYNKQl9UhpWyylaoUvCHFgMrc0x
	K6kA0PBg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4MGB-00000003RS3-0sDH;
	Thu, 02 Oct 2025 16:34:27 +0000
Date: Thu, 2 Oct 2025 17:34:27 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Bhavik Sachdev <b.sachdev1904@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Jan Kara <jack@suse.cz>, John Garry <john.g.garry@oracle.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Andrei Vagin <avagin@gmail.com>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>
Subject: Re: [PATCH 2/4] fs/namespace: add umounted mounts to umount_mnt_ns
Message-ID: <20251002163427.GN39973@ZenIV>
References: <20251002125422.203598-1-b.sachdev1904@gmail.com>
 <20251002125422.203598-3-b.sachdev1904@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002125422.203598-3-b.sachdev1904@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Oct 02, 2025 at 06:18:38PM +0530, Bhavik Sachdev wrote:

> @@ -1438,6 +1440,18 @@ static void mntput_no_expire(struct mount *mnt)
>  	mnt->mnt.mnt_flags |= MNT_DOOMED;
>  	rcu_read_unlock();
>  
> +	if (mnt_ns_attached(mnt)) {
> +		struct mnt_namespace *ns;
> +
> +		move_from_ns(mnt);
> +		ns = mnt->mnt_ns;
> +		if (ns) {
> +			ns->nr_mounts--;
> +			__touch_mnt_namespace(ns);
> +		}
> +		mnt->mnt_ns = NULL;
> +	}

Sorry, no.  You are introducing very special locking for one namespace's rbtree.
Not gonna fly.

NAKed-by: Al Viro <viro@zeniv.linux.org.uk>

