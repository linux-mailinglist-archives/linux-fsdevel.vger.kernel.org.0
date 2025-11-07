Return-Path: <linux-fsdevel+bounces-67442-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5250C403C1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 14:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5844942826F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 13:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798D031A813;
	Fri,  7 Nov 2025 13:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K10DaNeN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727C6433BC;
	Fri,  7 Nov 2025 13:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762523949; cv=none; b=M5a6VhZIK/yR+X7GI+jMZCoi1iLCFKYCoLo0iIuVYGDUrHaqKhwSFRLoRuwQLIuM5WDy4UCzLQ4S4yKmBIFXsjJr0wBeY8vSBBSrgzR6TJz/+h7O+gQUwjSf9TiRCXLQ0ltZAMkCjiD5HbtIFHc70ZVXsOEhSA6IYzSTl/Ft7Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762523949; c=relaxed/simple;
	bh=P6XUHOaJvjG29cBiZ2CB/0Yx4883pM3A3OrPUozDIX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZVCVMGwZn6YGKw/GNBtXcHKkfByKReuGdO4eAeMW5K7yv1kKCAgN3MFXUjhyvJIV1jp/r45tXAgtMHi7Q5gnDvqwFUD8esfFiXTqz3GreOn28MstLH3uKleamXliMot9u6v70X/01Q9ngcwJRhGc+8bJhVYu496jyHpCo0+TAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=K10DaNeN; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7dUWbgfOqkVn7S/pp573YtAkvotd2+0fUGiwiV5AgqE=; b=K10DaNeN6/TEZ/6YgKnQ+Vbx3L
	0aWGqAC12MgvdxL2ZfR0gB943XKed1B3yT1XIAf1qV6tx438EJSX2A1LvEFQ7kEAhfaOIHTkx6lHv
	68BMhmkCWqCx47VmHtMOoyULtrQIPcRZAOQEMtR2diuHf5qndB+MOe+zaaEfKVbqO/S+vuG1o1PDC
	vm4ABhl3RlJlP4VAYSC8CnGQitHuaci6YT/6RjAPTZVFIh0FVSiuG3lPMB3trP7+t8LyZu/VL+Nwm
	VPqhc6iPJMZpXyqWJKH42hvwZy74YDG7z1v5aShuTmluQwgRO9cVzXFBx74aS6ag+A+0+AtGviax2
	UhVbt6uA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHMzX-0000000HRec-3VPC;
	Fri, 07 Nov 2025 13:59:03 +0000
Date: Fri, 7 Nov 2025 05:59:03 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Brian Foster <bfoster@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/6] iomap, xfs: lift zero range hole mapping flush into
 xfs
Message-ID: <aQ37J1qqhhP2WXOX@infradead.org>
References: <20251016190303.53881-1-bfoster@redhat.com>
 <20251016190303.53881-3-bfoster@redhat.com>
 <20251105003114.GY196370@frogsfrogsfrogs>
 <aQtuPFHtzm8-zeqS@bfoster>
 <20251105222350.GO196362@frogsfrogsfrogs>
 <aQzEQtynNsJLdLcD@bfoster>
 <20251106233208.GU196362@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106233208.GU196362@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Nov 06, 2025 at 03:32:08PM -0800, Darrick J. Wong wrote:
> A harder question is: what would filesystems put in write_map for a pure
> read?  They could leave it at the default (null mapping) and the kernel
> wouldn't pay attention to it.

Please make them entirely separate iomap_iters, and allowing nesting.
That way no write map even exists for pure reads.


