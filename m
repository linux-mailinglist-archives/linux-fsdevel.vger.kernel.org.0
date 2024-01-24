Return-Path: <linux-fsdevel+bounces-8698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F6F83A7A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 12:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AE681C21C04
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 11:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755C74F215;
	Wed, 24 Jan 2024 11:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEbzNase"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D334248CC4;
	Wed, 24 Jan 2024 11:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706095258; cv=none; b=R1/loFe7MHnes42+K4TY0W18+FoABaB6z0UbtK3vWPFRq02Hzi6jOM9IYr6I+IP5AJSR8loABJc00uROhD85YduGcbFjBPvur7baYLrdkL3lP9kBo4xF9RDvn31KNB1DqlfMVItT0DsSPBWSp9qtBrEAnz9k+HFVexnZAgKdKXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706095258; c=relaxed/simple;
	bh=CsWy6omdP5V5hCJ7qYsvOq5EF/UQS9mAmOjM0tsvqfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2qsE3HFGvofZxHfWHlO73+UllJyT7p+slEaQ7x+zqOtIo2VDThF4Vu4f1LPiiFKmChic1afBcQ700y7Xwv2T5aQJPmngIN7nViQSG4YHxnZXdVlzEAbr/GjKZk7CVcQce0oVYOGFZaVDFJe2X4mDg8tgrjho4o96+m3H5Rvffk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEbzNase; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E76A9C43390;
	Wed, 24 Jan 2024 11:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706095258;
	bh=CsWy6omdP5V5hCJ7qYsvOq5EF/UQS9mAmOjM0tsvqfA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UEbzNaseUVscJLggF4Re1nGtYDRig5kswyZ53m9QQcdt2c6qgRa3jIQ5UIea26SLH
	 9SxY6VK72qf1DwH0swN9VELboe30lW/5pDaJZZr0zX6w+autF8IruvrpJzTiRRg84v
	 UNxajxMvPce0I0wgIDxtx0qvo3p8grccWiaPGVhAVGEL5qJzLn6uJ7dZidvyuJfxW5
	 7H6dGSvn+vSzhIH/DaW1M2bnvtDhw/c1mJi8KcY+cIXRrIVs8YeBRojIlhkMo6YmUP
	 E5/FYkn1WIbM4532aZF/7n1XYh/Aj/ShqoCJUkUH2cccc1z3LQt8U+sUklHjU4lPJo
	 T8JQG/AFR45DQ==
Date: Wed, 24 Jan 2024 12:20:52 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Baokun Li <libaokun1@huawei.com>, torvalds@linux-foundation.org, 
	viro@zeniv.linux.org.uk, willy@infradead.org, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/2] fs: make the i_size_read/write helpers be
 smp_load_acquire/store_release()
Message-ID: <20240124-abspaltung-fernab-8f058be5e9bf@brauner>
References: <20240122094536.198454-1-libaokun1@huawei.com>
 <20240122-gepokert-mitmachen-6d6ba8d2f0a8@brauner>
 <20240123185622.ssscyrrw5mjqjdyh@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240123185622.ssscyrrw5mjqjdyh@quack3>

On Tue, Jan 23, 2024 at 07:56:22PM +0100, Jan Kara wrote:
> On Mon 22-01-24 12:14:52, Christian Brauner wrote:
> > On Mon, 22 Jan 2024 17:45:34 +0800, Baokun Li wrote:
> > > This patchset follows the linus suggestion to make the i_size_read/write
> > > helpers be smp_load_acquire/store_release(), after which the extra smp_rmb
> > > in filemap_read() is no longer needed, so it is removed.
> > > 
> > > Functional tests were performed and no new problems were found.
> > > 
> > > Here are the results of unixbench tests based on 6.7.0-next-20240118 on
> > > arm64, with some degradation in single-threading and some optimization in
> > > multi-threading, but overall the impact is not significant.
> > > 
> > > [...]
> > 
> > Hm, we can certainly try but I wouldn't rule it out that someone will
> > complain aobut the "non-significant" degradation in single-threading.
> > We'll see. Let that performance bot chew on it for a bit as well.
> 
> Yeah, over 5% regression in buffered read/write cost is a bit hard to
> swallow. I somewhat wonder why this is so much - maybe people call
> i_size_read() without thinking too much and now it becomes atomic op on
> arm? Also LKP tests only on x86 (where these changes are going to be
> for noop) and I'm not sure anybody else runs performance tests on
> linux-next, even less so on ARM... So not sure anybody will complain until
> this gets into some distro (such as Android).

The LKP thing does iirc. We get reports from them quite often but there's
no way to request a test on a specific branch and get a result in some
timeframe (1 week would already be great) back. That's what I'd really like.

And similar for the build tests from the intel build bot it would be
nice if one could opt-in to get notifications that no performance
regression did indeed happen.

> 
> > But I agree that the smp_load_acquire()/smp_store_release() is clearer
> > than the open-coded smp_rmb().
> 
> Agreed, conceptually this is nice and it will also silence some KCSAN
> warnings about i_size updates vs reads.
> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

