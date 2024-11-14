Return-Path: <linux-fsdevel+bounces-34785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4F29C8B46
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 13:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 121EB1F24190
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 12:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5D61FB750;
	Thu, 14 Nov 2024 12:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=e43.eu header.i=@e43.eu header.b="vrMPpY3W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O7aD1roi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF6C1FAC5F;
	Thu, 14 Nov 2024 12:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731589010; cv=none; b=hUgokPIs+J9zcyT6l5FjBNBCRIUPJKTRrXhFb+j7XOff1o7iEiW8yyQL+/6Uy3mdcxbcSlJfq2VavJqp6guPJ/qkVfxO92pFVzKDaGKIXp/YrOUc638JXwLQ7zRVpltdqgYASoZZsapmKovr0/CgXmfWlxsyU9ATkFmgt3Jfdh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731589010; c=relaxed/simple;
	bh=OEEPGPn+WdCzU967s/fVLhxpOUTBrHOH/Uf45/2H4RY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AP5IE2wkKWZNlK2RsaA4FF6WXwiLdrlIed+jU6Trv3Y/ho7quCWUQpjRBUxYg+ofy2TPtGZLNfEL3vaCu2XKgcWGWcUURUVxrZGYS583RI7c2xn8gzASEZFqUyjaDbIkvNv2Ibn9IEqjuwYdpSjoXcW7CDgdepjvFwjTYtCy7FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e43.eu; spf=pass smtp.mailfrom=e43.eu; dkim=pass (2048-bit key) header.d=e43.eu header.i=@e43.eu header.b=vrMPpY3W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O7aD1roi; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e43.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e43.eu
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 330EA11401C4;
	Thu, 14 Nov 2024 07:56:48 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 14 Nov 2024 07:56:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=e43.eu; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1731589008;
	 x=1731675408; bh=OEEPGPn+WdCzU967s/fVLhxpOUTBrHOH/Uf45/2H4RY=; b=
	vrMPpY3WfbjUN4RvtQwBVZhzapEn9gpcUyWrLghzLiLsN+tpKv/JoEE5+MyQCkZq
	BCjQfJl6hNP8vE6mt9vEbDTI5DeB8EyoJ3tnyBI645Qf7+fT8V48S8c4XO8q/o7X
	9tsPMHZXA+quFRK0a4FHejLDVJZI2dw1boKoUIk9/M4ilWMJQO5rrIwDRoURoHZc
	eBXxc9DprityaU5ra3yI2N9k09IGwFrYd8xLESq22fGEAqwMQ7cyzNE+d11JtQ3q
	TBEtcMfoe+XZlaaHsUlzCp8/HDkr4N0wIcjkr0AbgnBOEURdolOvRdaXqjI97i1q
	HirT2SAWG3S3PdhWIcHs2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731589008; x=
	1731675408; bh=OEEPGPn+WdCzU967s/fVLhxpOUTBrHOH/Uf45/2H4RY=; b=O
	7aD1roix7Ga/z2nSKA1S88xjQ+HsufKU1WOCU7mYccMbj9Nh+Dg9T/vQSA1Q2f2m
	/uj1hWHvZP/MNqcaKiWxFmm1BfqG+In41oIULb33fwDGdE3/dTzVGPLF07k1H8bz
	chR8qMYaLauYi/mYW14vvTtDZM3/Uuch7uJrNaa7i1b5gV+8rWt4SRbvmng/v8Vu
	TkfB1iLKYFtYmL2rYK+HJ+IhMf32uUlnymVpeQMPVGcHlwpPLAHlKOcCrsPXjtAw
	zo1G066kbDPUZz1qJWbCM//Mbua4UUyws/hbd2zxhH5EZ8VoqjdiJOHv7OLzQlMs
	tjiQqcYXLLV5dFwitImZg==
