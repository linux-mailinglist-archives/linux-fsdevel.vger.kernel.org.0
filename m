Return-Path: <linux-fsdevel+bounces-42800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6472AA48E33
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 02:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07F8016D80E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 01:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B637602D;
	Fri, 28 Feb 2025 01:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="1GTD2Xup"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D166653363;
	Fri, 28 Feb 2025 01:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740707647; cv=none; b=HZwzco5RGPpiqVsh4CVSIijptVBassHIyDX8JMXUF2+DHUaco3gcOnJktYx0opva0HK/FoUpASfWIDes6xlzEP9GMFzgue3uVVvawyKnQaKFHgYZdj2l0xQGFQXTd+Y8uaXbwG7V6xboZhF1EHjTN0Pdz7N/AIuTw9xod/paeks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740707647; c=relaxed/simple;
	bh=evrMTEDSuyIa1W0y6REU7nRQBwJltHcgM+KqsBzG52o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Srq+JIIXpUOg+m4rfHaSAzR19jjc8FSheEn/eJB6mKPXIYT10K/kTZ5czZfSrFFGt0QyZCAkIQy74hRtlXxAl7p3QnKMFlAgLfnNLf3o4LUoPvttCPQ/NLzCU1pMmOvptsQ+Ga56PHXfdWncY+Vo/hnlQkI6e2Fp/IIJNUigEmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=1GTD2Xup; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Z3rpv711hz9sRk;
	Fri, 28 Feb 2025 02:53:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1740707640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=27+nlWbol20EEU9VGn+hQa4trjf7i7iixdALr91E0Po=;
	b=1GTD2XupHD3pmOuBMNbiAI9CRQ7NpWmMWttdol1n4lkPvWkniRnI5X15iMGUaHGRD7JaV6
	J1nAdr8+svXAgvqoegydBSDNTixrrFPo2GweU6XSGBpKRLReUhfXrHWaREhzxyUcEB2jqM
	pS5qiiFLs4Y9Qh5cqiIfvYX9vGvC3jLRHu3G2/MoLroMvQw8wX2QoSlJcyvCVhvc+EyP2u
	wRO/AU5Jx8pjjE71bZ13CcwETHQgg4Vb7aGwKwnxuq+rt6VARtbEKUUpll+DmzTkxoHOTt
	S5wjPn/h0/ukT5JhrgjgGSoT8vCL9+OtWkii2ywoJ31d3/DMb2NmDF4AOCXP0w==
Date: Thu, 27 Feb 2025 20:53:56 -0500
From: Ethan Carter Edwards <ethan@ethancedwards.com>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-staging@lists.linux.dev, 
	asahi@lists.linux.dev
Subject: [RFC] apfs: thoughts on upstreaming an out-of-tree module
Message-ID: <rxefeexzo2lol3qph7xo5tgnykp5c6wcepqewrze6cqfk22leu@wwkiu7yzkpvp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Lately, I have been thinking a lot about the lack of APFS support on
Linux. I was wondering what I could do about that. APFS support is not 
in-tree, but there is a proprietary module sold by Paragon software [0].
Obviously, this could not be used in-tree. However, there is also an 
open source driver that, from what I can tell, was once planned to be 
upstreamed [1] with associated filesystem progs [2]. I think I would 
base most of my work off of the existing FOSS tree.

The biggest barrier I see currently is the driver's use of bufferheads.
I realize that there has been a lot of work to move existing filesystem
implementations to iomap/folios, and adding a filesystem that uses
bufferheads would be antithetical to the purpose of that effort.
Additionally, there is a lot of ifndefs/C preprocessor magic littered
throughout the codebase that fixes functionality with various different
versions of Linux. 

The first step would be to move away from bufferheads and the
versioning. I plan to start my work in the next few weeks, and hope to
have a working driver to submit to staging by the end of June. From
there, I will work to have it meet more kernel standards and hopefully
move into fs/ by the end of the year.

Before I started, I was wondering if anyone had any thoughts. I am open
to feedback. If you think this is a bad idea, let me know. I am very
passionate about the Asahi Linux project. I think this would be a good
way to indirectly give back and contribute to the project. While I
recognize that it is not one of Asahi's project goals (those being
mostly hardware support), I am confident many users would find it
helpful. I sure would.

Thanks,
Ethan Carter Edwards <ethan@ethancedwards.com>

[0]: https://www.paragon-software.com/us/home/apfs-linux/
[1]: https://github.com/linux-apfs/linux-apfs-rw
[2]: https://github.com/linux-apfs/apfsprogs

