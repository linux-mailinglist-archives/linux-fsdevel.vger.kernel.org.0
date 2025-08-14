Return-Path: <linux-fsdevel+bounces-57923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C41DEB26CE4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 18:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E46C23B7A97
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 16:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B95A1F4611;
	Thu, 14 Aug 2025 16:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="PZPC15ix";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lBJXP0xw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE2B17AE1D;
	Thu, 14 Aug 2025 16:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755189973; cv=none; b=t5bfU+WaNnMP3nbMA1ZcoW9WylLV67jvKgQI3MTTqwfsLmmqcuhzjgD+4oj6h8nRF+47xpzGQYswkOkK6cVbcseiWpyPdX5+LeO4ieYHN4qwDTjeZss0oZteIgPTMNYCMSixvrXGiAE7oReL9TVuqEcCPx7NKo4UzVejnlvlc/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755189973; c=relaxed/simple;
	bh=fKf6o3bmqlQgxtEtngSAOhIgwUCatTJWZ5pVq4OayjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bY5fFNmTYOlTASTaNaL8HQCtJ82pVdF9/kG2IWw0CQbU02krM4M4WZYxSJ/w23Qy9PuWYt2r49YmLlQgK5q/RbEPqk+FxcWuJ60SOi8/CeT3jDseOgJYVaCJAtYQu78BUwYSb+nSc+B6AJe9ovQL9ba3PUMAumzAq5SmZwJzlZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=PZPC15ix; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lBJXP0xw; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2F3531400114;
	Thu, 14 Aug 2025 12:46:10 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 14 Aug 2025 12:46:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755189970;
	 x=1755276370; bh=9yiY/ywgCvaEzlIcLmDRRj90eSnYQzFz2AWPqotqZFw=; b=
	PZPC15ixSzDdwH6uNmJHv8PrVoxWqDQ4f62CVE1xwMyZhkTqxcdbB4hwSgp5I45n
	nVY1aiu50xaw9s6GgU71ORaIyo74dWkRh0ZoeRz1HwCDhhMU/X8uTgpvBbBgj6GB
	T5HkiqT96FnLMDn3YdldYpishCLWIpGz8scUVqAeqwGD7qwlz6m3pSHGFo+tvu6e
	JbPozepciRnCxFYB9BeekmKu/3ZIQfYqYsEQlzmR03OhT01C45wNJVvTTJuGyeZa
	VnbEuuPpVIzCXMVp6XZ1LpkgsVgLp9Y924ZyvWcnsw3Urcv8epI9B/ALux220xmG
	x92f6iWWKrXHeLAsSy9DCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755189970; x=
	1755276370; bh=9yiY/ywgCvaEzlIcLmDRRj90eSnYQzFz2AWPqotqZFw=; b=l
	BJXP0xwPnMYvXu6oVs7co1wMg2gJSO80oSio/FRzZCeVcTyZ9bjU1ty4LclE9Ccg
	pSgLW5YUt9ncGjWPmyO+UTXLPVzGU/z/9V6kEkoiLBaPcSXRxkXtTEwoR3RshalU
	NzPw1dVwUJCHJfWJuUaFYGBplvsxH17W0V3M6ULe9h/CpZoHbFIOeyZSXDjzXinL
	HhYkRh0Wd+POnsUp+BS98/41u6lBka0yscjcznbSo/LeCYCrL+VadbE7NqeC6cOn
	dvnpJXicLCDvN4rS6yFktWC227IBZYcTIAiR0Uh4TL4qR1Xmb7JJqw429mpi29dr
	RkrE73lY/WFtZw4vb0SBw==
X-ME-Sender: <xms:0RKeaPw3vwJKAWgvtdZ_vSGwTfIElFFHy_sCmhwwp5b3WZv29jazsQ>
    <xme:0RKeaEoWJXgP9_pHxcglqmZDgFKORiukAjoL-vwVSbblx9lK8myXk_VL-iYv_XQyp
    cDfeAKm9sJ13zwjOlM>
