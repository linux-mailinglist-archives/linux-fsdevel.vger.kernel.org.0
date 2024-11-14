Return-Path: <linux-fsdevel+bounces-34782-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D21B19C8AAF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 13:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DE551F24794
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 12:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C231FAF01;
	Thu, 14 Nov 2024 12:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=e43.eu header.i=@e43.eu header.b="bWxJs9be";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MvUPbQpD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4669A1F80C5;
	Thu, 14 Nov 2024 12:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731588489; cv=none; b=J0CRhNRkDTriHmSJmXBi5Vsp9viJXDCwHkRcljkj+l8YA5vv3yhqGZz6uHD+cCl+LGaBsZMZuAvxd94UkmLOsko2vu8qi6NswJ3UVEOsYneI5Sgb/NjioqtfYywKgSTu22MiWYE66Qd8iC3uxpEaAcYb4gae6tC3kqSvr06MY6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731588489; c=relaxed/simple;
	bh=hmPNzQ6mkHSpddKxzNhwvQICnsCulEoU9irM4BxqQ1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X0q8qaVqhUT5m0qlyKsjz24/0GVLGwX8WlcVErYT8F9IzjvykgebAoAETFFWFFljyWkqmP8KLTd+5i5zAiR8HN3wISsTxK0OuvXN9hxsWG1cnjmYR65jO7Bhlz1XSLHvIrMks8pHEMTu85rUj5ceMxDvzfarxdv8WWXO4p0ejns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e43.eu; spf=pass smtp.mailfrom=e43.eu; dkim=pass (2048-bit key) header.d=e43.eu header.i=@e43.eu header.b=bWxJs9be; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MvUPbQpD; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e43.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e43.eu
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 3A26713800EC;
	Thu, 14 Nov 2024 07:48:05 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 14 Nov 2024 07:48:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=e43.eu; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1731588485;
	 x=1731674885; bh=o+so2c+rSh0kXkVZiCw7zaQj2VniyJXLYj8M37prr48=; b=
	bWxJs9bephLfuu7DzVfpXxTzIA5UqEuyW4EeS5yt7zZB8rEc0BtzkS57BWln0drp
	0noNXS+yq32LK9tjBZjNfHQh/A/S3jzw9Jibaxbw1n+qPPgW0/hASAan/Gh/x1x4
	Z6wDBcAAMNrMESED3Nms2kbIK7iuVEgoscfpZ9QrXxQQ6OPVgGF0Ck++SNrb8coy
	hjvN8u3H5W1byJv6fYjTpJYi3HcUMB9QR0KCeAEhF4mfuz/ARNc3XAIHGovp8lsB
	5B9bIBabGcAYTuXya6zwN015KMsOpXoGK+aCGtT5GBoVhscjsjMOQpSgWVnUHKJs
	rhFKzxrRdMukhvfaJMzKEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731588485; x=
	1731674885; bh=o+so2c+rSh0kXkVZiCw7zaQj2VniyJXLYj8M37prr48=; b=M
	vUPbQpDN93IsY3mHrAzoWWv26EHJdCT1vb7/soIoFCxQan/HpEF1zUDG6jbHEe0W
	Ab5G1mUdWSbhuITYddsepGaor1ujUctfIXjFJ+IcVdC4Z1LpeoPCJKAXe54/x1zI
	6u7+KzfUA0fnPnZUsfLSiS+6DK01YgUFk2eTxQWajKHiUyjqPODLFi/uTAXgvy8p
	61EItoyCDrwdY8ud1NO8I1oXsxm+iliMJE6NQJA5UZka2zMr4N/7WAWr6oebtx4s
	/VfA8sMpEVilr7DLMSo8FPmxjO69GwkZaK3v4YTmMS27cRwudaSWLc1mFtLOQm70
	kNuxY1EIesJLWAkPeAdww==
X-ME-Sender: <xms:hPE1Z-njXzfjJJzaW8EcoT1zhnRfK6dEio1rPNJe9frCTth10neLYQ>
    <xme:hPE1Z118WSt4e1ab6H83L3LNZJmPtarxj_SZHS4pP7BBPMqoIkkYxcXFgyMSNRB4Z
    2qyKY-gJ7r7OT3BY_M>
