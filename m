Return-Path: <linux-fsdevel+bounces-32017-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3422299F424
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 19:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57E721C2266B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 17:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2FF1F9EAC;
	Tue, 15 Oct 2024 17:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="LcXiC3+5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oAmGcWqT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D04D1F76AA
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Oct 2024 17:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729013587; cv=none; b=AiTAaPi3fRPLP0m0VGxqg5ek+9VmYJwUG31XdVTh5yM2wXn8hZs3Ny5+5qWRYTMHzUl5L+lxfqySktC/XzQjQVB1uh2welNJ6b76HHJB6nDkIikAg5Zn2MIrKnJptENQAwxmCl0vwSUvsr7EpPwKyEwSvhO4mK2V+deEx151L8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729013587; c=relaxed/simple;
	bh=dmdiY6Wj08fWq+EDl6fz/rDZj8y00GdtzBNZG/lEP5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h3Sf2aqs32/0kmmmTTU8ybo03vkfvWqtY9lxDLmHsMdkhqwHPZEfxuaQFNw0Ob1czUR7XpIz+u9DmbVH7q39d12lZyu3wS9XOp8+3r9b0cWyF4qokJVd2d+GoTDs4V2Ie5ua3NZGirfVWKapjlxlBlyXKaD4MQNmxidZI1QgAz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=LcXiC3+5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oAmGcWqT; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 9C5FE1380176;
	Tue, 15 Oct 2024 13:33:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 15 Oct 2024 13:33:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1729013583;
	 x=1729099983; bh=/6N+CRmP37+/5Vg//iVb9zwqtxEyfTjcT9C5X8t3Ecg=; b=
	LcXiC3+5RxOLx7FLeQRMM5DhaI/EURkr9rt2mCzuOWRCMcfzu8MJIjBw8JEvtSb+
	TfGB8B0Ud3oVHOLRuLrwhJUKuEaZdR80vjeO/uVDEuSzTjZDMJUcAolcC6K38TDd
	XyGyHfzOppdzPrIeVr3FKFVjviLikansw3/2m1tE9XE3E5OyOdZe4IF2qQDazBG0
	fmz96E1vWrQ9vZ/8gnVRUHXswkyORErR4Mi+Dx7b6vRu1pgrfAMJ7vBi8yADoqE0
	LqC6Rb7UMrNtbnaskcezE/BZop+WtuWzejBSndY0gkOvMQlLVymnDvQijwta7xAv
	gKWMSTj+IdLH3sj4XN3Qbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729013583; x=
	1729099983; bh=/6N+CRmP37+/5Vg//iVb9zwqtxEyfTjcT9C5X8t3Ecg=; b=o
	AmGcWqTOU8T5lxLlmfKD8F4JzOUE7grommH5XdxD2xbTXRZDGkHFAi6652v/b22V
	FbJXpqpIahMaTW7qP/sFHZlhvYy5aW7XWUClbN4v5dZ+bJ0tbnJQw7QUoSrfMB6H
	nrYYYpYCyg8KR7Z0zfbsnxco7I5QXk2lyBCO2bCgy/E15Tv7RhEKuONfsK7cq2IB
	6TEuuHuGP6TSGInjUXxsitaDqgxZlliO4EnlU4RoElpen/0u2oaqYxVAM+ywO9Gr
	NUkaQhiyw7bwTfH2TUzqJGqOaGLX8XR1G0ygRJ91fJlcInEqIxfO8EVvSZKG3kEJ
	oVSJY82KuaZwBbN7/ELew==
X-ME-Sender: <xms:T6cOZ8I9t8UZMwNPC5qDZs6Y3WUyWh4OAvPxIEPQ2HB4k_PD9ofA6Q>
    <xme:T6cOZ8KzT0M3TCH0xi_m17to8Cc7yYL0IqtDO3ATxIOBAqrG0aDWmbSk39-S28Cu0
    K3l5iZ9F_38wrcmjUY>
X-ME-Received: <xmr:T6cOZ8stqC4mkO2utI7UhKdItK3dUBbx7ERfrQRoesc4A_755vBKIHirhQ8qZrQL-nSeaM2nB6zIbIGNy-pS8fQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegjedguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddv
    jeenucfhrhhomhepgfhrihgtucfurghnuggvvghnuceoshgrnhguvggvnhesshgrnhguvg
    gvnhdrnhgvtheqnecuggftrfgrthhtvghrnhepveeikeeuteefueejtdehfeefvdegffei
    vdejjeelfffhgeegjeeutdejueelhfdvnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepshgrnhguvggvnhesshgrnhguvggvnhdrnhgvthdpnhgs
    pghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghoughonh
    hnvghlsehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghl
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrrghunhgvrheskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepshgrnhguvggvnhesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:T6cOZ5ZNx3wnTXECyJXPr6WjtwPxu9PDetC5lVEyzL1HKrkQKqu_vw>
    <xmx:T6cOZzaRHAfyXEABblC1koyhGeHkA-tQmfUyXZvwoFfa6cEJzsu-gw>
    <xmx:T6cOZ1D0TuTgkf1_BLAuuXIOXavi4LRaeIhQ99xGgPa89ORXsRUbgg>
    <xmx:T6cOZ5Z3ezFEpakfeA-IAznhl0xajbImh-rJMcMRzwjpvtadFN7rxA>
    <xmx:T6cOZyUj0NfBOp-Vj3l4YZ_OEz7u0sqCQKT74wBOE0QtCYBDvkMKfpWR>
