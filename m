Return-Path: <linux-fsdevel+bounces-60335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B17B4511F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 10:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAFC47A27A5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 08:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892342FB626;
	Fri,  5 Sep 2025 08:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdN+o1B+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA49D13E898;
	Fri,  5 Sep 2025 08:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757060277; cv=none; b=Y9zl3V+uLxNdV+EY+kGDRoCruw5R+vfkX/1YzoGDT0SdzF1n4H6Sp86tJ9ShGdMou1MSs//vLmVvaNyAvur9lBVETZhOUIyTcrwsaG/OAsVJ60l4vE+DvjFk1hHQPpfxx3GElDtW0nO/Z+xW/AI5OwxcxWXxXUJpY+yYwLmeVaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757060277; c=relaxed/simple;
	bh=y9VH9c1nH0kxxxroJ0e7TZw+lVlM7zSLrtdSOs2uKac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XqbOLKvcM3X1RjleFu9FyRR5UPqstU+Z6004prJy10HZfiG9xEze2kNq2lBYC3wFSxh1bt2M/AOAgFGku0TyTV016XhxXojLG4X/Wx/8v8As04JLr2bQJzALJFL2krgNFujLyTH7f0q+j9t2NE0aaWYjIyjscIPTG2m6QNEi/Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdN+o1B+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3CCC4CEF1;
	Fri,  5 Sep 2025 08:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757060276;
	bh=y9VH9c1nH0kxxxroJ0e7TZw+lVlM7zSLrtdSOs2uKac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kdN+o1B+lV/nwhlHDkaeB/Yyd3W0xvtHeZdYOYPEDKyYqZugeXHsHO+40xiVSBf70
	 xujWeNE4LXCe1mwMTCxqgCENABhRjZKmeLFMX1N3ti/K+Zf9QQQzhHzHYv/z8/YONx
	 HRdLa4a9gW8ZEFqpONxapCtzryqu4zk0s85xFcgYcEtCufnzeebjkY48QnrBTO6r5o
	 nLIhjA8qB/pKGgCEGq2bjRqNZAStEu7/lWas6JBlMZ/g914BpUgjd1JHZn1UfvsR1Y
	 RuWjOCqnVzMwvumm/iHv+rVxGnDauY7y33sSki4G0ld+R3X61ZT8NORwDSgTUF47g/
	 L7cazTTK/QibA==
Date: Fri, 5 Sep 2025 10:17:51 +0200
From: Carlos Maiolino <cem@kernel.org>
To: Hans Holmberg <Hans.Holmberg@wdc.com>
Cc: "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, 
	Dave Chinner <david@fromorbit.com>, "Darrick J . Wong" <djwong@kernel.org>, hch <hch@lst.de>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	brauner@kernel.org
Subject: Re: [PATCH 1/3] fs: add an enum for number of life time hints
Message-ID: <gzj54cob33ecyfdabfbvci7nj7gl5sc2cbujpkg6qax7vgoph2@3ubnb4d2dfim>
References: <20250901105128.14987-1-hans.holmberg@wdc.com>
 <kcwEWPeEOk9wQLfYFJ-h2ttYjtf0Wq-SjdLpIAqoJzT3jysu_U4uhYJj1RZys6tWgxVKxq833URcLKj-5faenA==@protonmail.internalid>
 <20250901105128.14987-2-hans.holmberg@wdc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901105128.14987-2-hans.holmberg@wdc.com>

On Mon, Sep 01, 2025 at 10:52:04AM +0000, Hans Holmberg wrote:
> Add WRITE_LIFE_HINT_NR into the rw_hint enum to define the number of
> values write life time hints can be set to. This is useful for e.g.
> file systems which may want to map these values to allocation groups.
> 
> Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>

Cc'ing Chris Brauner here, as I think he is who will be picking this up.

The other two can go through XFS tree.

> ---
>  include/linux/rw_hint.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/rw_hint.h b/include/linux/rw_hint.h
> index 309ca72f2dfb..adcc43042c90 100644
> --- a/include/linux/rw_hint.h
> +++ b/include/linux/rw_hint.h
> @@ -14,6 +14,7 @@ enum rw_hint {
>  	WRITE_LIFE_MEDIUM	= RWH_WRITE_LIFE_MEDIUM,
>  	WRITE_LIFE_LONG		= RWH_WRITE_LIFE_LONG,
>  	WRITE_LIFE_EXTREME	= RWH_WRITE_LIFE_EXTREME,
> +	WRITE_LIFE_HINT_NR,
>  } __packed;
> 
>  /* Sparse ignores __packed annotations on enums, hence the #ifndef below. */
> --
> 2.34.1
> 

