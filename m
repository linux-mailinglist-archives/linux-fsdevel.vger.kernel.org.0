Return-Path: <linux-fsdevel+bounces-57076-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D81B1E915
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 15:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 215073B9A5C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 13:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E69D27BF85;
	Fri,  8 Aug 2025 13:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMX2tSbI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D272D20ED
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Aug 2025 13:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754659381; cv=none; b=DaBvV2yfaZX4QPZcknMTH7FSQ4aNOFzrY4THupg1DImDXKypzGIvOKkRHIlEWVynu1bKmLh5y1lQqZqK3R1LGW84EQ6vTWwZTvyp6w881Y02kkEl0QKbRIzNXsPovqU11CMj1xqWHH87LifAS7FyIWYpHKzjyMxhTCgh52XdBMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754659381; c=relaxed/simple;
	bh=Rasn6gZDmuaTAbIcN7yPrKyPdF6QBA7QrA9TlootmP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eBoeGA8uvmW/O4kZQTz7wQ8J+ykPXlTM972TYZauHg4fkyldehOTs+GNh8M7Vx6kgvxmFEcMgluxISCIvZ882XnSMlM3sk+I4fendcIagOLSYzJH+vHqfisRJSes0DoejmifgFNMew95UC8FsaCUq8qoNEWbDYiKeyaNaSCZFck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMX2tSbI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6713C4CEED;
	Fri,  8 Aug 2025 13:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754659381;
	bh=Rasn6gZDmuaTAbIcN7yPrKyPdF6QBA7QrA9TlootmP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WMX2tSbIPgbUe4F6viCg1Go0/eAl0IvBjcad0RQVEQ7R/xo1zDWIUCBVVsgTGrBO5
	 Zvy1bibxf/3jnxInsjJSN0Wy0He47RAUeRWLkBPTOJCDkdqllubmU8Ns1lvnvBoxWI
	 jNJ+FumMPRaAXiprEMT2m2l/s4SykCvh4WQWIiEEb8VmWKOQtWmXY6Y1gkvhH+NfNG
	 x5vkCYYLNZDlqFFubOmv6emDb9MKCn72sn1kpyAQn4V9R0YpiiO1GFHL+UR2CDI1Cs
	 Ej5Z8rXcNpo4h6Koz2cvLKz3ayYQlOp56h0PfqMyskeOXayZZ3e596b5qvGNKN0jri
	 osOCE48WgOZ9A==
Date: Fri, 8 Aug 2025 15:22:58 +0200
From: Christian Brauner <brauner@kernel.org>
To: Josh Triplett <josh@joshtriplett.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: futimens use of utimensat does not support O_PATH fds
Message-ID: <20250808-ziert-erfanden-15e6d972ae43@brauner>
References: <aJUUGyJJrWLgL8xv@localhost>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aJUUGyJJrWLgL8xv@localhost>

On Thu, Aug 07, 2025 at 02:01:15PM -0700, Josh Triplett wrote:
> I just discovered that opening a file with O_PATH gives an fd that works
> with
> 
> utimensat(fd, "", times, O_EMPTY_PATH)
> 
> but does *not* work with what futimens calls, which is:
> 
> utimensat(fd, NULL, times, 0)

It's in line with what we do for fchownat() and fchmodat2() iirc.
O_PATH as today is a broken concept imho. O_PATH file descriptors
should've never have gained the ability to meaningfully alter state. I
think it's broken that they can be used to change ownership or mode and
similar.

O_PATH file descriptors get file->f_op set to empty_fops when they're
opened. So anything that uses file operations is off-limits (read,
write, poll, mmap, sync etc.) but anything that uses inode_operations
(e.g., acl, setattr) or super operations isn't per se. So that scheme
isn't great. It shouldn't matter whether a write-like operation is
implemented on the file or inode level.

People do keep poking holes into O_PATH semantics at random. We're
constantly fighting off such attempts because they would break the few
useful promises that O_PATH file descriptors still give.

