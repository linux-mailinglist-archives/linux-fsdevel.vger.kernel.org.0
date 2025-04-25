Return-Path: <linux-fsdevel+bounces-47329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 448E5A9C1D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 10:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56D25922255
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 08:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCDF23814C;
	Fri, 25 Apr 2025 08:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readahead.eu header.i=@readahead.eu header.b="ElLrvg4w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HnXq2HQk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994F1230BD8;
	Fri, 25 Apr 2025 08:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745570352; cv=none; b=Pvh3/UFo+FG2VdpipEgC8lDFxQ9VEQ1M1rUPyPYgFbldkgiTE2AWzi+YyO71uZ0Bq/JFQME5OYItY0AVN4QZHdxokVPJkEa+wx79QQ+UNBMS0ffNEzkhKgRTui7yBxRzg451pOjxN9d3TFS7D3CGdGgdIkBSIeJ3kfqfu4/zuoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745570352; c=relaxed/simple;
	bh=/yXX9pgvUOeDvQBrbXVUN8W1QFyPQNhdnV+dJfUxJ/4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=N/u/bp0153zeH+P9XyHV1tiA6XQ6XOEZ9YAK+HfYCqR2qHxpH5V5dI5drGiApeGQdeiEru74gtNfQl3dQ54MOLRuVvBKBOCA+J8cBVChXC1zeDSrQauQTd1ssRfyhLP0qeZo9udzG5vV2cOy+TkS5XeQe6UzsfG0yLCTfYt+g9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readahead.eu; spf=pass smtp.mailfrom=readahead.eu; dkim=pass (2048-bit key) header.d=readahead.eu header.i=@readahead.eu header.b=ElLrvg4w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HnXq2HQk; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readahead.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=readahead.eu
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8AA911140218;
	Fri, 25 Apr 2025 04:39:06 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-02.internal (MEProxy); Fri, 25 Apr 2025 04:39:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=readahead.eu; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1745570346;
	 x=1745656746; bh=XnvyM4plL/VWjKsIduuUMp0AGlTQ6ZHweSxORhSaPAI=; b=
	ElLrvg4w9Et7djySJSaqsYYSTHeWOyllNLyST+gW14VDygocISieLR9UdjIZ+KmC
	juSTvFM/pE++E/8BEkxj19/z8YPByQGEKkwsP4gY8MP1g1QcljoPcC3SL60vTLst
	ZeRZ3CG2YeHpap7ua+IeQJh8gx42N4ozi+6DUo/ulK7BK7OktIRMnB0qxgaPse7o
	tGaYaCEETlf1Hqk0u75ojP8cwNaF6Fln5ZvOkkhh0jYy+cUaqMcsV3qaZvI5qfam
	9/aHmF1O/uJLqmqo67zcZIsHgrilNcfCOqbdcRm3hzrg3003yqqof6FuP1WaGuO5
	w50E/SV2UAatd+/Uuh5aUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745570346; x=
	1745656746; bh=XnvyM4plL/VWjKsIduuUMp0AGlTQ6ZHweSxORhSaPAI=; b=H
	nXq2HQkrvQn3KCcT5xydJEpqiiQl7MVuZNAG49oq2mBpX/3aChiXeVfYqZZXNBsb
	Azzivimrjd2yLv6PsweCIQIlcHvgG5V1Ipc3LbqRm0hPsjYaZSFp/54QMaxaF1FG
	c0LXGyD3db04E6y6HCbhW1ygXPp4N3U5rlo9f8LKDExT/d+PwPdYQE8dTJBhuxeo
	dZo85rBk31QDlRR0oXkkY5z2h1Sf81/cogAl78PhY+5X3I2iMoO6meenkI8xYPyb
	t+ZeOgDwY/gMuEaq7p7x2hWUt3quX2yCkDU36aCq+xMcKbtm2YA8ihKCO21JZ9IY
	91V+EwTnt6ORg9hUVl3lw==
