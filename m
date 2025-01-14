Return-Path: <linux-fsdevel+bounces-39140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7B3A108CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 15:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFCBE7A1536
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 14:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B590613B7A1;
	Tue, 14 Jan 2025 14:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hZxA7bkb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7638223242D
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 14:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736863989; cv=none; b=ZBnjW5PDDeU+k/hhpiOb4eAyoS2a4CWCUbeypiWfOxS/8KhC4ztjvm45qQUkaRipJRuxuX2ohqp1fwsNR5kLNedNvvBc+U6N46a5u282PLrp3nocKkCoqSA7xZ2NYaXn8C9XpcUPPUolL6vE1yBQHStMuROzW9CLF5K3FFaOAn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736863989; c=relaxed/simple;
	bh=H+3vaac2q1oXi2Voq08GOy34GbqWWixbbK/eHTbdMaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fqz1kOPuubbV5v5eqHln1T100UGguUTNOTm0GThS0G/8Cegija8eQDG54DD/HV+ko3Xf+uEM1Tz/zRzgqLZGWMQJ8TdVGAh1wc70G3Sb9Kv1OnvadrqU7pQsLlxBRR18HjADLTUwG+rHBT3gEKGVMYNxFgZvmm/MRwijKqqaHTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hZxA7bkb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736863986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B04i/gZ8lgb0zv2argciPqONFDUYHmh8OQrj2OyE9uo=;
	b=hZxA7bkbaTNlJjmbVNEdx1Ay7sHBbL0AEdi1udlPbskPEWelgOCUHYDznEGzl3LTdaeqWF
	p2i5dOdkl/ow5aJf/6FAJJ67DyxoVGeAoSvDUeRKGXtWhEovQEbPVYg6XvrvFlEUTjKhtY
	jyo+h2s1qWt0oKNP4CcBE8wYvy8BpDs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-324-GmAEdh9ENC6QwlqhKjVq9w-1; Tue,
 14 Jan 2025 09:13:04 -0500
X-MC-Unique: GmAEdh9ENC6QwlqhKjVq9w-1
X-Mimecast-MFC-AGG-ID: GmAEdh9ENC6QwlqhKjVq9w
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 648AA1955DC0;
	Tue, 14 Jan 2025 14:13:02 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.76.4])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1476219560A3;
	Tue, 14 Jan 2025 14:12:58 +0000 (UTC)
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
Date: Tue, 14 Jan 2025 09:12:57 -0500
Message-ID: <460E352E-DDFA-4259-A017-CAE51C78EDFC@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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


