Return-Path: <linux-fsdevel+bounces-76680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJphEIM0iWkD4QQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 02:12:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB1710ACA9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 02:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D1403009F9A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 01:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BB0256C8D;
	Mon,  9 Feb 2026 01:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Uo5z7vrN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F0E1DC997;
	Mon,  9 Feb 2026 01:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770599540; cv=none; b=dQOZut4E2dx4Ol9zWOAAFsmf4FnP46a+R9i0p1A7OZWXnJMDHepi0sqpOJ0C5b3m+xqK1d1J59Ejq2qqwMqQGv5GUoMut1NHL4u/G+qB/yrW6ad+toofNR4qAXud3LEW4asAd+B1EEPQhp4RRnIQx58S052g9KuAaCJE9cliBy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770599540; c=relaxed/simple;
	bh=X4+q86bAlBf8mak2C8mwWgfIea4fjDwFKBg72zzkyLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJ1W3QZzYztboRLA/QO/llQcFTxFvUxpiEpshDysAcILT/WRfzn3z7FXlrnF2aJAAZrEItbHWdyzYgANneS2c3nlOXN8Lgs6ZQIwyBFrooJ1iE7f22OZHW/NG5nOq+Byv4N4BagJEB3cdYo5DBXFfVukswb7XNfr1Vksl3MJaBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Uo5z7vrN; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XTzFIW0NEw+agTa+FpBNYsSuC1reSbTWBq+WJiPEUpk=; b=Uo5z7vrNMhH9ZMjRbBL4ibjoIB
	z1lrHBhOL71bzpEjpeuKLX6/5ikkN44UetacmjNVSEVuh5kquhfJTBfRd7Q4Onz5/Hvs2ox35c//I
	HIv9GaXxeMWNo84r+wlilz3StZ2kfW//kdCjhaZX1glJg6NNRyuwIkZpCxLFxttxN0HtXFA0AuBWz
	M6dVzzhNRJFHc76xRHHkpKrEJBzf/ek2ZkEAXD+t4/HS5aItlouOH+R0bF0L6UuZKIiWime9lhdLx
	6D5GZSmCiWq2l3lGcIeiSMDj3wMUex8vIqrGIrwJideCmwfqFpqZteJOGhdO6qIwFVPERk7ntMN8s
	lF6/XDag==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vpFrA-00000006ouT-1MXO;
	Mon, 09 Feb 2026 01:14:28 +0000
Date: Mon, 9 Feb 2026 01:14:28 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mark Brown <broonie@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: linux-next: build failure after merge of the vfs-brauner tree
Message-ID: <20260209011428.GG3183987@ZenIV>
References: <aXilaLSzB1xsGWCb@sirena.org.uk>
 <f9afaed3-9db5-4725-a0e5-cb6d6873b3c6@sirena.org.uk>
 <ef58e561-b366-4eb8-bad6-9d0e748f49c1@sirena.org.uk>
 <20260206-euter-weilen-610fef8cb79a@brauner>
 <aYj4JRK023heQnFy@sirena.co.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYj4JRK023heQnFy@sirena.co.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[zeniv.linux.org.uk,none];
	R_DKIM_ALLOW(-0.20)[linux.org.uk:s=zeniv-20220401];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76680-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viro@zeniv.linux.org.uk,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.org.uk:+];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.org.uk:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9AB1710ACA9
X-Rspamd-Action: no action

On Sun, Feb 08, 2026 at 08:55:01PM +0000, Mark Brown wrote:
> On Fri, Feb 06, 2026 at 01:19:12PM +0100, Christian Brauner wrote:
> > On Wed, Feb 04, 2026 at 02:31:06PM +0000, Mark Brown wrote:
> 
> > > This means that vfs-brauner is still held at the version from
> > > next-20260126 and none of the below commits have been in -next:
> 
> > This should've been fixed. Not sure what happened.
> > I've reassembled vfs.all completely just to be sure.
> 
> I am seeing an updated version (I've currently got commit
> 91dfa1c939f479938d83793389ad7cb9c1faa4de dated 7th Feb) but I'm still
> seeing the same build failure:
> 
>   CC       statmount_test
> statmount_test.c:36:26: error: conflicting types for 'statmount_alloc'; have 'struct statmount *(uint64_t,  int,  uint64_t,  unsigned int)' {aka 'struct statmount *(long unsigned int,  int,  long unsigned int,  unsigned int)'}
>    36 | static struct statmount *statmount_alloc(uint64_t mnt_id, int fd, uint64_t mask, unsigned int flags)
>       |                          ^~~~~~~~~~~~~~~
> In file included from statmount_test.c:15:
> statmount.h:91:33: note: previous definition of 'statmount_alloc' with type 'struct statmount *(uint64_t,  uint64_t,  uint64_t)' {aka 'struct statmount *(long unsigned int,  long unsigned int,  long unsigned int)'}
>    91 | static inline struct statmount *statmount_alloc(uint64_t mnt_id, uint64_t mnt_ns_id, uint64_t mask)
>       |                                 ^~~~~~~~~~~~~~~

c76a572bb04ed ("selftests/statmount: add statmount_alloc() helper")
vs. the existing function of the same name in mainline
tools/testing/selftests/filesystems/statmount/statmount_test.c

and something's fishy with the commit graph topology there -
you start at 1bce1a664ac2 (== vfs-7.0.namespace), then
there's a linear series from that to 30d2122405f2
*and*
commit d4b4bcc4d5e74a18920876337e74c1351e3c9dd7
Merge: 1bce1a664ac2 30d2122405f2
IOW, a merge that should've been a fast-forward...

Problem commit sits in that series.  Past that odd merge it gets merged
into your vfs.all in d433753e4867 ("Merge branch 'deferred.namespace-7.0'
into vfs.all").  And aforementioned deferred.namespace-7.0 is not among
the branches in the repository on kernel.org, so at a guess that's Christian's
internal-only branch that leaked into vfs.all...

