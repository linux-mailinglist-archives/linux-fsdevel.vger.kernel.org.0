Return-Path: <linux-fsdevel+bounces-12583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 808AD86152B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 16:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 367411F250D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 15:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5CD82863;
	Fri, 23 Feb 2024 15:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngTjYv9q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B4D7175E
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Feb 2024 15:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708700794; cv=none; b=R1HgOxfuTocWJSbQcO7f6JLTLFgbkGNH8e/6xPdbNJ9MRfUmi9SzRr164o3Dh3nmgE9reyrdGhxZRwx0pANj+vA4cfQMwNU8jcQMuXnmdietR6WkXe/iRgU7+ZYbxbs4wamPldUG3HTRWtP6BKPIV7B6BU46Eysy0SvKRzpKuvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708700794; c=relaxed/simple;
	bh=AaLCaJVHPp6COwKZI3iR9Kti/fzyBR+PBas/PeMKW6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jdT1mIXFJhDcbESmKtsSiHzJpEXB5+7uyytJc3R7MyMbi8Ohgy5ZBhWbjsI0G87Ysc4Q1UvANp1M/dtc9fHk3F6u6Vmz4WqcqOmvGdWC6by1Mh7dZWB9IVL33CQKOBSQafnKef1M4Ny1ybeGVosnge44FQOzzvUumnDZpjm6oT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ngTjYv9q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65959C433F1;
	Fri, 23 Feb 2024 15:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708700794;
	bh=AaLCaJVHPp6COwKZI3iR9Kti/fzyBR+PBas/PeMKW6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ngTjYv9qyNTMkFqp7RFpQ6f09MYd3qtOxJ7rswCQ+JlEC8yuDTvjYBT+GbyyQKBrv
	 wFlLTxsAEv4MYdIp+3Wb6uETLTaBlnH+bMImUT0mGCzkrORIQtHTwwW27Y/fYBVTng
	 tCSHGjoxYtczGVF04S6QdqatuIBjdmiQ5f1bO91VGgh5aTt6dtjiUgAEPFu3y8HMhr
	 ki5pauyiv7lUV//nZGH1W7ElFfX12YsT1ecahon2jkqoRH7kmMrEIThr39Z+gN/VGQ
	 UawcN0/v9HmM0VuzBRniUOKENfLq6nEBjtQsgeLxUQOzCUXalAh4fRxOoBCq0+8p3b
	 VidJY+pUQAYlA==
Date: Fri, 23 Feb 2024 16:06:29 +0100
From: Christian Brauner <brauner@kernel.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>, 
	Alexander Viro <aviro@redhat.com>, Bill O'Donnell <billodo@redhat.com>, Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH RFC] vfs: always log mount API fs context messages to
 dmesg
Message-ID: <20240223-beraten-pilzbefall-6ca15beab35b@brauner>
References: <9934ed50-5760-4326-a921-cee0239355b0@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9934ed50-5760-4326-a921-cee0239355b0@redhat.com>

On Thu, Feb 22, 2024 at 09:22:52AM -0600, Eric Sandeen wrote:
> As filesystems are converted to the new mount API, informational messages,
> errors, and warnings are being routed through infof, errorf, and warnf
> type functions provided by the mount API, which places these messages in
> the log buffer associated with the filesystem context rather than
> in the kernel log / dmesg.
> 
> However, userspace is not yet extracting these messages, so they are
> essentially getting lost. mount(8) still refers the user to dmesg(1)
> on failure.

I mean sure we can do this. But we should try without a Kconfig option
for this.

But mount(8) and util-linux have been switched to the new mount api in
v2.39 and libmount already has the code to read and print the error
messages:

https://github.com/util-linux/util-linux/blob/7ca98ca6aab919f271a15e40276cbb411e62f0e4/libmount/src/hook_mount.c#L68

but it's hidden behind DEBUG. So to me it seems much easier to just make
util-linux and log those extra messages than start putting them into
dmesg. Can't we try that first?

