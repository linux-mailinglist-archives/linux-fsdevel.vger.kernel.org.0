Return-Path: <linux-fsdevel+bounces-51346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 329BEAD5D71
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 19:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91A58188526C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 17:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CB123958C;
	Wed, 11 Jun 2025 17:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="gEUXmPkr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iCCdAfDC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a1-smtp.messagingengine.com (flow-a1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8400199FB2;
	Wed, 11 Jun 2025 17:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749664231; cv=none; b=l8oO1+FtPcvSKaXCX2ISZ9eOZuh5sOBlGXHY+7i08swpK/wIHpZ2qzO7vMU56BMNQ2w+K73345ykQPEE7TSH3+m8LD3zMFaKgKFV28OjpFg10dOUO+RFyItJmtMDpsv9JiyRcoKwkHK0+LLYXr63eipjheBL11dtwjk7vW9yAO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749664231; c=relaxed/simple;
	bh=FvaJG3csRIhufY2j9Z5lBoDXVgGGG2u7OOkcIKKSgaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BhXy9fm49Yb9UKzSMhlMO2eWnPEGfPrwdNTM5tNIg6YnxZJzaidezxpzxORBn4+RgQhOG52iETG+XV5F+mYxLJUMuGXt1fjKa8hbgSuHgHe2K7R4gAyGh0wRUNk3AGhe/bxIBVeYEgmdjvku9ABUw3FIo0jeXL2yVHHU8dKKNzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=gEUXmPkr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iCCdAfDC; arc=none smtp.client-ip=103.168.172.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id 8EBFE200464;
	Wed, 11 Jun 2025 13:50:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 11 Jun 2025 13:50:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1749664228;
	 x=1749671428; bh=eA33SKebzGAA9s0Ux6MuIF8txMGk1s/MAbhi7UZZs/s=; b=
	gEUXmPkrFq9V98viX0NjAtkbyoNrEQh+xcTb93v67xHjoNyQ9hdKvbrabw1lcwZe
	N+GzpjGjE6KFnbi+yM4ziRPRNc2yQiPGHPI2rLDefvrW139SMUeiO5hOzoSkTLb3
	kTPvFpChPgFDhQ/7rKAi+Ahp7cbMwp3XHfAgcEvUruYPNW1s+3AfgZme7hDlf1/U
	JQw5IqER5l42oKuYBBNwx/Mtw9lBbX8xJlPlhMht9r2DbYSl+NItHSjSyS+Ttj0H
	dSaZ50e2optbDVMdrdOf+2mL6zC3osYKj2LArJ5pdxoPVO8zSwmBqQ2p+ui0LmmY
	mhRKeugKHFgDEF5WYy3Y0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749664228; x=
	1749671428; bh=eA33SKebzGAA9s0Ux6MuIF8txMGk1s/MAbhi7UZZs/s=; b=i
	CCdAfDClQMCvMnxQpHHf7gc6rrr3Cso7caXsZ1B+Eps455aGm7XTKE4yMUf/IOLW
	xDtcgUElEu9K54HfEGkW8E39YRmwe7tRuOE7xvmD8hO8PHwhuUFs8Y3MF+jyiSpY
	vsRlNJUVhWOBj13d54Reyd3/eJfXVNwVgx1+SBldWAettFBkU/vtVgCUU7bjEHtE
	ZMlmDwNVsnq5hkbnxLdhCVkTcj0UNit9UnFhltuQ8dt1sAZUVV7xRhF3qJx9U/ws
	X8hAv3h/xSKtInPMesF5FhkEhlHprvKk5bPfNjfLrFUOfUGD7LpubN1KfUdG24CK
	GA5puyee+xYVFeGyjp12w==
X-ME-Sender: <xms:48FJaGgmgCT8NrqyzPRMUCTZ3MJwm2cwwuGJR-FyBe_ZFYA6PLuV_A>
    <xme:48FJaHDm54wmkWBIkAFDb8rjCAVewfj6x8mP-G_VLAihuLaktvC-V4dlK93ZVAFI7
    H8xmsxgymO3kdjmZxM>
X-ME-Received: <xmr:48FJaOEVZt6w7nVDWazjth9bwyQ9-19zwHjb4JpvGFeJmn88Gd3fxWzPp4CjL-7Leofx-fY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduvdekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddv
    jeenucfhrhhomhepvfhinhhgmhgrohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqe
    enucggtffrrghtthgvrhhnpedukeevhfegvedvveeihedvvdeghfeglefgudegfeetvdek
    iefgledtheeggefhgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehmsehmrghofihtmhdrohhrghdpnhgspghrtghpthhtohepvdefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepmhhitgesughighhikhhougdrnhgvthdprhgtphhtthhopehnvghilhessghr
    ohifnhdrnhgrmhgvpdhrtghpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtoh
    epsghpfhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhf
    shguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugi
    dqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhu
    gidqshgvtghurhhithihqdhmohguuhhlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehkvghrnhgvlhdqthgvrghmsehmvghtrgdrtghomh
