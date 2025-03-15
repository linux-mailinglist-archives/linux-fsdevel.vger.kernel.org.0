Return-Path: <linux-fsdevel+bounces-44122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE5AA62DF7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Mar 2025 15:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7265F7AA4B7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Mar 2025 14:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01104202C40;
	Sat, 15 Mar 2025 14:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="bcpqGaRY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5BF1C84C6;
	Sat, 15 Mar 2025 14:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742048023; cv=none; b=jGwPpEbYILMoCXMxMr+L8HicCaGh1AXGEtqzq+23OOYbW5jiFWgG7ZEuAYvt8SqNcM7J2VaOHJ2m/PyZf4ioyn0j30MkxeRJ67aTiWy9oUrIAHz6VAKp6+OvtL9ZiATCZllQN60ysUx32oisTd6yzHRdKoHe8W83wix14SBx/78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742048023; c=relaxed/simple;
	bh=WhAi2P/xoWb2QFlpwuGYAcV6+FUtBWOiikfVFGic3K8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tRmADC4UoAbcLdE9tjfBHxgFYV+N/DmJrFTv+dioxVaQLFZmyIb08Qq9qeRSiwVKIr9Mvsj/e77oxwxA7V/ubRY8rs4tcF/YwY/oDywZ+Fm/jxWrb/kvtMV+54v+KOX9GCTtl9STZ+0xzYKHZR0Ap2DBxeJF/A84EFy4qeLIgy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=bcpqGaRY; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4ZFNWQ0mf1z9tYL;
	Sat, 15 Mar 2025 15:13:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1742048018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OKB3Ev3QrQKX8dFU3lgB02L412RpyryG6yr1b6IQWSY=;
	b=bcpqGaRY5MyGzItZbHkHYqt19U5I7aOYL0tfy0iUcP27ouF5kJ+lEvWcB7Gj+zKtFxCQXM
	elJGy8gpq8C7T1fsiHZ9i8wfkgB+FVIbOwPY4o8qDA3ArM4DG10AzI0lxMBun55NX1UoZJ
	PrvUUDZZnwkxBUuEGqxJLEiWGnNa/jMw1sJWibyIvU5wAooUYIQzvSq5EAoWgkMYWwQ89s
	KkxhsY/CbCzIsfgkp/Tc80cjyY3oOzwBA+ycpDGsHvDldt7l9Yd1sGxmw4HhNdR4Lkpu3I
	8GRb13LRKHLK+Bp+k7/WS5CytG53UCt/hiY/G7zDO6miNfTVSbztcRjuSdb1xg==
Date: Sat, 15 Mar 2025 10:13:34 -0400
From: Ethan Carter Edwards <ethan@ethancedwards.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, tytso@mit.edu, 
	ernesto.mnd.fernandez@gmail.com, dan.carpenter@linaro.org, sven@svenpeter.dev, 
	ernesto@corellium.com, gargaditya08@live.com, willy@infradead.org, 
	asahi@lists.linux.dev, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-staging@lists.linux.dev
Subject: Re: [RFC PATCH 0/8] staging: apfs: init APFS module
Message-ID: <krww5lm4ot3qqgaxojipb5zyhrgtgjftvt4khdhcnsofmh2574@vyhzmrxf6vdk>
References: <20250314-apfs-v1-0-ddfaa6836b5c@ethancedwards.com>
 <2025031529-greedless-jingle-1f3b@gregkh>
 <20250315-gruft-evidenz-d2054ba2f684@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250315-gruft-evidenz-d2054ba2f684@brauner>

On 25/03/15 10:18AM, Christian Brauner wrote:
> > But I'll wait for an ACK from the filesystem developers before doing it
> > as having filesystem code in drivers/staging/ feels odd, and they kind
> > of need to know what's going on here for when they change api stuff.
> 
> Sorry, I don't want new filesystems going through the generic staging
> tree. Next week during LSFMM we can discuss a filesystem specific
> staging tree that is directly maintained as part of fs so it's tightly
> integrated. We're going to talk about two new filesystems anyway.

No problem! I understand. I just wanted to get the ball rolling and
start the conversation about this process. I am eager to hear back.

Thanks,
Ethan

> 
> Thanks!
> Christian

