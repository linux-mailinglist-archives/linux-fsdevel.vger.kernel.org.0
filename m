Return-Path: <linux-fsdevel+bounces-75550-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yE4wE6rzd2npmgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75550-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 00:07:22 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC708E26A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 00:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8E78301AA4D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 23:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DA930DD31;
	Mon, 26 Jan 2026 23:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=trevorgross.com header.i=@trevorgross.com header.b="Bc7EmbAT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-108-mta95.mxroute.com (mail-108-mta95.mxroute.com [136.175.108.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46E630CDA8
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 23:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769468835; cv=none; b=Z6fLhYkdAa3ATgc3SHuA4oK/BUWxYy68QK/XGJ2jWJqD20axrRXepP3p9brYRzWdlxpJFFDL/GgihB6yLl8H2hdcMdHGHAz6xhHyxyDm7Pda8i8dWk3QjiJS0cakC3x2tkvoxzK1Zu+vrQjKuY3SSa2RPnZ+dn9SKY39gXNnBog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769468835; c=relaxed/simple;
	bh=I97+kPJZrplTlhPViklyYGiaFAMUQCRKVKgoZx1sKHE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=NCUHsT8iOcmWnLVN8nEBynb838nqFMeqasSGOKgZgxFKJQ7IiBLEZ7Ai8frIEjx1kFnvTtQR2BqXSAwlpSJpXVrir6B0CjyQzyfxToPBSUthUMftyVYPkzKIXM2g7l+H0Hpg2/KXsDhaeWjIIdXUrL087qA1SG5/ZIfw7OvVRgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=trevorgross.com; dkim=pass (2048-bit key) header.d=trevorgross.com header.i=@trevorgross.com header.b=Bc7EmbAT; arc=none smtp.client-ip=136.175.108.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trevorgross.com
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta95.mxroute.com (ZoneMTA) with ESMTPSA id 19bfc8af1540009140.00a
 for <linux-fsdevel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Mon, 26 Jan 2026 23:02:02 +0000
X-Zone-Loop: 4bfc1978410d4b003611bdbc5fa660e924c5b899ac9a
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=trevorgross.com; s=x; h=In-Reply-To:References:To:From:Subject:Cc:
	Message-Id:Date:Content-Type:Content-Transfer-Encoding:Mime-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xKpYJ6JV/CTy0LhvXkMAAAGjNZETCU24btXVUOAYG/s=; b=Bc7EmbATIjrlm3rpnqiczH27rp
	p+GKPz/h305u71p0vaDTK3wIct/FidOMjGZd+qd5oUTBo76zUhcK5AHDfq5OWuDrlFS7oAP2x79SR
	UOlGI153hNQrJaBQM6LvMyyTuvyziZEntAcERFWL4kbH5TDrPo6kZYhmBKo0BZTnDMjdqQPeWs8/4
	lLb86iNg3wxUy5jLTGyS48NJupCF71c6ItXzyJ6vTcilTN0odWD66LDB1/OAP244oHdsqMVS6xH8S
	ACFnAhsKzAPEpQCcJJXGZb0Pvx1mShkmGCrh5XPRf2HKwAtmyWxtqaXzKpkWTJEo7AUGbNnyvSYdM
	1Hq6acRQ==;
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Jan 2026 17:01:59 -0600
Message-Id: <DFYW8O4499ZS.2L1ABA5T5XFF2@umich.edu>
Cc: "Zack Weinberg" <zack@owlfolio.org>, "Rich Felker" <dalias@libc.org>,
 "Alejandro Colomar" <alx@kernel.org>, "Vincent Lefevre"
 <vincent@vinc17.net>, "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-api@vger.kernel.org>, "GNU libc development"
 <libc-alpha@sourceware.org>
Subject: Re: [RFC v1] man/man2/close.2: CAVEATS: Document divergence from
 POSIX.1-2024
From: "Trevor Gross" <tmgross@umich.edu>
To: "Jeff Layton" <jlayton@kernel.org>, "Jan Kara" <jack@suse.cz>, "The
 8472" <kernel@infinite-source.de>
