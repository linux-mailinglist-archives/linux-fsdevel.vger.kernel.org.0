Return-Path: <linux-fsdevel+bounces-1739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7C77DE261
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 15:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AE651C20C96
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 14:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598B913FEC;
	Wed,  1 Nov 2023 14:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d4s8Bc5l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFF1101EC
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 14:29:35 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB6DDE
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 07:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698848969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V/7fAHV54bvUhDq0mC+8WSk6QrBbV5zrQG4RsRFgQ80=;
	b=d4s8Bc5lbh9IUlPnJMXbGIpbdzN5J2Z6IaZkVrHwteEhGkug50nQPbu+LcFVIELdSzTYRM
	b9D3UOb1TFrE0uRgL/fhil/NQB122ivdEVC8NXWIDv6tGHEKar+Xx38wu/v+eIPFg05cVW
	Jsw+svNZESvrBweSIFcOlBEl1rscws4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-0cZVZa6MOm2x0hHFFzmdOg-1; Wed, 01 Nov 2023 10:29:13 -0400
X-MC-Unique: 0cZVZa6MOm2x0hHFFzmdOg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3FD1185A58C;
	Wed,  1 Nov 2023 14:29:13 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.50.5])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 30E78C1290F;
	Wed,  1 Nov 2023 14:29:11 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
 Olga Kornievskaia <kolga@netapp.com>
Subject: Re: [RFC] simplifying fast_dput(), dentry_kill() et.al.
Date: Wed, 01 Nov 2023 10:29:10 -0400
Message-ID: <D21B49FB-6339-4B25-8623-8A5985ADDA24@redhat.com>
In-Reply-To: <20231101022227.GD1957730@ZenIV>
References: <20231030003759.GW800259@ZenIV> <20231030215315.GA1941809@ZenIV>
 <CAHk-=wjGv_rgc8APiBRBAUpNsisPdUV3Jwco+hp3=M=-9awrjQ@mail.gmail.com>
 <20231031001848.GX800259@ZenIV> <20231101022227.GD1957730@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On 31 Oct 2023, at 22:22, Al Viro wrote:

> [NFS folks Cc'd]
>
> On Tue, Oct 31, 2023 at 12:18:48AM +0000, Al Viro wrote:
>> On Mon, Oct 30, 2023 at 12:18:28PM -1000, Linus Torvalds wrote:
>>> On Mon, 30 Oct 2023 at 11:53, Al Viro <viro@zeniv.linux.org.uk> wrote:
>>>>
>>>> After fixing a couple of brainos, it seems to work.
>>>
>>> This all makes me unnaturally nervous, probably because it;s overly
>>> subtle, and I have lost the context for some of the rules.
>>
>> A bit of context: I started to look at the possibility of refcount overflows.
>> Writing the current rules for dentry refcounting and lifetime down was the
>> obvious first step, and that immediately turned into an awful mess.
>>
>> It is overly subtle.  Even more so when you throw the shrink lists into
>> the mix - shrink_lock_dentry() got too smart for its own good, and that
>> leads to really awful correctness proofs.
>
> ... and for another example of subtle shit, consider DCACHE_NORCU.  Recall
> c0eb027e5aef "vfs: don't do RCU lookup of empty pathnames" and note that
> it relies upon never getting results of alloc_file_pseudo() with directory
> inode anywhere near descriptor tables.
>
> Back then I basically went "fine, nobody would ever use alloc_file_pseudo()
> for that anyway", but... there's a call in __nfs42_ssc_open() that doesn't
> have any obvious protection against ending up with directory inode.
> That does not end up anywhere near descriptor tables, as far as I can tell,
> fortunately.
>
> Unfortunately, it is quite capable of fucking the things up in different
> ways, even if it's promptly closed.  d_instantiate() on directory inode
> is a really bad thing; a plenty of places expect to have only one alias
> for those, and would be very unhappy with that kind of crap without any
> RCU considerations.
>
> I'm pretty sure that this NFS code really does not want to use that for
> directories; the simplest solution would be to refuse alloc_file_pseudo()
> for directory inodes.  NFS folks - do you have a problem with the
> following patch?

It would be a protocol violation to use COPY on a directory:

https://www.rfc-editor.org/rfc/rfc7862.html#section-15.2.3

   Both SAVED_FH and CURRENT_FH must be regular files.  If either
   SAVED_FH or CURRENT_FH is not a regular file, the operation MUST fail
   and return NFS4ERR_WRONG_TYPE.

so nfsd4_verify_copy() does S_ISREG() checks before alloc_file_pseudo().

Ben


