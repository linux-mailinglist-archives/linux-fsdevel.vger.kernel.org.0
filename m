Return-Path: <linux-fsdevel+bounces-47214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 449B2A9A753
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 11:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE0279249DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 09:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37695212FAB;
	Thu, 24 Apr 2025 09:04:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D031DED49
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 09:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745485490; cv=none; b=dF+wG4v73eVojsmmI9T93XRp7wLSt+ohpp3TxaoRvMKQny/1FWLAgvcWQq6th8042w2GiO3B20BNFJ8XzmERjG+Kp+yHvaLry2qJkhTASPJOBVR8k2cIVAwozsdDv+fIUKoKHzRqUWvOcTudZ4HuS4+M+WTlD1kvxUba2j0ayvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745485490; c=relaxed/simple;
	bh=bue5WpVun4B9S+HVpjhE5qGsr5X5XLeRx8NkPiJaJBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LusABaxu9o2o5pq29gH3P4EWgJeVVys65D0PVdgJryNUR85xvh2EQJ2Q15gcUHX4SnEIKQeZ6c+sgDlDeE4hEzQkwTw0b2RfEYSmgdiZ9PNwLOBNUTtUhOm5wLl63s699ZtWLaWjoV8s0Zq09On13dVTd541Z5KjW+D2kflATYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8F7C867373; Thu, 24 Apr 2025 11:04:44 +0200 (CEST)
Date: Thu, 24 Apr 2025 11:04:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Revert "fs: move the bdex_statx call to
 vfs_getattr_nosec"
Message-ID: <20250424090444.GA27439@lst.de>
References: <20250424-patient-abgeebbt-a0a7001f040b@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424-patient-abgeebbt-a0a7001f040b@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Apr 24, 2025 at 10:59:44AM +0200, Christian Brauner wrote:
> This reverts commit 777d0961ff95b26d5887fdae69900374364976f3.
> 
> Now that we have fixed the original issue in devtmpfs we can revert this
> commit because the bdev_statx() call in vfs_getattr_nosec() causes
> issues with the lifetime logic of dm devices.

Umm, no.  We need this patch.  And the devtmpfs fixes the issue that
it caused for devtmpfs.


