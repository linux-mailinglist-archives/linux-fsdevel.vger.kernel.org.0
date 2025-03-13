Return-Path: <linux-fsdevel+bounces-43856-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2CFA5EA8C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 05:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7E443B889F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 04:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFED14386D;
	Thu, 13 Mar 2025 04:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="v7xtbCv0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEC578F37;
	Thu, 13 Mar 2025 04:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741840027; cv=none; b=a7jWUW9CzPEUEESKHq3RHRFld0Aj8M8zf1jqATt6LWJkIwX5I6eDyIejTeIoVaaz8DsAXAz+htoDHQayyI84kK2PyOxmwLIu8dT7FnDhclLqg/ZRcnjfEZUqKx6i1srqi28aPKzdU46rCPoF3qa7RzfONlzhIXbX9y0kwm4DAQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741840027; c=relaxed/simple;
	bh=rut1C+qOPz/OOsfkYwpouylVxN8Fb+VEbGFwtPL4v2I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=X9UIARRTK8VgIXR8JYkwuw7pxIrfneuVtqcPTMHi6Jk9AU4ySGeygt6vX3hDr/yfvk869YWXcQKR1rginLHwUjxQaC0Hf9SS4ANrg6ssqZFiFgGW03ZzvBynuXemZPPREEUUUCu1aoBJGHY51SpLMw+svvrheMxt1S1MLV+ZZZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=v7xtbCv0; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=jg+w1DC3NQVP4ft2a9Cfe6VN/QxEpG/4sB4ypk7l1R0=; b=v7xtbCv0cy23zBEBdI0h5zQrQN
	W7x5zdfl3quqyCOJESo8Edy7IJEKoFWyCOD6PErkiaW/V7nUb9lfyGGVyiCkIr6pJiM01y7sqmrCQ
	1uqA5Pg4mt7GaGPuZgH6HsO37Bpo7gXq2VAFG/Gtjd4seO3eMcpuYcD+4Rmwf0vKUE3RURn4TTGzM
	KgeJr8nDtNdFmIlPl1YLZkf6XKdDRUFWMd0BmnSBXJYJAgHAumN46Yle62DTqWW4TBvXkuJpNUAS8
	pJmnFpW2AzdDNFdw+8x+Uc99Lr1PjyZ0A+yRIKfNd880Z9WPVDg3bEtaohhKa8hKytkPiMDaCgrjB
	3HZLkp6A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tsa9u-00000008uSX-0UTc;
	Thu, 13 Mar 2025 04:27:02 +0000
Date: Thu, 13 Mar 2025 04:27:02 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-rdma@vger.kernel.org
Subject: [PATCHES] several fixes from tree-in-dcache stuff
Message-ID: <20250313042702.GU2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

Several fixes for fairly old crap - qibfs leak, a couple
of spufs ones and a spufs double-dput() memory corruptor.

This stuff sits in viro/vfs.git#fixes; individual patches
in followups.  Review would be very welcome.

