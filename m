Return-Path: <linux-fsdevel+bounces-26899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D36195CBD9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 13:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25DC91F21012
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 11:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55C3188591;
	Fri, 23 Aug 2024 11:59:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED16188001;
	Fri, 23 Aug 2024 11:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724414346; cv=none; b=MdfDdkBV1SeOlMGEevS6taPUW9byDtgAhcQs43rsM77383c9SwwXitn7dloRAjCt/N9gLXJY3MSEEqnRoPlrBIYwnMv+wQTVLp0+RZtLagUqKTJJyhMIyvvDsQ5081ibEWliKKw5gDxXCm4wx4Yvc7nJZgfWo+ZeBBZtH7u3JLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724414346; c=relaxed/simple;
	bh=J6uKXwEWLbE5yHpPJ8L1Zbn5ZceS6YRpK7tmfGN4JP4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k2duQT5aCn8A5Zq2gL9gs4q0M5ULPd1GRWVLAs3HKQUwjtbyOMuAIlQcg/+Bhkk8jaPgQVsiK14PTjznBQu53EvRWy7C4N0eN+2/vNUUGW1k4C3LMwyV6M6cPdxTBgFGiXkA7KRYMrgSesQTeQKCwcl9umr9+yl9ggiMTgWnu78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wqz8Q5xRXzpTNf;
	Fri, 23 Aug 2024 19:57:26 +0800 (CST)
Received: from kwepemd100024.china.huawei.com (unknown [7.221.188.41])
	by mail.maildlp.com (Postfix) with ESMTPS id 51AA5140390;
	Fri, 23 Aug 2024 19:59:01 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemd100024.china.huawei.com
 (7.221.188.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 23 Aug
 2024 19:59:00 +0800
From: yangyun <yangyun50@huawei.com>
To: <miklos@szeredi.hu>
CC: <josef@toxicpanda.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <yangyun50@huawei.com>,
	<lixiaokeng@huawei.com>
Subject: Re:[PATCH 1/2] fuse: replace fuse_queue_forget with fuse_force_forget if error
Date: Fri, 23 Aug 2024 19:58:13 +0800
Message-ID: <20240823115813.4138001-1-yangyun50@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <CAJfpegviwk5F+39Vz2D4UjLaGpsFZ-26WeDwetjL=hWV4T6S7A@mail.gmail.com>
References: <CAJfpegviwk5F+39Vz2D4UjLaGpsFZ-26WeDwetjL=hWV4T6S7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd100024.china.huawei.com (7.221.188.41)

On Thu, Aug 22, 2024 at 05:26:01PM +0200, Miklos Szeredi wrote:
> On Sat, 27 Jul 2024 at 12:06, yangyun <yangyun50@huawei.com> wrote:
> > Since forget is not necessarily synchronous (In my opinion, the pre-this patch use of
> > synchronous 'fuse_force_forget' is an error case and also not necessarily synchronous),
> > what about just changing the 'fuse_force_forget' to be asynchronous?
> 
> Even less impact would be to move the allocation inside
> fuse_force_forget (make it GFP_NOFAIL) and still use the
> fuse_queue_forget() function to send the forget as e.g. virtiofs
> handles them differently from regular requests.

fuse_force_forget uses the fuse_simple_request with args.force=true and it does not need allocation outside originally, so it is strange for what you said "move the allocation inside fuse_force_forge".

I think what you mean is moving the allocation inside fuse_queue_forget, not fuse_force_forget. This can make sense.

Thanks for your advice. I will update this patch.

> 
> Thanks,
> Miklos

