Return-Path: <linux-fsdevel+bounces-23411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A3392BDD4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 17:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B013E1F22813
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 15:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306A219CD0C;
	Tue,  9 Jul 2024 15:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="iLpfnOag";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oFnAoLNN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C89C364AB;
	Tue,  9 Jul 2024 15:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720537702; cv=none; b=EY0VCzV/Iu0xFge2fC2AfPBKcJEFXN5I7i9WH9yk+hfTt7HG4POQR+jrfrG97wmizyhYZb1hgdaf1qZVYKagsYmIbncK4CfNDLFkac6Crf3+UXacS0dwN3msRYfnsbbIEfTEdidIySf+E5c/UY+vlkU6Mr9AASpmBYgJllbS6xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720537702; c=relaxed/simple;
	bh=fXbDru/y5W+0JkwcQ1yBuNSWXsbd+IcKjgtGIm71ni4=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=f4uIEzoK4OvKw9l1thDnl0Bv/GlOOMNgRHU/tx0BZD1gvWp/rmdWd+dSj9L7K675SEznKZcKaxPv7TS/2UqDsixdJUcXhjWy3CvxIIdJnR4XH6nbr8i2O5mGplqwMDoNTri1PQcTjosJZISRPsoJ6dTEHBBSayEyzmSyv9iIah4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=iLpfnOag; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oFnAoLNN; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 253841380AB9;
	Tue,  9 Jul 2024 11:08:20 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 09 Jul 2024 11:08:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1720537700; x=1720624100; bh=YjpIAB6VJt
	vWW8uBMTlGJyRpx0vtfYCfo/jXt2pillU=; b=iLpfnOagzPr2Dua+U0ooLlHBdS
	th5AtQBXJzgZDRZBLaWiH/P4KxKJRI2z57hknrK0idjAzvxn9nXsjInQmaphiG7F
	foZF/TF3SNUiX2fpxNu29iNKnzi35Pz+keTR6cl/qW06M8h6ZCJSAcZMTiXV7rpD
	CkJ05DRdx/yeKr+eRUWD9ccr0LJzaF6YDhYbH84C7Kln8BaQFB6dI3xDeJMWM3Z0
	4EWhheJJ0REKc6nKkSM+T9DpcCU7BgPX1EhjatN7WkhzOFNrM/Xsif7sHN28a5GE
	YsxPIp+58bWi3tMIMTyDEvPZNkgfXzztdwOyJMXqMZ5TNkXRVk88262/TcGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1720537700; x=1720624100; bh=YjpIAB6VJtvWW8uBMTlGJyRpx0vt
	fYCfo/jXt2pillU=; b=oFnAoLNN4oY1qxSbUi3JC4rnLtSi1UhjU9sjzZN52jah
	7gs+/cqZhrupcoS9UA5AzssN2Rt7O+cjoMfkAmBnFjsvR5HyIlh15albjuqjrFlh
	YuwZ7ZR7ZYxEI9SwaYteuci10eKxK/lmlOnSsULzvn9HPGqhomrjO53Dwa+dN8Ad
	B5Zu2LuSSa10k8exLcaInN8/Ie9w1TH+FV6uyf+aJ0jsKMr31Dy6deph0t0G5aC5
	8FfbIFpUweIVd7Y3FEdvnx7jDVbyHKvXIPNmD8tdXtpQ/WG3nNrETvoVhl+E7s1y
	Z2F3ko9ajJz/hzXThm3ttO798L3u1h4rV3/9Y8jHhA==
X-ME-Sender: <xms:YlKNZpUkzhbTFq9YFbXbA5Hax3ZdK7swz798ECa_uTJzX2DrnGaSjg>
    <xme:YlKNZpmN9SHFiyrOIhx7cNHEX7dCZKF6SbgC5R9SH__LiCDdbJE_MD4IvTaF7HIe0
    cdivCbuDoaoqM2yo0k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdelgdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:YlKNZlYYMUFRcHB-45hUdzEqPn8ha4yHDNf2u4JQfuhjopsqYvi5WQ>
    <xmx:YlKNZsUM8CV98fuioFIhb-xOBSf5JmGWSttzJ302oc8e92-BOkrF0Q>
    <xmx:YlKNZjkyjqp5shhdF_-KYL9a2r_U2QHUlaPTdhaIz1nTwbtCOZMcjg>
    <xmx:YlKNZpc0HZssxCYMTZSHCMQ6AF6ejTYkIhUEiiSm1gMRoCg7aRNhUQ>
    <xmx:ZFKNZsD3_VjqDy_CMPnB88AtMDTG5Escgl8QuUyvfaBzWhdMPyjhyJI5>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id BDFF1B6008D; Tue,  9 Jul 2024 11:08:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <92726965-19a0-433b-9b49-69af84b25081@app.fastmail.com>
In-Reply-To: <6ab599393503a50b4b708767f320a46388aa95f2.camel@kernel.org>
References: <202407091931.mztaeJHw-lkp@intel.com>
 <c1d4fcee3098a58625bb03c8461b92af02d93d15.camel@kernel.org>
 <CAMuHMdVsDSBdz2axqTqrV4XP8UVTsN5pPS4ny9QXMUoxrTOU3w@mail.gmail.com>
 <c4df5f73-2687-4160-801c-5011193c9046@app.fastmail.com>
 <6ab599393503a50b4b708767f320a46388aa95f2.camel@kernel.org>
Date: Tue, 09 Jul 2024 17:07:58 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jeff Layton" <jlayton@kernel.org>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Subject: Re: [jlayton:mgtime 5/13] inode.c:undefined reference to
 `__invalid_cmpxchg_size'
Content-Type: text/plain

On Tue, Jul 9, 2024, at 16:23, Jeff Layton wrote:
> On Tue, 2024-07-09 at 16:16 +0200, Arnd Bergmann wrote:
>> On Tue, Jul 9, 2024, at 15:45, Geert Uytterhoeven wrote:
>
> I think the simplest solution is to make the floor value I'm tracking
> be an atomic64_t. That looks like it should smooth over the differences
> between arches. I'm testing a patch to do that now.

Yes, atomic64_t should work, but be careful about using this
in a fast path since it can turn into a global spinlock
in lib/atomic64.c on architectures that don't support it
natively.

I'm still reading through the rest of your series, but
it appears that you pass the time value into 
ktime_to_timespec64() directly afterwards, so I guess
that is already a fairly large overhead on 32-bit
architectures and an extra spinlock doesn't hurt too
much.

Two more things I noticed in your patch:

- smp_load_acquire() on a 64-bit variable seems problematic
  as well, maybe this needs a spinlock on 32-bit
  architectures?

- for the coarse_ctime function, I think you should be
  able to avoid the conversion to timespec by just calling
  ktime_get_coarse_real_ts64() again instead of converting
  monotonic to real and then to timespec.

- inode_set_ctime_current() seems to now store a fine-grained
  timespec in the inode even for the !is_mgtime case, skipping
  the timestamp_truncate() step. This appears to potentially
  leak a non-truncated value to userspace, which would be
  inconsistent with the value read back from disk.

      Arnd

