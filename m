Return-Path: <linux-fsdevel+bounces-46811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2143CA95409
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 18:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3CB33B5793
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 16:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AC51E1E1F;
	Mon, 21 Apr 2025 16:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="I5P+5qQV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD071A08AF
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Apr 2025 16:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745252991; cv=none; b=U4ZEnWrjerMF3JU17P3M78OfBLmVmJq34rNh7H6dJ0/DTxek3s3LIWXpmu8UhOMjY4G3zzccxpDeKLOnKiwYz1w1lOHz5VD9lkZGx3bj6IKSD3IC7Z2Kk8T9nEHZ3ApSf0qIWyjhb4bSxGSK2RxmPbqQvZ5EUe6fhTGs7MT6bZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745252991; c=relaxed/simple;
	bh=t5k/dXIfF8FEAFzU9LHDP2NNobtP59Adc0NFRUQ4c90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=toccdMfjWLIIOCh2vBLFk6ytwScX8vj1AcBoHN41A3t16zS1Zb6DLlNbU8TG/Rw+BPPB1Dfdl6OQevVxXv5dI6ldwq0UlEU6uZg33sD/QmwnT8kGRsWWpwKuv+ohM6HEkjJZppKRtdfwqzN6ERTuP8lYbPn9K0toEjZ1W4MiOT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=I5P+5qQV; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PrKq4n+WtySnNcmWr3N7jVY05dOVMtHUQJoVkE2geoQ=; b=I5P+5qQVXVypWz0l8e9ekI6tkN
	HiN5z81fWhjeZzJav6XVC68+TGHD3uqwUlELCHlA5r4Qn+j3nH2kupcIvBCHk7Kc2fOw6oxucgi39
	Eshskfp6jae23D5gUbpcZ7FjSJQDajVr3cdjBtLBMoNfH6h5+fkgf4NY0eG+ZWzKMp0gigby9GrOn
	mNKMLaVSWEA3qcH/loMR94+/0LfHY+AqEgglTimWfrRwWa9vzZfLpnAVVNJYso7SbblaLMbtLtXXs
	krMmtQhOwP8vnHdpND2nSphMu8rcmhrSTEkyy6G9gJfnh3XfGs2vh83i1ZCFeGkXoH/jYKlM4+W2v
	gwInFolA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6u1j-00000002JGh-0WdH;
	Mon, 21 Apr 2025 16:29:47 +0000
Date: Mon, 21 Apr 2025 17:29:47 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH][RFC] ->mnt_devname is never NULL
Message-ID: <20250421162947.GW2023217@ZenIV>
References: <20250421033509.GV2023217@ZenIV>
 <20250421-annehmbar-fotoband-eb32f31f6124@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421-annehmbar-fotoband-eb32f31f6124@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Apr 21, 2025 at 09:56:20AM +0200, Christian Brauner wrote:
> On Mon, Apr 21, 2025 at 04:35:09AM +0100, Al Viro wrote:
> > Not since 8f2918898eb5 "new helpers: vfs_create_mount(), fc_mount()"
> > back in 2018.  Get rid of the dead checks...
> >     
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > ---
> 
> Good idea. Fwiw, I've put this into vfs-6.16.mount with some other minor
> stuff. If you're keeping it yourself let me know.

Not sure...  I'm going through documenting the struct mount lifecycle/locking/etc.
and it already looks like there will be more patches, but then some are going
to be #fixes fodder.

Example caught just a couple of minutes ago: do_lock_mount()
                if (beneath) {
                        m = real_mount(mnt);
                        read_seqlock_excl(&mount_lock);
                        dentry = dget(m->mnt_mountpoint);
                        read_sequnlock_excl(&mount_lock);
                } else {
                        dentry = path->dentry;
                }

                inode_lock(dentry->d_inode);
What's to prevent the 'beneath' case from getting mnt mount --move'd
away *AND* the ex-parent from getting unmounted while we are blocked
in inode_lock?  At this point we are not holding any locks whatsoever
(and all mount-related locks nest inside inode_lock(), so we couldn't
hold them there anyway).

Hit that race and watch a very unhappy umount...

BTW, a stylistic note: 'beneath' and '!beneath' cases have very little
in common; I'm pretty sure it would be cleaner to split this function
in two, putting the '!beneath' case back into lock_mount() and calling
the rest lock_mount_beneath()...  This kind of boolean arguments is
a bad idea, IME - especially when they affect locking or lifetimes
in any way.

