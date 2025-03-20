Return-Path: <linux-fsdevel+bounces-44655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CABBFA6B02D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 22:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E94C71893D8F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 21:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3758D228CA9;
	Thu, 20 Mar 2025 21:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NVP7T92P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D20190072;
	Thu, 20 Mar 2025 21:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742507421; cv=none; b=IQmy08yKW4sEieRFjRcZw+bhrSUrv2poQ1nktb64XDPQeAwcIbDf+GdWqVtcM6ukAKr8ZxV2qvU6Gyn+/CKF5qhRNDZrdHieaQUgsY79xrSwcn7dTnjURKJva8ghux0qNJJLgN6XZvOKLGtqczqM1mhLHuWJvbvXal1qZIU4O/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742507421; c=relaxed/simple;
	bh=CdqCAE+cs4te1+LSwC83I+ZwB5sHxeVNxfaz1e4os/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZ/B98Px9Hidhv/m2s/dQu/UOI8GvZHopL7kjey3WYol7vBSVyzlXqAOiqDptuGeYGkwMHfQRe9cDofb8RyfcfYhlLhK312sYhTx3dkfLXpTzJMhmGrr7uiLgiaPPjKw08+2L7N8vKaU26l2TybEotWoq13HLSyLZFC9zW5Gn/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NVP7T92P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8923CC4CEDD;
	Thu, 20 Mar 2025 21:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742507421;
	bh=CdqCAE+cs4te1+LSwC83I+ZwB5sHxeVNxfaz1e4os/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NVP7T92Pj5R+HK68YWTI3qrBcBUb0GZRbnewWGJQtuo27h4NrcHddte6wcGbe9CVT
	 FqNPkMzpCV+bRmWLpGm1TtehzRASpimiYHJnQooPVyyFvAK5rYmiAn1WMznr6j/DN3
	 jz7qO9umdyQBrlfi3b82BaWbGT9Ys1j/LC+uOdEiA9Pklf/ppNaMiJk6XlSFHWnJVV
	 llajGYdXbKkxslYPfhqK2cDXw5D9+pq7+Iah66z+ShJFTf+tUKeD2KUk5fjpfpknx2
	 DAksopGPXcqzcxkwBDmadAT89hyJ5pr4j+hPUr0AbLCzv7JiyzmO7wF9QdP/+gYx+t
	 PAV8ey1C+e5mA==
Date: Thu, 20 Mar 2025 14:50:19 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Bart Van Assche <bvanassche@acm.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org, lsf-pc@lists.linux-foundation.org,
	david@fromorbit.com, leon@kernel.org, sagi@grimberg.me,
	axboe@kernel.dk, joro@8bytes.org, brauner@kernel.org, hare@suse.de,
	willy@infradead.org, djwong@kernel.org, john.g.garry@oracle.com,
	ritesh.list@gmail.com, p.raghav@samsung.com, gost.dev@samsung.com,
	da.gomez@samsung.com
Subject: Re: [LSF/MM/BPF TOPIC] breaking the 512 KiB IO boundary on x86_64
Message-ID: <Z9yNm5bvfaGo-Zsv@bombadil.infradead.org>
References: <Z9v-1xjl7dD7Tr-H@bombadil.infradead.org>
 <20250320141846.GA11512@lst.de>
 <a40a704f-22c8-4ae9-9800-301c9865cee4@acm.org>
 <Z9w7Nz-CxWSqj__H@kbusch-mbp.dhcp.thefacebook.com>
 <20250320163804.GA21242@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320163804.GA21242@lst.de>

On Thu, Mar 20, 2025 at 05:38:04PM +0100, Christoph Hellwig wrote:
> On Thu, Mar 20, 2025 at 09:58:47AM -0600, Keith Busch wrote:
> > I allocate out of hugetlbfs to reliably send direct IO at this size
> > because the nvme driver's segment count is limited to 128.
> 
> It also works pretty well for buffered I/O for file systems supporting
> larger folios.  I can trivially create 1MB folios in the page cache
> on XFS and then do I/O on them.

Right, but try DIO or io-uring cmd. The two step dma API seems to help us
bridge this gap and provide parity.

  Luis

