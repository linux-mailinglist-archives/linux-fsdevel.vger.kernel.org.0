Return-Path: <linux-fsdevel+bounces-53999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D2BAF9CED
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Jul 2025 02:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 470771C86578
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Jul 2025 00:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018B172607;
	Sat,  5 Jul 2025 00:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="rir315Ua"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B34C79F2;
	Sat,  5 Jul 2025 00:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751675142; cv=none; b=pf8OR0V1QnRe8oWQGLleTLCWqTj9mr3J5+T8jipzqYoGlAkUcYqQe0ILBJwndEQBlodIoD6CHieyXXr5Su5JttqVenbqEACK2FS41Oll/rRpEPCNIVQvHPDCqcXhdGtxE6uZe++3qw36QBRDK82SVWhRhTikBmVafPDVTnBhlVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751675142; c=relaxed/simple;
	bh=BeQeTfmyYnm2mOzsi53634ox7T6k5A28RilZNxYG6lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MekupcZh5ZaPDodzkYg1GrekcOEv5ABMUb312EYc/zdOHN6yD0ydjeLzMDvjcRScTQCdiCuQ2z78J2oHFXXERHTnQ8kJro5WUQdzPPhGdz6k5+Ffu4b5JElE2CRdVxgefvFmQAAdm8E5nA52ilrykkurbWDtpaoC1rB09B9zhgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=rir315Ua; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XwhfMgFq3ICeCByvEN6EISqFtxiGdSUTFXxixMwtQCs=; b=rir315UajBgbPeDrAOAOJfKkJ7
	y+C4vyqiJWdGmy+lxxnZr90QpWrbrff7kRU0cJ/yKNiIJx7vfd5vF3OFzxQH45pq8XssJcldqQLbk
	JSbxHR6YssgyCrtMgEDGAFugN5L82G9qfaR6A8haClZTE6DbbrusMd7ghNTnJLzI/SHrWXcLnbNL8
	QBgZjET8shnJztCRFuPdroohVDTlbYNbMXlMG9z2Vct+wIqbOJDTQywQHE57+I0oZI+W/OLIDWSav
	tmxpRm5AF+CLxLGgiRnFCAof5jpuABsz3w19dD6R1PVa18Pfw6ZMAPCsohY5xbllN8AnRy1gT5rLQ
	ogw2rf5w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXqim-0000000GAip-46EE;
	Sat, 05 Jul 2025 00:25:37 +0000
Date: Sat, 5 Jul 2025 01:25:36 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Tingmao Wang <m@maowtm.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org, Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Matthew Bobrowski <repnop@google.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 1/6] fs/9p: Add ability to identify inode by path for
 .L
Message-ID: <20250705002536.GW1880847@ZenIV>
References: <cover.1743971855.git.m@maowtm.org>
 <e839a49e0673b12eb5a1ed2605a0a5267ff644db.1743971855.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e839a49e0673b12eb5a1ed2605a0a5267ff644db.1743971855.git.m@maowtm.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Apr 06, 2025 at 09:43:02PM +0100, Tingmao Wang wrote:
> +bool ino_path_compare(struct v9fs_ino_path *ino_path,
> +			     struct dentry *dentry)
> +{
> +	struct dentry *curr = dentry;
> +	struct qstr *curr_name;
> +	struct name_snapshot *compare;
> +	ssize_t i;
> +
> +	lockdep_assert_held_read(&v9fs_dentry2v9ses(dentry)->rename_sem);
> +
> +	rcu_read_lock();
> +	for (i = ino_path->nr_components - 1; i >= 0; i--) {
> +		if (curr->d_parent == curr) {
> +			/* We're supposed to have more components to walk */
> +			rcu_read_unlock();
> +			return false;
> +		}
> +		curr_name = &curr->d_name;
> +		compare = &ino_path->names[i];
> +		/*
> +		 * We can't use hash_len because it is salted with the parent
> +		 * dentry pointer.  We could make this faster by pre-computing our
> +		 * own hashlen for compare and ino_path outside, probably.
> +		 */
> +		if (curr_name->len != compare->name.len) {
> +			rcu_read_unlock();
> +			return false;
> +		}
> +		if (strncmp(curr_name->name, compare->name.name,
> +			    curr_name->len) != 0) {

... without any kind of protection for curr_name.  Incidentally,
what about rename()?  Not a cross-directory one, just one that
changes the name of a subdirectory within the same parent?

