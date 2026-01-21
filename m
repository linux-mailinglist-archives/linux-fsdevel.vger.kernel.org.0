Return-Path: <linux-fsdevel+bounces-74775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHTOEhFScGlvXQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 05:12:01 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C5C50DE1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 05:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 49F4446686E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 04:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B843A9629;
	Wed, 21 Jan 2026 04:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="k3Rxmu5u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gAJ0npOh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a3-smtp.messagingengine.com (flow-a3-smtp.messagingengine.com [103.168.172.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891EC340287;
	Wed, 21 Jan 2026 04:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768968671; cv=none; b=RSzuF6ZR+f/yZ0DaO2XOWsHWENAO3JjL1RaARqSfLt3BUtp7n8NCBXhdiVoTuxtgXoGxSa/xxDjItb63qIiI5T+Oi8kdpiXsTJYGXDk5OI2qpK7GNYMM/qPy08wBYZR9/usbtTX20H8XKnNC31VvOlXH+pXZUi36Ok1urU+JbAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768968671; c=relaxed/simple;
	bh=S5q/wXvTe1ksmG2l2GU/dxpNKU7+kV4/8bzM26nMQjw=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=OAGaq7j0Y5gqY1ephbSGsu/3aPmhs6hhytC4nkJMsLkAzh96Ww8xHvVJiKji9i/ci7jaTpNLidLNk/UIx0hOK5kr9izUVyVztF40/+GrOyPZRELTQpBHYma/B22CJSOjt+0MDuEOE3CjqvF5QGdJxJuJ7YnGlrUqZ6t0ZxgHDDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=k3Rxmu5u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gAJ0npOh; arc=none smtp.client-ip=103.168.172.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.phl.internal (Postfix) with ESMTP id CDA9513807C6;
	Tue, 20 Jan 2026 23:10:49 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 20 Jan 2026 23:10:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1768968649; x=1768975849; bh=VHtydnr8fLS7IJeEIN+Bebc9EhZyuKs8Mry
	gf/E6Mwk=; b=k3Rxmu5uR9LzcxYLB3t0g9OZO0rJkXHWHzZwWU2baOA0T+BauMb
	JVwdNn8FXLcfJjWpT/PesgXD8rWNCNVfalot0ujFj+m9iIfbTfXgug2Q3yJqrVyB
	8eJIYj37xg9eo1bP9zpmammhxmuGoBzvKOGPf5Qihx0i4Xtur2zoOlGt4VqfI2Aq
	VcQiUYFS9VLDwzq7PFAV47UiRi8Z6ewfEdkzCtfuUcbBtYGQ4REwO/NQfx0wGxZa
	zaqsbkKg/7unaAaTepYNC7FeekN9e3dyldZZ6WnZ81ri0JmX1JvDTDOyA9r/um3Q
	0UTk91MwX8RKLgf76R+Fpg0kqrT6VIZzfKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768968649; x=
	1768975849; bh=VHtydnr8fLS7IJeEIN+Bebc9EhZyuKs8Mrygf/E6Mwk=; b=g
	AJ0npOh094R5rlQ+lB6V86VTqskShc/USfs9jmX1TOsWUZfsPdWnx0W03o0QsD0J
	ole/Eq8d6vjOz/TwgxXAi4GUViQNE7aP9SFrw1QS88PkqsRNgUMpp2Dsk75jigEL
	Tq3UezOIFJ8hQFHcKj89Ey79saQSKP0MwkW63MgMtbV/mnNXN/xKVwew/W1KuJOB
	UtSIMWwNUT/KJ08KW4iRnFlHq35eiupz+giAs+7ptzAfWnDBN/iL/8qtRpNmSEaA
	7+qwUSVwzkTj44zrlBWH3L4VcAF8ddte590kdslQTISEXKuf5ZNRlxQrYy4fTjd4
	+bXU8lH/3WUCP5TODW9mQ==
X-ME-Sender: <xms:x1FwaXcQqjPpSgnEH0JKgQq9qBmBgEL4xriEE0RJAFk0DGbOHo3GJQ>
    <xme:x1FwaRGn5TWEli8N0_6q7i-Js7HZaHfbVLccEQrr6Mlj8opNJxVvGV2IOF4DACpZJ
    67k8djIbKVq6CJIz8sMWvyebtGqxQwHb9fq0iYg9h6RLbhG>
