Return-Path: <linux-fsdevel+bounces-63432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CED67BB8B76
	for <lists+linux-fsdevel@lfdr.de>; Sat, 04 Oct 2025 11:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60BFE19C206E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Oct 2025 09:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C1121ADB9;
	Sat,  4 Oct 2025 09:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mazzo.li header.i=@mazzo.li header.b="oO/5ZkVY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xw2yKTm7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7667E288D6
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Oct 2025 09:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759568533; cv=none; b=TsdrsPCXnvJGu/tvuoQh6WSo4xhinLcjVtTh93zdXWa0K6rWnlWo9CDzwg2G0XugAs5jqlZ7Cg8ob2ZsnxXI50R2usaVqz6zqqKereTjeWLuBtJtgbEsWifb+okwLuaoP2aKD3zhuaTMQ8GK95sFsvhNbcMQCMb3KKWpVrqq+9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759568533; c=relaxed/simple;
	bh=Jk9zJNbR4ApyvROreZ9FXebhGVpUlV5C1ZfE35zC6ps=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=onHNrcc1xppXZFusADGOGBS3yVuFu8+wdUZaqadsikehZ1NeRfqrKTBApzqw/z5poaSipEG8WQQheAJRUt1mFrhoIOqn8izMPPBUMMF8Vh1V+oCpmiaCGML3bqb3VI93iGokcOByokqn54l7qvKqH+6XSH16RBNvfoeOTASpCKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mazzo.li; spf=pass smtp.mailfrom=mazzo.li; dkim=pass (2048-bit key) header.d=mazzo.li header.i=@mazzo.li header.b=oO/5ZkVY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xw2yKTm7; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mazzo.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mazzo.li
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 2D9301D000F7;
	Sat,  4 Oct 2025 05:02:08 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-05.internal (MEProxy); Sat, 04 Oct 2025 05:02:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mazzo.li; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1759568528;
	 x=1759654928; bh=NuiRRF8CFfIS9ByjZDrPwZqZfRWauXBJUOSlr+ztTDU=; b=
	oO/5ZkVYj9Gxssr10+T7tOJspRoJ7Wqyn8EgqNB8dX6h8eSWy/fR5Qmg1D6fU3eh
	sMjEG4iu+68d5rhjP4BXKC5S0JwOLTU3/j9OueMtdMHl8In1NintFUwxX3muAs7S
	JoLofkcEFOqxgz7AE7UqBKRm4qUKREW5eFJ0zZcYypDWJXOwwQaD4L8nqIwgOX1d
	OZrL4HBctey1H1rIv8bASCO/9MBcZwv2cNfx1HQWkViqZoW1cDGpBUHX2Pjtc0Lj
	ot2cDXjOr29UYmI6CwZwFY4HChlfAMlTAGREu4yI/iEv41GiG/DrGPUXMqeF1lb7
	hbvmLf786iWr++/ZURwf1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759568528; x=
	1759654928; bh=NuiRRF8CFfIS9ByjZDrPwZqZfRWauXBJUOSlr+ztTDU=; b=X
	w2yKTm7rw37HB8SlydLbTvfSYs+DACnt+/mDyNnJI0xSStjWYV3mnUjKeREvHl8i
	1vnWwV7OynbObZmhZi15CNJ2zHK7CyMzngKe4B+R5hBje8SekS+iL8S/sLN1A1dv
	3gcHd87AKZbLZMVLI3BkyUAFgMzWSakvPT8H3Yx3aPpvtSRKJfTDcE1K529axRQR
	jZrbWamCroMVuDerG/NNyzspU29ZPOVU9AJ8GknPgKHNEEYb1SbQVVpoYBATySmS
	e3bQT2kr4xv2WTf1ZUk/1O60blhLtTVfGRIcwa5R+jl++bB3L6zpzQt2oWKV4AU1
	qwf9zbGIi3zSS+21Mps6g==
X-ME-Sender: <xms:j-LgaEzZhnrmp0m328cDvsDEX5zAO-xXgNP4k6jm7eEgR-S8GG6p6w>
    <xme:j-LgaDGhQ2j1KUjdUTQv1PJlVgfdHO4qgOOy8UnTywZkdMEF0XTxNh65k6IeGDVEm
    UUf9fpiMCWPnnmiaw-09PaXwwC_BLXOUDdApTQfaulUWPl3Hp-ALKVZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeludefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfhrhgrnhgt
    vghstghoucforgiiiiholhhifdcuoehfsehmrgiiiihordhliheqnecuggftrfgrthhtvg
    hrnhepffefkeetueevvdehieejtddtuefhueelhfduleevgfduueeludetkeevkeeukeef
    necuffhomhgrihhnpeigthigmhgrrhhkvghtshdrtghomhdpmhgriiiiohdrlhhinecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfhesmhgriiii
    ohdrlhhipdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhfmhdprhgtphhtthho
    pegrmhhirhejfehilhesghhmrghilhdrtghomhdprhgtphhtthhopegsrhgruhhnvghrse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegujhifohhngheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepthihthhsohesmhhithdrvgguuhdprhgtphhtthhopehmihhklhhosh
    esshiivghrvgguihdrhhhupdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:j-LgaPrgXQ6p1lisNavBBWAZgFr1Aa8_-pdVaRoWQNl-dilVY6-Z_g>
    <xmx:j-LgaKXUQDfKDEspANu8hSrVrXdrRh6j1OqpBhStslBVhUsm2lC06A>
    <xmx:j-LgaKacdysX5HrK-oC-NWqEMNsnI8gZjk-tM6qiwzDi0_hOrgoWrA>
    <xmx:j-LgaHc2AKjy12Gz6w_bM_wPKyPXbtsQPPtxm2uPz-dUxMwlXLsMWw>
    <xmx:kOLgaHNsvpbnclthSGqPQ2Ko0bfm_mVQIgzo2YluyQS3pEE_D_Mdw7aw>
