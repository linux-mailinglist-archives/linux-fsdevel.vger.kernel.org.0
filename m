Return-Path: <linux-fsdevel+bounces-42283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28028A3FD98
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 18:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DDB6425BA8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 17:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A472505C9;
	Fri, 21 Feb 2025 17:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PyN+lkgy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9B124C66F;
	Fri, 21 Feb 2025 17:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740159496; cv=none; b=Lo9Kowpwur8ZILY8eER7qAnqR58EXYyKkh3LaVunG3UOKQcLj0M1nA0EgdZ2E9E/4Vo7MQktdZgn5jfZF9CkxbdeZyLfLJw2efKcHTsJ1Yle6L1/zvC9QyhRjDDEPZ53Iw1eLyEEaWs+jcU2BJEzK6o/qW21rvBgKdWlTz6ILoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740159496; c=relaxed/simple;
	bh=M0xkvub62ij39qNlsVKwNmNYQRQYXeThmbhJUaA3gZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MK9vep5ybMk6mwmKAEHPnTGLl1/qPJVvP+bq1g4rMPG2ZYK9GQEYLbmrkpheR+HDk+T430eDcjCaOIGH4mWjeEKFO1CPMddFHgSWdZBMwwIETI74ysV0X4SVv6HGVu7BcRh2vpRaUxEppKyxgx4sJJ9TBRQIQt0/1VR59qbWnWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PyN+lkgy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C62C4CED6;
	Fri, 21 Feb 2025 17:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740159494;
	bh=M0xkvub62ij39qNlsVKwNmNYQRQYXeThmbhJUaA3gZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PyN+lkgyL/OYiGKfYOLeqT940xLokBS34QCmwAtAvt05Ah3VW5gtpQl32nAP1MB4N
	 YMfV48lpqihiB7bccVxJxpe1q0iH5RouO/g8ZMOnsNXjPO5nEmMGUWDHkRyMmvkNbu
	 bFd6ChTvr9+Ea4ZO3yUt5fENsnbJopipae/ARnQP5yFszwdM6RE7n/doceWc2wkW8C
	 0WZkKr/32mkZF9gBUijG5xBzqAGr3gBmFWiZaWlbxbJTqKatMgAB1xIGZpscH9cqWz
	 cSc+ExPXkxqoMKqZXMRN9eCEhrRnv2Wos8FBz6Z7aim71voZxac4YnjF2GEMUrrIj3
	 eQKN4an5RpEKA==
Date: Fri, 21 Feb 2025 09:38:11 -0800
From: Kees Cook <kees@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Ronald Monthero <debug.penguin32@gmail.com>, al@alarsen.net,
	gustavoars@kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] qnx4: fix to avoid panic due to buffer overflow
Message-ID: <202502210936.8A4F1AB@keescook>
References: <20231112095353.579855-1-debug.penguin32@gmail.com>
 <gfnn2owle4abn3bhhrmesubed5asqxdicuzypfrcvchz7wbwyv@bdyn7bkpwwut>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gfnn2owle4abn3bhhrmesubed5asqxdicuzypfrcvchz7wbwyv@bdyn7bkpwwut>

On Fri, Feb 21, 2025 at 03:51:23PM +0100, Mateusz Guzik wrote:
> On Sun, Nov 12, 2023 at 07:53:53PM +1000, Ronald Monthero wrote:
> > qnx4 dir name length can vary to be of maximum size
> > QNX4_NAME_MAX or QNX4_SHORT_NAME_MAX depending on whether
> > 'link info' entry is stored and the status byte is set.
> > So to avoid buffer overflow check di_fname length
> > fetched from (struct qnx4_inode_entry *)
> > before use in strlen to avoid buffer overflow.
> > 
> 
> Inspired by removals of reiserfs and sysv I decided to try to whack
> qnx4.

I have no strong opinion here beyond just pointing out that it appears
that the qnx4 fs is still extant in the world. QNX itself is still alive
and well and using this filesystem based on what I can find.

-Kees

-- 
Kees Cook

