Return-Path: <linux-fsdevel+bounces-51698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8673ADA4E8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 02:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F3143AFC44
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 00:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC1913EFF3;
	Mon, 16 Jun 2025 00:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="bXCf3n7V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PMbfnxhn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b7-smtp.messagingengine.com (flow-b7-smtp.messagingengine.com [202.12.124.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78547081E;
	Mon, 16 Jun 2025 00:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750033458; cv=none; b=QXUNDVCuoqxYMzioB3nbjSH2Keudtu3Pu/JUHbiClk4/uUGoGT15KSMLSlLeVsFadjE8xTjkYVCrhS242tptTGVs7gc8MH23Zo+DhkZMOIXhBllMTROMapuq4mS7c1/rrRKLhoA9cYNfk+NT8vRNmUFOLC50Lr5jJ4pnVw2nT24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750033458; c=relaxed/simple;
	bh=7IEXinyr3qu+jpHKjO0L1jY42EFY0LL+w6E8nr4YOFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IeQIPtBHXv8KmsaM7wwOi7xQar9HKstcq7QaukZ6alJLKuPWotF9D0tFWT+T6oITSmaGEttpr3ViSpMyyZCUUkeMJNd7UpqfQ3A72yTCOm7UjGAGQF4inQ/oKIpVkFbOSkhLp08mS1MNHAMm8r/HtN3wivXrcO3zmhEgHkdRjaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=bXCf3n7V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PMbfnxhn; arc=none smtp.client-ip=202.12.124.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailflow.stl.internal (Postfix) with ESMTP id 48BDE1D4082A;
	Sun, 15 Jun 2025 20:24:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Sun, 15 Jun 2025 20:24:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1750033454;
	 x=1750040654; bh=8XxnGjJACOVia4cn5ERhWjKKo8PzonUiAuxALjFwG0o=; b=
	bXCf3n7VuvaUpovBnqRHm3GiY3CSy1XzZIK7rSOmGFXx3PuC54oDWK2JQ1Ea5Ddf
	o+jfDdPmWDrtCK2dYVqAqY0yDwe9GFGhEXuAhrhvowhPuxHR8S4gSKAThODYFxGh
	x0v9h71Efw5JlDJ745eXwPWFPwkycyCEkkxXMoN0gc9mvfx+5FdMCVsvyZEQnZVU
	H+XWqI3lwsqoIbx8d5P07GJPKEa5gTlEg2uvx5sPRz/FtWYYiCSubBavS/TDrv1f
	KUEUxTS/1tKTZ/w4BiZ1ux822SnFnZsT1RH+1LTmcBPl0zCjfjE9zdLNwMrG2AoJ
	e9Id/QFg/29V+3dQNz+RjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750033454; x=
	1750040654; bh=8XxnGjJACOVia4cn5ERhWjKKo8PzonUiAuxALjFwG0o=; b=P
	MbfnxhnSn1AdKWz26b8N0TkgCI/O2oMLub5GJWlfF2CrqX+DEeQIJR8h5pJnx68A
	ndivHfR9nSJSxWHJWEzHyMqyqDyEOON2fdBLzbzsq55XpmlWAmxI/e1BHzPXZKza
	EQQKjndwd9gRnwPIYzcAafg/xTR/CnJf/HOoNdyT10K3+vdkHCwxondRUcGufOHO
	690XlpvFp3qm7YtQbolgdFx3YV+ufTG+mznCXJOjs9E/OrFJ1IhT4l4nLoT9qifa
	isnDtvVmpg2NksRy8o3zsFk+RPv2itBsnS7QziOAd6pD2sgMiS9vTtRotnB2ft9p
	M9XLoFiCcUYp9nsl+pGCQ==
X-ME-Sender: <xms:LGRPaLfMG2IJ_bjfC-NR90Aj_ZqR_Z1AOhRNL1HAf4Nd5vJHOadz1g>
    <xme:LGRPaBOwbHIni36zHeRrKLVr9wzU7vqLj-h6MwLs5Z5ryp7tDurKqByTetjcVKc8M
    L8C7aO72uVJNUX_qqI>