X-ME-Sender: <xms:KUoLaD6BrvEtZ243u7bFoc8e9rwbadWeZIvtNJDTmD4PSD2k6BJdzg>
    <xme:KUoLaI7XiODhi5OEFyHIwV_a9U6_ZUHmr70_8HnPzBOXcTFZXD6E5IbvsWhepshRt
    pzkDQtkdyXHnImMWso>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedukeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedfffgrvhhiugcutfhhvghinhhssggvrhhgfdcuoegurghvihguse
    hrvggruggrhhgvrggurdgvuheqnecuggftrfgrthhtvghrnhepueekteduueejkeehheel
    vdefleeivdeugfekvdfffefgkeefuedvtdfftddvveeknecuffhomhgrihhnpehkvghrnh
    gvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpegurghvihgusehrvggruggrhhgvrggurdgvuhdpnhgspghrtghpthhtohepudejpd
    hmohguvgepshhmthhpohhuthdprhgtphhtthhopehkuhhnihihuhesrghmrgiiohhnrdgt
    ohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtth
    hopegslhhutggrseguvggsihgrnhdrohhrghdprhgtphhtthhopegurggrnhdrjhdruggv
    mhgvhigvrhesghhmrghilhdrtghomhdprhgtphhtthhopegvughumhgriigvthesghhooh
    hglhgvrdgtohhmpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhusggrse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgigrnhguvghrsehmihhhrghlihgt
    hihnrdgtohhm
X-ME-Proxy: <xmx:KUoLaKezNV5TdX96i0hcAXZKW3tm6pFEMxn8sTIOZDrBuk57bcaD2g>
    <xmx:KUoLaEL0HBEybq4fRAGMpvl_p3k_Gv17OTAfwTitj1SgF2xPUZlleQ>
    <xmx:KUoLaHIQ4_Famr47P1XAtLg60JsEtUkoVugx3jiRQ_-WFWkEs6PxCQ>
    <xmx:KUoLaNwIc4QoBzJj044NWxyyLX0M298_kQkkjvHyZtpnwF_FybuOoQ>
    <xmx:KkoLaJ6jLFtsEBhotZ1JZwTKqfiy1M1m9ZDxDzQ24RlSdI1h-jobmHpy>
Feedback-ID: id2994666:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8536F18A006B; Fri, 25 Apr 2025 04:39:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tbcbd793788c73c94
Date: Fri, 25 Apr 2025 10:38:45 +0200
From: "David Rheinsberg" <david@readahead.eu>
To: "Christian Brauner" <brauner@kernel.org>,
 "Oleg Nesterov" <oleg@redhat.com>, "Kuniyuki Iwashima" <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 netdev@vger.kernel.org, "Jan Kara" <jack@suse.cz>,
 "Alexander Mikhalitsyn" <alexander@mihalicyn.com>,
 "Luca Boccassi" <bluca@debian.org>,
 "Lennart Poettering" <lennart@poettering.net>,
 "Daan De Meyer" <daan.j.demeyer@gmail.com>, "Mike Yuan" <me@yhndnzj.com>
Message-Id: <4950895a-9b99-4ec3-981c-a392a20ce74c@app.fastmail.com>
In-Reply-To: <20250425-work-pidfs-net-v2-0-450a19461e75@kernel.org>
References: <20250425-work-pidfs-net-v2-0-450a19461e75@kernel.org>
Subject: Re: [PATCH v2 0/4] net, pidfs: enable handing out pidfds for reaped
 sk->sk_peer_pid
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi

