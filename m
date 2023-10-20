Return-Path: <linux-fsdevel+bounces-858-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D97A97D1720
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 22:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 173501C20F42
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 20:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9818424A07;
	Fri, 20 Oct 2023 20:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463F8249F3
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 20:36:41 +0000 (UTC)
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C2BD65
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 13:36:40 -0700 (PDT)
Received: from localhost (88-113-24-34.elisa-laajakaista.fi [88.113.24.34])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id 5d4b40fc-6f88-11ee-b972-005056bdfda7;
	Fri, 20 Oct 2023 23:36:37 +0300 (EEST)
From: andy.shevchenko@gmail.com
Date: Fri, 20 Oct 2023 23:36:36 +0300
To: Jan Kara <jack@suse.cz>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Baokun Li <libaokun1@huawei.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>, Jan Kara <jack@suse.cz>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Kees Cook <keescook@chromium.org>,
	Ferry Toth <ftoth@exalondelft.nl>, linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: [GIT PULL] ext2, quota, and udf fixes for 6.6-rc1
Message-ID: <ZTLk1G0KCF7YNjRx@surfacebook.localdomain>
References: <ZTFh0NeYtvgcjSv8@smile.fi.intel.com>
 <CAHk-=wjXG52UNKCwwEU1A+QWHYfvKOieV0uFOpPkLR0NSvOjtg@mail.gmail.com>
 <CAHk-=whis2BJF2fv1xySAg2NTQ+C5fViNSGkLNCOqGzi-3y+8w@mail.gmail.com>
 <ZTFxEcjo4d6vXbo5@smile.fi.intel.com>
 <ZTFydEbdEYlxOxc1@smile.fi.intel.com>
 <CAHk-=wh_gbZE_ZsQ6+9gSPdXfoCtmuK-MFmBkO3ywMKFQEvb6g@mail.gmail.com>
 <ZTKUDzONVHXnWAJc@smile.fi.intel.com>
 <CAHk-=wipA4605yvnmjW7T9EvARPRCGLARty8UUzRGxic1SXqvg@mail.gmail.com>
 <ZTLHBYv6wSUVD/DW@smile.fi.intel.com>
 <CAHk-=wgHFSTuANT3jXsw1EtzdHQe-XQtWQACzeFxn2BEBzX-gA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgHFSTuANT3jXsw1EtzdHQe-XQtWQACzeFxn2BEBzX-gA@mail.gmail.com>

Fri, Oct 20, 2023 at 12:43:56PM -0700, Linus Torvalds kirjoitti:
> On Fri, 20 Oct 2023 at 11:29, Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> >
> > I'll reply to this with the attached object file, I assume it won't go to the
> > mailing list, but should be available in your mailbox.
> 
> Honestly, both cases (that function gets inlined twice) look
> *identical* from a quick look, apart from obviously the extra call to
> __quota_error().
> 
> I might be missing something, but this most definitely is not a "gcc
> ends up creating very different code when it doesn't need to
> synchronize around the call" thing.
> 
> So a compiler issue looks very unlikely. No absolute guarantees - I
> didn't do *that* kind of walk-through instruction by instruction - but
> the results actually seem to line up perfectly.
> 
> Even register allocation didn't change, making the compare between #if
> 0 and without rather easy.
> 
> There's one extra spill/reload due to the call in the "non-#if0" case,
> and that actually made me look twice (because it spilled %eax, and
> then reloaded it as %rcx), but it turns that %eax/%ecx had the same
> value at the time of the spill, so even that was not a "real"
> difference.
> 
> So I will claim that no, it's not the compiler. It's some unrelated
> subtle timing, or possibly just a random code layout issue (because
> the code addresses do obviously change).

Okay, but since now I can't use the certain configuration, the bug is
persistent to me after this merge with the GCC. Yet, you mentioned that
you would expect some reports but I don't think many people have a
configuration similar to what I have. In any case a bug is lurking somewhere
there.

Let me check next week on different CPU (but I'm quite sceptical that it
may anyhow trigger the same behaviour as if it's a timing, many parameters
are involved, including hardware clocks, etc).

That said, if you or anyone has ideas how to debug futher, I'm all ears!

-- 
With Best Regards,
Andy Shevchenko



