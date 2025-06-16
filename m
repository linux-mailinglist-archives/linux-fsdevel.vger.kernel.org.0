Return-Path: <linux-fsdevel+bounces-51775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A2BADB3F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 16:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8DD67A73BF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 14:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D9F1E9B1A;
	Mon, 16 Jun 2025 14:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbrWlNPv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92C62BF00D
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jun 2025 14:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750084444; cv=none; b=WN4puB2QJMRFhh3zJx6I5eHDzuuxGkxhw5o7jGiBJ6/3+88lZMH649xRRzNtMcrHCEKK+BGRCtDfBQ2h0oUQ6n5IhkbCIDg3Hv8P+2OfLrKmkInm6Hkkq/CqImb85a9FLV9W+6zRsJrUtpsS4wWlkm5aBYEZVPcsoNilqewqHWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750084444; c=relaxed/simple;
	bh=KLuxqJRSuZN5NO7JmL9DLh5mq6GVxJF3zJEPyAaTawI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpAuR0eJmAxODNlx2MbfN7WmXhiJhSVy4QN5G/ujMsKmjjYJz2f07ojaoRt3adOFpxooVySvfNZVp0olFkC6a3/GIheAig7VNCqsEXVDot3chGmdUsZJczDL/Od/QgoaPLjPpyFJv2KpioCa7uzkwfLYL/sLHFk5Z4hQ8WrTnEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbrWlNPv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3261DC4CEEA;
	Mon, 16 Jun 2025 14:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750084444;
	bh=KLuxqJRSuZN5NO7JmL9DLh5mq6GVxJF3zJEPyAaTawI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WbrWlNPvfcfVCFzBzHrGjK26i8YE71bf9jAsJ9YGl5TYslZalYjsvJD7yvli048rE
	 7bei0jJVUf+3lH+n5b/GdKfZyHSmfqCcLJ/d7SXcUsKrv55b1uW19v6pGA5L8rUCP3
	 clo/1n01CpRrPtBYQL/L4B1IrWOpijwpOFQNQ0gsPlA1fJP/NxBko+nVEi74JKBls2
	 WVlF1b6e6+1hQ3QoSrbMOkOXFCf++2TdWmc8yu1wQwULcWiHoBXNFtydkjMgnOFHUD
	 IexS3YZf8k5wTUgZePhpoALgnd6DKA5CqT4AiC6jWwS933/fjMAi5xQLDoDQdwRaCj
	 eWoiWMfBR6fPw==
Date: Mon, 16 Jun 2025 16:34:00 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, neil@brown.name, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 1/8] simple_recursive_removal(): saner interaction with
 fsnotify
Message-ID: <20250616-fangen-auserkoren-3a9c1ecb454a@brauner>
References: <20250614060050.GB1880847@ZenIV>
 <20250614060230.487463-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250614060230.487463-1-viro@zeniv.linux.org.uk>

On Sat, Jun 14, 2025 at 07:02:23AM +0100, Al Viro wrote:
> Make it match the real unlink(2)/rmdir(2) - notify *after* the
> operation.  And use fsnotify_delete() instead of messing with
> fsnotify_unlink()/fsnotify_rmdir().
> 
> Currently the only caller that cares is the one in debugfs, and
> there the order matching the normal syscalls makes more sense;
> it'll get more serious for users introduced later in the series.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

