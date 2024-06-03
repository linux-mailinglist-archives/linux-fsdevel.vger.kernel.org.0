Return-Path: <linux-fsdevel+bounces-20792-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C1F8D7C86
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 09:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F3DCB22612
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 07:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C89F487BF;
	Mon,  3 Jun 2024 07:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="wbfMUy2e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3914206C;
	Mon,  3 Jun 2024 07:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717400172; cv=none; b=p3Sr7YkolRl9h5XXY5BkaqIILLoOHwM176Hc1QoPeiJV2ahnLEbTqAdt5WbnRVoNorhNLj3GIZx/wCMCgAe2scI+t1UkSjLH6G94X33SnULtOzgBjTHcaGH+yV+Zdl5h8q8W5VxgG5edYeaH0IeX7K4fhfhq7apQA34pZGGM0hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717400172; c=relaxed/simple;
	bh=0kQf22K2deHNwZd2BeXcd7XR0S10w4Ui/1GCnO6Zbqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=etcok4J4kzRsnrKn5kf3PmStKtq+LvqSdd8DJIuBuIFXhhW94/IDa+NT2OTR0cpx3iDRNoM41WmrTaSZ40V2H80+47ogMaWtAHVVm4SJ1O0S2gQfCY36Ajg1mXs8ipuOGw7XTK2AoHeOmR2GG8rOoB7LnzCajdWb4/i0P5LMuzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=wbfMUy2e; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zPJMNxL9q3oOUNAtT7uHZ2LdiEyt30JwkKPIDktMlZE=; b=wbfMUy2ejaVqZJEdRxZt/8mv/G
	w6qxt4V7clVUtrveTSc1Rj697prXOhOY0Rj/ZfD/RrEq3wsaTXTTeBHnlG1R8ymIiLA0Dmh7iIxMi
	QXepflqfijrviWoc9YKel9IbuF28gsj8NoOiwYHcIgnKokxbHMeOUwCQfBTlDHPOnHJELvFp98S0g
	mg7W9YyRs3617FaSaqJrwUVE4ZOj74IhkSUx62eBsZEJGWkoQptG2kWH1y+vCf4AxyWEHIbEDAAJo
	hjVPw9LBJCqsgARykMTVvx40VpaW+OXxEt3tek4y4TDp7dpUZzdBlJgini5p11PhHa+ZxYh2rtDd2
	Ax7RkRsg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sE2ER-00BZ6z-1G;
	Mon, 03 Jun 2024 07:35:51 +0000
Date: Mon, 3 Jun 2024 08:35:51 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Hyeonwoo Cha <chw1119@hanyang.ac.kr>
Cc: david.sterba@suse.com, aivazian.tigran@gmail.com, brauner@kernel.org,
	jack@suse.cz, tytso@mit.edu, adilger.kernel@dilger.ca,
	hirofumi@mail.parknet.co.jp, sfr@canb.auug.org.au,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-ext4@vger.kernel.org, reiserfs-devel@vger.kernel.org
Subject: Re: [PATCH] Fix filesystem issue: description of the fix Fix
 mark_buffer_dirty_inode to mark_buffer_dirty_fsync Signed-off-by: HyeonWoo
 Cha <chw1119@hanyang.ac.kr>
Message-ID: <20240603073551.GM1629371@ZenIV>
References: <20240603065910.20736-1-chw1119@hanyang.ac.kr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603065910.20736-1-chw1119@hanyang.ac.kr>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jun 03, 2024 at 03:59:10PM +0900, Hyeonwoo Cha wrote:

NAK.  Reasons:
	* patch described as a fix; that implies that some behaviour
change is there.  Yet there's no description of that change or
explanation of the problem being fixed.
	* lack of _any_ explanations, period.  Including e.g.
a discussion of the reasons why the change makes sense.
	* apparent blind trust in continued applicability of comments
that date back to 2002; in any case, no analysis is offered anywhere -
reviewers are supposed to do that themselves, presumably.
	* failure to Cc the original author of the comment in question.

