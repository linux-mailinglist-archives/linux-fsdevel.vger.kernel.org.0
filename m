Return-Path: <linux-fsdevel+bounces-22135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4E9912C40
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 19:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A34F028E4F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 17:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCFA1662F0;
	Fri, 21 Jun 2024 17:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="K89Z1Stc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5939020314
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Jun 2024 17:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718989859; cv=none; b=ugsmhMIzAkBob02MrtAFK4fgY+SP2YZSoV7hyIXQ9Rw9VyNasMGYyyMpPDIugbETT3YZyrhqowKWJfKFiqDsJ6lJj92UBUGjQ7Mlt2knAewA/M+j1REeXKvIFsGCtA2gE0jzmTU/+zdSEnkgrTZlk923/7ls6z1/nnWVGpqfjN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718989859; c=relaxed/simple;
	bh=36XJikwAKK6KmWDfSywJ648SL2lg2Z9qjYfnPVDcV1c=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=sXapUAcEB03rvU6r6je4X1fyq/5Te9lt5GgPdyqfqVKRZ7zERGettapMJSYuxe9rTZnXOaJ0en12q4VekLyBWnueUHHQIqM66x3oUQfcpIKvto+ygdpDDzZMf3v+CiEAh2ASGHgtCUMq7SKxrWDj++kUwGQinASSiV6YbXVR8G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=K89Z1Stc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA1A5C2BBFC;
	Fri, 21 Jun 2024 17:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1718989858;
	bh=36XJikwAKK6KmWDfSywJ648SL2lg2Z9qjYfnPVDcV1c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K89Z1StcvmluPOeq5yneIeBLcDvRF6FVRbC9WdnFXiQB7ZfMRNchsla2N0b9Qtf/K
	 MyQDA7nEDH0/QvL8RbxhkrSoohLVST+61fBB3LW/DgCAjm4unxkHBEDPWgrLZNS6iL
	 tNv/eIIXPxwWtrqqqQ+PJR+ML6GY0bvVvRsKOUWM=
Date: Fri, 21 Jun 2024 10:10:58 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jan Kara <jack@suse.cz>
Cc: <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>, Zach O'Keefe
 <zokeefe@google.com>
Subject: Re: [PATCH 2/2] mm: Avoid overflows in dirty throttling logic
Message-Id: <20240621101058.afff9eb37e99fd48452599b7@linux-foundation.org>
In-Reply-To: <20240621144246.11148-2-jack@suse.cz>
References: <20240621144017.30993-1-jack@suse.cz>
	<20240621144246.11148-2-jack@suse.cz>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Jun 2024 16:42:38 +0200 Jan Kara <jack@suse.cz> wrote:

> The dirty throttling logic is interspersed with assumptions that dirty
> limits in PAGE_SIZE units fit into 32-bit (so that various
> multiplications fit into 64-bits). If limits end up being larger, we
> will hit overflows, possible divisions by 0 etc. Fix these problems by
> never allowing so large dirty limits as they have dubious practical
> value anyway. For dirty_bytes / dirty_background_bytes interfaces we can
> just refuse to set so large limits. For dirty_ratio /
> dirty_background_ratio it isn't so simple as the dirty limit is computed
> from the amount of available memory which can change due to memory
> hotplug etc. So when converting dirty limits from ratios to numbers of
> pages, we just don't allow the result to exceed UINT_MAX.
> 

Shouldn't this also be cc:stable?

