Return-Path: <linux-fsdevel+bounces-50790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 404E9ACF94C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 23:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3ED9189BDDA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 21:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F30627FB3D;
	Thu,  5 Jun 2025 21:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MdoSnqXi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B9127FB0C;
	Thu,  5 Jun 2025 21:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749160313; cv=none; b=Y8TENH/LCPwwRft0sCflp5r+KBTOazdxxea6lrzZAAUAWI099Q+EOG+qmPrBnBDsK3a4mYLl0216BuoUF96LpiY0WeStTb39ikTH9XtYSk1Ls8Qe0YXrQyydEnpr4e885QUQWo9k4BSWbEvFQFutag4ChPp4kyzT3zM594R4iLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749160313; c=relaxed/simple;
	bh=KauwIIy/vgGSQeQb/SdnL3/lcMRyEmhp8yxF8XleYkM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GREuMG74R53YOnufevvqqi/zRt3HbWXiiURNra0fYPPDVkf4mmXQPeNFRYfpgrGli0xVFtlP7KRJJg2wY49Mfyvs0xpJvZ8d8E1tx0jSxCayzHrOV5TuoEXug9LINR9Wpb3P1o4yVWo1rC2OAsUFcOtfl6zrgyd79T1Wan+foOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MdoSnqXi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 033A8C4CEEB;
	Thu,  5 Jun 2025 21:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1749160313;
	bh=KauwIIy/vgGSQeQb/SdnL3/lcMRyEmhp8yxF8XleYkM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MdoSnqXiyJU9RPogV+Gl9lF5W3zr6ih/WgToqdUmnfZWF8TN8ipZKFOob7P+LYrnl
	 XmhANS8dQv1bStWpdlXf1/8DHqdOz9hIPWvxJJgKq6TTW9KBGUNll6KGz8t7nqy5PV
	 2pKcsqX4Lfh8PrKHQPI3zqHhcxHAKZtRtKkqJzR8=
Date: Thu, 5 Jun 2025 14:51:52 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jan Kara <jack@suse.cz>
Cc: Chi Zhiling <chizhiling@163.com>, willy@infradead.org,
 josef@toxicpanda.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Chi Zhiling <chizhiling@kylinos.cn>
Subject: Re: [PATCH] readahead: fix return value of page_cache_next_miss()
 when no hole is found
Message-Id: <20250605145152.9ae3edb99f29ef46b30096e4@linux-foundation.org>
In-Reply-To: <qbuhdfdvbyida5y7g34o4rf5s5ntx462ffy3wso3pb5f3t4pev@3hqnswkp7of6>
References: <20250605054935.2323451-1-chizhiling@163.com>
	<qbuhdfdvbyida5y7g34o4rf5s5ntx462ffy3wso3pb5f3t4pev@3hqnswkp7of6>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Jun 2025 10:22:23 +0200 Jan Kara <jack@suse.cz> wrote:

> On Thu 05-06-25 13:49:35, Chi Zhiling wrote:
> > From: Chi Zhiling <chizhiling@kylinos.cn>
> > 
> > max_scan in page_cache_next_miss always decreases to zero when no hole
> > is found, causing the return value to be index + 0.
> > 
> > Fix this by preserving the max_scan value throughout the loop.
> > 
> > Fixes: 901a269ff3d5 ("filemap: fix page_cache_next_miss() when no hole found")
> > Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
> 
> Indeed. Thanks for catching this. Don't know how I missed that. Feel free
> to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 

Thanks.  It's a simple patch - do we expect it to have significant
runtime effects?