X-ME-Sender: <xms:j_M1Z6Vi1SJ2hYyfFlfDZelpfrujAPWuu6bYYX_v32rcZ2S4tpsqrA>
    <xme:j_M1Z2lajdkW-xYxNUoP2JTjkQqs5WVL3MfnBL78GyMQP2IttFOoizoBj_bTf7QEZ
    ZNehT6xgdovre3cXNw>
X-ME-Received: <xmr:j_M1Z-Yslv5Ob0KCoROlYppa1KC0c1h-Nf-iENPeXghYVAK4lBJSvcbmh2ca6JUKU2lszvCG2i7vjKYwMSL6l-T9JCZr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddvgdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeen
    ucfhrhhomhepgfhrihhnucfuhhgvphhhvghrugcuoegvrhhinhdrshhhvghphhgvrhguse
    gvgeefrdgvuheqnecuggftrfgrthhtvghrnhepjeeftdelheduueetjeehvdefhfefvddv
    ieekleejfeevffdtheduheejledvfedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepvghrihhnrdhshhgvphhhvghrugesvgegfedrvghupdhn
    sggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephhgthh
    esihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruh
    hkpdhrtghpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtoheptghhuhgtkhdr
    lhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqfhhsuggvvh
    gvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghr
    nhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhgrhihtohhnse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegrmhhirhejfehilhesghhmrghilhdrtgho
    mh
X-ME-Proxy: <xmx:j_M1ZxUuM28GvNPPQK66AvlvVhQOq3Lw_VFrbEXfye3LRzp7rHD16Q>
    <xmx:j_M1Z0lB0UH6C5XhSG-G9D4eAkQGJBzIkajmkl5XiCP4WnI5lZ-sKQ>
    <xmx:j_M1Z2f-8gTCV7ESFvJGO9jhH6LCbHZojaac70k46lhtiTsgxQtVNQ>
    <xmx:j_M1Z2FtmLdRvNT-ixQCYzGvWh8nl4qWq0xUxb31JlWMdiIDk878jQ>
    <xmx:kPM1Z9e3Ht5NynNLPa1DpoR-ZAjGd2qzDlncHA4P9HP_kzRqdAal42Jv>
Feedback-ID: i313944f9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Nov 2024 07:56:46 -0500 (EST)
Message-ID: <bae72e9f-c88c-43ec-a91a-40f217ea2adc@e43.eu>
Date: Thu, 14 Nov 2024 13:56:45 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] exportfs: allow fs to disable CAP_DAC_READ_SEARCH
 check
Content-Language: en-GB
To: Christoph Hellwig <hch@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
 Amir Goldstein <amir73il@gmail.com>, linux-nfs@vger.kernel.org
References: <20241113-pidfs_fh-v2-0-9a4d28155a37@e43.eu>
 <20241113-pidfs_fh-v2-2-9a4d28155a37@e43.eu> <ZzV-oVtytT28gHz2@infradead.org>
From: Erin Shepherd <erin.shepherd@e43.eu>
In-Reply-To: <ZzV-oVtytT28gHz2@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 14/11/2024 05:37, Christoph Hellwig wrote:
> On Wed, Nov 13, 2024 at 05:55:24PM +0000, Erin Shepherd wrote:
>> For pidfs, there is no reason to restrict file handle decoding by
>> CAP_DAC_READ_SEARCH.
> Why is there no reason, i.e. why do you think it is safe.

A process can use both open_by_handle_at to open the exact same set of
pidfds as they can by pidfd_open. i.e. there is no reason to additionally
restrict access to the former API.

>> Introduce an export_ops flag that can indicate
>> this
> Also why is is desirable?
>
> To be this looks more than sketchy with the actual exporting hat on,
> but I guess that's now how the cool kids use open by handle these days.
Right - we have a bunch of API file systems where userspace wants stable
non-reused file references for the same reasons network filesystems do.
The first example of this was cgroupfs, but the same rationale exists for
pidfs and process tracking.