X-ME-Received: <xmr:hPE1Z8rZ8R1DsSErgDGo9oZNHLqBK3SpaGTc8RvNpj3jf-KE1U6vYknRbiaE5wWEkStXNPmXpjhKdKiGxaQjTZHKuN8H>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddvgdeggecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeen
    ucfhrhhomhepgfhrihhnucfuhhgvphhhvghrugcuoegvrhhinhdrshhhvghphhgvrhguse
    gvgeefrdgvuheqnecuggftrfgrthhtvghrnhepgeeghfejjeegtdfgfefhtdfhuedvjedu
    leeflefhjeetleeikeejgeeggefggedunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepvghrihhnrdhshhgvphhhvghrugesvgegfedrvghupdhn
    sggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrmhhirh
    ejfehilhesghhmrghilhdrtghomhdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruh
    hkpdhrtghpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtoheptghhuhgtkhdr
    lhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqfhhsuggvvh
    gvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghr
    nhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhgrhihtohhnse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:hPE1ZymjwEAiW1bU3xC9kS9WOuNbS1xmuoFPE_SoPUlZjmINBpV20g>
    <xmx:hPE1Z80SrNgo4Ctm370Ndj3ZWtApgQEgX6VSnbRkchkZowtpOgP95w>
    <xmx:hPE1Z5vLCnbzop9HGfA04DIh6hiEs3P24VQqbFuzOLamm_Slmsjo3A>
    <xmx:hPE1Z4WEB4VQKK1AUfC2I_SIYIVrcxoKB1XIe-8fpr61e2U5gi7zyA>
    <xmx:hfE1Zyzg2F1uAweoTuCQnjV0-kTS-L4j_vwdcvg1PdDqaTBhAjV_Zyrj>
Feedback-ID: i313944f9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Nov 2024 07:48:03 -0500 (EST)
Message-ID: <431019de-b6c6-474b-bf1f-e0afcdc0ce63@e43.eu>
Date: Thu, 14 Nov 2024 13:48:02 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] pidfs: implement file handle support
Content-Language: en-GB
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
 linux-nfs@vger.kernel.org
References: <2aa94713-c12a-4344-a45c-a01f26e16a0d@e43.eu>
 <20241113-pidfs_fh-v2-0-9a4d28155a37@e43.eu>
 <CAOQ4uxg4Gu2CWM0O2bs93h_9jS+nm6x=P2yu4fZSL_ahaSqHSQ@mail.gmail.com>
From: Erin Shepherd <erin.shepherd@e43.eu>
In-Reply-To: <CAOQ4uxg4Gu2CWM0O2bs93h_9jS+nm6x=P2yu4fZSL_ahaSqHSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

   

On 14/11/2024 08:02, Amir Goldstein wrote:
> On Wed, Nov 13, 2024 at 7:01 PM Erin Shepherd <erin.shepherd@e43.eu> wrote:
>> Since the introduction of pidfs, we have had 64-bit process identifiers
>> that will not be reused for the entire uptime of the system. This greatly
>> facilitates process tracking in userspace.
>>
>> There are two limitations at present:
>>
>>  * These identifiers are currently only exposed to processes on 64-bit
>>    systems. On 32-bit systems, inode space is also limited to 32 bits and
>>    therefore is subject to the same reuse issues.
>>  * There is no way to go from one of these unique identifiers to a pid or
>>    pidfd.
>>
>> This patch implements fh_export and fh_to_dentry which enables userspace to
>> convert PIDs to and from PID file handles. A process can convert a pidfd into
>> a file handle using name_to_handle_at, store it (in memory, on disk, or
>> elsewhere) and then convert it back into a pidfd suing open_by_handle_at.
>>
>> To support us going from a file handle to a pidfd, we have to store a pid
>> inside the file handle. To ensure file handles are invariant and can move
>> between pid namespaces, we stash a pid from the initial namespace inside
>> the file handle.
>>
>>   (There has been some discussion as to whether or not it is OK to include
>>   the PID in the initial pid namespace, but so far there hasn't been any
>>   conclusive reason given as to why this would be a bad idea)
> IIUC, this is already exposed as st_ino on a 64bit arch?
> If that is the case, then there is certainly no new info leak in this patch.

pid.ino is exposed, but the init-ns pid isn't exposed anywhere to my knowledge.

>> Signed-off-by: Erin Shepherd <erin.shepherd@e43.eu>
>> ---
>> Changes in v2:
>> - Permit filesystems to opt out of CAP_DAC_READ_SEARCH
>> - Inline find_pid_ns/get_pid logic; remove unnecessary put_pid
>> - Squash fh_export & fh_to_dentry into one commit
> Not sure why you did that.
> It was pretty nice as separate commits if you ask me. Whatever.

I can revert that if you prefer. I squashed them because there was some churn
when adding the init-ns-pid necessary to restore them, but I am happy to do
things in two steps.

Do you prefer having the final handle format in the first step, or letting it
evolve into final form over the series?


