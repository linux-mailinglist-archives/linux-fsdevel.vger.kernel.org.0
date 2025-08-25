Return-Path: <linux-fsdevel+bounces-59104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CCDB34717
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 18:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B2822A5865
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 16:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B642C301470;
	Mon, 25 Aug 2025 16:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="JgBmagAI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F51301029
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 16:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756138884; cv=none; b=Mk0yh7GBSoV/mV6//YN3kotwIQQ0y6ycCNYEtORlOURTo8hulW9o5qeqwbHBOhnOE4W24MJ7iGsGSJ6iLhwzZg7kFRzQT0vd8WpGO41TUjgsMNiTEt/d9gA/Sb8Ps0TJSYYkJ4twMMD9ykv1S10vpmqizCw40eZIHQhq9s376Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756138884; c=relaxed/simple;
	bh=Z9caLutQEhVyT+pZMKa+xjKkb5GzAdagbjYfBS/W2Yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OEebfsBWHxpHcKBnqxlMt4YKXzfNCDYYQJ35sV/Z/25VvORMbB5OSI8MmOiP/LPcgO42ElSg6C2LTgI/6FjPg+oK8cNwcPRQiEU7cf/TaVjUKrBI5wWaNfguNOmogfJcrqHL/+kqZS/k/bIzkdr1odiICeMhUuX6sE6rGvPKJl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=JgBmagAI; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ya0ljvtcAK8qBQ3Alu0GIckJZht3u2+psLRiTHbdmQo=; b=JgBmagAIHSpYHDPliqMvHxqDiq
	A0SU9tlqGuoYHz8nX7Gox5TlHJ0oXRgx0/6lu35wGAyMPTCVYHjMsW8q1X77/IjSNCwU99+f2YtIt
	6vfF3FXADvWmYllCvwXPDPiRGGqvZJN7T4fINy8GoiRbRsLcqNPzutSBco2Kd2LKfdH2Dug8iNXbk
	xAjVehpnjmuC6T7hCSo2AhGZtgfonTPM0WADwJEOgeB+vQFLdSmhZr2AEghix+PseL/n3IqsiN+oe
	76Nd2BobiuMJbGPmaDBu22GkjEXZtIHDE+wjRlA2g7xcTfZgjmDyMXtQF79P7wsi5Ypg0UblNq88J
	4iXKPbHA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqZwe-0000000GKEK-1MiD;
	Mon, 25 Aug 2025 16:21:20 +0000
Date: Mon, 25 Aug 2025 17:21:20 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz,
	torvalds@linux-foundation.org
Subject: Re: [PATCH 09/52] put_mnt_ns(): use guards
Message-ID: <20250825162120.GN39973@ZenIV>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
 <20250825044355.1541941-9-viro@zeniv.linux.org.uk>
 <20250825-hohen-brokkoli-377019b30a94@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825-hohen-brokkoli-377019b30a94@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Aug 25, 2025 at 02:40:53PM +0200, Christian Brauner wrote:

> Another thing, did I miss
> 
> commit aab771f34e63ef89e195b63d121abcb55eebfde6
> Author:     Al Viro <viro@zeniv.linux.org.uk>
> AuthorDate: Wed Jun 18 18:23:41 2025 -0400
> Commit:     Al Viro <viro@zeniv.linux.org.uk>
> CommitDate: Sun Jun 29 19:03:46 2025 -0400
> 
>     take freeing of emptied mnt_namespace to namespace_unlock()
> 
> on the list somehow? I just saw that "emptied_ns" thing for the first
> time and was very confused where that came from. I don't see any lore
> link attached to the commit message.

https://lore.kernel.org/all/20250623045428.1271612-35-viro@zeniv.linux.org.uk/

and

https://lore.kernel.org/all/20250630025255.1387419-45-viro@zeniv.linux.org.uk/

in the next iteration of the same patchset, both Cc'd to you.

As for the reasons, there are nasty hidden constraints caused by mount notifications;
even though all mounts are out of that namespace, we can't free it until the calls
of mnt_notify(), which come from notify_mnt_list(), from namespace_unlock().

Better handle it that way than have a recurring headache; besides, it helps with
cleaning post-unlock_mount() stuff.

