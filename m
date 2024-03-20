Return-Path: <linux-fsdevel+bounces-14923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C81881847
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 21:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70929286153
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 20:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2FE85936;
	Wed, 20 Mar 2024 20:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJNMlgKF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916AA85655;
	Wed, 20 Mar 2024 20:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710965192; cv=none; b=f+7mZe55AUMJgKX1CwoA/HG54c9rqrIWVkPe8m/Fi6w/e+m/BXVlj61rz//9eE19HG2/EjVur3O1uU8P4kuzlvam4sPLFfBdz0jAgxTr8OxHp4IxU/5zv63v/EUOhX/au+6knn6nCQSBlowd+2msskxIB/rglP7dNF9n/GP0Go4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710965192; c=relaxed/simple;
	bh=AfBIQbAOtxbWlNuWHqgq4zXf9lgF4bMQpKxq3regi2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VV3Rw7zbZLhyQe72FxUZN8knBeOp6xOEDeV1NMuxsvJSkJGSRnuc8Pa3+LNe98H9jc4AMNhs/0ttfGK6fvO7ywU9APINMnJgPQtPG0c9v0qMgeAFfI4O2MrNMykdNa/4SDmKteVM2As4LHcq4vYMtTkFfEhpsbI2CHU6k4vVaws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJNMlgKF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 064A4C43390;
	Wed, 20 Mar 2024 20:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710965192;
	bh=AfBIQbAOtxbWlNuWHqgq4zXf9lgF4bMQpKxq3regi2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EJNMlgKF1qsochRYrEB6+rz6KJN0QNeNCMYOVFGbJpkmw9AvfyGSbydlLD/5Zbw52
	 aNp2YZ5BP3eVBZQoRnBvG1ywxXgNHhcKXhQGErpdwy+fniYQCo4GMQGRC5E2LEI9ho
	 tF97s8pey3LmzIC2HhkCqQQh4xA9vHFw2k8krbmc42qOhGnQGE3MRBfue5BU0tadFs
	 BKkLvhLVUvUgTTUyne9ro5ooVKaxC3/eVNwlehNvXNNxrX6lwb45j5Nzln3CFzGQQV
	 IxQYBY7i3bbl11KNSpaqqMtbP2fgyJBF1BbvPfcJkgtyjPh9P0OTbG3lk5lhZzxq/V
	 vLkIkvokb8i9A==
Date: Wed, 20 Mar 2024 13:06:30 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Light Hsieh =?utf-8?B?KOisneaYjueHiCk=?= <Light.Hsieh@mediatek.com>
Cc: Ed Tsai =?utf-8?B?KOiUoeWul+i7kik=?= <Ed.Tsai@mediatek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	Chun-Hung Wu =?utf-8?B?KOW3q+mnv+Wujyk=?= <Chun-hung.Wu@mediatek.com>
Subject: Re: f2fs F2FS_IOC_SHUTDOWN hang issue
Message-ID: <ZftBxmBFmGCFg35I@google.com>
References: <0000000000000b4e27060ef8694c@google.com>
 <20240115120535.850-1-hdanton@sina.com>
 <4bbab168407600a07e1a0921a1569c96e4a1df31.camel@mediatek.com>
 <SI2PR03MB52600BD4AFAD1E324FD0430584332@SI2PR03MB5260.apcprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SI2PR03MB52600BD4AFAD1E324FD0430584332@SI2PR03MB5260.apcprd03.prod.outlook.com>

Can you try this?

https://patchwork.kernel.org/project/f2fs/patch/20240320001442.497813-1-jaegeuk@kernel.org/

On 03/20, Light Hsieh (謝明燈) wrote:
> Hi Jaegeuk:
> 
> We encounter a deadlock issue when Android is going to poweroff.
> Please help check.
> 
> When unmounting of  f2fs partition fail in Android poweroff procedure, init thread (pid = 1) invoke F2FS_IOC_SHUTDOWN  ioctl with arg F2FS_GOING_DOWN_FULLSYNC.
> This ioctl cause down_write of a semaphore in the following call sequence:
>         f2fs_ioc_shutdown() --> freeze_bdev() --> freeze_super() --> sb_wait_write(sb, SB_FREEZE_FS) --> ... ->percpu_down_write().
> 
> f2fs_ioc_shutdown() will later invoke f2fs_stop_discard_thread() and wait for stopping of f2fs_discard thread in the following call sequence:
>         f2fs_ioc_shutdown() -->f2fs_stop_discard_thread() -->kthread_stop(discard_thread) --> wait_for_completion().
> That is, init thread go sleep with a write semaphore.
> 
> f2fs_discard thread is then waken up to process f2fs discard.
> However, f2fs_discard threshold may then hang because failing to get the semaphore aleady obtained by the slept init thread:
>         issue_discard_thread() --> sb_start_intwrite() -->sb_start_write(sb, SB_FREEZE_FS) --> percpu_down_read()
> 
> Light