X-ME-Received: <xmr:LGRPaEhiXCH5Qq9ewEOl_W3wK9Yd9GVe9I3djR6Ohh9dEt0wns69YAtosxaO_dWShQjp2l68e4jOS5eAHqKBvX53>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvhedufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddv
    jeenucfhrhhomhepvfhinhhgmhgrohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqe
    enucggtffrrghtthgvrhhnpeegkeffgeffuefhfeeitdejteeufeelleefudegkeevffdv
    vdejtddvvdeihffgjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifthhmrdho
    rhhgpdhnsggprhgtphhtthhopedvfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgrtghksehsuhhs
    vgdrtgiipdhrtghpthhtohepshhonhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepnhgvihhlsegsrhhofihnrdhn
    rghmvgdprhgtphhtthhopegsphhfsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:LWRPaM_05YPq9EbFoM_D5Y4YloADqBNm_doNvBJRp-X2dRt1pZEDCw>
    <xmx:LWRPaHv68i9Nz7_OZZN6v6E2e1pGEz-rTqh1ZZaJijw33wporeII5A>
    <xmx:LWRPaLHEycsNNAVRSCiOw_pDdpoHtvhQSOtc4f3W65SC_u02STsXlQ>
    <xmx:LWRPaONWaU-9u3mHb3OUD_VPOhjHF7rBGhgw_3BN9IWGhd_Ev-IUmQ>
    <xmx:LmRPaAUal7HQ6HwmXR8Swz5gXSWR1kiUQYXsPZy2Fdo2n7-5oHgfMUOb>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 15 Jun 2025 20:24:10 -0400 (EDT)
Message-ID: <afe77383-fe56-4029-848e-1401e3297139@maowtm.org>
Date: Mon, 16 Jun 2025 01:24:09 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Ref-less parent walk from Landlock (was: Re: [PATCH v3 bpf-next 1/5]
 namei: Introduce new helper function path_walk_parent())
To: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Song Liu <song@kernel.org>
Cc: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 NeilBrown <neil@brown.name>, bpf@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, kernel-team@meta.com,
 andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, viro@zeniv.linux.org.uk, kpsingh@kernel.org,
 mattbobrowski@google.com, amir73il@gmail.com, repnop@google.com,
 jlayton@kernel.org, josef@toxicpanda.com, gnoack@google.com
References: <20250606213015.255134-1-song@kernel.org>
 <20250606213015.255134-2-song@kernel.org>
 <174959847640.608730.1496017556661353963@noble.neil.brown.name>
 <CAPhsuW6oet8_LbL+6mVi7Lc4U_8i7O-PN5F1zOm5esV52sBu0A@mail.gmail.com>
 <20250611.Bee1Iohoh4We@digikod.net>
 <CAPhsuW6jZxRBEgz00KV4SasiMhBGyMHoP5dMktoyCOeMbJwmgg@mail.gmail.com>
 <e7115b18-84fc-4e8f-afdb-0d3d3e574497@maowtm.org>
 <CAPhsuW4LfhtVCe8Kym4qM6s-7n5rRMY-bBkhwoWU7SPGQdk=bw@mail.gmail.com>
 <csh2jbt5gythdlqps7b4jgizfeww6siuu7de5ftr6ygpnta6bd@umja7wbmnw7j>
 <zlpjk36aplguzvc2feyu4j5levmbxlzwvrn3bo5jpsc5vjztm2@io27pkd44pow>
 <20250612-erraten-bepacken-42675dfcfa82@brauner>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20250612-erraten-bepacken-42675dfcfa82@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/12/25 13:31, Christian Brauner wrote:
