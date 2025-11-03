Return-Path: <linux-fsdevel+bounces-66829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E845C2D036
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 17:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 900484E994E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 16:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D0A316183;
	Mon,  3 Nov 2025 16:10:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DA8314B7F;
	Mon,  3 Nov 2025 16:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762186222; cv=none; b=dtdGY32zxoKqVJa0uRdbNewXMo+/gdwE5AXOeJAtVVvjJrAQcPvogD1F6SXmQuV42dBZO+/cXikmry5NMfHz4xvXFgg+qx+eu9yB8PZepFBz7PTPw5j680/NQrOZalOVkXCPOqtnbvb1qFihyDrl8pKdfiE5Ly6wtysL6xBKC0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762186222; c=relaxed/simple;
	bh=PIZ4DoMJooALmRRVauNj4A/92u4T3LrS3MaC+zSCVos=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=INO79ymRvzStf0ENJqFJxQ/iA8rPSv0RbWoPB1sb+xcpYdmjhNYNGVPnsXf7FVXJJsunTh4CqgQ0hh6xLYVXJrvatmnXsSHz+ue3dHvRLB/AqN2LiUCcwQpo2VFQrVqTMMTl5wlfzxy/7dTVHZ7e2vfg3x8WL9Byrbux4loZiV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id ACF47139E08;
	Mon,  3 Nov 2025 16:10:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id D4E0A20026;
	Mon,  3 Nov 2025 16:10:14 +0000 (UTC)
Date: Mon, 3 Nov 2025 11:10:18 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-aio@kvack.org, linux-unionfs@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-nfs@vger.kernel.org,
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
 cgroups@vger.kernel.org, netdev@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 12/12] trace: use override credential guard
Message-ID: <20251103111018.1a063e6f@gandalf.local.home>
In-Reply-To: <20251103-work-creds-guards-prepare_creds-v1-12-b447b82f2c9b@kernel.org>
References: <20251103-work-creds-guards-prepare_creds-v1-0-b447b82f2c9b@kernel.org>
	<20251103-work-creds-guards-prepare_creds-v1-12-b447b82f2c9b@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: D4E0A20026
X-Stat-Signature: 9i8cwffmtnwb5s6qrjb8xtgzkiwywx5n
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19W/8xN94pNILmfZfTWKaYA/3XQ1AXwuhQ=
X-HE-Tag: 1762186214-326372
X-HE-Meta: U2FsdGVkX187oVSDRmUrDkx/y/qOH8UZf0p4/Uberk79CvGGM3PB+bS4hFQMtMBRnStKU7tlXn/ljHIltb999OspMxf1AbgAdGJ4HELAt2d5MaZ3fPZKklFy28lWO7r0IfW2NHvpDWpAzd6euKudbGYI+fHpMHhDMkXFuPEqjUv0+MRdLzcQFruKvrL4Gl9DwYesxzucXQGzI2pHTBcEz6bFpl9Bi1TKKSPcL3Nt+jnhVL/ZY4VjnpDa6O+uTo/zuM+YOrGhZidshqQRODml/FXmO4hQP0LvRRP2OeH65EderoO+6Iw5sJs9vuJe8U2RHjqtb5RfJ+b+TBT13gA7yEo+MTIUsNTsghvG0w3kvqWdz/+jfR9m7Faf4VcYB3h/KdOAB3mXHBvjf7jof/ORBw==

On Mon, 03 Nov 2025 15:57:38 +0100
Christian Brauner <brauner@kernel.org> wrote:

> Use override credential guards for scoped credential override with
> automatic restoration on scope exit.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  kernel/trace/trace_events_user.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

