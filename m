Return-Path: <linux-fsdevel+bounces-64012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1AFBD5C50
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 20:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 91110351679
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 18:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4ACF2D3EDD;
	Mon, 13 Oct 2025 18:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="EQS5O1MD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lp5n2uck"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5084E27510B;
	Mon, 13 Oct 2025 18:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760381209; cv=none; b=TlLWDVpbhkN0W1axrlAgIjF4oJIYFkzYADUrMDcjOyVM16zHG1OZvKbQ/KL/XncifvyeIlUIVKBVh6qV+c8/8LdTJtchzuKbh+28f+Payi+hQLtg99tZr4m3dGR3Yvz84VBRWFZRo3CgeOLbYzzUmWCOpZnzl5+6JuCGMw1YFWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760381209; c=relaxed/simple;
	bh=nJMlcJVKA/S/p+TwTJAR4sneUnfxxNXEk2Hi0g6cdT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hAMrZ+PQfyQ1YV/4mnc8U822xWk+Jyl/w3yLSzLr4uyl52NRbTlV07i1lESKr6PzpnzoSFBpFhoGq61HjfT/DZQxnkdi435LhJmYedkPPdQ9shRymDJvQL/5qpEnfoqoJuN4ro1q++ms559KBcs0BySciP7Sw0en1Fu/mheQ41I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=EQS5O1MD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lp5n2uck; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 5FAA21D000F8;
	Mon, 13 Oct 2025 14:46:45 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 13 Oct 2025 14:46:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760381205;
	 x=1760467605; bh=ODvfGNxLi1HK131gK3WX63G87k/sXMzMiLk+BIgjTl8=; b=
	EQS5O1MD0u22RtNerj6yV/BoxriKOQIbJPg2lN9JQCw/Q1U87yCwWEdedRbMwBK8
	1UbNbsRiYWTb9fdJAksmjb6Q/M9njSv7UwoDIrMBIUA2HIcwn39Ds3iDXSVveOAL
	tM6/E6t/EgOhAGux078xBEXTVfczOK3LJl08ylBqmk4r6VorS6MqlbkdIINil5ug
	PKNkNiW/dBJ/WFia4+Y3SRv/QsTsLfbn8T/idN3Q4mhml8aLoOe8pKttHHTBGndd
	jDchbT7NQ0HVM92yYfoctb2EKSgyf1hED/u9r4/Zhn9E/BUmKzhvTGHjyGgSOQrf
	UGMf2l2LSUlXpBIXtCuL6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760381205; x=
	1760467605; bh=ODvfGNxLi1HK131gK3WX63G87k/sXMzMiLk+BIgjTl8=; b=L
	p5n2uckLHSMG8sj+hsupnVQDXhLWoOJIGbRwBAaeqtxHwajKmaTQ3OWwNW3clTUt
	5mzD/G2HuXui2hj23fRD5yvkNsyWmIOvVTaOY4yknQaEG2N+mVC0iCmwXYQ2LMjH
	F7QMgARDAInJX+cdsfYuOm23GGgOPt+jJYfehbu5kxDFZzdPL72x/Z/I0NXpz2P6
	1mJrMQbD7T09m4CdlaFrl2vFz6ewLaZQNLeY0ekBHp6oGtxY0N6DHZ8AUFSDUmY3
	Z/3MfGMIP/OykT2SEUM1D+fhwEkEihi3ndwifSFn59XIZYz2hZT+vRQ4BMTIeTDS
	XlBmQGca7qzSiSS/pKvZA==
X-ME-Sender: <xms:FEntaMhfLY3YZMRI5mN8pvnBYJVfm_4dS8pxLJL5gh_ucCOaBaIiXQ>
    <xme:FEntaFcuYa4ITfNHkv4nz5WXl3E6H5ZAcbWfDLOWp0JtqdwgjCZJlgyR2B02btNQ8
    WaPdREiri_SnbqJoE09WOys9NseiHkUot8pTFRXBXyStWQZDg4sC7w>
X-ME-Received: <xmr:FEntaEzhPYIBLdzMZTdjnvSuKVXNOS-YuEHHZUmW-9IS_48ux94ospxGwdAUFJYekaEviTMsbdeXku_ARJnZDOY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudekgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejre
    dttddvjeenucfhrhhomhepgfhrihgtucfurghnuggvvghnuceoshgrnhguvggvnhesshgr
    nhguvggvnhdrnhgvtheqnecuggftrfgrthhtvghrnhepveeikeeuteefueejtdehfeefvd
    egffeivdejjeelfffhgeegjeeutdejueelhfdvnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepshgrnhguvggvnhesshgrnhguvggvnhdrnhgvth
    dpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghs
    mhgruggvuhhssegtohguvgifrhgvtghkrdhorhhgpdhrtghpthhtohepshgrnhguvggvnh
    esrhgvughhrghtrdgtohhmpdhrtghpthhtohepvhelfhhssehlihhsthhsrdhlihhnuhig
    rdguvghvpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopegvrhhitghvhheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhutghhohesihhonhhkohhvrdhnvghtpdhrtghpthhtoheplhhinhhugigp
    ohhsshestghruhguvggshihtvgdrtghomhdprhgtphhtthhopegvrggurghvihhssehqqh
    drtghomh
