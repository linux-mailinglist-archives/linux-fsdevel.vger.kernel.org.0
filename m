Return-Path: <linux-fsdevel+bounces-74080-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3108D2EDAF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 10:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED20130A3F01
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 09:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC50357A39;
	Fri, 16 Jan 2026 09:36:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA773570C1;
	Fri, 16 Jan 2026 09:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768556211; cv=none; b=fLghZB+8ajwRH9bFy1w6vEIOPhCoVUCnIdhYbbPeUmRVGy6SXvXNJl3sYvKR3pJ/vS16h/3m7WdDmNtafTD3LyeM4FmOwwcN9wlCMln9hyLjPEQP2u9hNoI6SLij+1tVscdjByelVBKAj0HRMllL/Eig/SW0QpMx+z7pNBCHshs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768556211; c=relaxed/simple;
	bh=JDWJrbRjIFrw3KLEL0PaTeoWEdHsfnETA4l/qAIRuc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pasODqnfzhM8NUfrUYPUHgvaIq7BDv2DzklXviyuaSUjqG3H9OLcs4rFDu7ZbaOUyqGnxzdddD+IOye0XLhOgqwwRwirmOKHIqjNFPqS1Ne+66jZtc4TLtOd8Tvsw/RkvftQk53GW43jXefxIXhtbBwAPs1t5WmwZGErc4dqRDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0E16B227A8E; Fri, 16 Jan 2026 10:36:44 +0100 (CET)
Date: Fri, 16 Jan 2026 10:36:43 +0100
From: Christoph Hellwig <hch@lst.de>
To: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Cc: Amir Goldstein <amir73il@gmail.com>, Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Carlos Maiolino <cem@kernel.org>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org, kernel-dev@igalia.com
Subject: Re: [PATCH 3/3] ovl: Use real disk UUID for origin file handles
Message-ID: <20260116093643.GA23235@lst.de>
References: <20260114-tonyk-get_disk_uuid-v1-0-e6a319e25d57@igalia.com> <20260114-tonyk-get_disk_uuid-v1-3-e6a319e25d57@igalia.com> <20260114062608.GB10805@lst.de> <5334ebc6-ceee-4262-b477-6b161c5ca704@igalia.com> <20260115062944.GA9590@lst.de> <633bb5f3-4582-416c-b8b9-fd1f3b3452ab@suse.com> <20260115072311.GA10352@lst.de> <22b16e24-d10e-43f6-bc2b-eeaa94310e3a@igalia.com> <CAOQ4uxhbz7=XT=C3R8XqL0K_o7KwLKsoNwgk=qJGuw2375MTJw@mail.gmail.com> <0241e2c4-bf11-4372-9eda-cccaba4a6d7d@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0241e2c4-bf11-4372-9eda-cccaba4a6d7d@igalia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jan 15, 2026 at 03:55:15PM -0300, André Almeida wrote:
>> Is there any guarantee that file handles are relevant and point to the
>> same objects?
>>
>> The whole point of the overlayfs index feature is that overlayfs inodes
>> can have a unique id across copy-up.
>>
>> Please explain in more details exactly which overlayfs setup you are
>> trying to do with index feature.
>>
>
> The problem happens _before_ switching from A to B, it happens when trying 
> to install the same image from A on B.
>
> During the image installation process, while running in A, the B image will 
> be mounted more than once for some setup steps, and overlayfs is used for 
> this. Because A have the same UUID, each time B is remouted will get a new 
> UUID and then the installation scripts fails mounting the image.

It sounds like the 'clones' really need different persistent uuids. Or
do you also have a requirement that the two images have the same ID,
which would require a noouid-like option and extremely careful handling.

