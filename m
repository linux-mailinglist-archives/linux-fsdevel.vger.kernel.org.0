Return-Path: <linux-fsdevel+bounces-50323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 095A1ACAE48
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 14:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 565FF7A79FD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 12:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9531E215F6B;
	Mon,  2 Jun 2025 12:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dyH9LZKy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34C85227
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Jun 2025 12:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748868595; cv=none; b=DfezfnYZR9s+ML4u8ToA1hbZrzH+eUT148UI/47gWgs+fn/mYPFkCqG+cSUMbSwkj+yaDCamAuo34JUdp7ujcffYgyKxleNWE4E4wswsU96nSgs71YnzopeZZXKKtID1GVNr/VrzooTtD9OANaEUT5QUBVRPwOkxtOBXUPWw66I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748868595; c=relaxed/simple;
	bh=Qkme7WDrxMQRysddPwynrwcLtOYzpoGqjuXWlSrrMl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0WCuUZjAFIg2dgWsbM5fqS14Li8HJG/sm9OzxC/mGNY5QNSA91C82Fc1HCOFL7PInSOrRz2p7vrcIR9xqjCzEtYOuGQ8uOwCbpcyDkTm+/iLPWdeko63wp1OhL4O/pADMzGgZITsLRhdZ5eF04fJFC4NSWfEycUtJ+02JDXVD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dyH9LZKy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 184E0C4CEF1;
	Mon,  2 Jun 2025 12:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748868594;
	bh=Qkme7WDrxMQRysddPwynrwcLtOYzpoGqjuXWlSrrMl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dyH9LZKy+gwXwqHHSl3c9+A8lnZ5FeLM1vAM7bZGkS/ilRj1lNfazt7kUEm+PCnMW
	 GwPehfLDbCaK4elcaBSeEgzdsLeOxCJIKAhPWCM1xZ3t0TVVonAcnokhyaIqG3754k
	 SCZQx6kY9WKYmBzfH6fewA0Wb1MSza/tObkWRhEU=
Date: Mon, 2 Jun 2025 14:49:32 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Luca Boccassi <bluca@debian.org>, stable@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: Please consider backporting coredump %F patch to stable kernels
Message-ID: <2025060246-backlit-perish-c1ab@gregkh>
References: <CAMw=ZnT4KSk_+Z422mEZVzfAkTueKvzdw=r9ZB2JKg5-1t6BDw@mail.gmail.com>
 <20250602-vulkan-wandbild-fb6a495c3fc3@brauner>
 <2025060211-egotistic-overnight-9d10@gregkh>
 <20250602-eilte-experiment-4334f67dc5d8@brauner>
 <2025060256-talcum-repave-92be@gregkh>
 <20250602-substantiell-zoologie-02c4dfb4b35d@brauner>
 <20250602-analphabeten-darmentleerung-a49c4a8e36ee@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602-analphabeten-darmentleerung-a49c4a8e36ee@brauner>

On Mon, Jun 02, 2025 at 02:32:24PM +0200, Christian Brauner wrote:
> v5.14

Nit, the stable tree is "5.15", not "5.14" :)

I'll see if I can make this work...

Thanks for all of these, and thanks for adding back the upstream git
ids, that helped a lot.

greg k-h

