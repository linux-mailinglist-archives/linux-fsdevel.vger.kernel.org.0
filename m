Return-Path: <linux-fsdevel+bounces-54350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C69AFE6EA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 13:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B6653B3837
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 11:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741F328DB61;
	Wed,  9 Jul 2025 11:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="lyUI3kYA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KJSOIKab"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3EB3595C
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Jul 2025 11:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752059168; cv=none; b=XxlYHVTqPWPyVsZdPUcwtSWIxIJssBafLhoEo/0P9UIKC2/CaCwcYOwpAUN3pQq/zxlGt4J3v7cJ3zk6uebhDO6OLfS2a7lKAcaS6E16xC5OETzVM1CYYrPdwf9fuDF5vOUT5+SVDdhFfmGQdvnWrf8Btsr0dJpI4CBe7laxrcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752059168; c=relaxed/simple;
	bh=vukb+LXnzCSX6Be9B3T04BAAN3k3tRa20b5w2jPHLBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CAYptXMo9sr8kT/5n0pA3D2iqcVUyHbjhkU5O4E+oqsfdXgZy1k2WhNInWEjydXJ1gxZsHXk9d3gNDqJyFLiZL3rhCQFW03EPRAJ3s06r+eZ80rYSAq6KVdJ8bscOM61lT23f62giKYTOAfT9mn2/04ySqFbe6nU017jjYMaa24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=lyUI3kYA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KJSOIKab; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id A9C191D001A4;
	Wed,  9 Jul 2025 07:06:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 09 Jul 2025 07:06:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752059163;
	 x=1752145563; bh=6SrbkzQSffAn6GLdW7az5VaVu16+GjjLPlAkmwc3Z24=; b=
	lyUI3kYANckETbhM0x1IyR4tfMI/281JT7O+LXEzb9Dv8eNFE4l/FWlu6ktVcTPD
	jva6zZErMlQX11FGrbyZTN+4pH7UrXRd7nJbsc8G2ierUhcBZGi+q03lVNwDBFkB
	SzM7LppuQB1MAb382kE2TwLoQNbku1OryLfCu3bEx9+N50bz1jUdLJ2445AEmrQG
	k9FOPikbzVN5kIEsTN9pVTH+h9Q3gkoyAzCatoxHxwfij13lpDTgz0zDtohMHrKM
	FGhjJ34G7RDyI7UGnhvw3bBE0pnZL69P8PxgEz2KDPch/Xv6V7AYYkqbiM5OgJ0v
	6+ZLNrP+x5j9on0dZGq+ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752059163; x=
	1752145563; bh=6SrbkzQSffAn6GLdW7az5VaVu16+GjjLPlAkmwc3Z24=; b=K
	JSOIKabHGmd19O3e27UhShia7jB+8kEQ1UcInwN7fW4JHJCjlbBtWTqkU03H7/Os
	4eyqVqA2+Qoru0HMRwbKUtdu4c3x5pwAiSV3LL8cSWhxIFChQ8HNJoTeEBJWz632
	TxT1DhxWcMldOcFtwd1NTuV7I3vSS1sHRuEOMX330mCMYZGuPAPba3K9nqM8QM4W
	mE5V0ck1AUdVj9YkfyAL5Y29P8/zE47Q5VumLsQfatMvgsvJRDuvuRcqu5N8Cv08
	BJCFIaPmPaH0EOgiOLGUd7ELlJrHxYPH8hVzkPLH2UzQeTFv5+gnprMmeI++Z5o3
	znJhRv69F+uRVA8C75M/Q==
X-ME-Sender: <xms:G01uaPaawPQV0b5ifyCmfCNr9MqR_ZitTYyqhR_sNn85Cz9QHm5YZg>
    <xme:G01uaG1ZxriHqyuSnLdrJ6wafhc11TSc9dj1i0OOjScVXSN1DNI-6_bkFU3UXruLl
    9mt01C7f2oNnNOs>
X-ME-Received: <xmr:G01uaCZxNbuEWzxKNJw8s-FRaoCi34OLUF0w5Np0ikGf6dYAh90aT6bDoHC6Ts_LxnTyk1--RYA-dVmQb7c5_aBIVmKbLzSQUgP17Hqw8G1s2-l_rwpR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugessghssggvrhhnugdrtghomheqnecuggftrfgrth
    htvghrnhephefhjeeujeelhedtheetfedvgfdtleffuedujefhheegudefvdfhheeuvedu
    ueegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    gvrhhnugessghssggvrhhnugdrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehl
    ihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epuggrvhhiugesrhgvughhrghtrdgtohhmpdhrtghpthhtohepfihilhhlhiesihhnfhhr
    rgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhmmheskhhvrggtkhdrohhrgh
