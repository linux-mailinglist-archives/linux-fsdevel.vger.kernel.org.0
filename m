Return-Path: <linux-fsdevel+bounces-37746-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C04F9F6C7F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 18:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC61D16A29F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 17:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4E01FAC40;
	Wed, 18 Dec 2024 17:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gGE/gi82"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36121B4233
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2024 17:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734543858; cv=none; b=gV9FvOsk8pyrm0LQDJaPbWDvvilQ4ztlVhWQ0NRgrCJl4M8vjF5Hiwp2tWHXpik8VwGsxJc9Vc7L7S+7SRpHMWXbU85H7q4Ikp8N42AmwU5Ib8R3RA32WzRzn/giit1eb3K4cFEL4uFbDJRHC7rJXGG0CgSn99oYzy7U8uOJLpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734543858; c=relaxed/simple;
	bh=jeF+GglMMq/UzsVUWjdrLKaSXY6uZcPwqDO8JOGKkeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EvvKvdjwTLgpAmqfHy5KRRHjN0WcrrleOGpQb+MAih+u9Tye+NruoqhCfwCjAabdFMH3yB2iITpvR69r5ngQU7M9nODP+KN7jL3DXXJLUhsf98xPjVse5VFt/Scainc3Lj9EKw94FcKiXZIurvhgdRxYWBR6ziUYcH0i0GGuvW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gGE/gi82; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 18 Dec 2024 09:44:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734543849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b207jx9B6Ucc7re/kw/dxML2rRpzy02qKg5NjDAh1NQ=;
	b=gGE/gi82gfdzKdUXL3cixRylYPw4ZkutaRH/XcevIxYayrfmt29zJfulk4v6H/nLHS3j5N
	ok0b8oOGK21/e7z+kS6dKKCNqKrl4CA+WScOR6SaQMvp7N3QxSh29I+pSZvQtGHJ6usfzP
	Q51LnOcuz/AiwR079invxqwFDkmc1yU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com, 
	josef@toxicpanda.com, bernd.schubert@fastmail.fm, linux-mm@kvack.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v6 0/5] fuse: remove temp page copies in writeback
Message-ID: <p6ripet3dm6jsmskpy5zgbn66vywug6cwkbdhbbkc6lr2wo72a@5xctmai4jtmh>
References: <20241122232359.429647-1-joannelkoong@gmail.com>
 <CAJfpegtSif7e=OrREJeVb_azg6+tRpuOPRQNMvQ9jLuXaTtxHw@mail.gmail.com>
 <qbbwxtqrlxhdkesrruwgfnu3qyzi6b6jhahxhbvn56kpiw5i4v@dhvdhlslbhcc>
 <CAJnrk1ZHk6BnAWFBhw_rdq1UudgNjBf9r9Eg+VORxuPp48JOPw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1ZHk6BnAWFBhw_rdq1UudgNjBf9r9Eg+VORxuPp48JOPw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Dec 18, 2024 at 09:37:37AM -0800, Joanne Koong wrote:
[...]
> 
> Hi Andrew,
> 
> Could you let us know your preference or if there's anything else you
> need from us to proceed?
> 

Andrew has already picked the series into mm-tree (mm-unstable).


