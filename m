Return-Path: <linux-fsdevel+bounces-33963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A359C0FC3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 21:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B81B1F23E10
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 20:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4124218335;
	Thu,  7 Nov 2024 20:31:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F24618F2C3
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Nov 2024 20:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.238.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731011481; cv=none; b=O4cc+cbUyqW09h6Cuy+jbov/h/STxeZDFNlWnkuo6uOmY8o9IaUJdU4RCo/lnD53FoCRnDNskOlwdrbeP2iw/3bswpgAR/+JsTPLY8g/kuD4WTFtoJKk39vhvyJ/Ty5jtbLppWSE2L6afb6738+//PFZZAUgyM1qbNfYWGx0wZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731011481; c=relaxed/simple;
	bh=1U2EXTdiAm7QJ3hWrTWG/+CWrX+kA2ajH3EpBzSplX4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F6ae7QXYbqv7HJ0n7ktLF3DGjg8c5dM+JVps4gXv1Gg4VNEFzX9Yx8VBkvRsulPS5P88pe/WF4V8rFT896A44XQE47fSHeoHIJAMKS5UQtCRLZ/gwEiMZftemHMLVYVhjb6TlYfTY9r6JiM9RQczMKw/nwSs7HtK0G6c96Ot1ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net; spf=pass smtp.mailfrom=thesusis.net; arc=none smtp.client-ip=34.202.238.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thesusis.net
Received: by vps.thesusis.net (Postfix, from userid 1000)
	id F41A557087; Thu,  7 Nov 2024 15:22:06 -0500 (EST)
From: Phillip Susi <phill@thesusis.net>
To: linux-fsdevel@vger.kernel.org
Subject: Page cache deduplication
Date: Thu, 07 Nov 2024 15:22:06 -0500
Message-ID: <87r07m4wwh.fsf@vps.thesusis.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

I was just reading an lwn article on the introduction of page cache
deduplication for EROFS and how that normally isn't possible.  Why is it
not normally possible?  Each file has its own vma doesn't it?  So why
can't the underlying physical page be shared and the pte marked read
only so if you write to one file, it is COWed just like ksm does for
anonmymous memory?


