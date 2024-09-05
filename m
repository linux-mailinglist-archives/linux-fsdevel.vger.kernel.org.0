Return-Path: <linux-fsdevel+bounces-28672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9216896D06F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 09:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49C9C1F24970
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 07:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB56C193090;
	Thu,  5 Sep 2024 07:32:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from c.mail.sonic.net (c.mail.sonic.net [64.142.111.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0230192B70
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Sep 2024 07:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.142.111.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725521561; cv=none; b=lOIYwFJZ3+R4aPqm+p8FUokhOEXiiUWZCpB1j+B0r88vsZlf/sfgCeZLkV6STWUDkpvyCKjEVITvFlUU6XoOWme2Cm8uNndhRFV3wQj7wEY8wPfnmfhwlVRWOQj7W4NkAryEWj5tHHqyTroqIy1noEf9RHOj7RkzNtDUIbMP+Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725521561; c=relaxed/simple;
	bh=o3QfTXtx+QwlMAQ/BMqmMMnCRNn91qiNcjn0vQfY8QA=;
	h=From:To:Cc:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=XHLoFbafkheqbIMco4OApCZkozt4/pvrovWNn8xaP+Y9H/8swz0btz/ChKKMjgB61lIaPZl4Ula/mmhSMgKDO3BQ8tlmTDKyqk6GQJ0TzcfwObD60YyAGFFPQTIFeJF36cVpd7VZr9mQRT2N+ZJlMuRQSwn7FlmJej/5NGRy1XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nom.one; spf=pass smtp.mailfrom=nom.one; arc=none smtp.client-ip=64.142.111.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nom.one
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nom.one
Received: from 192-184-189-150.static.sonic.net (192-184-189-150.static.sonic.net [192.184.189.150])
	(authenticated bits=0)
	by c.mail.sonic.net (8.16.1/8.16.1) with ESMTPA id 4857WbwI023364;
	Thu, 5 Sep 2024 00:32:37 -0700
From: Forest <forestix@nom.one>
To: David Howells <dhowells@redhat.com>, Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Cc: linux-cifs@vger.kernel.org, netfs@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [REGRESSION] cifs: triggers bad flatpak & ostree signatures, corrupts ffmpeg & mkvmerge outputs
Date: Thu, 05 Sep 2024 00:32:37 -0700
Message-ID: <6jnidjladjose5gvv7nmofs008dlrd4cn3@sonic.net>
References: <1dihdj9avrsvritngbtie92i5udsf28168@sonic.net> <pv2lcjhveti4sfua95o0u6r4i73r39srra@sonic.net> <2450249.1725487311@warthog.procyon.org.uk>
In-Reply-To: <2450249.1725487311@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Sonic-CAuth: UmFuZG9tSVbvGf0QMMU2+heqAt9XXWwBTS5z4XYZxovm2+6kZYki/pAW4WyerkjOMMmI5x7lyt+q2EGN3oFQ+jiklWoCbC25
X-Sonic-ID: C;NPMwBllr7xGxjc+N3bHVhw== M;gIdGBllr7xGxjc+N3bHVhw==
X-Spam-Flag: No
X-Sonic-Spam-Details: -0.0/5.0 by cerberusd

On Wed, 04 Sep 2024 23:01:51 +0100, David Howells wrote:

>Forest <forestix@nom.one> wrote:
>
>> Write corruption still exists in 6.11.0-rc6.
>
>Can you try adding this:
>
>	https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c26096ee0278c5e765009c5eee427bbafe6dc090


That patch looks promising. With it, I've run my tests 2-3 times more than
usual, and there has been no sign of the corrupt writes so far. Thank you!

>Unfortunately, it managed to miss -rc6 because Linus released early before the
>PR could be sent to him.

Will these fixes be applied to the 6.10 series as well?

