Return-Path: <linux-fsdevel+bounces-57122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D97A3B1EEBA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 21:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6A541C23EF2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 19:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF61285C9B;
	Fri,  8 Aug 2025 19:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MVbd3V2B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A3E20468E;
	Fri,  8 Aug 2025 19:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754679979; cv=none; b=VJ8oY7J/j8LJt1W3DXUf8k6axH7PbUbx/mLSYNP4fttHKt+PYvl8rH5UYJ8L/o8tBeoEGg0Sd4UUL6JsUBJhamwgNW9IT6hlgWE+xlrsbIuaSuAnAaqzngmA/+GowqjVPNIaNnlRB4jIF/i/Vt63HCP2WNs5i1zvFXzSEDJ6ZH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754679979; c=relaxed/simple;
	bh=ihLtk4YDljPoQsVr1k+Q6KdWqVvNlEugtmCKJzbpreQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=maEzDQRRNUDuveilOLvbYQQLBB2n4mB81RQAxpdGbUc4PE6YqGA5em0gmZmeupjX28tOmkxjKbKWHBrJU9HA1N50Wv+PEGf/qcoWEsetnu5rfAlmxordiBuDxGhRHMrT5XkCkmc4JixiQ43nF8HTmPPY32gehxlo8OS8jzb8Wlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MVbd3V2B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F40C4CEED;
	Fri,  8 Aug 2025 19:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1754679979;
	bh=ihLtk4YDljPoQsVr1k+Q6KdWqVvNlEugtmCKJzbpreQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MVbd3V2B9PU2DpN4YFj4kXo77JcV02cklLt8Ew+/o0xBULibQLCGSDhPk+5YuQ/mj
	 6eGZKLNUShdnj3lo4imTZWyM+09/f2GhQBTb6C+0BGVP3d88ljwJ6pK750+ZjcNkFs
	 J83iYdBJegh8zofo/HjfG0v4JbPN3aOrqef3Y5ik=
Date: Fri, 8 Aug 2025 12:06:16 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, jasonmiu@google.com,
 graf@amazon.com, changyuanl@google.com, rppt@kernel.org,
 dmatlack@google.com, rientjes@google.com, corbet@lwn.net,
 rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com,
 kanie@linux.alibaba.com, ojeda@kernel.org, aliceryhl@google.com,
 masahiroy@kernel.org, tj@kernel.org, yoann.congal@smile.fr,
 mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com,
 axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com,
 vincent.guittot@linaro.org, hannes@cmpxchg.org, dan.j.williams@intel.com,
 david@redhat.com, joel.granados@kernel.org, rostedt@goodmis.org,
 anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn,
 linux@weissschuh.net, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-mm@kvack.org, gregkh@linuxfoundation.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org,
 cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com,
 Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
 aleksander.lobakin@intel.com, ira.weiny@intel.com,
 andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
 bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
 stuart.w.hayes@gmail.com, lennart@poettering.net, brauner@kernel.org,
 linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 saeedm@nvidia.com, ajayachandra@nvidia.com, jgg@nvidia.com,
 parav@nvidia.com, leonro@nvidia.com, witu@nvidia.com
Subject: Re: [PATCH v3 01/30] kho: init new_physxa->phys_bits to fix lockdep
Message-Id: <20250808120616.40842e9a9fdc056c9eb74123@linux-foundation.org>
In-Reply-To: <CA+CK2bBoMNEfyFKgvKR0JvECpZrGKP1mEbC_fo8SqystEBAQUA@mail.gmail.com>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
	<20250807014442.3829950-2-pasha.tatashin@soleen.com>
	<mafs0o6sqavkx.fsf@kernel.org>
	<mafs0bjoqav4j.fsf@kernel.org>
	<CA+CK2bBoMNEfyFKgvKR0JvECpZrGKP1mEbC_fo8SqystEBAQUA@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 8 Aug 2025 14:00:08 +0000 Pasha Tatashin <pasha.tatashin@soleen.com> wrote:

> > > I suppose this could be simplified a bit to:
> > >
> > >       err = xa_err(physxa);
> > >         if (err || physxa) {
> > >               xa_destroy(&new_physxa->phys_bits);
> > >                 kfree(new_physxa);
> > >
> > >               if (err)
> > >                       return err;
> > >       } else {
> > >               physxa = new_physxa;
> > >       }
> >
> > My email client completely messed the whitespace up so this is a bit
> > unreadable. Here is what I meant:
> >
> >         err = xa_err(physxa);
> >         if (err || physxa) {
> >                 xa_destroy(&new_physxa->phys_bits);
> >                 kfree(new_physxa);
> >
> >                 if (err)
> >                         return err;
> >         } else {
> >                 physxa = new_physxa;
> >         }
> >
> > [...]
> 
> Thanks Pratyush, I will make this simplification change if Andrew does
> not take this patch in before the next revision.
> 

Yes please on the simplification - the original has an irritating
amount of kinda duplication of things from other places.  Perhaps a bit
of a redo of these functions would clean things up.  But later.

Can we please have this as a standalone hotfix patch with a cc:stable? 
As Pratyush helpfully suggested in
https://lkml.kernel.org/r/mafs0sei2aw80.fsf@kernel.org.

Thanks.

