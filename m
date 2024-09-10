Return-Path: <linux-fsdevel+bounces-29003-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE6F972D5F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 11:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFE711C24403
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 09:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370E418C35F;
	Tue, 10 Sep 2024 09:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNDT2alz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9763B188CBD;
	Tue, 10 Sep 2024 09:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725960080; cv=none; b=LBNw+kg1xqP1DdILwIupt3oYfsgLzc6LSKh8BKdYlHf+qibsNJ5iNvwj9nPNmPnc5gcQr0SLuqvP+k4VufwI/+L2VLe2DeWL5R4vQyIrkve/JG+EEi3IKazGgCWAzHVd1/4pfTmyKgGdf6GpR9nGzV1FYcXaU0aWR3k8IYrrz68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725960080; c=relaxed/simple;
	bh=AKmNgJq7Gs5fBEgHIR/ia7zyFcTEv22tqHYp9vI99yE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HGUSWJMsKS79+m/7xGrmLskKSWpAZ6kLH0cXBTutSOA3b/sbDtF3e0AwG8/sfjHAwuKmBVHqTWuDCi1iU3kFoN2nK4cL5F5PosHi13X+sy4XRfN1JTmNwcCH7FijdvAt+M1L008IhK6Hxy/tR/ZV35ZBDS9eDLYwZaXeMvuO7KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gNDT2alz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B034C4CECF;
	Tue, 10 Sep 2024 09:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725960080;
	bh=AKmNgJq7Gs5fBEgHIR/ia7zyFcTEv22tqHYp9vI99yE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gNDT2alz9OI2lpAwhO6658etIlRqf9rslysJvF0VvVlNT1ur55mren8HDgWSBnepG
	 qv4qCkWILDna2TGfuekskgksOt/mQCb2eHn8/FRSTUdek2zdkHHBBpOitA/M9YUoHh
	 pIR3DdR0ktzeZcG4novQcxYJVxmTpg9FPUASGMiTPXRpkGuo8SgYrja3bXjyL7zLFA
	 XGGx+DXtfjUf9SJCZIJvwCCluyhSvo+pQ6MQY9Fv9o184O6/gEcpC1kBAPONxYcu6i
	 UK3lGJ5iAMJRdnkupZfxhFfOI232vu9L2q5xvugXnXgTvMYD7smdHdgJTjbVUH4G7F
	 4WCbCzavsJYiQ==
Date: Tue, 10 Sep 2024 11:21:16 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Chandan Babu R <chandan.babu@oracle.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: fix stale delalloc punching for COW I/O v2
Message-ID: <20240910-deponie-angriff-e9c557fc58bf@brauner>
References: <20240910043949.3481298-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240910043949.3481298-1-hch@lst.de>

>  - move the already reviewed iomap prep changes to the beginning in case
>    Christian wants to take them ASAP

I picked up patches 1-5. It was a bit hairy as I didn't have your merge
base and I went and looked at https://git.infradead.org/?p=users/hch/xfs.git;a=summary
but couldn't find the branch this was created from there. It'd be nice
if you could just point me where to look for any prerequisits next time
or just base it on some vfs.git branch. Thanks!

