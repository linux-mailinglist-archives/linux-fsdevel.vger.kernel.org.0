Return-Path: <linux-fsdevel+bounces-4589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB22180102D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 17:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75C542817E7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 16:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BF7249F3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 16:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Tn0U8AZd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6614193
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 07:05:49 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-111-98.bstnma.fios.verizon.net [173.48.111.98])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3B1F4gCV018398
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 1 Dec 2023 10:04:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1701443088; bh=b232xKygdMBKVyuYMmIG89ffhPZBtNMuA1DPdGrLdQc=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=Tn0U8AZdsfDguoM56HrG6xTK4HaV3SnqaHky5rL9N1bgVcF2UEtN1Zyr4PBAf4L1m
	 Uf7QW8crSJ7itqtKNDvMklkRIVQV3pPKcvpqa13PPO24G2zXz2gzTIN0ekUUoHnnEa
	 yiPZQqVZUprsrxN9n2oYC+RFaw/xahZHk/QzkdpRT89K1O8ZCnLlv2YF4GQmX67bUB
	 1eZ0f1DF9GNymKUndRkYWnCz6ErWvlkuB0xsc5GGuqsRC8eLJCr4w8OU3V2s32/4kr
	 QLmKEDUSo8AEZrpv2sRZi51n3lYqPofjA1izDafwSAyseWBWUZM1Gn38jmSbUREzO/
	 vAFEzKb+HBYrw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 5752115C027C; Fri,  1 Dec 2023 10:04:42 -0500 (EST)
Date: Fri, 1 Dec 2023 10:04:42 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Alice Ryhl <aliceryhl@google.com>
Cc: david.laight@aculab.com, a.hindborg@samsung.com, alex.gaynor@gmail.com,
        arve@android.com, benno.lossin@proton.me, bjorn3_gh@protonmail.com,
        boqun.feng@gmail.com, brauner@kernel.org, cmllamas@google.com,
        dan.j.williams@intel.com, dxu@dxuuu.xyz, gary@garyguo.net,
        gregkh@linuxfoundation.org, joel@joelfernandes.org,
        keescook@chromium.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, maco@android.com, ojeda@kernel.org,
        peterz@infradead.org, rust-for-linux@vger.kernel.org,
        surenb@google.com, tglx@linutronix.de, tkjos@android.com,
        viro@zeniv.linux.org.uk, wedsonaf@gmail.com, willy@infradead.org
Subject: Re: [PATCH 1/7] rust: file: add Rust abstraction for `struct file`
Message-ID: <20231201150442.GC509422@mit.edu>
References: <386bbdee165d47338bc451a04e788dd6@AcuMS.aculab.com>
 <20231201122740.2214259-1-aliceryhl@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201122740.2214259-1-aliceryhl@google.com>

On Fri, Dec 01, 2023 at 12:27:40PM +0000, Alice Ryhl wrote:
> 
> You can import it with a use statement. For example:
> 
> use kernel::file::flags::O_RDONLY;
> // use as O_RDONLY

That's good to hear, but it still means that we have to use the XYZ_*
prefix, because otherwise, after something like

use kernel::file::flags::RDONLY;
use kernel::uapi::rwf::RDONLY;

that will blow up.  So that has to be

use kernel::file::flags::O_RDONLY;
use kernel::uapi::rwf::RWF_RDONLY;

Which is a bit more verbose, at least things won't blow up
spectacularly when you need to use both namespaces in the same
codepath.

Also note how we do things like this:

#define IOCB_APPEND          (__force int) RWF_APPEND

In other words, the IOCB_* namespace and the RWF_* namespace partially
share code points, and so they *have* to be assigned to the same value
--- and note that since RWF_APPEND is defined as part of the UAPI, it
might not even be the same across different architectures....

Cheers,

						- Ted

