Return-Path: <linux-fsdevel+bounces-41603-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B12D2A32B21
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 17:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 964001887D03
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 16:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E18A210F59;
	Wed, 12 Feb 2025 16:05:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0B21B21AD
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Feb 2025 16:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739376334; cv=none; b=meW6feRJmtb6nQ1SSpt2VgjxnSpP3I6n/ZSltGw50otSlLrCPCA2aAlFMX2DcBhi1wd5P8sVs8nbpfiim4WnLlFhXEJCs9WzzgEZ0uK1JxIix1aoek+GWpSPc3DbN12V7wfE6/Jo4bjUoT22wzL7M/58eLc1AyCfvJtlYpbkBZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739376334; c=relaxed/simple;
	bh=rx5mvoX4y8oy4sk/zEBipIx4lBSs3LPqJBzxWuPp6RY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQMaJGKjKKo4gHvWPqQkSrRHY9rsNWXKCqpzUmT6P6qOcQ8r7KLFtF1AZ7Rn4ZuIfztVpKtOntlDuCPGK1E+SB7T10lgw3e5oFoGaEmU12nhfGUbDYpmbOb2IioBEOkzZ6zVlqN5nEbPVSHbvS7NaOS8cg7Lf7M9bVzq6Ohv6qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-224.bstnma.fios.verizon.net [173.48.82.224])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 51CG4pER014922
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 11:04:52 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id A276915C018E; Wed, 12 Feb 2025 11:04:51 -0500 (EST)
Date: Wed, 12 Feb 2025 11:04:51 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
        Christian Brauner <brauner@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jeff Layton <jlayton@kernel.org>,
        Adrian Ratiu <adrian.ratiu@collabora.com>,
        xu xin <xu.xin16@zte.com.cn>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Felix Moessbauer <felix.moessbauer@siemens.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc: Use str_yes_no() helper in proc_pid_ksm_stat()
Message-ID: <20250212160451.GB106698@mit.edu>
References: <20250212115954.111652-2-thorsten.blum@linux.dev>
 <20250212120451.GO1977892@ZenIV>
 <220DFA78-0A12-4F46-B778-B331A7F2841A@linux.dev>
 <20250212123609.GP1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212123609.GP1977892@ZenIV>

On Wed, Feb 12, 2025 at 12:36:09PM +0000, Al Viro wrote:
> On Wed, Feb 12, 2025 at 01:11:08PM +0100, Thorsten Blum wrote:
> > /*
> >  * Here provide a series of helpers in the str_$TRUE_$FALSE format (you can
> >  * also expand some helpers as needed), where $TRUE and $FALSE are their
> >  * corresponding literal strings. These helpers can be used in the printing
> >  * and also in other places where constant strings are required. Using these
> >  * helpers offers the following benefits:
> >  *  1) Reducing the hardcoding of strings, which makes the code more elegant
> >  *     through these simple literal-meaning helpers.
> >  *  2) Unifying the output, which prevents the same string from being printed
> >  *     in various forms, such as enable/disable, enabled/disabled, en/dis.
> >  *  3) Deduping by the linker, which results in a smaller binary file.
> >  */
> 
> Printf modifiers would've covered all of that, though...
> 
> The thing is, <expr> ? "yes" : "no" is visually easier to distinguish than
> str_yes_no(<expr>), especially when expression itself is a function call, etc.
> So I'd question elegance, actually...

Yeah, personally I think str_yes_no() is a bit of a toss-up from an
elegance perspective.  It's a fewer number of characters, sure, but
it's a bit more cognitive load where the people reading the code need
to map str_yes_no() to semantic meaning.  For someone who is doing
wholesale conversions, they probably don't notice it, but for someone
who isn't dealing with it every day, it's One More Thing that they
have to track.

Using printf modifiers would probably actually save more bytes from a
"size of the binary" perspective, at the cost of forcing the code
reader to deal with some line-noise perl- or Rust-like construction
(e.g., if %pcy is str_yes_no, %pco is str_on_off, %pct is
str_true_false, etc. is the increased cognitive load worth it?)

Bottom line, I don't *hate* the string choices, but I really don't
think it's an obvious improvement.  Thorsten, this is why I hadn't
processed your ext4 patch yet.  I was super busy over the holidays,
and from a prioritization perspective, I didn't consider it high
priority.  Thinking about it now, to be honest, I'm feeling really
ambivilent about string_choices.h

Cheers,

					- Ted

