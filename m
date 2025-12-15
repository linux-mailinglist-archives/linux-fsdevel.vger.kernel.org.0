Return-Path: <linux-fsdevel+bounces-71359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6E4CBF2F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 18:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3324F302573F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 17:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2E833F37A;
	Mon, 15 Dec 2025 17:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="DBmsQD4o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z9u8MS08"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BA53376A3;
	Mon, 15 Dec 2025 17:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765818570; cv=none; b=te8On8WizBMfpg2luGR/dgj5oBIw9p0D0EEdz/5MO5WwACg5h/SvQrdeflbjvi+RvCMN6fdbUAsp7tlmvrMPY5nRUJ1I6F7wo0GG0/V+RwnLBFhB8PDPht5WHdIP+ww9Hjt4kaVgMvIk0Vb6kd19BSscU911CS51An0DgmOKbKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765818570; c=relaxed/simple;
	bh=UpueoY4td8Le9kj70RSd7cpZwl2U2zAl8gIz9iDdiSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OLQFo5RyP82T0/IpgnZ7pCy8wjimVOOXkUS0LjMXIBqYOnJH66kEBEBLhn/laV0XjCDWsmKpe1CSrJq+gc6jLzuSSHanwXQ+jEj3YpA04YUpHmZHtgiWKGfNkDC5DYUCYfKp04yIb9feTwdNFaTuLvcYsa4Onsk2DK3v3UN3sc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=DBmsQD4o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z9u8MS08; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3EE6614001F1;
	Mon, 15 Dec 2025 12:09:19 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 15 Dec 2025 12:09:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1765818559;
	 x=1765904959; bh=xVWwiXFD+0T8MSjifsQoEy4fskO/HVJ0qZSwyVu4ZIM=; b=
	DBmsQD4oMM0qgWntCWtu0WtfgCf/MbXQL0FUzxGBYcCdiKwv6Ob824yeOfiSuBdV
	P1B90i6yCqsvXITHwrN+TSar2UAJcowbupdnIalHEtW8LBAmrSWKUhvHvbIaLJ4k
	jShsXUCGfXrijIeeaSbeTEJwxU4C/+fWMjhxWYiyvxVvmBUtKRer9/QvmRJQbDQT
	o1sXVzHHZuS+vFq+ZxmBtaSoS7krHEYHF8xglr2nqgbTh25V9wXTBWmzwb/EEc9d
	jvGwGI/vlrCEkHUzawnhwuFrN9HUs1ezWODsu0QFVWuuzv2pE/YTZhP/K1KEvjlV
	Uu2DLXq9S/ln1gdbpSN6FA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765818559; x=
	1765904959; bh=xVWwiXFD+0T8MSjifsQoEy4fskO/HVJ0qZSwyVu4ZIM=; b=Z
	9u8MS08Ik++NoxS3z66EZ0cJMm5KvLl6hGst26/iYdACNhfPrRO94El2ktlKhugD
	J80UG5N4Pw/OL78tsDsmMjLopfPrabQUp8gS4BbA6YRoReroHKpoYsk2wYnP1iHP
	p9zpvahy7mx4UjOLQyB2EvDXX88qBCYGxUPif6HJF+r/OAGzb/lfdjlSMXKOfy6U
	mRbpgHMmpET+yL1BZRMcdDxQZTZzOn0GhNlyI9qszF7/D1VGRTJBX4kqWVrJQJFr
	kkjlVZbgzkwcbArq2jtbKlhmFPmcfAt/Hqkj/VUV1pF9Fk6BrdGVZK3S/0EfrK2g
	HHxlroYaIcnqDyYLh3f5w==
X-ME-Sender: <xms:vkBAaTnfn8IXfsPJTqp0bgHes1h0G7rlhD_tYVLPcp3bB8rXjB16rg>
    <xme:vkBAaZ5CoOdVNPSImGLGiehDvXAYi3sCtH6QlXkti1K3n__KvgiDuCt9M-2TVYVhK
    bOoRcfNrs-6NO8MEDNtVoisYmnehpyWjnGQ4ZRqCL1okpioG9w>
X-ME-Received: <xmr:vkBAaUQp3GQuZa4G6m_Fqs7NASk9Ry4LYiXEKLRDXK2UmQA-9ZTjki3orkKJaWzcnQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefjeefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugessghssggvrhhnugdrtghomheqnecuggftrfgrth
    htvghrnhepfeeggeefffekudduleefheelleehgfffhedujedvgfetvedvtdefieehfeel
    gfdvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    gvrhhnugessghssggvrhhnugdrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtg
    homhdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhg
    pdhrtghpthhtohepuggrvhhiugesrhgvughhrghtrdgtohhmpdhrtghpthhtohepmhhikh
    hlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehlihhnuhigqdhmmheskhhvrggt
    khdrohhrghdprhgtphhtthhopegrthhhuhhlrdhkrhhishhhnhgrrdhkrhesphhrohhtoh
    hnmhgrihhlrdgtohhmpdhrtghpthhtohepjhdrnhgvuhhstghhrggvfhgvrhesghhmgidr
    nhgvthdprhgtphhtthhopegtrghrnhhilhesuggvsghirghnrdhorhhgpdhrtghpthhtoh
    eplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:vkBAaXwhg5qPoMSFxr2fjFWyNP3WxxYhQ73419jrK3qKUZ2yeX7Ssg>
    <xmx:vkBAacoS-5NRhIxVYWmGPTFL3D8ol9w16UKMZ8fl7XiWv23-lX1Ccw>
    <xmx:vkBAaa2MctWN15wgAlH3c4uX1-gQ9Gfl1BgMgTktPpzzX6UX9TGxLw>
    <xmx:vkBAacwVIAsywd5d6YrAgETJowG17h3I0KHd7Nw_L4SQyMrJOkmY-w>
    <xmx:v0BAaYs0WBymy6XKlOGtl7jdV99-_OSENo7ShJW2OJY5BD0iRI2jHBFg>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Dec 2025 12:09:17 -0500 (EST)
