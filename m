Return-Path: <linux-fsdevel+bounces-54838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A9AB03F6F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 15:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACFB517F4E0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 13:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6E22512F5;
	Mon, 14 Jul 2025 13:17:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4212F243946;
	Mon, 14 Jul 2025 13:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499040; cv=none; b=gvBUhZ1i2u7LiqtY+y9GtvpQb+DyuVIwfE7ChxT9qD3w/T3wQQ6KZ06Rq3SnPnYAy7MUVE+QvhAohdozCVmnpSVfVPWFSjEFFvj5RhrXcxbnt32QZAv4wOTMDAHXlNR0iZUoC5mI47loH9yJwuaOrr39UN7abdJAhKyA2P0kXCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499040; c=relaxed/simple;
	bh=0pR5PbT33styjbaGX+U4uv2AExspH9mUZoz5EmXegpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=prVCluIT2ZhWxqAtdhxDni+14r4oRU33naHPI5rWJCR5A2lCEUu9keYfft+V+9Gr6hrPKxbvaeqIrgweXZ5UC3JoWC5pkM7/Wy5FHHK3I5QImcBHdaNuPGLaiu5tyl8zze/olVyoSDHZ/IzpVwsvylqzFUCNxd2WIFhp6+EewWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1A17A227A88; Mon, 14 Jul 2025 15:17:14 +0200 (CEST)
Date: Mon, 14 Jul 2025 15:17:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Do we need an opt-in for file systems use of hw atomic writes?
Message-ID: <20250714131713.GA8742@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)

Hi all,

I'm currently trying to sort out the nvme atomics limits mess, and
between that, the lack of a atomic write command in nvme, and the
overall degrading quality of cheap consumer nvme devices I'm starting
to free really uneasy about XFS using hardware atomics by default without
an explicit opt-in, as broken atomics implementations will lead to
really subtle data corruption.

Is is just me, or would it be a good idea to require an explicit
opt-in to user hardware atomics?