X-ME-Proxy: <xmx:G01uaGIg52JjGG2pbpSk40MaQjnXJUUb69cdwNeTeQEF5kH1WAqhaA>
    <xmx:G01uaJH0CCnCFDd0vnndK5VJ8TU8iQIwt8fCD1SrCUhd6buW5z-Lww>
    <xmx:G01uaFvePsYwEmkNvU4lUwZSmgyiXg-COWus4WEYMQYN7dCwJEs5PQ>
    <xmx:G01uaAtzPMnv5JKO4z5Fi5U9jcfI0LBXtA73QiuVrn-XEove6exlFw>
    <xmx:G01uaChFL1q0ceHpu2CAnDN_Ylc1TkU4phTtcsdNFh6q4sX3STYULHLZ>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Jul 2025 07:06:02 -0400 (EDT)
Message-ID: <4ef06726-1851-44af-b4d1-45b828746ce2@bsbernd.com>
Date: Wed, 9 Jul 2025 13:06:01 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] fuse: use default writeback accounting
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, david@redhat.com, willy@infradead.org,
 linux-mm@kvack.org
References: <20250707234606.2300149-1-joannelkoong@gmail.com>
 <20250707234606.2300149-2-joannelkoong@gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20250707234606.2300149-2-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/8/25 01:46, Joanne Koong wrote:
> commit 0c58a97f919c ("fuse: remove tmp folio for writebacks and internal
> rb tree") removed temp folios for dirty page writeback. Consequently,
> fuse can now use the default writeback accounting.
> 
> With switching fuse to use default writeback accounting, there are some
> added benefits. This updates wb->writeback_inodes tracking as well now
> and updates writeback throughput estimates after writeback completion.
> 
> This commit also removes inc_wb_stat() and dec_wb_stat(). These have no
> callers anymore now that fuse does not call them.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/file.c              |  9 +--------
>  fs/fuse/inode.c             |  2 --
>  include/linux/backing-dev.h | 10 ----------
>  3 files changed, 1 insertion(+), 20 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index adc4aa6810f5..e53331c851eb 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1784,19 +1784,15 @@ static void fuse_writepage_finish(struct fuse_writepage_args *wpa)
>  	struct fuse_args_pages *ap = &wpa->ia.ap;
>  	struct inode *inode = wpa->inode;
>  	struct fuse_inode *fi = get_fuse_inode(inode);
> -	struct backing_dev_info *bdi = inode_to_bdi(inode);
>  	int i;
>  
> -	for (i = 0; i < ap->num_folios; i++) {
> +	for (i = 0; i < ap->num_folios; i++)
>  		/*
>  		 * Benchmarks showed that ending writeback within the
>  		 * scope of the fi->lock alleviates xarray lock
>  		 * contention and noticeably improves performance.
>  		 */
>  		folio_end_writeback(ap->folios[i]);
> -		dec_wb_stat(&bdi->wb, WB_WRITEBACK);
> -		wb_writeout_inc(&bdi->wb);
> -	}

Probably, just my own style, personally I keep the braces when there are
comments.

>  
>  	wake_up(&fi->page_waitq);
>  }
> @@ -1982,14 +1978,11 @@ static void fuse_writepage_add_to_bucket(struct fuse_conn *fc,
>  static void fuse_writepage_args_page_fill(struct fuse_writepage_args *wpa, struct folio *folio,
>  					  uint32_t folio_index)
>  {
> -	struct inode *inode = folio->mapping->host;
>  	struct fuse_args_pages *ap = &wpa->ia.ap;
>  
>  	ap->folios[folio_index] = folio;
>  	ap->descs[folio_index].offset = 0;
>  	ap->descs[folio_index].length = folio_size(folio);
> -
> -	inc_wb_stat(&inode_to_bdi(inode)->wb, WB_WRITEBACK);
>  }
>  
>  static struct fuse_writepage_args *fuse_writepage_args_setup(struct folio *folio,
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index bfe8d8af46f3..a6c064eb7d08 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1557,8 +1557,6 @@ static int fuse_bdi_init(struct fuse_conn *fc, struct super_block *sb)
>  	if (err)
>  		return err;
>  
> -	/* fuse does it's own writeback accounting */
> -	sb->s_bdi->capabilities &= ~BDI_CAP_WRITEBACK_ACCT;
>  	sb->s_bdi->capabilities |= BDI_CAP_STRICTLIMIT;
>  
>  	/*
> diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
> index e721148c95d0..9a1e895dd5df 100644
> --- a/include/linux/backing-dev.h
> +++ b/include/linux/backing-dev.h
> @@ -66,16 +66,6 @@ static inline void wb_stat_mod(struct bdi_writeback *wb,
>  	percpu_counter_add_batch(&wb->stat[item], amount, WB_STAT_BATCH);
>  }
>  
> -static inline void inc_wb_stat(struct bdi_writeback *wb, enum wb_stat_item item)
> -{
> -	wb_stat_mod(wb, item, 1);
> -}
> -
> -static inline void dec_wb_stat(struct bdi_writeback *wb, enum wb_stat_item item)
> -{
> -	wb_stat_mod(wb, item, -1);
> -}
> -
>  static inline s64 wb_stat(struct bdi_writeback *wb, enum wb_stat_item item)
>  {
>  	return percpu_counter_read_positive(&wb->stat[item]);


Reviewed-by: Bernd Schubert <bschubert@ddn.com>

