Return-Path: <linux-fsdevel+bounces-42173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 696EDA3DD78
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 15:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7B80176212
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 14:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9751D5AA9;
	Thu, 20 Feb 2025 14:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PRzcgYIN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2459C1D54C2
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2025 14:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740063438; cv=none; b=JugkFwOgr4m0muKet+18V6lGoU2yHuCSIzs6DRFwfXKZatHK2Sxi/Wtk0m5SW26Zgz1N9bPr5LsaDxbZW2fXgh1ozuD8A1SA9hGbSxbUH3A9Yh3rgptYdVIcoVp/59VeTb0lHiUPATAK72voIfAGp/pmSDviEmfyrvt5rbNnT0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740063438; c=relaxed/simple;
	bh=cwE9+ImJ3Nvdqe/tAfsto0R6e1kEymh4aPOQZuJK3Gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EDv/spNesFgEzbQxiBGLUKx2gdYRJIBx4SqUikMd2EcZZNueK+zgR+AsLAMq0YzQ5zEa1NRG008raILR4JRJ/yaBfY1IWWInyrRXTADSlkmzzW6qfg1yp/+ARTjCBflyWTbbXJUbSVQWwhCv5haHmwBN15cWPCQfIzO9StV2n/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PRzcgYIN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740063436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nxB2vu7dIgMe3HfcwqaJPCra1cNnSUPv03GtE2jqgiA=;
	b=PRzcgYIN2x+sppigqqmknqPvHlt1nfTc7rj7jrtItoWSYCVer3S4TD88GOsHN27x2ow9Yh
	7p/wLfy3hDNfo22nIxe/gLwUz/cYhJibZY3jjqJg8D2fhRjdQXvqBvvq4MYHdTpyDAUeFI
	F22+DQRhRUxSmuCgMyzPKjql77GGWP0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-147-UdWIR4TMOhChGhQovzGAnA-1; Thu,
 20 Feb 2025 09:57:10 -0500
X-MC-Unique: UdWIR4TMOhChGhQovzGAnA-1
X-Mimecast-MFC-AGG-ID: UdWIR4TMOhChGhQovzGAnA_1740063429
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 217B91800268;
	Thu, 20 Feb 2025 14:57:09 +0000 (UTC)
Received: from bfoster (unknown [10.22.88.79])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C2BD0300019F;
	Thu, 20 Feb 2025 14:57:07 +0000 (UTC)
Date: Thu, 20 Feb 2025 09:59:44 -0500
From: Brian Foster <bfoster@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH v2 00/12] iomap: incremental advance conversion -- phase 2
Message-ID: <Z7dDYDhi_CDBq8aA@bfoster>
References: <20250219175050.83986-1-bfoster@redhat.com>
 <20250220-mitgearbeitet-nagen-fa0db4e996f8@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220-mitgearbeitet-nagen-fa0db4e996f8@brauner>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, Feb 20, 2025 at 10:10:41AM +0100, Christian Brauner wrote:
> On Wed, Feb 19, 2025 at 12:50:38PM -0500, Brian Foster wrote:
> > Hi all,
> > 
> > Here's phase 2 of the incremental iter advance conversions. This updates
> 
> Hm, what's this based on? Can you base it on vfs-6.15.iomap, please?
> 

Yup.. this was based on -rc3 plus the previous series that introduced
the core iomap change. I'll give hch a couple days or so for any further
comments and post a v3 with Darrick's nit fixed and rebased on the 6.15
iomap branch. Thanks!

Brian


