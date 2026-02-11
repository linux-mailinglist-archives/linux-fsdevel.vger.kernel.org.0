Return-Path: <linux-fsdevel+bounces-76975-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKCQNknojGnquwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76975-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 21:36:25 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DFD12771A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 21:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E25E5300AC9A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 20:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F291340D86;
	Wed, 11 Feb 2026 20:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="KsN1TXQf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hfr3u1H0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDE01632E7;
	Wed, 11 Feb 2026 20:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770842180; cv=none; b=OcdtUx2fQXa9qRpMC3sBlRROb44fLdj+zdms+RLLGl5m/ENOgUTQSD6JjeMZ0OE9qepIHX4urvNdcYAbi9vJXOhEzQXwxP2kMw7Gbh0rIX8Q6gpDHOc7CpMRvB6n+zIlJ/IeWqxd6iYZtCikNyVFx+lG9N5KhdxYTAAUuseIm5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770842180; c=relaxed/simple;
	bh=JfKExKGAXbOz0IGnae61GWNu6MMiefXI457BJdV8hnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W0WPEHCqoMR8S+38wvjWljujbb9mzH9VE/gamxGkxT5Rlc+nK15017ilE8+oG/FPnn8y3upcztbdiDwYJs+5a4E8yq1zImMC6w9q/Atlh1HTMj6FQkogB7xDFVHVwLPb3Qc6gl99pu5n2QkqYFsnP/XpGXk4RGlyoFhiHMwHWC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=KsN1TXQf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hfr3u1H0; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E614A1400076;
	Wed, 11 Feb 2026 15:36:17 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 11 Feb 2026 15:36:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1770842177;
	 x=1770928577; bh=abtgy9OHuvjbDvR8RcsKvJLwI4WkSm7DPZQSxZMN0pU=; b=
	KsN1TXQfEQkstszEebHwRBFoabohirbly08FO9WDQ+8soEMe8MnT4Se39aDquj88
	TIYQr0+kE/U0dS/Fq7QknyalHGC0TGybXeDOS0cf+FEQpZxesioXEolw7zD0XMJH
	6iE5/CtuuLHprbDSSHiKSAlMLcVhJRAhphhrhFTIBotoyN4OGMwBzCnuwBp5MVXB
	mjclG4Zdz5SLHtKU3O0YaumOGHkGPmUgADewxEdAMDYAI6dGY1FRhg+HJ0sOsnIm
	bxkNnUxjT8eMt0DglkuoBCdiRIHI8/BhqjwNyYv1nDnscvk9I5QHA1H+zEmY2cXJ
	w+VY1YBMqx+VxOFKUuuNyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770842177; x=
	1770928577; bh=abtgy9OHuvjbDvR8RcsKvJLwI4WkSm7DPZQSxZMN0pU=; b=H
	fr3u1H0zJqKQighkNmemrVFT0oKP0X4pgscWOvzIJZDctxjYInZuIY3kTSO+jOQ6
	KmxX8YJ7S5GsLVeCsIVqoi7m7STK9SRZ7Qw3Ivrdia3hTBkCc9i4T6jjrUfMgcDE
	pYMyEpIhcmitQwMG8Fg7QNF12j82a4hk7RXczAp4ZiZjIJxLb61Satfh3nL6Xurn
	jQmTiQHNGRl/oGaAW5B7t4Q4axvlFyE/eOu1HUxKKQlNv0cIQfVTrO181vdvzpFH
	V0ePkb1XwDfsF0mEhtglwo6ueEY7Kw/WxxIBS1pVJ+aliaDgF6g2S9JgNh+76Re4
	kmonh8nhlVW7bpoDatFRg==
X-ME-Sender: <xms:QeiMaXbxotoCZdgtyOzGPzK8x69oUDi1_VvJjEJ_68frmvc3f9P5Zg>
    <xme:QeiMaQbxAd60Bk3lO9f-XsbNw53vEbrLIJZMrHyxeP1FSddWnnlqT_5Y4UE4aAUzS
    xb064E5iuPT5EmML4e_oWd1uyszime32m4EXoWz5e9hOuyFPuZz>
X-ME-Received: <xmr:QeiMaQmSJdNXfS2A4jB63RbARVvFjm5hRF2uL6HBcT2W1Na_OmREd2YyqdauzP00FEnEe0RSrPPv1P0wa4eZRUU5i-0g5kGALbFPpR9PklwTjDff-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdefheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeehhfejueejleehtdehteefvdfgtdelffeuudejhfehgedufedvhfehueev
    udeugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtg
    hpthhtohephhhorhhsthessghirhhthhgvlhhmvghrrdgtohhmpdhrtghpthhtohepsghs
    tghhuhgsvghrthesuggunhdrtghomhdprhgtphhtthhopehjohgrnhhnvghlkhhoohhngh
    esghhmrghilhdrtghomhdprhgtphhtthhopehluhhishesihhgrghlihgrrdgtohhmpdhr
    tghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehhsghirhhthhgvlhhmvghrseguughnrdgtohhm
