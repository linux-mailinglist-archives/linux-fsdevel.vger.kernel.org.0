Return-Path: <linux-fsdevel+bounces-39380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFD4A132B4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 06:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C244A16693F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 05:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BE215B135;
	Thu, 16 Jan 2025 05:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tNVlfNOG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF88B7346F;
	Thu, 16 Jan 2025 05:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737006151; cv=none; b=FCbwqljE4EJv121h7HarpXMB1Sd49haVQrJ8ofrk8X5T343rG0baOcD3UN5keK1FoEWo5XcIK8jS5GDE+/PSDWsXXUSSM4ZaQ39bZxfKj9PtCDPQ8FccLHvk3Bvas55aMwXWe2zvBFDH9FgZFED4VLWheUPKZG5/+rCxqKNnc48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737006151; c=relaxed/simple;
	bh=qBtIqKbPYLQDzRLYEL+GnEA4r0PMl400HhRevUspdqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRRftLjdztCCNjI5n3JcQmaWPHtyK1V+tDU2daKUZo029Zz8EwtvvAUvLQuljYh1P7+mz5yshwFHgxrCIrQwNGCOmW+fs46kOCFH4eoy1DeTD/MDwznZ1Wy59aEC7Fpq7PFRxvTyWH1AMTqLtsdf0sS6jKp5OSBl1OHOcpFvBGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tNVlfNOG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=oq12XYVIy0vKReS7B9XEMqCqZJpn3crY8ZLl/z7O9oQ=; b=tNVlfNOG8A7NCs5Sn+R3RSzibx
	+440KJlre66dy38PFNq+PZLV+39uq6ASK+KxOmF5w/vAP5RrLoUf9JzPuRFJ1l0bSr7didGcpFdOd
	52ymXzxFgciQS4OM1T5x+V+2RCnWR79F3q7JP6Sp15FLmq3oevtSYUJautd3nDOE1aORAdf+PNHs/
	RUSx51HIObTfSxiuQvWlCUD0NRrnIxbWouZmUe/GnWy9T3KBnJnQKbOkbvS1aFh3x9B4JbB8T58RF
	LSf8Ubnitec6VMqJmmL3bIlpoobaroq4ONIImCIOFqOLr9b3lSIh+6j8QYobBCryuCOKjF2UEtR5J
	iVTR4Q7g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tYIeD-0000000Dtl7-1Um9;
	Thu, 16 Jan 2025 05:42:29 +0000
Date: Wed, 15 Jan 2025 21:42:29 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Anna Schumaker <anna.schumaker@oracle.com>,
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] Implementing the NFS v4.2 WRITE_SAME
 operation: VFS or NFS ioctl() ?
Message-ID: <Z4icRdIpG4v64QDR@infradead.org>
References: <f9ade3f0-6bfc-45da-a796-c22ceaeb4722@oracle.com>
 <Z4bv8FkvCn9zwgH0@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z4bv8FkvCn9zwgH0@dread.disaster.area>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jan 15, 2025 at 10:14:56AM +1100, Dave Chinner wrote:
> How closely does this match to the block device WRITE_SAME
> (SCSI/NVMe) commands? I note there is a reference to this in the
> RFC, but there are no details given.

There is no write same in NVMe.  In one of the few wiѕe choices in
NVMe the protocol only does a write zeroes for zeroing instead of the
overly complex write zeroes.  And no one has complained about that so
far.

