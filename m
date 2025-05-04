Return-Path: <linux-fsdevel+bounces-48014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC7DAA891B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 May 2025 21:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 962077A3FB5
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 May 2025 19:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DD12475CE;
	Sun,  4 May 2025 19:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="icwJ7oao";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VeLFyOXQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB301367
	for <linux-fsdevel@vger.kernel.org>; Sun,  4 May 2025 19:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746386029; cv=none; b=TALk63n/j+2MXd1pQ4pOjjgSODnK81BEML1bjqG9eI5NFPoYC82AqrQNXOgwp8eVn/Hz2OzJqzSJKkaxMwGa4WbGSSon/zqYTnY8ktRez0YSkdfZKXHcnBQFLAOI9ScdJUHeNkOKgtDXjOp6ZnWO8XSwQICNPsXd5lYeqEgtE84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746386029; c=relaxed/simple;
	bh=UGx4CVW1QlHd10fJaToWgtNyWlX+AMZvyLbDdsgxu0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hhq6nrr7oYToUzwDOewVefLTQABFAa4yEe0Tamw7OViDuGqUV0w8SbY3HnU7VzShfB67nOoB8y02WeZXHlL2bi5hsLqP/bL+nTG1tz7BV9eLLbNPITt7KnJADXjGcjXz5uUYgoMIdeuVIpFLGlSuLheNm0qFTebx5M6RtJAZR48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=icwJ7oao; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VeLFyOXQ; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 9DE9B138014C;
	Sun,  4 May 2025 15:13:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sun, 04 May 2025 15:13:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746386026;
	 x=1746472426; bh=DZlRz/vqzTTyynuuzpj4Xs5Bs9CxAnBffU8swHlVs+8=; b=
	icwJ7oaoMjfsG/n/3MkKlU3txgpbQrzrdVwmRtIod6KTwOqiRqiuGOL1jL1RDWn9
	Z2H/vHFb9xzgDs+x9GAcFIy2hNqIk/VPPUX/v2NTAxjRI5Iyhj9mNCd8LT+UwKGX
	NHv46PjBV+by+7t1gLZReIWA8/dsiU69qZ3YbS952GpuSUmLtVF/v8Fa7vq0XQD0
	chGA1JcR/ZMBJo7YEQHjDgmdbp1ZI4rYUtxvdMsJk2hGeA6527/O3FE9Q7z2ZKu0
	k59ea0Z7crBoxUZYuaYd0JqZUgCDEFp+M30DlLpRvoIFn/yHSu8hLQj99l1YvqcI
	FBnzISgJy9YYxYSygGy9DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746386026; x=
	1746472426; bh=DZlRz/vqzTTyynuuzpj4Xs5Bs9CxAnBffU8swHlVs+8=; b=V
	eLFyOXQz1KKap5KbMlWLooC8kVrvCCFoMe6/ndTictTFRPO252x7xQmY4+E4NpaM
	m1tnDLESE+0czgXsR3Pqm04gDzLTabdWMs/S6nka8SmFNAAvQwWzi5AkieTeFkJn
	3mvJCIL5IvUm1tGdZiBNeZIbh4pe6OqruNssf8PrhkNq3NTmB5v27ZH2Tb+ErIQu
	FAufTljI6fL9gcHn6lhp3jOXaJjTYNFreJuWLI+mIsqxRmH/9xMTQy5X1pA8pdgj
	xNFWRW+jv52HRk/nOatW816xxiHlB4qe4MgPV7O+cofLmGa/11/j1Hgs+Q6GpCuE
	3i70sEBNYgpHrvyQSJyRQ==
X-ME-Sender: <xms:arwXaPzxeqy2y6Ipox2H6Oz5unKB35TeVCIhuU4JMfW6EVhUh2SV3w>
    <xme:arwXaHSMB8plZpfNlEpmTzL3qvtYyB8UmWMZL2dVMDQ52Qlmc5eZiLVYqmxfD9_mH
    cCCvqtw8vTRKrct>
X-ME-Received: <xmr:arwXaJVdt9cpHp_HJhWgYTujfm6nbefIUuoZZ-ENoSEHNTL7Woktz0cPlGyRAJBp84MlwB0WonhlcW-SXNmIjBq9z0cq-O7-OKM0aKZvx1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjeeltddvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:arwXaJgiZldrqP7Bgl6rarQtcOq4_g23xWVa3D--U-YO7V53XLGTdg>
    <xmx:arwXaBAP9emqt1Es0Sj4JuulyAyJBHWmIDxFCyj0mP0UQq4o_CRxzA>
    <xmx:arwXaCJmhgwFSXLm6q8nsiIDd_BYCRLKOSKRWzPAr4-lcE5hpGUrLA>
    <xmx:arwXaACa8SpYOEgS8AiJnGE6eP453CXBds9fU6cpZVnY-yv_GEoH3A>
    <xmx:arwXaEFqzPF7QQeEBmhjZ7Hl9jdnvVbrx6NaVg33nqexy5MpHrPL5p38>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 May 2025 15:13:45 -0400 (EDT)
