Return-Path: <linux-fsdevel+bounces-71989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B52CDA4C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 19:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 376A3302CF76
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 18:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE5E349B07;
	Tue, 23 Dec 2025 18:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Ok75Ef0t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EF220FAAB
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 18:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766516320; cv=none; b=qc/ZbqXrwMTTZ6um2kxt7L6/nXEzD/9OlvAcrQD/L9dsh3CDiu/RbUTrzzTKuaL57i2N7mh1PgPX5AW2uiTyosLbfAJX24UgBlZqbZIIjwy7+mOui/8gJKxTogACiWOn7JXFOikHmDxEJySuP1Z3oiv+HC+2HENckoBI6/2IV3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766516320; c=relaxed/simple;
	bh=jepJnbYttHYAcP6fT/tLjkqj/+x85LRlqkoUppJfAC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1zUOBz7Tabu2U0PkBOuV3bPxOfvbBme4k6nt5Pcl4fjuFDiTZqKpIRdYlYZdwnPpVqfx/SucqsqsZ+ETbuSYnMqTQuNnfjPD8aOfxVtskXqlWh0BGKwfImaiWZ0zWN5rMkY9GgQ1Rn8upNCXOCsyQhJaBTd2hxntOsRyN33MV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Ok75Ef0t; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lx0b5AMUsuUhLdZXAzrpovUEe1dbSBwKnb9MqUbXvWk=; b=Ok75Ef0tZcThdvSD5lV0GOgq6Z
	3z4+Kss4ryc0rdBp6UM3EEAlhd4gHR2V5bPwqjqABrkO+p1XQJ8D9WXlKt/ptyvKBUGtTvfHxuGv2
	TGAWqSFxDCky95lIYV4seATXYXEeJ/U91pqckS+yyV3G/LLbUg68kAGZkMFCoMA1DsczxbTVeRkv/
	TdTSS07FYct7xywN4uu8H4/H2bW7GtWOV4PO/Cs8Jk6D41q3fhpWTosxQuLBnErPBoJtYjRaZlrR0
	32S+Kg9Lbqb5h2hDaJrGHS4xW2zsY318KJT3cDZA8dBtq7owTRcicoTUQ0wRCSPkoo50Zm9QiUlCe
	J+DimYXQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vY7bS-000000073KI-0Z1j;
	Tue, 23 Dec 2025 18:59:26 +0000
Date: Tue, 23 Dec 2025 18:59:26 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Andrei Topala <topala.andrei@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: allow rename across bind mounts on same superblock
Message-ID: <20251223185926.GD1712166@ZenIV>
References: <20251223173803.1623903-1-topala.andrei@gmail.com>
 <20251223175128.GC1712166@ZenIV>
 <CAF8SvsB0yQC7Meni=UQEehaT5YBQx2uEas8irhg3vWstdM_JVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF8SvsB0yQC7Meni=UQEehaT5YBQx2uEas8irhg3vWstdM_JVA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Dec 23, 2025 at 08:27:58PM +0200, Andrei Topala wrote:
> Rename would not work if the user doesn't have the right permissions. The
> patch calls `mnt_want_write()` on both mounts and uses each side's idmap
> for permission checks.
> 
> This would make renames faster in this case. Currently, users who have
> write permission on both mounts get EXDEV and must fall back to copying the
> data, which can be slow for large files.
> 
> I initially attempted to handle this in userspace (in coreutils mv), but
> it's more complex there. It requires parsing /proc/self/mountinfo to
> translate paths through bind mount roots, and it only benefits mv. Other
> tools that call rename() directly would hit the slow path.
> 
> Is there a specific isolation scenario where allowing rename between
> same-superblock mounts would be problematic? I'd like to understand the
> concern better.

Consider fun with moving a subdirectory of a mounted subtree to another
mounted subtree, while some process has been chdired into it, for
starters...

