Return-Path: <linux-fsdevel+bounces-60042-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB27B413A6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EA545E8278
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A247D2D4803;
	Wed,  3 Sep 2025 04:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vUc474dY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720441DE3DC;
	Wed,  3 Sep 2025 04:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756874823; cv=none; b=DaXy03vcbIeJB2Yq/9GpVWRYrC2XySuI5LzhXbVEqZSIMEo1wfCDf9GRoycXDMke2WOHC9t4R8KPd9PaPxWeiRBMjzmgMv1ZufIQ2KbP1FqycTFHZPYNy59cO+VX4G0xAFyQTPbK9WJDjZFuH0Jj29NZaGI8PY3N4SUCwoZ8fV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756874823; c=relaxed/simple;
	bh=Q6sLYZfbTF2EVDK67+GnWbAGy3UzZVGmyT0OpcGqbnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N5wYMf9KWmF6IKF2EPqmWfYdafYyYJ5neCBrHqF5mAASsxknQTaovfIoWNWMajp1Qs8GpFtqrdtyvNDbah8TITaS9ymAtJpg5QywpSNg/bgWhgZXCCx5/UtFXV8LVlSy//nqBq/wbLgsmNVdz4M7P1Hvcw/0RjBq6Peo3ncDSmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vUc474dY; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Oz+na+DDB0qci4Krf6kgl2+d1IC1NsN0QPDO6XJVDfE=; b=vUc474dYrwmNySav+vM3lsDLpH
	jUDoLv4Fjw+3UWTx5CY25Gp9VHD3c3B7zWcYUJE5f+Xl/Xdyr3H/nRhHkEm8Xx91s23QorubXifzO
	quLUCCP1bu/C8aowpigJqm4Osuc/AQARO+wxtacoM3s1CwJJJOtc/NoL8aANB6mzmPl847jEz9rwK
	oMmrG2de/ya8NMX1cvDVJz7lys6UI9X8DcQGpwta6Nvl8LAP5Hg1brF6K8sc2sBxvY6GWKsPa8G+4
	rmeWD6DnTon2c1/o7+wAnVbdy81TpUo97qq52No0BO2IOrr0zcm8PN2ncOxmbHLVRHnpXOsOSLTve
	oKYbJCdA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfOa-0000000FGiY-0yoh;
	Wed, 03 Sep 2025 04:46:56 +0000
Date: Wed, 3 Sep 2025 05:46:55 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Ranganath V N <vnranganath.20@gmail.com>
Cc: rdunlap@infradead.org, brauner@kernel.org, conor+dt@kernel.org,
	corbet@lwn.net, devicetree@vger.kernel.org, djwong@kernel.org,
	krzk+dt@kernel.org, krzk@kernel.org, kvm@vger.kernel.org,
	laurent.pinchart@ideasonboard.com, linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, pbonzini@redhat.com, robh@kernel.org
Subject: Re: [PATCH] Documentation: Fix spelling mistakes
Message-ID: <aLfIP0nXp06l6xcd@casper.infradead.org>
References: <A33D792E-4773-458B-ACF4-5E66B1FCB5AC@infradead.org>
 <20250903040043.19398-1-vnranganath.20@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903040043.19398-1-vnranganath.20@gmail.com>

On Wed, Sep 03, 2025 at 09:30:43AM +0530, Ranganath V N wrote:
> Thanks for the response. Do you want me to resend the patch by ignoring this?
> particular "serie".

No.  "serie" is obsolete and was clearly a typo.

