Return-Path: <linux-fsdevel+bounces-51725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D33ADAD32
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 12:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E52B188AAE2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 10:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E4427AC30;
	Mon, 16 Jun 2025 10:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V9HTsgIA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6E51EFFB8
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jun 2025 10:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750069250; cv=none; b=QDLTtzJtYpXPymTa1H51BTQmtogDCLYheo1lfhpkt9y1jetiI+AJ1YOn+FOX/nb8ydjgmW8Z7BpwXnr8dowe0BMOy7RfrsquIcHtSBvkAcfFhUby1zHLapZvrYLe+HEHSHm+/hsgW7/BsNE7aAbMnRFAWgmIYLdbLwPn7AIcetM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750069250; c=relaxed/simple;
	bh=TzivUek7CnXdibJ+G8e6IXHDQ/J8rVZuczOdC5XiQtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bq2R1GfuybaT8czsIqKTo6R8cn9tLBar8HzSUW01r2FVccwlFGt+PHcicxO1hzM9McGS5xmApfk7oSoK90podFghMHJ9SJCRxDrN5SwQdB1f0fWUIL0c9bVe9r2VYZNVOne2afIwk6wzQpAVood4ZD0TYiDHaIMczWOI3ox2E7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V9HTsgIA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EEA7C4CEEA;
	Mon, 16 Jun 2025 10:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750069249;
	bh=TzivUek7CnXdibJ+G8e6IXHDQ/J8rVZuczOdC5XiQtE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V9HTsgIADYqpqvke/dpaE+PfxOdRhVkiTLoi07l7uBPRd5sgmql2m8Z5tNvYvFDuk
	 Aef1v9wtqGfNNXNf1dQiNWuOVYNyzZka0kpe+HOGkKGMFSR03Hbfo9EFdLrve9bN6K
	 +nmhV/YAjBdDpjkk50P5EUHZfvixf2DO7wc7Jlc4=
Date: Mon, 16 Jun 2025 12:20:46 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] binder_ioctl_write_read(): simplify control flow a bit
Message-ID: <2025061601-chooser-mammary-6e29@gregkh>
References: <20250615003011.GD1880847@ZenIV>
 <20250615003110.GA3011112@ZenIV>
 <20250615003216.GB3011112@ZenIV>
 <20250615020327.GF1880847@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250615020327.GF1880847@ZenIV>

On Sun, Jun 15, 2025 at 03:03:27AM +0100, Al Viro wrote:
> [don't really care which tree that goes through; right now it's
> in viro/vfs.git #work.misc, but if somebody prefers to grab it
> through a different tree, just say so]

Fine with me for this to go through yours, thanks!

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


