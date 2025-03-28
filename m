Return-Path: <linux-fsdevel+bounces-45202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D7AA7498C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 12:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8ECE87A6B82
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 11:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C95F21ABDE;
	Fri, 28 Mar 2025 11:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcX0qI+l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71B779CF;
	Fri, 28 Mar 2025 11:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743162995; cv=none; b=DIkxIpojNLcufH7GYHr30V0LJzP0NAc1IWZObiYxOKXRKL9nqLtzpsF9Sn19kfgcjrgX9XtIxZHg0iLojvhbilhM/jy6b5KgbrCw/A8ZUa9gE55fIra1/SGFNYVuhv4wz2H+8Cw6CvU3j1/P5wG5vPN1+m5nFQfXmsr3sYaK56g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743162995; c=relaxed/simple;
	bh=52MwTZJZU0wxVz6g+/oh+9uTD1hcfXzwEj1eTsBI9zc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XX1k/lN2nU/kdEiyLsO6YZb3CVnOx8KMa7fQZwct74AoPmAJZ3cFDB14vIExp+bnXRToY55dsoHJczmj7ipQA/HtNIV9batrRO72Mq027wILzJ0ue5nxN4fpC4fXWrdh+hkGypSXzNeRZiMO0Yo6PZJrMG9bldVID5EtU+tiPPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcX0qI+l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A269C4CEE4;
	Fri, 28 Mar 2025 11:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743162995;
	bh=52MwTZJZU0wxVz6g+/oh+9uTD1hcfXzwEj1eTsBI9zc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IcX0qI+lgYeFCMWshqIBCvAHI9PF+s3Vrehln+gBxm1AzA2M2JDldgYyI3ogCIf6r
	 752uzaT5i/+pMGVnTxRvNKUUMjJ1ugH1U9oNMA7Vxo8BzGZYVr9/qpXoy/aORAtYYB
	 YrpGdCE2E1enaR+IypIG407HTBVUZmnaT+5g37iDp1xCCsA8e5aXdcS/kFzGrTL3CO
	 yWU8uqwaZqzi607FoCtasILxfEj1HXIehiXliZEqAc+7x0kLDSeVVoHmYKMM3MAGgI
	 w2f5k3mN2lEKP5ZSGOdYGmBGKvVw703d42z6BziIP8Ilcr2yAZ+xXIBgocme3C/vl+
	 cOnJIOOl+8QlQ==
Date: Fri, 28 Mar 2025 12:56:29 +0100
From: Christian Brauner <brauner@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mcgrof@kernel.org, jack@suse.cz, hch@infradead.org, david@fromorbit.com, 
	rafael@kernel.org, djwong@kernel.org, pavel@kernel.org, peterz@infradead.org, 
	mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com
Subject: Re: [RFC PATCH 3/4] fs/super.c: introduce reverse superblock
 iterator and use it in emergency remount
Message-ID: <20250328-estrich-kaleidoskop-c677a5a3f551@brauner>
References: <20250327140613.25178-1-James.Bottomley@HansenPartnership.com>
 <20250327140613.25178-4-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250327140613.25178-4-James.Bottomley@HansenPartnership.com>

On Thu, Mar 27, 2025 at 10:06:12AM -0400, James Bottomley wrote:
> Originally proposed by Amir as an extract from the android kernel:
> 
> https://lore.kernel.org/linux-fsdevel/CAA2m6vfatWKS1CQFpaRbii2AXiZFvQUjVvYhGxWTSpz+2rxDyg@mail.gmail.com/
> 
> Since suspend/resume requires a reverse iterator, I'm dusting it off.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
>  fs/super.c | 48 +++++++++++++++++++++++++++++-------------------
>  1 file changed, 29 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 5a7db4a556e3..76785509d906 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -887,28 +887,38 @@ void drop_super_exclusive(struct super_block *sb)
>  }
>  EXPORT_SYMBOL(drop_super_exclusive);
>  
> +#define ITERATE_SUPERS(f, rev)					\

I'm not fond of the macro magic here.
I've taken some of your patches and massaging them.

