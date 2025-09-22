Return-Path: <linux-fsdevel+bounces-62364-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6740B8F034
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 07:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C02DF17ABF6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 05:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E01F2236E8;
	Mon, 22 Sep 2025 05:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="NMdcP4Dt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287972F0C63
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 05:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758518466; cv=none; b=mcMJwjAJpd2TEo+kQltAq87+wmmCEqO8Y7t57u307m4MDbjREW6SoRhqSyhxH/4qPzG14odnm3LsaL+atzj/G8J/LZwhsvbSMht0zPTMMNEnJZ3LuRAU6++5Hebw4/qrvHB4uNxvuJmeo/gy4cHze0NmEYtd595FTmELcSLu1UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758518466; c=relaxed/simple;
	bh=3VL+F8R32wCEbikEcjWZNF4VxAsjRjfejVXk+7Xgd6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OuuEMyKn5mcFFCZlL+0dFRMBA9O7oWfVFx1HHu+z6Qfv/xnuaprxMjAq/CBzMroi/ES9E8WVfdmJXDLTeuL8KJxkhIIb7mTsGbHJUChe1rOOPw/1t7Qd6G0UDBXQaxDkXBJi/aS58SWoafOAQCeWeMfq7zynaV+HS9DoHN1aRjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=NMdcP4Dt; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xgpzkAdkLG0lw1YyWubZTkRGA6u31MLUEo2h37XUmbg=; b=NMdcP4Dtk+PTSmhdx87d48Uh4S
	JpoN5hUZKZe3+SmXqSRCJASqtuT7tX6eHDjRkkawQQpKNXj6UF9baew2ss5raheANjMnOh/s3UN/G
	OnmOqFOI446pTDoVt5hlHLWiP9p4vS9Hek6IIMUg09OwuYFmIJ6+Bbx8sn+UsThwVFTGgGfSg50If
	J7ijgg0tgrpUv1Gs+SwJY9zjAoMznXAwZht6pzROneYWG2bPxhL2mBWSKtmyzfCYgI/nev1tItvnR
	AOwv2JlfQ3khSvU9K8Y2o1yK/P3g1xHTTD88RooTahmhGL181H/TuPCDM+ep5xMuuxCdZwHSC39Ey
	lK0zCbpw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0Yyy-00000008DsL-45S7;
	Mon, 22 Sep 2025 05:21:01 +0000
Date: Mon, 22 Sep 2025 06:21:00 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 5/6] VFS: rename kern_path_locked() and related
 functions.
Message-ID: <20250922052100.GQ39973@ZenIV>
References: <20250922043121.193821-1-neilb@ownmail.net>
 <20250922043121.193821-6-neilb@ownmail.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922043121.193821-6-neilb@ownmail.net>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Sep 22, 2025 at 02:29:52PM +1000, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
> 
> kern_path_locked() is now only used to prepare for removing an object
> from the filesystem (and that is the only credible reason for wanting a
> positive locked dentry).  Thus it corresponds to kern_path_create() and
> so should have a corresponding name.
> 
> Unfortunately the name "kern_path_create" is somewhat misleading as it
> doesn't actually create anything.  The recently added
> simple_start_creating() provides a better pattern I believe.  The
> "start" can be matched with "end" to bracket the creating or removing.
> 
> So this patch changes names:
> 
>  kern_path_locked -> start_removing_path
>  kern_path_create -> start_creating_path
>  user_path_create -> start_creating_user_path
>  user_path_locked_at -> start_removing_user_path_at
>  done_path_create -> end_creating_path
> 
> and also introduces end_removing_path() which is identical to
> end_creating_path().
> 
> __start_removing_path (which was __kern_path_locked) is enhanced to
> call mnt_want_write() for consistency with the start_creating_path().

Documentation/filesystems/porting.rst, please.  Either in this commit,
or as a followup.

