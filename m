Return-Path: <linux-fsdevel+bounces-48012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB89AA8913
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 May 2025 21:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C01C43B5E34
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 May 2025 19:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE052459DD;
	Sun,  4 May 2025 19:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="HhUlsaVP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k+8PFMnw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B179221FDD
	for <linux-fsdevel@vger.kernel.org>; Sun,  4 May 2025 19:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746385447; cv=none; b=dHtH8t3co0QYHHiziB4BVCY7ZDOyMfhjWd34o9Bh2qa9Q4ewgaAloJT3iBXTskyZgEnzOtzyGf7G/2tFukUe50y/KL7Ds7cbZS6dQg4IkUFqo/xmjTHvWJEEi08oOdEperCDZq4mepNDehGZ2F1e5iIn6UJvPD9I+0IUSr2nr2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746385447; c=relaxed/simple;
	bh=LhrX7ruTvUxfY3eYfl3MLpcqf3hKZbrZssH7zEgkPLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BdFnwbqzhjHaE2z4qo1ju99fcVL9K4LdYfXfoY05Zbq59uerBSre1qr3ZpjTkbpWkpd/c8cfDbgp33YXm/czv2LAa2+onytRbdmuRAbTwRpgutDQfBXCtZC5RyeXFrOLfylVWhKg1j/CSdl+zH4DXjBw39yDKkzsotR673ey+9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=HhUlsaVP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k+8PFMnw; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5D32611400D5;
	Sun,  4 May 2025 15:04:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sun, 04 May 2025 15:04:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746385444;
	 x=1746471844; bh=hD9Ndx/9MxUD4BwgWqp+X8/bR114D+7WtSHTQkrANbo=; b=
	HhUlsaVPPs251sMgy9uWwYYqpHr61b8CYwXrGKPpBZLtXFhizlkCEXlqV2BT+LFb
	I9/qPbek91EH/ie748U4OuwEp2jJWAVDlne0yOTQqyz+lgzgKdpuFJVSssbNNEue
	oHgtDE8aOxZjDjcoGZfU1TpjYy71jYNaqLDt2fNdiCNuG1xpk7oTBMAlxjOYsE1a
	r7UCbTt79Ht9X4o3KR++Vwsjv2TC/iqQ8FGyCpL6ldincq5jviFZUwdnMSWi1iIc
	A6RVwKXKC/PT1riUoiLU8kf8zdKMYYPjmmw5zT68iob8VQ7x1zzCfXmhUDXIOyMe
	7+MB3IJB7WxunEnkTCruiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746385444; x=
	1746471844; bh=hD9Ndx/9MxUD4BwgWqp+X8/bR114D+7WtSHTQkrANbo=; b=k
	+8PFMnwuDsAQYYvwvpdEY3oCpnaokZKtjlxRUxfV4m++7rKclcstR8DcawOVkhrt
	aLZ0UlxJvRlHQ6XwPFoyScrSapC8Eko+w0TtSo9+OG+yttojHv3gRf+SnR0c6bv+
	U7fp/xdTFx0u4u8ujBSlJE68dA8L9qE7IIHU28ReFDXHG9ayD+fjBRizLEobfcrm
	DKSWavb8t2APmLlsy3fPc1j9pXCQbpl2czPzOvwChF/PzOXW2I6PahUnsEB2UVHb
	NHy22szkzceB+2tiqg1eSp+GCf9gM6cEy6OhwaqXpZvD/Vk2Q+v3OUreCfhewKP5
	H8dTLh1SSuGY9h1Rx3UMw==
X-ME-Sender: <xms:I7oXaO9Z70wStmkUs2GTFpQJ4fWJS2xsqeGmfGWUOjwDE6gsPv9H_Q>
    <xme:I7oXaOsgAD9xnWT2GoY5kTYgD-kZlSnQG3xu1Hoz3WUgkslDOZ34OYVSA6jTMIQzd
    SECCGwGdfiW8e5v>
