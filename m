Return-Path: <linux-fsdevel+bounces-70472-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C65AFC9C6FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 18:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 49AE434932C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 17:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D502C159C;
	Tue,  2 Dec 2025 17:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="wX1rIQD6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hg3pzsPp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E13D29AAE3
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Dec 2025 17:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764697217; cv=none; b=l/TqF6/amaDibop1zkbDMHZf2zXY6BYjeH39rqCe6tjVvCOzWLa9aQSK7rM+speZmxy49AUbI7B+5DVGl1Guo8f7auJBQc6SoqFf2tnRln5wTU+3KaKN5xRk3EnryTDE40UldiIGOj+xUEELlHzFUzWVqIOGkz0W+NZMpt4WEZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764697217; c=relaxed/simple;
	bh=LY8wTM30SFeaqv3Rw5OHAOykHvKbjm6BHsT5i9gnK3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qHbwZtgBauGJiYxXTHD/pymgk0kT7g6u9RsCEw5wuZ3tUWIwGyziLtJZtZkvF7UcMcF+0pdwWN4aFwGJmDLdjskrygDO5kmq56i2lyBbqWekcnFZ5KcbSa9ANXWcSQhXGQ34iDivwS58vK0YGf9CbE/eiAaHRYWZNcGqWnjP490=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=wX1rIQD6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hg3pzsPp; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 92A0714001BB;
	Tue,  2 Dec 2025 12:40:13 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 02 Dec 2025 12:40:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1764697213;
	 x=1764783613; bh=BZtOm5+1TZAchd5lHO5/FL97irLnSqsjk47mLJ5X/Rk=; b=
	wX1rIQD6U9kqimLDJDWYhhjhvHWoDWmDrsPnGsQmGzz4kApS2+CKwF3mFYQItuue
	wjZRDee72HstDzwqo8msQyM+6bNsLhDerbLToklNFLWCCZ8OHP9a5R/BeQc28M4A
	s64263Oq+QOvyHJkemlzZp530hWo/3AqX2YtVVhy+937Ow4EQxusQGnGQ9JKPV6L
	ux3nHm/q5nvPHO5tujLZleGdDflPgm8cj3Z6jzRJ5Wbxbl7nslUF4zaBCKqVB6W8
	bZM/4z94dBw8Hj2TMJ8Oha9UbNpWjVDNL36myPxTPuNIhSsjFNrrklHuoo/b8Vqn
	gavtMQNPxQliZ1JXEybFhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764697213; x=
	1764783613; bh=BZtOm5+1TZAchd5lHO5/FL97irLnSqsjk47mLJ5X/Rk=; b=H
	g3pzsPptfoV3KYjznLRKexgA798nkyk8GnHsWlBnAbPiRCoh9K7A6RgNvNM44H6H
	mcUdq8+tbwfjpCBjfMTSNAdQtNulftvjwd0Cl9CNviAl88ZW6IE+rLnETodyB35X
	UKHJc017yAWWtTx3updNwaF6myQ9KWZHA4T4exHYhprNdB795H3rCU2xToc7E7L/
	IZ+GyKicHnfUfp8NElX9NYjl8mTq02FVQETHHsSnJNd/Wg1qNkgQ04JfCxzRxuP5
	GtklIbKO2brYdHYwNdGTmudPtnZgIp5Kcgkd3mqCAqIimRRXyhZSBcnBb3q4/hw0
	dq7dqIS6DVWFmrV0W7trg==
X-ME-Sender: <xms:fCQvaaUhBiAYF47LsXPDsgDJirPt7mPhpi1F52cKj2pBz_fi-yv0dw>
    <xme:fCQvaaTSYzawiEmTQlYhl_zlEW-OEQ7NaFjFktP88oJLjDTXkE4zKDDWeyIYLgWYA
    kIVdUTcbFzerWLuS03rN_OhG3rczQGkTwwNJ1SBUi6-XMyJXWo>
