Return-Path: <linux-fsdevel+bounces-9121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9D483E4CC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 23:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6785F286F76
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 22:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117162555B;
	Fri, 26 Jan 2024 22:09:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A39A250E2;
	Fri, 26 Jan 2024 22:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706306952; cv=none; b=tNLCVy5m9RUaqKIZG4PY8TL+8b8KEU2xwtjDScusfGu3osEAQm/bCtN/+TUmxgHK+6JqPMjjyMEaSEhjQeVUW3LH2RIADON+g7QtYlrQ8+QjwVskiCITO2uo9GD5eaF2W3RRU4lbXsCjClUVPdcrwjHYBQilYL3wxaZAd9vQ86w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706306952; c=relaxed/simple;
	bh=CtzTaYkdi2xs3uvaVT8RVg0S77WwmwuAqxtycAss0+4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=FAuKAxWmeHCegt8Tm/Dt53iKXbH11c48WdYHswHFf4ST/fUQbMNBbTKji5igtlVGkL3BZt3TwrN4258f9kT7lYmHSt8MjH1pPXNp52mmANCuosJfI0UxCmQ4sxmKB+6kwddbc68vqTevpHdKiWhrS+EimKRcepeqfeVEvEetqJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 07DF080ECE;
	Fri, 26 Jan 2024 22:09:01 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 0E2082000D;
	Fri, 26 Jan 2024 22:08:58 +0000 (UTC)
Date: Fri, 26 Jan 2024 17:08:57 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: LKML <linux-kernel@vger.kernel.org>,
 Linux Trace Devel <linux-trace-devel@vger.kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Christian Brauner <brauner@kernel.org>, Ajay Kaher <ajay.kaher@broadcom.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
User-Agent: K-9 Mail for Android
In-Reply-To: <CAHk-=whNfNti-mn6vhL-v-WZnn0i7ZAbwSf_wNULJeyanhPOgg@mail.gmail.com>
References: <20240126150209.367ff402@gandalf.local.home> <CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com> <20240126162626.31d90da9@gandalf.local.home> <CAHk-=wj8WygQNgoHerp-aKyCwFxHeyKMguQszVKyJfi-=Yfadw@mail.gmail.com> <CAHk-=whNfNti-mn6vhL-v-WZnn0i7ZAbwSf_wNULJeyanhPOgg@mail.gmail.com>
Message-ID: <0C9AF227-60F1-4D9B-9099-1A86502359BA@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 0E2082000D
X-Rspamd-Server: rspamout08
X-Stat-Signature: t1hwm8ebwiqcmhpjwt1gda5gazipj7e6
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18G8o5mt59Y6mr4cWUlR88Fv+EAXiFrcgE=
X-HE-Tag: 1706306938-501392
X-HE-Meta: U2FsdGVkX1+yskEDYPvVQ4g3ZQhGys1dTkR4hq7/xYKHMIk+a3H5TVdzTbqEDVUy82Kw2Hgn1sDiQcIr4Xekxca5ZKNqbcwHaiRaMkJrH2npVIMGJ0UhRjkZqlHcphfyYQB/wh7CPdsSDpgSgb0SjHNedmUZI+Z2RkvLkpf4Ib063dkbgah4REWw2JnlWSzk1u2AMILAJl22ExM7bJ5hWB7MELUlKn5wyselZhAIBVlZqT4DWiCb+XEKmEOPpx2aEg404WMra9w1Er6KwPjZjPgsFJFMYZT4y7wD/pGZkUxeHPokQ0iBVubKmBDqH7xdqXfGZ6pMzYj0wwMCpBGn+qEM0nadn1ZyYw6J/okdtLnRp497w0DhPVxql35DWgjEoStdEFav1/kCp6O1vat0QA==



On January 26, 2024 4:49:13 PM EST, Linus Torvalds <torvalds@linux-foundat=
ion=2Eorg> wrote:
>On Fri, 26 Jan 2024 at 13:36, Linus Torvalds
><torvalds@linux-foundation=2Eorg> wrote:
>>
>> If you have more than 4 billion inodes, something is really really wron=
g=2E
>
>Btw, once again, the vfs layer function you took this from *does* have
>some reason to worry=2E Somebody might be doing 'pipe()' in a loop=2E
>
>Also, if your worry is "what if somebody mounts that thing a million
>times", the solution to *that* would have been to make it a per-sb
>counter, which I think would be cleaner anyway=2E
>

I'm more worried about a loop of:

cd /sys/kernel/tracing/instances
while:; do mkdir foo ; rmdir foo: done

Which is what my tests do=2E And I have run that for over a weekend=2E


>But my real issue is that I think you would be *much* better off just
>deleting code, instead of adding new code=2E
>
>For example, what purpose does 'e->dentry' and 'ei->d_childen[]' have?
>Isn't that entirely a left-over from the bad old days?
>

I'm not at my computer, but when I tried deleting that, it caused issues w=
ith the lookup code=2E

-- Steve=20

>So please try to look at things to *fix* and simplify, not at things
>to mess around with and make more complicated=2E
>
>              Linus

