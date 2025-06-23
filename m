Return-Path: <linux-fsdevel+bounces-52651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D44AE575A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 00:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78793170074
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 22:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3615225A23;
	Mon, 23 Jun 2025 22:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="RvBl1G0W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BBD222581
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 22:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750717684; cv=none; b=mMhlxOn2io7VtkIxfHiAusCrRP2ttM0SH9Ng+gqUIB1QKZTcMmsr1GNDuEJvIsUhBUg97VUK1GfANqbLGdqScUbL9hoF+XRl4hQv6ulemACj3h0aj2HnLeRcp3Mz744g/WuRAS23l4jiwb6xh63YDXScWw+XnuTAowQ5ORUHNPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750717684; c=relaxed/simple;
	bh=QtGrCeytbtFLBf1Bd02xO577WTDEXSM7/x2YRtL1r40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F9gRw8283zd83BBmcIs35tqgHZ6rHqDj44Ukyr9T1RPFj11ke+FGAOKs4WWRK4Kq1HbN7mhlBB0kNw0xKcsPg0PuGMGBTZC2r5g10HSnX73r/Df1ILowjOnWhEcwI1EtPmEYYWpduwDtxmdjh9ihGfJJTA65FaY0UQry1YkZYms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=RvBl1G0W; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DFXsSjLHkxRhRgUMECwumVx8dPlxEJjkXAHm6REKMAo=; b=RvBl1G0WSdAFadM811nqMyTBLh
	/IDGuuy0Wrl2efdNsCRZDPJwbuhex/xSPcEaZdxukcR7dVHJZlkdEqim4aET6wLjBx4QIuVlgL8CT
	7r2KyV4zu90hHzJlM4Nagu42ZM+YR9pnFXcOB2E//wNSD6wu8bZcdxq/Ylgxh72ubUc1BJupp42Fn
	CskYXlPTvVPtNzYfgoACso4MeC5D5HR1peKmA/7Q8PNWz5C5rxhz7KRMK0NmMrk6Ir/3/BoYRgwRA
	XkmMqRBVzqjWNdaIuCnihj4/tBmMittgQjg4CFwJ0h63X+aV3TZlUtjQp3kZIka6afkWSSULufmZu
	++eMXFjQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTpdw-00000001SJ9-3Fsm;
	Mon, 23 Jun 2025 22:28:00 +0000
Date: Mon, 23 Jun 2025 23:28:00 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: John Johansen <john@apparmor.net>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][BUG] ns_mkdir_op() locking is FUBAR
Message-ID: <20250623222800.GL1880847@ZenIV>
References: <20250623213747.GJ1880847@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623213747.GJ1880847@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jun 23, 2025 at 10:37:47PM +0100, Al Viro wrote:

> Better yet, have mkdir A/B race with rmdir A.  After dropping

mkdir A/namespaces/B vs rmdir A, sorry.