X-ME-Received: <xmr:fCQvaYNis4e0jR--gnx3qGle1bv57SdWGAME4qeHipcHQmEdYnXGvtLJY3md9fmsLgJ0kFgewlBWTq0wRv75PFT-agm9z8O6hzJT7G9ctkoi4487LuA0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecunecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvd
    ejnecuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghr
    nhgurdgtohhmqeenucggtffrrghtthgvrhhnpeehhfejueejleehtdehteefvdfgtdelff
    euudejhfehgedufedvhfehueevudeugeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpegsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprh
    gtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlvghordhlihhl
    ohhngheshhhurgifvghirdgtohhmpdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvug
    hirdhhuhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepsghstghhuhgsvghrthesuggunhdrtghomhdprhgtph
    htthhopeihrghnghgvrhhkuhhnsehhuhgrfigvihdrtghomhdprhgtphhtthhopehlohhn
    uhiglhhirdeigeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:fCQvaYQTlEBaSs-2jm9YVD4X7flXgqlG6NQOnJW9p_wcjHxHG3kVbQ>
    <xmx:fCQvaWi2umTBZCsvKja9EwX_vEQq69iHc6FDhlVt-yhrIE9Sr714ww>
    <xmx:fCQvaR85cYqzcgRM0D-pGlk0GD-HnewwOlJTkXNFnU4LrM2xOKFMHQ>
    <xmx:fCQvadGiI0RvXayIEXKo71MKm0ZMvZyJFoLa8py6-fsd-sMTWBzz2Q>
    <xmx:fSQvacnGrGJA4Tj4SoskXjE1Qx-xSSzEFl5Tg_3HCwwbBnRVwBZhdAYk>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Dec 2025 12:40:11 -0500 (EST)
Message-ID: <71e2ccaa-325b-4dd4-b5b7-fd470924c104@bsbernd.com>
Date: Tue, 2 Dec 2025 18:40:10 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: limit debug log output during ring teardown
To: Long Li <leo.lilong@huawei.com>, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, bschubert@ddn.com, yangerkun@huawei.com,
 lonuxli.64@gmail.com
References: <20251129110653.1881984-1-leo.lilong@huawei.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20251129110653.1881984-1-leo.lilong@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Long,

On 11/29/25 12:06, Long Li wrote:
> Currently, if there are pending entries in the queue after the teardown
> timeout, the system keeps printing entry state information at very short
> intervals (FUSE_URING_TEARDOWN_INTERVAL). This can flood the system logs.
> Additionally, ring->stop_debug_log is set but not used.
> 
> Use ring->stop_debug_log as a control flag to only print entry state
> information once after teardown timeout, preventing excessive debug
> output. Also add a final message when all queues have stopped.
> 
> Signed-off-by: Long Li <leo.lilong@huawei.com>
> ---
>  fs/fuse/dev_uring.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 5ceb217ced1b..d71ccdf78887 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -453,13 +453,15 @@ static void fuse_uring_async_stop_queues(struct work_struct *work)
>  	 * If there are still queue references left
>  	 */
>  	if (atomic_read(&ring->queue_refs) > 0) {
> -		if (time_after(jiffies,
> +		if (!ring->stop_debug_log && time_after(jiffies,
>  			       ring->teardown_time + FUSE_URING_TEARDOWN_TIMEOUT))
>  			fuse_uring_log_ent_state(ring);
>  
>  		schedule_delayed_work(&ring->async_teardown_work,
>  				      FUSE_URING_TEARDOWN_INTERVAL);
>  	} else {
> +		if (ring->stop_debug_log)
> +			pr_info("All queues in the ring=%p have stopped\n", ring);
>  		wake_up_all(&ring->stop_waitq);
>  	}
>  }


how about like this?

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index f6b12aebb8bb..a527e58b404a 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -452,9 +452,11 @@ static void fuse_uring_async_stop_queues(struct work_struct *work)
         * If there are still queue references left
         */
        if (atomic_read(&ring->queue_refs) > 0) {
-               if (time_after(jiffies,
-                              ring->teardown_time + FUSE_URING_TEARDOWN_TIMEOUT))
+               if (time_after(jiffies, ring->teardown_time +
+                                       FUSE_URING_TEARDOWN_TIMEOUT)) {
                        fuse_uring_log_ent_state(ring);
+                       ring->teardown_time = jiffies;
+               }
 
                schedule_delayed_work(&ring->async_teardown_work,
                                      FUSE_URING_TEARDOWN_INTERVAL);

Most of it is formatting, it just updates  "ring->teardown_time = jiffies",
idea is that is logs the remaining entries. If you run into it there is
probably a bug - io-uring will also start to spill warnings.


Thanks,
Bernd


