Return-Path: <linux-fsdevel+bounces-64073-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BBEBD74C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 06:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED5AC4F748E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 04:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AA830BF54;
	Tue, 14 Oct 2025 04:44:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9984519C54F;
	Tue, 14 Oct 2025 04:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760417070; cv=none; b=BjjMA+Yx3dpwHpEROdMmQArdyDkPv7q5icVxSoddCbZ1Yqt8GoZU38lJR45kVo5f4n2aW0RVwGK+p9JFhOP7444v0rUaHs3caKTfhHL475uSG4eEwm84HiY7j/3kIHZCpQ3nQ/Vlrm68s23H66tSK1q3vQcqOdGupuLVsw+Dp1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760417070; c=relaxed/simple;
	bh=3xzfzkbgYIg9IfR3Ir94hE3O8Ov0sXJ49fRS3a8QW2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZfTpAj+lcDKIucQK1ecMBf6PUYBTqHjpQoVQi04q3IqZk3Cw5oH7bG/4KzoV14jDofyEH4nTQFp5FfFmagFS47HSbxL8Znh509JxKQYAK5l0TTSfCtBaPgRrNXbDjrx3gJkM/rgJZ/8PAf1JUgZufmCEOrOufniPluF+Vi+h4vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 26F11227A87; Tue, 14 Oct 2025 06:44:22 +0200 (CEST)
Date: Tue, 14 Oct 2025 06:44:21 +0200
From: hch <hch@lst.de>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: hch <hch@lst.de>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Jan Kara <jack@suse.cz>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"v9fs@lists.linux.dev" <v9fs@lists.linux.dev>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"jfs-discussion@lists.sourceforge.net" <jfs-discussion@lists.sourceforge.net>,
	"ocfs2-devel@lists.linux.dev" <ocfs2-devel@lists.linux.dev>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 04/10] btrfs: use the local tmp_inode variable in
 start_delalloc_inodes
Message-ID: <20251014044421.GA30920@lst.de>
References: <20251013025808.4111128-1-hch@lst.de> <20251013025808.4111128-5-hch@lst.de> <aae79ea0-f056-4da7-8a87-4d4fd6aea85f@wdc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aae79ea0-f056-4da7-8a87-4d4fd6aea85f@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Oct 13, 2025 at 08:11:35AM +0000, Johannes Thumshirn wrote:
> If you have to repost this for some reason, can you rename tmp_inode to 
> vfs_inode or sth like that?
> 
> The name is really confusing and the commit introducing it doesn't 
> describe it really either.

It is.  vfs_inode is kinda weird, too.  The problem is that inode
is used for the btrfs_inode.  But if there's consensus on a name
I'll happily change it.


