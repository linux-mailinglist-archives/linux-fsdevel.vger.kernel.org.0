Return-Path: <linux-fsdevel+bounces-73760-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C88D1F9CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 16:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF4A5304226A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 15:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEA7316182;
	Wed, 14 Jan 2026 15:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2aGkR9+G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94C92550A3;
	Wed, 14 Jan 2026 15:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768403159; cv=none; b=c2qvk+fuUVL5eKapVnw7SZM+axGX0E39ewGrMhCoyDbk8hxm0M/CFKU9sHEeCVX1zdOcRa/OzKt564SmY3lsfb3fDaaFy67effjMfu9g93x/cERvZWAkjsBZzcuFxiI25KdirLI9LSyCzuiWKl/+5dheWiPkzFK2JOWDvZeTGC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768403159; c=relaxed/simple;
	bh=FHu9QC6aUntevDtu9b89ECBHcIAGyW7+M4M/0IVXo6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5lo4y5b5xR703tUpNw6g8vwbXExavFEH1n3/uPEEu+QW79+cJYb0zowmQpvy7XudnlUswuCEdc8+lVDBFXst2x8C4alV0dB0QjFqOWGA8mVIaJ/PBVxhc73nSlm/CJWBZY+htRn3fW8xHU2A18zCJe0saA164NRy0hi9N7E1O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2aGkR9+G; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=p/1eVpMenCIWXkmi+LWs4qBDeJZQRhQ1Mo2xBG1d6m0=; b=2aGkR9+Gq07Pqsr81YJxBM46lt
	pC2tFopI1k2CQN/EQyBvUMbN685on8x5U4CpdjMpkFZFWeBtSU1OM84Ciw+y3szFcelfmqTyyg3Vm
	y2DbB7FtxibRk5XBq6sH9x7jaP/v3yPQ2Ob6mTE3lbJs+jMPsrwoZFGtqfkkexkKI90sVyqCbvrKN
	zpFbi2ZET+fTj2fii5dhkiKqKWNVPeKcG3n8jccbhPTVNNeRCqGKQRlyNUdLbE0ua8zYfilMENTNi
	ksLGJd1DFd0SiHbXxA8bZhed6Je0ZmYu3Fr0+QZKywruGLSgXGNe8uS3svWfCZcAVQ+74djzH6mhe
	QKhXyQqw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vg2Qx-00000009cKq-2YJq;
	Wed, 14 Jan 2026 15:05:19 +0000
Date: Wed, 14 Jan 2026 07:05:19 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, Christoph Hellwig <hch@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
	Luis de Bethencourt <luisbg@kernel.org>,
	Salah Triki <salah.triki@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>, Anders Larsen <al@alarsen.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
	Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Chunhai Guo <guochunhai@vivo.com>, Jan Kara <jack@suse.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	David Woodhouse <dwmw2@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Dave Kleikamp <shaggy@kernel.org>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Mike Marshall <hubcap@omnibond.com>,
	Martin Brandenburg <martin@omnibond.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Phillip Lougher <phillip@squashfs.org.uk>,
	Carlos Maiolino <cem@kernel.org>, Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Hans de Goede <hansg@kernel.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-mtd@lists.infradead.org, jfs-discussion@lists.sourceforge.net,
	linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
	ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org,
	linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, gfs2@lists.linux.dev, linux-doc@vger.kernel.org,
	v9fs@lists.linux.dev, ceph-devel@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Subject: Re: [PATCH 00/24] vfs: require filesystems to explicitly opt-in to
 lease support
Message-ID: <aWewryHrESHgXGoL@infradead.org>
References: <cb5d2da6-2090-4639-ad96-138342bba56d@oracle.com>
 <ce700ee20834631eceededc8cd15fc5d00fee28e.camel@kernel.org>
 <20260113-mondlicht-raven-82fc4eb70e9d@brauner>
 <aWZcoyQLvbJKUxDU@infradead.org>
 <ce418800f06aa61a7f47f0d19394988f87a3da07.camel@kernel.org>
 <aWc3mwBNs8LNFN4W@infradead.org>
 <CAOQ4uxhMjitW_DC9WK9eku51gE1Ft+ENhD=qq3uehwrHO=RByA@mail.gmail.com>
 <aWeUv2UUJ_NdgozS@infradead.org>
 <c40862cd65a059ad45fa88f5473722ea5c5f70a5.camel@kernel.org>
 <CAOQ4uxhDwR7dteLaqURX+9CooGM1hA7PL6KnVmSwX11ZdKxZTA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhDwR7dteLaqURX+9CooGM1hA7PL6KnVmSwX11ZdKxZTA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jan 14, 2026 at 03:14:13PM +0100, Amir Goldstein wrote:
> Very well then.
> How about EXPORT_OP_PERSISTENT_HANDLES?

Sure.

> > The problem there is that we very much do want to keep tmpfs
> > exportable, but it doesn't have stable handles (per-se).
> 
> Thinking out loud -
> It would be misguided to declare tmpfs as
> EXPORT_OP_PERSISTENT_HANDLES
> and regressing exports of tmpfs will surely not go unnoticed.

tmpfs handles are stable.  It's the tmpfs files that don't survive an
unmount or reboot..


