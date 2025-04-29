Return-Path: <linux-fsdevel+bounces-47600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB4EAA0F2D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 16:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FE101A826F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 14:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7880F218AC8;
	Tue, 29 Apr 2025 14:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRyZ9rE3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB1B2163A0;
	Tue, 29 Apr 2025 14:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745937528; cv=none; b=hmI1OQvqICLy3iM0P9SxV9NfkHgzD8U2KJCLAh1pJpmLTXmctFD3scmiWcUw1HWBl0tik5wgG46S0MBRXerJeQkZble1/tBnMRHXJeTvvxBAH9BOrUkLyneAGGcGWMfPmK+GfebBOOHWcXlq1i7Kw1nL7aerQ1zK+YerfdxwM8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745937528; c=relaxed/simple;
	bh=kZjoUjt4BR6vPfSrpHj0Lg/HIVD3ZWL+zVGn7l59AbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yx9ZDoZMNRuZb2G0jvRR27IDkbvBfQeSZxclqs0ycg5Gz7bNexa+qRhR4eB2i2A+QsuNUBEM2nZkj0tAJrVgW6WiHOOQ1JLjVXhyludK6fBNHgcReWrL0RjO+cU62xuZ0T3JGE65Kn6z47b6ggTCPYFIFQ1n608lwokC1wA5Fts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BRyZ9rE3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618DFC4CEE3;
	Tue, 29 Apr 2025 14:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745937528;
	bh=kZjoUjt4BR6vPfSrpHj0Lg/HIVD3ZWL+zVGn7l59AbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BRyZ9rE3f4fbT4LnQMwNFbP6EQrMEoABbqfy7/Df7fT7KBqdg1FlZppyWExOEtlMY
	 E9BQaSxZWJW3tQut/x7QiKf39Z/fK/zvCUA8Nva4s/XKsKUx05WDrQN7jBoTA6lKeJ
	 u9OwkjDV+eOWwD3U9tTSvqSTaRIrbm9HF1G00SVBgRrB7+WP5TarDg2zcWlX13sCoW
	 puL+IDASQBDh3yFhTglld7Ju7Zw8rdlKM/5Z/dJZqgEkcFGUS+TW89jrIk0ND51mN6
	 0SmInBfQ2l/XIH2zy02rKNzW29vgEO5UqftsfV4nWTzlG4N9tCZl98pN0NnaEehNuY
	 s/Nz9Q94Gk/QA==
Date: Tue, 29 Apr 2025 07:38:47 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: John Garry <john.g.garry@oracle.com>, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, cem@kernel.org,
	linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v9 15/15] xfs: allow sysadmins to specify a maximum
 atomic write limit at mount time
Message-ID: <20250429143847.GC25655@frogsfrogsfrogs>
References: <20250425164504.3263637-1-john.g.garry@oracle.com>
 <20250425164504.3263637-16-john.g.garry@oracle.com>
 <20250429122211.GB12603@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429122211.GB12603@lst.de>

On Tue, Apr 29, 2025 at 02:22:11PM +0200, Christoph Hellwig wrote:
> So I guess the property variant didn't work out based on the replies
> from Darrick last round?

Correct.  Calling setxattr on the property wouldn't call
xfs_set_max_atomic_write_opt to change the operational limit, and I
don't want to start up the whole magic xattrs discussion again by making
xfs_xattr_set do extra things if name=="trusted.xfs:max_atomic_write".

(Though iirc you were the most opposed to magic xattrs, and my
opposition is 45% yuck factor and 55% "hch will nak it anyway" ;) )

--D

