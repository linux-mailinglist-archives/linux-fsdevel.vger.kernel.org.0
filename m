Return-Path: <linux-fsdevel+bounces-37083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E85BC9ED497
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 19:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A764168A81
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 18:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C528B204088;
	Wed, 11 Dec 2024 18:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mO/4ozg6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF38201266;
	Wed, 11 Dec 2024 18:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733941109; cv=none; b=aeLkn0tF64lm0Sq+2x212cYUJ9cAveEDvPC1vQNezRRNkw9Xjz1jrQN3mPEd/eMOd2Pzi+n5iK4Y8EpZSqUIGgkLf6ksGSm3cfjWYWcB3QSWT3Zc0Ns45PY2nD7gUGjcYY6Cbeswra1GXZFk7ciCXYGn36qaoTHPDxV7hnXl9Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733941109; c=relaxed/simple;
	bh=0Ha0iFDk7Ri2O+rZLVr8uvjg5fh5VNVFuhQutjRlXDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7eRfzb10jFgYWlOOj8BxR/dZaP9RlbQPlbr1thMzxIbcRjeHuslqoNEDKQd5aYx7UDZyhh7nvrYD++CVdPP1bHXXC9r9R6UC+SeX6ZN3vpJ5c65XnPCQq37rtw+sFu/rhBW0C6+x/pH2YaNMpqP401S2TsH2kDi6Jp9qLm0NvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mO/4ozg6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8559BC4CED2;
	Wed, 11 Dec 2024 18:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733941107;
	bh=0Ha0iFDk7Ri2O+rZLVr8uvjg5fh5VNVFuhQutjRlXDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mO/4ozg6DJKMCxmeI6euSHEGop6RmQKa5U5tCu4Es5X2566kyxtggE7ev8DMZ6ksE
	 1q9XSOvGt+0U6WImq8H+LhapO2ODdBrrmmjjuMkLurHtNU88dMZnMLxl9dzqMfdOju
	 B3Ya0zfJO+5QWEzDRsc5Xvw+RiEzrvbIeOjtPVbMZDS1fqA8Xk7IZak9kl1rbFQ1LC
	 9yLWAX6riZx1ObNjGP1pxJdhF32gQOk45S+s7yazjq3eF/tns4AncFI1UtX8NLXfB0
	 O3PaV0Fo1QwI0xrD11634AL860vvNi7zzzqfRltn003+YCBq0DhNzOnqDqt+NogEih
	 XzIYCOG2NVxbA==
Date: Wed, 11 Dec 2024 10:18:27 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	Ritesh Harjani <ritesh.list@gmail.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Andrey Albershteyn <aalbersh@kernel.org>,
	John Garry <john.g.garry@oracle.com>
Subject: Re: [RFC 3/3] xfs_io: add extsize command support
Message-ID: <20241211181827.GC6678@frogsfrogsfrogs>
References: <cover.1733902742.git.ojaswin@linux.ibm.com>
 <6448e3adc13eff8b152f7954c838eb9315c91574.1733902742.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6448e3adc13eff8b152f7954c838eb9315c91574.1733902742.git.ojaswin@linux.ibm.com>

On Wed, Dec 11, 2024 at 01:24:04PM +0530, Ojaswin Mujoo wrote:
> extsize command is currently only supported with XFS filesystem.
> Lift this restriction now that ext4 is also supporting extsize hints.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Seems pretty straightforward to me.  Are you planning to add an extsize
option to chattr?

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  io/open.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/io/open.c b/io/open.c
> index a30dd89a1fd5..2582ff9b862e 100644
> --- a/io/open.c
> +++ b/io/open.c
> @@ -997,7 +997,7 @@ open_init(void)
>  	extsize_cmd.args = _("[-D | -R] [extsize]");
>  	extsize_cmd.argmin = 0;
>  	extsize_cmd.argmax = -1;
> -	extsize_cmd.flags = CMD_NOMAP_OK;
> +	extsize_cmd.flags = CMD_NOMAP_OK | CMD_FOREIGN_OK;
>  	extsize_cmd.oneline =
>  		_("get/set preferred extent size (in bytes) for the open file");
>  	extsize_cmd.help = extsize_help;
> -- 
> 2.43.5
> 
> 

