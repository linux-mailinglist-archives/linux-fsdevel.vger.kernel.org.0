Return-Path: <linux-fsdevel+bounces-39745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13033A1741A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 22:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAE361884466
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 21:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807EA1EF0B8;
	Mon, 20 Jan 2025 21:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gpc6pxde"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7C41EE029
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2025 21:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737408396; cv=none; b=WnII+ZXDHn57PdQKNA1wi4RtSWCDFFo4D8/rBZThSaOa8E8hVVcSgdV6gsrEYzYlL/C25xxaOW9Q43ZkS6Bg1eyVIcbPM6CuEyqu56SHgEYNbqG7haG8PZK+0zeREB4R2jKHN1l0lyGIzkpfsI5hG2tkCl/32nA2AdILxELHha0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737408396; c=relaxed/simple;
	bh=H+3vaac2q1oXi2Voq08GOy34GbqWWixbbK/eHTbdMaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NZfdPv4Lc7PAfq6g6aw7/oymYz0hr+xbKMmWPX2usx8zF15a9vkXtNCa78iCJf39KylwlXXc4Tc8BhXWqaINBbou1+Y1YvQ3Kn3Ufg8cDu4ILT4/q4BV1bU0eHioHm+ryIyp2idfjnwAXZyRfwXzpb0/daF+nrdAzjlNz1MDTAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gpc6pxde; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737408392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B04i/gZ8lgb0zv2argciPqONFDUYHmh8OQrj2OyE9uo=;
	b=gpc6pxde/xrEkPV+4o073gUrF0Sg5RLP+rtnmImMqTrJt82EdjkpLCiN27+6cQcDpfdKUl
	JOJjnhCBMcG2KQl+areKIWGfohxluskRBszX8AmwyKlvhXQSqU8TK563InxerFGowZAo6N
	yxrJ9XGW6OJ9LxWBV12bYgK2Tg7+j8E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5-lXpB4fRHMqKvNM_Aia6CJg-1; Mon,
 20 Jan 2025 16:26:27 -0500
X-MC-Unique: lXpB4fRHMqKvNM_Aia6CJg-1
X-Mimecast-MFC-AGG-ID: lXpB4fRHMqKvNM_Aia6CJg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1EAC5195608A;
	Mon, 20 Jan 2025 21:26:25 +0000 (UTC)
Received: from [100.85.132.103] (unknown [10.22.76.4])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9B3231955BE3;
	Mon, 20 Jan 2025 21:26:21 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Shyam Prasad N <nspmangalore@gmail.com>,
 lsf-pc@lists.linux-foundation.org,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-mm@kvack.org,
 brauner@kernel.org, Matthew Wilcox <willy@infradead.org>,
 David Howells <dhowells@redhat.com>, Jeff Layton <jlayton@redhat.com>,
 Steve French <smfrench@gmail.com>, trondmy@kernel.org,
 Shyam Prasad N <sprasad@microsoft.com>
Subject: Re: [LSF/MM/BPF TOPIC] Predictive readahead of dentries
Date: Mon, 20 Jan 2025 16:26:19 -0500
Message-ID: <4A6F89B6-5E6C-4DFD-AC3A-CD80F6E4B1EB@redhat.com>
In-Reply-To: <CAOQ4uxjk_YmSd_pwOkDbSoBdFiBXEBQF01mYyw+xSiCDOjqUOg@mail.gmail.com>
References: <CANT5p=rxLH-D9qSoOWgjYeD87uahmZJMwXp8uNKW66mbv8hmDg@mail.gmail.com>
 <CAOQ4uxjk_YmSd_pwOkDbSoBdFiBXEBQF01mYyw+xSiCDOjqUOg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 14 Jan 2025, at 8:24, Amir Goldstein wrote:

> On Tue, Jan 14, 2025 at 4:38 AM Shyam Prasad N <nspmangalore@gmail.com> wrote:
>>
>> The Linux kernel does buffered reads and writes using the page cache
>> layer, where the filesystem reads and writes are offloaded to the
>> VM/MM layer. The VM layer does a predictive readahead of data by
>> optionally asking the filesystem to read more data asynchronously than
>> what was requested.
>>
>> The VFS layer maintains a dentry cache which gets populated during
>> access of dentries (either during readdir/getdents or during lookup).
>> This dentries within a directory actually forms the address space for
>> the directory, which is read sequentially during getdents. For network
>> filesystems, the dentries are also looked up during revalidate.
>>
>> During sequential getdents, it makes sense to perform a readahead
>> similar to file reads. Even for revalidations and dentry lookups,
>> there can be some heuristics that can be maintained to know if the
>> lookups within the directory are sequential in nature. With this, the
>> dentry cache can be pre-populated for a directory, even before the
>> dentries are accessed, thereby boosting the performance. This could
>> give even more benefits for network filesystems by avoiding costly
>> round trips to the server.
>>
>
> I believe you are referring to READDIRPLUS, which is quite common
> for network protocols and also supported by FUSE.
>
> Unlike network protocols, FUSE decides by server configuration and
> heuristics whether to "fuse_use_readdirplus" - specifically in readdirplus_auto
> mode, FUSE starts with readdirplus, but if nothing calls lookup on the
> directory inode by the time the next getdents call, it stops with readdirplus.
>
> I personally ran into the problem that I would like to control from the
> application, which knows if it is doing "ls" or "ls -l" whether a specific
> getdents() will use FUSE readdirplus or not, because in some situations
> where "ls -l" is not needed that can avoid a lot of unneeded IO.

Indeed, we often have folks wanting dramatically different behavior from
getdents() in NFS, and every time we've tried to improve our heuristics
someone else shouts "regression"!

We can tune the NFS heuristic per-mount, but it often makes the wrong
choice..  As you say letting the application make the call would be ideal.
POSIX_FADV_ ?

Ben


