Return-Path: <linux-fsdevel+bounces-76810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eB73DdPAimkeNgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 06:23:31 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8866B117122
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 06:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D335302BE26
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 05:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC3D32C309;
	Tue, 10 Feb 2026 05:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="A1ABKV4n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rZpkH6x+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC5B26A0DD;
	Tue, 10 Feb 2026 05:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770700922; cv=none; b=GpQvrHNJiLOiPwp/dAHRK92NM8uxUKkNFRH28z/LfrLU+q8fp7FcUSf8pxjTOaQ6gRzrOUdL4kiHtESFI/ldl8qe+ELTJ0p27UxFE8sgvkx6+8btYXJovkCZjNaMsYP5z1vAflkC1aMVhiDzAzo9P51XNh/mV8X4S+w4PGkiVHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770700922; c=relaxed/simple;
	bh=kJoeguUaFWEiTpCXv3pfo/3NM/nrRaP0LSGEregA2yI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GIQKnAl9v8VhdNBwGi+5PBII0pPOTuiTFRUcV1bC5Bcho6/OCs4dQR924TBpKPm/o/6TG/Zj+CyztLB+OAS4omwN4r1c81p0NeR/J68ihibQVfePacgVUUXEPs2lE+OftH5tEjYWY6wCId8y5ltZWwdCPd/ygxzodOUfG4ucsfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=A1ABKV4n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rZpkH6x+; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3AD737A01D1;
	Tue, 10 Feb 2026 00:21:59 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 10 Feb 2026 00:21:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770700918; x=1770787318; bh=PmSZWeAvIs
	2E2OOaIEyt1H2r3sCAT/z+1lGe1+pXOnw=; b=A1ABKV4niBOGnYpA9wf+Tt785q
	XZbOSspq5Rf7UF/q+EGciU4u0FGIOfIJOpuyiB7wIW/5TE2bFmHlu6UKflj3bH90
	YeCCCbqQvhnPjETxZqa1pbqy/Polc9hm2e+0BU7j+H9akSkUY3BSKDwPnZ6Qd+3v
	FJ0vw4fAXKO9ZZGex8ppK1Aih07kdOmKlSx1Or3iFkp3Wvrdo6vAH109a7mQjXWk
	DDlqJub9gu2ENWPRM8QsgHNhCcLg2cesne3KrqRG0vgiUsQnPdsj5emWPOTKVWWA
	P6dv79r0YbZpXzckuaQdSuZXiTbBS0kQi8fP6wtYqxwWJcJzUnS0s3nByPiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770700918; x=1770787318; bh=PmSZWeAvIs2E2OOaIEyt1H2r3sCAT/z+1lG
	e1+pXOnw=; b=rZpkH6x+TY2clXW66EjZ7y8pMJZ0it70GuEa/yv76Fwx5XEGkR5
	75iuUBJyP4osmsxGESdvMixsunZ+YsxhBGTPW881mN5+EOEglNm/LuxNPpYKvdmc
	fmEc/UTO9eeWRiibPFlBaihX65vC3+MtPqOyFipojXzQRRqO/KjEk2Gir3ECKCx8
	ThFBS98s61vzlZnJqqwtF9MnrwCkZiirr1yCOe5yjLV+G/r9tavH2RI+rfVXyQjm
	rjJuYg8WzaEf+x19RlPrDTR8JMy8DIr3JmtOGWcKxfOMb4OWZuDNH2cTjeV1gPmy
	EosbxXKmqJRiGRVC9yHo1DdYV2wBudSOC4Q==
X-ME-Sender: <xms:dsCKaYowjRaELRV71XXdC6uDdCpL525QsQLNWaHRVLLssbEpiLvhPA>
    <xme:dsCKabXym-yznvgpy7rI9CSAdUSDh4EYZKXNiWYYzmNzF5GL4AdoPo2XRQfJbAhGa
    7g2gKOvFohtB9RbgryWtXGkGDKkGhMpBmQol6ovEDBPqgxoPrk>
