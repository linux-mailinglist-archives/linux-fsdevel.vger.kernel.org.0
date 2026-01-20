Return-Path: <linux-fsdevel+bounces-74595-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E00D3C3F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 10:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3FA015402B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 09:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE25A3D6465;
	Tue, 20 Jan 2026 09:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="j33OTuP0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vRfEPB9l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13D12E972B;
	Tue, 20 Jan 2026 09:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768901298; cv=none; b=CuVRzpomCX9KlBEOrEEPD9CY1jUVchCkGToNqohsBRtsujG+08Gf4I2HLJmEPUxjwo6NGTzmvXJLzoxa5fJrC0xF60akpGRjyP3rCJu1iItuRMQnNqyxi3RLJ1Eoqbdpc/qBfdcVhh0zCSalmpzwdYZuZh1Mb9YQh4E0PRLu7GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768901298; c=relaxed/simple;
	bh=rC1jKjtaOGnzKCk9U382rfBYAo0TnSnxhD4UP+fwBoQ=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=nZEygSZxJnMLmDytGnQEgp9h3wRrAVF9/dCNoIwzEdd1FlA4HLxSIVTMhqEdgN2uOwGJngyrkYj6UCPF/0Fm2kOLseyJHrBgmvobWO9RtEnjGMyhJFElb/ylfR7w2aDf7XKicpf5N26uGPJaybc1YLz/7oFhrxtLw/hRrlmpWho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=j33OTuP0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vRfEPB9l; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.stl.internal (Postfix) with ESMTP id CE9921300F39;
	Tue, 20 Jan 2026 04:28:12 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 20 Jan 2026 04:28:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1768901292; x=1768908492; bh=7QgCrbLkIptlQB8MVpfuQ5CmfZ1YH3bd02H
	xJZ3+58E=; b=j33OTuP0cjno3z5TCSPfTCf69nIJq4J2TB5KtE0o/LhmJQgOMMH
	kw9U4yfo+H4rbb4XXms15vEyKh5x5b9B49ixFXgMxO4Fm/hlFNGiQ+bGN45gDtRw
	OmBoeYoqajuPHnyR9SoIEo6hAUWx0AGYwxm0DKRLHzi1XCnz83A+Hu2GZPA6aOKy
	RYLYKmY0UNhDwR1vtSOzYxhEesYwmuTg/Wi6L8FGSkj9+ZIBdbcCFjmPCZksIcHe
	kKd1xQhaGqcg0mozQ4CX54TPCVBCAS2wCwpvglGH91fDXLL6Bvjn2GFbB+NC5Mzg
	8aJ9uAz6SFiYHNlOnXGI9e3y5wQd6hGFAJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768901292; x=
	1768908492; bh=7QgCrbLkIptlQB8MVpfuQ5CmfZ1YH3bd02HxJZ3+58E=; b=v
	RfEPB9lwITUP46pQlb43ZbdMvxQAVBGMGvib8VTBG9JSo9K4qJAJLjbu5y7j73ym
	Qq3Bc0GK6JEw8nge/9U3NMkxvbjnEI/Ql3zoReMMAU2ycFjN5VLIXyTGDlZ9tldG
	YgURkKvG64q2sB1nBTb/8GE6Lw99gQK+2TICCynSDho7Mvxl3hSSag9eGoZb+MaV
	oo8v63rBhvVlkO8Ct3o6GUqwRPu+Ijq5yt0cKqsqAdpEZGpx+AkEVlFEQ3yPkt8x
	uJ/IqXAfO3Pl34Ql8sGavblmOZ2r9+wh8PIDOYvjhIPgR5sCl1S563/bzjtKHtCZ
	P4olLR+6UbfSBxEoSdPgg==
X-ME-Sender: <xms:qEpvaZRu_TffLaKZaE2CMY56BJZs69KBOLtnttktrwuGzZ9ody-WNQ>
    <xme:qEpvaQKNRSt0Wi7GeDYGOldsinZiQ_yhrx7t0k8T2G3tKf8FjH9OLeJ94c9A7G_ww
    X6RDyQAeSOcxaWQTYme-4_uSzp1k5iDvZmDz68VmQKXregkq1o>
