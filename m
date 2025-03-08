Return-Path: <linux-fsdevel+bounces-43532-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD098A57F23
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Mar 2025 22:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B08DA3ABA5B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Mar 2025 21:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97941EDA00;
	Sat,  8 Mar 2025 21:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vWK9xA8I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F217C2EAE4
	for <linux-fsdevel@vger.kernel.org>; Sat,  8 Mar 2025 21:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741471141; cv=none; b=g/wNqTsPNiJtYZ0t7WKaJM98W++MxiBZXnfguVFQpDo9+Z8cGmDMek/ESd+fjeB50XL6jPFVqgcDmJD3VgkkFi8Tzd/7cQy+dlmSNlBT7zQ3oDLYEiEh4yMcYRmtnlHeNk25o96XFcrgY9CMpAum0B6HVgrQrFBqtp4joycYI5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741471141; c=relaxed/simple;
	bh=p86EgVLWBe8WTppLDti2AJM2Jw1wFafEgiZOs169sE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S7z/A2eJOfLpZeQeMqA+U1T18RhsZIOj0SVlpqbhnpU9rxOsiZmYHgTmPkSTOQhZFO/nSNhGHZ8dUF+0O/0sDz0wIpNmvMXxgu5quNqWCb6Q37hCSfgPbtY+XQX7+/am883egYsJDxkm7UhDh1EBYJpCgi22imae9UAfa8i14ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vWK9xA8I; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 8 Mar 2025 16:58:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741471137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Au7fJ9XgM21AaQJVoKb8P3+31pAT4gKK4Tj3RdgQ0uk=;
	b=vWK9xA8IZX7bBOLGG76yt6cBd9DGDYg4PLo+q/15kzkwmKGxtLHxZyDhmfF1m12pKCcOGV
	zSnbcQ0QtlDDEepRUTQCgqinXfP7PSiJKqPNgwMzmZ106bsiGd+8q9e1kLZGaJi9EgMxfJ
	vRH/svthsoc4nxJWNEWHgkJZ/or+TVU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Hector Martin <marcan@marcan.st>, 
	syzbot <syzbot+4364ec1693041cad20de@syzkaller.appspotmail.com>, broonie@kernel.org, joel.granados@kernel.org, kees@kernel.org, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] general protection fault in proc_sys_compare
Message-ID: <wkn3delpogj7ay7irqjemviubsnvnnd72yaywqr4ibtbfjxfif@efp5mfvixwp5>
References: <67ca5dd0.050a0220.15b4b9.0076.GAE@google.com>
 <239cbc8a-9886-4ebc-865c-762bb807276c@marcan.st>
 <ph6whomevsnlsndjuewjxaxi6ngezbnlmv2hmutlygrdu37k3w@k57yfx76ptih>
 <20250307133126.GA8837@mit.edu>
 <a5avbx7c6pilz4bnp3iv7ivuxtth7udo6ypepemhumsxvuawrw@qa7kec5sxyhp>
 <20250308215305.GB69932@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250308215305.GB69932@mit.edu>
X-Migadu-Flow: FLOW_OUT

On Sat, Mar 08, 2025 at 04:53:05PM -0500, Theodore Ts'o wrote:
> On Fri, Mar 07, 2025 at 09:33:11AM -0500, Kent Overstreet wrote:
> >
> > > Maybe this is something Syzbot could implement?
> > 
> > Wouldn't it be better to have it in 'git bisect'?
> 
> "Git bisect" is the wrong layer of abstraction.  It doesn't know
> anything about (a) how build the software package (which might not be
> the kernel, remember), nor how to run a test, nor how to tell whether
> a test run was successful or a failure.

Eh?

It has a mode for automatic bisections, you just give it a test that
runs pass/fail.

This works with my ktest, which runs tests in a VM and in non
interactive gives you that pass/fail in the exit code - I've used it
that way before.

> > If only we had interns and grad students for this sort of thing :)
> 
> The lightweight test manager (ltm) for gce-xfstests was implemented by
> an intern.  And the kernel compilation service (kcs), git branch
> watcher, and git bisection engine for gce-xfstests was done by a group
> of undergraduates at a unversity in Boston as part of a software
> engineering class project.
> 
> Mentoring interns and undergraduates was incredibly fulfilling, and I
> very much enjoyed the experience.  I'd like to think I helped them to
> become better software engineers.  However, mentoring students takes a
> significant amount of time, and on net, it's not clear it was a win
> from a personal time ROI perspective.
> 
> We did manage to recruit the intern to become a SWE at Google after he
> graduated, so that was definitely considered a win from my company's
> perspective.  :-)

Cool :)

