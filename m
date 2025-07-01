Return-Path: <linux-fsdevel+bounces-53478-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA82BAEF6E2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 13:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55747447A85
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 11:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310612737F6;
	Tue,  1 Jul 2025 11:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYmJfDQg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3B22737F0;
	Tue,  1 Jul 2025 11:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751370071; cv=none; b=Pe2eK4i0l16sUHL+aoHpZfpFB8v1EZPL2phLFA+ISS9VV1srbPQkPQNCwOr1GobB8s736ifBXvWgOYiKQUY23qD01kYClnxIzh45aQiDZe4r3DgudToazDdKe7v5jvFK5cu1HrvGWFKl28UEroejB0pXxjP2/xbzVGB+lD1+3BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751370071; c=relaxed/simple;
	bh=m6pSYy0tOJNXW7ylgEySqJmEjacZzj22J0Usd7Xsnhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tm3I8Xynm5dQNqP8O7H+s5+bx6IZykbaeXg1MhV5O7+8c199+/r/+HJ/+f3EnXz+4VEdzsCZJqW8SnowZBnTgtXXi8KaQA61d++a79UqAhYX8aEhfdVxnO7mY8adkztQU5hpdDFswSH8t8dhpud8JAWyYf+riP/DFUMqU7TyLY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYmJfDQg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 400B6C4CEEB;
	Tue,  1 Jul 2025 11:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751370071;
	bh=m6pSYy0tOJNXW7ylgEySqJmEjacZzj22J0Usd7Xsnhk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XYmJfDQgjwW/irh721f6asrwGaTLKzGybVLOL4ZXYAzXr0d4N33s7zjaGDn3H4SYg
	 gQ4rajHiARf3HX/cV6soZIXSONNHEXy0EYAPFjuH+bONtrKOhsAVRbACUKVbryfY4O
	 5UJCxlSzteDBYnE1gJVHvdLNGshMnNYGeKXSgCfe43rHNWWW+6RiqLfImMVOaoVEzf
	 W4xZafS8kDa2dT45nEMt5BDAp0YO+cVLEuASMtc7hKao37mvUql/ZRjX/pAW2Wq/04
	 OfC1xi3iaNldsfCrjLkg5aEVSfkkpQHoM5aeDagiu1LEheCFO8sJamPVOkvikgN2S0
	 xSRQo9PqSEXwQ==
Date: Tue, 1 Jul 2025 13:41:06 +0200
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
	linux-cifs@vger.kernel.org, netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfs: Merge i_size update functions
Message-ID: <20250701-weswegen-wippt-089188706c33@brauner>
References: <1576470.1750941177@warthog.procyon.org.uk>
 <1587239.1750941876@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1587239.1750941876@warthog.procyon.org.uk>

On Thu, Jun 26, 2025 at 01:44:36PM +0100, David Howells wrote:
> Here's a follow up patch to the previous one, though this would be for next -
> and assuming it's okay to do the i_blocks update in the DIO case which it
> currently lacks.
> 
> David
> ---
> Netfslib has two functions for updating the i_size after a write: one for
> buffered writes into the pagecache and one for direct/unbuffered writes.
> However, what needs to be done is much the same in both cases, so merge
> them together.
> 
> This does raise one question, though: should updating the i_size after a
> direct write do the same estimated update of i_blocks as is done for
> buffered writes.
> 
> Also get rid of the cleanup function pointer from netfs_io_request as it's
> only used for direct write to update i_size; instead do the i_size setting
> directly from write collection.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Steve French <sfrench@samba.org>
> cc: Paulo Alcantara <pc@manguebit.org>
> cc: linux-cifs@vger.kernel.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---

I have one big ask. Please please please put your comments after the
commit message --- separator. Otherwise git/b4 will take your top
comment as the commmit message and discard the actual commit message.

