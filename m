Return-Path: <linux-fsdevel+bounces-29842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A62097EB4E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 14:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51E541F21C8E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 12:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F521198A31;
	Mon, 23 Sep 2024 12:07:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBE9433D6;
	Mon, 23 Sep 2024 12:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727093242; cv=none; b=NUSF/BqKMX4+8183ye7H+av6+WkSl/I57dYdrcY6EImHh9vqF/agxzXVaqzgNflbefftf6VKvXWwlVUTzNmZ+nIYh+s3Dpl2NMvn5kPNNv786F11YkF/D/QeHs/EzLaPIiDDU0iOsVTd1lg+ajhhYl7Mah41NAq06W3lIvVixxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727093242; c=relaxed/simple;
	bh=JUPknFSBZHM4Zd+Mg+lJ0b9E0WgLwSiwYFLhdIjEimc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0u9Si176PRH/b6E/Gndy6NGkiJNP0wsZbYbIhgG3dM4YUmbpLzcLkfLH0PpMRiopCiQqKxQxaVdhMtpij4hPrLB6lI58AfNzyBcKXjId+JqC90YvrVP/W94EAe+53l4CGGM4uwLrbp9c542cJ4n8RyON2081COXwNtys2q4bbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id DF02B68AFE; Mon, 23 Sep 2024 14:07:15 +0200 (CEST)
Date: Mon, 23 Sep 2024 14:07:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Dave Chinner <david@fromorbit.com>,
	Ritesh Harjani <ritesh.list@gmail.com>, chandan.babu@oracle.com,
	djwong@kernel.org, dchinner@redhat.com, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	catherine.hoang@oracle.com, martin.petersen@oracle.com
Subject: Re: [PATCH v4 00/14] forcealign for xfs
Message-ID: <20240923120715.GA13585@lst.de>
References: <877cbq3g9i.fsf@gmail.com> <ZtlQt/7VHbOtQ+gY@dread.disaster.area> <8734m7henr.fsf@gmail.com> <ZufYRolfyUqEOS1c@dread.disaster.area> <c8a9dba5-7d02-4aa2-a01f-dd7f53b24938@oracle.com> <Zun+yci6CeiuNS2o@dread.disaster.area> <8e13fa74-f8f7-49d3-b640-0daf50da5acb@oracle.com> <ZvDZHC1NJWlOR6Uf@dread.disaster.area> <20240923033305.GA30200@lst.de> <cfdbb625-90b8-45d1-838b-bf5b670f49f1@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfdbb625-90b8-45d1-838b-bf5b670f49f1@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Sep 23, 2024 at 09:16:22AM +0100, John Garry wrote:
> Outside the block allocator changes, most changes for forcealign are just 
> refactoring the RT big alloc unit checks. So - as you have said previously 
> - this so-called madness is already there. How can the sanity be improved?

As a first step by not making it worse, and that not only means not
spreading the rtextent stuff further, but more importantly not introducing
additional complexities by requiring to be able to write over the
written/unwritten boundaries created by either rtextentsize > 1 or
the forcealign stuff if you actually want atomic writes.

> To me, yes, there are so many "if (RT)" checks and special cases in the 
> code, which makes a maintenance headache.

Replacing them with a different condition doesn't really make that
any better.

