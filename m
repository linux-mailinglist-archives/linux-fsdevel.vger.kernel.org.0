Return-Path: <linux-fsdevel+bounces-46631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13604A92282
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 18:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CFBD5A446E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 16:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0177254865;
	Thu, 17 Apr 2025 16:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JaR1rCDz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22236111A8;
	Thu, 17 Apr 2025 16:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744906740; cv=none; b=adEBcyQBMAUc23PiilujJtQB17AY/FXQYtmuycQzQKwuIGD6CvskvT2xs7Fi2xDufnQmgkBLTZMN5cb6WBAMziXWyFvJawKf571FDR7J7+QVV/SJ3DKQkSbGHgAngAmmAB9mbHsvJCUDBAMRV5wqfdAR5n8HpdOQxZPRc9ZuMSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744906740; c=relaxed/simple;
	bh=dB9mozrOqyBcD7MjHjwTfrA+t24nximWt/ZvoATeJ24=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Nk6pZAw2j142pyBu7ueeQuX6qnj0jKe0wh6SG8W/EAwQLszaVbnrL7z1Xk92qbvXpuoxzbnh15ucYPEfib4179KG/ApGECnz64VMq2W+Hpon1cxoOtNbTu22VSr/WkoDF0m7gzviIP9aUuUYWB1BkUcGyhRHHK5wbI50hbYQMNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JaR1rCDz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6022DC4CEE4;
	Thu, 17 Apr 2025 16:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744906739;
	bh=dB9mozrOqyBcD7MjHjwTfrA+t24nximWt/ZvoATeJ24=;
	h=Date:From:To:Cc:Subject:From;
	b=JaR1rCDzoM6JAfNB0MxydWg+Y0HulEirgf3tnbnDHnD4Twk7UpwvNrdjIQoYiXKkY
	 S2c5YlyzzYRLsyv09KLKkh7r123N3ZJzUEXveb14gvcYnKvL5+N1uNVpO5svRsxjaG
	 3PGfOa6rbiaoc2bdB4onGfYsEEDS7mhVnyHIZfgQ5YOtSjzDcwd3PJwR0k85gCwl7d
	 m0uzuGh0at7oQ2GrUdJXzc5Ky8R+AcMqlA1LtnfN3jrhKgJZbinBRKr4Kx816YpA5l
	 WEphdEqOrL0YHa06n3443TAQEPFYZ44nxcysqyqVEbW5Z5AkqWcCT2V0/NlYBMMT1R
	 0noGfI2alis1A==
Date: Thu, 17 Apr 2025 09:18:57 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Linux FS Devel <linux-fsdevel@vger.kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Tso Ted <tytso@mit.edu>,
	kdevops@lists.linux.dev, fstests <fstests@vger.kernel.org>
Subject: Automation of parsing of fstests xunit xml to kicdb kernel-ci
Message-ID: <aAEp8Z6VIXBluMbB@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

We're at the point that we're going to start enablish automatic push
of tests for a few filesystems with kdevops. We now have automatic
collection of results, parsing of them, etc. And so the last step
really, is to just send results out to kicdb [0].

Since we have the xml file, I figured I'd ask if anyone has already
done the processing of this file to kicdb, because it would be easier
to share the same code rather than re-invent. We then just need to
describe the source, kdevops, version, etc.

If no one has done this yet, we can give it a shot and we can post
here the code once ready.

[0] https://docs.kernelci.org/kcidb/submitter_guide/

  Luis

