Return-Path: <linux-fsdevel+bounces-66621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C54E5C26A56
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 19:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EA88188C152
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 18:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBD028643D;
	Fri, 31 Oct 2025 18:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="uMDj1qws"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B681A8F97;
	Fri, 31 Oct 2025 18:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761936509; cv=none; b=XTTbfsL96nHrxFKtOl2ODV+a0rrdeVnCxrgw/Q3QN6yHSKno/fLxjGFsPVDjLXSvU9mIS8OQIbre7eahFiselzqMbt44DiV94jhEXTdPCgsVGU/tvSo/N30iY1yEYqaAX1qgWr0cUqxEsAxEh7xwxGXR+WCunIP1uEz+F5/mz2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761936509; c=relaxed/simple;
	bh=NSw/zDktj2wbaxR6bwDrkLPC58C25a1g21UrPPWTd+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M8ZKMBo2nKgP9URNrmSTpAwzJy2cTqKU/9sQb4urW8PiV3lpA8rBqV55AslG1MNUXl9ExCo9aRedaD8VjQb/+de3R9im3WFv7O7NoTaOGVsfjQt9gDTYceMkkBC5a9zb9RDFKBnGusfwRaaCeRp88H0JNeAjHTV7294+Q1Si4fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=uMDj1qws; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=/CaTZRmDMSXRd7oTRFhVkdej8yA5OkfPlk4FGH0eihI=; b=uMDj1qws6oHfsGOgRXigSXeBfk
	vu/4luu4ZfSi/l9hN8o5K6JCJdxpI90VjmOmW0eCk8pKX+eFeKi7UcEZZINrfis+maPAWp1wGsTFe
	K8fZAjjha2+SPSN4EkePt/uGYv2atDz7gt1bfqfoYAWWyqLxNQTZCryySJr9zn7oiMlN86zokEaQu
	DUXo/9bOxCbjhqHuGZ4EZa+JakHHwm1yzJguTFCeY/6hcwAO2KGrbDaJ95mI1N3FFOz3YfhsNqu/J
	N02DxHj082C8PRRrhJqhjikaVsBPMmMUU755JLhNWeT65y0msoyV4haKigzCM+xtq9rnadKDQDpCk
	n+ryjPgA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEuAg-00000009sUN-3w6r;
	Fri, 31 Oct 2025 18:48:23 +0000
Date: Fri, 31 Oct 2025 18:48:22 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: GuangFei Luo <luogf2025@163.com>, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mount: fix duplicate mounts using the new mount API
Message-ID: <20251031184822.GC2441659@ZenIV>
References: <20251025024934.1350492-1-luogf2025@163.com>
 <20251025033601.GJ2441659@ZenIV>
 <788d8763-0c2c-458a-9b0b-a5634e50c029@163.com>
 <20251031-gerufen-rotkohl-7d86b0c3dfe2@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251031-gerufen-rotkohl-7d86b0c3dfe2@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Oct 31, 2025 at 01:54:27PM +0100, Christian Brauner wrote:

> > > I agree that it's a regression in mount(8) conversion to new API, but this
> > > is not a fix.
> > Thanks for the review. Perhaps fixing this in |move_mount| isn't the best
> > approach, and I don’t have a good solution yet.
> 
> Sorry, no. This restriction never made any sense in the old mount api
> and it certainly has no place in the new mount api. And it has been
> _years_ since the new mount api was released. Any fix is likely to break
> someone else that's already relying on that working.

Not quite...  I agree that it makes little sense to do that on syscall level,
but conversion of mount(8) to new API is a different story - that's more recent
than the introduction of new API itself and it does create a regression on
the userland side.

IIRC, the original rationale had been "what if somebody keeps clicking on
something in some kind of filemangler inturdface and gets a pile of overmounts
there?", but however weak that might be, it is an established behaviour of
mount(2), with userland callers of mount(2) expecting that semantics.

Blind conversion to new API has changed userland behaviour.  I would argue
that it's a problem on the userland side, and the only question kernel-side
is whether there is something we could provide to simplify the life of those
who do such userland conversions.  A move_mount(2) flag, perhaps, defaulting
to what we have move_mount(2) do now?