X-ME-Received: <xmr:qEpvaUCQIq-1KHB6_RIe1LGDrNvPT7-Pf2pS69NApMKw_XyWcd3Xjgm1K74OT05ZV5sAHW67jfmb2iTtKkO835nraIAcdJpfENZOC6QYa41Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedttdehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:qEpvaeYFJm2gr5_L8NWl6mKqz3iuWcYL5GhOz7qN1Jbytm-BYS6-XA>
    <xmx:qEpvaWaRmlMl_FAkLOWmvpEFBndgYt5ijvyvEjxWGEaN27mPHvAi-g>
    <xmx:qEpvaQ3aTzLxTMX0gQJAiP7LkrKQZuiwBkg6xW_bdcSF80TWtR8qMw>
    <xmx:qEpvaefZ5gApKS4TFvhYKouLIp05WV67rLedqicozK4OIkyQ2Rx9Zg>
    <xmx:rEpvaZbrohR6KsMgi07NQMg42JbqLkXHlbfm5plWcXavjDNCqQ_UV7PJ>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jan 2026 04:27:50 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Christoph Hellwig" <hch@infradead.org>
Cc: "Christian Brauner" <brauner@kernel.org>,
 "Christoph Hellwig" <hch@infradead.org>,
 "Jeff Layton" <jlayton@kernel.org>,
 "Amir Goldstein" <amir73il@gmail.com>,
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
In-reply-to: <aW8w2SRyFnmA2uqk@infradead.org>
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>,
 <CAOQ4uxjOJMwv_hRVTn3tJHDLMQHbeaCGsdLupiZYcwm7M2rm3g@mail.gmail.com>,
 <9c99197dde2eafa55a1b55dce2f0d4d02c77340a.camel@kernel.org>,
 <176877859306.16766.15009835437490907207@noble.neil.brown.name>,
 <aW3SAKIr_QsnEE5Q@infradead.org>,
 <176880736225.16766.4203157325432990313@noble.neil.brown.name>,
 <20260119-kanufahren-meerjungfrau-775048806544@brauner>,
 <176885553525.16766.291581709413217562@noble.neil.brown.name>,
 <aW8w2SRyFnmA2uqk@infradead.org>
Date: Tue, 20 Jan 2026 20:27:46 +1100
Message-id: <176890126683.16766.5241619788613840985@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Tue, 20 Jan 2026, Christoph Hellwig wrote:
> On Tue, Jan 20, 2026 at 07:45:35AM +1100, NeilBrown wrote:
> > This sounds like you are recommending that we give in to bullying.
> 
> I find your suggestion that anything you disagree with is bullying
> extremely offensive.  If you have valid reasons for naming something
> after the user instead of explaining the semantics, please explain that.

I was referring not to your behaviour but to this statement by Christian:

  So if Christoph insists on the other name then I say let's just go with it.

I think that someone "insisting" on something rather than "arguing
rationally" for something "sounds like" bullying.  Had Christian said
something like "Christoph has convinced me of the wisdom of his choice"
that would have been very different.

I am quite happy to have reasoned discussions with people who disagree
with me.  I hope to always provide new relevant information, and hope
they will too.

> 
> If you think NFS actually explains the semantics pretty well, please
> explain that too, especially in forms that can be put into
> documentation, including for the user ABI.

There are multiple issues here:

 - filehandle stability.  As far as I know all filesystems provide
   stable filehandles when the "subtree_check" export option is not used.
   Certainly cgroupfs does.  So having an EXPORT_OP_STABLE_HANDLES
   flag would mean it was set for every filesystem - unless there is
   something else I'm not aware of.  That is certainly possible and I
   hope someone will let me know if I'm missing something.

 - filehandle uniqueness.  This is somewhat important and if a
   filesystem doesn't provide it, that should be considered a bug.  In a
   different thread Christian has observed that there would be benefit
   if pidfs and nsfs provided uniqueness across reboots.  It is quite
   easy for a virtual filesystem to generate a 64 bit random number when
   the fs is initialised, and include that in file handles.  Having a
   EXPORT_OP_REUSES_HANDLES flag could mark filesystems that are still
   buggy if that is thought to be useful.

 - GETATTR always reporting file size of 0.  This is the only concrete
   symptom that Jeff has reported (that I have seen).  This  makes it
   impossible to read files over NFS even if they have content.
   Would EXPORT_OP_INACCURATE_SIZE be useful?

 - maintainer feature choice.  A maintainer may choose not to support
   export over NFS because they feel that there is no value and the
   possible support burden would not be worth it.  There may be locking
   / lease / etc issues that further complicate things.  So it might be
   reasonable for a maintainer to choose to forbid NFS export while
   allowing local fhandle access. EXPORT_OP_NO_NFS_EXPORT.

It took me a while to sift through the code/patches/comments and come to
this understanding and I apologise if I wasn't as clear earlier.  But
my intuition was always that file handle stability was never the real
issue, and maintainer choice was.  Hence my rejection of the
"STABLE_HANDLES" name.

Thanks,
NeilBrown

