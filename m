Return-Path: <linux-fsdevel+bounces-51981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BF4ADDE78
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 00:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ACC217291F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 22:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1531F1DF75B;
	Tue, 17 Jun 2025 22:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="pw7TAtuQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF15CA6F;
	Tue, 17 Jun 2025 22:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750197686; cv=none; b=OuyBIX5sehngVjJ6PeRa4vuGmvXkjKqr1Yk2R5PWNptoWiMgeYXij7EYuC0Jn9gC9NDtPwNxglkrLCNJsuMtZuIcOPo3txWMfo0MTX+l7LUpxbHvlAUVR4W5eLK4C6x2qF0r5FD9CzK15M8LL2YOSV+Sq5suOuEDfHOJ5L2X084=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750197686; c=relaxed/simple;
	bh=98OltrgXlSIY+zJivzsdMUugbC523DqhsfawekZg9a8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eW388EvJoTN3AfcN3j0BKeHy/gCORJTeZaWhSk0qcGkaTkQts0SpA3gVLVjOF3K0f19nSdNTruNKa+fBY2SMo918Kr8aVf56iAe9k8XlCJ3xhF0KiFB/x5QRaVM1YInOSx21Ns7U9q9OBn1FGNpxFArWlq+RAiB10dmCQjb0Um0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=pw7TAtuQ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9FMT2FpjdQo0FAdhbwycFRbupTNyRdJb2Vkr2XVSKqY=; b=pw7TAtuQKFDTsrWyKI93zDkl2d
	BefezzL9pVcV4neiYzYD9FamEJrWAMjMFQEXnMKgiDYsJlvgXh4ILB/0cR/rwCIWBecVpO+bmORY/
	ODnbTB3w6YRi9G0jNUyvd5ThY2FSCqww6BG/ET8xGx999ef5JGdOCQb3H2nZzVdGf6MXbkE/wTxg6
	Gz09uCx+sIcWlzLQ3tcMPYGeDNWLnQQKm0PbO2FX/FrP6gRRSchCu1Wb4mZJjfSu2hCJ/WAlZ+dyh
	woqDqlWCRHZjdkHf4fYB2OEZYgpOOdWNcNM6bFazAOt9Z47Tg4rpBV8m48hVvitWLlahCvV26/S2r
	+axfU6IA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uReMs-00000001Q0T-1uHx;
	Tue, 17 Jun 2025 22:01:22 +0000
Date: Tue, 17 Jun 2025 23:01:22 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Subject: Re: [PATCH 3/3] ceph: fix a race with rename() in
 ceph_mdsc_build_path()
Message-ID: <20250617220122.GM1880847@ZenIV>
References: <20250614062051.GC1880847@ZenIV>
 <20250614062257.535594-1-viro@zeniv.linux.org.uk>
 <20250614062257.535594-3-viro@zeniv.linux.org.uk>
 <f9008d5161cb8a7cdfed54da742939523641532d.camel@ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9008d5161cb8a7cdfed54da742939523641532d.camel@ibm.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Jun 17, 2025 at 06:21:38PM +0000, Viacheslav Dubeyko wrote:

> Tested-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

OK, tested-by/reviewed-by applied to commits in that branch, branch
force-pushed to the same place
(git.kernel.org:/pub/scm/linux/kernel/git/viro/vfs.git work.ceph-d_name-fixes)

Would you prefer to merge it via the ceph tree?  Or I could throw it
into my #for-next and push it to Linus come the next window - up to you...

