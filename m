Return-Path: <linux-fsdevel+bounces-49322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA39ABB073
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 May 2025 16:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33E101895A27
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 May 2025 14:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBCC21CA08;
	Sun, 18 May 2025 14:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Tkf+PaOP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2194E2CA6;
	Sun, 18 May 2025 14:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747577232; cv=none; b=HoBZepH39U6uGxnQsKBfmNLQselw1T9qpSYtT7JDSqoygOieLmhjhwvyWjsfN+pQp+gFTlrXibwETSBWGdCLc+Mj7r3NlqfKd/bpMQ0Tuox/039UrI7ucKnCnVN8HePFhbdOLJPxgE7iTVUOZjl2j774wCN599EmKn79sSAonmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747577232; c=relaxed/simple;
	bh=7ZUOy4zfzwtQfFECls1H0K0rWiwTK00K7JoofSWCwAk=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JEsvSEs6qY3FoKyRV1Qi2Aavl/lXDlQNrceFc+YsHoJFD89+xZh88a9i83oCe+sNgIiQLL2ez6xJPkKGKaDH0spZ7c9+JPbZCZxtRScitsdsfo88v/jX93Z5ODrS1ILsHsuk+o/JBJjYHL0pxD0/yMbBFNjTXnPiBTwrpp5H9Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Tkf+PaOP; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1747576921; bh=ySspec3YNrQpxYsv4pE3dYx/3DWUTev93a0NvHqCYAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Tkf+PaOP4+TjvyoUmtHWN4GO+oR5cw7jYpGd/9g+y8NWcLiy4o3h2w7+nGA65GoYQ
	 qVbYuar0HaUtMxQI7PMXkdzwZiH12EXLC8QQARXHCHIWFeUCWKey9lcCTP2yoceREM
	 cjUNP3sQrYge3JMV8tVk67hQQCWX6kP6py9uRPfM=
Received: from ctt.. ([219.143.130.140])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 798228B; Sun, 18 May 2025 22:01:57 +0800
X-QQ-mid: xmsmtpt1747576917tkneko3hr
Message-ID: <tencent_7A72A617DCA9854675A3B22B9C0B5F5E4E09@qq.com>
X-QQ-XMAILINFO: MapnONytPuzijWxJBHCc5PS93VZJwvuokpXoI5q/M+ZsDlZKJp5CVfAhqVZz1b
	 J4nce0pjPp6rvu1jW9ucyd0Ilc9eHXHfF1X6k8HRQV7PzhaWTnqammcFHeqrUzAyOJh//Ef6HrR3
	 GeYvjvinwpiiF3aCTUEhnfOgZmO3igKVLIZQuSHLL8+AlJ+yozztRpjG2aAVfHBn0AfNRtGaXoBB
	 BuAkEP/LMzqSMzWumhq/sOfy25wDzDVHRDqohC+/vBcE6CYwsm/QbPTgs9YBgmk/rvq/ZMEd1Tcp
	 fxJfHa+gOv6rqX3SNrZ39QPoTRNKkFZNZpMfWKQhxtu498djZJ7pcy/gAv2yBDUC6nAwaoh4a4mg
	 DZnqtfQYbWFflLFHs6INBVdeV5gwh8P+kQJ6k5YqkjX3BtkrmoCXsjaC7JhPgKeC942IX8u+ScUF
	 zX88Xkn2m+z0Uxb0/0bijildv3DNbJpBTJvOPd7yWzfwI8KJeCFzRP2eKkrf0/0H3dhuxMbAgm2e
	 PQS4YB8aL10fUGYRMfJH0GpDb95K19DrN6fjyZ7zbLaEOVpipNMrvBcIHC/WNk67d8ngYmDQjiDb
	 RUU/Z6vxaZnY5Ye7x0ybbS+jhtf2y8dwZvc86LBPQAMbYkpECcOWaR4a6A3o99PET4CGfJZJASoJ
	 dkF1sGSp5mP+9Zl3S+ahpoEUzbP7IaAtPTSNEtMfPzNnlQ7E4jUcLhVVJQdU7SVRgtcKgVBGIMTj
	 llvQ74gB4VtRXDwfJCkhpr+jopP3gsnFi6obNb81/pdRqZ/Xy76qO8Pn07mPvZHWRh1V/S8Shh43
	 Qjc17FhAt4RabMxkkmTwNhoFkLx9ZiphYu/08NsVducxF4+3iPqeIl/Q5+YxNKW0cOSvtHb1JY8Z
	 ihcw8+ADlLhUZi23vFSlMsZOXTZi1Gbrud6oCBn7ac6eR8+MHQZ6Oodwwt2/ccbEiuqhsAtCavDY
	 /QajZEBPWGbWKj7UMGogvJL+EImqr48Jx0A3ZjSPefRFeE1UIt4iij6duxQ7GW4maNWNzH4K3Gti
	 iowD5bqIqGWCC75+C7S0Fxt+tt5U3xU/NSZuueawLJ6b6j9/xXiVlj79vPCk1ZaFSIzr/voVUuwT
	 V2lMuN
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Taotao Chen <chentao325@qq.com>
To: hch@infradead.org,
	tytso@mit.edu,
	willy@infradead.org
Cc: adilger.kernel@dilger.ca,
	akpm@linux-foundation.org,
	chentaotao@didiglobal.com,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 1/3] mm/filemap: initialize fsdata with iocb->ki_flags
Date: Sun, 18 May 2025 14:01:57 +0000
X-OQ-MSGID: <20250518140157.20878-1-chentao325@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aCSxc7TnJzP-n2Lk@infradead.org>
References: <aCSxc7TnJzP-n2Lk@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Christoph, Matthew, Ted

Thanks for the suggestions.

Replacing file with iocb in write_begin(), updating call sites,
and adjusting i915/gem usage makes a lot of sense. I’ll send a
v2 to reflect this change.

Thanks,  
Taotao


