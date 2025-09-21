Return-Path: <linux-fsdevel+bounces-62339-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1E8B8D965
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Sep 2025 12:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A49E54403C8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Sep 2025 10:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECED258EFC;
	Sun, 21 Sep 2025 10:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="suPlKyrD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GeQRDIo/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEC424A066;
	Sun, 21 Sep 2025 10:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758450150; cv=none; b=jht46VBY4r6rwJpxnaWGCEjGw7P/YhXLmP+6hg66p6vTTYwqlPfY+eJPD4cXTB3OyWZgdcxuWMUsy8yFIpGqbKPgIv9ECv4UND2vRj+100VGFL1qvn8MC763u6TApXZUUpYN9K29876zM5b9VfYJWOd3ofn4w/4NMg23e6mzPAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758450150; c=relaxed/simple;
	bh=EuaMo6D/BJKLE6f/Qu2pbLWx6rfoIYSR/NXFNH+/L3U=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=iXigrRaS+OmOAx4XRexOSOGeoV3HJ923aeR5q43WRG+tlXjHO06b41ZinYjIP92FV1ZLFMl27FMPL4F/nnYuTlW7BeDJUFGab3ioxu/bEl7AHtoCTwgL9MLVmENGDx1PVVEIgSM+PM6sfPGCNW7hMvNyvGjDFFfbWY270DZuj50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=suPlKyrD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GeQRDIo/; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 562C314000FC;
	Sun, 21 Sep 2025 06:22:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sun, 21 Sep 2025 06:22:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1758450147; x=1758536547; bh=z4dTzHicOmu0ud13rOeQ61ccyjqJXmSHMtb
	dd650m2s=; b=suPlKyrDIIb3+IwNlbntYUFM9a0CpPFkrFNA265367EGvWcyL6g
	Ai3GxZx0x+4ArraDgo85aSSM6UQ4zzFGVA5VIEciOlSm3NNSWX25P5Y03QWE28I3
	CLe6f2VtSTdh4JJKb+G/1iqdVfzX0vAmv0rw3WzjY6AV5y90Gk3IeMMfARA36sOH
	HpJc25LV040BNWMua/br1P4ozNIqmfIxCFvLkngByr/O5d1WPsGJ3KRF4kkGQuB9
	S9eEzNsKbEG3NxPAg9XaP00LN2cp8jxFXUVLY3emc7MIrrwwoRA8u81v7iQcDmwB
	y1i85q2UsOjLlxCKTdi3KzV5btBgy0j8lkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758450147; x=
	1758536547; bh=z4dTzHicOmu0ud13rOeQ61ccyjqJXmSHMtbdd650m2s=; b=G
	eQRDIo/bVDytypOm19Nj87vmudllOQ9j3VlOHWvohikkIUe1MVoAnRfTnb6vhZG5
	p/cfn+Y69hQFq+LVxWZ+cDO0PRm78tF1WIHNftcRqY4jWKzNPYz/PYCASiN4T7dQ
	Ff0byzGrYNOTxv9a00wLEgh7Gxodwbti8lnoGpLU6lf/v6i1l7z0vb1Vww21tC7U
	K5yuRQ00OCVFDsDfZsOmzfTDSHTacSs4GGwG3NyiQgJvWadUrnUBAu+OrOJ+aYl6
	6m6TGOIv9j/d9/dL6Ak7LlYiyTg58SG9j90U7kwqG7mGOfPxJlTcpdXt+6/6EDcN
	eM/eiPVRXLdSFxgbW1jzg==
X-ME-Sender: <xms:4tHPaNn-6gqhyy2fn228rdPkVbYp_Ug6kGDDGg2DHA_UQqBKha9eUw>
    <xme:4tHPaOnAXRg9ewbcwMnOihWBSq0CcdpuYvlOUopk6I_0inPF1phzlafTbq6JWqCIc
    p6hDERGz-ekLA>
