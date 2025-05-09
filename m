Return-Path: <linux-fsdevel+bounces-48664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE61AB1CEF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 21:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF5B6A0671C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 19:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1872417D9;
	Fri,  9 May 2025 19:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gsUoVL4s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BD3221293;
	Fri,  9 May 2025 19:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746817373; cv=none; b=a+WjJdCWb3iUWIfgr4U/JBa1JxracZCOZQm5miocFnJASbng+iXfHuWkh0Yi2qE0WY/a9MkfQXKfvRnp+KQlo1Nm116q95aaLu8W6BFKCX/ogqRX/0doeeaNYN6xhWO6uNQTB2eZWj1QsKqVjoLJ5CoYDyXVmrjgAjQ3UEwfRFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746817373; c=relaxed/simple;
	bh=ua/zeA/cmsKUR9jnhkX22ndKSQwlwu7PdYE/f3HJ3CM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKF/yI3cczXLYPfbRR5NQD3bVoaloKPK5vQShCRu/3kKX8Q9/aw08ppIdErfd+q1dJ/YJu/PH2I0csQZWdV7Wl/JgqYte/9q2moobf72mDdXVGWZQzDZxgI8LjU91BJ0D04TZT3pOniK8bw+4TlOyS5jw1vAcJ3VwLKkaCz3t6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gsUoVL4s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C10FC4CEE4;
	Fri,  9 May 2025 19:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746817373;
	bh=ua/zeA/cmsKUR9jnhkX22ndKSQwlwu7PdYE/f3HJ3CM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gsUoVL4so4CmYRcBqERB7ojDk3QYKcvIFT2sVLlpVQbUW4UID2b8+uY64kEKKwTyM
	 1M9s9ikMx3Jy+UzAUvI7YmpAEh80kKufBxMr8jsbel6Jee1oDJxxpTau9hCVMiv9oq
	 akvf6mg6CHeVrMwKxPfiyWi7o2MqtRMSjdgOLAxymTB8Kqvedse0HOZmzFQrg5WtiN
	 phkYo2kOZvlnxhu9ZMNxvMjAl2dANGEn7qVVfcpaaaBB+TW/x8SSi4v2Mv5HQRiQt6
	 W8YIsu0sNWhs8q6VM336bGw7DGGARWg8osIpXheEwVL5ryuNK+VD38RONUURg+8K2k
	 dS1faas0NywnQ==
Date: Fri, 9 May 2025 12:02:50 -0700
From: Kees Cook <kees@kernel.org>
To: Joel Granados <joel.granados@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	rcu@vger.kernel.org, linux-mm@kvack.org,
	linux-parisc@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 04/12] mm: move randomize_va_space into memory.c
Message-ID: <202505091202.BFC3FBB85@keescook>
References: <20250509-jag-mv_ctltables_iter2-v1-0-d0ad83f5f4c3@kernel.org>
 <20250509-jag-mv_ctltables_iter2-v1-4-d0ad83f5f4c3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509-jag-mv_ctltables_iter2-v1-4-d0ad83f5f4c3@kernel.org>

On Fri, May 09, 2025 at 02:54:08PM +0200, Joel Granados wrote:
> Move the randomize_va_space variable together with all its sysctl table
> elements into memory.c. Register it to the "kernel" directory by
> adding it to the subsys initialization calls
> 
> This is part of a greater effort to move ctl tables into their
> respective subsystems which will reduce the merge conflicts in
> kernel/sysctl.c.
> 
> Signed-off-by: Joel Granados <joel.granados@kernel.org>

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

