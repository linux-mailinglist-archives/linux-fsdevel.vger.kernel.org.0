Return-Path: <linux-fsdevel+bounces-19879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CFD8CAD13
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 13:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA6E11C21E01
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 11:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFBE62A02;
	Tue, 21 May 2024 11:08:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0827C1F947
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 May 2024 11:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716289718; cv=none; b=GkCfOWJWF+NAYlYr1rNZ5Rv8ufVaTgHz2gyb6odrYVY3K1JPGaBVkpU0xhFHuaEw+mTBUp6q4qTZ1/zNCElixRmZRREaj4suEwf8lSgIeaNRbpw/08sdZvnYDsDFGNMhVoTSsSEOBr1oyxDFJflVux/9yLVNHsts7YL5NbuOeoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716289718; c=relaxed/simple;
	bh=xdvZhsrcP187ALvUqO+Ia2SAIvu4ozrHz4p0nw+A7c8=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=G8QDsTDdHGBQL+mEIFItSew2BNrmBlIyw1adCM2x2A1Ml6zzuz4lVfetOSH+eMqogWd5UT0/weIkAK8htEJgVOF6W6dCX1xuGGzm4M+aRBHB6tdv79YlUD6FSF+VerBJ5Mx6IbYmy+DBti0aPQbVhrJBeGfgV/4M0RYeY1gPXN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VkBR951CszwPFC;
	Tue, 21 May 2024 19:04:53 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 995AB1800B6;
	Tue, 21 May 2024 19:08:30 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 21 May 2024 19:08:29 +0800
Subject: Re: How to detect if ubi volume is empty
To: Pintu Agarwal <pintu.ping@gmail.com>, linux-mtd
	<linux-mtd@lists.infradead.org>, <linux-fsdevel@kvack.org>, linux-fsdevel
	<linux-fsdevel@vger.kernel.org>, Ezequiel Garcia <ezequiel@collabora.com>,
	=?UTF-8?Q?Bj=c3=b8rn_Mork?= <bjorn@mork.no>
References: <CAOuPNLhN2pxa5KPpxiCBZMEGTgqaNddB6DZeB17tanp2gQgX1w@mail.gmail.com>
 <CAOuPNLjccNaLVAMWZ4p9U5zFe7FMwJa=3StPMTFDRngo2yRb-w@mail.gmail.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <03967933-4ced-89b9-ec63-6af89f3d88bf@huawei.com>
Date: Tue, 21 May 2024 19:08:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAOuPNLjccNaLVAMWZ4p9U5zFe7FMwJa=3StPMTFDRngo2yRb-w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600013.china.huawei.com (7.193.23.68)

在 2024/5/20 18:22, Pintu Agarwal 写道:
> Hi,
>
> In Linux Kernel 5.15 is there a way to detect in runtime, if UBI
> volume (squashfs based, ubiblock, dynamic) is empty or not ?

There is a way to get the empty state of UBI volume by ioctl 
UBI_IOCEBUNMAP, for example:

fd = open(UBI_VOLUME, O_EXCL)

check_volume_empty  [1]

close(fd)

[1] 
https://www.linux-mtd.infradead.org/?p=mtd-utils.git;a=blob;f=ubifs-utils/mkfs.ubifs/mkfs.ubifs.c;h=42a47f839e115567de58e8cdfcc50c4202fc7af1;hb=refs/heads/master#l2804

> Based on this we need to make some decisions at runtime.
>
> Currently, we are using a crude way to detect volume empty by reading
> the first 1K block using the "dd" command and checking if the contents
> are all FF.
>
> Is this good enough, or is there some other better way ?
>
> Thanks.
> Pintu
>
> .



