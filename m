Return-Path: <linux-fsdevel+bounces-7840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6768782B88C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 01:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EBAB282B2F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 00:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A4C7F1;
	Fri, 12 Jan 2024 00:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RijKlkpv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A21362
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jan 2024 00:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d54b765414so34967625ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jan 2024 16:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705018718; x=1705623518; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7ckfdvUM867eVAU33Kckg9n+n5xC+joVeZXEKBZM060=;
        b=RijKlkpvw7ODd5O8Ssv7s5eRunAz8bwp3X8/wkHKPfUGeIjB5ff3SKlat/WrgUDFfs
         3o43mAPemKNjUN9kx405TWpxN2cuk5rIJ6jyoWY+W+nlyqNcfTNSqAt9PRd5Z99b2b5a
         XMWQ4TBXMtDEOfaR7bDUDlSWsnirGiecXqVww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705018718; x=1705623518;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ckfdvUM867eVAU33Kckg9n+n5xC+joVeZXEKBZM060=;
        b=ZE3CxHkOWB/YQkVuI5Y/vyy4sIuy2+nzWdXe40uQjsHcbk9vxdCtvWrOKIawzCntgh
         4ItoQBWjTHr88mAplQYUiqKc5zpaPx2LJ+PwbIToe15pVXhpGHcM8v83i3T0pLdKppus
         IE7UQzgJbxJygwh1m3bgXNH+7kJm2wQJiYuhMABeeH/ameU7u8ZYp2WrWCNn+IF7klEY
         I2CpHIJROb0mD9Jtb0Q7mazNyGFFS1eXgyVltDMLPqKYcqlaO87uAovO4IU467/Q1BiL
         YqckxPvzWwTwd0Hutt2odM4hlm3xAbWy/u/PzZOGQcgrcgqAUvFUA/gFjgH39GavSakV
         yYPQ==
X-Gm-Message-State: AOJu0Yyrv0xGdvkWZRuYOhT/RqB/TKUgS9FvTbQA+1Y7o2lN9NHU/JcV
	FmQvR6h1s4PGkoUFkHD5i17n0MERlkjl
X-Google-Smtp-Source: AGHT+IEg/VLeJRae0TCJ6R9QiR4EWdGViVk1gVX6xzgnn/TW4WYKqjLPFs52GnpRs54GewYce/HrxA==
X-Received: by 2002:a17:903:25c3:b0:1d4:1f06:f4e0 with SMTP id jc3-20020a17090325c300b001d41f06f4e0mr121227plb.137.1705018718030;
        Thu, 11 Jan 2024 16:18:38 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n11-20020a170902d2cb00b001d398889d4dsm1754222plc.127.2024.01.11.16.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 16:18:37 -0800 (PST)
Date: Thu, 11 Jan 2024 16:18:37 -0800
From: Kees Cook <keescook@chromium.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Matthew Wilcox <willy@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs updates for 6.8
Message-ID: <202401111613.781DFC8@keescook>
References: <wq27r7e3n5jz4z6pn2twwrcp2zklumcfibutcpxrw6sgaxcsl5@m5z7rwxyuh72>
 <202401101525.112E8234@keescook>
 <6pbl6vnzkwdznjqimowfssedtpawsz2j722dgiufi432aldjg4@6vn573zspwy3>
 <202401101625.3664EA5B@keescook>
 <xlynx7ydht5uixtbkrg6vgt7likpg5az76gsejfgluxkztukhf@eijjqp4uxnjk>
 <CAHk-=wigjbr7d0ZLo+6wbMk31bBMn8sEwHEJCYBRFuNRhzO+Kw@mail.gmail.com>
 <ZaByTq3uy0NfYuQs@casper.infradead.org>
 <202401111534.859084884C@keescook>
 <zocgn7zzr4wo3egjnq2vpmh7kpuxcj7gvo3a5tlbidt6wdh4rs@2udxphdcgeug>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zocgn7zzr4wo3egjnq2vpmh7kpuxcj7gvo3a5tlbidt6wdh4rs@2udxphdcgeug>

On Thu, Jan 11, 2024 at 07:05:06PM -0500, Kent Overstreet wrote:
> On Thu, Jan 11, 2024 at 03:42:19PM -0800, Kees Cook wrote:
> > On Thu, Jan 11, 2024 at 10:57:18PM +0000, Matthew Wilcox wrote:
> > > On Wed, Jan 10, 2024 at 05:47:20PM -0800, Linus Torvalds wrote:
> > > > No, because the whole idea of "let me mark something deprecated and
> > > > then not just remove it" is GARBAGE.
> > > > 
> > > > If somebody wants to deprecate something, it is up to *them* to finish
> > > > the job. Not annoy thousands of other developers with idiotic
> > > > warnings.
> > > 
> > > What would be nice is something that warned about _new_ uses being
> > > added.  ie checkpatch.  Let's at least not make the problem worse.
> > 
> > For now, we've just kind of "dealt with it". For things that show up
> > with new -W options we've enlisted sfr to do the -next builds with it
> > explicitly added (but not to the tree) so he could generate nag emails
> > when new warnings appeared. That could happen if we added it to W=1
> > builds, or some other flag like REPORT_DEPRECATED=1.
> > 
> > Another ugly idea would be to do a treewide replacement of "func" to
> > "func_deprecated", and make "func" just a wrapper for it that is marked
> > with __deprecated. Then only new instances would show up (assuming people
> > weren't trying to actively bypass the deprecation work by adding calls to
> > "func_deprecated"). :P Then the refactoring to replace "func_deprecated"
> > could happen a bit more easily.
> > 
> > Most past deprecations have pretty narrow usage. This is not true with
> > the string functions, which is why it's more noticeable here. :P
> 
> Before doing the renaming - why not just leave a kdoc comment that marks
> it as deprecated? Seems odd that checkpatch was patched, but I can't
> find anything marking it as deprecated when I cscope to it.

It doesn't explicitly say "deprecated", but this language has been in
the kdoc for a while now (not that people go read this often):

 * Do not use this function. While FORTIFY_SOURCE tries to avoid
 * over-reads when calculating strlen(@q), it is still possible.
 * Prefer strscpy(), though note its different return values for
 * detecting truncation.

But it's all fine -- we're about to wipe out strlcpy for v6.8. Once the
drivers-core and drm-misc-next trees land, (and the bcachefs patch[1])
we'll be at 0 users. :)

-Kees

[1] https://lore.kernel.org/lkml/20240110235438.work.385-kees@kernel.org/

-- 
Kees Cook

