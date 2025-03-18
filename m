Return-Path: <linux-fsdevel+bounces-44251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6610CA6697A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 06:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CA13189EC3D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 05:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172341DD0EF;
	Tue, 18 Mar 2025 05:35:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C25198823;
	Tue, 18 Mar 2025 05:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742276124; cv=none; b=srRKGJWDiRGqmmtAIJrVRkOjnH4yVQBnZeicvBLTUnE3LG6KbKSoHyrQvEEhw3OoFZCRNegxcVbCwzzlVZ6IQk8zKYATe4F6gHVrvlxCKVb6o4DnXZ43o7hsQOtwlE7FTVVaI3om/j/0r+pirUqo6axZ7nO7ZReXcCPKr5GzxoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742276124; c=relaxed/simple;
	bh=+c2x5ERmBnWghzUV765Rd1l4qABHJdiuFIAKuTNH+jQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hgIrZ4NjeWrK0mYpxI3Fjvrje6rS4a9hkKTWySjUshI9hFmazqDdV5QPmSNMunGl2Bc+RBXXWzA7wNV2X4MKAaXKTpT/+QyHakyGO4Qvv3USN7zI7jbYyQNQUsYZ9HgSnDYouGkH0lBwS3x7t+jW0hScv2jIGrsT8ZueREyhWQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E37EF68AA6; Tue, 18 Mar 2025 06:35:16 +0100 (CET)
Date: Tue, 18 Mar 2025 06:35:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, brauner@kernel.org,
	djwong@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
	martin.petersen@oracle.com, tytso@mit.edu,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v6 10/13] xfs: iomap COW-based atomic write support
Message-ID: <20250318053516.GC14470@lst.de>
References: <20250313171310.1886394-1-john.g.garry@oracle.com> <20250313171310.1886394-11-john.g.garry@oracle.com> <8734fd79g1.fsf@gmail.com> <cd05e767-0d30-483a-967f-a92673cdcba8@oracle.com> <87r02vspqq.fsf@gmail.com> <aad48c97-20dc-4fec-aeda-9f87294bac78@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aad48c97-20dc-4fec-aeda-9f87294bac78@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Mar 17, 2025 at 02:56:52PM +0000, John Garry wrote:
> ok, fine. I am just worried that these commit messages become too wordy. 
> But, if people want this info, then I can provide it.

While too wordy commit messages do exit, you're really far from that
threshold.  So yes, please explain this.

I think we also really need a document outside of commit logs and
comments that explains the exact atomic write semantics and how
we implement them between the hardware offload and always COW writes.


