Return-Path: <linux-fsdevel+bounces-47542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC12CA9FA98
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 22:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 423FE188EBC1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 20:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C99C1DEFC6;
	Mon, 28 Apr 2025 20:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5eimXIC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C991C126BF7;
	Mon, 28 Apr 2025 20:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745872172; cv=none; b=Ef5fZ/jc9FeX5ukQ8BLigbXQwj5GeY+/cWj6L9ZNAvY+DofyOr6hyTNha/SF7hiONrxVR/bSD76bHIhbIukYt2xOS8s+JY5q46LKrkHUOYFPyMnFHk7sIRMz2YQY/IukhnrtDgxRUybTPMuL+E3v1oHxD0fJb8AIlCIlAg+uLro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745872172; c=relaxed/simple;
	bh=t99wgD/1kSq3OuHKjbQE/PDIYvLBiQxFXqsgNZ//Wik=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=nKvn4o+yb03yC442Nt72gmwUOhjfuESHNmtQAEAi/om6CMXpCFgU5UPOO0ooHQmINVA/aTkp4FZ1DQljw4OP1iDDez7dIOyDokGOMzoabmp/+kPv0TS3762peVUJLo8gh5lYEbXA6MIdUI0MMGgTh/LMhGwvYTyAZyZRrnWTURc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5eimXIC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DF64C4CEE4;
	Mon, 28 Apr 2025 20:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745872171;
	bh=t99wgD/1kSq3OuHKjbQE/PDIYvLBiQxFXqsgNZ//Wik=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Q5eimXICKZ4Cu4j4zFJd6XxcNBXnYVyfIFXx0e7pzbIm/5vx27voqC+0VoormEO0c
	 t3nZPZWXEiV78kT4prnKA10SKsTy4TdMiqN7eLGQAyob8Dtk2K4+9HRp9UiIQurDuA
	 ypUKp7hmD9P0GdNrsI1q4tSKlxvtvP24dBidWIoHupNW/+C3RBw5xySMufbjejcv9k
	 PBSBZNtwUArGm9J6zLU4PFSY4IZBRU5u7a6K2dA1FH9hQvN8l5KMqPXb6zJ0XN0xQH
	 dBEsBFEJXfpFXhQ+8hBJYj3bjGc51M4xORrpPRPlFMltBWZMkB13910li0f2GGrmWF
	 nXIkKEWeD3Xxw==
Date: Mon, 28 Apr 2025 13:29:27 -0700
From: Kees Cook <kees@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
CC: Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mm: abstract initial stack setup to mm subsystem
User-Agent: K-9 Mail for Android
In-Reply-To: <4941ed00-09a4-4926-b7e4-9cdd70eed281@lucifer.local>
References: <cover.1745592303.git.lorenzo.stoakes@oracle.com> <92a8e5ef7d5ce31a3b3cf631cb65c6311374c866.1745592303.git.lorenzo.stoakes@oracle.com> <202504250925.58434D763@keescook> <8fc4249b-9155-438a-8ef8-c678a12ea30d@lucifer.local> <4941ed00-09a4-4926-b7e4-9cdd70eed281@lucifer.local>
Message-ID: <3D2389C5-6908-47DD-824F-4BCBC8273653@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On April 28, 2025 3:46:06 AM PDT, Lorenzo Stoakes <lorenzo=2Estoakes@oracl=
e=2Ecom> wrote:
>On Mon, Apr 28, 2025 at 09:53:05AM +0100, Lorenzo Stoakes wrote:
>> On Fri, Apr 25, 2025 at 10:09:34AM -0700, Kees Cook wrote:
>> > On Fri, Apr 25, 2025 at 03:54:34PM +0100, Lorenzo Stoakes wrote:
>> > > There are peculiarities within the kernel where what is very clearl=
y mm
>> > > code is performed elsewhere arbitrarily=2E
>> > >
>> > > This violates separation of concerns and makes it harder to refacto=
r code
>> > > to make changes to how fundamental initialisation and operation of =
mm logic
>> > > is performed=2E
>> > >
>> > > One such case is the creation of the VMA containing the initial sta=
ck upon
>> > > execve()'ing a new process=2E This is currently performed in __bprm=
_mm_init()
>> > > in fs/exec=2Ec=2E
>> > >
>> > > Abstract this operation to create_init_stack_vma()=2E This allows u=
s to limit
>> > > use of vma allocation and free code to fork and mm only=2E
>> > >
>> > > We previously did the same for the step at which we relocate the in=
itial
>> > > stack VMA downwards via relocate_vma_down(), now we move the initia=
l VMA
>> > > establishment too=2E
>> > >
>> > > Signed-off-by: Lorenzo Stoakes <lorenzo=2Estoakes@oracle=2Ecom>
>> > > Acked-by: David Hildenbrand <david@redhat=2Ecom>
>> > > Reviewed-by: Suren Baghdasaryan <surenb@google=2Ecom>
>> > > ---
>> > >  fs/exec=2Ec          | 51 +---------------------------------
>> >
>> > I'm kind of on the fence about this=2E On the one hand, yes, it's all=
 vma
>> > goo, and should live with the rest of vma code, as you suggest=2E On =
the
>> > other had, exec is the only consumer of this behavior, and moving it
>> > out of fs/exec=2Ec means that changes to the code that specifically o=
nly
>> > impacts exec are now in a separate file, and will no longer get exec
>> > maintainer/reviewer CCs (based on MAINTAINERS file matching)=2E Exec =
is
>> > notoriously fragile, so I'm kind of generally paranoid about changes =
to
>> > its behaviors going unnoticed=2E
>> >
>> > In defense of moving it, yes, this routine has gotten updates over th=
e
>> > many years, but it's relatively stable=2E But at least one thing has =
gone in
>> > without exec maintainer review recently (I would have Acked it, but t=
he
>> > point is review): 9e567ca45f ("mm/ksm: fix ksm exec support for prctl=
")
>> > Everything else was before I took on the role officially (Nov 2022)=
=2E
>> >
>> > So I guess I'm asking, how do we make sure stuff pulled out of exec
>> > still gets exec maintainer review?
>>
>> I think we have two options here:
>>
>> 1=2E Separate out this code into mm/vma_exec=2Ec and treat it like
>>    mm/vma_init=2Ec, then add you as a reviewer, so you have visibility =
on
>>    everything that happens there=2E
>>
>
>Actually, (off-list) Vlastimil made the very good suggestion that we can
>just add this new file to both exec and memory mapping sections, have
>tested it and it works!
>
>So I think this should cover off your concerns?
>
>[snip]

Yes, this is brilliant! Totally works for me; thank you (and Vlastimil) fo=
r finding a good way to do it=2E

-Kees

--=20
Kees Cook

