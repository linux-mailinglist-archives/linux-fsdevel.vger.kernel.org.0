Return-Path: <linux-fsdevel+bounces-20891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB1E8FA943
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 06:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 202AD1F25A08
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 04:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2204813DB83;
	Tue,  4 Jun 2024 04:32:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6E858ABC;
	Tue,  4 Jun 2024 04:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717475567; cv=none; b=jMaY8h1B31GNRBXw1/hReUbb79IvfSTqQ5HVYAWyNQa3N/XPY2Y4/ymcYOpHGKU1nvjwpE3GaLkXg7T6DnbIkWOLujIBIxsmzdpBw1jm4nmA/2kRIRcGJWh3LjKYAfNjmeccYbSoK6BMV+V2VKiRN9D4wYKsbaVWkAS7xncUse0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717475567; c=relaxed/simple;
	bh=KDDDW9uMlYV93RCwqn73ulg52hfzwtU4iridi6Gh/KQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JUaO5rcIAntXvTNrUNUClbQMotuLvfmREyxuq8lJjePF+51ecSi4hNMSxRm5RoZrTvI4Lav3/Mz/qQeEznSTdgjNgxwitTUrl3byNmD8lR5R+foPWiqScIBj4oL2tKoipOySJ1WgKMwKOB0qMN7/N1sfXIjIelxrag/29Ncdy0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D3F6168D12; Tue,  4 Jun 2024 06:32:42 +0200 (CEST)
Date: Tue, 4 Jun 2024 06:32:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	martin.petersen@oracle.com, bvanassche@acm.org, david@fromorbit.com,
	hare@suse.de, damien.lemoal@opensource.wdc.com,
	anuj20.g@samsung.com, joshi.k@samsung.com, nitheshshetty@gmail.com,
	gost.dev@samsung.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v20 00/12] Implement copy offload support
Message-ID: <20240604043242.GC28886@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jun 03, 2024 at 10:53:39AM +0000, Nitesh Shetty wrote:
> The major benefit of this copy-offload/emulation framework is
> observed in fabrics setup, for copy workloads across the network.
> The host will send offload command over the network and actual copy
> can be achieved using emulation on the target (hence patch 4).
> This results in higher performance and lower network consumption,
> as compared to read and write travelling across the network.
> With this design of copy-offload/emulation we are able to see the
> following improvements as compared to userspace read + write on a
> NVMeOF TCP setup:

What is the use case of this?   What workloads does raw copies a lot
of data inside a single block device?


