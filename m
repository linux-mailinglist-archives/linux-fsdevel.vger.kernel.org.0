Return-Path: <linux-fsdevel+bounces-55983-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93477B11449
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 01:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C9E31C220D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 23:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3049123C4F2;
	Thu, 24 Jul 2025 23:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ruPz4zob"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EB112DDA1;
	Thu, 24 Jul 2025 23:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753398057; cv=none; b=FgIaV2zKHoKP2RKUFJmF7MQ4pd0SOISmUaqAEpJ7bBEDfM5vF+4RhsHUZ86d+rj2rN7VZWok8btH2TPFzShKV4yxx2uveFDtrIHajiSKwqd4OrVt6KAFwwb9dnCUf4y+qGIUhJZJKkbC2fcmDVb7j1vAtbnvAGKABRMxh4H1lQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753398057; c=relaxed/simple;
	bh=3JYZQt+JAnHY80WYO6Dt5cLmP0TzpcX9DK3P7DAJAAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BRNzsiMUQWc/ImPh66rFyElA0KlFaytjP4pM954S3/ZegJZbPI9JvYKtkl3uJKIhgHKv8sYMEu8x7lJyifAjwLXwHM9/o8JpaYVFaY8gr0BOLqnLZoCBVHKr1qncMHAb44+Qa22ZUCm7ScjISSGugd4h9hYN07q2/AScOLAXddE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ruPz4zob; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3i+oaVRycYF7HLHNCz5mfZUDTy1ALYFSThoeXYMOmqY=; b=ruPz4zobhEv1cmo6reTDD2cDUE
	Khoh0VKsiWzoq4VbP0YZCKhseh5HIrHi7e0GbnAnPeSaNh0AeR/0hvJsz6CdUXhTkBXa5jDdgZlS3
	1NZV4oCDNNQuUNvUGtb+YJfO1gBfj9TkHWVr+C1+grY8aaBY7A950ct79URrbmuYiaD3XqqlqhFvY
	OXK8xrsflSfa+IijYAGhPUGAlMSRLpO+/td7PlfYjsOF+NwDDvXP24XBIrpxs5eZNjK+3wu413xgy
	BvdqHfBd3+yoFEYT1SEkcb9GHtpFvAxDRrJWfV4oHcUWCG2XJqHnLlSKcTNe2LZmksQtcJbJOZrvZ
	qmxhHMAQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uf4vk-000000092zN-2tP8;
	Thu, 24 Jul 2025 23:00:52 +0000
Date: Fri, 25 Jul 2025 00:00:52 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Andrei Vagin <avagin@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, criu@lists.linux.dev
Subject: Re: do_change_type(): refuse to operate on unmounted/not ours mounts
Message-ID: <20250724230052.GW2580412@ZenIV>
References: <CANaxB-xXgW1FEj6ydBT2=cudTbP=fX6x8S53zNkWcw1poL=L2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANaxB-xXgW1FEj6ydBT2=cudTbP=fX6x8S53zNkWcw1poL=L2A@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Jul 24, 2025 at 01:02:48PM -0700, Andrei Vagin wrote:
> Hi Al and Christian,
> 
> The commit 12f147ddd6de ("do_change_type(): refuse to operate on
> unmounted/not ours mounts") introduced an ABI backward compatibility
> break. CRIU depends on the previous behavior, and users are now
> reporting criu restore failures following the kernel update. This change
> has been propagated to stable kernels. Is this check strictly required?

Yes.

> Would it be possible to check only if the current process has
> CAP_SYS_ADMIN within the mount user namespace?

Not enough, both in terms of permissions *and* in terms of "thou
shalt not bugger the kernel data structures - nobody's priveleged
enough for that".

What the hell is CRIU trying to do there?