X-ME-Received: <xmr:I7oXaEB-pQoIr2h-Rv2L8TakzuKI_sSUQjxMvMHrn8mTP1cZcZEJ-VM0dy1jgsIf53sSZHpwN_5fRDkjc-mWS2xNfG7l1VV-99TW_hzC2LU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjeeltddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddt
    vdejnecuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuh
    gsvghrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepvefhgfdvledt
    udfgtdfggeelfedvheefieevjeeifeevieetgefggffgueelgfejnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggv
    rhhtsehfrghsthhmrghilhdrfhhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtghomhdp
    rhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtoheplhhinh
    hugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehj
    lhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjvghffhhlvgiguheslh
    hinhhugidrrghlihgsrggsrgdrtghomhdprhgtphhtthhopehjohhsvghfsehtohigihgt
    phgrnhgurgdrtghomhdprhgtphhtthhopeifihhllhihsehinhhfrhgruggvrggurdhorh
    hgpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesmhgvthgrrdgtohhm
X-ME-Proxy: <xmx:I7oXaGetx1-gdGZHG_vcFA3_YdwgJehQRuify0ryNpj2qWoKs-hKGg>
    <xmx:I7oXaDMjB5fHp_gY84gg1ZyKHs6eysp9DPuqR6vdxU6nwr6xztv5dw>
    <xmx:I7oXaAlrlOWu1z0VGOaaXCFid-cKJLO1xftUMS9_wy0B0vl5GtyyKA>
    <xmx:I7oXaFs6RQV5SZWh6dLF7a23LC2wo4tI_nnMOHW7rJgnd0CmerHTbQ>
    <xmx:JLoXaIz1r-T-ak5-kCoJWUpHWXi7Q3By19CuydqqGSl2VqagzJWCHVEL>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 May 2025 15:04:02 -0400 (EDT)
Message-ID: <aaf03e96-a042-4a7b-bf6d-d125ef436975@fastmail.fm>
Date: Sun, 4 May 2025 21:04:01 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/11] fuse: support large folios for symlinks
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, jlayton@kernel.org,
 jefflexu@linux.alibaba.com, josef@toxicpanda.com, willy@infradead.org,
 kernel-team@meta.com
References: <20250426000828.3216220-1-joannelkoong@gmail.com>
 <20250426000828.3216220-7-joannelkoong@gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20250426000828.3216220-7-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/26/25 02:08, Joanne Koong wrote:
> Support large folios for symlinks and change the name from
> fuse_getlink_page() to fuse_getlink_folio().
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Reviewed-by: Bernd Schubert <bschubert@ddn.com>

> ---
>  fs/fuse/dir.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 1fb0b15a6088..3003119559e8 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -1629,10 +1629,10 @@ static int fuse_permission(struct mnt_idmap *idmap,
>  	return err;
>  }
>  
> -static int fuse_readlink_page(struct inode *inode, struct folio *folio)
> +static int fuse_readlink_folio(struct inode *inode, struct folio *folio)
>  {
>  	struct fuse_mount *fm = get_fuse_mount(inode);
> -	struct fuse_folio_desc desc = { .length = PAGE_SIZE - 1 };
> +	struct fuse_folio_desc desc = { .length = folio_size(folio) - 1 };
>  	struct fuse_args_pages ap = {
>  		.num_folios = 1,
>  		.folios = &folio,
> @@ -1687,7 +1687,7 @@ static const char *fuse_get_link(struct dentry *dentry, struct inode *inode,
>  	if (!folio)
>  		goto out_err;
>  
> -	err = fuse_readlink_page(inode, folio);
> +	err = fuse_readlink_folio(inode, folio);
>  	if (err) {
>  		folio_put(folio);
>  		goto out_err;
> @@ -2277,7 +2277,7 @@ void fuse_init_dir(struct inode *inode)
>  
>  static int fuse_symlink_read_folio(struct file *null, struct folio *folio)
>  {
> -	int err = fuse_readlink_page(folio->mapping->host, folio);
> +	int err = fuse_readlink_folio(folio->mapping->host, folio);
>  
>  	if (!err)
>  		folio_mark_uptodate(folio);


