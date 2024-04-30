Return-Path: <linux-fsdevel+bounces-18195-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F978B66E1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 02:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FEF628355A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 00:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153351843;
	Tue, 30 Apr 2024 00:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="D7VbQ5Eu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143B610E4;
	Tue, 30 Apr 2024 00:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714437045; cv=none; b=Mfevm/1ughwrk+KbY7SaMtP3ZzTto3B0HaaV7J+Lmk3Y18PthZNWY67TE/lCkmAfmhw4NPP5YEjQ26xqOnKyU7ndcuHDzjoZTu6L6qe0kwIdVeOkGWlG361QAKUdB+9JEDTt/B4WmRyX/JsKtN55Sy1lM/jHxKKEcMQfIv2HhNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714437045; c=relaxed/simple;
	bh=Sad0c3BAwORuOECFTxuWorp+2Q9bvjgU3vgOlJ1g6I0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hieZ+yZR/31G3Z1UmOaaeT4sDFXQ+OLKuTLXVR2L+N1pRGsXPJBalXJbEnZT35O3wK65FiJtLfDtpltGDR029/gX6WQBpTswwFz3ZhJ7QHiWeapXdhWIKJaUhzgGdnPpKT2SQCOWPC4oGE5613P1Z69+LOIzpY3b3UP6FFT1Blk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=D7VbQ5Eu; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nwJE2BVn3Hc8XvZkB0UiLwTax0Bm/qufFbEA9OSgtUQ=; b=D7VbQ5EuUjrbl1Fl685yZ8uFzx
	ZFKB1nISp4g/yVMnGApD1ezb3cniQPB36LHQJ5Es447i2nPEiRS1SwDkYgIfC5t03CNwt4LYY1nFp
	IGltnH7CKGl607NAFaVJ0tWc5re5Gyb6DN7qwSc+6vZjCHMq9Ec++dN10gPiEe9ejzLZd8D6BZ6EY
	GK0P5AxyUZKFg9NrrNFpEvhLodriZRl7oQIkKcN5V+Urpw+rXupjGUWdNmIR2mJmdHzww+3tRdAIh
	t+V4BMjmQ9rcsdjVQrtXNX4r8IQJh3tkQsBRjUagkqLkb1lUiyeqWBdwREjZnP79uHy3ufCN3bQU4
	npjEZJJQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s1bOG-007PBM-1V;
	Tue, 30 Apr 2024 00:30:36 +0000
Date: Tue, 30 Apr 2024 01:30:36 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Stefan Haberland <sth@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, jack@suse.cz, hch@lst.de,
	brauner@kernel.org, axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, yukuai3@huawei.com,
	Yu Kuai <yukuai1@huaweicloud.com>,
	Eduard Shishkin <edward6@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Jan Hoeppner <hoeppner@linux.ibm.com>
Subject: Re: [PATCH vfs.all 15/26] s390/dasd: use bdev api in dasd_format()
Message-ID: <20240430003036.GD2118490@ZenIV>
References: <20240406090930.2252838-1-yukuai1@huaweicloud.com>
 <20240406090930.2252838-16-yukuai1@huaweicloud.com>
 <20240416013555.GZ2118490@ZenIV>
 <Zh47IY7M1LQXjckX@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <ca513589-2110-45fe-95b7-5ce23487ea10@linux.ibm.com>
 <20240428185823.GW2118490@ZenIV>
 <20240428232349.GY2118490@ZenIV>
 <dc4325fb-d723-4d9f-adb7-7ee65a195231@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc4325fb-d723-4d9f-adb7-7ee65a195231@linux.ibm.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Apr 29, 2024 at 04:41:19PM +0200, Stefan Haberland wrote:

> The dasdfmt tool checks if the disk is actually in use and refuses to
> work on an 'in use' DASD.
> So for example a partition that was in use has to be unmounted first.

Hmm...  How is that check done?  Does it open device exclusive?

