Return-Path: <linux-fsdevel+bounces-48171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2806CAABA7E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 09:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E61A1C26DEB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 07:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B351241669;
	Tue,  6 May 2025 05:02:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24339235BF4;
	Tue,  6 May 2025 05:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746507767; cv=none; b=Nlf7KvAmvpnFt/bTbYCX41jjRwbo4rWlaIlRwvdTOhKzYEE+EWLuorXlxzH6ENYHtEjpyKBuoogxlintZc73g4yn6958SoEmgX/XymyKiYY+5WeKbNLuMm3yJ8n+pgBtQx2DMACpGu0M2X8KEAc5f5OXh1SmvW6MtppJ6l1jFE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746507767; c=relaxed/simple;
	bh=WpiL9RUKgpw4IAWGl2V9dyiwaKBSUahbWcqFMg2jLmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JOU6oi/vRLjUY8vDYxklKALq+TjYqt7zqPD/iaW2AI59gvGMi4XlilgQCrMnVusgV2cc1l5jLHWo15/+GXIzTYtyeNbrRoGLzr2BRoJUIx5OJWEQXD7tUTqXfZSybyXI40wzMSejtnd/A9HriZQMhMUZ+GxYMV1zZXhhAY4LZd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9C5A767373; Tue,  6 May 2025 07:02:39 +0200 (CEST)
Date: Tue, 6 May 2025 07:02:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Zhang Yi <yi.zhang@huaweicloud.com>,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	tytso@mit.edu, john.g.garry@oracle.com, bmarzins@redhat.com,
	chaitanyak@nvidia.com, shinichiro.kawasaki@wdc.com,
	brauner@kernel.org, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC PATCH v4 07/11] fs: statx add write zeroes unmap attribute
Message-ID: <20250506050239.GA27687@lst.de>
References: <20250421021509.2366003-1-yi.zhang@huaweicloud.com> <20250421021509.2366003-8-yi.zhang@huaweicloud.com> <20250505132208.GA22182@lst.de> <20250505142945.GJ1035866@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505142945.GJ1035866@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, May 05, 2025 at 07:29:45AM -0700, Darrick J. Wong wrote:
> attributes_mask contains attribute flags known to the filesystem,
> whereas attributes contains flags actually set on the file.
> "known_attributes" would have been a better name, but that's water under
> the bridge. :P

Oooh.  I think I was very confused at what this patch does, and what
it does seems confused as well.

The patch adds a new flag to the STATX_ATTR_* namespace, which
historically was used for persistent on-disk flags like immutable,
not the STATX_* namespace where I assumed it, and which has no
support mask.  Which seems really odd for a pure kernel feature.
Then again it seems to follow STATX_ATTR_WRITE_ATOMIC which seems
just as wrongly place unless I'm missing something?


