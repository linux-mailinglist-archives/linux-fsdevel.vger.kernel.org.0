Return-Path: <linux-fsdevel+bounces-74460-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF6AD3AF71
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 16:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C32B73060260
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 15:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8853090DD;
	Mon, 19 Jan 2026 15:45:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7727C278E47;
	Mon, 19 Jan 2026 15:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768837519; cv=none; b=J7IKtzbXsE8aoOhUfy8KVZ+FGWar7bHhwMt1ev7CKbfjoH0OL5rf7AgC96oXAfoxkQh4S0SMNrORw/6oR//gCtcKQA/KstcBgp1Pvkd6ch5HWGta2FFny72VoW1mOHhW+bqvT17sMrHOC2Ali+gLPyEwH3gHK7tA9cObwNcvsqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768837519; c=relaxed/simple;
	bh=4g1/FrueJxkVwUmLw0512e3qtr6xVgwg7YVMH5uX3Xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMSl9rAlbz8LEuhMzHD3/9Ck/7aOkXGMcScG0kUHqf+JgDwVq2KZnNJvu6rc1QP/MLGdHJ313stqlFJNhAiCbODYyVXL3wru7AE9+kJ0HNCUn3qEgTCelcm7ApZRfQDhZydE6sS7pmsYxMam2YgB/gE/R05gNVBx7rVUtcq9i/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34EB2497;
	Mon, 19 Jan 2026 07:45:10 -0800 (PST)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 936F23F694;
	Mon, 19 Jan 2026 07:45:14 -0800 (PST)
Date: Mon, 19 Jan 2026 15:45:12 +0000
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
Subject: Re: [PATCH v2 02/17] firmware: arm_scmi: Reduce the scope of
 protocols mutex
Message-ID: <aW5RiHlkX0HGkAzT@pluto>
References: <20260114114638.2290765-1-cristian.marussi@arm.com>
 <20260114114638.2290765-3-cristian.marussi@arm.com>
 <20260119112154.0000029d@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119112154.0000029d@huawei.com>

On Mon, Jan 19, 2026 at 11:21:54AM +0000, Jonathan Cameron wrote:
> On Wed, 14 Jan 2026 11:46:06 +0000
> Cristian Marussi <cristian.marussi@arm.com> wrote:
> 
> > Currently the mutex dedicated to the protection of the list of registered
> > protocols is held during all the protocol initialization phase.

Hi Jonathan,

> > 
> > Such a wide locking region is not needed and causes problem when trying to
> > initialize notifications from within a protocol initialization routine.
> > 
> > Reduce the scope of the protocol mutex.
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> I haven't checked carefully that the new scope is appropriate but
> as a change in of itself, the code is correct and clean.
> With that in mind.

I will double check after more testing.

> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> 

Thanks for having a look.

Cristian

