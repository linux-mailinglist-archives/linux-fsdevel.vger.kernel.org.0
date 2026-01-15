Return-Path: <linux-fsdevel+bounces-73937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AC7D25A45
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 17:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2653630752F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 16:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E333B8D7E;
	Thu, 15 Jan 2026 16:08:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6D22C158D;
	Thu, 15 Jan 2026 16:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768493302; cv=none; b=bQ9IRvvCXcenIfBaZAGp7TB+64jds7mALNiVFUHP+oE+CMjmjs6TAO2Brt0gjSDE1pejx19zPMTdsafosVnBM0k9DmWcy0L+cX5ai8hqG3ZTUaiIIQ7Qtquyx4M2OpoReOBSrvVrOJHOAWc7PEn5bfErfyVTyab513pFrYrIayU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768493302; c=relaxed/simple;
	bh=oluAEehTKSlBUTuq+kKwr/KxTa55+6K5UFb1kYO/H70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DHk5AFRJ/wApDat3XvYZghFViuL3CbIWHGQWqBpSHdmOSEgqMep7mzuuHlr0XJw1myyfwakNTC5ZzNJ2+AAjh9EmeT4/0yhLUM2JfxJabybcU0qnolGav+t++ahUL4lZKjbMP5WhggDOW/ngESwFQquN9vvj2iH8Ae526STC5Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id ADAB6227AAA; Thu, 15 Jan 2026 17:08:16 +0100 (CET)
Date: Thu, 15 Jan 2026 17:08:16 +0100
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
	Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org, kernel-dev@igalia.com
Subject: Re: [PATCH 3/3] ovl: Use real disk UUID for origin file handles
Message-ID: <20260115160816.GA16080@lst.de>
References: <20260114-tonyk-get_disk_uuid-v1-0-e6a319e25d57@igalia.com> <20260114-tonyk-get_disk_uuid-v1-3-e6a319e25d57@igalia.com> <20260114062608.GB10805@lst.de> <5334ebc6-ceee-4262-b477-6b161c5ca704@igalia.com> <20260115062944.GA9590@lst.de> <633bb5f3-4582-416c-b8b9-fd1f3b3452ab@suse.com> <20260115072311.GA10352@lst.de> <22b16e24-d10e-43f6-bc2b-eeaa94310e3a@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <22b16e24-d10e-43f6-bc2b-eeaa94310e3a@igalia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jan 15, 2026 at 12:42:33PM -0300, André Almeida wrote:
>> So André, can you confirm this what you're worried about?  And btrfs
>> developers, I think the main problem is indeed that btrfs simply allows
>> mounting the same fsid twice.  Which is really fatal for anything using
>> the fsid/uuid, such NFS exports, mount by fs uuid or any sb->s_uuid user.
>>
>
> Yes, I'm would like to be able to mount two cloned btrfs images and to use 
> overlayfs with them. This is useful for SteamOS A/B partition scheme.

Then you'll really need to assign them different (persistent) fsids/uuids.


