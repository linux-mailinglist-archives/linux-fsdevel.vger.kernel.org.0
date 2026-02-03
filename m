Return-Path: <linux-fsdevel+bounces-76195-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KF+sNUb3gWljNAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76195-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 14:25:26 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0E8D9E25
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 14:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F29213073D04
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 13:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB35A38E5E3;
	Tue,  3 Feb 2026 13:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Oo9YRcb6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99EE3563DD
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 13:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770125116; cv=none; b=ZRPulZNItpS2dLmoTUfOMtUvx2y7aeUAnJT4UzzbXEKu3zgGLxS9m2hZLJMPXmuMZeeOBz60Hx9qFVjMRvhNlYBPq8Z32KQ1HsVnG+0RSUqpJm1sfTOYMJrOJ4nAdCLVqUznP01zOJLUk/IKHnDRiylLKMK2x6DvlHSMOCMvGhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770125116; c=relaxed/simple;
	bh=DXCJtUUvPDFduMzBV9HR/LzQOQpSZ5MneBFwflO2PuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GDJ94ughYorgOHt7VlrQk35w7QnLHm9xUSfPAaemT+mQb5mS9q0OQq4gU98qtdwV7hNyY/4NyM7fosSqC0ncmn4FhYmxEvKpjL5bPIUVWDgBkf+ux3vERZ+6WhGFVFPV0bezO8tJeR9QkwocLKTkZSaUMY3EudX2lTcQ5ltQuqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Oo9YRcb6; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=KhR+Bpome514j0cBz5QBQ56s5G0jRMPbD4FwhFQbBBQ=;
	b=Oo9YRcb6FPWKkpGcAj7WZmDZ/Bw1+/BmroPRuFLUb71i2HmoklWxmxW83V7OobHRtLUxBux2I
	ynLsDUBxgrO6R7fOy+DVvwukVBVKYcQQjOO1HY55GsD+BdZOiK2s95x7ZDaHcPYIg/RiqtO1Sqo
	Mp4ShgQruAdHL53gulsdOj8=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4f53y85dRNz1K96Z;
	Tue,  3 Feb 2026 21:20:32 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 103FE40563;
	Tue,  3 Feb 2026 21:25:04 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 3 Feb 2026 21:25:03 +0800
Message-ID: <71d4c5cc-8830-4a2e-8e7d-349c7f571e2e@huawei.com>
Date: Tue, 3 Feb 2026 21:25:03 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] fs/iomap: Describle @private in iomap_readahead()
Content-Language: en-US
To: <brauner@kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, "Darrick J. Wong" <djwong@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
References: <20260126120020.675179-1-lihongbo22@huawei.com>
 <20260126120020.675179-2-lihongbo22@huawei.com>
 <4dd236c2-2ada-4d2b-a565-5c94904dcc23@linux.alibaba.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <4dd236c2-2ada-4d2b-a565-5c94904dcc23@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76195-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lihongbo22@huawei.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,huawei.com:email,huawei.com:dkim,huawei.com:mid]
X-Rspamd-Queue-Id: 8D0E8D9E25
X-Rspamd-Action: no action

Hi Christian,

Sorry to bother you. Have you missed applying this patch? Or need more 
update.

Thanks,
Hongbo

On 2026/1/29 17:21, Gao Xiang wrote:
> Hi Christian,
> 
> On 2026/1/26 20:00, Hongbo Li wrote:
>> The kernel test rebot reports the kernel-doc warning:
>>
>> ```
>> Warning: fs/iomap/buffered-io.c:624 function parameter 'private'
>>   not described in 'iomap_readahead'
>> ```
>>
>> The former commit in "iomap: stash iomap read ctx in the private
>> field of iomap_iter" has added a new parameter @private to
>> iomap_readahead(), so let's describe the parameter.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: 
>> https://lore.kernel.org/oe-kbuild-all/202601261111.vIL9rhgD-lkp@intel.com/
>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> 
> Could you apply this single patch kernel-doc fix directly?
> 
> Thanks,
> Gao Xiang

