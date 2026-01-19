Return-Path: <linux-fsdevel+bounces-74434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC525D3A6B0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 12:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 014D7308E192
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 11:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE1830DD1E;
	Mon, 19 Jan 2026 11:22:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8502C0F91;
	Mon, 19 Jan 2026 11:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768821720; cv=none; b=A0MSQQxfar8p+k57c5JSre9UVLB5SyG96nW6ifP8T0XdNL8IADT8gm7WIuZilUpy68FpiXwzPw5VijXYPpntXJEQ9aN9NuwQfchNScjVouvzYkwYxMAxwWp4UjBnZnqLoMcxyiunzNKt2RkKKj6RG8yGGa8BxPu8O+dkK3/Wmio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768821720; c=relaxed/simple;
	bh=Mku49t3nA3C52/phlyv21Hm7M7TrhfEoAauI0IjGzXA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tyK6JMO41uTlbeEySPD9u7Ayk48+B43JZCuFS9DeAe9Kj6WF7OwznMA0lT6J+Gs5W63DKqb+UY2K1DqEoG6ym2p1SBT4U9l78WzDQuJzWTS8AFY0IHq9cE7rIfyzmVPTK7sGHR7rzTQ7bt7TZCB+i44ITBjD1uIv7I1QEiiV8DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dvp1g3JhPzHnHKG;
	Mon, 19 Jan 2026 19:21:27 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 2326A40569;
	Mon, 19 Jan 2026 19:21:57 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 19 Jan
 2026 11:21:56 +0000
Date: Mon, 19 Jan 2026 11:21:54 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Cristian Marussi <cristian.marussi@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<arm-scmi@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<sudeep.holla@arm.com>, <james.quinlan@broadcom.com>, <f.fainelli@gmail.com>,
	<vincent.guittot@linaro.org>, <etienne.carriere@st.com>,
	<peng.fan@oss.nxp.com>, <michal.simek@amd.com>, <dan.carpenter@linaro.org>,
	<d-gole@ti.com>, <elif.topuz@arm.com>, <lukasz.luba@arm.com>,
	<philip.radford@arm.com>, <souvik.chakravarty@arm.com>
Subject: Re: [PATCH v2 02/17] firmware: arm_scmi: Reduce the scope of
 protocols mutex
Message-ID: <20260119112154.0000029d@huawei.com>
In-Reply-To: <20260114114638.2290765-3-cristian.marussi@arm.com>
References: <20260114114638.2290765-1-cristian.marussi@arm.com>
	<20260114114638.2290765-3-cristian.marussi@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Wed, 14 Jan 2026 11:46:06 +0000
Cristian Marussi <cristian.marussi@arm.com> wrote:

> Currently the mutex dedicated to the protection of the list of registered
> protocols is held during all the protocol initialization phase.
> 
> Such a wide locking region is not needed and causes problem when trying to
> initialize notifications from within a protocol initialization routine.
> 
> Reduce the scope of the protocol mutex.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
I haven't checked carefully that the new scope is appropriate but
as a change in of itself, the code is correct and clean.
With that in mind.
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>




