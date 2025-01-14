Return-Path: <linux-fsdevel+bounces-39149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 222AFA10A2B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 16:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B11E7A344F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 15:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445C3157485;
	Tue, 14 Jan 2025 15:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b="Uf7ZmyHK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx.manguebit.com (mx.manguebit.com [167.235.159.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B9F158531
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 15:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.235.159.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736866903; cv=none; b=Zb3+5yAan4SW7RQQ+S8Ii2ytzw0sbGV66I2KYdnHYzybyApi1GjaUTg3/YebZLMXs8JPb/qH95D0kQbx44cylyt2YmRDlMBloCEdtJbpde+HEN5V5DAz1icYEQQKanqKuPPxruSQRqW8omQ68pcG2QS7BkZ++GXD7g3BtrbsLZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736866903; c=relaxed/simple;
	bh=Uswn3LNPnFxj4MhYD3S5lhOLiJ3rridcbMI1Q7nSoeg=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=pYf6psZHuDVarVIR0PZvoMhIKZ8IwfzGVHvOPOoxxgonqr2Yea8+3j8BMxrvC76gFMBwVUNf1iqOKyUbTFweupDGD63xSahyxK4D9XHwKCICbMPXJU3W47KI+fApgIMYo4fmNNurGAJTZi8AFapZfLpsaGTmci1+KSRik3aYDiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com; spf=pass smtp.mailfrom=manguebit.com; dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b=Uf7ZmyHK; arc=none smtp.client-ip=167.235.159.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.com
Message-ID: <dbc41d4c3113c0e3a7915d463ddcb322@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1736866899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uswn3LNPnFxj4MhYD3S5lhOLiJ3rridcbMI1Q7nSoeg=;
	b=Uf7ZmyHKAkdRXahsoWD410eaGLOaBe/6YSqJb+a/rRsBgfix0bHyiQ7yanuth+uwTHC95F
	qW8bv5WV+tnBj0b0HgtMMn5JGlvc1L5Zf3ma5ENrueprOjXUXg/Khl/XEH9GrvV0yuDTDr
	nVChqmMudj8tLbfHnJvc96/jZK5sDFezwTcFqhSQb20etjJyv3kbW/iS1P23rnKlCratKV
	ABzSyUKHVZ+PMUo8MWH7lj11X/7Ua/mWCRrdfvWQ9SGJJaZgA9KA2d1Ck4pfexloZH7mXp
	JZzE/FG+64yL4E8gzU9dsxo1YdUQ9d/lFeJOT94j9q86nRLtImC2Mz3Dnzdkhg==
From: Paulo Alcantara <pc@manguebit.com>
To: Benjamin Coddington <bcodding@redhat.com>, Amir Goldstein
 <amir73il@gmail.com>
Cc: Shyam Prasad N <nspmangalore@gmail.com>,
 lsf-pc@lists.linux-foundation.org, linux-fsdevel
 <linux-fsdevel@vger.kernel.org>, linux-mm@kvack.org, brauner@kernel.org,
 Matthew Wilcox <willy@infradead.org>, David Howells <dhowells@redhat.com>,
 Jeff Layton <jlayton@redhat.com>, Steve French <smfrench@gmail.com>,
 trondmy@kernel.org, Shyam Prasad N <sprasad@microsoft.com>
Subject: Re: [LSF/MM/BPF TOPIC] Predictive readahead of dentries
In-Reply-To: <460E352E-DDFA-4259-A017-CAE51C78EDFC@redhat.com>
References: <CANT5p=rxLH-D9qSoOWgjYeD87uahmZJMwXp8uNKW66mbv8hmDg@mail.gmail.com>
 <CAOQ4uxjk_YmSd_pwOkDbSoBdFiBXEBQF01mYyw+xSiCDOjqUOg@mail.gmail.com>
 <460E352E-DDFA-4259-A017-CAE51C78EDFC@redhat.com>
Date: Tue, 14 Jan 2025 12:01:36 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Benjamin Coddington <bcodding@redhat.com> writes:

> On 14 Jan 2025, at 8:24, Amir Goldstein wrote:
>
>> On Tue, Jan 14, 2025 at 4:38=E2=80=AFAM Shyam Prasad N <nspmangalore@gma=
il.com> wrote:
>>>
>>> The Linux kernel does buffered reads and writes using the page cache
>>> layer, where the filesystem reads and writes are offloaded to the
>>> VM/MM layer. The VM layer does a predictive readahead of data by
>>> optionally asking the filesystem to read more data asynchronously than
>>> what was requested.
>>>
>>> The VFS layer maintains a dentry cache which gets populated during
>>> access of dentries (either during readdir/getdents or during lookup).
>>> This dentries within a directory actually forms the address space for
>>> the directory, which is read sequentially during getdents. For network
>>> filesystems, the dentries are also looked up during revalidate.
>>>
>>> During sequential getdents, it makes sense to perform a readahead
>>> similar to file reads. Even for revalidations and dentry lookups,
>>> there can be some heuristics that can be maintained to know if the
>>> lookups within the directory are sequential in nature. With this, the
>>> dentry cache can be pre-populated for a directory, even before the
>>> dentries are accessed, thereby boosting the performance. This could
>>> give even more benefits for network filesystems by avoiding costly
>>> round trips to the server.
>>>
>>
>> I believe you are referring to READDIRPLUS, which is quite common
>> for network protocols and also supported by FUSE.
>>
>> Unlike network protocols, FUSE decides by server configuration and
>> heuristics whether to "fuse_use_readdirplus" - specifically in readdirpl=
us_auto
>> mode, FUSE starts with readdirplus, but if nothing calls lookup on the
>> directory inode by the time the next getdents call, it stops with readdi=
rplus.
>>
>> I personally ran into the problem that I would like to control from the
>> application, which knows if it is doing "ls" or "ls -l" whether a specif=
ic
>> getdents() will use FUSE readdirplus or not, because in some situations
>> where "ls -l" is not needed that can avoid a lot of unneeded IO.
>
> Indeed, we often have folks wanting dramatically different behavior from
> getdents() in NFS, and every time we've tried to improve our heuristics
> someone else shouts "regression"!

In CIFS, we already preload the dcache with the result of
SMB2_QUERY_DIRECTORY, which I believe NFS does the same thing.

Shyam, what's the problem with current approach?

