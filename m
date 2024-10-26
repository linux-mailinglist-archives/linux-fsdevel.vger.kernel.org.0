Return-Path: <linux-fsdevel+bounces-33005-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9929B159F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Oct 2024 08:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17835283DBA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Oct 2024 06:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C9217BB07;
	Sat, 26 Oct 2024 06:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ReLZemze"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D3B29CE5;
	Sat, 26 Oct 2024 06:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729925784; cv=none; b=Dp9jqEyjbKQzknFDyeS8LXgzRT96YqkqmRHb8J9YX9em//jDVqosjmPKCwWI/TEZINtETu/x4mLLF5NY72SEp5DV3plRjEO7H7GGkoFOCoQ5X4SvNNDJ8XcTf8tt3MPYWqQFPRIk6Eg7H2W+qpcJWKS+gY6oR/0EnksoP1/ElzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729925784; c=relaxed/simple;
	bh=d+bCeXuuX6Ror1LFO3OCR5GB5C0R6JqFDgINRk8FG3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OTGgjzZ3wjglzds8Ao21ipYQo1Z8d9B8zSrq065/1AvNmE/7XpExTv5NzPslQzHpiUUAQ97fwaOyGEC/SIKl5Txmtc0xf/JU+OhZmeqRb023GFs4RKnmi4PhOPpnJoU0CarvtA2Fa3QEHRmQdG8ooOgaW6TtBk2QbbEkrqA78aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ReLZemze; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=DrR92H6XTz4kyxDBrFWKSqtKcZqgk99WoEdwxPn/FE0=; b=ReLZemzeXXQQGM2yyB4TdDgKLm
	VP7cHlwMQqFPzgQ/8Aw7QJG98zEjAocsaySj7XtOqE0K00JZ5PmPCHsX7R/qUC/BNRjGRBfIgIogT
	dFFLRQkUX15gpxWsUqT2DoP7WkzrQP43GqzpjIOfdUNzkGfZUGBRO0pLLGbv5esZ3lZYKCDP/3yNG
	N7czz620M10QjLX18zZjTEodw0OWrCQfaE6zOSv7fsPch8Mt+FHQy+N8gpymuFNFjaWhZtc8k7R10
	ZDpwh0HNOe7raePzqbVE5/B6lfDLqJZe6aapJzdVkvKRQThHRcKY0aPrlVbST988AknYYl4UyV3ZF
	7voDUQiQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t4aih-00000007rUI-16D5;
	Sat, 26 Oct 2024 06:56:19 +0000
Date: Sat, 26 Oct 2024 07:56:19 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] ovl: replace dget/dput with d_drop in ovl_cleanup()
Message-ID: <20241026065619.GD1350452@ZenIV>
References: <20241025150154.879541-1-mszeredi@redhat.com>
 <CAOQ4uxhA-o_=4jE2DyNSAW8OWt3vOP1uaaua+t3W5aA-nV+34Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhA-o_=4jE2DyNSAW8OWt3vOP1uaaua+t3W5aA-nV+34Q@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Oct 26, 2024 at 08:30:54AM +0200, Amir Goldstein wrote:
> On Fri, Oct 25, 2024 at 5:02 PM Miklos Szeredi <mszeredi@redhat.com> wrote:
> >
> > The reason for the dget/dput pair was to force the upperdentry to be
> > dropped from the cache instead of turning it negative and keeping it
> > cached.
> >
> > Simpler and cleaner way to achieve the same effect is to just drop the
> > dentry after unlink/rmdir if it was turned negative.
> >
> > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> 
> Looks sane.
> Applied to overlayfs-next for testing.

I thought it was about preventing an overlayfs objects with negative ->__upperdentry;
why would a negative dentry in upper layer be a problem otherwise?