X-ME-Received: <xmr:0RKeaApxCwsZ5s0MGrtxRPTkLL13JDq8LTTBLN_WLCygiBFGsLicUpdRWV3OYfOP-pFzswSJsG--fewDnpzAbZcRrA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeduheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpefgrhhitgcu
    ufgrnhguvggvnhcuoehsrghnuggvvghnsehsrghnuggvvghnrdhnvghtqeenucggtffrrg
    htthgvrhhnpeevieekueetfeeujedtheeffedvgeffiedvjeejleffhfeggeejuedtjeeu
    lefhvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsrghnuggvvghnsehsrghnuggvvghnrdhnvghtpdhnsggprhgtphhtthhopedutddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheptgihphhhrghrsegthihphhgrrhdrtghomh
    dprhgtphhtthhopehsrghnuggvvghnsehrvgguhhgrthdrtghomhdprhgtphhtthhopegt
    hhgrrhhmihhtrhhosehpohhsthgvohdrnhgvthdprhgtphhtthhopehgrhgvghhkhheslh
    hinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepuggrkhhrsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeguhhhofigv
    lhhlshesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:0RKeaECGZnDVGGACs5BrntPz6KQbFD60mBJLytFRvsHYLAYkwbxNAg>
    <xmx:0RKeaOu5tv24dFE-ROESRLaEgV01r-_jBuoU_QdLnw3QmBdAJpomQQ>
    <xmx:0RKeaDIN9em2lzD_uoWG22A5AxLI-AJuTe560PlLa7PcCVqd1v-IiA>
    <xmx:0RKeaFYQwq8BkhYJoonXI_xFWYUokeh3HrjLnNPR_yGVRXSiGfkZ1g>
    <xmx:0hKeaOfenuvO67v5kUufweWD-Gk-R-wYZNnFHvTd__fQSemMI7986ucK>
Feedback-ID: i2b59495a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Aug 2025 12:46:09 -0400 (EDT)
Message-ID: <1dcf4661-97c2-4727-b4c5-f05785196dcb@sandeen.net>
Date: Thu, 14 Aug 2025 11:46:08 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] debugfs: fix mount options not being applied
To: Aleksa Sarai <cyphar@cyphar.com>, Eric Sandeen <sandeen@redhat.com>
Cc: Charalampos Mitrodimas <charmitro@posteo.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20250804-debugfs-mount-opts-v1-1-bc05947a80b5@posteo.net>
 <a1b3f555-acfe-4fd1-8aa4-b97f456fd6f4@redhat.com>
 <d6588ae2-0fdb-480d-8448-9c993fdc2563@redhat.com>
 <2025-08-14.1755150554-popular-erased-gallons-heroism-gRtAbX@cyphar.com>
