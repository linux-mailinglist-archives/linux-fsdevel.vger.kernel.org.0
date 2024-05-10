Return-Path: <linux-fsdevel+bounces-19261-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C128C23B8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 13:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDA8A1F2660A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 11:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B3616E898;
	Fri, 10 May 2024 11:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CpkkZ62Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB21D21340;
	Fri, 10 May 2024 11:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715341105; cv=none; b=F7zNiV9egLgiR2gR0HxcTNhJuQFeswdNMLMQzjC+vOE8la7he0VjbaDzkaF7jfAzO9IqNKPnGHeWO3Sq0L4te4+CMZ8GmdBCSFRn0sL/KkTRc3HHq3JyKIO4xrgoF4Wb2jE8Y+EaG5gN5kdmmiPqaS7gVAeEbh6TuFnfNfcSdv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715341105; c=relaxed/simple;
	bh=w3BI4D5JBPl2WXO21E0L6qbAIpFhZSt6nwXLcFPR5QI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IzobMuZRNka8JG/QG8UVkz+jhsFKh1r7BhW6RMzKSUV88u9seUZ+0xGyAgOZ5PA8qlRHlUlzPatRgdhI89EGVjibbES8mC3KEmXf1gWPn3wVb7jIBETe+nc91DSRfDKOWA7NbgwP6dchmaPogsz6so5WGPYJ/0yFz9YsSS+vhBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CpkkZ62Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40505C113CC;
	Fri, 10 May 2024 11:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715341104;
	bh=w3BI4D5JBPl2WXO21E0L6qbAIpFhZSt6nwXLcFPR5QI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CpkkZ62YAEEoEIAyF5eXcSUuk/m62T9XYGeBgMong1LMUDOuEOWgDuThCSVJaTEZk
	 RAXjF9wpNp6SwmIXKtCfcZgEXZtrZMnLy5i5NSbLziB2oQlzxvJtOL6LtKI2C0bKl6
	 SnwjXy99V53wWbaTtXWvU5ZFcQjtgfF82PEhHjAle7jUebtmV0SykQxsHX04xG6CHn
	 hQbUkr5C61PkSqKlLMSTfUgsLS2L7lTr7caAYB1nFDYE9GV2sCrBkqaXdtXVJddgky
	 wmgUYIOmZ7/LojmFQM413k1SE96WG0z+ZCC0F3o4WHmTgCAzgNMtV/uEBYaV9o2baF
	 qqUwKvYSNQHeQ==
Date: Fri, 10 May 2024 13:38:19 +0200
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	Max Kellermann <max.kellermann@ionos.com>, Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: Don't reduce symlink i_mode by umask if no ACL
 support
Message-ID: <20240510-golfball-tastsinn-d148a67476ea@brauner>
References: <CAJfpegtJbDc=uqpP-KKKpP0da=vkxcCExpNDBHwOdGj-+MsowQ@mail.gmail.com>
 <1553599.1715262072@warthog.procyon.org.uk>
 <1554509.1715263637@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1554509.1715263637@warthog.procyon.org.uk>

On Thu, May 09, 2024 at 03:07:17PM +0100, David Howells wrote:
> Miklos Szeredi <miklos@szeredi.hu> wrote:
> 
> > I think this should just be removed unconditionally, since the VFS now
> > takes care of mode masking in vfs_prepare_mode().
> 
> That works for symlinks because the symlink path doesn't call it?

All of the mode handling should now be done correctly in the VFS (see
Miklos reply as well). In general the less fs specific mode handling we
have, the better because we've been bitten by this before.

