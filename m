Return-Path: <linux-fsdevel+bounces-73883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B88D228F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 07:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F04D3051C5A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 06:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB18325A2DD;
	Thu, 15 Jan 2026 06:29:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258B01F1313;
	Thu, 15 Jan 2026 06:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768458591; cv=none; b=AwRE/NmrJ3GdScggjcLTcDaVGOdw1ovzUzzZKwiGYi2kp3MTWVY4JoHkksGS3q3Hp3qyJDlsGgAfIj+yAJuRlHRvgHOSvozfNSDCyVVHpo6tlbF8zCx7iCify97484Jk0+H2rHMUZ9uJFSHhlRyN2eO0Ln04ImS4dV9gCldleTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768458591; c=relaxed/simple;
	bh=5AjX7DXGf/G71C1G+H+3MNEPAMvBWTUNdnRJTAShFdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V48V7z0UJSUE8jCNq7aMljO9SlVQQjQR/FqtTsKxdJWqBElpPe0D6YpS6mTq2KISkNh9C+R0rylFYg6gwGMRwDpG3WdDM8JMI1yTKyCl69YAFJo4M6OsKFRpvEG7dYBz9YWy98V9mU1GbmJurQ2fS8DWp88XsAHaPCnuq47VjGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 43C15227AA8; Thu, 15 Jan 2026 07:29:45 +0100 (CET)
Date: Thu, 15 Jan 2026 07:29:44 +0100
From: Christoph Hellwig <hch@lst.de>
To: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Cc: Christoph Hellwig <hch@lst.de>, Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Carlos Maiolino <cem@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
	kernel-dev@igalia.com
Subject: Re: [PATCH 3/3] ovl: Use real disk UUID for origin file handles
Message-ID: <20260115062944.GA9590@lst.de>
References: <20260114-tonyk-get_disk_uuid-v1-0-e6a319e25d57@igalia.com> <20260114-tonyk-get_disk_uuid-v1-3-e6a319e25d57@igalia.com> <20260114062608.GB10805@lst.de> <5334ebc6-ceee-4262-b477-6b161c5ca704@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5334ebc6-ceee-4262-b477-6b161c5ca704@igalia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 14, 2026 at 01:17:15PM -0300, André Almeida wrote:
> Em 14/01/2026 03:26, Christoph Hellwig escreveu:
>> On Wed, Jan 14, 2026 at 01:31:43AM -0300, André Almeida wrote:
>>> Some filesystem, like btrfs, supports mounting cloned images, but assign
>>> random UUIDs for them to avoid conflicts. This breaks overlayfs "index"
>>> check, given that every time the same image is mounted, it get's
>>> assigned a new UUID.
>>
>> ... and the fix is to not assign random uuid, but to assign a new uuid
>> to the cloned image that is persisted.  That might need a new field
>> to distintguish the stamped into the format uuid from the visible
>> uuid like the xfs metauuid, but not hacks like this.
>>
>
> How can I create this non random and persisting UUID? I was thinking of 
> doing some operation on top the original UUID, like a circular shift, some 
> sort of rearrangement of the original value that we can always reproduce. 
> Is this in the right direction do you think?

Just allocate an entirely new uuid?  That's what XFS did with the
metadata uuid (persistent and stapted into all metadata headers) vs
user visible uuid that can be changed.

