Return-Path: <linux-fsdevel+bounces-25825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56431950F3D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 23:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08E842846A9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 21:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07EF1AAE03;
	Tue, 13 Aug 2024 21:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="jjZJmuCi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BtREhKhB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB6D1A76BB
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2024 21:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723585463; cv=none; b=UQwUDfzb4pklqL3hS3C5Rfm+wLEHop0Smc6Eiri3tk81Xx6FLmNEoojZ3p8JNGfZAgFL5XEwRX+6jgVVVHU6KCis+cYUChGR4ln6lDOogYceaDurYU2vO+MjL0Ei5QqBXWHax+82Gznu/APM8YefY5/Q+EKEUsofNKV1a6Vpols=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723585463; c=relaxed/simple;
	bh=mmiavoWiDdt7JAm/9WRwUXW2tONc5eBfUHfJ+Q3ADFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aJUsqmm+rKyWYHhuP6SmoPhWQ9Y95B56wjqtC54qLnQI6SxjRlJ2vqxUilY0mBIzBvg6XDNWMvdMVqbeC6YCTg26gpYOvL4i6SOtpbSRTZD71tGm5NPUBH1sa3+Rt6slRoWjz7tE+hiofZ9rThkmU3KOdqnU0fBzPz0qfgJtFuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=jjZJmuCi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BtREhKhB; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id D766B138FC9F;
	Tue, 13 Aug 2024 17:44:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 13 Aug 2024 17:44:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1723585459;
	 x=1723671859; bh=wSqdsf7qvDqgysZZ5Nxm90NepuTeFqbX41a6wStD2Zg=; b=
	jjZJmuCidsxd5hCLtZq2s7kmmnOOznw4cpDEh6TM1ZOIp6AIEWVFrhXk/YBytsPC
	z3CAQWomCljvhNBg4aMOuFPjaNOjUGKO8FJx1RyxjL1DZ5YG0BU2C17qvZ0rRgY+
	GzOe+z39UZ3IeJ4VvapJ0OnKf7hrWikvdaOEXnvOtBHhxgalVICvdoewW2eIr5ip
	8GufzOKjb6JGf0ZN7JQeBk1yrSD1u5m3cwiOKcjQ9daT2kch+nhUk/zKcn91AJBN
	gpXmvl85LSC/QfqiDeI82Ch+xsTsjl3LiTV8O7qGwH5qoExeTqqcbVsMEMv+FEaj
	bOwpY4+OdK8d2CPoYUR97w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723585459; x=
	1723671859; bh=wSqdsf7qvDqgysZZ5Nxm90NepuTeFqbX41a6wStD2Zg=; b=B
	tREhKhBAWB1ZQUSZAQbFZV+do/CNHZ/ryJXYuD37uBKhWhiJv/jgU3jkDQMbMvTU
	0C7HZI9zJcg1I2+VVrmSeqplO9zDFR8GobGdSPdlcHwQnUaVMR5bkG3FyOm0pd5J
	H08JFquOvt25YDgT6OJibUTPtWAdulvJUAD2A2lsXLvKMh4xqydrXEnsv/AcpWtc
	I0l64N6sVyQnCPQJkMjxpIg4rCfeHivz1l+7CiOUx0rqpiCtSv39N4UH8a40DT43
	I4vO9xndQ3DfKfczhtNXUAtwxWwHDJZy362L7tgTllze9UAS6i22MmTzCq3ueQYQ
	Z/UCtRtZPMRrXOjUeDnfg==
X-ME-Sender: <xms:s9O7Zjo7bk7YeO2DxaoEU66uhF45XeiOQ-m3yHJUOD8aBNs50MjRzQ>
    <xme:s9O7Ztpvk5t1w5RwRwjtYTNeiKcvcCUmU0pXrn3RJ72MwPQ4JHUJKo2yaO1tLY8KB
    oHtJB_ejFKi7-CB>
