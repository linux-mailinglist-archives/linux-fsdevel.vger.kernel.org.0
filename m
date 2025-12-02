Return-Path: <linux-fsdevel+bounces-70415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D573DC99B33
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 02:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6D8AB4E2523
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 01:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513F21ACEDA;
	Tue,  2 Dec 2025 01:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="np1oQ/4W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2998F136672;
	Tue,  2 Dec 2025 01:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764637526; cv=none; b=EKmL05F1KohhGDHBJ4zgjrgG3I6lBhzjw60p5b/iIKn2p4smKW0kc/aSummjd8VqAtxNKTC1+dr1Txj0UXze2OD5kz7/Znrm6H8JgW9Vn0kJ+Lh2O9DAJoIAVD57Xcexc3l4B0TjP9Qd6v/31dFMdxrcB8cE+hBl6u+5huy8Wlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764637526; c=relaxed/simple;
	bh=SAwKAzvENhC0Q7LFV/ACapGNoUW0BbkauoLBwheWQDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XGmQuvtgtsOEa7Hz7pxcwQ5Z6zmuKl/FdXigXExV68QZLmx0WQFjwqkeqFxg6oQHRm6ShbYPe0eMaKHv7lsqMx9xiXVnKk1dMEB8K4ItrWZ/JUfl25sM65zXlxOc+KVfjR+8jYjUPLNdcCjUF29Se8bpdiLJF7/zjzoumHVjSLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=np1oQ/4W; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 8173914C2D6;
	Tue,  2 Dec 2025 02:05:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1764637516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kQ+YPoE1IdIMD5iabnaVYzVd3c1iZaf+XEZzuosT9Tk=;
	b=np1oQ/4WTMFcIYcvDexp2eN85aYrItlAPxJz9cshX6DXu8CSZpEciyYgN4/eX2FDj12TCT
	g/Rm64IHvwK5QLyLzfnse2KUhFYHuya9KC8zE2ixtdGQAAQi104xuLz5taLPhwmgENHNg4
	W+aCtDzeFFrb0ZQYeahML3rzOVwCb+1tFr3e7tUbtGwjz5AN93ac+b6xnyL/n/S+JtGLC8
	WrFMM9ppfY/gPiw/lgwgP1OsLlQmdqhE9C97pWqz1AJm5VJCoeo/nWIbjWF5/9m01felzL
	uR8zOS306dNXMVkj89qvxVbViXSGimMxU/zCvw75nmh2WUf4TNaIDLztZvnpFw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 72ae703d;
	Tue, 2 Dec 2025 01:05:11 +0000 (UTC)
Date: Tue, 2 Dec 2025 10:04:56 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: Remi Pommarel <repk@triplefau.lt>, v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com,
	eadavis@qq.com
Subject: Re: [PATCH V3 4/4] 9p: convert to the new mount API
Message-ID: <aS47OBYiF1PBeVSv@codewreck.org>
References: <20251010214222.1347785-1-sandeen@redhat.com>
 <20251010214222.1347785-5-sandeen@redhat.com>
 <aOzT2-e8_p92WfP-@codewreck.org>
 <aSdgDkbVe5xAT291@pilgrim>
 <aSeCdir21ZkvXJxr@codewreck.org>
 <b7b203c4-6e4b-4eeb-a23e-e6314342f288@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b7b203c4-6e4b-4eeb-a23e-e6314342f288@redhat.com>

Eric Sandeen wrote on Mon, Dec 01, 2025 at 04:36:58PM -0600:
> I suppose it would be a terrible hack to just extend the enum to include
> hexadecimal "strings" like this, right.... ;)

Yeah, that might work for all intent and purposes but we'll get someone
who mounted with cache=0x3 next... :)

> I think the right approach would be to just reinstate get_cache_mode() to
> do open-coded parsing as before, and get rid of the enum for the cache
> option.

This sounds good to me!

> Would you like me to send a patch 5/4, or an updated 4/4 to implement this,
> or would you rather do it yourself if you think you have a better chance
> of getting it right than I do?

No strong feeling either way but I think a 5/4 would be better to
clarify why we do this -- I could probably do it as well but I'd
definietly appreciate if you could do it (and I'll just have to make
time to test at the end!)

> As for the other enum, I think we're still ok (though maybe you can confirm)
> because p9_show_client_options() still does a switch on clnt->proto_version,
> and outputs the appropriate mount option string.

Thanks for checking as well!
-- 
Dominique

