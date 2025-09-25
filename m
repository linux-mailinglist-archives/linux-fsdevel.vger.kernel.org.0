Return-Path: <linux-fsdevel+bounces-62800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 605C2BA1186
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 20:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E65E1C22E8A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 18:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FE8315D31;
	Thu, 25 Sep 2025 18:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="oZfkZfD6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AB52F25FE
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 18:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758826597; cv=none; b=rxxzranvehoZp/UIqa5c0YRhHMEzxcdEFGgCkxBC8eZFHd33hWnIdALoh/E0AdB/qgDqUBBTI3kEaGMbz6rEAb9LkJOVSFZ7ShkrFj/5JQcGs0pYrtxgd4dTxXzTCR+OxzsG9F70NPFUeTsAb+bL6pbr65XR2FQSZ2f8GArikUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758826597; c=relaxed/simple;
	bh=/pui4F0/5pS3MnewNrcoo20YhsQnRrYGlBgJ9emeIV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nwe/tCkqsuEHyLg+t9HzZ56SfCrNfNsadGhc7uzdYx8f/XDIcyzD2rtO03n33lLok42dSEmxg73YfL5yom2VuHLaz5Ow+eVIsCd6FBRUGDeDwRaPxt7mcsuoct51Sr3VTRT64npP3wcXAFfUE0wCuInpURJgz48jOWs7cJgCBnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=oZfkZfD6; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dfArm5SLzNgxfSOBk2RFS1NjJEi8CMhoa8CMOAIpVjE=; b=oZfkZfD6Ya8tha+tGyJ7+mv+xo
	KlU14xZCI8+Mzpo3UDGI101ErhXFR+WMDGN/3fMOjeI6WNtepqmMcGSH5LKc3rtHf9efO1oktFBRa
	Ff3MWNXlhIcyJX8utUldIqHTdluRvj0UNgAfW/wdmtcYVE6HJi2TQwsDGa5XM2zVYk5ofmS/NGS6H
	zrCggilVpOPTeNyYHPzQ7oN2Qcq8XjFBKMACdxwWqbiaRy+ED1kXkcGy6MlXlhz6FyWWyKurPMdtG
	FrFB15FrxZlFVrI/CK9crm7XGbdtyfagZ9RrvAT9N47ut7XQpbcOS9prC0wB0pNxpYMFFAdCAfx1Q
	dW1qhDlQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1r8o-00000009tsS-2yex;
	Thu, 25 Sep 2025 18:56:31 +0000
Date: Thu, 25 Sep 2025 19:56:30 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	John Johansen <john@apparmor.net>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] kernel/acct.c: saner struct file treatment
Message-ID: <20250925185630.GZ39973@ZenIV>
References: <20250906090738.GA31600@ZenIV>
 <20250906091339.GB31600@ZenIV>
 <4892af80-8e0b-4ee5-98ac-1cce7e252b6a@sirena.org.uk>
 <klzgui6d2jo2tng5py776uku2xnwzcwi4jt5qf5iulszdtoqxo@q6o2zmvvxcuz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <klzgui6d2jo2tng5py776uku2xnwzcwi4jt5qf5iulszdtoqxo@q6o2zmvvxcuz>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Sep 25, 2025 at 02:28:16PM +0200, Jan Kara wrote:

> This is mostly harmless (just the returned error code changed) but it is a
> side effect of one thing I'd like to discuss: The original code uses
> file_open_name(O_WRONLY|O_APPEND|O_LARGEFILE) to open the file to write
> data to. The new code uses dentry_open() for that. Now one important
> difference between these two is that dentry_open() doesn't end up calling
> may_open() on the path and hence now acct_on() fails to check file
> permissions which looks like a bug? Am I missing something Al?

You are not; a bug it is.  FWIW, I suspect that the right approach would
be to keep file_open_name(), do all checks on result of that, then use
	mnt = mnt_clone_internal(&original_file->f_path);
and from that point on same as now - opening the file to be used with
dentry_open(), etc.  Original file would get dropped in the end of acct_on().
I'll put together something along those lines and post it.

