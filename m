Return-Path: <linux-fsdevel+bounces-48008-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54257AA88DD
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 May 2025 20:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADA60171A5B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 May 2025 18:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB49624678A;
	Sun,  4 May 2025 18:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="mI8WPVhg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rtw9rN0E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAA56DCE1
	for <linux-fsdevel@vger.kernel.org>; Sun,  4 May 2025 18:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746382044; cv=none; b=pQXI8+YQ4fX0MNFnijyOj4KULwvhr3zAc0drtj6k9m3z14qdG0jrvANL+ti8mZYKeqkH3wgl9OiDBIa+n95XEbX9BA+scMtwP/pp4dsqZ9lh53RkmRD/fTInOWwxuINFMDjusZMg2Pt+77rvRDLF7CEg6ACw6gFTnh5QEAuaY38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746382044; c=relaxed/simple;
	bh=QpPwCWMCof1IM0J3YqQvohdUm4O2MbmcIs5cMWsItQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GU//mZd4gIMR0LGJshI86eFVa6vOqzXZ8frWm3bhMkd6tQAMnEHTpjrxeZX9B5L6qRshFEx/axUqAE19iXwc8nVCoYtlFZ5KhypNQtRAqYK7ZBPYt67ZjXemflCiJ8Onoad0q7f1lXF67+LcV+XSOrd2C8u0BYtNZrdTmHprr2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=mI8WPVhg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rtw9rN0E; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ED2FE114014C;
	Sun,  4 May 2025 14:07:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sun, 04 May 2025 14:07:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746382040;
	 x=1746468440; bh=J2BpHE75untqUJEQ3syxQj6KG1rh1MV4/+HgjYgQ7i8=; b=
	mI8WPVhgvSCShEsqPKbmhg5iA4GwKwjL9oK5N1ilN5HiPepnbEOxpqqXmv39nmZb
	nb9JFLE3RA4taH+f0YVWN1KroMNi+x3XXGDFUb861VqkcQPkU590wX9k+SjMRSS9
	dYvkRWt9DxvAHUXlOh7p/dtlNplctS7zfEnBeP7eCom63nJzWw6BD3mT+uTElhpt
	7kw9hTyswvhM3v+VwnTLmweKqxEEEhAIRjsZnDkn6RLvltDJAK4/UEd0Mz9khkA0
	aEM+K80K5OhHTCTt9xHoEEThCsGdmy9IDMKsk8UCQWgDvVI73pUjzPJs8D9bE1vh
	oSBhlC+8fepEIN/yRX5zoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746382040; x=
	1746468440; bh=J2BpHE75untqUJEQ3syxQj6KG1rh1MV4/+HgjYgQ7i8=; b=R
	tw9rN0Et3Sl/T7QAghyJTaVKIM0t+RJqKGes5Cm9opj5OT2a8Qajgq5hkOP5Mxnd
	bsoWDpbimBjkrPdsLfOO2PGi1ewEF8UebIgTjUgiHVE79t1m8KtjUeJmk+LkWXNS
	9szU53yVeDixo5ojp64smERO99TphPsU+dMGmm/OQDsWrruh0D0zetoGjd0oWmqY
	E5SwIIdojln5/JqqkgksBPDd02AqPwMintDmrpCVJVjgzXArmD2EP4PxVZjd35ck
	6YxexWJfyLWbQIjKza2PscXqHwaPyCmaXcC70rK2Mf0h6JXcSfZvpXRLKYR257bh
	VUuxH1w8CN+4GSqcPa8Kg==
X-ME-Sender: <xms:2KwXaNLw4EXeLPNe86Pk8z-nYJj5TNgFEoISQMua3uNjPDcDI8Pxqg>
    <xme:2KwXaJJRsT525r9T26G_rjmru86Dx1xwU0eyIQSbHTwsEbpsBcwQzBhGhlOIxc0Sk
    uJHlC2joDZHJy0p>
X-ME-Received: <xmr:2KwXaFs_wcYqs9-rMMXPzlOk9hTJI5T96g8ZJeoMA6atK4FCvXyJRzgHgnPL4tXsA0Rn6_-YuRoYTCAagms015zE_1RnFs4XpPsgnBroEPs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjeekkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddt
    vdejnecuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuh
    gsvghrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepvefhgfdvledt
    udfgtdfggeelfedvheefieevjeeifeevieetgefggffgueelgfejnecuvehluhhsthgvrh
    fuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggv
    rhhtsehfrghsthhmrghilhdrfhhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtghomhdp
    rhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtoheplhhinh
    hugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehj
    lhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjvghffhhlvgiguheslh
    hinhhugidrrghlihgsrggsrgdrtghomhdprhgtphhtthhopehjohhsvghfsehtohigihgt
    phgrnhgurgdrtghomhdprhgtphhtthhopeifihhllhihsehinhhfrhgruggvrggurdhorh
    hgpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesmhgvthgrrdgtohhm
