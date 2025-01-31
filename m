Return-Path: <linux-fsdevel+bounces-40465-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE17A2392B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 05:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F24B43A8FCD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 04:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2487D13AD26;
	Fri, 31 Jan 2025 04:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="PCPw4qxx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACE112CD96
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jan 2025 04:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738298442; cv=none; b=jnpmRz4Z0caIKjfkU2Zs1ia45wIOE1y1EAFTwyt966IEvx+4GGQSsxFH582+N9l2yOX+CjEIJ1gdaLvC4JXx3D28Pi1mgrNodHHbvyRu3jUhB6Gj4qTJuH1sKwoO2q4dpR6pFA4rhYRot20diVKiCvuHM+kGmFTqL46UeUc6iOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738298442; c=relaxed/simple;
	bh=UCGyZjQy6WQrIu39YraJAcmxRCphUxJx3w6t9kNiL8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RAzN2kqYzvnjC7v2L3fGRAf2nNK4PxIY6c+VdWu+GEOaKqrkwIGBPIkL+2C4SvejC3PsZe7nrNbepod2jGdP7qH8XXj751vYrlIBkxMyEWVy3QVkBx6/dkct6goNBBPgYqx5JS2jlbWOULTMiQHfGIkuuzsNhySl80FpQYKmaNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=PCPw4qxx; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org ([12.221.73.181])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 50V4eFhe029357
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 23:40:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1738298419; bh=NIu5WVUHGLf9gfdTWvOvNK/xFsqLPRxW7J/Q8nhUDO0=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=PCPw4qxxsROGw2PX/NHKbAd85xP/Eidk7VIu5PmPz2yaHhuHymcZRPeRp1kJsika/
	 BmqpzMAIc0jLKRf6+bbvE5E3gSl2Oyl8hUwV8oRXF6TdPdRuZc8wqkpOHi4Xd7ZlUE
	 Ke23JkbUo3zBiBMJtO0oWIxFqFoyNZh33Ap7QBgCm4hdFFxMs6pWx00dp/YfquqtT7
	 EazfVXTezzvo0+RmgElK4dTsjdsBLIEC6oXdnSbMl9i+iXFCVjf4tjCB/Tjhv9jz30
	 sBGW4sSgoDuRMfKYGvk6yaYyF0rdvp4UNqoP8IIZxgYEyuR7izjO2NZZjZD4jLQh/5
	 YZieu+n0RShxQ==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 0DD8B344FF0; Thu, 30 Jan 2025 20:40:15 -0800 (PST)
Date: Thu, 30 Jan 2025 20:40:15 -0800
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>, lsf-pc@lists.linux-foundation.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        josef@toxicpanda.com
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] File system checksum offload
Message-ID: <20250131044015.GB416991@mit.edu>
References: <CGME20250130092400epcas5p1a3a9d899583e9502ed45fe500ae8a824@epcas5p1.samsung.com>
 <20250130091545.66573-1-joshi.k@samsung.com>
 <20250130142857.GB401886@mit.edu>
 <yq1r04knj7a.fsf@ca-mkp.ca.oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1r04knj7a.fsf@ca-mkp.ca.oracle.com>

On Thu, Jan 30, 2025 at 03:39:20PM -0500, Martin K. Petersen wrote:
> It already works that way. If a device advertises being
> integrity-capable, the block layer will automatically generate
> protection information on write and verify received protection
> information on read. Leveraging hardware-accelerated CRC calculation if
> the CPU is capable (PCLMULQDQ, etc.).

So I'm confused.  If that's the case, why do we need Kanchan Joshi's
patch to set some magic bio flag and adding a mount option to btrfs?

      	     	  	    	     	    - Ted

