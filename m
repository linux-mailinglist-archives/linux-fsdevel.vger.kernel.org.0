Return-Path: <linux-fsdevel+bounces-34623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D169C6CB8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 11:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4151328BE91
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 10:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D261FBC86;
	Wed, 13 Nov 2024 10:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Urxv04DL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478DC282EE
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 10:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731493242; cv=none; b=HtUnLhjjl2TpFFiesn6zw+Tx4JwnNuq8AM5chcWty663r+im5cAdKPmPlukj7yXa6OH62oHu2nzvbdhgzUT7b9wYHi9DHnXNCj69Afb53Qn988vRAf5bt1V9T7v3HSUxv43xe9LhTCZlBOPCrLRqUNiNkl8DuczSm+TYBG5qQnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731493242; c=relaxed/simple;
	bh=gI+REbIbJrsVaNNUbsEYrZXh6EQ2sC2eVt9afJwn8z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AqmiwNlp/+yXyp8DKktyqSiu4xZVA126bOo1LbSEBcNqb3hGWaU6CnXGc2mq9DgX2lXxRSyLnb9krLddoWH9LtYmsuLy3j/UgEBGMc60Poxwch51AuzGp//R1nd2BiAU7yJw02yST+eocyEoC3bGwq/HBKx74M/mPjKkb1AQzjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Urxv04DL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69AC1C4CECD;
	Wed, 13 Nov 2024 10:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731493241;
	bh=gI+REbIbJrsVaNNUbsEYrZXh6EQ2sC2eVt9afJwn8z0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Urxv04DLAm3IEXhnnmxxMiDPz2DTJ7SqBgaQ7ovYzLeYdv4PhZfgqH6jNmjZy1fxk
	 r9FH/Ghy56XepDbss+DlaTNCQvhV8igg4VmrJ4G3j4gGfLqrlo91i5KpPVL9TbfT4w
	 mgbHr7It6QcTiaje5E86Jd4g6OlVbc8pVZ/t5sUXNPi2MRpy8FEeLtyNNelW3ICR0J
	 08Gt7pii4T2MxfKIrVPh04rdV8hbQvKEFfwBFbkraSgULa635nokZhB4hD2dyLe3fW
	 D+drZ2PQvGm0ZFyjeOk8330KiM7aG1+fUyq3Q223k1KWxKG9JU3xhadDEdA1roG3/j
	 0p4t0FUkJz4zg==
Date: Wed, 13 Nov 2024 11:20:37 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 2/5] kill getname_statx_lookup_flags()
Message-ID: <20241113-angemacht-funkverkehr-e8cc46315d5b@brauner>
References: <20241112202118.GA3387508@ZenIV>
 <20241112202552.3393751-1-viro@zeniv.linux.org.uk>
 <20241112202552.3393751-2-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241112202552.3393751-2-viro@zeniv.linux.org.uk>

On Tue, Nov 12, 2024 at 08:25:49PM +0000, Al Viro wrote:
> LOOKUP_EMPTY is ignored by the only remaining user, and without
> that 'getname_' prefix makes no sense.
> 
> Remove LOOKUP_EMPTY part, rename to statx_lookup_flags() and make
> static.  It most likely is _not_ statx() specific, either, but
> that's the next step.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

