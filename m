Return-Path: <linux-fsdevel+bounces-59632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2246DB3B7B1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 11:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8A553B4031
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 09:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC64264A90;
	Fri, 29 Aug 2025 09:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ELsS7ac9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902921F55F8
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 09:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756460975; cv=none; b=DqqFRNkfMsq8p/ImXGwBZBwCYdcPHEScQDzWPWlwEygjXvEI4M6LNW1jy/tbsCkLWVDmlQaUWjT/RIqZEcJ9am75u4T0TLPQq0U7fAzS+puzt9yHsImQ6QvLzowbQY03sNoZlhdaAYMR5QTQ4CpnblV7KeVe0OsGz+h9KaUWw64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756460975; c=relaxed/simple;
	bh=S4mJM0awfxC5kDVcLjJ/EV4kKU7GJPip6aWBEkbtP+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fDRfnp/h79AyaoUbCXghA55B5QxBkjXIMSfTnGVQhuf3qRNuh/ZWYjXEdP+lZlvwQF19u4NZHIxeeBKMKr8p8C4hVdF1wfToOcntxiUSuserBYyDHa2/u2OyZAebyXRS4umLoa3ARX0DKvgCgiTOWZq6Eo6TPO6GVqJ3pgJVrWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ELsS7ac9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A15C4CEF0;
	Fri, 29 Aug 2025 09:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756460975;
	bh=S4mJM0awfxC5kDVcLjJ/EV4kKU7GJPip6aWBEkbtP+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ELsS7ac9DBlEi2bhRf6bpFnfCrNJizBUk3yijCa0XOTK9e7SO6WEVJQowNp/l2PHQ
	 qbw54X0blMQqm3G6Mgsx4+XMCDxmR4RJ1LyEOkkz1egj25SMYsAciutcA9x+VF8Cn1
	 ID8zfUD8gJkTsfeYZSVJUafPkRsmEJw/omn1JpxEgxyn/T6dDeabVxY2xhCFQmylBW
	 qrUAifAOEzjq/856O/nzpN7mzw8HLEULJ/5waaP+7rqt210g49OYudfWyNBXqvPt1Y
	 5QOsvhFdeWMbZlFJm22bdKdGLJ22Z5zwsNh+xfEdNsut6JrUmV4ldv2wFcHCXfaqu0
	 joy7KF3fVuThQ==
Date: Fri, 29 Aug 2025 11:49:31 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH v2 13/63] has_locked_children(): use guards
Message-ID: <20250829-ethik-neider-31c8b9230af3@brauner>
References: <20250828230706.GA3340273@ZenIV>
 <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
 <20250828230806.3582485-13-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250828230806.3582485-13-viro@zeniv.linux.org.uk>

On Fri, Aug 29, 2025 at 12:07:16AM +0100, Al Viro wrote:
> ... and document the locking requirements of __has_locked_children()
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

