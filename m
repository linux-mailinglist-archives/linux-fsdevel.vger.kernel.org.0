Return-Path: <linux-fsdevel+bounces-47051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F2AA9812A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 09:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29E80188506E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 07:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9733F268FF9;
	Wed, 23 Apr 2025 07:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKhitSoH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61F61DE3C3;
	Wed, 23 Apr 2025 07:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745393785; cv=none; b=KnUHCyd6tojac7WAqSlVgv026O4dHGhtgI+6S2sLt3IMHPcAbxNynlU5AAISporav95QeQuMcOoHjHUMrFNoYhsxajqxLSglBHifHa5Ggbl6Q0IeE7aBuBtu7Dtk/8AR3HynZuU3Y4ETYYTd99mp3YxikWcn2E29ILqZ6Us8X2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745393785; c=relaxed/simple;
	bh=Yzkq2uyGzZyQgkKjl3TYYD6a4FU8WuLLe5IWzRRT544=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/8X6bt/RMkKFC0idR4H4Bxl35QV4hFtk08fbnbAi1htCbwjk5ngLIiEjhM4tnO7Eg07YxXiNu437Uw5+UEQqY7WJf08EnCrfwgmltg/E6BOCCv/7XLCqTXrh9X/qpDK9x9rqmp7v0Fmi7tsES2a1bx9fg97X1DBVrGVg6lLwSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lKhitSoH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE123C4CEE2;
	Wed, 23 Apr 2025 07:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745393784;
	bh=Yzkq2uyGzZyQgkKjl3TYYD6a4FU8WuLLe5IWzRRT544=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lKhitSoHmtRl00kFHQbdZToHWxFgJZviiv1jLaoUumjtoCmrRZb8OLIM3P+9JBle7
	 ULIO61Kz5qTBaMybVUk0DChx2QD5XHo1Z1HHbtuKOWvHuh4mE4/sTxU7RNKcAMbEiw
	 n4kjGNC04SRADc7uIrljY/txywHNGwxT+FZ/StWaA+ivxvCObvj/dLG7LGp87dH7co
	 wXxZQnwXoqhs1/dHARfvIChX5dg+vk3bfyAQB52tPM2Qzw8l/N0uKG3vhZL+UMrsfE
	 FrgErfvgjN3bjj1QDSklh6f27NyNJBXISa4GYz9mF/jGWoNWJl6O21pDTrJQWUObsj
	 we+7zQ72ggQug==
Date: Wed, 23 Apr 2025 00:36:22 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	brauner@kernel.org, djwong@kernel.org, hch@lst.de,
	viro@zeniv.linux.org.uk, jack@suse.cz, cem@kernel.org,
	linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com,
	linux-api@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>,
	Daniel Gomez <da.gomez@samsung.com>
Subject: Re: [PATCH v7 11/14] xfs: add xfs_file_dio_write_atomic()
Message-ID: <aAiYdoZsnUTUntnm@bombadil.infradead.org>
References: <20250415121425.4146847-1-john.g.garry@oracle.com>
 <20250415121425.4146847-12-john.g.garry@oracle.com>
 <aAa2HMvKcIGdbJlF@bombadil.infradead.org>
 <69302bf1-78b4-4b95-8e9b-df56dd1091c0@oracle.com>
 <aAh4L9crlnEf3uuJ@bombadil.infradead.org>
 <cf67f166-4c65-4d76-a3a2-1ad2614e89b7@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf67f166-4c65-4d76-a3a2-1ad2614e89b7@oracle.com>

On Wed, Apr 23, 2025 at 08:08:40AM +0100, John Garry wrote:
> On 23/04/2025 06:18, Luis Chamberlain wrote:
> > On Tue, Apr 22, 2025 at 07:08:32AM +0100, John Garry wrote:
> > > On 21/04/2025 22:18, Luis Chamberlain wrote:
> > 
> > Sounds like a terrible predicant for those that want hw atomics and
> > reliability for it.
> 
> Well from our MySQL testing performance is good.

Good to hear, thanks!

  Luis

