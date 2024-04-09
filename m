Return-Path: <linux-fsdevel+bounces-16432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C116789D6EA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 12:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 790FC28392D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 10:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49B981ACA;
	Tue,  9 Apr 2024 10:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JwsmimZN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D677D3E8;
	Tue,  9 Apr 2024 10:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712658237; cv=none; b=WCeFBY4/kwrjgr8CFZENTRZwJc/aRk33atNyPhm5i7rxQ3MSUkWKD2dx8YqE+IfP/+aLwynZLBJ9Pl+R0rbusIWSrM/1aiCbT9Er8/sadEXAgU5Y+CKv6HhZI+QypX705YHT4HGe3Ay/N2VfAIwELncB9wMs2637F0UkB8tHvVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712658237; c=relaxed/simple;
	bh=LjHYHlvcIvNKOMqgpeBN4KMgJFSPPgeh6oX8HGYd0nU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nztw8O+skolIhQbBX5UmoDl+bwh1HBpWgmL/7htZwgOr9VGTPhaHbBmZ+1YlxUrP1Xfgyjf4clJMB1K30iUeccZpW+9NZAFNJM8z+7Mcs9t7PIUHV0r1/ISjGR+l++WvLltxz4P0V0PTqVh6TVzN6bI44JAuIAMQT4jJKhSUB+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JwsmimZN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA52C433F1;
	Tue,  9 Apr 2024 10:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712658236;
	bh=LjHYHlvcIvNKOMqgpeBN4KMgJFSPPgeh6oX8HGYd0nU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JwsmimZN1xjKR7+t8bqCf6G2vKD+kLz5TTStcQWP6yQBh44/v9GeLOa49tDZw3NWj
	 JgzqAvqrWs+3oAuTeahiszjuhF/zWIOAf0zeIlMnmAqnZMX6O59D+jr01XxyLfPBe6
	 XY3MV7b/QT3y/R6Q1yAecJkOCbsLVpqTUFx0oYw4QV4wyiTU0QqMXumaVXTk98Y66B
	 Q4gGsYHpXELW9UJnoK1zYKJ3PQBHr7O/YkIzRhK/bxSWzTGxxoPCAuqCvrhEYbdq7s
	 3D8MBzsBjbw6hFxDA5Y7TnPwWcoFkHHBRatE9Az48SoobYZfoVdnXpfkecZwkTf54q
	 YxbOn6v4O3Ohw==
Date: Tue, 9 Apr 2024 12:23:49 +0200
From: Christian Brauner <brauner@kernel.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, hch@lst.de, viro@zeniv.linux.org.uk, axboe@kernel.dk, 
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH vfs.all 22/26] block: stash a bdev_file to read/write raw
 blcok_device
Message-ID: <20240409-pavillon-lohnnebenkosten-8ba65c1fd8e0@brauner>
References: <20240406090930.2252838-1-yukuai1@huaweicloud.com>
 <20240406090930.2252838-23-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240406090930.2252838-23-yukuai1@huaweicloud.com>

> +static int __stash_bdev_file(struct block_device *bdev)

I've said that on the previous version. I think that this is really
error prone and seems overall like an unpleasant solution. I would
really like to avoid going down that route.

I think a chunk of this series is good though specicially simple
conversions of individual filesystems where file_inode() or f_mapping
makes sense. There's a few exceptions where we might be better of
replacing the current apis with something else (I think Al touched on
that somewhere further down the thread.).

I'd suggest the straightforward bd_inode removals into a separate series
that I can take.

Thanks for working on all of this. It's certainly a contentious area.

