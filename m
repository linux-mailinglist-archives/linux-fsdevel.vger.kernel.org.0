Return-Path: <linux-fsdevel+bounces-39041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC068A0B961
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 15:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EECC218806A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 14:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1A72451E6;
	Mon, 13 Jan 2025 14:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MjI9nj/o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7002451CC
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jan 2025 14:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736778214; cv=none; b=VGH0WWHH0et+8e2wlqiciAduMRSJO5aymd1ZT7rsOxMIhR4IesObgmIsp5gj+aXJILnchgNmlUicU/ocmvWJrub0oFTvwtldUHGoVQMy0LhT62DqR4oJ5T50rwk2VI/P3yGmY+CYnNSi55xNSF87GPheew8QlKXcfsydHerjI6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736778214; c=relaxed/simple;
	bh=ZiVkU3ieMxuFoPQqlEuab44LJ+CLdRjJ9y/dJVzcfg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eX2sZEquG4EiWEBOVUHQM2rQcTakSgkADRdHKHO0u7ab3QFRC47Ri818FeImTMEr2I0YCq+BnbmKtBH0mXR8tQEQ1N+7LIUwuEzPWR+fWLsDwMBwzQ9c3Dkhz50VFCch3W9hthAibSPETS3tFVcDVEkJ7yugRmNcN+CMHvt9ilk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MjI9nj/o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736778212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J4oAaAjM2XjU/h2onTlrQ9TCcfAUUmAcwGjULRZ2X4Y=;
	b=MjI9nj/oLgnOcAGkpuSOvbwAKxED+BqEpJF5gsu3U3QAMrDxXzlS7OFODbV4D7+bCdl52v
	aCDiqfEI2w9CuZCbwFUoV/n3ExsmVHDSYAZVZ7Kv8aWg2KUgfOI16EOkCxKlEZnQQubG7f
	hBhPpNjOM9TC5xEyVV5uzRJ5kJAtv+g=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-604-bPgOs30VNOeDbU1HokFlNA-1; Mon,
 13 Jan 2025 09:23:28 -0500
X-MC-Unique: bPgOs30VNOeDbU1HokFlNA-1
X-Mimecast-MFC-AGG-ID: bPgOs30VNOeDbU1HokFlNA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7489F1956080;
	Mon, 13 Jan 2025 14:23:27 +0000 (UTC)
Received: from bfoster (unknown [10.22.80.118])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AFEB23003FD1;
	Mon, 13 Jan 2025 14:23:26 +0000 (UTC)
Date: Mon, 13 Jan 2025 09:25:38 -0500
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 3/6] iomap: support incremental iomap_iter advances
Message-ID: <Z4UiYikZaxqBOp-c@bfoster>
References: <20241213143610.1002526-1-bfoster@redhat.com>
 <20241213143610.1002526-4-bfoster@redhat.com>
 <Z391qhtj_c56nfc2@infradead.org>
 <Z4Fd4tUp1hFmGB2G@bfoster>
 <Z4SbLBtacHgN3qd-@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4SbLBtacHgN3qd-@infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Sun, Jan 12, 2025 at 08:48:44PM -0800, Christoph Hellwig wrote:
> On Fri, Jan 10, 2025 at 12:50:26PM -0500, Brian Foster wrote:
> > Yeah, I agree this is a wart. Another option I thought about was
> > creating a new flag to declare which iteration mode a particular
> > operation uses, if for nothing else but to improve clarity.
> 
> I actually really like the model where the processing loop always
> advances.  It'll make a few things I have on my mind much easier.
> 
> That doesn't mean I want to force you to go all the way for the initial
> patch series, but I'd love to see a full switchover, and preferably
> without a too long window of having both.
> 

Ok, thanks. I'm on board with that, just need to dig back into it to be
certain of details or roadblocks..

Another thing that crossed my mind is that it might be preferable to
convert across at least one release cycle regardless, just from a risk
management standpoint. I.e., introduce for zero range in one release,
let the test robots and whatnot come at me with whatever issues that
might exist, and then follow up with broader changes from there. But
anyways, one thing at a time..

Brian

> > reason.. would we think this is a worthwhile iteration cleanup on its
> > own?
> 
> Yes.
> 


