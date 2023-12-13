Return-Path: <linux-fsdevel+bounces-5842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E71AD810FB4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 12:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C8B91F21200
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 11:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E81123765;
	Wed, 13 Dec 2023 11:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="MDlsJjRK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [IPv6:2001:1600:3:17::bc0d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B83EA
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 03:21:28 -0800 (PST)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
	by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4SqtN43LsgzMq7Nh;
	Wed, 13 Dec 2023 11:21:24 +0000 (UTC)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4SqtN34wRyzMpnPs;
	Wed, 13 Dec 2023 12:21:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1702466484;
	bh=R1jT/Ixs62kOgk8GjZHMk/bnGe9wVVziPfUyW72MSsM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MDlsJjRK+Z47avYDWJ7D3jfJd79Ovwszr1i+W+NommzQWF9UsLWsyJFFqfVRVOu7w
	 twcBhNiKuCkgTVUWA4DQIL1YVuXsepSRjM3w7fLdscabbMf51uihtyqv3xwV5J+EZY
	 oRICXaRB/FY9yd0OWJpg/zimPackHq3p/43oqusE=
Date: Wed, 13 Dec 2023 12:21:04 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v8 9/9] landlock: Document IOCTL support
Message-ID: <20231213.yaeP8teus5su@digikod.net>
References: <20231208155121.1943775-1-gnoack@google.com>
 <20231208155121.1943775-10-gnoack@google.com>
 <20231211.ieZahkeiph1o@digikod.net>
 <ZXbNCkzHbvystV8t@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZXbNCkzHbvystV8t@google.com>
X-Infomaniak-Routing: alpha

On Mon, Dec 11, 2023 at 09:49:14AM +0100, Günther Noack wrote:
> Hello Mickaël!
> 
> Thanks for the review!
> 
> On Mon, Dec 11, 2023 at 08:04:33AM +0100, Mickaël Salaün wrote:
> > On Fri, Dec 08, 2023 at 04:51:21PM +0100, Günther Noack wrote:
> > > ++------------------------+-------------+-------------------+-------------------+
> > > +|                        | ``IOCTL``   | ``IOCTL`` handled | ``IOCTL`` handled |
> > > +|                        | not handled | and permitted     | and not permitted |
> > > ++------------------------+-------------+-------------------+-------------------+
> > > +| ``READ_FILE`` not      | allow       | allow             | deny              |
> > > +| handled                |             |                   |                   |
> > > ++------------------------+             +-------------------+-------------------+
> > > +| ``READ_FILE`` handled  |             | allow                                 |
> > > +| and permitted          |             |                                       |
> > > ++------------------------+             +-------------------+-------------------+
> > > +| ``READ_FILE`` handled  |             | deny                                  |
> > > +| and not permitted      |             |                                       |
> > > ++------------------------+-------------+-------------------+-------------------+
> > 
> > Great! Could you please format this table with the flat-table syntax?
> > See https://docs.kernel.org/doc-guide/sphinx.html#tables
> 
> This link actually says that “Kernel style for tables is to prefer simple table
> syntax or grid table syntax” (instead of the flat-table syntax).
> 
> This "visual" style is more cumbersome to edit, but editing documentation
> happens less than reading it, so further edits are less likely.  I also find it
> easier to reason about what the cell sizes are that way, rather than having to
> wrap my head around special :rspan: and :cspan: syntax.

Indeed, let's keep this ascii art.

> 
> If you are not strongly opposed to it, I'd prefer to keep the existing style,
> but we can do it either way if you feel strongly about it.  Let me know how
> important this is to you.
> 
> Thanks,
> —Günther
> 

