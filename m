Return-Path: <linux-fsdevel+bounces-15083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF76886DEB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 14:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AF661F213FC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 13:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350144643A;
	Fri, 22 Mar 2024 13:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4akKLQc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932AE3F8F7;
	Fri, 22 Mar 2024 13:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711115867; cv=none; b=KRuu3hCD4px6lLz8xjkhxMj7rQM8AijcqM03wRTpbTRWbC8kPzPvoH4F9xrcxp87lkGBlMYLvV0rUwrMvicHlEbf4Gkrczb2rDanKrtbcbE3vJqB5L7pKfTjUCyfNGABogYxti+Qk213gwQL9bNO6x8CfLeabyVn/htlEKmBJ98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711115867; c=relaxed/simple;
	bh=Js9co96eGqEjZBrOp/79tcRIasSwidzlgGY09Q9Tvsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R70wkRgoX9lemvNVlID/jXOGuyxBaZf3lFPzm+yZXGAGH9hop7vZYe8LfWgcNeKj7vEGSiXKdjBGVY+o72a5Pick3GDQ1cOt7GFE/mvK+jkzwYeI31hfiS8nq583aLvhC+4mAon9MLx9BLP8ibQ7Kl1nDMSm8Cs/TffMnxV2Jcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4akKLQc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A22E4C433C7;
	Fri, 22 Mar 2024 13:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711115867;
	bh=Js9co96eGqEjZBrOp/79tcRIasSwidzlgGY09Q9Tvsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L4akKLQcATzeOK7VwTduDoLlDz05vnQojHzdXe4skXSmeNqay+OjIuOVnU8zq8OEq
	 GLt1dy+P4FSPlSg9paqzSZy+WWfaF2nlk7dZ51hhvci4yOfgUqcdwhXrk6sdHqYXOL
	 aG0bK/xqxOY2RWfUBr5h7lFVNoqjLRBWyMDZFBUFmEsSiWtYEUsKveciT6cFO7Esot
	 paR7fGq80GcEIoUcA64/QpWXw7uKCHDnOkkdXcX0dbGvLHR2Q6khhfi1s1iogK4srD
	 dcuMOE32KbIZRzI8uUv7FLNL5yD+D5JZ5CeH17p+TDlGHjKijDsP+/3qw9LUQXBH7H
	 Emt7GgxljVe9Q==
Date: Fri, 22 Mar 2024 14:57:42 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com, 
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [RFC v4 linux-next 19/19] fs & block: remove bdev->bd_inode
Message-ID: <20240322-zerfiel-dolch-0faceaf399d2@brauner>
References: <5c231b60-a2bf-383e-e641-371e7e57da67@huaweicloud.com>
 <ea4774db-188e-6744-6a5b-0096f6206112@huaweicloud.com>
 <20240318232245.GA17831@lst.de>
 <c62dac0e-666f-9cc9-cffe-f3d985029d6a@huaweicloud.com>
 <20240321112737.33xuxfttrahtvbej@quack3>
 <240b78df-257e-a97c-31ff-a8b1b1882e80@huaweicloud.com>
 <20240322063718.GC3404528@ZenIV>
 <20240322063955.GM538574@ZenIV>
 <170c544c-164e-368c-474a-74ae4055d55f@huaweicloud.com>
 <20240322125750.jov4f3alsrkmqnq7@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240322125750.jov4f3alsrkmqnq7@quack3>

> Do you mean for operations like bread(), getblk(), or similar, don't you?
> Frankly I don't find a huge value in this and seeing how clumsy it is
> getting I'm not convinced it is worth it at this point.

Yes, I agree.

