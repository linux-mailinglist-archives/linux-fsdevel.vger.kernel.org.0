Return-Path: <linux-fsdevel+bounces-63928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E274BD1EC2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 10:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62EBF3B932F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 08:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40B42EBB87;
	Mon, 13 Oct 2025 08:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JoJ5YBKd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64C22EB865;
	Mon, 13 Oct 2025 08:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760342759; cv=none; b=c3o8dtNHWe5QaJ2KgIfdF0C1uT+Ctu1xRPmcOykPbFkkU/7nNg/yAEgMJZyvxlT6Zrq2Tu5Q4ZMiO1/5bWZo6glE9oKt9NCHGw1NaNED23etk6OUoEuNlUFatK3RphMMXoleZtwZS7GDKtL/n6NQ4J3h6ouO4+6ovDcPhE/wLa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760342759; c=relaxed/simple;
	bh=5HsWbtZ2dcB7krEcbKjne7KnS+nPBJU93qavaxJizuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TXN8Za1Akmd75uDhay9RyJg4K33k8nsTB2ar7olErOfDVNsisVdZbRYtqAHojSPNjNJxEHllCGnu2jnkgP00K4SxHUQTMy2imJjBjOtzxlUEAlfc2GLidlHcxidEsViQMRz1GUmPoYhVIE4ASH0NFb/+cqjwp8rmOXWykhd4mNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JoJ5YBKd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB19FC4CEE7;
	Mon, 13 Oct 2025 08:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760342758;
	bh=5HsWbtZ2dcB7krEcbKjne7KnS+nPBJU93qavaxJizuM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JoJ5YBKdMmynvxsqiAkHkZbrbXNbh1kQQdkhIKnwG6b9L6o3Uzqi1X27KlKrsP3Fl
	 R+lbP/clJGXkbhS5NEhqi0WhSG87d70ezCBhCv1BktJRTGsKjbOMR2s0X7m2rPZ0Za
	 aJ89IXK3xmT7/fyqzwHbHH3uYFwcU8sSKoILbJ6+EgEN5d0jr/somN9ZzIA7z4pSU1
	 vSAsqr50CL9MnLXn4g22yvpe4Rxs3HtQAYyAu3lN/RpP31W4v5IU0188xLD7bhEdEo
	 rs2FORcAaC7QLU5udePhJZbhtXDoEEFtFdrkp7D0ifJNyNJWapFn9NwLgNGUylYwx6
	 Gyj0yBRoVk77w==
Message-ID: <227fc5f2-c16c-4fb2-be02-e7b1f37559dc@kernel.org>
Date: Mon, 13 Oct 2025 17:05:53 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] mm: remove filemap_fdatawrite_wbc
To: Christoph Hellwig <hch@lst.de>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov
 <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>, Mark Fasheh <mark@fasheh.com>,
 Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
 Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org, v9fs@lists.linux.dev,
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
 ocfs2-devel@lists.linux.dev, linux-xfs@vger.kernel.org, linux-mm@kvack.org
References: <20251013025808.4111128-1-hch@lst.de>
 <20251013025808.4111128-9-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251013025808.4111128-9-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/10/13 11:58, Christoph Hellwig wrote:
> Replace filemap_fdatawrite_wbc, which exposes a writeback_control to the
> callers with a __filemap_fdatawrite helper that takes all the possible
> arguments and declares the writeback_control itself.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

