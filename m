Return-Path: <linux-fsdevel+bounces-6172-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA21814554
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 11:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50216B22FD4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 10:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA071A709;
	Fri, 15 Dec 2023 10:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZ6m6fb9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC6319BDD;
	Fri, 15 Dec 2023 10:19:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F50C433CA;
	Fri, 15 Dec 2023 10:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702635554;
	bh=1I04KCvKIIKJsGUHXpkctM4Gpr7k/ATJ2YN1VolgB0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jZ6m6fb9EaYiGIoBIclk4x5LEwOzFg2z/ijLCECN+Zr5C6GdmmnYqVuZ9mrMY84az
	 waqtmFlcC5kJSNfNmp4m6XIwaKWMEAJkT5yimNhUW55KRCVfW48QK8wrblO6NlGcoG
	 PvB8nPktYp5LnL1yBEiqTNaSnKjDCRIGVaPjAvJ/HZYf9XU3BoorH6lqSJ4oFxWG2p
	 yXz4QCKW0O5rR8EU4D52y7dkWsLZNaGAQFCcAZJnMa6N7i8SBLH28uIx2w7L1WdWCu
	 dMrncoeIUuKYTbRNfPWuH0A0qo02JlfxdScduF/sYXu1eWSAo/Pvzc/4Dl+olxzHZl
	 PyN/QcKoEkJxA==
Date: Fri, 15 Dec 2023 11:19:07 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bvanassche@acm.org>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Daejun Park <daejun7.park@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Dave Chinner <dchinner@redhat.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v6 05/20] fs: Restore F_[GS]ET_FILE_RW_HINT support
Message-ID: <20231215-ersatzlos-geheuer-85504a401e08@brauner>
References: <20231214204119.3670625-1-bvanassche@acm.org>
 <20231214204119.3670625-6-bvanassche@acm.org>
 <20231215072255.GD18575@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231215072255.GD18575@lst.de>

On Fri, Dec 15, 2023 at 08:22:55AM +0100, Christoph Hellwig wrote:
> NAK, we should not bloat struct file without a reason.

Worth noting, that we would've gained 32bit in the fmode_t expansion and
another 32bit in here. So 64bit in one cycle...

