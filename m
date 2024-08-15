Return-Path: <linux-fsdevel+bounces-26020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B9295285A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 05:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BCA01C2228F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 03:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFAB374C4;
	Thu, 15 Aug 2024 03:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="JrcDMDtk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08184320E;
	Thu, 15 Aug 2024 03:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723693526; cv=none; b=R2YZGcz1W0xp69mvleTtj5c7jWdrwe8hCUnXUqryIGmTAdI5WzYla8yIZy7l5b9oMxi2lCXiqZUPF1rCzlTtYgg/fG8k6C8Ymi47j3YUYo7BtxMA9+u8iv6sKs+DKBqaVu+DNSkDs+TyDcjSVuDwA/HoiCFBfOZ3mrwPGaYpVJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723693526; c=relaxed/simple;
	bh=BG/NLdZ0yP6u1hJ8ThtQeQ0AvAlu1PpiSeRyRhWpmAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MCmrNHd6cq0GENgeV3QdZazWZ8ymfboww1YNVNKIXRmVH2iTq4x2z+tu5+u9KhRpJ8ANrRrXk5t5Uteb4iefc/YD36dZ4aGJuSW2JSsG7/EKKx/iV2WluJ4XLzBKe5kHOWPzTPLN/O0NaNxhVnz24bx+aVKMuZumSIw+kzR9xwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=JrcDMDtk; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BG/NLdZ0yP6u1hJ8ThtQeQ0AvAlu1PpiSeRyRhWpmAQ=; b=JrcDMDtkNJ0p6Hp9xFRPRpo5+F
	euJNWs0yClvj9y8F+r8nZtYgstLie467YJyhfJ9jVahkE+EU8MC2kHuhnIwdg/iu35EUegeK6dJS3
	Ake3tHzaUC6BnJueZFhGuH1SCiEcUbxPRnYNAI4X3iPTFj+81FGOgy+m5+Z8JRrkJHvbMcEp1nqBO
	1um8iuc8Vg7iqvYDsFv7ktsJOZTi94xhsacCg0/SFhXPJgiHqgLelUXarWsk4Yi3LYkHwqBYXq21/
	QY0PS3GgRmRzHAnzsRcYzXyYCwIOMJPsk5IU/v3G3MFRBBDo7KSTw8swF13o2v3LwObs86DZ3fbH5
	XkHJ/Agw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1seRQM-00000001o1v-07tW;
	Thu, 15 Aug 2024 03:45:18 +0000
Date: Thu, 15 Aug 2024 04:45:17 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: "Ma, Yu" <yu.ma@intel.com>
Cc: brauner@kernel.org, jack@suse.cz, mjguzik@gmail.com,
	edumazet@google.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, pan.deng@intel.com,
	tianyou.li@intel.com, tim.c.chen@intel.com,
	tim.c.chen@linux.intel.com
Subject: Re: [PATCH v5 1/3] fs/file.c: remove sanity_check and add
 likely/unlikely in alloc_fd()
Message-ID: <20240815034517.GV13701@ZenIV>
References: <20240614163416.728752-1-yu.ma@intel.com>
 <20240717145018.3972922-1-yu.ma@intel.com>
 <20240717145018.3972922-2-yu.ma@intel.com>
 <20240814213835.GU13701@ZenIV>
 <d5c8edc6-68fc-44fd-90c6-5deb7c027566@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5c8edc6-68fc-44fd-90c6-5deb7c027566@intel.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Aug 15, 2024 at 10:49:40AM +0800, Ma, Yu wrote:

> Yes, thanks Al, fully agree with you. The if (error) could be removed here
> as the above unlikely would make sure no 0 return here. Should I submit
> another version of patch set to update it, or you may help to update it
> directly during merge? I'm not very familiar with the rules, please let me
> know if I'd update and I'll take action soon. Thanks again for your careful
> check here.

See the current work.fdtable...

