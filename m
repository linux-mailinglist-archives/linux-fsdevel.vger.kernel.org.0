Return-Path: <linux-fsdevel+bounces-27267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A62E95FEAE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 04:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDB7B282EEC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 02:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED76101DE;
	Tue, 27 Aug 2024 02:03:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AEA1854;
	Tue, 27 Aug 2024 02:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724724217; cv=none; b=ZvevYAyRwuEzEyVZ1h0dIVL4QxHXmfAYcpVAEHL7NXYAUYNsbHTGuZypi7L50PqDyc4LFDzXFlXEFApL0Oe36/MAQMXBRJRaMFS+5dN/ckLKxpLhkaitKAwQBwRII7TZCze16vxLZj/Gs7Ehi5FTK8NhszljlkaqddlhnlE6a/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724724217; c=relaxed/simple;
	bh=+Lw+5WYJJxM1tmEOAqj+YhhvBRg1BYVaNNNg1e1GHmw=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=KwBpqDC4jJYoxFEEsEFG5RrwkP4MyyOaysXthM5AQYFciKxebcAiGqRgolaougzP+IBX2/hLRYrU2oQTKBSC1Fo/lJqb1XR7JQbucl+UMLR58/6XCbkFlTrmWzzudEN1Q5irPPYGREodMUUtVb9ZBEAupQ9Fas13PRXNOmqVPtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Wt9n601DVz1S97D;
	Tue, 27 Aug 2024 10:03:21 +0800 (CST)
Received: from kwepemh100016.china.huawei.com (unknown [7.202.181.102])
	by mail.maildlp.com (Postfix) with ESMTPS id 2077C140136;
	Tue, 27 Aug 2024 10:03:32 +0800 (CST)
Received: from [10.174.178.75] (10.174.178.75) by
 kwepemh100016.china.huawei.com (7.202.181.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 27 Aug 2024 10:03:29 +0800
Subject: Re: [PATCH -next 00/15] sysctl: move sysctls from vm_table into its
 own files
To: Kees Cook <kees@kernel.org>
References: <20240826120449.1666461-1-yukaixiong@huawei.com>
 <202408261256.ACC5E323B2@keescook>
CC: <akpm@linux-foundation.org>, <mcgrof@kernel.org>,
	<ysato@users.sourceforge.jp>, <dalias@libc.org>,
	<glaubitz@physik.fu-berlin.de>, <luto@kernel.org>, <tglx@linutronix.de>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
	<viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jack@suse.cz>,
	<j.granados@samsung.com>, <willy@infradead.org>, <Liam.Howlett@oracle.com>,
	<vbabka@suse.cz>, <lorenzo.stoakes@oracle.com>, <trondmy@kernel.org>,
	<anna@kernel.org>, <chuck.lever@oracle.com>, <jlayton@kernel.org>,
	<neilb@suse.de>, <okorniev@redhat.com>, <Dai.Ngo@oracle.com>,
	<tom@talpey.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <paul@paul-moore.com>,
	<jmorris@namei.org>, <linux-sh@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-nfs@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-security-module@vger.kernel.org>, <wangkefeng.wang@huawei.com>
From: yukaixiong <yukaixiong@huawei.com>
Message-ID: <99407b2b-25db-d559-cded-babf34381a5e@huawei.com>
Date: Tue, 27 Aug 2024 10:03:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <202408261256.ACC5E323B2@keescook>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggpeml500022.china.huawei.com (7.185.36.66) To
 kwepemh100016.china.huawei.com (7.202.181.102)



On 2024/8/27 3:57, Kees Cook wrote:
> On Mon, Aug 26, 2024 at 08:04:34PM +0800, Kaixiong Yu wrote:
>> This patch series moves sysctls of vm_table in kernel/sysctl.c to
>> places where they actually belong, and do some related code clean-ups.
>> After this patch series, all sysctls in vm_table have been moved into its
>> own files, meanwhile, delete vm_table.
> This is really nice! Thanks for doing this migration. I sent a note
> about the "fs: dcache: ..." patch that I don't think will be a problem.
>
> Reviewed-by: Kees Cook <kees@kernel.org>
>
Thanks for your review !:-) Looking forward to future opportunities for 
further discussion and collaboration.