References: <20260120174659.GE6263@brightrain.aerifal.cx>
 <aW_jz7nucPBjhu0C@devuan> <aW_olRn5s1lbbjdH@devuan>
 <1ec25e49-841e-4b04-911d-66e3b9ff4471@app.fastmail.com>
 <0f60995f-370f-4c2d-aaa6-731716657f9d@infinite-source.de>
 <20260124213934.GI6263@brightrain.aerifal.cx>
 <7654b75b-6697-4aad-93fc-29fa9b734bdb@infinite-source.de>
 <de07d292-99d8-44e8-b7d6-c491ac5fe5be@app.fastmail.com>
 <whaocgx6bopndbpag2wazn2ko4skxl4pe6owbavj3wblxjps4s@ntdfvzwggxv3>
 <c59361e4-ad50-4cdf-888e-3d9a4aa6f69b@infinite-source.de>
 <pt7hcmgnzwveyzxdfpxtrmz2bt5tki5wosu3kkboil7bjrolyr@hd4ctkpzzqzi>
 <72100ec4b1ec0e77623bfdb927746dddc77ed116.camel@kernel.org>
In-Reply-To: <72100ec4b1ec0e77623bfdb927746dddc77ed116.camel@kernel.org>
X-Authenticated-Id: tg@trevorgross.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	R_DKIM_REJECT(1.00)[trevorgross.com:s=x];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[umich.edu : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75550-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[trevorgross.com:-];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tmgross@umich.edu,linux-fsdevel@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[umich.edu:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EAC708E26A
X-Rspamd-Action: no action

On Mon Jan 26, 2026 at 10:43 AM CST, Jeff Layton wrote:
> On Mon, 2026-01-26 at 16:56 +0100, Jan Kara wrote:
>> On Mon 26-01-26 14:53:12, The 8472 wrote:
>> > On 26/01/2026 13:15, Jan Kara wrote:
>> > > On Sun 25-01-26 10:37:01, Zack Weinberg wrote:
>> > > > On Sat, Jan 24, 2026, at 4:57 PM, The 8472 wrote:
>> > > > > >       [QUERY: Do delayed errors ever happen in any of these si=
tuations?
>> > > > > >=20
>> > > > > >          - The fd is not the last reference to the open file d=
escription
>> > > > > >=20
>> > > > > >          - The OFD was opened with O_RDONLY
>> > > > > >=20
>> > > > > >          - The OFD was opened with O_RDWR but has never actual=
ly
>> > > > > >            been written to
>> > > > > >=20
>> > > > > >          - No data has been written to the OFD since the last =
call to
>> > > > > >            fsync() for that OFD
>> > > > > >=20
>> > > > > >          - No data has been written to the OFD since the last =
call to
>> > > > > >            fdatasync() for that OFD
>> > > > > >=20
>> > > > > >          If we can give some guidance about when people don=E2=
=80=99t need to
>> > > > > >          worry about delayed errors, it would be helpful.]
>> > > >=20
>> > > > In particular, I really hope delayed errors *aren=E2=80=99t* ever =
reported
>> > > > when you close a file descriptor that *isn=E2=80=99t* the last ref=
erence
>> > > > to its open file description, because the thread-safe way to close
>> > > > stdout without losing write errors[2] depends on that not happenin=
g.
>> > >=20
>> > > So I've checked and in Linux ->flush callback for the file is called
>> > > whenever you close a file descriptor (regardless whether there are o=
ther
>> > > file descriptors pointing to the same file description) so it's upto
>> > > filesystem implementation what it decides to do and which error it w=
ill
>> > > return... Checking the implementations e.g. FUSE and NFS *will* retu=
rn
>> > > delayed writeback errors on *first* descriptor close even if there a=
re
>> > > other still open descriptors for the description AFAICS.
>
> ...and I really wish they _didn't_.
>
> Reporting a writeback error on close is not particularly useful. Most
> filesystems don't require you to write back all data on a close(). A
> successful close() on those just means that no error has happened yet.
>
> Any application that cares about writeback errors needs to fsync(),
> full stop.

Is there a good middle ground solution here?

It seems reasonable that an application may want to have different
handling for errors expected during normal operation, such as temporary
network failure with NFS, compared to more catastrophic things like
failure to write to disk. The reason cited around [1] for avoiding fsync
is that it comes with a cost that, for many applications, may not be
worth it unless you are dealing with NFS.

I was wondering if it could be worth a new fnctl that provides this kind
of "best effort" error checking behavior without having the strict
requirements of fsync. In effect, to report the errors that you might
currently get at close() before actually calling close() and losing the
fd.

Alternatively, it would be interesting to have a deferred fsync() that
schedules a nonblocking sync event that can be polled for completion/
errors, with flags to indicate immediate sync or allow automatic syncing
as needed. But there is probably a better alternative to this
complexity.

- Trevor

[1]: https://github.com/rust-lang/libs-team/issues/705

