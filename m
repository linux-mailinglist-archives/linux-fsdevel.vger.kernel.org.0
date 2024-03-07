Return-Path: <linux-fsdevel+bounces-13934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A44428759DE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 23:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 437C01F22F52
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 22:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3149C13C9DB;
	Thu,  7 Mar 2024 22:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKX9WTDk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B38413B78F;
	Thu,  7 Mar 2024 22:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709848947; cv=none; b=Fp/RG5PfZtBZqP7KgTAxRey3xsnRqdNUQ0RNITIXPBfNKNM6Z22Q9HGvg3NgTLtqm4HjIXGpoNhKp0TCewWuzqVwYQqIRnl4NHy1y89CQ2ofbYzQ3ZOJKvjMdvBJorOTEnqtZhkZITVijEGwiZUsFFnbR41EAZ9o1IJcWpeERC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709848947; c=relaxed/simple;
	bh=6oIjGTLj9qpyepazk9MNzQIaCtzloCGl6gO4O+68Gd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nm7j+3sE7DRNf6ESrVq5B6WYdMJczyZ4NtW3vhLb+UgfJXPKeTredUjb8eNMAayFdoXJo+holw+PmNQJx0Fez8FzusMos7n97RlYewnH49GLczOFrr6DDsC+7a/8NHTvAKBDT1uldxd32zhCD+ncsWhUvQeidqbAg+DF1QOpI7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKX9WTDk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A8CC433C7;
	Thu,  7 Mar 2024 22:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709848946;
	bh=6oIjGTLj9qpyepazk9MNzQIaCtzloCGl6gO4O+68Gd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kKX9WTDkCj4KokbX9TSITkzpNRLNmeee3oaZy0y+opV0AKz9cUQITE7YKF+J6DxaZ
	 6lEtJpniYLnbKa2/RqhEQi1RFu4WTYVO0I4Hi7p109WiVurkeewWzjfdvflyrOZ9QD
	 gg0cMQXBPo6I3dEzJIZ3ZSVhSDpVNq+D6CKJtenJDvEsN4iUt63kEGb/ZvJF/UN5na
	 o3AMuooLDTZu0jeKh5Xb1NogwkCPZpZHl4eeEZQO52LlrcgYnG4DuHOWpvVpVC5gdy
	 uydvETaPPA+uv00N34zZl58MQecK5YRAgYczHGeXDXpOQj4YL4b51Kkg4sYy1LaQD7
	 X9e3TNMf5H2VQ==
Date: Thu, 7 Mar 2024 14:02:24 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com
Subject: Re: [PATCH v5 06/24] fsverity: pass tree_blocksize to
 end_enable_verity()
Message-ID: <20240307220224.GA1799@sol.localdomain>
References: <20240304191046.157464-2-aalbersh@redhat.com>
 <20240304191046.157464-8-aalbersh@redhat.com>
 <20240305005242.GE17145@sol.localdomain>
 <20240306163000.GP1927156@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306163000.GP1927156@frogsfrogsfrogs>

On Wed, Mar 06, 2024 at 08:30:00AM -0800, Darrick J. Wong wrote:
> Or you could leave the unfinished tree as-is; that will waste space, but
> if userspace tries again, the xattr code will replace the old merkle
> tree block contents with the new ones.  This assumes that we're not
> using XATTR_CREATE during FS_IOC_ENABLE_VERITY.

This should work, though if the file was shrunk between the FS_IOC_ENABLE_VERITY
that was interrupted and the one that completed, there may be extra Merkle tree
blocks left over.

BTW, is xfs_repair planned to do anything about any such extra blocks?

- Eric

