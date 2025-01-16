Return-Path: <linux-fsdevel+bounces-39449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81144A1445D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 23:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAE62188E00B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 22:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882381DC9BA;
	Thu, 16 Jan 2025 22:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="B9n25m1E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qHDK+bHU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3493A158520
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jan 2025 22:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737065269; cv=none; b=Ul/7fizdrcK2RYb7/3ICgcna/j7ci6DoG2W2yZDFnt3eJRFC1xVn8P+skYcsy+kMVN2AblSf9v8r8M6M6xD79wut1pvau4nrpml+Z8UfhsFZgkZbbBea6u/bRRjORijMv42gL358C+eevObZlREZDnrrcgTJp/47fyBG+8/q/oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737065269; c=relaxed/simple;
	bh=pGXBH0X61sah0t1dvqBVgbpKa5qgsUXJgNdNvWzUsDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t1l/84MQf3hzM5b9eiRBAyk3chJFwzrwyd/tt9s7SI4reoQMnZL4VU5SFY+P/tWbuJLFNYCKKZ+rUOjNSI3dtmPBDQykep5r1NwRDX2LGTwyEnUkS7MDlAEG2gMFQJLrkpE3q3iiP58DF6hVGEtLSXuvC/0d1nQrrFJ56pz9vjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=B9n25m1E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qHDK+bHU; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 12C001140158;
	Thu, 16 Jan 2025 17:07:46 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 16 Jan 2025 17:07:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1737065265;
	 x=1737151665; bh=8J2xxyvJohcy/aLoEmG6UkEJZTRoe9+vu18pYTu0p4A=; b=
	B9n25m1E32iSGIOV9HHDpe/bsSJbFtlunwm7er7cFIz6FCbS+vBvO0zTZa232Ixg
	ekM+QkbL7tQveA2RjNultQ83ILhXLGgVD06UWnkLjTH1quraRUEgwYYLaY2pUjzG
	uZ5Goe9apIx6ciwElpZWQy7Xu1AF44EOmshYIsGOgMhT62nkHjQaiSWlIlnTVOfD
	3uw7hJYCTwiLJt5K4Vwt134mykZFv0rVisUUBFnQ+eb5T6BqDxcmryGDmbyj+anh
	RQMLmerCxUDHloNDt46NM9FURBZaFE+i/TUUfZ9x1x74RJkX8FA1eT3cERprb07x
	DrCqHcZAPhkrIQaTzmHF0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1737065265; x=
	1737151665; bh=8J2xxyvJohcy/aLoEmG6UkEJZTRoe9+vu18pYTu0p4A=; b=q
	HDK+bHUmf+4fSk9UMYgC2UvNImQ4iu0/t8lTr0+ZuTI9tIa3JdKxYSrhnmckpUhV
	6p4PoLvaGV8LmqmpEoqb+3MVPDZy0M9BaseMQ1r5tV0BZdGPgkIhAzya2cbJlMrt
	G2MDmhMca/olay2RWRiysdoK3BNhy9v1uGWGcLQmvUOvZLP8UR07ergOt+AWuYfD
	2wLw7SsEpN+XGF+Ucthh5ZlVvit6uK4/wvr/YMXBEZyzOn6El7bAVLF9f2qXXTv1
	wtoIWsXKW2+5zKmiI5E0TouvsRnzaWRUkSgYB41NSoH0PkyH8W9pv0dLawkWWBdR
	8+YKzcdyilvmDxQ1H3SQg==
X-ME-Sender: <xms:MYOJZxMExH5cFm0OBmEm-m3dfqyhroiSER_yDV1TEZSKfmKKbGgeFA>
    <xme:MYOJZz_qmJidn33x7AaPOvGfxEY1iE4orF3v2Bnkx8WTRbYfFO4W0CxNOhO21C4Le
    vnhgEO2D4TqfN5sOoY>
