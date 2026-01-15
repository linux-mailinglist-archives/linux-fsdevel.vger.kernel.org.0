Return-Path: <linux-fsdevel+bounces-73944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF272D25F77
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 17:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1AF523050886
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 16:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8573BB9F3;
	Thu, 15 Jan 2026 16:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="QRP82hww"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF243B530C;
	Thu, 15 Jan 2026 16:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768496257; cv=none; b=ZUqke3M37blv2ufEPtqs6lJzlGP4gsWivfJkdvw+0U3r10eZe1RROFTvqxNw/oPOmQTd4yxv1gAw1lAjepovUgs5BV/1fBfp6fsktB7MAm30YoSmR9R+N0tDaqpES1kQUZhrj2JPtOik53bGrHp4xrGNNPvc/3+m6vZ/NXbSTk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768496257; c=relaxed/simple;
	bh=RRiX81CZwQhe6tuMCfbcvaDGNPLe3O4jA/JD7UOTEbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dA+5LkBnpzZGU4ad1Gp3vI8VgUPbvrsojJ6hYPtke7dYKwfkpzlL3ZT3mSRLpHGWlYX7R7/dfkR1n5L1H/L5fWRtGAjyU6Wm2z2sMjk4g3x+lCCV/wPHK2QfyRAgOM2NyKfgkb/pEmZluUBndGK6Bomj1tzBN42MlbTUB1DZ+I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=QRP82hww; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4dsTgM6kW4z1XLwWq;
	Thu, 15 Jan 2026 16:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1768496253; x=1771088254; bh=pyJZLrfYN2fopVo75CqixFeJ
	Ag7d9LR6Rf52qTESDCM=; b=QRP82hww25rHq/9BSUHHSiWm1b2wYPyDivT8jGCh
	CCVOapBk8eRxKB88JFKz8F6EzoAEejIbMqs1DRlmtSoqyeh9VdI2dfuh34JuR6Ez
	15a5930vopQWoat26A4oVSHOPOf/6WJyi31fOG8zX9m10ZtsBoBE3J625T606xYl
	ojah3djRvWEoep14fQAL3WpSdMsxbJBi3hoEYl+1g1uZQQ5ppeqlHhZ8aHL3JVZ2
	5OfCbvi6sY5eRi8sEF7f+85Y0MQo//vrxTrr1qiiei9A3L3HyWxrTM8jL7CIHOds
	8jVhW9vA9caNMmis+ofnhUnkz/MiJLIkuDgvxrRn5IPBVQ==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id EthOTvHz3v5K; Thu, 15 Jan 2026 16:57:33 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4dsTgF6l2wz1XLyhS;
	Thu, 15 Jan 2026 16:57:29 +0000 (UTC)
Message-ID: <2f88aa9b-b1c2-4b02-81e8-1c43b982db1b@acm.org>
Date: Thu, 15 Jan 2026 08:57:28 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: target: Fix recursive locking in
 __configfs_open_file()
To: Prithvi Tambewagh <activprithvi@gmail.com>, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
 linux-kernel@vger.kernel.org, hch@lst.de, jlbec@evilplan.org,
 linux-fsdevel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com, khalid@kernel.org,
 syzbot+f6e8174215573a84b797@syzkaller.appspotmail.com, stable@vger.kernel.org
References: <20260108191523.303114-1-activprithvi@gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260108191523.303114-1-activprithvi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/8/26 12:15 PM, Prithvi Tambewagh wrote:
> This poses a possibility of recursive locking,
> which triggers the lockdep warning.

Patches that fix a lockdep complaint should include the full lockdep 
complaint.

Since the fixed lockdep complaint didn't trigger a deadlock it must be
a false positive complaint, isn't it? Such complaints should be fixed
but without additional information we can't tell what the best way is to
fix the complaint.

Thanks,

Bart.

