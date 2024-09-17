Return-Path: <linux-fsdevel+bounces-29560-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3324A97AC52
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 09:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60E511C21713
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 07:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86ECB14C5AE;
	Tue, 17 Sep 2024 07:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="MlGiO8IF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8491271750;
	Tue, 17 Sep 2024 07:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726559078; cv=none; b=rkaxdvhf+PQOGmkH6TcSMDPsmQIO6YB0AM47YU2RqsJu0VG7kScSkGr/fQeyIf0VTG88hW33Xw2cwTnjlFz9D/BBaTmtrMGJc8DNr/6bifkFO8z6UZ/sMrikHdrLf1ScTWsr0OKhJHhDpKty+JPsYVjcCK3NrWDKEq8kyTrpIc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726559078; c=relaxed/simple;
	bh=2GovlFmFngew98nnqJdSUfpfZ6K5DSEqQBQAgPo4Q6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YaByh7w6FaMlzA+3dLlZksA/x/fBewBB/Hxl6Rus+TMqoexBngtVbNorKIk/5aR50xfmUZrL6nbyiEQUCc5AG/K8m+yaSU4TVuAzolMnOx9MGeWsiyhz6qnCYBs5TCcXRsCqvv46KMAIKV0ZlFj+cDblYRZ9tvHStyvTUKU82kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=MlGiO8IF; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9cCDNqUqku74cuT7uPSo0Wm5Piy7EOaKF6xGAapJSn8=; b=MlGiO8IFgA/5EE8FaV84k6wbe5
	hL87z/Km4WaN9jOXFpYpVWjE00u+bKu2Whq+a5UKdOEEg7YJ57e4DcFyeOGak3IabNckm1PpwrbgY
	K12LtGN71UYaDm2LotNk6R14LIpbc7MVqwemmNVAn7HLHBXA7v+ZuRMRgUEK9zxNCNRBFG61pOywl
	2kogj/jVtNYd2W9thyz44rcpHCWOB2F+odMecViYUCdYGkSztpnASLeKU8o7QVPULgXddI2Hmleof
	R5ltXXvY/SXeeHjNwXD7H26eQsTiRQc0lSIMWiH+jGxAN/DGSeKZm0eSDMaD6Vj3CLsq1f9JOh3Gu
	BMonxIIA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sqSsv-0000000D8Ft-3xHZ;
	Tue, 17 Sep 2024 07:44:29 +0000
Date: Tue, 17 Sep 2024 08:44:29 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Yiyang Wu <toolmanp@tlmp.cc>, linux-erofs@lists.ozlabs.org,
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 19/24] erofs: introduce namei alternative to C
Message-ID: <20240917074429.GE3107530@ZenIV>
References: <20240916135634.98554-1-toolmanp@tlmp.cc>
 <20240916135634.98554-20-toolmanp@tlmp.cc>
 <20240916170801.GO2825852@ZenIV>
 <ocmc6tmkyl6fnlijx4r3ztrmjfv5eep6q6dvbtfja4v43ujtqx@y43boqba3p5f>
 <1edf9fe3-5e39-463b-8825-67b4d1ad01be@linux.alibaba.com>
 <20240917073149.GD3107530@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240917073149.GD3107530@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Sep 17, 2024 at 08:31:49AM +0100, Al Viro wrote:

> > After d_splice_alias() and d_add(), rename() could change d_name.  So
> > either we take d_lock or with rcu_read_lock() to take a snapshot of
> > d_name in the RCU walk path.  That is my overall understanding.
> 
> No, it's more complicated than that, sadly.  ->d_name and ->d_parent are
> the trickiest parts of dentry field stability.
> 
> > But for EROFS, since we don't have rename, so it doesn't matter.
> 
> See above.  IF we could guarantee that all filesystem images are valid
> and will remain so, life would be much simpler.

In any case, currently it is safe - d_splice_alias() is the last thing
done by erofs_lookup().  Just don't assume that names can't change in
there - and the fewer places in filesystem touch ->d_name, the better.

In practice, for ->lookup() you are safe until after d_splice_alias()
and for directory-modifying operations you are safe unless you start
playing insane games with unlocking and relocking the parent directories
(apparmorfs does; the locking is really obnoxious there).  That covers
the majority of ->d_name and ->d_parent accesses in filesystem code.

->d_hash() and ->d_compare() are separate story; I've posted a text on
that last year (or this winter - not sure, will check once I get some
sleep).

d_path() et.al. are taking care to do the right thing; those (and %pd
format) can be used safely.

Anyway, I'm half-asleep at the moment and I'd rather leave writing these
rules up until tomorrow.  Sorry...

