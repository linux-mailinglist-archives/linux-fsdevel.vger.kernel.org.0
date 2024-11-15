Return-Path: <linux-fsdevel+bounces-34998-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 527EA9CFB03
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Nov 2024 00:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CBD5B35229
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 23:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C735D192B76;
	Fri, 15 Nov 2024 23:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IVf6rO1y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D0B1917ED
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 23:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731712283; cv=none; b=mUovx3YCsOsee5YuGp5cFw42EpPfD5XZQcOmjl5bwwa8USH5y80ck2RU00CgJmRuLyYunVWlWtHgWj7PD91xurgaQLUJj/zbBd+wOnoRdMRsRkMmXNNeEtQlEqpnUZzE1nkljgooXOGg5Mr7E6fTQzdWQIYvRCyZ1YGeG5NGCmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731712283; c=relaxed/simple;
	bh=KbRVmRu6PNu4huGu0g77O0gwaIPfKoGdaPKnD4Af078=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPk4mMckEd0deh+a94d1ihL7SnWVYvhhp17z9fJW7DX5BaiEyaemIoSj73ELHdLGYNUPlNVz1B+0p86Go6hAIRWFdlmJJXRupR3PSthXoQy5PnXZ0I0X8/zN3gG48L0eZ+VjNoqJdVWQWX/SHQqAxVPmuZVuNJa2wuFCZEAKwIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IVf6rO1y; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 15 Nov 2024 15:11:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731712277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wn5Z6kTHyTlKPhFTF8uOmLasKjWL5IXoAbGblP68jNU=;
	b=IVf6rO1y4UekQQIovpfvNfkoPGKIE4dnqwmv739uS6lkI+flcH2RYxnTgPUJkL6keStB/t
	Sqz+nLps5gFky9yj+b4m7y4A2lFkVuwZR3KSh7nsWKu5QT3oDgaXtEAf0nGeBemJhwQqot
	PSLua2SAtaU0/W7zPLymoVPT1wTC/fo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	jefflexu@linux.alibaba.com, josef@toxicpanda.com, linux-mm@kvack.org, 
	bernd.schubert@fastmail.fm, kernel-team@meta.com
Subject: Re: [PATCH v5 1/5] mm: add AS_WRITEBACK_INDETERMINATE mapping flag
Message-ID: <2h6gh5p5kbwp2ca3c6shfo62hfcfdjo2f4ixibg3slihnulovj@qs3f7mbq7325>
References: <20241115224459.427610-1-joannelkoong@gmail.com>
 <20241115224459.427610-2-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115224459.427610-2-joannelkoong@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Nov 15, 2024 at 02:44:55PM -0800, Joanne Koong wrote:
> Add a new mapping flag AS_WRITEBACK_INDETERMINATE which filesystems may
> set to indicate that writing back to disk may take an indeterminate
> amount of time to complete. Extra caution should be taken when waiting
> on writeback for folios belonging to mappings where this flag is set.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Indeterminate is definitely different, ok with me.

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

