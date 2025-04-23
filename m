Return-Path: <linux-fsdevel+bounces-47058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EEC6A9833B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 10:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E0BB442B22
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 08:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47CC275115;
	Wed, 23 Apr 2025 08:16:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD3C26F457;
	Wed, 23 Apr 2025 08:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745396182; cv=none; b=SB9rwVHee83ScsTAe3xS82f3cfZ2pvapJP4QNs0Zd8aQ9as+fMWai22Fig6Zo8TGth3HxydSPp4jAqgupEaEp6nh9zz9LAlFVj+CVwp2hZkeLtNVgIKmVTR9w3o5jHiDythCt7tGx2wXYjm3C7zOGuluaBF6jy6p76Xzu0Y7OtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745396182; c=relaxed/simple;
	bh=vloqzshVOPueVViTkxh/S01iosGVwmKXxsOV5kK3MkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OvdbqrNIjDbxS8qVR4ZoxityysP1T/u2RAO8JHuS4IJIWRrFRGmoP2Mfk+rTxE8J7UqoqGsXf2CSfGzYXFSdWIPHetant/J/EOQXPdTkC7Hl/6UozB+hcsm7QY42y2P/lmF1iWSfDbKEYMpcG/TdIjtEB90cc2hx4lolMUqPMF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 236D168AFE; Wed, 23 Apr 2025 10:16:15 +0200 (CEST)
Date: Wed, 23 Apr 2025 10:16:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, djwong@kernel.org, hch@lst.de,
	viro@zeniv.linux.org.uk, jack@suse.cz, cem@kernel.org,
	linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v8 10/15] xfs: add large atomic writes checks in
 xfs_direct_write_iomap_begin()
Message-ID: <20250423081614.GC28307@lst.de>
References: <20250422122739.2230121-1-john.g.garry@oracle.com> <20250422122739.2230121-11-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422122739.2230121-11-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Apr 22, 2025 at 12:27:34PM +0000, John Garry wrote:
> For when large atomic writes (> 1x FS block) are supported, there will be
> various occasions when HW offload may not be possible.
> 
> Such instances include:
> - unaligned extent mapping wrt write length
> - extent mappings which do not cover the full write, e.g. the write spans
>   sparse or mixed-mapping extents
> - the write length is greater than HW offload can support

or simply no hardware support at all.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

