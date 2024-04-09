Return-Path: <linux-fsdevel+bounces-16464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EE389E10F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 19:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E38D01C21E1B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 17:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1082C15382F;
	Tue,  9 Apr 2024 17:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="OAwGOJjb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F26713E3E3;
	Tue,  9 Apr 2024 17:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712682409; cv=none; b=Du19XjtcdNfOD78M+Qw9DVoWZiTUhc3z/C7OumDmP4CeYKcvw2H+Em9A/lCNtwGTA3n2sOUkD8kveOKOdUe1/L7JrXJCNb5cz1k2H/wYJMpJGs9mghK5nVDM0Zr0vH/mt8N5QTucVcm8jVo1cydQChOudsMSNJnIPr1KUj/4dBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712682409; c=relaxed/simple;
	bh=SU/lIZjorLYT/0gn8Ivk/IkYaTA7K0Unxbh+QSYRN84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rR7X/PyQ/HACnD585NxsNUgB4WEZNWlsXyK5TExNpW7D7lVzMq+XNefwAqGeyTqX2JgwPJH17zolapmKuF+PdfzI4Q/88Dxy+yN6ra+PTqyPsSEfgljufOAl78JLQtnFk1c8gGufFPGxWNgFEAIIiu+Hca9w4gkkR4sJGBA/69A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=OAwGOJjb; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SU/lIZjorLYT/0gn8Ivk/IkYaTA7K0Unxbh+QSYRN84=; b=OAwGOJjbH3VyJN6C/JQx2eHqDl
	L6MBrNPuxjVIC/3iVlvU40CtZjaRS9iKd/G/fWJ4MwqmO5ppVaLxueAHwoOojyzqZ0moH1XmuxHtL
	yuSVvOEjppa1fcyBL90f8sFclfNIwgQy4acr/3hlrlJGzLm632vl+fqrdrcy0tF3xmJ7+9ohSvAIs
	/kTJyOiH9zbC+AbqCw3pIi8mgEIy6FvTTwLGJqEpogltTzljTRvsVTeNtLN7uh33DK+0bmvMUrtlD
	GqHp0buy79XsBLsZufqboxbgT7vyi5ZN5t/3DA5OzzKMkk2gjLP8jY3MyoqOmgH3BIRYzLC4I5S0R
	kHfYxYKg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1ruEvk-009F9r-11;
	Tue, 09 Apr 2024 17:06:44 +0000
Date: Tue, 9 Apr 2024 18:06:44 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] iov_iter: add copy_to_iter_full()
Message-ID: <20240409170644.GE2118490@ZenIV>
References: <20240409152438.77960-1-axboe@kernel.dk>
 <20240409152438.77960-2-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409152438.77960-2-axboe@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Apr 09, 2024 at 09:22:15AM -0600, Jens Axboe wrote:
> Add variant of copy_to_iter() that either copies the full amount asked
> for and return success, or ensures that the iov_iter is back to where
> it started on failure and returns false.

FWIW, see git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.iov_iter

There was an open-coded instance (skb_copy_linear()) that I'd converted to
that helper in the same commit; I can split it, of course, but I don't
see much point in that.

