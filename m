Return-Path: <linux-fsdevel+bounces-23879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1807A9343E2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 23:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94BEEB24268
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 21:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA79518A940;
	Wed, 17 Jul 2024 21:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TdvaaN8x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1487A1DFC7;
	Wed, 17 Jul 2024 21:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721251710; cv=none; b=ADOwZgBHvYD1D3i9kZuFmo14ajGK+kRU/OnjoCPpjFARLnP7IQgWN7amRmL9CLjmukTYjsl+tE3XpCLPC04oj+MimyYrg8A7/S9+eYp5jTGR80JVg3Wsr5EJW6+/+rp0qinUQBHF/05CTd0Grhyh2BA2yl90o3Z5QduBho3RJR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721251710; c=relaxed/simple;
	bh=Ez4225G2NV+0TxVgoB4yehSB6Z1gZ+vNNquCmaxqDyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rufir7sFvD0pX7uZHELZhs6GZfnnzZ/kcmC/adYe6XTcAcJ1BA7sC/Ddy6K6grkurxDVLG5Gz8KXjTesUQr04hct04Znjx8xfazoLzCFmnc3yFGWLFiqx7Xz0sSbFe1T+4veFOnfslEYjPlq8yKtXQ7L0JvgK2pmeE4BWFLr5pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TdvaaN8x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A36C2BD10;
	Wed, 17 Jul 2024 21:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721251709;
	bh=Ez4225G2NV+0TxVgoB4yehSB6Z1gZ+vNNquCmaxqDyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TdvaaN8xiTbNbpop7iYQE9Zi+65HRNfXxktUVfm065CE1PtHv7uJpMW01Nxx/HOXQ
	 bgfzyKETKZForMMsG/wZprYpqnBOqkMwlz+8eVY42CEzR8j4FOoGhOC204IR8doYfl
	 TYmS/w6XgVtXvCU1aFJ2n9SYtSJuNufWo2+iMv5OBBEJzlO3aqrXucfQEriZWM9xTN
	 ya3HyH3kvE9b2ZBWHlQ5OcrTM0yAnfdM6oNFLbFCt04RliJGGTAbqOBBF0lZKOPgH0
	 H55hD18IYY2IkfQmKFfzCEihRnn8fwcOrykoQqVujcuVa+xCdGl63kpecVi2UJCW6n
	 PuKdX3Aj1oC2g==
Date: Wed, 17 Jul 2024 14:28:29 -0700
From: Kees Cook <kees@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, kernel@collabora.com,
	gbiv@google.com, inglorion@google.com, ajordanr@google.com,
	Doug Anderson <dianders@chromium.org>, Jeff Xu <jeffxu@google.com>,
	Jann Horn <jannh@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] proc: add config to block FOLL_FORCE in mem writes
Message-ID: <202407171426.4DE97F7@keescook>
References: <20240717111358.415712-1-adrian.ratiu@collabora.com>
 <20240717205335.GA3632@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717205335.GA3632@sol.localdomain>

On Wed, Jul 17, 2024 at 01:53:35PM -0700, Eric Biggers wrote:
> On Wed, Jul 17, 2024 at 02:13:58PM +0300, Adrian Ratiu wrote:
> > +config SECURITY_PROC_MEM_RESTRICT_FOLL_FORCE
> > +	bool "Remove FOLL_FORCE usage from /proc/pid/mem writes"
> > +	default n
> > +	help
> > +	  This restricts FOLL_FORCE flag usage in procfs mem write calls
> > +	  because it bypasses memory permission checks and can be used by
> > +	  attackers to manipulate process memory contents that would be
> > +	  otherwise protected.
> > +
> > +	  Enabling this will break GDB, gdbserver and other debuggers
> > +	  which require FOLL_FORCE for basic functionalities.
> > +
> > +	  If you are unsure how to answer this question, answer N.
> 
> FOLL_FORCE is an internal flag, and people who aren't kernel developers aren't
> going to know what it is.  Could this option be named and documented in a way
> that would be more understandable to people who aren't kernel developers?  What
> is the effect on how /proc/pid/mem behaves?

"Do not bypass RO memory permissions via /proc/$pid/mem writes" ?

-- 
Kees Cook

