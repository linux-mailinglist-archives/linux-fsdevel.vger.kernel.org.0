Return-Path: <linux-fsdevel+bounces-7805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E064882B31D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 17:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E2671F21CE9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 16:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541935025E;
	Thu, 11 Jan 2024 16:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qXSnYYIo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D80950250
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jan 2024 16:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 11 Jan 2024 11:37:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704991031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ybxsMvmrI3V4Ip45Nv9SUAbIu72iHpBLx+E0cWa2rs4=;
	b=qXSnYYIoy4ElNF2N6nkNJssKCrdmXEui1pc6Rmn7zCs/jUlSBlNmz5CHcupAyNnZuFlrMa
	sg+umAojRu83LTF1pp1vZH1ykJ9/LMIWvSBeu7WnH1sow+gD4xLIb6tocrkrl6OIPTpU89
	pmwTdKfvZKG6WxB34g5PMDdUHJGY91Q=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Christoph Hellwig <hch@lst.de>
Cc: bfoster@redhat.com, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] bcachefs: fix incorrect usage of REQ_OP_FLUSH
Message-ID: <e6wpysqepf5nfpvugxutqqohkunjvewomk7lkvk2kd2cwkstg2@g7r3qz46txx7>
References: <20240111073655.2095423-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111073655.2095423-1-hch@lst.de>
X-Migadu-Flow: FLOW_OUT

On Thu, Jan 11, 2024 at 08:36:55AM +0100, Christoph Hellwig wrote:
> REQ_OP_FLUSH is only for internal use in the blk-mq and request based
> drivers. File systems and other block layer consumers must use
> REQ_OP_WRITE | REQ_PREFLUSH as documented in
> Documentation/block/writeback_cache_control.rst.
> 
> While REQ_OP_FLUSH appears to work for blk-mq drivers it does not
> get the proper flush state machine handling, and completely fails
> for any bio based drivers, including all the stacking drivers.  The
> block layer will also get a check in 6.8 to reject this use case
> entirely.
> 
> [Note: completely untested, but as this never got fixed since the
> original bug report in November:
> 
>    https://bugzilla.kernel.org/show_bug.cgi?id=218184
> 
> and the the discussion in December:
> 
>     https://lore.kernel.org/all/20231221053016.72cqcfg46vxwohcj@moria.home.lan/T/
> 
> this seems to be best way to force it]
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Hey Christoph, thanks - applied.