X-ME-Received: <xmr:s9O7ZgPUnNQ9jB17R_zAAhSENxRJA3XjTyOZ1QTJFbwNEhD0oQi9K-FGb53SfH7ynAdsh1_o_12rua3melFr_0Yir8AM75hEN2hAdyFKdQLmgPmqRrYwrLKV8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtfedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdej
    necuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvg
    hrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepvefhgfdvledtudfg
    tdfggeelfedvheefieevjeeifeevieetgefggffgueelgfejnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhht
    sehfrghsthhmrghilhdrfhhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtghomhdprhgt
    phhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtoheplhhinhhugi
    dqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhs
    vghfsehtohigihgtphgrnhgurgdrtghomhdprhgtphhtthhopehoshgrnhguohhvsehosh
    grnhguohhvrdgtohhmpdhrtghpthhtohepshifvggvthhtvggrqdhkvghrnhgvlhesugho
    rhhmihhnhidrmhgvpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesmhgvthgrrdgtoh
    hmpdhrtghpthhtohepughsihhnghhhseguughnrdgtohhm
X-ME-Proxy: <xmx:s9O7Zm5j6L5mOM8PlM3pjKk_E8Wa2_bzV_4YsrordD9zrGkKjjOFMg>
    <xmx:s9O7Zi7u8ltQCPFBw05aVcpEvUAN9lkSzW4ncLP4rWd8Urf_aqhNaA>
    <xmx:s9O7ZuhZu18-gXXTHV_ATv8I_GUnVQhhsIH7muPftBNtcNkz-u6UBg>
    <xmx:s9O7Zk5JCZqoDnTGuDnSjr_Kku95mWAYPgLQA-4zj36qVRxFTuoIFg>
    <xmx:s9O7ZkvDhJ6aFK208cPUeaX3IT3xdS7XIVQUdIotq6a93E5GXjMBTz4P>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 17:44:17 -0400 (EDT)
Message-ID: <4c37917a-9a64-4ea0-9437-d537158a8f40@fastmail.fm>
Date: Tue, 13 Aug 2024 23:44:15 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: add FOPEN_FETCH_ATTR flag for fetching attributes
 after open
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com, osandov@osandov.com, sweettea-kernel@dorminy.me,
 kernel-team@meta.com, Dharmendra Singh <dsingh@ddn.com>
References: <20240813212149.1909627-1-joannelkoong@gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, fr, ru
In-Reply-To: <20240813212149.1909627-1-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/13/24 23:21, Joanne Koong wrote:
> Add FOPEN_FETCH_ATTR flag to indicate that attributes should be
> fetched from the server after an open.
> 
> For fuse servers that are backed by network filesystems, this is
> needed to ensure that file attributes are up to date between
> consecutive open calls.
> 
> For example, if there is a file that is opened on two fuse mounts,
> in the following scenario:
> 
> on mount A, open file.txt w/ O_APPEND, write "hi", close file
> on mount B, open file.txt w/ O_APPEND, write "world", close file
> on mount A, open file.txt w/ O_APPEND, write "123", close file
> 
> when the file is reopened on mount A, the file inode contains the old
> size and the last append will overwrite the data that was written when
> the file was opened/written on mount B.
> 
> (This corruption can be reproduced on the example libfuse passthrough_hp
> server with writeback caching disabled and nopassthrough)
> 
> Having this flag as an option enables parity with NFS's close-to-open
> consistency.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/file.c            | 7 ++++++-
>  include/uapi/linux/fuse.h | 7 ++++++-
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index f39456c65ed7..437487ce413d 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -264,7 +264,12 @@ static int fuse_open(struct inode *inode, struct file *file)
>  	err = fuse_do_open(fm, get_node_id(inode), file, false);
>  	if (!err) {
>  		ff = file->private_data;
> -		err = fuse_finish_open(inode, file);
> +		if (ff->open_flags & FOPEN_FETCH_ATTR) {
> +			fuse_invalidate_attr(inode);
> +			err = fuse_update_attributes(inode, file, STATX_BASIC_STATS);
> +		}
> +		if (!err)
> +			err = fuse_finish_open(inode, file);
>  		if (err)
>  			fuse_sync_release(fi, ff, file->f_flags);
>  		else if (is_truncate)

I didn't come to it yet, but I actually wanted to update Dharmendras/my
atomic open patches - giving up all the vfs changes (for now) and then
always use atomic open if available, for FUSE_OPEN and FUSE_CREATE. And
then update attributes through that.
Would that be an alternative for you? Would basically require to add an
atomic_open method into your file system.

Definitely more complex than your solution, but avoids a another
kernel/userspace transition.

Thanks,
Bernd

