Return-Path: <linux-fsdevel+bounces-66828-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3353CC2D003
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 17:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D2916349265
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 16:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129BA315D51;
	Mon,  3 Nov 2025 16:09:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D2A313285;
	Mon,  3 Nov 2025 16:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762186196; cv=none; b=EmI8pzwU/EiMTvEl6akZ8hYLkLS+z+TzRvtDgkJy1GjTg+dw8smm0huWWlfMWFYR2MSDo+BECUMyOy4i+HVeMvEhi/UsAqvY77wkCk1F7zuRrYcyw31dL/kG2cC1Vy1z/AtNxWSxeSqxw+uMV6iPPSGtY6lO53+CTkb1EyMQQLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762186196; c=relaxed/simple;
	bh=xrxwG32n/y2oy1YHTu3G6RDWmunQWMgWRiwV4cS732s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l84mKzEjjQ5PFyBts8qGnpqfyiqRmyyCH65hA9dglaDh5jRISTBBmCfUVQFG+QeknFX1NY1ptoALaQWoB+dU78Fl2fJvsRXSypdGckZIOAz2x4DXmjuslt6ymZk1Ue+Xg5Aamvh7FC9jiG792Yl+EDuAwcyfj7EZuQ1WyWbfdjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id C84CD12ACEE;
	Mon,  3 Nov 2025 16:09:45 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id E4D1E20024;
	Mon,  3 Nov 2025 16:09:42 +0000 (UTC)
Date: Mon, 3 Nov 2025 11:09:46 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-aio@kvack.org, linux-unionfs@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-nfs@vger.kernel.org,
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
 cgroups@vger.kernel.org, netdev@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 11/12] trace: use prepare credential guard
Message-ID: <20251103110946.063f53da@gandalf.local.home>
In-Reply-To: <20251103-work-creds-guards-prepare_creds-v1-11-b447b82f2c9b@kernel.org>
References: <20251103-work-creds-guards-prepare_creds-v1-0-b447b82f2c9b@kernel.org>
	<20251103-work-creds-guards-prepare_creds-v1-11-b447b82f2c9b@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: f3a1jbh7gz5tygnr9ophixt6pum6i47w
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: E4D1E20024
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18u0U/NQFwhYc5xAY2TcmGwcG1D2BgWoTc=
X-HE-Tag: 1762186182-249034
X-HE-Meta: U2FsdGVkX1/oN4yafgD+MyqaAV3m0VoVtYRzu0D3nhVrjp7q8uA8Uc/g3Y1973pDGRtBMJFIpQ7B0O+F37rmbF8kIjhS7YPoQfvuYhqXbP66FkjkDqcxlSq/f9rE0VLfodvjXBeCq8tk6S9A50kqMRPnFBqoeWWggpvhArKEUJcxWbwhtGBUJA9D9GDy2rYSO7wzCitOaHdm8UT261o9vVM0wBxFfhfhIDvg4yDkUhUWC4l4RdGwq0vyz6roxCpZv5oWzdyX4MkQM3lYByyuZonkzkJpT2nT1UIISYlOxhoA6jv36VwIlmUVdl8Rp2E7rl7MGO6o9ABv2Rp0ARVpE/1Y8CPdK53RazVlow3RlyHTtAdeg3sjiAKEZ+dX7QrpdQ7cwXCa90kYxiksyJez7g==

On Mon, 03 Nov 2025 15:57:37 +0100
Christian Brauner <brauner@kernel.org> wrote:

> Use the prepare credential guard for allocating a new set of
> credentials.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  kernel/trace/trace_events_user.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