X-ME-Proxy: <xmx:2KwXaOYn-9XVGCoIozqu6uoHlfxfy1-UV_BIqbWOxE8AIYEkAhNKdA>
    <xmx:2KwXaEZlFDoWRbvzmHTLUeTY5acnFUCIftdaWcLFu77wb_QWJltZFQ>
    <xmx:2KwXaCCfGp9Tr7gBGaxj6HmxRjC9n0frrJeFrk1rKDyq9pniGs5Q6Q>
    <xmx:2KwXaCYSao3DBDlMDO03SIhvkeqJjTlKO92tn3w-9_QzjWTdryqmBQ>
    <xmx:2KwXaEcThZ794XXsO_mALpy29lyTetalQICJLUssYy1oReMWN6PfNdkL>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 May 2025 14:07:19 -0400 (EDT)
Message-ID: <a27e1ecd-5865-4b7d-b053-ee626b948821@fastmail.fm>
Date: Sun, 4 May 2025 20:07:18 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/11] fuse: support large folios for retrieves
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, jlayton@kernel.org,
 jefflexu@linux.alibaba.com, josef@toxicpanda.com, willy@infradead.org,
 kernel-team@meta.com
References: <20250426000828.3216220-1-joannelkoong@gmail.com>
 <20250426000828.3216220-3-joannelkoong@gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20250426000828.3216220-3-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/26/25 02:08, Joanne Koong wrote:
> Add support for folios larger than one page size for retrieves.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Reviewed-by: Bernd Schubert <bschubert@ddn.com>

> ---
>  fs/fuse/dev.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 7b0e3a394480..fb81c0a1c6cd 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -1837,7 +1837,7 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
>  	unsigned int num;
>  	unsigned int offset;
>  	size_t total_len = 0;
> -	unsigned int num_pages, cur_pages = 0;
> +	unsigned int num_pages;
>  	struct fuse_conn *fc = fm->fc;
>  	struct fuse_retrieve_args *ra;
>  	size_t args_size = sizeof(*ra);
> @@ -1855,6 +1855,7 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
>  
>  	num_pages = (num + offset + PAGE_SIZE - 1) >> PAGE_SHIFT;
>  	num_pages = min(num_pages, fc->max_pages);
> +	num = min(num, num_pages << PAGE_SHIFT);
>  
>  	args_size += num_pages * (sizeof(ap->folios[0]) + sizeof(ap->descs[0]));
>  
> @@ -1875,25 +1876,29 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
>  
>  	index = outarg->offset >> PAGE_SHIFT;
>  
> -	while (num && cur_pages < num_pages) {
> +	while (num) {
>  		struct folio *folio;
> -		unsigned int this_num;
> +		unsigned int folio_offset;
> +		unsigned int nr_bytes;
> +		unsigned int nr_pages;
>  
>  		folio = filemap_get_folio(mapping, index);
>  		if (IS_ERR(folio))
>  			break;
>  
> -		this_num = min_t(unsigned, num, PAGE_SIZE - offset);
> +		folio_offset = ((index - folio->index) << PAGE_SHIFT) + offset;
> +		nr_bytes = min(folio_size(folio) - folio_offset, num);
> +		nr_pages = (offset + nr_bytes + PAGE_SIZE - 1) >> PAGE_SHIFT;
> +
>  		ap->folios[ap->num_folios] = folio;
> -		ap->descs[ap->num_folios].offset = offset;
> -		ap->descs[ap->num_folios].length = this_num;
> +		ap->descs[ap->num_folios].offset = folio_offset;
> +		ap->descs[ap->num_folios].length = nr_bytes;
>  		ap->num_folios++;
> -		cur_pages++;
>  
>  		offset = 0;
> -		num -= this_num;
> -		total_len += this_num;
> -		index++;
> +		num -= nr_bytes;
> +		total_len += nr_bytes;
> +		index += nr_pages;
>  	}
>  	ra->inarg.offset = outarg->offset;
>  	ra->inarg.size = total_len;


