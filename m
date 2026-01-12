Return-Path: <linux-fsdevel+bounces-73201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19041D118AD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 10:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D723305D9B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 09:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FF434A78D;
	Mon, 12 Jan 2026 09:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="hILrfsK6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com [50.112.246.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EB6349B01;
	Mon, 12 Jan 2026 09:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.112.246.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768210854; cv=none; b=kE/ife0Z6bRFgRC6eLDvV9LPbxeraiMQyXlcFn/CWy0p6tJaGosYK2DyOUIpjZpAyK+ioiXJnvyScv8aOA1ZaSOd1V423wM7lH/lNjNijjRSPWEUvGNtp0/xd29bQZe0X/MMvwR/esP0pC+1XePPrNxDt+dxnIpt3J0wSObVT8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768210854; c=relaxed/simple;
	bh=9Tnd54ccK/SEyrhDqdu0sR6BOb88u6CYAQ7GQqFz6PU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l0odYWqpgeUJ98BZNvxjbPcwxeC5pE5nBdlpoGTf26FsF1VgeGtI3E0tCSr3TF+xhWn4ZqDnKTM+9icQ3Blrux0HXRVlLD7LvADG2vDfZy9pdVbYwqEnsWcG4+SwBKFgOBnX/eDF5RFjCwucMx00Ylhn+ub/VRN+1/L8OQIu1O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=hILrfsK6; arc=none smtp.client-ip=50.112.246.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1768210852; x=1799746852;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=46Ky87W6PsIzO2xwYH31+q/xQevV13LL6yLzYIEoe9I=;
  b=hILrfsK6Vtt5Ytal5LfKQ8Xbg/Hrtnjm8bjWKmmk/LlhLI9ANVwtoW1d
   uBATNmCfcD8NSyCB9VxGlSWvjqH8/sqQL1wwLTDsU12chxOZ09sy6TPZu
   hijHYKG0k4hEOYduFocFj/PA/SR1iKuiU+3/iToKApDWQhspR/znNEvb5
   eX/XZ+ljpFEtYSpFft3JOrTp7eK6X7dqyAAngVQeCaQkoxJCNOvDIBcva
   aBOebCw7veDeJZ9XR3HB1q+80tOy69Pdr2CPy8tGXqUu4KH8a/L//4asM
   NY9WwCD0qalATDYdCLD5B+E35jeirZ7W3XrkkiBCFy5/szHlJhMXSAGk6
   A==;
X-CSE-ConnectionGUID: XosqesVkSVqQj3B9uDwMww==
X-CSE-MsgGUID: FSf+tNWnQ9aSxR6gXLLWKA==
X-IronPort-AV: E=Sophos;i="6.21,219,1763424000"; 
   d="scan'208";a="10493313"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 09:40:48 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:9853]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.48.99:2525] with esmtp (Farcaster)
 id 68855ca0-6d20-4a7d-a073-a0d0e1bc8e75; Mon, 12 Jan 2026 09:40:48 +0000 (UTC)
X-Farcaster-Flow-ID: 68855ca0-6d20-4a7d-a073-a0d0e1bc8e75
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Mon, 12 Jan 2026 09:40:48 +0000
Received: from c889f3b07a0a.amazon.com (10.106.82.30) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Mon, 12 Jan 2026 09:40:46 +0000
From: Yuto Ohnuki <ytohnuki@amazon.com>
To: <mjguzik@gmail.com>
CC: <brauner@kernel.org>, <jack@suse.cz>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <viro@zeniv.linux.org.uk>,
	<ytohnuki@amazon.com>
Subject: Re: [PATCH v2] fs: improve dump_inode() to safely access inode fields.
Date: Mon, 12 Jan 2026 09:40:38 +0000
Message-ID: <20260112094038.71100-1-ytohnuki@amazon.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <tno2xwbsdiq674hlvcfxmzo357wia3b6b2jxddgh4u2yvygmic@ygtdea6prr33>
References: <tno2xwbsdiq674hlvcfxmzo357wia3b6b2jxddgh4u2yvygmic@ygtdea6prr33>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D043UWA002.ant.amazon.com (10.13.139.53) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> It would be good to avoid duplication of the pr_warn stuff as the format
> string is expected to change over time. I guess you could retain
> "<invalid>" for the case where sb was unreadable? Or even denote it,
> perhaps with "<unknown, sb unreadable>" or similar.
> 
> 
> I don't really care as long as tere is one pr_warn dumping the state.
> 
> This bit:
> +	pr_warn("invalid inode:%px\n", inode);
> 
> could still print the passed reason. "invalid inode:" is a little
> misleaing, perhaps "unreadable inode" would be better?
> 
> As a side note I was told kernel printk supports %# for printing hash
> values, perhaps a good opportunity to squeeze this in intead of 0x. One
> will have to test it indeed gives the expected result.

Thank you for the review and suggestions.

Yes, I intended to denote the situation where sb is unreadable, so I've
adopted "<unknown, sb unreadable>" in v3.
I'll address all the other points as well and send out v3.

Best regards,
Yuto



Amazon Web Services EMEA SARL, 38 avenue John F. Kennedy, L-1855 Luxembourg, R.C.S. Luxembourg B186284

Amazon Web Services EMEA SARL, Irish Branch, One Burlington Plaza, Burlington Road, Dublin 4, Ireland, branch registration number 908705




