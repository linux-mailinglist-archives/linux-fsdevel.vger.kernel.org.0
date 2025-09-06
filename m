Return-Path: <linux-fsdevel+bounces-60450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4A0B46B68
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 13:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78B171B26241
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 11:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E0827C875;
	Sat,  6 Sep 2025 11:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wm5qGOur"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468C1136E37
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Sep 2025 11:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757158385; cv=none; b=ejMvRWuk22fU7D78cRDKu/Nk6dYxkhDvBBbMnlIMapCvRhmUMgM7GTL9xSTS1XjET1BU0kTJ8x9vZstoRaUv/8J6XvqHwInIKusM3weIgh6pamche3gG6XHdqmALOYEP+Ie7Bx8qAmKWMuHRD4LWFqnSfNSh2vGRbf4hb66uzlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757158385; c=relaxed/simple;
	bh=2V7/sZ21I2f5P1OwC6qaeh2zfojZfG9GmAn4/1l1IWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E4N4pWMj8ktPJI3sYYZuIf9RQLP9Lr+X/E7BpPI8YmIYUmYlKmPf3Tqt/MaLzQ710WJxKcMDvs+TZa2NTKCxYgV7iIPEh8UHicWPua3LQRKOUkU2a+kkyfa8QnwL1w+mlj7XONwYz2zKtrCJEyMpOeKwMdZH9JBfrvrUPxCrQSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wm5qGOur; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 565D0C4CEE7;
	Sat,  6 Sep 2025 11:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757158384;
	bh=2V7/sZ21I2f5P1OwC6qaeh2zfojZfG9GmAn4/1l1IWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wm5qGOurh9js5cx5quUyJwURBYN3xu9bNAAePhO5Jx51iTLhBwp38T7ilolRkW/JC
	 /JWlO4iQ1xb5PWf4yQuaJgi8qJA9it3kmA6ucIC1VR4jIXsBkrnAC7psAGKBa524/S
	 q7Dnsr5hpifk4FulQ3J/IibtMW/CWNbTUaGA3G9o=
Date: Sat, 6 Sep 2025 13:32:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "k.chen" <k.chen@smail.nju.edu.cn>
Cc: security@kernel.org, slava@dubeyko.com, frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org, glaubitz@physik.fu-berlin.de,
	wenzhi.wang@uwaterloo.ca, liushixin2@huawei.com
Subject: Re: [PATCH] hfsplus: fix slab-out-of-bounds read in hfsplus_uni2asc()
Message-ID: <2025090630-undercut-modified-3805@gregkh>
References: <20250906100923.444243-1-k.chen@smail.nju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250906100923.444243-1-k.chen@smail.nju.edu.cn>

On Sat, Sep 06, 2025 at 06:09:23PM +0800, k.chen wrote:
> The previous fix (94458781aee6) was insufficient,
> as it did not consider that
> sizeof(struct hfsplus_attr_unistr) != sizeof(struct hfsplus_unistr).
> 
> Fixes: 94458781aee6 ("hfsplus: fix slab-out-of-bounds read in hfsplus_uni2asc()")
> Signed-off-by: k.chen <k.chen@smail.nju.edu.cn>

Please use your name and not your email address for the
"signed-off-by:" name portion.

thanks,

greg k-h

