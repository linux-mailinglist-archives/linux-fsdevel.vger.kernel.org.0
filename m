Return-Path: <linux-fsdevel+bounces-2515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D69117E6BA5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 14:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12CC01C2098F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 13:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0CE1DFFF;
	Thu,  9 Nov 2023 13:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i30VXecm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CD71DFDD
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 13:53:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83271C433C8;
	Thu,  9 Nov 2023 13:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699537988;
	bh=DOkFXo4rQIvkKDZn9MGABKWomW9J4qXXIaJ5EuZoppw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i30VXecmFh6cyDgEm2aZQZQTOFc+p8iFHx5SfSvXtEYK+ns5iCj4xWuP7k4F0iAX1
	 Ynyfpd9hEoKqHXYJtGvsueps81L1IIHBvRGPBXvwpe4TvnWn5T6KbkJEHGCHWRDPCv
	 EGxAF3PwGoqx5Hpqk2Z6U4JSlmmMrdLEU6M7oZKsdq5ApY+WW9dJto4jf6WYBfMMMg
	 VSw0wD8LTA2gkuKzUC/UcuvYT49E4XzICtlRPkD6Pn9kqr830+mP4EwXXoGrd15+2R
	 rru5JcjO7YoD8R01DZomB2QM1Kz7OUQTdKuC1BWjMd3y41CQIe12hfIdy1N1WiVOLi
	 TDWKNS9XlHXOg==
Date: Thu, 9 Nov 2023 14:53:04 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 07/22] shrink_dentry_list(): no need to check that dentry
 refcount is marked dead
Message-ID: <20231109-hundstage-barmherzigen-7e97704fede6@brauner>
References: <20231109061932.GA3181489@ZenIV>
 <20231109062056.3181775-1-viro@zeniv.linux.org.uk>
 <20231109062056.3181775-7-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231109062056.3181775-7-viro@zeniv.linux.org.uk>

On Thu, Nov 09, 2023 at 06:20:41AM +0000, Al Viro wrote:
> ... we won't see DCACHE_MAY_FREE on anything that is *not* dead
> and checking d_flags is just as cheap as checking refcount.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Could also be a WARN_ON_ONCE() on d_lockref.count > 0 if DCACHE_MAY_FREE
is set but probably doesn't matter,
Reviewed-by: Christian Brauner <brauner@kernel.org>

