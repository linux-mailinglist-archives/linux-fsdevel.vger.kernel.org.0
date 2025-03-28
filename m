Return-Path: <linux-fsdevel+bounces-45183-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 512E5A741FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 02:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A0403B63EB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 01:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023951C5D63;
	Fri, 28 Mar 2025 01:18:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0D7A93D;
	Fri, 28 Mar 2025 01:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743124701; cv=none; b=Hgcp4ktD2L+vs3+oVygpsxB8YVfGpRAGDwxBoWjaYCU/9cU7W5wlTrH0IWVdRlmLPVcyntM4T4hXkK98CEfZuxrMY7zfx2yVeejyWlTVf1ykEvEvejv5B8vNjhjp0xdajkvJtHlH15akxB7Qdhfqb2EzCiftUtUduhr0n8kD1tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743124701; c=relaxed/simple;
	bh=3tv+9sVfsxVpQxZpnbHOLZtbXCpdS07eLrspxL6SaKg=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=jkzk1YACxIHLuYozr7QPvKgaoru5yqkmi3eHjD/fzGHp0UMvA4ZXkoquUnNYCIPSei2kt2uvkI6ritUSa8AfHklBViyuH5Din4OxvvWlFZFmm18PADdsNwleNFKnGQ2yOaJ894d/9HIPmqabZ9PH6bQJ4NcldF6pbNyY2zAVsq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1txyMS-001t5k-UX;
	Fri, 28 Mar 2025 01:18:16 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "David Howells" <dhowells@redhat.com>
Cc: dhowells@redhat.com, "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 linux-nfs@vger.kernel.org, netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/6] VFS: improve interface for lookup_one functions
In-reply-to: <3170778.1742479489@warthog.procyon.org.uk>
References: <>, <3170778.1742479489@warthog.procyon.org.uk>
Date: Fri, 28 Mar 2025 12:18:16 +1100
Message-id: <174312469657.9342.13122047478058505480@noble.neil.brown.name>

On Fri, 21 Mar 2025, David Howells wrote:
> NeilBrown <neil@brown.name> wrote:
>=20
> > Also the path component name is passed as "name" and "len" which are
> > (confusingly?) separate by the "base".  In some cases the len in simply
> > "strlen" and so passing a qstr using QSTR() would make the calling
> > clearer.
> > Other callers do pass separate name and len which are stored in a
> > struct.  Sometimes these are already stored in a qstr, other times it
> > easily could be.
> >=20
> > So this patch changes these three functions to receive a 'struct qstr',
> > and improves the documentation.
>=20
> You did want 'struct qstr' not 'struct qstr *' right?  I think there are
> arches where this will cause the compiler to skip a register argument or two
> if it's the second argument or third argument - i386 for example.  Plus you
> have an 8-byte alignment requirement because of the u64 in it that may suck=
 if
> passed through several layers of function.

I don't think it is passed through several layers - except where the
intermediate are inlined.
And gcc enforces 16 byte alignment of the stack on function calls for
i386, so I don't think alignment will be an issue.

I thought 'struct qstr' would result in slightly cleaner calling.  But I
cannot make a strong argument in favour of it so I'm willing to change
if there are concerns.

Thanks,
NeilBrown

