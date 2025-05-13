Return-Path: <linux-fsdevel+bounces-48812-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79936AB4CEB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 09:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B738467C40
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 07:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016731F09BD;
	Tue, 13 May 2025 07:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i40G3V6u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEE81F03D6;
	Tue, 13 May 2025 07:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747121989; cv=none; b=RydfJrp25sOwNGMriTrbKN1Jj67smExoy19KFJp2IzcpeBIlC7PtrRIaeu2CSJ341iuV1v6B0W+4Vb6wCD1Rj5fOQgw1VZ4qV0/miM1Fxqte12dVPTpj9+EoyHUn6mhJ3lv5Ou4dOvCQZ6DRtMwwOFjG+UcgaNzvfiUMOIhpr1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747121989; c=relaxed/simple;
	bh=hjWQjgTtHXLhLzvMlxehe6/+1Kfl8Mm7PJtbcltv3iY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hXyYg9Ut/yyl8iSDVoWliyyeYTq6NvR033n8+8HoinZOdRCdR6uDxpX1pGDLEGhD0avpABWsdNmi+pvY5PUh5daS/X+Urd6VuVF8JZJiyLA4O7giaJ5SARaYIt1KEBhbj48xNxU1LvK9Jm3D/HjD4BpGej8ZkR8OkoP24ISuIKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i40G3V6u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80157C4CEE4;
	Tue, 13 May 2025 07:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747121988;
	bh=hjWQjgTtHXLhLzvMlxehe6/+1Kfl8Mm7PJtbcltv3iY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i40G3V6uP21v6a5wEmsDMf5+UO8lAxBF2jpdwodzqIF72E7JNM74ODWfnOzOGUCJ+
	 6sJKz3yFYe1MghSR8XlpJq6pRY0w06DKMjxYOcwO8ds2toNBbPBNf0CmT7NJ1C4owX
	 pMv3cOhhslII932jl0Vvgl76MsfbBB8CfPmQicNYbmECUSWztJKt9WYZmu/Utg1jiK
	 K6yP5N/4avrX+YOgokbVMgaEBIulp2mRKn0sfRygG4zXvVYbslBaOPz1VAcM+fGYuZ
	 QupmJj9+YvW8s7NHlm9GyKN5a+vuRiwox5VlhfecW+OhpmXbeBtHgtehU9NrE/Hxh6
	 qyHaEOAU0lIdg==
Date: Tue, 13 May 2025 09:39:45 +0200
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>, 
	Chen Linxuan <chenlinxuan@uniontech.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] fs: fuse: add backing_files control file
Message-ID: <20250513-etage-dankbar-0d4e76980043@brauner>
References: <20250509-fusectl-backing-files-v3-0-393761f9b683@uniontech.com>
 <20250509-fusectl-backing-files-v3-2-393761f9b683@uniontech.com>
 <CAJfpegvhZ8Pts5EJDU0efcdHRZk39mcHxmVCNGvKXTZBG63k6g@mail.gmail.com>
 <CAC1kPDPeQbvnZnsqeYc5igT3cX=CjLGFCda1VJE2DYPaTULMFg@mail.gmail.com>
 <CAJfpegsTfUQ53hmnm7192-4ywLmXDLLwjV01tjCK7PVEqtE=yw@mail.gmail.com>
 <CAC1kPDPWag5oaZH62YbF8c=g7dK2_AbFfYMK7EzgcegDHL829Q@mail.gmail.com>
 <CAJfpegu59imrvXSbkPYOSkn0k_FrE6nAK1JYWO2Gg==Ozk9KSg@mail.gmail.com>
 <CAOQ4uxgM+oJxp0Od=i=Twj9EN2v2+rFByEKabZybic=6gA0QgA@mail.gmail.com>
 <CAJfpegs-SbCUA-nGnnoHr=UUwzzNKuZ9fOB86+jgxM6RH4twAA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegs-SbCUA-nGnnoHr=UUwzzNKuZ9fOB86+jgxM6RH4twAA@mail.gmail.com>

On Mon, May 12, 2025 at 12:06:19PM +0200, Miklos Szeredi wrote:
> On Mon, 12 May 2025 at 11:23, Amir Goldstein <amir73il@gmail.com> wrote:
> 
> > The way I see it is, generic vs. specialized have pros and cons
> > There is no clear winner.
> > Therefore, investing time on the getxattr() direction without consensus
> > with vfs maintainer is not wise IMO.
> 
> AFAIU Christian is hung up about getting a properly sized buffer for the result.

No, the xattr interface is ugly as hell and I don't want it used as a
generic information transportation information interface. And I don't
want a single thing that sets a precedent in that direction.

> But if the data is inherently variable sized, adding specialized
> interface is not going to magically solve that.
> 
> Instead we can concentrate on solving the buffer sizing problem
> generally, so that all may benefit.

The xattr system call as far as I'm concerned is not going to be pimped
to support stuff like that.

> 
> > The problem I see with this scheme is that it is not generic enough.
> > If lsof is to support displaying fuse backing files, then it needs to
> > know specifically about those magic xattrs.
> 
> Yeah, I didn't think that through.  Need some *standard* names.
> 
> > Because lsof only displays information about open files, I think
> > it would be better to come up with a standard tag in fdinfo for lsof
> > to recognize, for example:
> >
> > hidden_file: /path/to/hidden/file
> > hidden_files_list: /path/to/connections/N/backing_files
> 
> Ugh.
> 
> > Making an interface more hierarchic than hidden_files_list:
> > is useless because lsof traverses all fds anyway to filter by
> > name pattern and I am very sceptical of anyone trying to
> > push for an API get_open_fds_by_name_pattern()...
> 
> The problem is that hidden files are hidden, lsof can't traverse them
> normally.  It would be good to unhide them in some ways, and for me
> that would at least mean that you can
> 
>  1) query the path (proc/PID/fd/N link)
>  2) query fdinfo
>  3) query hidden files

Then by all means we can come up with a scheme in procfs that displays
this hierarchically if we have to.