X-ME-Received: <xmr:x1FwaeOCYluQbHVqHC0b8yb2QyAzu4oYGvwgfL3Rv1YcRePq4NfK1L8su9uzG-K39Rf20ZSVJLGZZZsgDaJ4alcLa9ozRYjqUp45LbFlfXWe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedvvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtjeertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epudetfefhudevhedvfeeufedvffekveekgfdtfefggfekheejgefhteeihffggfelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepjedvpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpd
    hrtghpthhtohepghhuohgthhhunhhhrghisehvihhvohdrtghomhdprhgtphhtthhopehl
    ihhnuhigqdigfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinh
    hugidquhhnihhonhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehl
    ihhnuhigqdhnihhlfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlih
    hnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    lhhinhhugidqvgigthegsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:x1FwaR8X47pB82llCoOnx-_tqfG4Wgl__nF7iR7DTsvnBKEgoxWWLA>
    <xmx:x1FwadL_4AgUdEoAdrrjBUzKm_QwvAZ5_vABwDi-yZXKOEZQmRVN-g>
    <xmx:x1FwacjsPmz0p5xJHKbK1Llgy6XHSkD5sIUV00neAVndqU1R0osl9Q>
    <xmx:x1FwaQ-U7Yh5HcQNL5v5YvAtJgbgLMSzKZeFpndI7b9KPjw4FZERdA>
    <xmx:yVFwafa--UBBDa_lEtTQJ8XgCJ_3LeDDEGWDRnQKAI7NA5gXIajXqhW->
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jan 2026 23:10:25 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Christoph Hellwig" <hch@infradead.org>,
 "Amir Goldstein" <amir73il@gmail.com>,
 "Christian Brauner" <brauner@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "Hugh Dickins" <hughd@google.com>,
 "Baolin Wang" <baolin.wang@linux.alibaba.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Theodore Ts'o" <tytso@mit.edu>,
 "Andreas Dilger" <adilger.kernel@dilger.ca>, "Jan Kara" <jack@suse.com>,
 "Gao Xiang" <xiang@kernel.org>, "Chao Yu" <chao@kernel.org>,
 "Yue Hu" <zbestahu@gmail.com>, "Jeffle Xu" <jefflexu@linux.alibaba.com>,
 "Sandeep Dhavale" <dhavale@google.com>,
 "Hongbo Li" <lihongbo22@huawei.com>, "Chunhai Guo" <guochunhai@vivo.com>,
 "Carlos Maiolino" <cem@kernel.org>, "Ilya Dryomov" <idryomov@gmail.com>,
 "Alex Markuze" <amarkuze@redhat.com>,
 "Viacheslav Dubeyko" <slava@dubeyko.com>, "Chris Mason" <clm@fb.com>,
 "David Sterba" <dsterba@suse.com>,
 "Luis de Bethencourt" <luisbg@kernel.org>,
 "Salah Triki" <salah.triki@gmail.com>,
 "Phillip Lougher" <phillip@squashfs.org.uk>,
 "Steve French" <sfrench@samba.org>, "Paulo Alcantara" <pc@manguebit.org>,
 "Ronnie Sahlberg" <ronniesahlberg@gmail.com>,
 "Shyam Prasad N" <sprasad@microsoft.com>,
 "Bharath SM" <bharathsm@microsoft.com>,
 "Miklos Szeredi" <miklos@szeredi.hu>,
 "Mike Marshall" <hubcap@omnibond.com>,
 "Martin Brandenburg" <martin@omnibond.com>,
 "Mark Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>,
 "Joseph Qi" <joseph.qi@linux.alibaba.com>,
 "Konstantin Komarov" <almaz.alexandrovich@paragon-software.com>,
 "Ryusuke Konishi" <konishi.ryusuke@gmail.com>,
 "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Dave Kleikamp" <shaggy@kernel.org>,
 "David Woodhouse" <dwmw2@infradead.org>,
 "Richard Weinberger" <richard@nod.at>, "Jan Kara" <jack@suse.cz>,
 "Andreas Gruenbacher" <agruenba@redhat.com>,
 "OGAWA Hirofumi" <hirofumi@mail.parknet.co.jp>,
 "Jaegeuk Kim" <jaegeuk@kernel.org>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-ext4@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org,
 ceph-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-cifs@vger.kernel.org, linux-unionfs@vger.kernel.org,
 devel@lists.orangefs.org, ocfs2-devel@lists.linux.dev,
 ntfs3@lists.linux.dev, linux-nilfs@vger.kernel.org,
 jfs-discussion@lists.sourceforge.net, linux-mtd@lists.infradead.org,
 gfs2@lists.linux.dev, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 00/29] fs: require filesystems to explicitly opt-in to
 nfsd export support
In-reply-to: <9fdf7a8c04861306b453a78233f4bd6004c465f4.camel@kernel.org>
References: <>, <9fdf7a8c04861306b453a78233f4bd6004c465f4.camel@kernel.org>
Date: Wed, 21 Jan 2026 15:10:22 +1100
Message-id: <176896862299.16766.6206046829320088529@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[ownmail.net,none];
	TAGGED_FROM(0.00)[bounces-74775-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,gmail.com,kernel.org,zeniv.linux.org.uk,oracle.com,redhat.com,talpey.com,google.com,linux.alibaba.com,linux-foundation.org,mit.edu,dilger.ca,suse.com,huawei.com,vivo.com,dubeyko.com,fb.com,squashfs.org.uk,samba.org,manguebit.org,microsoft.com,szeredi.hu,omnibond.com,fasheh.com,evilplan.org,paragon-software.com,nod.at,suse.cz,mail.parknet.co.jp,vger.kernel.org,kvack.org,lists.ozlabs.org,lists.orangefs.org,lists.linux.dev,lists.sourceforge.net,lists.infradead.org];
	FREEMAIL_FROM(0.00)[ownmail.net];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-fsdevel@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_GT_50(0.00)[72];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,noble.neil.brown.name:mid,ownmail.net:dkim,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,brown.name:replyto]
X-Rspamd-Queue-Id: E3C5C50DE1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 19 Jan 2026, Jeff Layton wrote:
> 
> There is another approach we could consider: We could move the
> export_operations that are needed for local filehandle access into a
> new struct filehandle_operations or something. It does mean adding an
> extra pointer to the super_block for the new operations vector, but it
> might be more intuitive.

If that sort of change were seen to be valuable, I would rather not
create a filehandle_operations but merge some (or all) of
export_operations into super_operations.
Maybe then the existence of s_export_op would return to mean "NFS export
supported" even if it is empty.

Thanks,
NeilBrown

