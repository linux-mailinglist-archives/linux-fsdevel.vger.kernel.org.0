Return-Path: <linux-fsdevel+bounces-47141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7551A99B74
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 00:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 161CD7AF5EC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 22:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462C51EFF89;
	Wed, 23 Apr 2025 22:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="QvEIh57f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC3319DF4A
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Apr 2025 22:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745446850; cv=none; b=qPv6g53lYW0wv/5qVaqIdngSRIR2aXxwHPqKi0peaWhwJbT7ymDgdpvyDwUDjc57LUBrCLTeVe+OM+8Ja/Xf8kxS8TteNrVG+qS4RjgcvPEjcWnwhnNmuIQOKa9MLKjbC44hIAkejL8n4G0u4cYOc+JkJhrQoEZT9aAWGpxbZAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745446850; c=relaxed/simple;
	bh=btuYSVqpucVXUNHOvbsjp6TBOOqsUF2Tw1UqxEx88Rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KSWM8NDR8QYrzT7hxIAr0Y1LVrrvRG/RvqNd3XBaW3bpysZGzO1Zv6xAY8erDuGV+UU19aoZp0j6YGUCRwr/MFRFSfy27XhDT3txLrHCkvWJ64Tmh/qKrhN5s1ymzQeJ4QIsA1qAfa+m2ZTcswQSTsc+3kq3KIZCAKS8Z15EZtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=QvEIh57f; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=u9n5BnKY5QvC3XYHMH47rJHlKf8oibEyW5xRgtCpuqA=; b=QvEIh57fUYLewyZm7y6+FSXdVP
	DXLf/7OosiGME9n/WH3bSgfkuDJ80XRoVMrDrCEGsVgA7nv0VLJkmPWBqQPXkUNXzCnlr84ZJG3Ub
	tjq7daU09CN51UDNW8wS+a80Bchbc9ZZKQdd1VOTxqmmilCOv0apriCeyptvXxIZ1eyqRs7pjGy7f
	RAM1wltvN1fnxk1llrRB6bk9UHIgps3JquQBTk57FbuwTCQjUegxI5tGKQ4kGpYMZG1CGmfGffPA8
	U54oiGtYrHaGYD9mvhlFsq0HV03nSOdhGeTlT21WtY728zoeqsXQWrbACKJehUPB5ug4FZQLfN1EG
	eBCl9vng==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7iST-0000000CGSh-2rhl;
	Wed, 23 Apr 2025 22:20:45 +0000
Date: Wed, 23 Apr 2025 23:20:45 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH][RFC] ->mnt_devname is never NULL
Message-ID: <20250423222045.GF2023217@ZenIV>
References: <20250421033509.GV2023217@ZenIV>
 <20250421-annehmbar-fotoband-eb32f31f6124@brauner>
 <20250421162947.GW2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421162947.GW2023217@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Apr 21, 2025 at 05:29:47PM +0100, Al Viro wrote:
> On Mon, Apr 21, 2025 at 09:56:20AM +0200, Christian Brauner wrote:
> > On Mon, Apr 21, 2025 at 04:35:09AM +0100, Al Viro wrote:
> > > Not since 8f2918898eb5 "new helpers: vfs_create_mount(), fc_mount()"
> > > back in 2018.  Get rid of the dead checks...
> > >     
> > > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > > ---
> > 
> > Good idea. Fwiw, I've put this into vfs-6.16.mount with some other minor
> > stuff. If you're keeping it yourself let me know.
> 
> Not sure...  I'm going through documenting the struct mount lifecycle/locking/etc.
> and it already looks like there will be more patches, but then some are going
> to be #fixes fodder.

BTW, could you explain what this is about?
        /*
         * If this is an attached mount make sure it's located in the callers
         * mount namespace. If it's not don't let the caller interact with it.
         *
         * If this mount doesn't have a parent it's most often simply a
         * detached mount with an anonymous mount namespace. IOW, something
         * that's simply not attached yet. But there are apparently also users
         * that do change mount properties on the rootfs itself. That obviously
         * neither has a parent nor is it a detached mount so we cannot
         * unconditionally check for detached mounts.
         */
        if ((mnt_has_parent(mnt) || !is_anon_ns(mnt->mnt_ns)) && !check_mnt(mnt))
                goto out;

Why do you care about mnt_has_parent() here?  mnt is the root of subtree you
are operating on, so that condition means
	* any subtree (including the entire tree) of caller's mount tree is OK
(fair enough)
	* full mount tree of anon namespace is OK
	* nothing else is acceptable

What about partial subtrees of anon namespaces?  Restriction looks odd...

