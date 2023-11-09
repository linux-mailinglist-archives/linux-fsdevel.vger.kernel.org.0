Return-Path: <linux-fsdevel+bounces-2610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A49A7E7057
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 18:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FF0E1C20C6B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 17:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E98B225D9;
	Thu,  9 Nov 2023 17:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OtPUps+1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545B822339
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 17:33:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06095C433C9;
	Thu,  9 Nov 2023 17:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699551191;
	bh=ONAZfGT/GR+2C7wlkeNleBHtFqwPFxRAbrq2Ds2uw9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OtPUps+1l4PC+5LeHgHXLeT//zsVgvp5PIAH1Y6bnN++uS3zUZ30DtGp5WoCqY8IZ
	 DAcpm6Eo9u1hnCSIQK+QcE+69R9VPTR4fRwo0wPuAaJn1qXCcYsQ0InfWtTV75+eeZ
	 Hu4GRIzbbwUNwlSO3pQs6rsSXq/8WQ+LCSW1JyEz7kCh7AfbIJNF/F2A2aGZ+Muofd
	 TiiJD9nVnzt88lAjmPAkwy6MRFZyWJBPoKstSQBAcY29wEiEv9oHQdRPwZ+zxv+Yf6
	 r5cbx1JKjy2TmPylu/oF6BJuFCpeeH5wHbdrsEUrldj8xNYa6xxM9A/U62GMOn/fMS
	 IWJZYNpSMrcbw==
Date: Thu, 9 Nov 2023 18:33:06 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 21/22] d_prune_aliases(): use a shrink list
Message-ID: <20231109-stuhl-lampen-683c345c22e1@brauner>
References: <20231109061932.GA3181489@ZenIV>
 <20231109062056.3181775-1-viro@zeniv.linux.org.uk>
 <20231109062056.3181775-21-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231109062056.3181775-21-viro@zeniv.linux.org.uk>

On Thu, Nov 09, 2023 at 06:20:55AM +0000, Al Viro wrote:
> Instead of dropping aliases one by one, restarting, etc., just
> collect them into a shrink list and kill them off in one pass.
> 
> We don't really need the restarts - one alias can't pin another
> (directory has only one alias, and couldn't be its own ancestor
> anyway), so collecting everything that is not busy and taking it
> out would take care of everything evictable that had been there
> as we entered the function.  And new aliases added while we'd
> been dropping old ones could just as easily have appeared right
> as we return to caller...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Nice cleanup,
Reviewed-by: Christian Brauner <brauner@kernel.org>