Content-Language: en-US
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <2025-08-14.1755150554-popular-erased-gallons-heroism-gRtAbX@cyphar.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/14/25 4:05 AM, Aleksa Sarai wrote:
> On 2025-08-05, Eric Sandeen <sandeen@redhat.com> wrote:
>> On 8/4/25 12:22 PM, Eric Sandeen wrote:
>>> On 8/4/25 9:30 AM, Charalampos Mitrodimas wrote:
>>>> Mount options (uid, gid, mode) are silently ignored when debugfs is
>>>> mounted. This is a regression introduced during the conversion to the
>>>> new mount API.
>>>>
>>>> When the mount API conversion was done, the line that sets
>>>> sb->s_fs_info to the parsed options was removed. This causes
>>>> debugfs_apply_options() to operate on a NULL pointer.
>>>>
>>>> As an example, with the bug the "mode" mount option is ignored:
>>>>
>>>>   $ mount -o mode=0666 -t debugfs debugfs /tmp/debugfs_test
>>>>   $ mount | grep debugfs_test
>>>>   debugfs on /tmp/debugfs_test type debugfs (rw,relatime)
>>>>   $ ls -ld /tmp/debugfs_test
>>>>   drwx------ 25 root root 0 Aug  4 14:16 /tmp/debugfs_test
>>>
>>> Argh. So, this looks a lot like the issue that got fixed for tracefs in:
>>>
>>> e4d32142d1de tracing: Fix tracefs mount options
>>>
>>> Let me look at this; tracefs & debugfs are quite similar, so perhaps
>>> keeping the fix consistent would make sense as well but I'll dig
>>> into it a bit more.
>>
>> So, yes - a fix following the pattern of e4d32142d1de does seem to resolve
>> this issue.
>>
>> However, I think we might be playing whack-a-mole here (fixing one fs at a time,
>> when the problem is systemic) among filesystems that use get_tree_single()
>> and have configurable options. For example, pstore:
>>
>> # umount /sys/fs/pstore 
>>
>> # mount -t pstore -o kmsg_bytes=65536 none /sys/fs/pstore
>> # mount | grep pstore
>> none on /sys/fs/pstore type pstore (rw,relatime,seclabel)
>>
>> # mount -o remount,kmsg_bytes=65536 /sys/fs/pstore
>> # mount | grep pstore
>> none on /sys/fs/pstore type pstore (rw,relatime,seclabel,kmsg_bytes=65536)
>> #
> 
> Isn't this just a standard consequence of the classic "ignore mount
> flags if we are reusing a superblock" behaviour? Not doing this can lead
> to us silently clearing security-related flags ("acl" is the common
> example used) and was the main reason for FSCONFIG_CMD_CREATE_EXCL.

Perhaps, but I think it is a change in behavior since before the mount
API change. On Centos Stream 8 (sorry, that was the handy VM I had around) ;)

<fresh boot>

# mount | grep pstore
pstore on /sys/fs/pstore type pstore (rw,nosuid,nodev,noexec,relatime,seclabel)

# umount /sys/fs/pstore 
# mount -t pstore -o kmsg_bytes=65536 none /sys/fs/pstore
# mount | grep pstore
none on /sys/fs/pstore type pstore (rw,relatime,seclabel,kmsg_bytes=65536)

(kmsg_bytes was accepted on older kernel, vs not in prior example on new kernel)

# mount -o remount,kmsg_bytes=65536 /sys/fs/pstore
# mount | grep pstore
none on /sys/fs/pstore type pstore (rw,relatime,seclabel,kmsg_bytes=65536)

remount behaves as expected...

-Eric

> Maybe for some filesystems (like debugfs), it makes sense to permit a
> mount operation to silently reconfigure existing mounts, but this should
> be an opt-in knob per-filesystem.
> 
> Also, if we plan to do this then you almost certainly want to have
> fs_context track which set of parameters were set and then only
> reconfigure those parameters *which were set*. At the moment,
> fs_context_for_reconfigure() works around this by having the current
> sb_flags and other configuration be loaded via init_fs_context(), but if
> you do an auto-reconfigure with an fs_context created for mounting then
> you won't inherit _any_ of the old mount options. This could lead to a
> situation like:
> 
>   % mount -t pstore -o ro /sys/fs/pstore
>   % mount -t pstore -o kmsg_bytes=65536 /tmp
>   % # /sys/fs/pstore is now rw.
> 
> Which is really not ideal, as it would make it incredibly fragile for
> anyone to try to mount these filesystems without breaking other mounts
> on the system.
> 
> If fs_context tracked which parameters were configured and only applied
> the set ones, at least you would avoid unintentionally unsetting
> parameters of the original mount.
> 
> FWIW, cgroupv1 has a warning when this situation happens (see the
> pr_warn() in cgroup1_root_to_use()). I always wondered why this wasn't
> done on the VFS level, as a warning is probably enough to alert admins
> about this behaviour without resorting to implicitly changing the mount
> options of existing mounts.
> 
>> I think gadgetfs most likely has the same problem but I'm not yet sure
>> how to test that.
>>
>> I have no real objection to merging your patch, though I like the
>> consistency of following e4d32142d1de a bit more. But I think we should
>> find a graceful solution so that any filesystem using get_tree_single
>> can avoid this pitfall, if possible.
>>
>> -Eric
>>
>>
> 


