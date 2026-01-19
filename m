Return-Path: <linux-fsdevel+bounces-74435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B786BD3A6EE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 12:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E66C630263F5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 11:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63A63128D4;
	Mon, 19 Jan 2026 11:33:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2B1312835;
	Mon, 19 Jan 2026 11:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768822414; cv=none; b=tpZObSpvKnwH5Viw+PHxEMuet7KUJPdXiCK5OLonxa5lOTJgeYlpHGlC8XtWJOeGSf5R43CXQWd/dh+7b9xlXr6ojHL2+pDyw62k3rOhfA8i3HZlj48x0NDk6WwSNdLOvlKGU8Zdms8kRPKL6qhczFNIsPu4pczGOEo2KtGApNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768822414; c=relaxed/simple;
	bh=pDjMxzKNbmueMQFTXyIngWd3Nd1Rdxn6nCk1/bY50EM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PexR5oBz9y0DOhsbwq0HUSH1MfG0h2dyIHfPC+ypp1liUSGHpAfqBSRNZKYRznweyasMH+5AUUI78LjXaEmJAJG0f/4FKUexILfiED+ZZ/84IAu/hfmk59wfNtncGYOnZ5dKZYMwjbzwaTlZqAs+MJNs7CVR4SqrFCI7oEtS0lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dvpH56bBJzJ46q8;
	Mon, 19 Jan 2026 19:33:05 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id A4A9240570;
	Mon, 19 Jan 2026 19:33:28 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 19 Jan
 2026 11:33:27 +0000
Date: Mon, 19 Jan 2026 11:33:26 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Cristian Marussi <cristian.marussi@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<arm-scmi@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<sudeep.holla@arm.com>, <james.quinlan@broadcom.com>, <f.fainelli@gmail.com>,
	<vincent.guittot@linaro.org>, <etienne.carriere@st.com>,
	<peng.fan@oss.nxp.com>, <michal.simek@amd.com>, <dan.carpenter@linaro.org>,
	<d-gole@ti.com>, <elif.topuz@arm.com>, <lukasz.luba@arm.com>,
	<philip.radford@arm.com>, <souvik.chakravarty@arm.com>
Subject: Re: [PATCH v2 03/17] firmware: arm_scmi: Allow protocols to
 register for notifications
Message-ID: <20260119113326.00005902@huawei.com>
In-Reply-To: <20260114114638.2290765-4-cristian.marussi@arm.com>
References: <20260114114638.2290765-1-cristian.marussi@arm.com>
	<20260114114638.2290765-4-cristian.marussi@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Wed, 14 Jan 2026 11:46:07 +0000
Cristian Marussi <cristian.marussi@arm.com> wrote:

> Allow protocols themselves to register for their own notifications and

and provide their own notifier callbacks.

> providing their own notifier callbacks. While at that, allow for a protocol
> to register events with compilation-time unknown report/event sizes: such
> events will use the maximum transport size.

I'm not keen on the 'while at that' part of the patch. In an ideal
world that's a separate patch.

One other comment inline.

Jonathan
p.s. You get to my review victim whilst I run a particularly annoying
bisection on the other screen (completely unrelated!) :)

> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> v1-->v2
>  - Fixed multiline comment format
> ---
>  drivers/firmware/arm_scmi/common.h    |  4 ++++
>  drivers/firmware/arm_scmi/driver.c    | 12 ++++++++++++
>  drivers/firmware/arm_scmi/notify.c    | 28 ++++++++++++++++++++-------
>  drivers/firmware/arm_scmi/notify.h    |  8 ++++++--
>  drivers/firmware/arm_scmi/protocols.h |  6 ++++++
>  5 files changed, 49 insertions(+), 9 deletions(-)
> 


> diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
> index 78e9e27dc9ec..e84b4dbefe82 100644
> --- a/drivers/firmware/arm_scmi/notify.c
> +++ b/drivers/firmware/arm_scmi/notify.c


> @@ -779,8 +787,13 @@ int scmi_register_protocol_events(const struct scmi_handle *handle, u8 proto_id,
>  	}
>  
>  	evt = ee->evts;
> -	for (i = 0; i < ee->num_events; i++)
> +	for (i = 0; i < ee->num_events; i++) {
> +		if (evt[i].max_payld_sz == 0) {
> +			payld_sz = max_msg_sz;
> +			break;
> +		}
>  		payld_sz = max_t(size_t, payld_sz, evt[i].max_payld_sz);

Everything here seems to already be a size_t.  It is rare that we actually need max_t over
max, and definitely not when all the types match.
		payld_sz = max(payl_sz, evt[i].max_payld_sz);

> +	}
>  	payld_sz += sizeof(struct scmi_event_header);


