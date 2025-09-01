Return-Path: <linux-fsdevel+bounces-59812-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CD7B3E1E0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 13:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 685AB3A654C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 11:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C3231AF3F;
	Mon,  1 Sep 2025 11:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXyc0YFy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E4F28E3F
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 11:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756726874; cv=none; b=hChfGARN7rYuOD9hqfs1C+F6qW8Knpc5rTmAH4X5AnfWSymoVm7h71oJpgoAy7WwhkctJl6TfeR/jhKJZntoM8/BRaBDXOWvOgM9HhK+OFp+LYTlAYF6ZhVF8lzUeJpV2OBogD8IPjL9CihqcRImfTQpwRpD+YTGtK6yY0Msh0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756726874; c=relaxed/simple;
	bh=mt6wQO9HjKTLxNyYTl5G7WBwGSnsTuU1sWe33u8k6Es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0bwbtP1v3xqMtfq7+RGe24D3VpgHnaa5gOfGjqbnBxrp+hFJhi6TijTIcN0JpnE0uvXnhc8rrQ9z5Td+njHSImObUSB7Ad3ODi/os/XeY8zjwVk5wpE7AE5HdDPn8Q6exN00rV9ArUh6JYeVUTu6jPe6U9lqB+nNxA8pU4uH/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXyc0YFy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E53C4CEF0;
	Mon,  1 Sep 2025 11:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756726874;
	bh=mt6wQO9HjKTLxNyYTl5G7WBwGSnsTuU1sWe33u8k6Es=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FXyc0YFyScsNgYBlyKknqMk9wekcmI8VlqHu8jgx7Pn/9qRwsZBAv33H+voV0gXqV
	 tm7opwuYHxKDxTvb7ytK0K49A1GhexaYh/uWexqO18c1iLTzglXjgtav+XxFKGGmq1
	 uGWZ/BQ09d9/0snSMBs5UmPOqLAd0BuAZHr6vhi2zDgm9hPuGP5fc4Ut0YQ9Ivrrik
	 S9FmEmbOrWQZ2haHX6bN/VperFKR/Wzi5wzuQCFD7LFYMqAwAguCMEuGG+iW8UUCKG
	 p+zpzifAEVQPCfZf+0UqRfErdZKokUE5oQuAD7mSwncOprW5D+1AHnwKvAkI43Qk5y
	 CKDPAfQnj9n9g==
Date: Mon, 1 Sep 2025 13:41:10 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH v2 31/63] graft_tree(), attach_recursive_mnt() - pass
 pinned_mountpoint
Message-ID: <20250901-tierzucht-schildern-061de32ea9cc@brauner>
References: <20250828230706.GA3340273@ZenIV>
 <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
 <20250828230806.3582485-31-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250828230806.3582485-31-viro@zeniv.linux.org.uk>

On Fri, Aug 29, 2025 at 12:07:34AM +0100, Al Viro wrote:
> parent and mountpoint always come from the same struct pinned_mountpoint
> now.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

