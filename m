Return-Path: <linux-fsdevel+bounces-30158-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE83E98728B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 13:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93A7DB2D6EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 11:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498821AFB0A;
	Thu, 26 Sep 2024 11:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="hbhzby4Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5C81AF4D8;
	Thu, 26 Sep 2024 11:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727348970; cv=pass; b=acAg5KuYy/XoSxlSFOPqVDiXDsPOtc6hd23zMjSf3kMg897vajWiih1C1ZRFTVbOgtBASqXjXZxGTN+GZRxmPM5Wbk1HD1td/A8h3QNtVtGcx9gwDaSou+/ASO81yv0ibJ5s+H3RyIBOwM+8A1qKmf095YRsL9G+6/ZyloYwwqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727348970; c=relaxed/simple;
	bh=T1OCpA4iZm4u50GcD7BSAchFUYS0PjSXl0dfsYmFnE0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AvMk0uqDbwcdjYpjuZEcZvMioNYb3bqnJj/Wj2Y4JfXI8NABbbOz3W4HnuGcrxxmbnmriwmRGUgU1+uZeENKkDYq+yUQx/YoLwwCvXuURcdLZ/9hJY5hjGUeoW9Aj/r//EqhNhow12TP+VDYVJ06UyVP4Rfqj0WcuquCrBRARpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=hbhzby4Q; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1727348898; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JftiJ+kfhrPTjDL6sW/l4oFxYIOI87ItdjqAO/0rXBqlO22A/T8UDmice+ArvvSySHqS7yUO1t0HW3vcJq+RBoPuLh3Zcs+FJhNVVZfTh2evdHdj+OwhzOe4Ua8Bth0KshwLOave0uvvyKrOH216soxh98ccekTpnH/GHLp2elc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1727348898; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=JrLldkqoPq2lsMOGw47yIyVjJ4SBU4HXusXF9HRcH38=; 
	b=D1zo3pxIOylMlxGoEF+ikaTNXBczl6cgfjVq1raLAgrTbZ720aeeTdoOyU54ZZg5+aENhkpKzsU7Si0zKdPMpTsmaqQraUQDyhJY9405SF7E+qAPkL5lSpKT/v5BvIMKUSUXMzdca62SeIBH1c7hdfOshr1gPu6zh/DkFNYntcI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1727348898;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=JrLldkqoPq2lsMOGw47yIyVjJ4SBU4HXusXF9HRcH38=;
	b=hbhzby4Q0+wmGZCDnWnVbjGHuObOBXwD5vIr/vqWRLLwz/aYuEX6+MBXc7TGy030
	itYIjVbHxjSnC7o/gPWNQUG7TOwI4gfaAdM+zvP5Ae/5F2U9y2cGE8qALQ3X9vkQAMP
	b/2O4g3zuCs+mNqYjA3US+WqdXATOCe+U7nFnhFk=
Received: by mx.zohomail.com with SMTPS id 1727348896138291.23618690406806;
	Thu, 26 Sep 2024 04:08:16 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, Doug Anderson
 <dianders@chromium.org>, Jeff Xu <jeffxu@google.com>, Jann Horn
 <jannh@google.com>, Kees Cook <kees@kernel.org>, Ard Biesheuvel
 <ardb@kernel.org>, Christian Brauner <brauner@kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, corbet@lwn.net, paul@paul-moore.com,
 jmorris@namei.org, serge@hallyn.com, thuth@redhat.com, bp@alien8.de,
 tglx@linutronix.de, jpoimboe@kernel.org, paulmck@kernel.org,
 tony@atomide.com, xiongwei.song@windriver.com, akpm@linux-foundation.org,
 oleg@redhat.com, casey@schaufler-ca.com, viro@zeniv.linux.org.uk,
 linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-security-module@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH AUTOSEL 6.6 048/139] proc: add config & param to block
 forcing mem writes
In-Reply-To: <e22f3662-c985-4409-99f3-5168fa2a4b9f@p183>
References: <20240925121137.1307574-1-sashal@kernel.org>
 <20240925121137.1307574-48-sashal@kernel.org>
 <e22f3662-c985-4409-99f3-5168fa2a4b9f@p183>
Date: Thu, 26 Sep 2024 14:07:59 +0300
Message-ID: <871q16ad0w.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-ZohoMailClient: External

On Wed, 25 Sep 2024, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> On Wed, Sep 25, 2024 at 08:07:48AM -0400, Sasha Levin wrote: 
>> From: Adrian Ratiu <adrian.ratiu@collabora.com>  [ Upstream 
>> commit 41e8149c8892ed1962bd15350b3c3e6e90cba7f4 ]  This adds a 
>> Kconfig option and boot param to allow removing the FOLL_FORCE 
>> flag from /proc/pid/mem write calls because it can be abused. 
> 
> And this is not a mount option why? 

Hello and thanks for asking!

The only reason is nobody asked for it yet. :)

We need to be careful how we do this, so the restriction is still 
enabled when remounting, otherwise I don't see any impediment, 
provided we can find a way to make it clean and safe.
 
I am travelling these weeks (All Systems GO conf) and have a lot 
going on, so please feel free to send a patch and I'll review it 
ASAP, otherwise I'll try to come up with something by end of 
October.

Adrian

