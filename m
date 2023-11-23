Return-Path: <linux-fsdevel+bounces-3547-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0773A7F636D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 16:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75EE0B21373
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 15:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2951F3E473;
	Thu, 23 Nov 2023 15:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="XuFA093o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F0010C4;
	Thu, 23 Nov 2023 07:57:26 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id CB541FF80E;
	Thu, 23 Nov 2023 15:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
	t=1700755045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AF/KeTYKhpfCXHeZPKV/bfK4ZedFWe4v+4JbDSSxA/I=;
	b=XuFA093obwvK280z2xdg/19K6D/WCU59rHBphQqXJKjTAerzfphmIVx2tgwSaX1foGUnUm
	IMBNRrJmqIWb/SHxkiiFDzdUI2OrpBu7wqbrFYcJHVDO4QE2+VNyKDH1H9BvGP92WknY52
	QcZnKu7liRTfyqh602spjR3aTmutaA88Wy1dzP8pe8B1GTgqXqN3Cbc8K6jZcOW9aQ0Lsk
	vZ/IXL2cVYJ4IiB3pdRoQLySmvbb2pyqXG24xOMNRQigPoLJk4lcgtTTRpF2julehI8Epv
	CkezQN76OWICUNRDvmrG3fWh0/ZWpOgMHPlX93cSWBdem9Nq9Fsetqxm88LI2Q==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,  Christian Brauner
 <brauner@kernel.org>,  tytso@mit.edu,
  linux-f2fs-devel@lists.sourceforge.net,  ebiggers@kernel.org,
  linux-fsdevel@vger.kernel.org,  jaegeuk@kernel.org,
  linux-ext4@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH v6 0/9] Support negative dentries on
 case-insensitive ext4 and f2fs
In-Reply-To: <CAHk-=wh5WYPN7BLSUjUr_VBsPTxHOcMHo1gOH2P4+5NuXAsCKA@mail.gmail.com>
	(Linus Torvalds's message of "Wed, 22 Nov 2023 16:18:56 -0800")
Organization: SUSE
References: <20230816050803.15660-1-krisman@suse.de>
	<20231025-selektiert-leibarzt-5d0070d85d93@brauner>
	<655a9634.630a0220.d50d7.5063SMTPIN_ADDED_BROKEN@mx.google.com>
	<20231120-nihilismus-verehren-f2b932b799e0@brauner>
	<CAHk-=whTCWwfmSzv3uVLN286_WZ6coN-GNw=4DWja7NZzp5ytg@mail.gmail.com>
	<20231121022734.GC38156@ZenIV> <20231122211901.GJ38156@ZenIV>
	<CAHk-=wh5WYPN7BLSUjUr_VBsPTxHOcMHo1gOH2P4+5NuXAsCKA@mail.gmail.com>
Date: Thu, 23 Nov 2023 10:57:22 -0500
Message-ID: <87o7fkihst.fsf@>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gabriel@krisman.be

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Side note: Gabriel, as things are now, instead of that
>
>         if (!d_is_casefolded_name(dentry))
>                 return 0;
>
> in generic_ci_d_revalidate(), I would suggest that any time a
> directory is turned into a case-folded one, you'd just walk all the
> dentries for that directory and invalidate negative ones at that
> point. Or was there some reason I missed that made it a good idea to
> do it at run-time after-the-fact?
>

The problem I found with that approach, which I originally tried, was
preventing concurrent lookups from racing with the invalidation and
creating more 'case-sensitive' negative dentries.  Did I miss a way to
synchronize with concurrent lookups of the children of the dentry?  We
can trivially ensure the dentry doesn't have positive children by
holding the parent lock, but that doesn't protect from concurrent
lookups creating negative dentries, as far as I understand.

-- 
Gabriel Krisman Bertazi

