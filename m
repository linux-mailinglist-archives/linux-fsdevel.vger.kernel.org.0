Return-Path: <linux-fsdevel+bounces-59631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DEC2B3B7B0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 11:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0B7B566386
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 09:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1551304BC5;
	Fri, 29 Aug 2025 09:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gF28cR+B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0C7264612
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 09:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756460949; cv=none; b=XtJD1E/+QY75LducF9Kmsd0EL4LzJTTQ4eq6ooT4fm/o6iqWr+9UYsegRTU9wT1beDDKK1VHTE47jcCIGHn25uE5PPiVnoSGNbAOV+98Ag59h0aHj6R3kiXpKDpS6xa68l2ZJExyc+lj0tUrToig7nT9stu+fzITwox2Tt1VXs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756460949; c=relaxed/simple;
	bh=PzCz+WHpLsdmxJPZS69SRDso3QNp/rZUrs3cZ/weLdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WRd/oV5rgMHZh74C0jvY1rzS54FiTbOYnojtlLekc7l1QgMzUCyigp4Bc+Kmv4DIc1KYHAOl7IuWZKQ7IQoyGP4IIh/d7athAtk4hzOzCtOgBFHaXQJK435W0jFLPwQqC7a7lV8J/7ivHZ5YBUUnwzoWMVCbHWZSKaCxpzUWIbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gF28cR+B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87334C4CEF0;
	Fri, 29 Aug 2025 09:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756460947;
	bh=PzCz+WHpLsdmxJPZS69SRDso3QNp/rZUrs3cZ/weLdM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gF28cR+BXLOJA4tE/246pDFsKkbLy9L9s48fg6Y8M4bnMUy1KkzBqrb5cMeA9SmoK
	 7I5gh4JYSytQ0QtkojsQJ/1JeT2HByFESQnrTXBPBxZkbXHTABYZOb0jegE0FU79lJ
	 nezVDvxSPeUGbgI1+6URfQSQlAGV6FbLt3P+SsxAJjsTaNyWfIcn14uvFsJdiPCKV4
	 MUD+6M8WulHjF6NkyA7f+5YgQdqOxJbbAXeDqDUvek76S/MM2tM3RnnCEp6o/tcAZj
	 o+COVDgUSe2DtUmf99FobZ47CRlm2xDnoO074XGX52x7j+5rXJp49Qei+OM/4Td3i6
	 s3KDgZ0RyMFYg==
Date: Fri, 29 Aug 2025 11:49:04 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH v2 02/63] introduced guards for mount_lock
Message-ID: <20250829-ruhen-ertrinken-6a2ef076cd3d@brauner>
References: <20250828230706.GA3340273@ZenIV>
 <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
 <20250828230806.3582485-2-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250828230806.3582485-2-viro@zeniv.linux.org.uk>

On Fri, Aug 29, 2025 at 12:07:05AM +0100, Al Viro wrote:
> mount_writer: write_seqlock; that's an equivalent of {un,}lock_mount_hash()
> mount_locked_reader: read_seqlock_excl; these tend to be open-coded.
> 
> No bulk conversions, please - if nothing else, quite a few places take
> use mount_writer form when mount_locked_reader is sufficent.  It needs
> to be dealt with carefully.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

