Return-Path: <linux-fsdevel+bounces-47069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B061DA983C5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 10:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B0C91B61978
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 08:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1B5274658;
	Wed, 23 Apr 2025 08:33:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04811DFE20;
	Wed, 23 Apr 2025 08:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745397203; cv=none; b=bKqtCN427eZpcohv7YermRuElSBDv5jCXLf6IZ4SFXASJnrqvr5y+5cEpP9dkyOQAcWwaDbyNwgIoCAt7zEqcMdGm3erfQCL5BqqRpHwgy2hYbrj6AW3qaoGNX6d/V6GcbSVuxTXxIO2zog5JROkoWBLeaSpeGuQV2qnMZ8idik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745397203; c=relaxed/simple;
	bh=3ji8kguHaQU3S4gdvl7lTdpGzqqUxIrkl1k+i/cBe0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W2EMSmhJ661zJLtFqt9JsNtmEI1AhyRFOtaMFl+4AhAl+zP3BjJ5jFqz/aou34jaN1rqBn016pxC+F5oo1yh955DcyFlqdFI0h57zzq1qH6fyRD2JrbdYM3aYObQz//0WclcnHDccUT9oZSp2q2whXMfrk/ENcVM7FQIIM1pFbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1769C68AFE; Wed, 23 Apr 2025 10:33:17 +0200 (CEST)
Date: Wed, 23 Apr 2025 10:33:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>,
	brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	cem@kernel.org, linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v8 05/15] xfs: ignore HW which cannot atomic write a
 single block
Message-ID: <20250423083317.GB30432@lst.de>
References: <20250422122739.2230121-1-john.g.garry@oracle.com> <20250422122739.2230121-6-john.g.garry@oracle.com> <20250423003823.GW25675@frogsfrogsfrogs> <f467a921-e7dd-4f5b-ac9f-c6e8c043143c@oracle.com> <20250423081055.GA28307@lst.de> <f27ea8f7-700a-4fb1-b9cd-a0cba04c9e47@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f27ea8f7-700a-4fb1-b9cd-a0cba04c9e47@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Apr 23, 2025 at 09:28:14AM +0100, John Garry wrote:
>> But maybe we should just delay setting the atomic values until later so
>> that it can be done in a single pass?  E.g. into xfs_setsize_buftarg
>> which then should probably be rename to something like
>> xfs_buftarg_setup.
>>
>
> How about just do away with btp->bt_bdev_awu_{min, max} struct members, and 
> call bdev_atomic_write_unit_max(mp->m_ddev_targp->bt_bdev) [and same for 
> RT] to later to set the mp awu max values at mountfs time? I think that 
> would work..

Sounds reasonable.

