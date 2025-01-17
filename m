Return-Path: <linux-fsdevel+bounces-39466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB95A14AB6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 09:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38D04167270
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 08:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCF11F868A;
	Fri, 17 Jan 2025 08:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="JXegMKSu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BF61F6690
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jan 2025 08:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737101501; cv=none; b=uk68KrsXhO+ud3/VoRi6214q/32BDE8eK9aBgGt273uIPcqE3rz0mAKku4UA/YWYpppsHG6Ml3heKdwsGDzpE0goOpFA9KX1YLd7CHJ2antXfptiMu9pEcaJ8wXQQ1YN74GQAxd/KGLCxlgvKRjhoiVzZW0jMR+sgqtqDrS/tO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737101501; c=relaxed/simple;
	bh=2+B+EJFY3irGQuVrtT+YtNf+ceaj/Ep7TTpVV4rDGhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNROJDMl3eGUnBSIOyuAtV2kXJo0wgvH4PqX5G4cJbQizMEJDYbec9Kyu0BH74vxxUN/n5pEly3SiSkIEU3JkEgTOudrq+Qi4lXbHFaFYdA32T5JrDE5cQFwWl91Ahjv780KaVp3O4lPKXci19D8l6zUuFz8KL+eFcrEr6F1UW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=JXegMKSu; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kt0I1pZgmHGP+GRkHJ0PXR9kZGxrIxRC4EeUKokeiTk=; b=JXegMKSubtjMiFENB3IgzfiBE4
	3Hr4h7iCfe3j9FChtWTp1GIbFANQvh80jdaZhVBqu5BvvE1G3rf5raW/jGF3D4bcG30gOre0nkQot
	jb5NTOll+OcGCcCCk1PxVFpkemS1ZTGNkE9JgQTic2jHSJK91AfQIgI2+bFJSZd4r/1wJmP+RrPJK
	zVjBq2ULDOgZbZooobIKCQq2dDYdqK+8YVHWF44IZplf234RRb/TsfhDsO9vGmpMXyWbjv1f45/HY
	nkcGkPRilMei1/kV+qyAxsUdhGgKEO4ATjhC40RZi2JYV4f+lBdkpGUCbkAEs0lr5qeHKTIDQvQ6u
	q3eU1Q+w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tYhS4-000000033Gr-17sU;
	Fri, 17 Jan 2025 08:11:36 +0000
Date: Fri, 17 Jan 2025 08:11:36 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Eric Sandeen <sandeen@redhat.com>, linux-fsdevel@vger.kernel.org,
	brauner@kernel.org
Subject: Re: [PATCH] ufs: convert ufs to the new mount API
Message-ID: <20250117081136.GP1977892@ZenIV>
References: <20250116184932.1084286-1-sandeen@redhat.com>
 <20250116190844.GM1977892@ZenIV>
 <9f1435d3-5a40-405e-8e14-8cbdb49294f5@sandeen.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f1435d3-5a40-405e-8e14-8cbdb49294f5@sandeen.net>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Jan 16, 2025 at 04:07:44PM -0600, Eric Sandeen wrote:
> On 1/16/25 1:08 PM, Al Viro wrote:
> > On Thu, Jan 16, 2025 at 12:49:32PM -0600, Eric Sandeen wrote:
> > 
> >> +	switch (opt) {
> >> +	case Opt_type:
> >> +		if (reconfigure &&
> >> +		    (ctx->mount_options & UFS_MOUNT_UFSTYPE) != result.uint_32) {
> >> +			pr_err("ufstype can't be changed during remount\n");
> >> +			return -EINVAL;
> >>  		}
> >> +		ufs_clear_opt(ctx->mount_options, UFS_MOUNT_UFSTYPE);
> >> +		ufs_set_opt(ctx->mount_options, result.uint_32);
> >> +		break;
> > 
> > Do we really want to support ufstype=foo,ufstype=bar?
> 
> well, we already do that today. Old code was:
> 
>                 switch (token) {
>                 case Opt_type_old:
>                         ufs_clear_opt (*mount_options, UFSTYPE);
>                         ufs_set_opt (*mount_options, UFSTYPE_OLD);
>                         break; 
>                 case Opt_type_sunx86:
>                         ufs_clear_opt (*mount_options, UFSTYPE);
>                         ufs_set_opt (*mount_options, UFSTYPE_SUNx86);
>                         break;
> ...
> 
> so I was going for a straight conversion for now so that the behavior
> was exactly the same (i.e. keep the last-specified type. I know, it's
> weird, who would do that? Still. Don't break userspace? And we've been
> burned before.)

FWIW, see viro/vfs.git #work.ufs - separating ufs flavour and on-error
flags, dealing with -o ufstype conflicts, then your patch ported on
top of that.

