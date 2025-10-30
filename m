Return-Path: <linux-fsdevel+bounces-66429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1144CC1EA4E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 07:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A1FA4E6FA5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 06:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E7732E757;
	Thu, 30 Oct 2025 06:55:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38098330B3A;
	Thu, 30 Oct 2025 06:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761807310; cv=none; b=MJVSsMsCrjweCa3ZvFfMODb/sPhoFgqEBWKJTCYXxWZtiyvhf7OUeHoYxdz5H4ze/sgbSBF3qaa8D1uidkrKP4KMNg/V7ulFP4Faaqv+wtGU/4uZDQ7wQBSue7Bm/wgrlxTZ33FtSOnAUo6gsWPMmU2gIGYU2eb2WKOGJvxz7Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761807310; c=relaxed/simple;
	bh=6n7XV+piCArqedH5FjXxGpsUWElW+qTSY+amqnEK8sM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/Rb/tIbsAoAzPb3jTLAEjdP62ti3oJqhdTX89ARo7LiqWd/IOS0Ys2StUyV6fjpU6MsCVMuPg4YbL2XBzNtZ46VtgZAtFkP7+wI8BV/BnnEtbdd1L4pDUZvqRPJqcQdwv3erCV93xe891tBYyDum9vq8wANQiyRgo8z5nssI+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id EA87D227AAA; Thu, 30 Oct 2025 07:55:04 +0100 (CET)
Date: Thu, 30 Oct 2025 07:55:04 +0100
From: Christoph Hellwig <hch@lst.de>
To: Qu Wenruo <wqu@suse.com>
Cc: Christoph Hellwig <hch@lst.de>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/4] xfs: fallback to buffered I/O for direct I/O when
 stable writes are required
Message-ID: <20251030065504.GB13617@lst.de>
References: <20251029071537.1127397-1-hch@lst.de> <20251029071537.1127397-5-hch@lst.de> <20251029155306.GC3356773@frogsfrogsfrogs> <20251029163555.GB26985@lst.de> <8f384c85-e432-445e-afbf-0d9953584b05@suse.com> <20251030055851.GA12703@lst.de> <04db952d-2319-4ef9-8986-50e744b00b62@gmx.com> <20251030064917.GA13549@lst.de> <a44566d9-4fef-43cc-b53e-bd102724344a@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a44566d9-4fef-43cc-b53e-bd102724344a@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Oct 30, 2025 at 05:23:32PM +1030, Qu Wenruo wrote:
>> So what is your application going to do if the open fails?
>
> If it can not accept buffered fallback, error out.

Why would it not be able to accept that?


