Return-Path: <linux-fsdevel+bounces-52313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B49AE1A3B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 13:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC5F05A551E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 11:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C7528AAE9;
	Fri, 20 Jun 2025 11:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="npkPStXW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nifjXByx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB18730E841;
	Fri, 20 Jun 2025 11:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750420227; cv=none; b=NbomvbK1gv8h9OBsB1xMUb89vxeVf/XQjZSLP2rro1W9LoEWPWh+MJdJ6yLz0TLFZ35N8H4ZyO4Ms6+kGxPsriK72D9V0KjvVIIa6M4+rM64WyoD3LbkbH36pIPQpy6Q+r3p1cDqgIAqek+nLaNnkEE7FyPkcEDqZbVDYi8SHyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750420227; c=relaxed/simple;
	bh=XQP+okgwnUJzIyjCbH/bSoqgpvri7GVwz1su2JFjrl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tE2xewMK1HasxnDPA3029II5S6SgiekpMwF5PrgCIiriara92wfQxm6m+Xk7M11MzvKZm9+GVztdZaYOHj+QAZXRR3NSdoHPW7AMQVbIren++lT4Y/nOJEuoVIIaE0XX9aL19y2oMI2CMdRgIyufEkRhfmlT/GHen/x5mg+uRVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=npkPStXW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nifjXByx; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 82591114022E;
	Fri, 20 Jun 2025 07:50:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 20 Jun 2025 07:50:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1750420223;
	 x=1750506623; bh=l2hII4cp1PyuBUVylpSn0Ellq5/eSFVIntLZcwtH1hI=; b=
	npkPStXWRyCVryYxdY6IQIeviIXh+2n6rWViPZzUqh3iKMz1i10zmSsiEUd+pQJz
	Fb0mfWiQ+gREkaF27Ke5uUelXBVoYvl6hQXa5src0MEuQS2kfeRvrQ2fN4PYqn4x
	vG1oEBofJsiHI57HdtNVwpUbgBVrawFWGEAunbsoNdU2CYRzOMQSsfqRw+Bzh5ym
	62LGJpzEEdvRv4TEOhSrb9ySoEdBaoLqLupVqBhTGdyOJ8Z0JRXAV2tpr67PN/N/
	fw9s79YKr9rTT8ywGwQTRK2jR72Xj4xKWCEvS1XZONoCTDIUT+kISZVyM6mxLUkB
	i1tnyNNjtMsZyNiZ6dmrNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750420223; x=
	1750506623; bh=l2hII4cp1PyuBUVylpSn0Ellq5/eSFVIntLZcwtH1hI=; b=n
	ifjXByxaNRRLakj6lL2xdIIaetTwnvH805LM7CD4adrNFy94YnTao2IgfAx5vkYy
	NTLGgFdivOUSJOxyarSG3s5Yz7zp9gce8YRXRysN6/CNeggZzceJLrElDmHHtXE6
	LgpOCk+OJZWwaSbaB++54u9ta0CqamZKB+8aPd5QFP4U4BG10s58rYhG7s5SKZmA
	Fro62KBvsRUfv2TCqm+hGCLPjW6olucr6SC6LZMlEwH3r014CmRITU7MhpqgkCop
	eXdHefyblyadVyvBO6jcoWXsFqyCvBCHZb/c+1m01twZUBu3J2QYngUc+fPGrelb
	TPhU36bmUQ8/mb1jEuhMg==
X-ME-Sender: <xms:_kpVaNDFBXzNsKJDv88JH3iaARE_DiQYyagf-am3xLWXrZBrM954zQ>
    <xme:_kpVaLg15AFCv4uk5N2ctJvgbTjy6CQ4YCRrvJNfKGJqXJutu2bSUe3cJuzuzuVjR
    0ZT4te9V7C8k-Yd>
X-ME-Received: <xmr:_kpVaImHbuNoGhKVDMUAk-gQ1CkJ6HWc0QBU_72JLPe8icmOHYGR3kGwuiK_JpZ1MA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdekfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhguucfu
    tghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrghtth
    gvrhhnpeehhfejueejleehtdehteefvdfgtdelffeuudejhfehgedufedvhfehueevudeu
    geenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvg
    hrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhhishesrhgvughhrghtrdgtohhmpdhrtghpthhtoh
    epthihthhsohesmhhithdrvgguuhdprhgtphhtthhopegujhifohhngheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgtohhmpdhrtghpth
    htoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehjohhhnhesghhrohhvvghsrdhnvghtpdhrtghpthhtohepmhhikhhlohhsse
    hsiigvrhgvughirdhhuhdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghi
    lhdrtghomhdprhgtphhtthhopehjohhsvghfsehtohigihgtphgrnhgurgdrtghomh
