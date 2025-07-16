Return-Path: <linux-fsdevel+bounces-55086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C5DB06D27
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 07:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9C991C20051
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 05:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FBC27990E;
	Wed, 16 Jul 2025 05:22:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDC9221FB1;
	Wed, 16 Jul 2025 05:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752643347; cv=none; b=Eij9BihHMx+erXV1D+wGvJa59v5j4yeisKvGNBk0MOuC42Zpbq9ue/eN1uiJqm2Yj58lgyPtiWTISoMUk447ZbXJG0Mps63fLkNjw8lTUnn1q1qYJyai50sesJjDgTf+V5hBUmlUCXFH5lUfNyj6vKlEqQ3mCVX/JXiUV2eu9RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752643347; c=relaxed/simple;
	bh=3uv1zx3kclCGkKtEHzbYC3eiKbUpQOH1Ffju3cC8Zgw=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=jpjqpJyIIKTEa0RTfMkg6rHYjBjG+/eZIT6DxEejuiPbQW0B5HdEVfcAWE5ngR7tcXSej9xyfxY5iXtSmGVPgw41GUs8qGgIebJaqoEQSYlLlD4IOQEtOAq3sV8qac7CyviWcg3UJ5OdYKWCtWOrMQaTTCQPfeh4XK8tiIFyVTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ubuay-002BJl-RX;
	Wed, 16 Jul 2025 05:22:22 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Namjae Jeon" <linkinjeon@kernel.org>, "Steve French" <smfrench@gmail.com>,
 "Sergey Senozhatsky" <senozhatsky@chromium.org>,
 "Tom Talpey" <tom@talpey.com>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] smb/server: various clean-ups
In-reply-to: <20250608234108.30250-1-neil@brown.name>
References: <20250608234108.30250-1-neil@brown.name>
Date: Wed, 16 Jul 2025 15:22:22 +1000
Message-id: <175264334224.2234665.14956053645355864817@noble.neil.brown.name>


Hi,
 did anyone have a chance to look at these - no replies and they don't
 appear in linux-next ??

Thanks,
NeilBrown
 

On Mon, 09 Jun 2025, NeilBrown wrote:
> I am working towards making some changes to how locking is managed for
> directory operations.  Prior to attempting to land these changes I am
> reviewing code that requests directory operations and cleaning up things
> that might cause me problems later.
> 
> These 4 patches are the result of my review of smb/server.  Note that
> patch 3 fixes what appears to be a real deadlock that should be trivial
> to hit if the client can actually set the flag which, as mentioned in
> the patch, can trigger the deadlock.
> 
> Patch 1 is trivial but the others deserve careful review by someone who
> knows the code.  I think they are correct, but I've been wrong before.
> 
> Thanks,
> NeilBrown
> 
>  [PATCH 1/4] smb/server: use lookup_one_unlocked()
>  [PATCH 2/4] smb/server: simplify ksmbd_vfs_kern_path_locked()
>  [PATCH 3/4] smb/server: avoid deadlock when linking with
>  [PATCH 4/4] smb/server: add ksmbd_vfs_kern_path()
> 
> 