Message-ID: <2410c88d-380a-4aef-898e-857307a57959@bsbernd.com>
Date: Mon, 15 Dec 2025 18:09:16 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] fs/writeback: skip AS_NO_DATA_INTEGRITY mappings
 in wait_sb_inodes()
To: Joanne Koong <joannelkoong@gmail.com>, akpm@linux-foundation.org
Cc: david@redhat.com, miklos@szeredi.hu, linux-mm@kvack.org,
 athul.krishna.kr@protonmail.com, j.neuschaefer@gmx.net, carnil@debian.org,
 linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
References: <20251215030043.1431306-1-joannelkoong@gmail.com>
 <20251215030043.1431306-2-joannelkoong@gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US
In-Reply-To: <20251215030043.1431306-2-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/15/25 04:00, Joanne Koong wrote:
> Skip waiting on writeback for inodes that belong to mappings that do not
> have data integrity guarantees (denoted by the AS_NO_DATA_INTEGRITY
> mapping flag).
> 
> This restores fuse back to prior behavior where syncs are no-ops. This
> is needed because otherwise, if a system is running a faulty fuse
> server that does not reply to issued write requests, this will cause
> wait_sb_inodes() to wait forever.
> 
> Fixes: 0c58a97f919c ("fuse: remove tmp folio for writebacks and internal rb tree")
> Reported-by: Athul Krishna <athul.krishna.kr@protonmail.com>
> Reported-by: J. Neuschäfer <j.neuschaefer@gmx.net>
> Cc: stable@vger.kernel.org
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>   fs/fs-writeback.c       |  3 ++-
>   fs/fuse/file.c          |  4 +++-
>   include/linux/pagemap.h | 11 +++++++++++
>   3 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 6800886c4d10..ab2e279ed3c2 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -2751,7 +2751,8 @@ static void wait_sb_inodes(struct super_block *sb)
>   		 * do not have the mapping lock. Skip it here, wb completion
>   		 * will remove it.
>   		 */
> -		if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK))
> +		if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK) ||
> +		    mapping_no_data_integrity(mapping))
>   			continue;
>   
>   		spin_unlock_irq(&sb->s_inode_wblist_lock);
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 01bc894e9c2b..3b2a171e652f 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -3200,8 +3200,10 @@ void fuse_init_file_inode(struct inode *inode, unsigned int flags)
>   
>   	inode->i_fop = &fuse_file_operations;
>   	inode->i_data.a_ops = &fuse_file_aops;
> -	if (fc->writeback_cache)
> +	if (fc->writeback_cache) {
>   		mapping_set_writeback_may_deadlock_on_reclaim(&inode->i_data);
> +		mapping_set_no_data_integrity(&inode->i_data);
> +	}

For a future commit, maybe we could add a FUSE_INIT flag that allows privileged
fuse server to not set this? Maybe even in combination with an enforced request
timeout?

>   
>   	INIT_LIST_HEAD(&fi->write_files);
>   	INIT_LIST_HEAD(&fi->queued_writes);
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 31a848485ad9..ec442af3f886 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -210,6 +210,7 @@ enum mapping_flags {
>   	AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM = 9,
>   	AS_KERNEL_FILE = 10,	/* mapping for a fake kernel file that shouldn't
>   				   account usage to user cgroups */
> +	AS_NO_DATA_INTEGRITY = 11, /* no data integrity guarantees */
>   	/* Bits 16-25 are used for FOLIO_ORDER */
>   	AS_FOLIO_ORDER_BITS = 5,
>   	AS_FOLIO_ORDER_MIN = 16,
> @@ -345,6 +346,16 @@ static inline bool mapping_writeback_may_deadlock_on_reclaim(const struct addres
>   	return test_bit(AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM, &mapping->flags);
>   }
>   
> +static inline void mapping_set_no_data_integrity(struct address_space *mapping)
> +{
> +	set_bit(AS_NO_DATA_INTEGRITY, &mapping->flags);
> +}
> +
> +static inline bool mapping_no_data_integrity(const struct address_space *mapping)
> +{
> +	return test_bit(AS_NO_DATA_INTEGRITY, &mapping->flags);
> +}
> +
>   static inline gfp_t mapping_gfp_mask(const struct address_space *mapping)
>   {
>   	return mapping->gfp_mask;


Reviewed-by: Bernd Schubert <bschubert@ddn.com>

