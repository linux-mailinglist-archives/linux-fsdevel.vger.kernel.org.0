Return-Path: <linux-fsdevel+bounces-44559-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1169A6A51A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 12:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D67B1897B81
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 11:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9AA21CC68;
	Thu, 20 Mar 2025 11:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGqnsfhX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89747214A98;
	Thu, 20 Mar 2025 11:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742470873; cv=none; b=TkblkmppVYgvLFNYjPq9L6bCbuwXK+vbP6sCcQFF9i939PO/3DPA7XTYeUZyWf0Hi1i7PIlIMQc1eRwhjE113ZzR+RsTklb1J0tsB2cYPkPn1E8pfvvwxddvQduqq7Hm/vhYEeZkih1sAQKWDppo4VN9aczj/p3HRPPiQz7bdjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742470873; c=relaxed/simple;
	bh=76RdB/g6Y50zkaCO75Y2n9UEvJzSLLD2iwa/QrAYSwI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lt+2kBLFQXZluoFsVt2H3vrO6yAg52Nj+S+fMheCsP7AMhN+pxeyJL7AMf/Zj2t7tvJp0e1JcNUiqbN0/ErCrKnKKSOxyM7laAw9kreiRWkbQzWKZ6cn3c7KoJVcJuKTj+eS0mYwmskeZl7pNOd9QgD9qg0VCaWi2tMs3bDLE2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGqnsfhX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87B8BC4CEDD;
	Thu, 20 Mar 2025 11:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742470873;
	bh=76RdB/g6Y50zkaCO75Y2n9UEvJzSLLD2iwa/QrAYSwI=;
	h=Date:From:To:Cc:Subject:From;
	b=AGqnsfhXk9NYBoKxuflpuxAxjxhUGPR5bhUuk1NMOeWrOrO8dZLv7nYDxqAQ0ysox
	 pXioidUOdytJnK1Wbp5Hef+ollk2qOnba9MgrIq1M8OCj1W9/8Pm/CcezPcKagrx0L
	 Yf/yNROzL6LuDGeUDlcUJXk5GZ7WmXrBkXtjv3YNKgfmH9eUlSe7+cK6boQzJe1Gfj
	 iLcfD7GZPBLimrDc4vF9TgZscNe58A925X+PhBf1FZ0CVFYPW7jKGFIXuN0Msa/8Ew
	 iB0iGVs5pWPMMe5VRzIZyIM0wRj3xFwzgRhhTVu9bGTi+kbaW6x0UuyawLI5gzczOB
	 JKq4qkrcE99Gg==
Date: Thu, 20 Mar 2025 04:41:11 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org
Cc: lsf-pc@lists.linux-foundation.org, david@fromorbit.com, leon@kernel.org,
	hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk,
	joro@8bytes.org, brauner@kernel.org, hare@suse.de,
	willy@infradead.org, djwong@kernel.org, john.g.garry@oracle.com,
	ritesh.list@gmail.com, p.raghav@samsung.com, gost.dev@samsung.com,
	da.gomez@samsung.com, Luis Chamberlain <mcgrof@kernel.org>
Subject: [LSF/MM/BPF TOPIC] breaking the 512 KiB IO boundary on x86_64
Message-ID: <Z9v-1xjl7dD7Tr-H@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

We've been constrained to a max single 512 KiB IO for a while now on x86_64.
This is due to the number of DMA segments and the segment size. With LBS the
segments can be much bigger without using huge pages, and so on a 64 KiB
block size filesystem you can now see 2 MiB IOs when using buffered IO.
But direct IO is still crippled, because allocations are from anonymous
memory, and unless you are using mTHP you won't get large folios. mTHP
is also non-deterministic, and so you end up in a worse situation for
direct IO if you want to rely on large folios, as you may *sometimes*
end up with large folios and sometimes you might not. IO patterns can
therefore be erratic.

As I just posted in a simple RFC [0], I believe the two step DMA API
helps resolve this.  Provided we move the block integrity stuff to the
new DMA API as well, the only patches really needed to support larger
IOs for direct IO for NVMe are:

  iomap: use BLK_MAX_BLOCK_SIZE for the iomap zero page
  blkdev: lift BLK_MAX_BLOCK_SIZE to page cache limit

The other two nvme-pci patches in that series are to just help with
experimentation now and they can be ignored.

It does beg a few questions:

 - How are we computing the new max single IO anyway? Are we really
   bounded only by what devices support?
 - Do we believe this is the step in the right direction?
 - Is 2 MiB a sensible max block sector size limit for the next few years?
 - What other considerations should we have?
 - Do we want something more deterministic for large folios for direct IO?

[0] https://lkml.kernel.org/r/20250320111328.2841690-1-mcgrof@kernel.org

  Luis

