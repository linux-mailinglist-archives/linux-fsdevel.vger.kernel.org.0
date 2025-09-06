Return-Path: <linux-fsdevel+bounces-60413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28ABBB46958
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 07:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F0917B0588
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 05:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F1C27A455;
	Sat,  6 Sep 2025 05:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="jKTCEmwo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEE2213E90
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Sep 2025 05:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757137964; cv=none; b=Sp/WE16FP+VN7HcbOfjOLk79lBU9ROj02BbxmLg1CBFExIsSI1AMYUtFdS4CfaVd+57wVUNcFWgmwcb1FCC7Z3bEesHTCxKNFMXaCBoGmtnXKCEK5JMqVvU2kTCxbxusoD9UHwc8xKM1vAc4ad3e9vOmri0fV2HQLkx94pgXOoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757137964; c=relaxed/simple;
	bh=t8cZyuLNU/8oCDibkcn+E+PeqlXgYB2BZwuZ3lVDk84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GNR2AKztw1uk4gqNNszABJ+9j4vjW70F2EnClOSm9CpVHTxIuNJ8Vc6luK9BZAlGBbTk55oczmsMOr5tz3HUSMG17/nI7iBE4S+lj78pUZYxD2C89YbLbujba0YcWuaUG0o/3QPresBMspln8vGNFiYLAqTaOlWKhJNPpw+3Bn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=jKTCEmwo; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VCzrWvZFyyAOsVvfE8R711pjB6qmnO+kZ5FyggeR6V0=; b=jKTCEmwoo0aLVx0/tqbaD+WfN+
	CLh5ZJ8ufs9DvFwpH2fUjT8AJyycJkHZGAFvf+uLX+wDyAD70PGj70d0GEM2fnjMtdzn6/e54UkAJ
	d0qWvKidWhuxlGaNTrDeszVibQ216lt5J+4Xi1JWS7CbX76HiSO7xTDlj03QAliLtXddZtTf6Ri9K
	JpRIGuApHUvz9omR3tk1bcLJdwgCzO2vV/Na6iNULo+FQMQN9gVCg6f8Vh8ZY+7v3OsuD0ilayHWd
	itToEMHaSBCHyjygfGDDYMi4vC0d8Ed1BYQ+OslWKtqAW310wKJ/3Km5Uc9NbhIMn1lXXJJJQtQJF
	rwf0y3OA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uulqq-0000000FdWi-2wXV;
	Sat, 06 Sep 2025 05:52:40 +0000
Date: Sat, 6 Sep 2025 06:52:40 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@ownmail.net>
Cc: Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/6] fs/proc: Don't look root inode when creating "self"
 and "thread-self"
Message-ID: <20250906055240.GT39973@ZenIV>
References: <20250906050015.3158851-1-neilb@ownmail.net>
 <20250906050015.3158851-2-neilb@ownmail.net>
 <20250906055005.GS39973@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250906055005.GS39973@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Sep 06, 2025 at 06:50:05AM +0100, Al Viro wrote:
> On Sat, Sep 06, 2025 at 02:57:05PM +1000, NeilBrown wrote:
> > From: NeilBrown <neil@brown.name>
> > 
> > proc_setup_self() and proc_setup_thread_self() are only called from
> > proc_fill_super() which is before the filesystem is "live".  So there is
> > no need to lock the root directory when adding "self" and "thread-self".
> > 
> > The locking rules are expected to change, so this locking will become
> > anachronistic if we don't remove it.
> 
> Please, leave that one alone.  FWIW, in tree-in-dcache branch (will push
> tomorrow or on Sunday, once I sort the fucking #work.f_path out) there's
> this:

PS: you do realize that we have similar things in devpts, binder, functionfs,
etc., right?  What's special about procfs?

