Return-Path: <linux-fsdevel+bounces-42155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 811AAA3D4EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 10:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FDDC7A5A00
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 09:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91D11F03EA;
	Thu, 20 Feb 2025 09:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="B9nNp1Kj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331001F03D3
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2025 09:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740044247; cv=none; b=VLaEc8VWfJjClyD9o6QMoyrgHrGfvFuGEUfHSlBmdKkkjsHFnqpctgaCi18GzBQ/jDCNRpRwPircZP1HEW0RtWRUsVQj2myxSSV3Jq5JjNf7JInX3quKVGzPZq89itq8QTjgFuJbiiqYFACB+sKAMcAicJLjAWsXNbnQuyLl3RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740044247; c=relaxed/simple;
	bh=Zm9lcTFIuefAMNw1nCB+oawkK/6nd23DDWGDq3hZ+Og=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H4+MrFGT8ISbsxV85DoauJF0gNwaFc/zk6CRPHi3K5DSGgmB0UQ1PqMxiV+sn45MjND6kU+VZFyU+Zel/5BCQFu47VpZ14JpWsRTISWRPoa+92xyXjNrWxH8laH4F1lZ0I+RwbH8Oia/57nz8H5pdzvhGuus82HPcmMFBzhgNkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=B9nNp1Kj; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=mU8lW38cQIahWA8UM+45YRP4XAvQLqSXRVOqOVBwWyc=; b=B9nNp1KjpNGflpfNEefIoGJJVU
	6Ylu7bDlVOkfs2p7p8N9XsoxJH4dpxNpiXPtc1moZxIpJRTmiVDzCtFJKR1KGtwztUU+jA4pEKQnW
	DEq4aEbmppn+STAEjrOfduQc0t+2lonPCd7Z5j5rhOP8Mv2XWzAiUTY+tKpfwbyGmlD0aBHI3KL0K
	QCYoEuM4MR8ky2LmUoLhl3TjbpS4a132AATeGvqJwV5vMy7WOhSpuXwECt3diDpYMdl0OGFrhJrFB
	1LUynlssV0MRp3FHK4noYg2VERPwqYN6qAA/9Vu3kROaz3P3b7jiSme42538TvHgTkCEa14pSEYnb
	AqTeuPNw==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tl2zU-00FGrv-Ia; Thu, 20 Feb 2025 10:37:14 +0100
From: Luis Henriques <luis@igalia.com>
To: Sam Lewis via fuse-devel <fuse-devel@lists.sourceforge.net>
Cc: miklos@szeredi.hu,  Sam Lewis <samclewis@google.com>,
  bernd.schubert@fastmail.fm,  linux-fsdevel@vger.kernel.org
Subject: Re: [fuse-devel] Symlink caching: Updating the target can result in
 corrupted symlinks - kernel issue?
In-Reply-To: <20250219195400.1700787-1-samclewis@google.com> (Sam Lewis via
	fuse-devel's message of "Wed, 19 Feb 2025 19:54:00 +0000")
References: <CAJfpegvVtao9OotO3sZopxxkSTkRV-cizpE1r2VtG7xZExZFOQ@mail.gmail.com>
	<20250219195400.1700787-1-samclewis@google.com>
Date: Thu, 20 Feb 2025 09:37:07 +0000
Message-ID: <87h64p7y9o.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19 2025, Sam Lewis via fuse-devel wrote:

> Hi Miklos.
>
> I work at Google on the Android team, and we have a build system that wou=
ld
> benefit greatly from the kernel symlink cache. In my testing, I can easily
> reproduce the truncation using the steps outlined by Laura. I tested your=
 patch
> and have confirmed it fixes the bug.

Oh, wow!  I've tried to reproduce the issue myself and I've been failing
miserably.  Are you using CVMFS as well, or can you reproduce it with some
synthetic fuse server?  I've tried both approaches but no luck so far.

Cheers,
--=20
Lu=C3=ADs

> What steps need to be taken to merge your fix? Can I help in any way?
>
> Thanks,
> Sam Lewis
>
>
> --=20
> fuse-devel mailing list
> To unsubscribe or subscribe, visit https://lists.sourceforge.net/lists/li=
stinfo/fuse-devel


