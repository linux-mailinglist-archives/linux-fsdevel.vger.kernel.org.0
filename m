Return-Path: <linux-fsdevel+bounces-70149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5A8C929D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 17:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D5D424E2056
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 16:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EC929ACF6;
	Fri, 28 Nov 2025 16:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="NKRQIs/S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FE3284889
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Nov 2025 16:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764348649; cv=none; b=qyx8jj++hAalKgJVUBW5IQ8OGJ7eoBsN+WM87guSPM0jP1Klqk+mmYDxO1zq/6MGxHPBcyD/F4OmcHD2E14J9ilZZpLei3qPRFbC0gaHtWPxZNSPM3ZgMEetutUdIp0fgkYwfpNR4AXOmAjZ9UUkJMhixnY2uy/FO3fofm/qH3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764348649; c=relaxed/simple;
	bh=Fy3In8ULemnFIoSuLPP7pX1ZC8TC8ExWoz00SEFLRi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KLnXu+1U9lhALan73qDIRjUKk9dt+2AZwciXc2TmKQx7Eo8Af5RDLsqt5fHajYekOFv6qNDxILxcVQB6gtYrLfKATfg1jBIU4AVA7PD/vZmhHcP6IYIZGi0C0Q+NcRnelaLEcMB3SyT303WCOYTKrRo+jmNJeayY2G3dkVMmSxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=NKRQIs/S; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org ([12.17.7.130])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5ASGnxgY023597
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Nov 2025 11:50:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1764348602; bh=q9jN6fQfkx/KyFHet/wN+pflZ1Zh3vcBg8XYhFcoHKo=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=NKRQIs/SzL6q3RHL+vXAc6BIyJLZK0NmmNlDEeixEuWSK7yEyNI7TdWJ8XbCKgOxq
	 tlJq6rSZScfNhQ6cShc1/W4hUpAuQteDV+VIMVA8wuIYVpioFlKNdK8P6svULVQNp4
	 VOHwjfkAP8hywmMNi3woFQ3Sfm3PmhjVG8yCb40NGo2qwpgG9cE20J5/3aZmPBLu/x
	 O9OjM11Lg/gWESmiZNeqzyHoQoJyRwsAuubsvpHHqk6QBlXA6OoWiiQrU5gTcoB7kn
	 QYEKRk8KSUc71G/a1QuImPi1UD1oG79TFqoQShsvuYWImXdk7qlSM2LRVfWmnLPXIZ
	 nU3QRJD8iZyNw==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 28D8C4D4AD84; Fri, 28 Nov 2025 10:49:59 -0600 (CST)
Date: Fri, 28 Nov 2025 10:49:59 -0600
From: "Theodore Tso" <tytso@mit.edu>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yizhang089@gmail.com, libaokun1@huawei.com,
        yangerkun@huawei.com
Subject: Re: [PATCH v2 00/13] ext4: replace ext4_es_insert_extent() when
 caching on-disk extents
Message-ID: <20251128164959.GC4102@macsyma-3.local>
References: <20251121060811.1685783-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121060811.1685783-1-yi.zhang@huaweicloud.com>

Thanks to Jan and Ojaswin for their comments and reviews on this patch set.

As you may have noticed this version of the patchset is currently in
the ext4.git tree, and has shown up in linux-next.

Given that we have some suggested changes, there are a couple of ways
we can handle this:

1) Zhang Yi could produce a new version of the patch set, and I'll
replace the v2 version of the patch set currently in the ext4.git tree
with a newer version.

2) We could append fix-up patches to the ext4.git tree to reflect
those changes.

3) I could drop the patch set entirely and we apply a later version
of the patch series after the merge window.

What are folks' preferences?

Thanks,

						- Ted

