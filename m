Return-Path: <linux-fsdevel+bounces-74421-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6870CD3A2E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 10:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 10505302D3A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 09:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0376A355812;
	Mon, 19 Jan 2026 09:27:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493CF354AFE;
	Mon, 19 Jan 2026 09:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768814820; cv=none; b=ldkxLbfszWbEMsagbExsHCiWFb3c3+W7qDaM/3mdKmVrDIHEoYiqvqDb+lEmzJq6s6hZnzExe8yhxWG8/3aGBf3402J4dEfpN7i0kWMz8Lg2Z038eUM7hvRZVGL9GeXBWvoWzPf8VBNPaEubSMcdeTAwzzVHd++n1kgxgHDfV/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768814820; c=relaxed/simple;
	bh=PjfUcFXku+cUWAO2n5GG+1jRW2QpGfHonTRQxtcsSUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h2F3injie+zy2gPB6z0UXcjOqEJQf6JKg+MXwOHokqCyuNY+Hm/FnjcNv9PJCLj0kHQ3OIk7XO7LXwFQn7IxjPepP/VY/WDoLQ3uWqDma3Pv7hJlitBcR88H2KQn92sjwZiMxOx/gNlx2FYDG0lO24o7i9STsg/wbcQXUyHs4rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 95285227AA8; Mon, 19 Jan 2026 10:26:53 +0100 (CET)
Date: Mon, 19 Jan 2026 10:26:53 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, Eric Biggers <ebiggers@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	fsverity@lists.linux.dev
Subject: Re: [PATCH 3/6] fs,fsverity: handle fsverity in generic_file_open
Message-ID: <20260119092653.GA10032@lst.de>
References: <20260119062250.3998674-1-hch@lst.de> <20260119062250.3998674-4-hch@lst.de> <tn4evey6q4ktzfu4vd2fmaz5j233cigw2grnyvzc4cnholsolb@z44vyuenknkl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tn4evey6q4ktzfu4vd2fmaz5j233cigw2grnyvzc4cnholsolb@z44vyuenknkl>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jan 19, 2026 at 10:05:56AM +0100, Jan Kara wrote:
> > +	if (IS_ENABLED(CONFIG_FS_VERITY) && IS_VERITY(inode)) {
> > +		if (filp->f_mode & FMODE_WRITE)
> > +			return -EPERM;
> > +		return fsverity_file_open(inode, filp);
> > +	}
> 
> Why do you check f_mode here when fsverity_file_open() checks for it as
> well?

Probably because it's a left over from when I tried to open code
fsverity_file_open here.  I'll fix it up.


