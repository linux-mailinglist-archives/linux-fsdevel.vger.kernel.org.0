Return-Path: <linux-fsdevel+bounces-73142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E16B7D0DE80
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 23:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD13B303E02C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 22:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE8A2BE7D6;
	Sat, 10 Jan 2026 22:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uIECgSaC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40C92512E6;
	Sat, 10 Jan 2026 22:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768084369; cv=none; b=gYx/PhbZRbwV8wovsFeyi+LmyKytZnKjyOtfgDRJ3+0v5etZZRBVRWHCO0AGoaSE1Wps2HI9u6k1IaMQcQ91P/lpc6EZVfOjGmZQr3qpGN3M+kvhlkkFSkZWdiy+aWc8dBBVJZuMbeT6S6dqubPAMIxrAPeTFwkNju6XCbF5yCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768084369; c=relaxed/simple;
	bh=oAW94gm3vd8W2ohOygrMjlHLVVoVtqYi3vmPwGAE9nM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=UrCkqyCmk7NEEROZg3HjRoDSnvSK4DxGOj1PrJxhSjqNMhXDea4OHz1LgAvaX8dA7iseaiYc/fKaKK1RgeSeqGLTl6oq3wgDyi6u2ne9uaVto3ClGcSoRUSNMlGUspYFfs3oUhWGzhI/XEoer0qQwiIMcIQj9uqAmk0l+tnQIEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uIECgSaC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33465C4CEF1;
	Sat, 10 Jan 2026 22:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768084369;
	bh=oAW94gm3vd8W2ohOygrMjlHLVVoVtqYi3vmPwGAE9nM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=uIECgSaC7c/KFMx0lq/iT7PTFFhpqTfYszY75Vf/qvGFqE4yfoxhYCBeqZ617/enb
	 lx6tfAnPWksHQDuEI4JhgoWjOOFcUItSp841JFPO0HKpFGC50zPz5mGiRRoxcl5JKb
	 +vTVudJ9uwZnUs9iC5RvQNHImv9o6HbhzOSC0zhTmGead82SFEFuuOOk5l1aPep3+q
	 GbFHNEM8Qilzf/W5qMKDrRu+Cgj4pJhUXd2NbKIr3q1zi5M2LOYrpOoy58Af25YSIK
	 icFhi/1fBC95ImUHiEnUYs/Tl24GE6wvNRnOG3WokrcbIwIYkFSGI+gbNVnWNVckOO
	 FtgFissZ6T/Rw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 4C188F40068;
	Sat, 10 Jan 2026 17:32:48 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Sat, 10 Jan 2026 17:32:48 -0500
X-ME-Sender: <xms:kNNiaYhSzm5r5IXAL8SG6xwxIgZZL3Dlon8LIudo925dBWDrZ9Mj_w>
    <xme:kNNiab0n7mzsWfTLCk1AO9TY-idwcQalF4lMISGbtF6SCKG1Nz_FJsdq7rrVwI_J0
    FPaLVQNEZ6eJZENcQFR67rlXRdc2tbdpjcyAWpF9rV_YhHsTRlyAWut>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduuddvledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepnhgvihhlsegsrhhofihnrdhnrghmvgdprhgtphhtthhopehjlhgrhihtohhnse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghl
    vgdrtghomhdprhgtphhtthhopegurghirdhnghhosehorhgrtghlvgdrtghomhdprhgtph
    htthhopehokhhorhhnihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepthhomhes
    thgrlhhpvgihrdgtohhmpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrd
    horhhgrdhukh
X-ME-Proxy: <xmx:kNNiaZkCozX01KTS3Re-j6VN6OfGeJxPiSfLkRGNXWGGiYZe_b5vFw>
    <xmx:kNNiaSNp57kFYNT76T7nXJp2A3Z2EY981PwO9nVO7tzoaRDY9ptQdA>
    <xmx:kNNiaW-tQy_AOw7xa53q2mjqG79WRn6o-DYjCa7X_NDAJIVCRlaHeg>
    <xmx:kNNiaUH7tqWSARo65sSUd0yL5UuiWiAx5K6SW7TGufqemdQ22HJq8Q>
    <xmx:kNNiaVhxA7UYCoiQ87RsQ5YWLvv1qdNDQyDfUFp4CvCMYTuxd9DA9QBq>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 27998780054; Sat, 10 Jan 2026 17:32:48 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AGJJpQnrpxIw
