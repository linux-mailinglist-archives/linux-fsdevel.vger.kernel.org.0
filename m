Return-Path: <linux-fsdevel+bounces-58839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4383FB3203E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 18:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74D511895400
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 16:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436B5238C3A;
	Fri, 22 Aug 2025 16:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Agj5yhd8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5EC242D86
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 16:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755879033; cv=none; b=jykVLRi4qIm+ARpD/xLMQ4oSbsdAQYiUKbmCtL+zFuykS6JN7XSGG2KVBdVI9MwIeMRWpsNCBlNS6P8aVquNA1RKi7vXGzCI+Ok4dxiPcBbdMhAU8pnE3nKelaKlIvpswUBm4QvxWqT4jgPClvl7IzQtzXjmYgWaS+BwZF4UmPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755879033; c=relaxed/simple;
	bh=CFy9qRbdsQ1UILnFsarvyMKHCGH+d4LwaaXk+Ox+dHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iB2H5Mw80o852TxKov7kBHqQ4gHd7shEvI3X3nBHIyQTNRhUm3g28powBlhIkHPXXSUcFjfpfTkqAtRz+wLLrol+MtBqV4K7NehXtqGmIldvlFgwDNlnMpArF/F8FNv89aRARwKdZpTvO6iB+1ZyrsFOzWZL1CSlW+TgaQqsqSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Agj5yhd8; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (pool-173-48-112-142.bstnma.fios.verizon.net [173.48.112.142])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 57MGAJGB020237
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 12:10:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1755879022; bh=zXMZEZbcw0IXXeWvArqy3HEE3YJogsMRE11Bzh6buRY=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=Agj5yhd80SQ264QRMIlYFA0ULIrtOYdOF7PAjMSEcQj4EdD+Z406ioUp2nJQ2lpDx
	 WWchoEQiuiyzRTGe4AbRg7pMWx4zpBO/ErG3YiLBspe8bYLRBhRpjZXO6Tpg0jSung
	 w3FFb5S6Ixf67SpwatdSmY0bSTBMRRTTLL06v1K0+gaNvWPzQKBfHr52S8UWA/cx2F
	 U43PsW57QtPuqU19D4fVTFkjTgslLBEp4fgy55LqMtZJFkrfgrp7ByIYl2g1+TmHBd
	 77ynXZGTgj6J+EAGpUI80RJz1m2zdK5UOhwH1zxd9WooC7w/ngBIy+YD+r/t/PanZg
	 BhG0bG9/S2log==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id BAA203FE341F; Fri, 22 Aug 2025 12:09:18 -0400 (EDT)
Date: Fri, 22 Aug 2025 12:09:18 -0400
From: "Theodore Tso" <tytso@mit.edu>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Greg KH <greg@kroah.com>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Subject: Re: [MAINTAINER SUMMIT] Adding more formality around feature
 inclusion and ejection
Message-ID: <20250822160918.GA49788@macsyma.lan>
References: <fc0994de40776609928e8e438355a24a54f1ad10.camel@HansenPartnership.com>
 <20250821203407.GA1284215@mit.edu>
 <940ac5ad8a6b1daa239d748e8f77479a140b050d.camel@HansenPartnership.com>
 <2025082202-lankiness-talisman-3803@gregkh>
 <20250822122424.GA34412@macsyma.lan>
 <62aea685546cee80b18cfd7e1ea50b1a590d5edd.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62aea685546cee80b18cfd7e1ea50b1a590d5edd.camel@HansenPartnership.com>

On Fri, Aug 22, 2025 at 04:31:49PM +0100, James Bottomley wrote:
> 
> When did this become about how our current maintainer pull system
> works?  I'm certainly not advocating changing it.

  ...

> Well I did ask for two concrete things, but I can certainly repeat:
> 
> On Fri, 2025-08-22 at 09:09 +0100, James Bottomley wrote:
> >  I think I'd be happy if we sort out two things
> > 
> >    1. That the decision be taken by more than one person rather than
> >       abdicating to last man standing

Well, if we keep the current maintainer pull system, then the natural
consequence is that it *is* up to the higher-level maintainer to make
the decision.  In the case where we don't have maintainer teams, then
it will be a single person.

So I don't know how to square your request with your assertion that
you don't want to advocate changing how our current maintainer
hierarchy works.  Could you clarify your thinking here?

Thanks,

							- Ted

