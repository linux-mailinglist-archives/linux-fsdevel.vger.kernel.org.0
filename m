Return-Path: <linux-fsdevel+bounces-8388-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9772835B1C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 07:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88B52B25AA5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 06:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65176AD9;
	Mon, 22 Jan 2024 06:38:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C766F4EB;
	Mon, 22 Jan 2024 06:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705905498; cv=none; b=AEIyGJh+iKFHwz4KBISmYZX5eO9zMBKRYhwE0hbj8GUkxiq64vxftgDV+VRoH1ui8AQYNwJ7vdEoyxmskJ6VFi4AyGWRFGmEsCMyD3QUuVoJ0DscVDRIv9lLi3CszqcQeiB7EMOxp23QDrY4idpfXICwxCcL5/ywazEaYhy1dTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705905498; c=relaxed/simple;
	bh=SzuBe6lNf5+Hu3ZVScoPAaHHZ8/rI2vh7ytm/IGjp4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B7fN7xzLvC0dHez6Uvn5eXcN4RbL9JEzrJQQZw4Hsdrf1siTh19VIPV1U/mBD0+MdO3tXNUKCvFONMlxirNpqs9iPtHMHtfnxW7e+M9FOHkfaBDixaWfyQoElZPQk0uTgTeN1butbxPe0fVPY3Xrl5WfkexvaDCvc/Fgan7uicM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BE32A68B05; Mon, 22 Jan 2024 07:30:08 +0100 (CET)
Date: Mon, 22 Jan 2024 07:30:07 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Christoph Hellwig <hch@lst.de>, bfoster@redhat.com,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] bcachefs: fix incorrect usage of REQ_OP_FLUSH
Message-ID: <20240122063007.GA23991@lst.de>
References: <20240111073655.2095423-1-hch@lst.de> <ueeqal442uw77vrmonr5crix5jehetzg266725shaqi2oim6h7@4q4tlcm2y6k7>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ueeqal442uw77vrmonr5crix5jehetzg266725shaqi2oim6h7@4q4tlcm2y6k7>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jan 19, 2024 at 04:32:44PM -0500, Kent Overstreet wrote:
> 
> I've got a new bug report with this patch:
> https://www.reddit.com/r/bcachefs/comments/19a2u3c/error_writing_journal_entry/
> 
> We seem to be geting -EOPNOTSUPP back from REQ_OP_FLUSH?

With the patch you are replying to you will not get -EOPNOTSUPP
for REQ_OP_FLUSH?, because bcachefs won't send it as it's supposed to.

Without this patch as in current mainline you will get -EOPNOTSUPP
because sending REQ_OP_FLUSH and finally check for that to catch bugs
like the one fixed with this patch.

