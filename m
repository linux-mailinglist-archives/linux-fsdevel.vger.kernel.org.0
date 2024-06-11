Return-Path: <linux-fsdevel+bounces-21482-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5DD904784
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 01:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A52281C23863
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 23:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC242155CAE;
	Tue, 11 Jun 2024 23:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="39nJIEgh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02AE155A47;
	Tue, 11 Jun 2024 23:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718147338; cv=none; b=umj28EI18UnVym2jq4fNjjsgpg9Yok3XhhnvtiZhoJMR2o8oE7LXiDfMzcd+KdpEgxthUiajPfwn269fsD5uCqxOr2wqEYxnxIs9+flFwXiLWtjXoiUJKOhUVznKsPEVsCpGhw1ZLP3oVeDOgx0RA4f2HxizzmtfsGG1BKgTd54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718147338; c=relaxed/simple;
	bh=SMsMnl/E19q1EZECqP3FDag1lE3b7Ahyh8DT0mGtfvE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=I3+RdSNkr4sjTWP0oXS+GyXNrwP3NXjbvALyga/51+S0Jwjbr6DU1IETWOl5knP3l9ppKexuNPgLAIcigJIzu8ukU2kgNy9F+6p/HFtTTzEFQwDlnsCIgzGE5uGD0NvkLqlhs1p12Ym0wawfzu+xofB9Yp4/pQNjTHtKkq0OpCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=39nJIEgh; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4VzPVw0Xr1z6CmSMs;
	Tue, 11 Jun 2024 23:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:content-language:references:subject:subject:from:from
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1718147327; x=1720739328; bh=6DyzKM+DtIuobPzwKOhzgzP6
	zkpd17hL1Aod6VJ/k68=; b=39nJIEghuNGK8K73AWmToVISBeoYV97i8RVEhARB
	IRWhsd6ZL2QdIjPJ7QnzwRbKfRaZ87lsD7S5g5Z++gK4qzFWDrFiAET0BiuRs06o
	USgIpJxgOyp7ofPPz/5l117TJMTR/6Zf+EKUZk13h1SdkDqopqVaDfyd4P3zj9kE
	qvy4qDb7cImQyKSzUoJmxrIlDJSFBDKDpyIOX7rwQpPB9cLLQXnR3jw5FP7hUoQn
	BlUUg8xfHQCTKMLpOXW0KJvGuuR/ziY/2UC7wMh/uIzdSA1HjNMFWU1GZ/zdAXeM
	xWb6FFfP3xrcVN868iwkDsldcRYcDPDhMx3Sz435/+Cc/w==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id dk6etEF2j3HT; Tue, 11 Jun 2024 23:08:47 +0000 (UTC)
Received: from [192.168.3.219] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4VzPVk0Gv6z6Cnk8s;
	Tue, 11 Jun 2024 23:08:45 +0000 (UTC)
Message-ID: <9dae2056-792a-4bd0-ab1d-6c545ec781b9@acm.org>
Date: Tue, 11 Jun 2024 16:08:44 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v9 11/19] scsi: sd: Translate data lifetime information
To: Christian Heusel <christian@heusel.eu>,
 Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Daejun Park <daejun7.park@samsung.com>,
 Kanchan Joshi <joshi.k@samsung.com>, Damien Le Moal <dlemoal@kernel.org>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>, regressions@lists.linux.dev
References: <20240130214911.1863909-1-bvanassche@acm.org>
 <20240130214911.1863909-12-bvanassche@acm.org>
 <Zmi6QDymvLY5wMgD@surfacebook.localdomain>
 <678af54a-2f5d-451d-8a4d-9af4d88bfcbb@heusel.eu>