X-ME-Proxy: <xmx:QeiMab1BN_efz6XHd_UDViLjP9-NdjVD304rL5WTLFQy8e3ePbMQ8w>
    <xmx:QeiMaQ0cluqiMsAxGjSfMM0bXP-ZUkAsnTNzBT1vChOkfne_fZnZIg>
    <xmx:QeiMadp_zRNXExu9NihuyZwu98T5k_PcJN1ZRB27uS6cfCI_2HMoQA>
    <xmx:QeiMacggc38TGhL-lPv2yAqR3JNPfKNIcBA6NaXNan0HnKxvlCLwrw>
    <xmx:QeiMaaTqT2LqQz57TAdQG9uQZqMVliXTHq2GGepZ9X3X9SWTPOUNmiwl>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Feb 2026 15:36:16 -0500 (EST)
Message-ID: <f38cf69e-57b9-494b-a90a-ede72aa12a54@bsbernd.com>
Date: Wed, 11 Feb 2026 21:36:14 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] fuse: add compound command to combine multiple
 requests
To: Miklos Szeredi <miklos@szeredi.hu>,
 Horst Birthelmer <horst@birthelmer.com>
Cc: Bernd Schubert <bschubert@ddn.com>, Joanne Koong
 <joannelkoong@gmail.com>, Luis Henriques <luis@igalia.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Horst Birthelmer <hbirthelmer@ddn.com>
References: <20260210-fuse-compounds-upstream-v5-0-ea0585f62daa@ddn.com>
 <20260210-fuse-compounds-upstream-v5-1-ea0585f62daa@ddn.com>
 <CAJfpegvt0HwHOmOTzkCoOqdmvU6pf-wM228QQSauDsbcL+mmUA@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJfpegvt0HwHOmOTzkCoOqdmvU6pf-wM228QQSauDsbcL+mmUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bsbernd.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[bsbernd.com:s=fm2,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[ddn.com,gmail.com,igalia.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76975-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[bsbernd.com:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernd@bsbernd.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,messagingengine.com:dkim,bsbernd.com:mid,bsbernd.com:dkim]
X-Rspamd-Queue-Id: 80DFD12771A
X-Rspamd-Action: no action



On 2/11/26 17:13, Miklos Szeredi wrote:
> On Tue, 10 Feb 2026 at 09:46, Horst Birthelmer <horst@birthelmer.com> wrote:
> 
>> +static char *fuse_compound_build_one_op(struct fuse_conn *fc,
>> +                                        struct fuse_args *op_args,
>> +                                        char *buffer_pos)
>> +{
>> +       struct fuse_in_header *hdr;
>> +       size_t needed_size = sizeof(struct fuse_in_header);
>> +       int j;
>> +
>> +       for (j = 0; j < op_args->in_numargs; j++)
>> +               needed_size += op_args->in_args[j].size;
>> +
>> +       hdr = (struct fuse_in_header *)buffer_pos;
>> +       memset(hdr, 0, sizeof(*hdr));
>> +       hdr->len = needed_size;
>> +       hdr->opcode = op_args->opcode;
>> +       hdr->nodeid = op_args->nodeid;
> 
> hdr->unique is notably missing.
> 
> I don't know.  Maybe just fill it with the index?
> 
>> +       hdr->uid = from_kuid(fc->user_ns, current_fsuid());
>> +       hdr->gid = from_kgid(fc->user_ns, current_fsgid());
> 
> uid/gid are not needed except for creation ops, and those need idmap
> to calculate the correct values.  I don't think we want to keep legacy
> behavior of always setting these.
> 
>> +       hdr->pid = pid_nr_ns(task_pid(current), fc->pid_ns);
> 
> This will be the same as the value in the compound header, so it's
> redundant.  That might not be bad, but I feel that we're better off
> setting this to zero and letting the userspace server fetch the pid
> value from the compound header if that's needed.
> 
>> +#define FUSE_MAX_COMPOUND_OPS   16        /* Maximum operations per compound */
> 
> Don't see a good reason to declare this in the API.   More sensible
> would be to negotiate a max_request_size during INIT.
> 
>> +
>> +#define FUSE_COMPOUND_SEPARABLE (1<<0)
>> +#define FUSE_COMPOUND_ATOMIC (1<<1)
> 
> What is the meaning of these flags?
> 
>> +
>> +/*
>> + * Compound request header
>> + *
>> + * This header is followed by the fuse requests
>> + */
>> +struct fuse_compound_in {
>> +       uint32_t        count;                  /* Number of operations */
> 
> This is redundant, as the sum of the sub-request lengths is equal to
> the compound request length, hence calculating the number of ops is
> trivial.
> 
>> +       uint32_t        flags;                  /* Compound flags */
>> +
>> +       /* Total size of all results.
>> +        * This is needed for preallocating the whole result for all
>> +        * commands in this compound.
>> +        */
>> +       uint32_t        result_size;
> 
> I don't understand why this is needed.  Preallocation by the userspace
> server?  Why is this different from a simple request?

With simple request and a single request per buffer, one can re-use the
existing buffer for the reply in fuse-server

- write: Do the write operation, then store the result into the io-buffer
- read: Copy the relatively small header, store the result into the
io-buffer

- Meta-operations: Same as read


Compound:
- iterate over each compound, store the result into a temporary buffer
- After completion, copy the temporary buffer back into the compound

Which then results in the choice of
- Make the temporary buffer as large as the IO buffer
- Reallocate for each compound, or something like 2x 1st buffer
- Allocate the exact size of what kernel nows the reply is supposed to
be on success

In this specific case I had especially asked to store the result size
into the compound to simplify code in libfuse.

Question, this is a just a uint32_t, does it hurt to leave it? Maybe
with the additional comment like "Optimization, not strictly needed, but
might simplify fuse-server".


Thanks,
Bernd

