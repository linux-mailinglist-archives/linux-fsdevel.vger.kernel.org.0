Return-Path: <linux-fsdevel+bounces-21470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A61E904603
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 22:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33B6C28576A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 20:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214671527A1;
	Tue, 11 Jun 2024 20:57:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468B412E61
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jun 2024 20:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718139461; cv=none; b=Dg5h6oxojN6UEQAmTKASuKEc9cAIS2255tedRQE+Vfbh4f4AaTI1PQcamPBG0VQVPavM7d7QSAXT19jRuX7H9OJf0hpwIw3pJBmlieOS4fMzESug3O0AQajVvY0MoBowMBwYecgnf/Uf/SNKdGMUTMxdjwJaPW5T6/3JsFDO1vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718139461; c=relaxed/simple;
	bh=tLKAD0brpJBYNtwRhU/ZGRg+Bkx3Ih0yYHGeL7d05Do=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S2C3p0pKh7AIgXlREErTme6MbvHDv2g/Qn/FO5d+KXtgXZVsam/7Kr3mATbWENu+9akCv4WQeRAOaiWc4/+MAjuxUSMVmzlidDe1Rw98nQbIJkmijq64idcfc+g7jPIM7Vg+htnWrMPTORqZowSBz7tKxTDroZOcdmT3J+jU5kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-87.elisa-laajakaista.fi [88.113.25.87])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id 3b858a0a-2835-11ef-ab10-005056bdd08f;
	Tue, 11 Jun 2024 23:57:37 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 11 Jun 2024 23:57:36 +0300
To: Bart Van Assche <bvanassche@acm.org>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Daejun Park <daejun7.park@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: Re: [PATCH v9 11/19] scsi: sd: Translate data lifetime information
Message-ID: <Zmi6QDymvLY5wMgD@surfacebook.localdomain>
References: <20240130214911.1863909-1-bvanassche@acm.org>
 <20240130214911.1863909-12-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130214911.1863909-12-bvanassche@acm.org>

Tue, Jan 30, 2024 at 01:48:37PM -0800, Bart Van Assche kirjoitti:
> Recently T10 standardized SBC constrained streams. This mechanism allows
> to pass data lifetime information to SCSI devices in the group number
> field. Add support for translating write hint information into a
> permanent stream number in the sd driver. Use WRITE(10) instead of
> WRITE(6) if data lifetime information is present because the WRITE(6)
> command does not have a GROUP NUMBER field.

This patch broke very badly my connected Garmin FR35 sport watch. The boot time
increased by 1 minute along with broken access to USB mass storage.

On the reboot it takes ages as well.

Revert of this and one little dependency (unrelated by functional means) helps.

Details are here: https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/issues/60

P.S. Big thanks to Arch Linux team to help with bisection!

Note, from tomorrow I will be off from the HW in question for 2+ months, I can
test anything back in mid-August, but I hope you may do something about it
without my participation.

-- 
With Best Regards,
Andy Shevchenko