On Fri, Apr 25, 2025, at 10:11 AM, Christian Brauner wrote:
> SO_PEERPIDFD currently doesn't support handing out pidfds if the
> sk->sk_peer_pid thread-group leader has already been reaped. In this
> case it currently returns EINVAL. Userspace still wants to get a pidfd
> for a reaped process to have a stable handle it can pass on.
> This is especially useful now that it is possible to retrieve exit
> information through a pidfd via the PIDFD_GET_INFO ioctl()'s
> PIDFD_INFO_EXIT flag.
>
> Another summary has been provided by David in [1]:
>
>> A pidfd can outlive the task it refers to, and thus user-space must
>> already be prepared that the task underlying a pidfd is gone at the time
>> they get their hands on the pidfd. For instance, resolving the pidfd to
>> a PID via the fdinfo must be prepared to read `-1`.
>>
>> Despite user-space knowing that a pidfd might be stale, several kernel
>> APIs currently add another layer that checks for this. In particular,
>> SO_PEERPIDFD returns `EINVAL` if the peer-task was already reaped,
>> but returns a stale pidfd if the task is reaped immediately after the
>> respective alive-check.
>>
>> This has the unfortunate effect that user-space now has two ways to
>> check for the exact same scenario: A syscall might return
>> EINVAL/ESRCH/... *or* the pidfd might be stale, even though there is no
>> particular reason to distinguish both cases. This also propagates
>> through user-space APIs, which pass on pidfds. They must be prepared to
>> pass on `-1` *or* the pidfd, because there is no guaranteed way to get a
>> stale pidfd from the kernel.
>> Userspace must already deal with a pidfd referring to a reaped task as
>> the task may exit and get reaped at any time will there are still many
>> pidfds referring to it.
>
> In order to allow handing out reaped pidfd SO_PEERPIDFD needs to ensure
> that PIDFD_INFO_EXIT information is available whenever a pidfd for a
> reaped task is created by PIDFD_INFO_EXIT. The uapi promises that reaped
> pidfds are only handed out if it is guaranteed that the caller sees the
> exit information:
>
> TEST_F(pidfd_info, success_reaped)
> {
>         struct pidfd_info info = {
>                 .mask = PIDFD_INFO_CGROUPID | PIDFD_INFO_EXIT,
>         };
>
>         /*
>          * Process has already been reaped and PIDFD_INFO_EXIT been set.
>          * Verify that we can retrieve the exit status of the process.
>          */
>         ASSERT_EQ(ioctl(self->child_pidfd4, PIDFD_GET_INFO, &info), 0);
>         ASSERT_FALSE(!!(info.mask & PIDFD_INFO_CREDS));
>         ASSERT_TRUE(!!(info.mask & PIDFD_INFO_EXIT));
>         ASSERT_TRUE(WIFEXITED(info.exit_code));
>         ASSERT_EQ(WEXITSTATUS(info.exit_code), 0);
> }
>
> To hand out pidfds for reaped processes we thus allocate a pidfs entry
> for the relevant sk->sk_peer_pid at the time the sk->sk_peer_pid is
> stashed and drop it when the socket is destroyed. This guarantees that
> exit information will always be recorded for the sk->sk_peer_pid task
> and we can hand out pidfds for reaped processes.
>
> Note, I'm marking this as RFC mostly because I'm open to other
> approaches to solving the pidfs registration. The functionality in
> general we should really provide either way.
>
> Link: 
> https://lore.kernel.org/lkml/20230807085203.819772-1-david@readahead.eu 
> [1]
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
> Changes in v2:
> - Fix typo in pidfs_register_pid() kernel documentation.
> - Remove SOCK_RCU_FREE check as it's already and better covered by 
> might_sleep().
> - Add comment to pidfd_prepare() about PIDFD_STALE only being valid if
>   the caller knows PIDFD_INFO_EXIT information is guaranteed to be
>   available.
> - Fix naming of variables and adhere to net declaration ordering.
> - Link to v1: 
> https://lore.kernel.org/20250424-work-pidfs-net-v1-0-0dc97227d854@kernel.org
>
> ---
> Christian Brauner (4):
>       pidfs: register pid in pidfs
>       net, pidfs: prepare for handing out pidfds for reaped sk->sk_peer_pid
>       pidfs: get rid of __pidfd_prepare()
>       net, pidfs: enable handing out pidfds for reaped sk->sk_peer_pid
>
>  fs/pidfs.c                 | 80 ++++++++++++++++++++++++++++++++++++++-----
>  include/linux/pid.h        |  2 +-
>  include/linux/pidfs.h      |  3 ++
>  include/uapi/linux/pidfd.h |  2 +-
>  kernel/fork.c              | 83 ++++++++++++++++----------------------------
>  net/core/sock.c            | 14 +++-----
>  net/unix/af_unix.c         | 85 ++++++++++++++++++++++++++++++++++++++++------
>  7 files changed, 183 insertions(+), 86 deletions(-)
> ---
> base-commit: b590c928cca7bdc7fd580d52e42bfdc3ac5eeacb
> change-id: 20250423-work-pidfs-net-bc0181263d38

Thank you very much! Looks good to me!

Reviewed-by: David Rheinsberg <david@readahead.eu>

Thanks
David

