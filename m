Return-Path: <linux-fsdevel+bounces-32546-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A849A9686
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 05:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF9F62847A7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 03:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794DA13C8F4;
	Tue, 22 Oct 2024 03:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NggfWXyY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E894322A;
	Tue, 22 Oct 2024 03:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729566398; cv=none; b=pnEAO/JtMTvCY235zK8oBFdWhqU1GxlUlRA2sEeknhWxmWGx493TwY8ValoCyXukaO0IUtgy2abkdqNXy5A6CKT/oi2yKiOD+fXbg96sMNsPjbhT7VMoUQKt/OPdFmRvapTHt9VIrdgg7JRj0bdMRGhfr5zpJg1zd/HczJ5wlTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729566398; c=relaxed/simple;
	bh=Pdj6kXiEu2uGZ0LuXnPEeFujTzUCsth+MkAeAwOml2M=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=dGVFxIfAO5+JghjPTTH2s/le+AW9NsepW3IGQWeGPxPXnwy1NXUw4/h8QRFMPZqrCh7yzUKKankhPydy5o9uQc5UaDoT5OfMgjo/fBsCFIiPtCLWIA6rKbwXPfsPuWoMzFmH9jy9JvdqdLEGeFUpnd+gOr870PouJzwjooYBa+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NggfWXyY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63BF2C4CEC3;
	Tue, 22 Oct 2024 03:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1729566398;
	bh=Pdj6kXiEu2uGZ0LuXnPEeFujTzUCsth+MkAeAwOml2M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NggfWXyYP0PLz8NPZXXLKvtCHBOCCUHJXIA791VBnfM5S43KFnylELeAOIU7G2AuL
	 BEW8cUiNFq6PaoOmq/MK+SmL8Qu69m2puY1HIXO2lKmM5M5fYArC67wGmpVdUKHTie
	 y13EZL8CT913+ZhvQL8OUOUJTE+rrtGvnIzZ+0Hc=
Date: Mon, 21 Oct 2024 20:06:36 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Paul Moore <paul@paul-moore.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Roberto Sassu
 <roberto.sassu@huaweicloud.com>, Liam.Howlett@oracle.com,
 lorenzo.stoakes@oracle.com, vbabka@suse.cz, jannh@google.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 ebpqwerty472123@gmail.com, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
 eric.snowberg@oracle.com, jmorris@namei.org, serge@hallyn.com,
 linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
 bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
 syzbot+1cd571a672400ef3a930@syzkaller.appspotmail.com, Roberto Sassu
 <roberto.sassu@huawei.com>
Subject: Re: [PATCH v2] mm: Split critical region in remap_file_pages() and
 invoke LSMs in between
Message-Id: <20241021200636.308f155a72f8a4d1e26f82b8@linux-foundation.org>
In-Reply-To: <CAHC9VhQP7gBa4AV-Hbh4Bq4fRU6toRmjccv52dGoU-s+MqsmfQ@mail.gmail.com>
References: <20241018161415.3845146-1-roberto.sassu@huaweicloud.com>
	<CAHC9VhQP7gBa4AV-Hbh4Bq4fRU6toRmjccv52dGoU-s+MqsmfQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Oct 2024 11:34:08 -0400 Paul Moore <paul@paul-moore.com> wrote:

> >  mm/mmap.c | 69 +++++++++++++++++++++++++++++++++++++++++--------------
> >  1 file changed, 52 insertions(+), 17 deletions(-)
> 
> Thanks for working on this Roberto, Kirill, and everyone else who had
> a hand in reviewing and testing.
> 
> Reviewed-by: Paul Moore <paul@paul-moore.com>
> 
> Andrew, I see you're pulling this into the MM/hotfixes-unstable
> branch, do you also plan to send this up to Linus soon/next-week?  If
> so, great, if not let me know and I can send it up via the LSM tree.

In the normal course of things I'd send it upstream next week, but I
can include it in this week's batch if we know that -next testing is
hurting from it?