X-ME-Proxy: <xmx:_kpVaHw3BCmLCcPEt5esB2526zpYbljLvrjsNswI2t0rge-F4T3xCg>
    <xmx:_kpVaCTMOCtKUrWyj65sSLtI5QUyASoAH0BT9BajAbjfqfcfD3Se_w>
    <xmx:_kpVaKbfrVh5JDCyor75MsA7-nnLBugEpYG-jun4XSBaOkjhyB-OXA>
    <xmx:_kpVaDTvnIzMl9qcrEoLjXfmlQaDKdOPDH6eTR8wFasTUGwKLqoDFw>
    <xmx:_0pVaLiov9a9lbVj0ffG6DBDk3wC6JyK9pEU8jKDsj_1RB4Xzo3qcPlH>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Jun 2025 07:50:21 -0400 (EDT)
Message-ID: <1ac7d8ff-a212-4db8-8d01-e06be712c4ed@bsbernd.com>
Date: Fri, 20 Jun 2025 13:50:20 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC[RAP]] fuse: use fs-iomap for better performance so we can
 containerize ext4
To: Allison Karlitskaya <lis@redhat.com>, Theodore Ts'o <tytso@mit.edu>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Amir Goldstein
 <amir73il@gmail.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 John@groves.net, miklos@szeredi.hu, joannelkoong@gmail.com,
 Josef Bacik <josef@toxicpanda.com>, linux-ext4 <linux-ext4@vger.kernel.org>
References: <20250521235837.GB9688@frogsfrogsfrogs>
 <CAOQ4uxh3vW5z_Q35DtDhhTWqWtrkpFzK7QUsw3MGLPY4hqUxLw@mail.gmail.com>
 <20250529164503.GB8282@frogsfrogsfrogs>
 <CAOQ4uxgqKO+8LNTve_KgKnAu3vxX1q-4NaotZqeLi6QaNMHQiQ@mail.gmail.com>
 <20250609223159.GB6138@frogsfrogsfrogs>
 <CAOQ4uxgUVOLs070MyBpfodt12E0zjUn_SvyaCSJcm_M3SW36Ug@mail.gmail.com>
 <20250610190026.GA6134@frogsfrogsfrogs> <20250611115629.GL784455@mit.edu>
 <CAOYeF9W8OpAjSS9r_MO5set0ZoUCAnTmG2iB7NXvOiewtnrqLg@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US
In-Reply-To: <CAOYeF9W8OpAjSS9r_MO5set0ZoUCAnTmG2iB7NXvOiewtnrqLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/20/25 10:58, Allison Karlitskaya wrote:
> hi Ted,
> 
> Sorry I didn't see this earlier.  I've been travelling.
> 
> On Wed, 11 Jun 2025 at 21:25, Theodore Ts'o <tytso@mit.edu> wrote:
>> This may break the github actions for composefs-rs[1], but I'm going
>> to assume that they can figure out a way to transition to Fuse3
>> (hopefully by just using a newer version of Ubuntu, but I suppose it's
>> possible that Rust bindings only exist for Fuse2, and not Fuse3).  But
>> in any case, I don't think it makes sense to hold back fuse2fs
>> development just for the sake of Ubuntu Focal (LTS 20.04).  And if
>> necessary, composefs-rs can just stay back on e2fsprogs 1.47.N until
>> they can get off of Fuse2 and/or Ubuntu 20.04.  Allison, does that
>> sound fair to you?
> 
> To be honest, with a composefs-rs hat on, I don't care at all about
> fuse support for ext2/3/4 (although I think it's cool that it exists).
> We also use fuse in composefs-rs for unrelated reasons, but even there
> we use the fuser rust crate which has a "pure rust" direct syscall
> layer that no longer depends on libfuse.  Our use of e2fsprogs is
> strictly related to building testing images in CI, and for that we
> only use mkfs.ext4.  There's also no specific reason that we're using
> old Ubuntu.  I probably just copy-pasted it from another project
> without paying too much attention.


 From libfuse point of view I'm too happy about that split into different
libraries. Libfuse already right now misses several features because
they were added to virtiofs, but not to libfuse. I need to find the time
for it, but I guess it makes sense to add rust support to libfuse (and
some parts can be entirely rewritten into rust).



Thanks,
Bernd