Content-Language: en-US
In-Reply-To: <678af54a-2f5d-451d-8a4d-9af4d88bfcbb@heusel.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/11/24 2:21 PM, Christian Heusel wrote:
> On 24/06/11 11:57PM, Andy Shevchenko wrote:
>> Tue, Jan 30, 2024 at 01:48:37PM -0800, Bart Van Assche kirjoitti:
>>> Recently T10 standardized SBC constrained streams. This mechanism allows
>>> to pass data lifetime information to SCSI devices in the group number
>>> field. Add support for translating write hint information into a
>>> permanent stream number in the sd driver. Use WRITE(10) instead of
>>> WRITE(6) if data lifetime information is present because the WRITE(6)
>>> command does not have a GROUP NUMBER field.
>>
>> This patch broke very badly my connected Garmin FR35 sport watch. The boot time
>> increased by 1 minute along with broken access to USB mass storage.
>>
>> On the reboot it takes ages as well.
>>
>> Revert of this and one little dependency (unrelated by functional means) helps.
> 
> We have tested that the revert fixes the issue on top of v6.10-rc3.
> 
> Also adding the regressions list in CC and making regzbot aware of this
> issue.
> 
>> Details are here: https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/issues/60
>>
>> P.S. Big thanks to Arch Linux team to help with bisection!
> 
> If this is fixed adding in a "Reported-by" or "Bisected-by" (depending
> on what this subsystem uses) for me would be appreciated :)

Thank you Christian for having gone through the painful process of
bisecting this issue.

Is the Garmin FR35 Flash device perhaps connected to a USB bus? If so,
this is the second report of a USB storage device that resets if it
receives a query for the IO Advice Hints Grouping mode page. Does the
patch below help?

Thanks,

Bart.


diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 3a43e2209751..fcf3d7730466 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -63,6 +63,7 @@
  #include <scsi/scsi_cmnd.h>
  #include <scsi/scsi_dbg.h>
  #include <scsi/scsi_device.h>
+#include <scsi/scsi_devinfo.h>
  #include <scsi/scsi_driver.h>
  #include <scsi/scsi_eh.h>
  #include <scsi/scsi_host.h>
@@ -3117,6 +3118,9 @@ static void sd_read_io_hints(struct scsi_disk *sdkp, unsigned char *buffer)
  	struct scsi_mode_data data;
  	int res;

+	if (sdp->sdev_bflags & BLIST_SKIP_IO_HINTS)
+		return;
+
  	res = scsi_mode_sense(sdp, /*dbd=*/0x8, /*modepage=*/0x0a,
  			      /*subpage=*/0x05, buffer, SD_BUF_SIZE, SD_TIMEOUT,
  			      sdkp->max_retries, &data, &sshdr);
diff --git a/drivers/usb/storage/scsiglue.c b/drivers/usb/storage/scsiglue.c
index b31464740f6c..9a7185c68872 100644
--- a/drivers/usb/storage/scsiglue.c
+++ b/drivers/usb/storage/scsiglue.c
@@ -79,6 +79,8 @@ static int slave_alloc (struct scsi_device *sdev)
  	if (us->protocol == USB_PR_BULK && us->max_lun > 0)
  		sdev->sdev_bflags |= BLIST_FORCELUN;

+	sdev->sdev_bflags |= BLIST_SKIP_IO_HINTS;
+
  	return 0;
  }

diff --git a/include/scsi/scsi_devinfo.h b/include/scsi/scsi_devinfo.h
index 6b548dc2c496..fa8721e49dec 100644
--- a/include/scsi/scsi_devinfo.h
+++ b/include/scsi/scsi_devinfo.h
@@ -69,8 +69,10 @@
  #define BLIST_RETRY_ITF		((__force blist_flags_t)(1ULL << 32))
  /* Always retry ABORTED_COMMAND with ASC 0xc1 */
  #define BLIST_RETRY_ASC_C1	((__force blist_flags_t)(1ULL << 33))
+/* Do not read the I/O hints mode page */
+#define BLIST_SKIP_IO_HINTS	((__force blist_flags_t)(1ULL << 34))

-#define __BLIST_LAST_USED BLIST_RETRY_ASC_C1
+#define __BLIST_LAST_USED BLIST_SKIP_IO_HINTS

  #define __BLIST_HIGH_UNUSED (~(__BLIST_LAST_USED | \
  			       (__force blist_flags_t) \