X-ME-Received: <xmr:4tHPaBvIC1wTbzMyk6Z6_pupiyb2-fdrDwS3wmltW5QQior3XvDjrxQFy5SPe20vXimLdad3qAUTV9KiHeJdEVBVTaKfgGCxDkhwN4vsSbQB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehgeejvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthhqredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    ffveejleejheeujeegheelleeuveduheejkeegveeuffetvefhfeevtdeuuefgjeenucff
    ohhmrghinhepghhithhhuhgsrdgtohhmpdhkvghrnhgvlhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgssehofihnmhgr
    ihhlrdhnvghtpdhnsggprhgtphhtthhopedujedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprhgtphhtthho
    pehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuh
    igqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hinhhugidqughotgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdgtihhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuh
    igqdgstggrtghhvghfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegs
    phhfsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgrtghksehsuhhsvg
    drtgii
X-ME-Proxy: <xmx:4tHPaIJcxLI3mylMD65vcVWusoP2ANC-YLZj18LljgYs_YDW3iCO8g>
    <xmx:4tHPaGgZA-AHazPVIA52TncFHJ17tXzJ_qghKTM5oUTHW75gg4Kr9g>
    <xmx:4tHPaEv6cEE7Fyvgf5R_3YeXxs9nKDVZb4dA2WqlhHve4Jshif9Q_w>
    <xmx:4tHPaIiKeeX1mmr-u8fMPJqBpiX9lJy-gb8Y3tvRhBYBzbFC7qYN4A>
    <xmx:49HPaJOA2ecx8oezZruDJjk7UiOe6Ag1tYRGEkvQOih3emkbW4M3hGxH>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 21 Sep 2025 06:22:22 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "kernel test robot" <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
 "Amir Goldstein" <amir73il@gmail.com>, linux-doc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 ocfs2-devel@lists.linux.dev, linux-cifs@vger.kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jeff Layton" <jlayton@kernel.org>,
 "Jan Kara" <jack@suse.cz>, oliver.sang@intel.com
Subject:
 Re: [PATCH v3 5/6] VFS: rename kern_path_locked() and related functions.
In-reply-to: <202509211121.ebd9f4b0-lkp@intel.com>
References: <20250915021504.2632889-6-neilb@ownmail.net>,
 <202509211121.ebd9f4b0-lkp@intel.com>
Date: Sun, 21 Sep 2025 20:22:13 +1000
Message-id: <175845013376.1696783.14389036029721020068@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sun, 21 Sep 2025, kernel test robot wrote:
>=20
> Hello,
>=20
> kernel test robot noticed "BUG:unable_to_handle_page_fault_for_address" on:
>=20
> commit: 747e356babd8bdd569320c29916470345afd3cf7 ("[PATCH v3 5/6] VFS: rena=
me kern_path_locked() and related functions.")
> url: https://github.com/intel-lab-lkp/linux/commits/NeilBrown/VFS-ovl-add-l=
ookup_one_positive_killable/20250915-101929
> base: https://git.kernel.org/cgit/linux/kernel/git/vfs/vfs.git vfs.all
> patch link: https://lore.kernel.org/all/20250915021504.2632889-6-neilb@ownm=
ail.net/
> patch subject: [PATCH v3 5/6] VFS: rename kern_path_locked() and related fu=
nctions.

This incremental fix should be sufficient.

Thanks,
NeilBrown


diff --git a/fs/namei.c b/fs/namei.c
index 5ceb971632fe..92973a7a8091 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2772,7 +2772,7 @@ static struct dentry *__start_removing_path(int dfd, st=
ruct filename *name,
 	if (unlikely(type !=3D LAST_NORM))
 		return ERR_PTR(-EINVAL);
 	/* don't fail immediately if it's r/o, at least try to report other errors =
*/
-	error =3D mnt_want_write(path->mnt);
+	error =3D mnt_want_write(parent_path.mnt);
 	inode_lock_nested(parent_path.dentry->d_inode, I_MUTEX_PARENT);
 	d =3D lookup_one_qstr_excl(&last, parent_path.dentry, 0);
 	if (IS_ERR(d))
@@ -2789,7 +2789,7 @@ static struct dentry *__start_removing_path(int dfd, st=
ruct filename *name,
 unlock:
 	inode_unlock(parent_path.dentry->d_inode);
 	if (!error)
-		mnt_drop_write(path->mnt);
+		mnt_drop_write(parent_path.mnt);
 	return d;
 }
=20