X-ME-Received: <xmr:dsCKaRHYPgnwh2yDkqAmF4FM8ENKVzL8eYHwuPMzceOmJ6uEbdPF57KLjqaEERbNyvoAVbpI07UCb709T6Bm0DcFVBgCEBnWR8UMMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleekkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepfdhgrhgvghes
    khhrohgrhhdrtghomhdfuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtth
    gvrhhnpeehvddvueekieejgfehheelhfeufefghfdtjeetgfelvdeffffgueehfeeitefg
    leenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrh
    gvgheskhhrohgrhhdrtghomhdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehslhgrvhgrrdguuhgsvgihkhhosehisghmrdgtohhmpdhrtg
    hpthhtohepshhlrghvrgesughusggvhihkohdrtghomhdprhgtphhtthhopehlihhnuhig
    qdhmmheskhhvrggtkhdrohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghl
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghpfhesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:dsCKaaA4U_G8cEY84QDjNeMVM51VCM2JWqDgNL28vThKhYgcUeDvXw>
    <xmx:dsCKabwpRkBtH1Zq-BHsiOiM7eJ7OobKLcEiH8VYKcCZyrTO448iuQ>
    <xmx:dsCKaYf0Lhl0zIEM-29RY3Qzg-NOZ6OXQeiB-6RXQyNvLb68V7_tGA>
    <xmx:dsCKaYvvjYbeM-OISLYTqXUFZ1T2_2m99aE7fQ-LkJpUjHW6WttOkg>
    <xmx:dsCKaSV2Xrd4_QAL21HEj9ouG4vORj4YmPwE4e6sHG8f5Okt6kgu465A>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Feb 2026 00:21:58 -0500 (EST)
Date: Tue, 10 Feb 2026 06:21:56 +0100
From: "greg@kroah.com" <greg@kroah.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "slava@dubeyko.com" <slava@dubeyko.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [RFC PATCH v1 3/4] ml-lib: Implement simple testing character
 device driver
Message-ID: <2026021045-handstand-arousal-0f74@gregkh>
References: <20260206191136.2609767-1-slava@dubeyko.com>
 <20260206191136.2609767-4-slava@dubeyko.com>
 <2026020719-thrive-domain-f0c2@gregkh>
 <d3f051c5920d4f68c00a92845e2491003b516a1f.camel@ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3f051c5920d4f68c00a92845e2491003b516a1f.camel@ibm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FROM_DN_EQ_ADDR(1.00)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kroah.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kroah.com:s=fm3,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-76810-lists,linux-fsdevel=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greg@kroah.com,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kroah.com:+,messagingengine.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dubeyko.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8866B117122
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 08:56:47PM +0000, Viacheslav Dubeyko wrote:
> On Sat, 2026-02-07 at 16:55 +0100, Greg KH wrote:
> > On Fri, Feb 06, 2026 at 11:11:35AM -0800, Viacheslav Dubeyko wrote:
> > > Implement simple testing character device driver
> > > 
> > > Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
> > 
> > It's hard to tell if this is just an early april-fools joke or not, but
> > if it's not:
> > 
> > > +### Character Device Operations
> > > +- **Open/Close**: Device can be opened and closed multiple times
> > > +- **Read**: Read data from a kernel buffer
> > > +- **Write**: Write data to a kernel buffer (1KB capacity)
> > > +- **Seek**: Support for lseek() operations
> > > +
> > > +### IOCTL Commands
> > > +- `ML_LIB_TEST_DEV_IOCRESET`: Clear the device buffer
> > > +- `ML_LIB_TEST_DEV_IOCGETSIZE`: Get current data size
> > > +- `ML_LIB_TEST_DEV_IOCSETSIZE`: Set data size
> > > +
> > > +### Sysfs Attributes
> > > +Located at `/sys/class/ml_lib_test/mllibdev`:
> > > +- `buffer_size`: Maximum buffer capacity (read-only)
> > > +- `data_size`: Current amount of data in buffer (read-only)
> > > +- `access_count`: Number of times device has been opened (read-only)
> > > +- `stats`: Comprehensive statistics (opens, reads, writes)
> > 
> > Again, this is not an acceptable use of sysfs.
> 
> Maybe, I am missing your point. Are you assuming that I am going to share huge
> pieces of data by means of sysfs? If so, then I am not going to use sysfs for
> it.

Please do not use sysfs for this at all.

> > > +	/* Allocate device number */
> > > +	ret = alloc_chrdev_region(&dev_number, 0, 1, DEVICE_NAME);
> > 
> > Don't burn a cdev for this, please use the misc device api.
> > 
> 
> It is not real-life driver. It is only testing driver with the goal to
> check/test the ML library infrastructure and to show the potential way of using
> the ML library.
> 
> As the next step, I am planning to use the ML library for two potential real-
> life use-case: (1) GC subsystem of LFS file system, (2) ML-based DAMON approach.
> 
> So, this driver is only testing engine of implementing and testing the vision of
> ML library.

We don't take code that uses apis incorrectly. Please do not use a cdev
for this type of "testing" driver, that is the incorrect thing to do and
actually makes your code more complex than it needs to.

good luck!

greg k-h