X-ME-Proxy: <xmx:48FJaPTibvdXpRf4dEbBHjP2j_m4Q4HywL1rb6Md14zdoofmnkQCtg>
    <xmx:48FJaDyeUQduz7FMROkkZ7htsreGZDlxessxM_n_yig_sIKGi0AeoA>
    <xmx:48FJaN7jINoJbi6cH1rZWjmajmqKTzvmwGXYM-MgOdVe1VsKDkWlKA>
    <xmx:48FJaAwLAHSVgjBViOU1_M8IQf0ozZwS9SRisCPHjj3zWkaIy7EAbA>
    <xmx:5MFJaD67w1xy9KHUjplsFvQqyTSjOu_mdjGVuEn997plgYw5XDIQyHc0>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Jun 2025 13:50:25 -0400 (EDT)
Message-ID: <e7115b18-84fc-4e8f-afdb-0d3d3e574497@maowtm.org>
Date: Wed, 11 Jun 2025 18:50:24 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 bpf-next 1/5] namei: Introduce new helper function
 path_walk_parent()
To: Song Liu <song@kernel.org>, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>
Cc: NeilBrown <neil@brown.name>, Jan Kara <jack@suse.cz>,
 bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, viro@zeniv.linux.org.uk,
 brauner@kernel.org, kpsingh@kernel.org, mattbobrowski@google.com,
 amir73il@gmail.com, repnop@google.com, jlayton@kernel.org,
 josef@toxicpanda.com, gnoack@google.com
References: <20250606213015.255134-1-song@kernel.org>
 <20250606213015.255134-2-song@kernel.org>
 <174959847640.608730.1496017556661353963@noble.neil.brown.name>
 <CAPhsuW6oet8_LbL+6mVi7Lc4U_8i7O-PN5F1zOm5esV52sBu0A@mail.gmail.com>
 <20250611.Bee1Iohoh4We@digikod.net>
 <CAPhsuW6jZxRBEgz00KV4SasiMhBGyMHoP5dMktoyCOeMbJwmgg@mail.gmail.com>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <CAPhsuW6jZxRBEgz00KV4SasiMhBGyMHoP5dMktoyCOeMbJwmgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/11/25 17:31, Song Liu wrote:
> On Wed, Jun 11, 2025 at 8:42 AM Mickaël Salaün <mic@digikod.net> wrote:
> [...]
>>> We can probably call this __path_walk_parent() and make it static.
>>>
>>> Then we can add an exported path_walk_parent() that calls
>>> __path_walk_parent() and adds extra logic.
>>>
>>> If this looks good to folks, I can draft v4 based on this idea.
>>
>> This looks good but it would be better if we could also do a full path
>> walk within RCU when possible.
> 
> I think we will need some callback mechanism for this. Something like:
> 
> for_each_parents(starting_path, root, callback_fn, cb_data, bool try_rcu) {
>    if (!try_rcu)
>       goto ref_walk;
> 
>    __read_seqcount_begin();
>     /* rcu walk parents, from starting_path until root */
>    walk_rcu(starting_path, root, path) {
>     callback_fn(path, cb_data);
>   }
>   if (!read_seqcount_retry())
>     return xxx;  /* successful rcu walk */
> 
> ref_walk:
>   /* ref walk parents, from starting_path until root */
>    walk(starting_path, root, path) {
>     callback_fn(path, cb_data);
>   }
>   return xxx;
> }
> 
> Personally, I don't like this version very much, because the callback
> mechanism is not very flexible, and it is tricky to use it in BPF LSM.

Aside from the "exposing mount seqcounts" problem, what do you think about
the parent_iterator approach I suggested earlier?  I feel that it is
better than such a callback - more flexible, and also fits in right with
the BPF API you already designed (i.e. with a callback you might then have
to allow BPF to pass a callback?).  There are some specifics that I can
improve - Mickaël suggested some in our discussion:

- Letting the caller take rcu_read_lock outside rather than doing it in
path_walk_parent_start

- Instead of always requiring a struct parent_iterator, allow passing in
NULL for the iterator to path_walk_parent to do a reference walk without
needing to call path_walk_parent_start - this way might be simpler and
path_walk_parent_start/end can just be for rcu case.

but what do you think about the overall shape of it?

And while it is technically doing two separate things (rcu walk and
reference walk), so is this callback to some extent.  The pro of callback
however is that the retry on ref walk failure is automatic, but the user
still has to be aware and detect such cases.  For example, landlock needs
to re-initialize the layer masks previously collected if parent walk is
restarting.

(and of course, this also hides the seqcounts from non VFS code, but I'm
wondering if there are other ways to make the seqcounts in the
parent_iterator struct private, if that is the only issue with it?)

Also, if the common logic with follow_dotdot is extracted out to
__path_walk_parent, path_walk_parent might just defer to that for the
non-rcu case, and so the complexity of that function is further reduced.

> 
> Thanks,
> Song