X-ME-Received: <xmr:MYOJZwSvBOcLxFQYlUsUtpxdtWV00TtB2tS6WsrLyT-E0BjaTTIcoEANg_ZQTBM3RKd4qixL1Fv_L4obwSzyCOFK23ch>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddgudehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddv
    jeenucfhrhhomhepgfhrihgtucfurghnuggvvghnuceoshgrnhguvggvnhesshgrnhguvg
    gvnhdrnhgvtheqnecuggftrfgrthhtvghrnhepveeikeeuteefueejtdehfeefvdegffei
    vdejjeelfffhgeegjeeutdejueelhfdvnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepshgrnhguvggvnhesshgrnhguvggvnhdrnhgvthdpnhgs
    pghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvhhirhhose
    iivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehsrghnuggvvghnsehr
    vgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:MYOJZ9uIz6b8EhC5nDSi0PRa5mutR6nbvnzEpMqW08I-3S3fsMhhfw>
    <xmx:MYOJZ5fLecuitQ1_J-Lst1ktou5L0HO3SYSCsTE79hx3xMT8yGesgw>
    <xmx:MYOJZ5313zHcAHNn8OyXUNK2ThAhfsrGeVO7RvLJlzeE3kA1IEVUrg>
    <xmx:MYOJZ18zYHjpFZn8vNa0TzZoAPcNRKMWNEJ9DoeyoeHojNlMK2nQ2Q>
    <xmx:MYOJZw4v-waSwc4Q_kzAPbCSd6yM0XMvK13CRiRrMv19NRBNqExezEUb>
Feedback-ID: i2b59495a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 17:07:45 -0500 (EST)
Message-ID: <9f1435d3-5a40-405e-8e14-8cbdb49294f5@sandeen.net>
Date: Thu, 16 Jan 2025 16:07:44 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ufs: convert ufs to the new mount API
To: Al Viro <viro@zeniv.linux.org.uk>, Eric Sandeen <sandeen@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org
References: <20250116184932.1084286-1-sandeen@redhat.com>
 <20250116190844.GM1977892@ZenIV>
Content-Language: en-US
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <20250116190844.GM1977892@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/16/25 1:08 PM, Al Viro wrote:
> On Thu, Jan 16, 2025 at 12:49:32PM -0600, Eric Sandeen wrote:
> 
>> +	switch (opt) {
>> +	case Opt_type:
>> +		if (reconfigure &&
>> +		    (ctx->mount_options & UFS_MOUNT_UFSTYPE) != result.uint_32) {
>> +			pr_err("ufstype can't be changed during remount\n");
>> +			return -EINVAL;
>>  		}
>> +		ufs_clear_opt(ctx->mount_options, UFS_MOUNT_UFSTYPE);
>> +		ufs_set_opt(ctx->mount_options, result.uint_32);
>> +		break;
> 
> Do we really want to support ufstype=foo,ufstype=bar?

well, we already do that today. Old code was:

                switch (token) {
                case Opt_type_old:
                        ufs_clear_opt (*mount_options, UFSTYPE);
                        ufs_set_opt (*mount_options, UFSTYPE_OLD);
                        break; 
                case Opt_type_sunx86:
                        ufs_clear_opt (*mount_options, UFSTYPE);
                        ufs_set_opt (*mount_options, UFSTYPE_SUNx86);
                        break;
...

so I was going for a straight conversion for now so that the behavior
was exactly the same (i.e. keep the last-specified type. I know, it's
weird, who would do that? Still. Don't break userspace? And we've been
burned before.)

> 
>> +static void ufs_free_fc(struct fs_context *fc)
>> +{
>> +	kfree(fc->fs_private);
>> +}
> 
> Grr...  That's getting really annoying - we have way too many instances doing
> exactly that.  Helper, perhaps?

Yeah ... should probably also decide if we should eliminate the default case
for every fs too, we should never hit default: barring programming errors.
And ISTR you asking for another helper a while ago... oh yeah, something like:

static inline bool fc_rdonly(const struct fs_context *fc)
{
	return fc->sb_flags & SB_RDONLY;
}

so at some point maybe we should make a treewide pass on this stuff?

>> -#define ufs_set_opt(o,opt)	o |= UFS_MOUNT_##opt
>> -#define ufs_test_opt(o,opt)	((o) & UFS_MOUNT_##opt)
>> +#define ufs_clear_opt(o, opt)	(o &= ~(opt))
>> +#define ufs_set_opt(o, opt)	(o |= (opt))
>> +#define ufs_test_opt(o, opt)	((o) & opt)
> 
> I wonder if we would be better off without those macros (note, BTW,
> that ufs_test_opt() is not used at all)...

*shrug* I was just going for the minimal transformation w/o any
"also, while we're at it ..." bits. (tho I guess I did remove the
BUG_ON.)

If there are changes you want to see /now/ though I'm happy to do it.

Thanks,
-Eric