Message-ID: <007d07bf-4f0b-4f4c-af59-5be85c43fca3@fastmail.fm>
Date: Sun, 4 May 2025 21:13:44 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/11] fuse: support large folios for readahead
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, jlayton@kernel.org,
 jefflexu@linux.alibaba.com, josef@toxicpanda.com, willy@infradead.org,
 kernel-team@meta.com
References: <20250426000828.3216220-1-joannelkoong@gmail.com>
 <20250426000828.3216220-10-joannelkoong@gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20250426000828.3216220-10-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/26/25 02:08, Joanne Koong wrote:
> Add support for folios larger than one page size for readahead.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/fuse/file.c | 36 +++++++++++++++++++++++++++---------
>  1 file changed, 27 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 1d38486fae50..9a31f2a516b9 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -876,14 +876,13 @@ static void fuse_readpages_end(struct fuse_mount *fm, struct fuse_args *args,
>  	fuse_io_free(ia);
>  }
>  
> -static void fuse_send_readpages(struct fuse_io_args *ia, struct file *file)
> +static void fuse_send_readpages(struct fuse_io_args *ia, struct file *file,
> +				unsigned int count)
>  {
>  	struct fuse_file *ff = file->private_data;
>  	struct fuse_mount *fm = ff->fm;
>  	struct fuse_args_pages *ap = &ia->ap;
>  	loff_t pos = folio_pos(ap->folios[0]);
> -	/* Currently, all folios in FUSE are one page */
> -	size_t count = ap->num_folios << PAGE_SHIFT;
>  	ssize_t res;
>  	int err;
>  
> @@ -918,6 +917,7 @@ static void fuse_readahead(struct readahead_control *rac)
>  	struct inode *inode = rac->mapping->host;
>  	struct fuse_conn *fc = get_fuse_conn(inode);
>  	unsigned int max_pages, nr_pages;
> +	struct folio *folio = NULL;
>  
>  	if (fuse_is_bad(inode))
>  		return;
> @@ -939,8 +939,8 @@ static void fuse_readahead(struct readahead_control *rac)
>  	while (nr_pages) {
>  		struct fuse_io_args *ia;
>  		struct fuse_args_pages *ap;
> -		struct folio *folio;
>  		unsigned cur_pages = min(max_pages, nr_pages);
> +		unsigned int pages = 0;
>  
>  		if (fc->num_background >= fc->congestion_threshold &&
>  		    rac->ra->async_size >= readahead_count(rac))
> @@ -952,10 +952,12 @@ static void fuse_readahead(struct readahead_control *rac)
>  
>  		ia = fuse_io_alloc(NULL, cur_pages);
>  		if (!ia)
> -			return;
> +			break;
>  		ap = &ia->ap;
>  
> -		while (ap->num_folios < cur_pages) {
> +		while (pages < cur_pages) {
> +			unsigned int folio_pages;
> +
>  			/*
>  			 * This returns a folio with a ref held on it.
>  			 * The ref needs to be held until the request is
> @@ -963,13 +965,29 @@ static void fuse_readahead(struct readahead_control *rac)
>  			 * fuse_try_move_page()) drops the ref after it's
>  			 * replaced in the page cache.
>  			 */
> -			folio = __readahead_folio(rac);
> +			if (!folio)
> +				folio =  __readahead_folio(rac);
> +
> +			folio_pages = folio_nr_pages(folio);
> +			if (folio_pages > cur_pages - pages)
> +				break;
> +

Hmm, so let's assume this would be a 2MB folio, but fc->max_pages is
limited to 1MB - we not do read-ahead anymore?

Thanks,
Bernd


>  			ap->folios[ap->num_folios] = folio;
>  			ap->descs[ap->num_folios].length = folio_size(folio);
>  			ap->num_folios++;
> +			pages += folio_pages;
> +			folio = NULL;
> +		}
> +		if (!pages) {
> +			fuse_io_free(ia);
> +			break;
>  		}
> -		fuse_send_readpages(ia, rac->file);
> -		nr_pages -= cur_pages;
> +		fuse_send_readpages(ia, rac->file, pages << PAGE_SHIFT);
> +		nr_pages -= pages;
> +	}
> +	if (folio) {
> +		folio_end_read(folio, false);
> +		folio_put(folio);
>  	}
>  }
>  


