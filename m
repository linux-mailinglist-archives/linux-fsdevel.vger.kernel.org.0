Return-Path: <linux-fsdevel+bounces-74461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BBBD3AF96
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 16:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A36AC3046FBC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 15:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3168538BDDB;
	Mon, 19 Jan 2026 15:49:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7589923D7F4;
	Mon, 19 Jan 2026 15:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768837773; cv=none; b=saHqfYckXxCKtjC5P5omPTk0sGl9t/cSddPijBgfPs6r+QmRp+SbXpjBzl6E5YAL+XF8J7gZV/SOy84zQqS98qGevJoWiBvn0QfEV02U6uvjmZ+M3G4uwETZQ74nSQJg0b5cMzwMsM1f4K6rtnUnE0LMjSxfNfUSkOSXqklQkn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768837773; c=relaxed/simple;
	bh=JFsJJwr5hwad7i84JPp4EUF02MwmWcNdXPd6yHsBf38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AAaraXTLiRouRj/gWKo6qWpaSMiYjT0J5fKOgzAuriIP7eKPngftdQymNJ2DMa3QvRQmiiQpPSLxxytG9IYQJsE6wCYz6uSvrtDLm0/n4NcGNMoKEcf3ImM/KYzQ+UCBVTvEzipBNc3HYWv7iM7Yceqe6ChShIMElrbhDuvlEU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43489FEC;
	Mon, 19 Jan 2026 07:49:25 -0800 (PST)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 986073F694;
	Mon, 19 Jan 2026 07:49:29 -0800 (PST)
Date: Mon, 19 Jan 2026 15:49:27 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	sudeep.holla@arm.com, james.quinlan@broadcom.com,
	f.fainelli@gmail.com, vincent.guittot@linaro.org,
	etienne.carriere@st.com, peng.fan@oss.nxp.com, michal.simek@amd.com,
	dan.carpenter@linaro.org, d-gole@ti.com, elif.topuz@arm.com,
	lukasz.luba@arm.com, philip.radford@arm.com,
	souvik.chakravarty@arm.com
Subject: Re: [PATCH v2 03/17] firmware: arm_scmi: Allow protocols to register
 for notifications
Message-ID: <aW5Sh1lIS0n_2Fyr@pluto>
References: <20260114114638.2290765-1-cristian.marussi@arm.com>
 <20260114114638.2290765-4-cristian.marussi@arm.com>
 <20260119113326.00005902@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119113326.00005902@huawei.com>

On Mon, Jan 19, 2026 at 11:33:26AM +0000, Jonathan Cameron wrote:
> On Wed, 14 Jan 2026 11:46:07 +0000
> Cristian Marussi <cristian.marussi@arm.com> wrote:
> 
> > Allow protocols themselves to register for their own notifications and
> 
> and provide their own notifier callbacks.
> 
> > providing their own notifier callbacks. While at that, allow for a protocol
> > to register events with compilation-time unknown report/event sizes: such
> > events will use the maximum transport size.
> 
> I'm not keen on the 'while at that' part of the patch. In an ideal
> world that's a separate patch.

Yes indeed...it was tempting to do it together with the rework since it
was the only usecase that triggered the 'while-at' change...

...but this series in general needs more splitting both at the protocol
level and at the FS level (once I get some feedback from FS guys) so I
will split this out too.

> 
> One other comment inline.
> 
> Jonathan
> p.s. You get to my review victim whilst I run a particularly annoying
> bisection on the other screen (completely unrelated!) :)
> 
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> > v1-->v2
> >  - Fixed multiline comment format
> > ---
> >  drivers/firmware/arm_scmi/common.h    |  4 ++++
> >  drivers/firmware/arm_scmi/driver.c    | 12 ++++++++++++
> >  drivers/firmware/arm_scmi/notify.c    | 28 ++++++++++++++++++++-------
> >  drivers/firmware/arm_scmi/notify.h    |  8 ++++++--
> >  drivers/firmware/arm_scmi/protocols.h |  6 ++++++
> >  5 files changed, 49 insertions(+), 9 deletions(-)
> > 
> 
> 
> > diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
> > index 78e9e27dc9ec..e84b4dbefe82 100644
> > --- a/drivers/firmware/arm_scmi/notify.c
> > +++ b/drivers/firmware/arm_scmi/notify.c
> 
> 
> > @@ -779,8 +787,13 @@ int scmi_register_protocol_events(const struct scmi_handle *handle, u8 proto_id,
> >  	}
> >  
> >  	evt = ee->evts;
> > -	for (i = 0; i < ee->num_events; i++)
> > +	for (i = 0; i < ee->num_events; i++) {
> > +		if (evt[i].max_payld_sz == 0) {
> > +			payld_sz = max_msg_sz;
> > +			break;
> > +		}
> >  		payld_sz = max_t(size_t, payld_sz, evt[i].max_payld_sz);
> 
> Everything here seems to already be a size_t.  It is rare that we actually need max_t over
> max, and definitely not when all the types match.
> 		payld_sz = max(payl_sz, evt[i].max_payld_sz);

...indeed...I will fix.

Thanks,
Cristian

