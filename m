Return-Path: <linux-fsdevel+bounces-16366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AD689C6A1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 16:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA83D1C21C1C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 14:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5491185939;
	Mon,  8 Apr 2024 14:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="HONY+oDM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26CC8592A
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Apr 2024 14:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712585732; cv=none; b=WA9Lqk74enA32v+z3V1M85KkI/01KZ8JVf1Cy9AbS55X/mKZCjKQUlraA93NVPi/jHd+pvRkNpszY4c0AQzDB5dQZ5gdT1TnhkC6FRsN2lKgayzsC74ZpEXbCz4J26ldCGDcv7YArGlGoLMwUi2ZRu4k7DTOGYr/B9Bui4mgFUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712585732; c=relaxed/simple;
	bh=ADXGdxvg0oF2vsB4ZJmUWTJLOw3fUL4w2dLJjuMosuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OAmIuxrqH1V6bigR0Xv4NAr8TA9y0DBm3EDz4TJ9S1adf7FK6ku/no+gEjTEk9eeSMJRyRjKPA3n3OazIAITlLL4iaPKA3ZNgzqxNBh3iGCsMFfc5BhComiUTwSYwdqayHh5GiFnQVROaJD6Y83MpyMpT38B3EYv7dMi2B7NWak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=HONY+oDM; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-60.bstnma.fios.verizon.net [173.48.113.60])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 438EF4R2003092
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Apr 2024 10:15:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1712585708; bh=n0L8jGEaqMSQqP+8wLzWG2tUuPOgaNvlPqaKBr3gcaw=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=HONY+oDMme0xbipSpJQ9y6Zcs+cGoT2efYjF5GSz+f9r9zonEBR/TXBB33Oc28N7D
	 46zViJ67l/Tat+YWjPGGFGlrfI/qs17C27WZwqNgV0+nkXV6Qad/dO/Pdm4hioqgRa
	 TAQSuduWKkfqr0kuKvNx3e//KwD+MaaAX6eafLSJNDxgWJ7nFNNXNn/emjlyy15dV/
	 1JeipL9SB9JyMaTdL0dtvL20Jt94cT6jHcvlnh3szeeE7oUVSB5ZtU8JFgpdDPXM0S
	 47xa2lCmCltO/sIBUEEDtBmxvAQd+43Q4DI7dc81LvP+AUsGAG4/nzqJf5BILnevAY
	 BhUEZu3oqGAjA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 127E715C00DE; Mon,  8 Apr 2024 10:15:04 -0400 (EDT)
Date: Mon, 8 Apr 2024 10:15:04 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Matthew Wilcox <willy@infradead.org>
Cc: HAN Yuwei <hrx@bupt.moe>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: Questions about Unicode Normalization Form
Message-ID: <20240408141504.GA122316@mit.edu>
References: <AD5CD726D505B53F+46f1c811-ae13-4811-8b56-62d88dd1674a@bupt.moe>
 <ccfe804c63cbc975b567aa79fb37002d50196215.camel@HansenPartnership.com>
 <D445FB6AD28AA2B6+fe6a70b0-56bf-4283-ab4d-8c12fb5d377f@bupt.moe>
 <20240408013928.GG13376@mit.edu>
 <ZhNk78RE2Bocs9ap@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhNk78RE2Bocs9ap@casper.infradead.org>

On Mon, Apr 08, 2024 at 04:30:55AM +0100, Matthew Wilcox wrote:
> As I understand it, an important usecase for the casefold feature is
> running Windows games under WINE.  I don't do this myself (sgt-puzzles
> is more my speed), but there's a pretty important market for this.
> Wasn't this why Gabriel was funded to work on it (eg commit b886ee3e778e)?
> Or was that the Android usecase?

Good point.  Your history is correct; the other use case, which Gabriel
was funded to do the work for, was for Steam for Linux, which uses a
fork of Wine called Stream Play.

The other potential use case for casefold is that it would accelarate
Samba servers, which will first try to do a lookup on the filename but
if it gets ENOENT, has to do an O(1) readdir search to see if there is
a case insensitive match to the given lookup.  I haven't heard of
anyone who has actually configured their CIFS server to do this, but
it should work.

						- Ted

