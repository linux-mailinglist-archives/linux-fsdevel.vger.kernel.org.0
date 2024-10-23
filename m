Return-Path: <linux-fsdevel+bounces-32687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 292DB9AD867
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 01:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF66C283F96
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 23:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5471FF7C6;
	Wed, 23 Oct 2024 23:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="sPdfZD3C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2739A1CCB31;
	Wed, 23 Oct 2024 23:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729725889; cv=none; b=ohtKSWLvjlr0nRmImDyFJl6r/8SbIjrMs6lPDIn5GorLNg1qKNXE9jd9xOFCJAr/Vkr0baJHRYaQRvLsfwvSBw/o1PwKmP7ImLkpr7Ya+paOVcXRqOebe82tkbdAvYvjaEvyKlIBOGuZxK5mdTd35HcNhUvQC/YTW/LshlQxK6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729725889; c=relaxed/simple;
	bh=Qx5v7hPYIHtsQ8iDSicYJL/L3Zyh0HA051qawU0dk9g=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KRJEk7DcGfqO3Py/AhuKkruwO7HndvfzAUzWqivaNXAbF7kaQ6XiTjRECw9UlqEqi2kyUhb59Sz3YJ6rpm6xZWjF4DXteZ6UyxFCc8i9X21EKesNdatm7KVnO1yhKZU6QtG4XCViFivLog4qR98VOcCAqt2XoWPJZ+CbgDfaeZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=sPdfZD3C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76899C4CEC6;
	Wed, 23 Oct 2024 23:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1729725888;
	bh=Qx5v7hPYIHtsQ8iDSicYJL/L3Zyh0HA051qawU0dk9g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sPdfZD3C75x+zdwpX980Cb5uMMaWdXbkRoTNOzjDZ2QZ1GzduGr4Y/46wyyZ2WzJ0
	 NBtfmwq/HIUpUfnA02BVvZUpSBiGzw9Y91N4txja77ie89aYDKsuSst3as8PAdINh0
	 BEm/IeUUCHR5Wx3iwauiU+93Yw3yobj41jjYyDTc=
Date: Wed, 23 Oct 2024 16:24:47 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jim Zhao <jimzhao.ai@gmail.com>
Cc: willy@infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page-writeback: Raise wb_thresh to prevent write
 blocking with strictlimit
Message-Id: <20241023162447.2bf480b4ce590fdeb8b6c52d@linux-foundation.org>
In-Reply-To: <20241023100032.62952-1-jimzhao.ai@gmail.com>
References: <20241023100032.62952-1-jimzhao.ai@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Oct 2024 18:00:32 +0800 Jim Zhao <jimzhao.ai@gmail.com> wrote:

> With the strictlimit flag, wb_thresh acts as a hard limit in
> balance_dirty_pages() and wb_position_ratio(). When device write
> operations are inactive, wb_thresh can drop to 0, causing writes to
> be blocked. The issue occasionally occurs in fuse fs, particularly
> with network backends, the write thread is blocked frequently during
> a period. To address it, this patch raises the minimum wb_thresh to a
> controllable level, similar to the non-strictlimit case.

Please tell us more about the userspace-visible effects of this.  It
*sounds* like a serious (but occasional) problem, but that is unclear.

And, very much relatedly, do you feel this fix is needed in earlier
(-stable) kernels?


