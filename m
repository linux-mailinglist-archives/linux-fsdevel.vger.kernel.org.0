Return-Path: <linux-fsdevel+bounces-27208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFA795F875
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 19:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA2BD1F21D34
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 17:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C2C1991BA;
	Mon, 26 Aug 2024 17:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="h8BmHZmw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89015198E96;
	Mon, 26 Aug 2024 17:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724694257; cv=none; b=j53AmNwdZxdaDOFWZok581rxVhdhKLp/jdiPhGI/ux4D4g9kT5fNL8TueHRgxe4EosJG0f+avgiPTLrGPybfKd8OMJJug/4xFN4So7N93M7I2TSESWFkOG7mDJfY7zZFK4CAqbH4MSLgFMLUwMNjPyqiMR8XnTlNclsgnGjZOKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724694257; c=relaxed/simple;
	bh=Ky1WtZTB1vAFitwSZSr9oE2Lkfv8g9tc5SCDtUd5Igw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SNP17xEU/LDu5nqMIpLB/rxXXF6w2CxTiT7RYS54kLhWwQXSmIaSip/SyqCCh+in/K5dhc9FwvcVw841n5iw3whfq+aSobqb4rtkTvFEDqPGhsRv/gYUQxtv/hFDNhjCKmRP6qvMAbwLq4V3ONOcqigaTOuPkGH3aq2kdGNxWcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=h8BmHZmw; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4Wsyj54Rwmz6ClY9F;
	Mon, 26 Aug 2024 17:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1724694244; x=1727286245; bh=Ky1WtZTB1vAFitwSZSr9oE2L
	kfv8g9tc5SCDtUd5Igw=; b=h8BmHZmwBPtHY/5huyweT7LC/hAMCyRbF8I/nDUc
	eInWFOIaDBLKsf8lBA747JuClgmy4aunEUTem/G+Zb1CBh1IASDyPUTvkMLdO9+X
	qf9Im9LfJJDOPEtLBbARVpojuH0XyhSxuH+s1pxtSSbzb0ndrXh6q9dJydWXuOEf
	9bkLSmmHa0O14/T+VRXR3GRbmD3jhZEV7dDoa8tyenLHf80v0Pa1BDJnwxoLR7YF
	vRgyjI5dlCOoXvve3MUZyzxLD0S6dzNucYTg+phQSn2J5HNK6zgcaHT7GQr3m8oI
	ZBY8H2kdtb4aZJ1oadDKSG/M5XNQpbawLnms14gmqV/TJw==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id TfuIq-julCUO; Mon, 26 Aug 2024 17:44:04 +0000 (UTC)
Received: from [172.31.110.201] (unknown [216.9.110.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4Wsyhx6Vmgz6ClY98;
	Mon, 26 Aug 2024 17:44:01 +0000 (UTC)
Message-ID: <d0e017ac-8367-4bb8-9b7f-d72dd068fdb1@acm.org>
Date: Mon, 26 Aug 2024 10:44:00 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] fs, block: refactor enum rw_hint
To: Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk, kbusch@kernel.org,
 hch@lst.de, sagi@grimberg.me, martin.petersen@oracle.com,
 James.Bottomley@HansenPartnership.com, brauner@kernel.org, jack@suse.cz,
 jaegeuk@kernel.org, jlayton@kernel.org, chuck.lever@oracle.com
Cc: linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, gost.dev@samsung.com, vishak.g@samsung.com,
 javier.gonz@samsung.com
References: <20240826170606.255718-1-joshi.k@samsung.com>
 <CGME20240826171413epcas5p3f62c2cc57b50d6df8fa66af5fe5996c5@epcas5p3.samsung.com>
 <20240826170606.255718-2-joshi.k@samsung.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240826170606.255718-2-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/26/24 10:06 AM, Kanchan Joshi wrote:
> Change i_write_hint (in inode), bi_write_hint (in bio) and write_hint
> (in request) to use u8 data-type rather than this enum.

That sounds fishy to me. Why to increase the size of this enum? Why to
reduce the ability of the compiler to perform type checking? I think
this needs to be motivated clearly in the patch description.

Bart.

