Return-Path: <linux-fsdevel+bounces-54355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7D2AFE9C2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 15:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 113B26429AE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 13:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7333435962;
	Wed,  9 Jul 2025 13:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ekzGI7f9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BF52DEA7C;
	Wed,  9 Jul 2025 13:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752066761; cv=none; b=sair9oq9HRAFfuo8x8G6Q5Qbnr3WknYKxOX/qp4XZE3H3z7WR7PHpVpyiuFjTyo8NzmvR2fnld13GOP8i17Y5JQDXyul3Ddxxe/oqzuydQ1kP9ShGb0iblP3MT2tsxDoTt1RzgYCff89Wtkc53xMjuURd8lepjCxXUyAWYASB2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752066761; c=relaxed/simple;
	bh=LKmv2NGpBCcZcf6hJ/d0Vq5FxARLGPHo4jAek1f/S1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+wOTrPrcX2ChdBEqVvFFYJ81S+761fRTJsiRcLZjxr4CYCAy+nPR0xWq4mHs9Ba0KZbapI/5xnyAwZ9KSUh8baAZYsqpdyE1gPqFvaVL9GvdvGQWp0dCMrwzBW9e3rPKWKtp9CpF+GdoehXtRaQbF42fMqxAGQWqjW/asnfFuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ekzGI7f9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E24FCC4CEEF;
	Wed,  9 Jul 2025 13:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752066761;
	bh=LKmv2NGpBCcZcf6hJ/d0Vq5FxARLGPHo4jAek1f/S1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ekzGI7f9ZZkTVoA82pA6xEoD1oSq/Vdb0zKv5JrgywH1B47y/avKon/JEoFd6cX3X
	 oWg6/dZg+atnjrfJVFvtw9u83ulNoxpWx+HiNrozpn/d+sQJRNy4+z8WICGWEEG2ev
	 dr67WLAMsbsXufNf0cAN6nv0OsacLB4GtkDnF40E=
Date: Wed, 9 Jul 2025 15:12:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: "Heyne, Maximilian" <mheyne@amazon.de>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Sauerwein, David" <dssauerw@amazon.de>,
	Sasha Levin <sashal@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 5.15] fs/proc: do_task_stat: use __for_each_thread()
Message-ID: <2025070905-blooper-unplowed-7e9f@gregkh>
References: <20250605-monty-tee-7cec3e1e@mheyne-amazon>
 <ef0e0364-29e2-47c2-8f0a-93f385cebf08@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef0e0364-29e2-47c2-8f0a-93f385cebf08@oracle.com>

On Wed, Jul 09, 2025 at 05:33:39PM +0530, Harshit Mogalapalli wrote:
> Hi,
> 
> + stable

Not much we can do with this, it needs to be submitted to us in a form
we can apply it in (i.e. sent to the stable list...)

thanks,

greg k-h

