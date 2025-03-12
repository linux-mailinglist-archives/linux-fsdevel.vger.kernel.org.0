Return-Path: <linux-fsdevel+bounces-43804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 167E8A5DE84
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 14:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 943383AE7A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 13:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE3524BC09;
	Wed, 12 Mar 2025 13:59:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EA52459D0;
	Wed, 12 Mar 2025 13:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741787960; cv=none; b=FwjSiHcnvri1dwa/ddxJaH8V2B0VvUxMMxfhhEBTK5pxPlOGRWxX5ZdVirp/yOzemgAdfvUWVqHhHotFLKo+4DvJgZ8NPZRzZ3C4YQ5g0TGga+RJkwUrLg1juNRDzqVyw7Q/U7UueoK/SX3uA5yBG4SZDG32guQ1OCe6dQQmJ7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741787960; c=relaxed/simple;
	bh=I+ZggbW2AQWliXHPSHrqQCZgq7RM16Z511PBjh6KULs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LnwfkDrkWjJFDOJI5V1uDaobKXxARQPF+LdkyXqbxaBJbW/xZNJWYCs/IukPU3APxrDpar4xG25bbw4QsjEKo/n1otUonWsUHqwrd2Eeaa+S9gn8yUqdpaJ7shgm8KKPQ62SBIQ5NzInHYfwwncdwsorJlx+vcPORfv9nxSg//s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id EF23C68BFE; Wed, 12 Mar 2025 14:59:12 +0100 (CET)
Date: Wed, 12 Mar 2025 14:59:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: Li Wang <liwang@redhat.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Christoph Hellwig <hch@lst.de>,
	brauner@kernel.org, hare@suse.de, willy@infradead.org,
	david@fromorbit.com, djwong@kernel.org, kbusch@kernel.org,
	john.g.garry@oracle.com, ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	ltp@lists.linux.it, lkp@intel.com, oliver.sang@intel.com,
	oe-lkp@lists.linux.dev, gost.dev@samsung.com, p.raghav@samsung.com,
	da.gomez@samsung.com, kernel@pankajraghav.com
Subject: Re: [PATCH] block: add BLK_FEAT_LBS to check for PAGE_SIZE limit
Message-ID: <20250312135912.GB12488@lst.de>
References: <20250312050028.1784117-1-mcgrof@kernel.org> <20250312052155.GA11864@lst.de> <Z9Edl05uSrNfgasu@bombadil.infradead.org> <20250312054053.GA12234@lst.de> <Z9EfKXH6w8C0arzb@bombadil.infradead.org> <CAEemH2du_ULgnX19YnCiAJnCNzAURW0R17Tgxpdy9tg-XzisHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEemH2du_ULgnX19YnCiAJnCNzAURW0R17Tgxpdy9tg-XzisHQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Mar 12, 2025 at 05:19:36PM +0800, Li Wang wrote:
> Well, does that patch for ioctl_loop06 still make sense?
> Or any other workaround?
> https://lists.linux.it/pipermail/ltp/2025-March/042599.html

The real question is what block sizes we want to support for the
loop driver.  Because if it is larger than the physical block size
it can lead to torn writes.  But I guess no one cared about those
on loop so far, so why care about this now..

But if we don't want any limit on the block size that patch looks
right.

