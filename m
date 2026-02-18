Return-Path: <linux-fsdevel+bounces-77481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sA+LHkoQlWmkKgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 02:05:14 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2548D152706
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 02:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A6193024111
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 01:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF4C2C0F79;
	Wed, 18 Feb 2026 01:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GjahZ+Tn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E301F419A;
	Wed, 18 Feb 2026 01:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771376703; cv=none; b=jtQKQWomloKKG1gEWXRgBFWrbUHJiD7tlTumbYH5oM5LgJqhQKRENNbb8hm/P3ST7O7HsMUc/2J4gxfoDhP3X6CNUBEbZJs9+zBZkrdIRxB3k3VGOjhO39WydLxdmGM9EPRTw6bLKn9Hf7+hH3Nki1TcEoLyQz+nsxALFCWNI3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771376703; c=relaxed/simple;
	bh=IsqEVzhEg6qsCM/MHOX/MCUhJ03tO51uDgjhXK3ZRNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vsoqwa10S/CH4BrHPYRStGSkIehTfuw9sSzq1QnlVZDw24h6vZlh/BdkZ/CTCeM6Ue5UZP2NYe0f9Gcxp9vtfJtVGRUGH+at8WS5aOXah91nVB5HCW2wuwEfK5UMhv7iWsj1KvE2reFiKhvDoxQvhZVoRvvBKLhoCvWbOguoXeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GjahZ+Tn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40116C4CEF7;
	Wed, 18 Feb 2026 01:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771376702;
	bh=IsqEVzhEg6qsCM/MHOX/MCUhJ03tO51uDgjhXK3ZRNo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GjahZ+Tnj34RwerIUXUtIfq0dwbgYjpFesDdYoaXSQI9Yterjvxz1XuvI6BibwGjh
	 CZXMYjLYEMq1nPyoDDsC4Q0KZb3as1Da5/zYPKkZnIvrkZocbRhUqoEiBAkCnu8oWb
	 5SlgwDP2/9ywE5jjLaCX8Vl+OP0LasrdlsSRwYyYhHm7pW2tVZ6a3R/a8ksafmbxLg
	 jMy3THFxzS2u53AyYI8/Jpn5CBaMJEOjEiMLl1QxaoCF0UdEA+zEnDSkHJcPmnq7cH
	 oo6gyji/OGtE3g4CW3KNETatLFWwLbNB55tJv1RIx3uGUraIr+MVJ+QLWojBsyR3Ua
	 arIF2J1zJUGkw==
Date: Wed, 18 Feb 2026 12:04:43 +1100
From: Dave Chinner <dgc@kernel.org>
To: Andres Freund <andres@anarazel.de>
Cc: Pankaj Raghav <pankaj.raghav@linux.dev>, Jan Kara <jack@suse.cz>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	lsf-pc@lists.linux-foundation.org, djwong@kernel.org,
	john.g.garry@oracle.com, willy@infradead.org, hch@lst.de,
	ritesh.list@gmail.com, Luis Chamberlain <mcgrof@kernel.org>,
	dchinner@redhat.com, Javier Gonzalez <javier.gonz@samsung.com>,
	gost.dev@samsung.com, tytso@mit.edu, p.raghav@samsung.com,
	vi.shah@samsung.com
Subject: Re: [LSF/MM/BPF TOPIC] Buffered atomic writes
Message-ID: <aZUQKx_C3-qyU4PJ@dread>
References: <d0c4d95b-8064-4a7e-996d-7ad40eb4976b@linux.dev>
 <aY8n97G_hXzA5MMn@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <7cf3f249-453d-423a-91d1-dfb45c474b78@linux.dev>
 <zzvybbfy6bcxnkt4cfzruhdyy6jsvnuvtjkebdeqwkm6nfpgij@dlps7ucza22s>
 <wkczfczlmstoywbmgfrxzm6ko4frjsu65kvpwquzu7obrjcd3f@6gs5nsfivc6v>
 <4627056f-2ab9-4ff1-bca0-5d80f8f0bbab@linux.dev>
 <ignmsoluhway2yllepl2djcjjaukjijq3ejrlf4uuvh57ru7ur@njkzymuvzfqf>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ignmsoluhway2yllepl2djcjjaukjijq3ejrlf4uuvh57ru7ur@njkzymuvzfqf>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77481-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dgc@kernel.org,linux-fsdevel@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.dev,suse.cz,linux.ibm.com,vger.kernel.org,kvack.org,lists.linux-foundation.org,kernel.org,oracle.com,infradead.org,lst.de,gmail.com,redhat.com,samsung.com,mit.edu];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2548D152706
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 11:21:20AM -0500, Andres Freund wrote:
> Hi,
> 
> On 2026-02-17 13:42:35 +0100, Pankaj Raghav wrote:
> > On 2/17/2026 1:06 PM, Jan Kara wrote:
> > > On Mon 16-02-26 10:45:40, Andres Freund wrote:
> > > > (*) As it turns out, it often seems to improves write throughput as well, if
> > > > writeback is triggered by memory pressure instead of SYNC_FILE_RANGE_WRITE,
> > > > linux seems to often trigger a lot more small random IO.
> > > > 
> > > > > So immediately writing them might be ok as long as we don't remove those
> > > > > pages from the page cache like we do in RWF_UNCACHED.
> > > > 
> > > > Yes, it might.  I actually often have wished for something like a
> > > > RWF_WRITEBACK flag...
> > > 
> > > I'd call it RWF_WRITETHROUGH but otherwise it makes sense.
> > > 
> > 
> > One naive question: semantically what will be the difference between
> > RWF_DSYNC and RWF_WRITETHROUGH?

None, except that RWF_DSYNC provides data integrity guarantees.

> > So RWF_DSYNC will be the sync version and
> > RWF_WRITETHOUGH will be an async version where we kick off writeback
> > immediately in the background and return?

No.

Write-through implies synchronous IO. i.e. that IO errors are
reported immediately to the caller, not reported on the next
operation on the file.

O_DSYNC integrity writes are, by definition, write-through
(synchronous) because they have to report physical IO completion
status to the caller. This is kinda how "synchronous" got associated
with data integrity in the first place.

DIO writes are also write-through - there is nowhere to store an IO
error for later reporting, so they must be executed synchronously to
be able to report IO errors to the caller.

Hence write-through generally implies synchronous IO, but it does
not imply any data integrity guarantees are provided for the IO.

If you want async RWF_WRITETHROUGH semantics, then the IO needs to
be issued through an async IO submission interface (i.e. AIO or
io_uring). In that case, the error status will be reported through
the AIO completion, just like for DIO writes.

IOWs, RWF_WRITETHROUGH should result in buffered writes displaying
identical IO semantics to DIO writes. In doing this, we then we only
need one IO path implementation per filesystem for all writethrough
IO (buffered or direct) and the only thing that differs is the folios
we attach to the bios.

> Besides sync vs async:
> 
> If the device has a volatile write cache, RWF_DSYNC will trigger flushes for
> the entire write cache or do FUA writes for just the RWF_DSYNC write.

Yes, that is exactly how the iomap DIO write path optimises
RWF_DSYNC writes. It's much harder to do this for buffered IO using
the generic buffered writeback paths and buffered writes never use
FUA writes.

i.e., using the iomap DIO path for RWF_WRITETHROUGH | RWF_DSYNC
would bring these significant performance optimisations to buffered
writes as well...

> Which
> wouldn't be needed for RWF_WRITETHROUGH, right?

Correct, there shouldn't be any data integrity guarantees associated
with plain RWF_WRITETHROUGH.

-Dave.
-- 
Dave Chinner
dgc@kernel.org

