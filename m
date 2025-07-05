Return-Path: <linux-fsdevel+bounces-53998-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E12EAF9CE8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Jul 2025 02:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C88A81C47B77
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Jul 2025 00:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05ACE376F1;
	Sat,  5 Jul 2025 00:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="NnoVZDgn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB0E79F2;
	Sat,  5 Jul 2025 00:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751674761; cv=none; b=r45PXg28qxZK8Nj87ZeD8cwQNfWqOiEq5Yg76p07eNjtrcKYxu0G0DHLyumnjXklVQ6EZYWB25hrQLTE6t0JCqWFXaHA+1fTfRRMAV1tRl16/+ORjC3ZWZLfu2feU5wMaeF/EBKexwlrcwVeEXOWbpSDRltJgKV8ZMQb+w8Wbn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751674761; c=relaxed/simple;
	bh=7KSEMpdQv5K6O+lHIpQ7p5r1UkCpC6IhDPJCq11BzAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lz3/wW6pBacXOkg10cfpBGoKs4dEt015bTgEZYH9XCIpQKn9sYfx6cAAj7sd80/az+cVQf4WsR7xxXcdTHGdeVSYfk1UbwMeot5Kp4ouMe1/OOAVGKOieoqxqdxE/WvZ1FreuYawJCr3/ur70qCMHkguRtJZvkEsr+J7eMhpMFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=NnoVZDgn; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LuJgoONVd4nqFv/9TM+3f7c8gw4kfdDPriGqzKrxWKs=; b=NnoVZDgn75e9F98pgaHn47CXG0
	EDY3IOk7ohVG9n+eTlQaXv4aSW87xBnyRegkrV3psIKd+tlomm3dg1xeytdHjWhcTiQiL8S1PkttZ
	CahZ898r9gWBygzwcXw2T5kqfkw9q1BEzfUj/6vZH1o1Fin9jZJAYGnb3es2Zo+l2sUNPu4lL2Mw0
	Jcgfb0D3em22Djgz8RAne4Td9hLwlf8WgxKx5SHG9wIDukuOJO0TtPw208dl2wdCFf0LBzZQ7uF4I
	DGG/iaztfImBsC+joYFA2HbU7aTUd0sOks2iOPgjbRPNWHFNPUbXy8zfSv0vOS3KeMm2stWTnV6Li
	WG3FoyOg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXqcc-0000000G8ZK-07h3;
	Sat, 05 Jul 2025 00:19:14 +0000
Date: Sat, 5 Jul 2025 01:19:13 +0100
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
Message-ID: <20250705001913.GV1880847@ZenIV>
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

> +struct v9fs_ino_path *make_ino_path(struct dentry *dentry)
> +{
> +	struct v9fs_ino_path *path;
> +	size_t path_components = 0;
> +	struct dentry *curr = dentry;
> +	ssize_t i;
> +
> +	lockdep_assert_held_read(&v9fs_dentry2v9ses(dentry)->rename_sem);
> +
> +	rcu_read_lock();
> +
> +    /* Don't include the root dentry */
> +	while (curr->d_parent != curr) {
> +		path_components++;
> +		curr = curr->d_parent;
> +	}
> +	if (WARN_ON(path_components > SSIZE_MAX)) {
> +		rcu_read_unlock();
> +		return NULL;
> +	}
> +
> +	path = kmalloc(struct_size(path, names, path_components),
> +		       GFP_KERNEL);

Blocking allocation under rcu_read_lock().

