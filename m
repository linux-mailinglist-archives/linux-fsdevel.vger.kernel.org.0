Return-Path: <linux-fsdevel+bounces-28656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C072896C964
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 23:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D1831F22762
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 21:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C97084047;
	Wed,  4 Sep 2024 21:12:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from c.mail.sonic.net (c.mail.sonic.net [64.142.111.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAB213D28F
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 21:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.142.111.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725484360; cv=none; b=sil3yD8kto9x8W2C0QCmijbCj5gyHtSEyuox723uycuXH0CVX5XfPPGLBrQ+I9K2VFOEL3HF3ueSnoRd9JqElzK842b0thjDo1jzKPIyDsLOsjZct5dyhxnnlOXYfjNlPKhWkw4T4ftDQBpgg9Gis2l6pGELTdH9C2FvVaYhndo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725484360; c=relaxed/simple;
	bh=guLfzvzHe/Ar8KjiPmsJlEXy+TxFLF80tnd+JVKmu0E=;
	h=From:To:Cc:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=hZM78U/AfuFZjFQc1VVNaJn+0e67cDwKEaobVmnct5GsLC15Qy53V+poW5v4j6sq8copwtbiqG7PWFM5fZhFttxsqwoN0C0iSL5frE/cPnFbt18vDmUwh8iFPLo35pFwXmfMKo+VVY6bzJKFTdm7fFQRl+n6QzT+QlV6KWAC2jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nom.one; spf=pass smtp.mailfrom=nom.one; arc=none smtp.client-ip=64.142.111.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nom.one
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nom.one
Received: from 192-184-189-85.static.sonic.net (192-184-189-85.static.sonic.net [192.184.189.85])
	(authenticated bits=0)
	by c.mail.sonic.net (8.16.1/8.16.1) with ESMTPA id 484L28aW000373;
	Wed, 4 Sep 2024 14:02:08 -0700
From: Forest <forestix@nom.one>
To: David Howells <dhowells@redhat.com>, Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Cc: linux-cifs@vger.kernel.org, netfs@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [REGRESSION] cifs: triggers bad flatpak & ostree signatures, corrupts ffmpeg & mkvmerge outputs
Date: Wed, 04 Sep 2024 14:02:08 -0700
Message-ID: <1dihdj9avrsvritngbtie92i5udsf28168@sonic.net>
References: <pv2lcjhveti4sfua95o0u6r4i73r39srra@sonic.net>
In-Reply-To: <pv2lcjhveti4sfua95o0u6r4i73r39srra@sonic.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Sonic-CAuth: UmFuZG9tSVbf6qhAFZ29YVsyvEy6C+n4FasBrjvR+o3aEgrO/1vOqvbzlOlEcb+NyztygbtXqMYqLA8TJlo1h/NIWayd8fSz
X-Sonic-ID: C;1leg8gBr7xGvzM+N3bHVhw== M;Igyv8gBr7xGvzM+N3bHVhw==
X-Spam-Flag: No
X-Sonic-Spam-Details: -0.0/5.0 by cerberusd

On Sat, 24 Aug 2024 18:50:40 -0700, Forest wrote:

>I think I have found a cifs regression in the 6.10 kernel series, which leads
>certain programs to write corrupt data.
[...]
>3ee1a1fc39819906f04d6c62c180e760cd3a689d is the first bad commit

Write corruption still exists in 6.11.0-rc6.

Bad ostree signatures may be fixed in 6.11.0-rc6. (My reproducer didn't
trigger it in that version.)

