Return-Path: <linux-fsdevel+bounces-41048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3821EA2A515
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 10:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A720188954A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 09:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BB9226539;
	Thu,  6 Feb 2025 09:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZG5ehmq4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823EA215778;
	Thu,  6 Feb 2025 09:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738835347; cv=none; b=vF0llld94bAlbhpTEXEp0FiKETCWMtY5Zbya4Q7Ox/EEmZ+gAg5gkX81KU+VQTwDutUeVYHvbUsNeWCltS9DJTILfaS0UEGBBia5MQCF4MedCGH/QTWQUViap9lMY29hDAV1L+xJozjDNaVc3XeVJjliji5/eEkCpD0tcbDpSbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738835347; c=relaxed/simple;
	bh=VjgJG7HJO75EfEty4D/K3zMWxBje59/FhlZFefM2alU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNI01QHIrBfxpdLMQ7EMHz8pNiaanYCmG3FW6XYJ3lxC6gjXIr8WhT0RMh+Vh8Is+92nWkK1BT0htShkRkKu3weQQWAC54WUt2x9oEpzlOI9h/GUj2/hR1i0nAHcR4yTFfkBKUzE4IMyN6FzwtVParniMwCpNvUCGegow1677Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZG5ehmq4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94CF8C4CEDD;
	Thu,  6 Feb 2025 09:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738835346;
	bh=VjgJG7HJO75EfEty4D/K3zMWxBje59/FhlZFefM2alU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZG5ehmq4UYy1mNP0SdCXcmL9wsRj9oyyg2bctkHJ6n4I4JsxbFfQbc1uvp3nA5AS5
	 Oj0FO3ueUGu7pSaTZw0ThblA8dlPye83QCtEkYR3YP1xTtCkmcjcrMg+I/fevKq/kw
	 3/X5agh9j2A5gxMqYb01RmZ3thuSF+1N2SvfW3DBB8lWfEGKGqukeYHPIyu3Hx+sm2
	 WNZ/XevBo8AoWB6oloY7jpJ+K3LCsDX+no8xxRldOxw+LT5XB3ytbXWpgHlt08CKkq
	 vU+fUwnHz4DFrDwbk7rgpFx2x0JxOC1hhZ1RoZ60K82fquEGnB/pfQQGjvJHKUtqIf
	 1gX/A3Hb2G0pA==
Date: Thu, 6 Feb 2025 10:49:00 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Jeff Layton <jlayton@kernel.org>, David Howells <dhowells@redhat.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Mateusz Guzik <mjguzik@gmail.com>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, 
	Oliver Sang <oliver.sang@intel.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, 
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] pipe: introduce struct file_operations
 pipeanon_fops
Message-ID: <20250206-gravierend-ungeduldig-d3af18bb6703@brauner>
References: <20250205153302.GA2216@redhat.com>
 <20250205153329.GA2255@redhat.com>
 <CAHk-=wiqUibNm0W-KcCb3H+aiSVr4Uz3COZq=LjqGd__6guFEg@mail.gmail.com>
 <20250205161636.GA1001@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250205161636.GA1001@redhat.com>

On Wed, Feb 05, 2025 at 05:16:37PM +0100, Oleg Nesterov wrote:
> On 02/05, Linus Torvalds wrote:
> >
> > On Wed, 5 Feb 2025 at 07:34, Oleg Nesterov <oleg@redhat.com> wrote:
> > >
> > > So that fifos and anonymous pipes could have different f_op methods.
> > > Preparation to simplify the next patch.
> >
> > Looks good, except:
> >
> > > +++ b/fs/internal.h
> > >  extern const struct file_operations pipefifo_fops;
> > > +extern const struct file_operations pipeanon_fops;
> >
> > I think this should just be 'static' to inside fs/pipe.c, no?
> 
> I swear, this is what I did initially ;)
> 
> But then for some reason I thought someone would ask me to export
> pipeanon_fops along with pipefifo_fops for consistency.
> 
> OK, I will wait for other reviews and send V3.

It's fine. Minor things like this I can just fix myself when pulling
this. There's no need to generate more mail traffic for this.