Feedback-ID: i78a648d4:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4AA30216005F; Sat,  4 Oct 2025 05:02:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AKLrIgF2TFVc
Date: Sat, 04 Oct 2025 10:01:04 +0100
From: "Francesco Mazzoli" <f@mazzo.li>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: "Amir Goldstein" <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
 "Christian Brauner" <brauner@kernel.org>,
 "Darrick J. Wong" <djwong@kernel.org>,
 "Bernd Schubert" <bernd.schubert@fastmail.fm>,
 "Miklos Szeredi" <miklos@szeredi.hu>
Message-Id: <a46bc09c-0af1-42b8-b134-128b93b7b5c4@app.fastmail.com>
In-Reply-To: <20251004025247.GD386127@mit.edu>
References: <bc883a36-e690-4384-b45f-6faf501524f0@app.fastmail.com>
 <CAOQ4uxi_Pas-kd+WUG0NFtFZHkvJn=vgp4TCr0bptCaFpCzDyw@mail.gmail.com>
 <34918add-4215-4bd3-b51f-9e47157501a3@app.fastmail.com>
 <20251004025247.GD386127@mit.edu>
Subject: Re: Mainlining the kernel module for TernFS, a distributed filesystem
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, Oct 4, 2025, at 03:52, Theodore Ts'o wrote:
> To do that, some recommendations:
> ...

Thank you, this is all very useful.

> Looking the documentation, here are some notes:
> 
> * "We don't expect new directories to be created often, and files (or
>   directories) to be moved between directories often."  I *think*
>   "don't expect" binds to both parts of the conjuction.  So can you
>   confirm that whatw as meant is "... nor do we expect that files
>   (or directries) to be moved frequently."

Your interpretation is correct.

> * If that's true, it means that you *do* expect that files and
>   directories can be moved around.  What are the consistency
>   expectations when a file is renamed/moved?  I assume that since
>   clients might be scattered across the world, there is some period
>   where different clients might have different views.  Is there some
>   kind of guarantee about when the eventual consistency will
>   definitely be resolved?

While TernFS is geo-replicated, metadata is geo-replicated in a master-slave
fashion: writes go through a single region, and writers in a given region
are guaranteed to read their own writes. We have plans to move this to
master-master setup, but it hasn't been very urgent since the metadata latency
hit is usually hidden by the time it takes to write the actual files (which as
remarked tend to be pretty big).

That said, directory entries are also cached, we use 250ms but it's
configurable.

File contents on the other hand are written locally and replicated both in a
push and pull fashion. However files are immutable, which means you never have
an inconsistent view of file contents in different regions.

See also the "Going global" section of the blog post:
<https://www.xtxmarkets.com/tech/2025-ternfs/>.

> * In the description of the filesystem data or metadata, there is no
>   mention of whether there are checksums at rest or not.  Given the
>   requirements that there be protections against hard disk bitrot, I
>   assume there would be -- but what is the granularity?  Every 4092
>   bytes (as in GFS)?   Every 1M?   Every 4M?   Are the checksums verified
>   on the server when the data is read?  Or by the client?   Or both?
>   What is the recovery path if the checksum doesn't verify?

Some of this is explained in the blog post mentioned above. In short: file
contents are both checksummed at a page level, but also at a higher boundary
(we call these "spans"), and the CRCs at this higher boundary are cross checked
by the metadata services and the storage nodes. I've written two blog posts
about these topics, see <https://mazzo.li/posts/mac-distributed-tx.html> and
<https://mazzo.li/posts/rs-crc.html>. The metadata is also checksummed by way
of RocksDB. Errors are recovered from using Reed-Solomon codes.

> * Some of the above are about the protocol, and that would be good to
>   document.  What if any are the authentication and authorization
>   checking that gets done?  Are there any cryptographic protection for
>   either encryption or data integrity?  I've seen some companies who
>   consider their LLM to highly proprietary, to the extent that they
>   want to use confidential compute VM's.  Or if you are using the file
>   system for training data, the training data might have PII.

There's no cryptographic protection or authentication in TernFS. We handle
authentication at a different layer: we have filesystem gateway that expose
only parts of the filesystem to less privileged users.

> There has been some really interesting work that that Darrick Wong has
> been doing using the low-level fuse API.  ...

One clear takeaway from this thread is that FUSE performance is a topic I
don't know enough about. I'll have to explore the various novelties that
you guys have brought up to bring me up to speed.

> I belive the low-level FUSE interface does expose dentry revalidation.

It doesn't directly but Bernd pointed out that it won't invalidate dentries
if the lookup is stable, which is good enough.

> Ah, you are using erasure codes; what was the design considerations of
> using RS as opposed to having multiple copies of data blocks.  Or do
> you support both?

We support both.

> This would be great to document --- or maybe you might want to
> consider creating a "Design and Implementation of TernFS" paper and
> submitting to a conference like FAST.  :-)

The blog post was intended to be that kind of document, but we might consider a
more detailed/academic publication!

Thanks,
Francesco

