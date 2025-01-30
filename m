Return-Path: <linux-fsdevel+bounces-40453-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 836ADA23750
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 23:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41AC43A6A9E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 22:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA5A1F130B;
	Thu, 30 Jan 2025 22:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="qhz+CEhX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716993987D;
	Thu, 30 Jan 2025 22:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738276676; cv=none; b=Ye6jMtcIyli/UlU8zMA/qr6UR0QuNpfDDDByOH0ZoY/DRGfCYB+C4ZsEOYLWRZepS9o4ywZTg2wupPENQqK3YHeJJO/SWepht6KR06cRVYTYMcbV0nkwA4UgI/nBDazIZT7CGcb1c6Qc7BMyRBu9CopU7jbCfhj0Rz7WQNK6zKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738276676; c=relaxed/simple;
	bh=RsT+cN+IqZrca/sfcUXS4hAuAouyjftXrA3xfHri/m8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=lu6NzDLcVebsfV249LefiSTTB/r4mMMAxPdX049CxT8QmdpgIP4oR671kaV33UAkp6/l0qwsOM2qoYQOeZSTkasQKGjncumv/72mhcPQ84Dg+k5YqrFDY+j545Iq1/BFCL4/2wYqg7ZnpnGyoZjcFQZ79rZFJxayV3nCOu6eEac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=qhz+CEhX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D887C4CED2;
	Thu, 30 Jan 2025 22:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1738276675;
	bh=RsT+cN+IqZrca/sfcUXS4hAuAouyjftXrA3xfHri/m8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qhz+CEhXICkn0jM8lJT8fdw57VIsg72Lz0XhZHpDVAWpeM2PKCSs1x7elh59mqcJU
	 vXJwfAUj/PYIeBgmH7lalHq3R2muaTnviixMFnft70NgqqKKJbxOr6d/DbMoV3Oi22
	 kOFWUI8NEtokisuK+fCLAVpZ4LpfVx/d8Zp4kbnQ=
Date: Thu, 30 Jan 2025 14:37:54 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Christian Brauner <christian@brauner.io>, Shuah Khan <shuah@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan
 <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 pedro.falcato@gmail.com, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, Oliver Sang
 <oliver.sang@intel.com>, John Hubbard <jhubbard@nvidia.com>, Tejun Heo
 <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Michal Koutny
 <mkoutny@suse.com>, Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH v7 0/6] introduce PIDFD_SELF* sentinels
Message-Id: <20250130143754.1b8bb87bfb15175dd434529b@linux-foundation.org>
In-Reply-To: <cover.1738268370.git.lorenzo.stoakes@oracle.com>
References: <cover.1738268370.git.lorenzo.stoakes@oracle.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Jan 2025 20:40:25 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> If you wish to utilise a pidfd interface to refer to the current process or
> thread it is rather cumbersome, requiring something like:
> 
> 	int pidfd = pidfd_open(getpid(), 0 or PIDFD_THREAD);
> 
> 	...
> 
> 	close(pidfd);
> 
> Or the equivalent call opening /proc/self. It is more convenient to use a
> sentinel value to indicate to an interface that accepts a pidfd that we
> simply wish to refer to the current process thread.
> 

The above code sequence doesn't seem at all onerous.  I'm not
understanding why it's worth altering the kernel to permit this little
shortcut?

