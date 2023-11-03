Return-Path: <linux-fsdevel+bounces-1924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B757E049E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 15:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 238CF1C209E7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 14:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C041A59C;
	Fri,  3 Nov 2023 14:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="caZxQdt0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39C51A585
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Nov 2023 14:23:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E4A1B9;
	Fri,  3 Nov 2023 07:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vZJ7LPQ3GnvRgDrJKFJUcbvTnIjY96mQSJDKJHx0Emk=; b=caZxQdt0+HWGkRhgC5bEyTIorI
	woNm8ezr7fTQAzNgHiQxUdDSkean9Jv5aaTOshgznslGH34+t1uhrAjq5xvVh+BCFJFQlkq7RymI+
	bZpnGUTCsrD4Z/j6ioEcX6aOJHyO+vRg2CETMkrBpxqVIR5IHET2vsawZChOsrLW+fYDbe+WfefQF
	nf6cwD8P08YOlSoFKFUK6FWr6840VNATn2aagSoFy+9CI1zJPrLDYEO44upGVP3nQdw7ujQKI0hNH
	55k/mLd69YgE8NcukXzhYVs2HOay1B+i/rzvohKJ1K2e10WQZeaWR7wgmBVwpPbumf+rMIFBnS06L
	Vn3WsQww==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qyv4a-00BZNw-25;
	Fri, 03 Nov 2023 14:22:56 +0000
Date: Fri, 3 Nov 2023 07:22:56 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <ZUUCQA7kIioHBv7d@infradead.org>
References: <ZTk1ffCMDe9GrJjC@infradead.org>
 <20231025210654.GA2892534@perftesting>
 <ZTtOmWEx5neNKkez@infradead.org>
 <20231027131726.GA2915471@perftesting>
 <ZT+uxSEh+nTZ2DEY@infradead.org>
 <20231031-faktor-wahlparty-5daeaf122c5e@brauner>
 <ZUDxli5HTwDP6fqu@infradead.org>
 <20231031-anorak-sammeln-8b1c4264f0db@brauner>
 <ZUE0CWQWdpGHm81L@infradead.org>
 <20231101-nutzwert-hackbeil-bbc2fa2898ae@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101-nutzwert-hackbeil-bbc2fa2898ae@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Nov 01, 2023 at 09:16:50AM +0100, Christian Brauner wrote:
> mkfs.btrfs -f /dev/sda
> mount -t btrfs /dev/sda /mnt
> btrfs subvolume create /mnt/subvol1
> btrfs subvolume create /mnt/subvol2
> 
> Then all subvolumes are always visible under /mnt.
> IOW, you can't hide them other than by overmounting or destroying them.

Yes.

> If we make subvolumes vfsmounts then we very likely alter this behavior
> and I see two obvious options:
> 
> (1) They are fake vfsmounts that can't be unmounted:
> 
>     umount /mnt/subvol1 # returns -EINVAL
> 
>     This retains the invariant that every subvolume is always visible
>     from the filesystems root, i.e., /mnt will include /mnt/subvol{1,}

Why would we have to prevent them to be automounted?  I'd expect
automount-like behavior where they are automatially mounted and then
expired or manuall unmounted.

> But if we do e.g., (2) then this surely needs to be a Kconfig and/or a
> mount option to avoid breaking userspace (And I'm pretty sure that btrfs
> will end up supporting both modes almost indefinitely.).

It would definitively need to be an opt-in for existing systems.