Feedback-ID: i2b59495a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Oct 2024 13:33:02 -0400 (EDT)
Message-ID: <6ec5ef91-316c-4418-a2ac-8cc987aef2c5@sandeen.net>
Date: Tue, 15 Oct 2024 12:33:02 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efs: fix the efs new mount api implementation
To: Bill O'Donnell <bodonnel@redhat.com>, linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org, sandeen@redhat.com
References: <20241014190241.4093825-1-bodonnel@redhat.com>
Content-Language: en-US
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <20241014190241.4093825-1-bodonnel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/14/24 2:02 PM, Bill O'Donnell wrote:
> Commit 39a6c668e4 (efs: convert efs to use the new mount api)
> did not include anything from v2 and v3 that were also submitted.
> Fix this by bringing in those changes that were proposed in v2 and
> v3.
> 
> Fixes: 39a6c668e4 efs: convert efs to use the new mount api.
> 
> Signed-off-by: Bill O'Donnell <bodonnel@redhat.com>

Thanks Bill. 

I'd kind of like to see efs_context_opts renamed to efs_context_ops - this
is an ops vector, nothing to do with opts or "options."

But I hadn't caught that on the first review, and functionally this fixes
the in fill_super problems and removes the dead code, so:

Reviewed-by: Eric Sandeen <sandeen@redhat.com>

> ---
>  fs/efs/super.c | 43 +++----------------------------------------
>  1 file changed, 3 insertions(+), 40 deletions(-)
> 
> diff --git a/fs/efs/super.c b/fs/efs/super.c
> index e4421c10caeb..c59086b7eabf 100644
> --- a/fs/efs/super.c
> +++ b/fs/efs/super.c
> @@ -15,7 +15,6 @@
>  #include <linux/vfs.h>
>  #include <linux/blkdev.h>
>  #include <linux/fs_context.h>
> -#include <linux/fs_parser.h>
>  #include "efs.h"
>  #include <linux/efs_vh.h>
>  #include <linux/efs_fs_sb.h>
> @@ -49,15 +48,6 @@ static struct pt_types sgi_pt_types[] = {
>  	{0,		NULL}
>  };
>  
> -enum {
> -	Opt_explicit_open,
> -};
> -
> -static const struct fs_parameter_spec efs_param_spec[] = {
> -	fsparam_flag    ("explicit-open",       Opt_explicit_open),
> -	{}
> -};
> -
>  /*
>   * File system definition and registration.
>   */
> @@ -67,7 +57,6 @@ static struct file_system_type efs_fs_type = {
>  	.kill_sb		= efs_kill_sb,
>  	.fs_flags		= FS_REQUIRES_DEV,
>  	.init_fs_context	= efs_init_fs_context,
> -	.parameters		= efs_param_spec,
>  };
>  MODULE_ALIAS_FS("efs");
>  
> @@ -265,7 +254,8 @@ static int efs_fill_super(struct super_block *s, struct fs_context *fc)
>  	if (!sb_set_blocksize(s, EFS_BLOCKSIZE)) {
>  		pr_err("device does not support %d byte blocks\n",
>  			EFS_BLOCKSIZE);
> -		return -EINVAL;
> +		return invalf(fc, "device does not support %d byte blocks\n",
> +			      EFS_BLOCKSIZE);
>  	}
>  
>  	/* read the vh (volume header) block */
> @@ -327,43 +317,22 @@ static int efs_fill_super(struct super_block *s, struct fs_context *fc)
>  	return 0;
>  }
>  
> -static void efs_free_fc(struct fs_context *fc)
> -{
> -	kfree(fc->fs_private);
> -}
> -
>  static int efs_get_tree(struct fs_context *fc)
>  {
>  	return get_tree_bdev(fc, efs_fill_super);
>  }
>  
> -static int efs_parse_param(struct fs_context *fc, struct fs_parameter *param)
> -{
> -	int token;
> -	struct fs_parse_result result;
> -
> -	token = fs_parse(fc, efs_param_spec, param, &result);
> -	if (token < 0)
> -		return token;
> -	return 0;
> -}
> -
>  static int efs_reconfigure(struct fs_context *fc)
>  {
>  	sync_filesystem(fc->root->d_sb);
> +	fc->sb_flags |= SB_RDONLY;
>  
>  	return 0;
>  }
>  
> -struct efs_context {
> -	unsigned long s_mount_opts;
> -};
> -
>  static const struct fs_context_operations efs_context_opts = {
> -	.parse_param	= efs_parse_param,
>  	.get_tree	= efs_get_tree,
>  	.reconfigure	= efs_reconfigure,
> -	.free		= efs_free_fc,
>  };
>  
>  /*
> @@ -371,12 +340,6 @@ static const struct fs_context_operations efs_context_opts = {
>   */
>  static int efs_init_fs_context(struct fs_context *fc)
>  {
> -	struct efs_context *ctx;
> -
> -	ctx = kzalloc(sizeof(struct efs_context), GFP_KERNEL);
> -	if (!ctx)
> -		return -ENOMEM;
> -	fc->fs_private = ctx;
>  	fc->ops = &efs_context_opts;
>  
>  	return 0;


