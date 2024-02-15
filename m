Return-Path: <linux-fsdevel+bounces-11626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD04855849
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 01:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D2F7B21A63
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 00:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF5F818;
	Thu, 15 Feb 2024 00:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrK5g6Ne"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1535E19A;
	Thu, 15 Feb 2024 00:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707956666; cv=none; b=jkz9LE8fBE+Z7MhNFxkoDTlgwMfOMB4ozHB4nYp9XNA2PXZ+QCjmlFpWwXd0Upf6ISy91Jkh9bmxp/VgyGjaikyYL7jXD6amu4eVFtRXns/6MpEHkl5o8H69uQZdAsmPDeAAXYYVIwtxr8rVXLJlya6VGAJN79ADzamutIzepTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707956666; c=relaxed/simple;
	bh=59cH34O2OWkKVZjG9GgdkKelHOHZV98dvK1VvoxsuNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uuMd7eYJUiO+OyKAbQYZHr3ZYfU1txlc30yoX/xjmcG9MIEG7+zVvTOTWzc5un9mHVbbOaERxY6+ucpwBlr7I+lYJdZb5374KL/gPO/CHKAqF2zP2QF1GAhzCqZ1dye6KLdodni/pCEDUUjIiQDkCLfjUnx/dyUuD2fq4BiMxLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hrK5g6Ne; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3713FC433C7;
	Thu, 15 Feb 2024 00:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707956665;
	bh=59cH34O2OWkKVZjG9GgdkKelHOHZV98dvK1VvoxsuNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hrK5g6NegFC+QhqrQea4HSmqTdiC9Ka/gx0p2n7jiipIgWksWr24/0BVRwkNjluCO
	 o/mA4cjWmL+WNNbSUwu1cH2syPViHbh7mITciDFdhaMCXuxgQb1c0suVhPiV7ViTp4
	 ncP94sqOe852oIomjyUZT4yz5pxRVbglAV2iZOjOQHcF0MwWecT5ZK+kVShnJlfvNY
	 OykMsWyj4W+fUb6iZ5pVyPKpNc3tVavEbiWfVhg9eOlNlmVArIP5dRJf6RCvhpaXDh
	 oqcrmyOzsFiY7kqCA9BzFxTZCbrJRiQa6bzILtTeVdf4wv05i3k6HPWJd9IJH19vEP
	 KMzA0kaGVqA3g==
Date: Wed, 14 Feb 2024 16:24:23 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: viro@zeniv.linux.org.uk, jaegeuk@kernel.org, tytso@mit.edu,
	amir73il@gmail.com, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, brauner@kernel.org
Subject: Re: [PATCH v6 00/10] Set casefold/fscrypt dentry operations through
 sb->s_d_op
Message-ID: <20240215002423.GJ1638@sol.localdomain>
References: <20240213021321.1804-1-krisman@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213021321.1804-1-krisman@suse.de>

On Mon, Feb 12, 2024 at 09:13:11PM -0500, Gabriel Krisman Bertazi wrote:
> Hi,
> 
> v6 of this patchset applying the comments from Eric and the suggestion from
> Christian. Thank you for your feedback.
> 
> Eric, since this is getting close to merging, how do you want to handle
> it? I will take patch 1 through my tree already, are you fine if I merge
> this through unicode or do you want to take it through fscrypt?
> 
> As usual, this survived fstests on ext4 and f2fs.

I think you should just take the whole series through the unicode tree.

If I understand correctly, this series is really about fixing things for
casefolding support, not fscrypt support, right?  There is a lot of interaction
between the two, but ultimately it's casefold that gets fixed.

- Eric