X-ME-Proxy: <xmx:FEntaE0cnx7HP2HiNctGcyISzco3pACZEkz_gZ6CijkpRg-0mdhu9w>
    <xmx:FEntaKxzzk2sEh9LAAuI4EzwWtzoaCr26Gz6hvRHWpyszyyMI5G4DQ>
    <xmx:FEntaJXJ2JdGIuw31tlczbar6W_BxT7CUAykswYgqKyii21Wcj8qSw>
    <xmx:FEntaG-K49NP11ml-ZDo78NDGknw9DqRED2v2U1Upb5ZpxZL6PznTA>
    <xmx:FUntaHy9uBs-56vNBRCN_s5BmMhUbygjt52nQ5QcDwNYE2ltn1DAXBjJ>
Feedback-ID: i2b59495a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Oct 2025 14:46:43 -0400 (EDT)
Message-ID: <bc86b13e-1252-4bf0-86f9-77da37f5e37a@sandeen.net>
Date: Mon, 13 Oct 2025 13:46:42 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 4/4] 9p: convert to the new mount API
To: Dominique Martinet <asmadeus@codewreck.org>,
 Eric Sandeen <sandeen@redhat.com>
Cc: v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, ericvh@kernel.org, lucho@ionkov.net,
 linux_oss@crudebyte.com, eadavis@qq.com
References: <20251010214222.1347785-1-sandeen@redhat.com>
 <20251010214222.1347785-5-sandeen@redhat.com>
 <aOzT2-e8_p92WfP-@codewreck.org>
Content-Language: en-US
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <aOzT2-e8_p92WfP-@codewreck.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/13/25 5:26 AM, Dominique Martinet wrote:
> Hi Eric,
> 
> Thanks for this V3!
> 
> I find it much cleaner, hopefully will be easier to debug :)

Good news and bad news, I see.

> ... Which turned out to be needed right away, trying with qemu's 9p
> export "mount -t 9p -o trans=virtio tmp /mnt" apparently calls
> p9_virtio_create() with fc->source == NULL, instead of the expected
> "tmp" string
> (FWIW I tried '-o trans=tcp 127.0.0.1' and I got the same problem in
> p9_fd_create_tcp(), might be easier to test with diod if that's what you
> used)

I swear I tested this, but you are right, and it fails for me too.

Oh ... I know what this is :(

Introducing the "ignore unknown mount options" change in V4 caused it to
also ignore the unknown "source" option and report success; this made the
vfs think "source" was already handled in vfs_parse_fs_param() and
therefore it does not call vfs_parse_fs_param_source(). This has bitten
me before and it's a bit confusing.

I'm not sure how I missed this in my V4 testing, I'm very sorry.

> Looking at other filesystems (e.g. fs/nfs/fs_context.c but others are
> the same) it looks like they all define a fsparam_string "source" option
> explicitly?...

Not all of them; filesystems that reject unknown options have "source"
handled for them in the VFS, but for filesystems like debugfs that
ignore unknown parameters it had to handle it explicitly. (Other
filesystems may do so for other reasons I suppose).

See also a20971c18752 which fixed a20971c18752, though the bug had
slightly less of an impact.

> Something like this looks like it works to do (+ probably make the error
> more verbose? nothing in dmesg hints at why mount returns EINVAL...)
> -----
> diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
> index 6c07635f5776..999d54a0c7d9 100644
> --- a/fs/9p/v9fs.c
> +++ b/fs/9p/v9fs.c
> @@ -34,6 +34,8 @@ struct kmem_cache *v9fs_inode_cache;
>   */
>  
>  enum {
> +	/* Mount-point source */
> +	Opt_source,
>  	/* Options that take integer arguments */
>  	Opt_debug, Opt_dfltuid, Opt_dfltgid, Opt_afid,
>  	/* String options */
> @@ -82,6 +84,7 @@ static const struct constant_table p9_cache_mode[] = {
>   * the client, and all the transports.
>   */
>  const struct fs_parameter_spec v9fs_param_spec[] = {
> +	fsparam_string  ("source",      Opt_source),
>  	fsparam_u32hex	("debug",	Opt_debug),
>  	fsparam_uid	("dfltuid",	Opt_dfltuid),
>  	fsparam_gid	("dfltgid",	Opt_dfltgid),
> @@ -210,6 +213,14 @@ int v9fs_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  	}
>  
>  	switch (opt) {
> +	case Opt_source:
> +                if (fc->source) {
> +			pr_info("p9: multiple sources not supported\n");
> +			return -EINVAL;
> +		}
> +		fc->source = param->string;
> +		param->string = NULL;

Yep, this looks correct, I think. It essentially "steals" the string from
the param and sets it in fc->source since the VFS won't do it for us.

I can't help but feel like there's maybe a better treewide fix for this
to make it all a bit less opaque, but for now this is what other
filesystems do, and so I think this is the right fix for my series at
this point.

Would you like me to send an updated patch with this change, or will you
just fix it on your end?

Thanks,
-Eric

> +		break;
>  	case Opt_debug:
>  		session_opts->debug = result.uint_32;
>  #ifdef CONFIG_NET_9P_DEBUG
> -----
> 
> I'll try to find some time to test a mix of actual mount options later
> this week
> 
> Cheers,


