Return-Path: <linux-fsdevel+bounces-13892-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE8F87528E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 15:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AAAF28552C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 14:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57F212E1DF;
	Thu,  7 Mar 2024 14:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YafQAxVY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEA112D775
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Mar 2024 14:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709823588; cv=none; b=eRuXVxId2dLroelxROyIIPEqhBwaff4M8kuY8RvUqT945KnhgsNnNEQXWsrSSNdyf6p62LO1fFdTLv0Zhdj9LBL/lGxz47hzL/ZMep1PLqllG1yhTSP6t4zQzjE3Lqd/kCSX7WC7niF6MTPMW0G+oQn6nNWQSG6zWRiRONuegS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709823588; c=relaxed/simple;
	bh=XflE5OQzElkEXfrrrd49ymBt3uZWY+1/xxxHeAFeWeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gN3YnDASk0Wg1iW7VKjvHbECdecY4lkk37DEd9p93i2jIDx7XcL01hDfAuzpmjftagzpM2d2f/bnBS3Ct5/dmRvfOnVmejeKjfD8FJp0vAoh0Oeb7a529cG3vEWk6+x9k/pl0Te85xC6eveqBiAIR+YrvPJrqA52lz3gHVxH7dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YafQAxVY; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wUJp+ma+FxPhkWdylQUE2obPA+/tXu3/YIlPPLbfesY=; b=YafQAxVYfB0YV+X0BAxM2t542D
	jR4HX7yaCzYZaKgTNj9XZrPHOBvR7DEDim42VHob7JwoNgjRPi1ol2IfE49qFV5hs/25lQLGabAqg
	QY6Ee8ggWkcYyDTXC6ysQ2X2/9yMWIb7Oc+Ba1BLxE1WMCdJhhu5i7/5bYPTpArW0/qQ3Qy0vB5QT
	Dw/fWG11uhQ4wAXjkioLqXZfFEyLftQNDWW4MMBE/7qH7m83EqP3LC3OCsp1UpupUZZ5gklUIta7h
	CNBqAdBMKryCEQT3BgW3xcjdif1Xjm26WhctYfPtWIJIaBXbqzTRxj2e3Bvfi9ZVRKmC87hmTwLlr
	Xfk5jj9g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riFDj-00000009MsO-1zsy;
	Thu, 07 Mar 2024 14:59:43 +0000
Date: Thu, 7 Mar 2024 14:59:43 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Mikulas Patocka <mpatocka@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] tmpfs: don't interrupt fallocate with EINTR
Message-ID: <ZenWX_WymceGgtrw@casper.infradead.org>
References: <ef5c3b-fcd0-db5c-8d4-eeae79e62267@redhat.com>
 <20240305-abgas-tierzucht-1c60219b7839@brauner>
 <20240306174911.ixwy2kto33cfjueq@quack3>
 <20240307-kultur-ankam-39d311604493@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307-kultur-ankam-39d311604493@brauner>

On Thu, Mar 07, 2024 at 11:45:59AM +0100, Christian Brauner wrote:
> Right now fallocate() is restartable. You could get EINTR and then
> retry. Changing this to fatal_signal_pending() would mean that this
> property is lost. The task will have to be wiped.

People made much the same argument when I removed the nfs 'intr'
mount option.  It hasn't actually caused any issues that I've seen.

> If this is only done for the sake of the OOM killer then we can probably
> try and change it. But then we'd need to also reflect that on the
> manpage.

It's part of POSIX, I wouldn't remove the manpage.  I think it's a QoI
issue; we should only check for fatal signals.

