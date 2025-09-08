Return-Path: <linux-fsdevel+bounces-60577-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A71BB49748
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 19:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95F04188A6C1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 17:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867F6315793;
	Mon,  8 Sep 2025 17:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="KcUadCx7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB0330EF8F
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Sep 2025 17:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757353000; cv=none; b=Psg9o18HD1ydmNKy/9oxev1XuT4OhsXlKHA08UbT3D6/ERbE1xjwlLeROWZhx9fByddSAgnBSvA9vHEY5XP3yK8tb4SLrGtP7qK6x0PnGDVroJ/fZPrRHINK5ltrVpDs5cKctpT/IUATwpPeG7Pgkl5llgfbhlDR9I//4hbIteQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757353000; c=relaxed/simple;
	bh=SIapCOF3l48xNtXDMzoBBihaQkF3gWD8jmx64L2nA68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AlkRikt5IN+4wEKPs4+E2xXbBOXqsE7xbixQSlkyxrOzJ92BJNut61bjpD5DoLZLxHbRTQjKH0wA3GvCMWIFs9dZ/8oi5tJsGFp/IR4N2OXsm5nRBSSzjxhfEeQIuDahuVlAJgM0IANJPqhgQmuOWPHjxq3h0ycSw4S5P7CGlQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=KcUadCx7; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UFqkfSYm6AXhI6MkaCWL/F5X4dsgZSW+440aRHyI63E=; b=KcUadCx7DRMgxQi1iCMcS1jUO4
	1G9gJ6opj39Mknv8DvIFmUEwRuQ9dVTWhCMviTaJA+vfMzIZjSdQNvFouN/H28lv+XjNWet3mPkKW
	38goF3S1jPmONQKqfd/EPhUdRBfyUnOMDTw7gYttJ9HQkvv5bx1KwVCUF7igpY83UCMIck8UmpiV3
	uDcvOEUJ2ag7T05PQKNE/wECwhC24vAStt9f84X2tnKQAydaMup4EAwLjXnustL70/gtPipHe7Upv
	AKPiW7QlIwN/rz3LCdcGWYNaMySGCMHYJbrIFh+ci35WWM0fM5bzeEXWcryI6jlPkN7wYWT20HAuF
	neiQv/RA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvfnA-00000005gyc-10DQ;
	Mon, 08 Sep 2025 17:36:36 +0000
Date: Mon, 8 Sep 2025 18:36:36 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org, jack@suse.cz, torvalds@linux-foundation.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH v3 52/65] ecryptfs: get rid of pointless mount references
 in ecryptfs dentries
Message-ID: <20250908173636.GK31600@ZenIV>
References: <20250903045432.GH39973@ZenIV>
 <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
 <20250903045537.2579614-53-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903045537.2579614-53-viro@zeniv.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Sep 03, 2025 at 05:55:14AM +0100, Al Viro wrote:

> +	sbi->lower_mnt = path.mnt;
Argh...  That should be
+	ecryptfs_superblock_to_private(s)->lower_mnt = path.mnt;

Kudos to Dan Carpenter for catching that and it looks like I need
to deal with the gap in testing that had let it through ;-/

