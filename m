Return-Path: <linux-fsdevel+bounces-27805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8333F9642F1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 13:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A3171C227B8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 11:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7412C1917F3;
	Thu, 29 Aug 2024 11:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pqDh+9ax"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE6D19006B
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 11:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724930813; cv=none; b=goLilImbZ9FgU/cPuxCOJra+e4qxFRweGhWFUrFcr+R5pEtUhBqxJ6HqQM7lY8Hz5f6Xg6kzie298SWISOEQhmu+MTzDquevbvzquZl+VFq45PdDcMWTEGT13b7J72lRmayf82NBVCYkPNA5cLrWyb/A59UYmSuyvHBiUvG8TTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724930813; c=relaxed/simple;
	bh=Y+B5km99YPVm29mtxzC/gh4SydowuGm+EA1JK8Z3kW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXCKoFFJFrzm8nJTqWvGCiyVTdgNVj8ZMwUxEEcAl/vWmACxKIQvjSH0ECNGa6vhnNyS8wMwVnOfRSGyQZaI3E0h2weD0GAglrxhA/msreQ8UcRUJ0vB75Z7SYYElgiunayHYvoOUkUrMd718hZfewoVDRUAyfL067P0lzsZRc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pqDh+9ax; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 29 Aug 2024 07:26:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724930809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MAsc263Wcw45dgdq27pEPB5wCPxiVZqJ/sXfhtkn/JY=;
	b=pqDh+9axWna7Fo3dWS+XmOMowCMJDZnOyWnD9kGLFfZgQfEbeA0KrHh/ctrxOrcQVwU+ra
	RescOXF98Ykom8q34kMaih+lGV/mSSX9YFDiHUtTKh1LvT8jsq+4cdSgVG+Trx2+/q83fO
	MyBK4pF/ow/uUEa5sOu5DpWR4K5lvaM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, 
	linux-fsdevel@vger.kernel.org, amir73il@gmail.com, brauner@kernel.org, 
	linux-xfs@vger.kernel.org, gfs2@lists.linux.dev, linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH v4 14/16] bcachefs: add pre-content fsnotify hook to fault
Message-ID: <zzlv7xb76hkojmilxsvrsrhsh7yzglvrwofxcavjo4nluhjbdu@cl2c4iscmfg2>
References: <cover.1723670362.git.josef@toxicpanda.com>
 <9627e80117638745c2f4341eb8ac94f63ea9acee.1723670362.git.josef@toxicpanda.com>
 <20240829111055.hyc4eke7a5e26z7r@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829111055.hyc4eke7a5e26z7r@quack3>
X-Migadu-Flow: FLOW_OUT

On Thu, Aug 29, 2024 at 01:10:55PM GMT, Jan Kara wrote:
> On Wed 14-08-24 17:25:32, Josef Bacik wrote:
> > bcachefs has its own locking around filemap_fault, so we have to make
> > sure we do the fsnotify hook before the locking.  Add the check to emit
> > the event before the locking and return VM_FAULT_RETRY to retrigger the
> > fault once the event has been emitted.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> Looks good to me. Would be nice to get ack from bcachefs guys. Kent?

I said I wanted the bcachefs side tested, and offered Josef CI access
for that - still waiting to hear from him.

