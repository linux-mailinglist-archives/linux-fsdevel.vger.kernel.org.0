Return-Path: <linux-fsdevel+bounces-29716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FD897CBF1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 18:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA7021F21D98
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 16:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98B01A01CA;
	Thu, 19 Sep 2024 16:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b="NEvcd5Pe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx.manguebit.com (mx.manguebit.com [167.235.159.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7757712E78;
	Thu, 19 Sep 2024 16:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=167.235.159.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726761682; cv=pass; b=RNXCb1vfrPtT1CNg9j9crS0At2tgRygW69D4jUf3h13wzeEafb09F2JVLPard/G/zE1ahWu/W/SZjzJT6DD5jR0sd/v7+O9LELS82o4a8+kYDJC4gONVGeV3rCCPOr9zhzT9efWfKXTKnx6EPa0Zj2irt2r3dxUVLudl3htOI84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726761682; c=relaxed/simple;
	bh=9apZN3gdncchidJNMgRva76vAr6gjxwT+9Tj84xH6yo=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=qY1oBFnyKWHMv4qJ9vvy7chnO56c6OElTMojFb5LkO2GcrFdOkGwxdjoNBCJFAiXb+3dIKyYhkXuW/aEu3FHYoFE7WIvQlXtFrBEnjqQBSUQTtPm8LdVLa+P4fiIf93E8wqwxWHliJ/iuvSRnINb3OK8v5x1yNLeoFACd8uJ65E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com; spf=pass smtp.mailfrom=manguebit.com; dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b=NEvcd5Pe; arc=pass smtp.client-ip=167.235.159.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.com
Message-ID: <31d3465bbb306b7390dd7be15e174671@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1726761673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J5OEabVcJpXqlzpr09AtYa8XVKEt17KM+jff+BcSPVA=;
	b=NEvcd5PekX1vIQKRMxmsrSIe4iRG4GcBNX3yRuv4tINH1Tm1vrJhZ/7Orp25fdMfejUCPC
	TBQ+xzHsrakidO5vAaqp33ZmFY1f8m4RT3f+CjPYSowQYkFIoMOzkxrYAhJ6UQiwUwPzJP
	eN8lH0dEgwaHYYqBvk30ORFL42aTfFc25OHImIsH4Hbuiu803b39Qrwmi6tgVW4pYfxNfE
	mkW1uQa+QxCpg80RQSre7YgG323MCMzRHQGkW+SUsTSKAfHJlvF6j5u3pFUNIV1ykdZ9Rm
	W6YNbCiqhDoB7MHy0eJ21nQiMDJip8H1Wr43EfdZzScx8jcmsgVNC+B5QdF9pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1726761673; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J5OEabVcJpXqlzpr09AtYa8XVKEt17KM+jff+BcSPVA=;
	b=GTRJw95lKuh+lplAXllOy/GjP9ix5FLgo+OKxANGEByRUNGtNO+DDA56U1srdwxz0YiIRD
	dBe0fnSytmCe9qEa7wGjcCDgEcFvBecIeiw3qoZ8VbfFBIL7d+mQEq17K/5aG7/qtKlOdL
	Cymj/3h/yI/hzjKRhCZqzmLvoP+GdK8seCHB5N9qOM/IEz97IsU6WlBbSfZBSrGe7INkoL
	AC1WrNqq9rbOkU74c/Ov0O2oKEOUZU+u462Un4nJW8o6ooIGKNVcv8b0VtNK7EYLw+zXfK
	aeSqxADUwTAgOQCoYmbmMEPWm2Jjq/2dX08Is2pqEul6/sXiHcwDNmHHsZDSzw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.mailfrom=pc@manguebit.com
ARC-Seal: i=1; s=dkim; d=manguebit.com; t=1726761673; a=rsa-sha256;
	cv=none;
	b=ZrC1B9uyEceT34dunHzDViMw8XC+VM/XEenZ6k0PVBkZ+rjcyHgwmTvG6zvynCMmOE+SWD
	Pb2qtfIiBNXjMS17rVxKj8Kiz6hDLIa0cD2cgGaRyU2D1QdMiLwqUxUyX+sof4bX5CbDNB
	UaIS15yz5AMH++VXwNZy/WZUpRHSKnD75Vm0z+ShoF5GnuyGeBUXWMcgTbup0W7EkdVnI3
	RQl3zmrC66AyX//1p+rbe0V8j8lsVzqWxDk/yJVnD+snrDxL/6UGBs4DjSnhQsCkfX3Ctt
	plGRpG7ql4zSpVeIoc4CwfXq+pNjTfSt8gW0egM+GrCdBXN9ZwqF+UO8Rprj5w==
From: Paulo Alcantara <pc@manguebit.com>
To: David Howells <dhowells@redhat.com>, Steve French <stfrench@microsoft.com>
Cc: dhowells@redhat.com, Jeff Layton <jlayton@kernel.org>,
 linux-cifs@vger.kernel.org, netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cifs: Make the write_{enter,done,err} tracepoints
 display netfs info
In-Reply-To: <2390624.1726687464@warthog.procyon.org.uk>
References: <2390624.1726687464@warthog.procyon.org.uk>
Date: Thu, 19 Sep 2024 13:01:10 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Howells <dhowells@redhat.com> writes:

> Make the write RPC tracepoints use the same trace macro complexes as the
> read tracepoints and display the netfs request and subrequest IDs where
> available (see commit 519be989717c "cifs: Add a tracepoint to track credits
> involved in R/W requests").
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Steve French <stfrench@microsoft.com>
> cc: Paulo Alcantara (Red Hat) <pc@manguebit.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: linux-cifs@vger.kernel.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/smb/client/smb2pdu.c |   22 +++++++++++++++-------
>  fs/smb/client/trace.h   |    6 +++---
>  2 files changed, 18 insertions(+), 10 deletions(-)

Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>