> On Thu, Jun 12, 2025 at 11:49:08AM +0200, Jan Kara wrote:
>> On Thu 12-06-25 11:01:16, Jan Kara wrote:
>>> On Wed 11-06-25 11:08:30, Song Liu wrote:
>>>> On Wed, Jun 11, 2025 at 10:50 AM Tingmao Wang <m@maowtm.org> wrote:
>>>>> [...]
>>>>> Aside from the "exposing mount seqcounts" problem, what do you think about
>>>>> the parent_iterator approach I suggested earlier?  I feel that it is
>>>>> better than such a callback - more flexible, and also fits in right with
>>>>> the BPF API you already designed (i.e. with a callback you might then have
>>>>> to allow BPF to pass a callback?).  There are some specifics that I can
>>>>> improve - Mickaël suggested some in our discussion:
>>>>>
>>>>> - Letting the caller take rcu_read_lock outside rather than doing it in
>>>>> path_walk_parent_start
>>>>>
>>>>> - Instead of always requiring a struct parent_iterator, allow passing in
>>>>> NULL for the iterator to path_walk_parent to do a reference walk without
>>>>> needing to call path_walk_parent_start - this way might be simpler and
>>>>> path_walk_parent_start/end can just be for rcu case.
>>>>>
>>>>> but what do you think about the overall shape of it?
>>>>
>>>> Personally, I don't have strong objections to this design. But VFS
>>>> folks may have other concerns with it.
>>>
>>> From what I've read above I'm not sure about details of the proposal but I
>>> don't think mixing of RCU & non-RCU walk in a single function / iterator is
>>> a good idea. IMHO the code would be quite messy. After all we have
>>> follow_dotdot_rcu() and follow_dotdot() as separate functions for a reason.
>>> Also given this series went through several iterations and we don't yet
>>> have an acceptable / correct solution suggests getting even the standard
>>> walk correct is hard enough. RCU walk is going to be only worse. So I'd
>>> suggest to get the standard walk finished and agreed on first and
>>> investigate feasibility of RCU variant later.
>>
>> OK, I've now read some of Tingmaon's and Christian's replies which I've
>> missed previously so I guess I now better understand why you complicate
>> things with RCU walking but still I'm of the opinion that we should start
>> with getting the standard walk working. IMHO pulling in RCU walk into the
>> iterator will bring it to a completely new complexity level...
> 
> I would not want it in the first place. But I have a deep seated
> aversion to exposing two different variants.

Hi Christian, Jan, Song,

I do appreciate your thoughts here and thanks for taking the time to
explain.  I just have some specific points which I would like you to
consider:

Taking a step back, maybe the specific designs need a bit more thought,
but are you at all open to the idea of letting other subsystems take
advantage of a rcu-based parent walk?  Testing shows that for specific
cases of a deep directory hierarchy the speedup (for time in Landlock) can
be almost 60%, and still very significant for the average case. [1]

I think what I'm proposing here is basically what follow_dotdot_rcu
already does (aside from checking rename_seq, but actually that was mostly
a conservative check. I think we're good even if we just check dentry seq
across the path walk calls), and in fact given the latest suggestion to
base the path walk helper on a modified version of follow_dotdot (that
takes path argument instead of using nameidata), I can see one approach
here being to do the same for follow_dotdot_rcu (i.e. extracting the logic
from start to before "nd->next_seq = read_seqcount_begin(&parent->d_seq);").
That way, we will not be "inventing" any new code that messes with VFS
internals.

In respect to the comment from Jan, I'm putting the suggestion out right
now to avoid only surfacing this ask after Song's path iterator API has
just been merged.  I'm not saying we have to do it here and now, but if
there is at all a possibility of incorporating rcu-based walk in this
helper (or a separate helper - I personally don't mind either way), I
would like to make sure that possibility stays open.

I'm happy to wait till Song's current patch is finished before continuing
this, but if there is strong objection to two separate APIs, I would
really appreciate if we can end up in a state where further change to
implement this is possible.

> Especially if the second variant wants or needs access to internal details
> such as mount or dentry sequence counts. I'm not at all in favor of that.

I don't want to expose VFS internals, but are you worried about even
making use of them?  (well, rename_lock and d_seq is already accessible
from outside since they are defined in include/linux/dcache.h, and so it's
just the (readout of the) mount seqcount here that will gain additional
exposure, but maybe we can mark it with __private.)

Would it be less worrying if any checks against those seqcount values are
kept within follow_dotdot_rcu, but just that it is stored in an iterator
that outside code are supposed to treat as opaque?  (We can maybe define
the semantic here as basically "this iterator makes sure your rcu walk
can't result in states where a reference-taking walk won't get to, as long
as you retry when the function returns -EAGAIN (or maybe -ECHILD)").

[1]: https://lore.kernel.org/all/cover.1748997840.git.m@maowtm.org/#t

Thanks a lot,
Tingmao