Date: Sat, 10 Jan 2026 17:31:02 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>
Cc: NeilBrown <neil@brown.name>, "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, "Chuck Lever" <chuck.lever@oracle.com>
Message-Id: <c04214f2-74c6-4b7f-9805-9130e888bee9@app.fastmail.com>
In-Reply-To: <20260110220816.GE3634291@ZenIV>
References: <20260108004016.3907158-1-cel@kernel.org>
 <20260108004016.3907158-5-cel@kernel.org>
 <176794792304.16766.452897252089076592@noble.neil.brown.name>
 <50610e1c-7f09-4840-b2b2-f211dd6cdd5f@app.fastmail.com>
 <20260110164946.GD3634291@ZenIV>
 <0599548b-49c1-44e0-b0a8-a077cbdfbcce@kernel.org>
 <20260110220816.GE3634291@ZenIV>
Subject: Re: [PATCH v2 4/6] fs: invoke group_pin_kill() during mount teardown
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Sat, Jan 10, 2026, at 5:08 PM, Al Viro wrote:
> On Sat, Jan 10, 2026 at 03:07:38PM -0500, Chuck Lever wrote:
>
>> 4. The result is that if a share is unexported while NFSv4 clients still
>> have that share mounted, open/lock/delegation state remains in place,
>> and the underlying files remain open on the NFS server. That prevents
>> the shared file system from being unmounted (which is sometimes the very
>> next step after unexport). As long as the NFS client maintains its lease
>> (perhaps because it has other shares mounted on that server), those
>> files remain open.
>> 
>> The workaround is that the server administrator has to use NFSD's
>> "unlock file system" UI first to revoke the state IDs and close the
>> files. Then the file system can be unmounted cleanly.
>> 
>> 
>> Help me understand what you mean by write count? Currently, IIUC, any
>> outstanding writes are flushed when each of the files that backs a
>> stateid is closed.
>
> File opened for write carries has write access granted at open time and
> keeps it until the final fput().  Try this:
>
> root@cannonball:/tmp# mkdir /tmp/blah
> root@cannonball:/tmp# mount -t tmpfs none /tmp/blah/
> root@cannonball:/tmp# exec 42>/tmp/blah/a
> root@cannonball:/tmp# mount -o remount,ro /tmp/blah/
> mount: /tmp/blah: mount point is busy.
>        dmesg(1) may have more information after failed mount system call.
> root@cannonball:/tmp# exec 42>&-
> root@cannonball:/tmp# mount -o remount,ro /tmp/blah/
> root@cannonball:/tmp# ls /tmp/blah/a 
> /tmp/blah/a
> root@cannonball:/tmp# umount /tmp/blah 
> root@cannonball:/tmp#
>
> You don't need to be in the middle of write(2); just having a file opened for
> write prevents r/o remount.

After an unexport, NFS clients can't WRITE -- NFSD will reject WRITE
requests with NFS4ERR_STALE, AIUI.

If "unlock file system" closes the files that NFSD is holding open on
an exported file system, then shouldn't that bring the write count down
by definition?

(Fwiw, I'm talking about /proc/fs/nfsd/unlock_filesystem).


> Do you want to be able to
> 	* umount without an unexport?
> 	* remount read-only without an unexport?

I think unexport is a reasonable pre-requisite for any configuration
changes to the local mount on the NFS server. So IMHO we don't want
either of those.

The issue I'm trying to resolve is that even after unexport, unmount
doesn't work reliably. Triggering "unlock_filesystem" automatically
on unmount should be able to mitigate or fully address that.


-- 
Chuck Lever

