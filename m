Return-Path: <linux-fsdevel+bounces-60417-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A821B46967
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 08:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6B0C17CFEE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 06:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC892BE7C0;
	Sat,  6 Sep 2025 06:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="NcI8f4eA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gbA4zXaK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D551E520F;
	Sat,  6 Sep 2025 06:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757139690; cv=none; b=Ao7ENFQOOSmftUkKk0K6YT+BWXNUroyOokoJkZilM58G5iwS5p/lBX+O6MEfA+7kxjh7xyE3zLFkwetI3ub3f/R1zPmkN9UrPXGZmYtkYuBr7kAuLiP/1Fj+BguGhHhKhIwcj7L5XuUOFtPYobopw3v1ldUdoppgZVErdhnGwk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757139690; c=relaxed/simple;
	bh=OhFYpdo+ki2jBw7vWea33uPUPRVGPuYU47AqLGZ5TEo=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=YRHzYnfEoI3AF0xMIiMCQ4+Z5wI5c5Wh8b9us5p+tdq3KmC7VVHYfn0C8AerczhI7U82IGtGoiL0fYQynKf7IMiAivJkPxvhOuIdGbDhpDLD0aOyN1V0QAAcoLnj2hTv73sH7jONvIO+/4qtVVH0VLSCgm2cFRpqjZDub4ghbR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=NcI8f4eA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gbA4zXaK; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 1A79FEC00E0;
	Sat,  6 Sep 2025 02:21:26 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Sat, 06 Sep 2025 02:21:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1757139686;
	 x=1757226086; bh=C/Qx8gn1aEPxWdZanYl378oDEkan1w0vCyVmbQR1Sik=; b=
	NcI8f4eA6+xfI+2FZ3v0vxGpjNfnklewK7IIeASRWtoQDVgOefMZ6ZUovqGqgbpY
	rv+cqMSYbYJ19cfSmfvC5mbWFCxobGt5njpVjEWHHODiA3sNCzT5mJvl93o7+xER
	ZV3yGZmSl49yKYjfDmJewZXCtta8BmtPC2oZobwfiE8WPfEFI0a8lRgfVPFzUUZ0
	1pgrcnhdc9qdGbORsgnMbVN9xm2omraRoh2jE5UaOMYTwt019Cp49cRuwEYRDzvE
	YnCe1OLinSxSp5v6kd8yieLO7BO91D0Xi9p3ik6/IvDB5nscZ5GOVFxqGANPcCbd
	TOlzG5o1e4bsxXtnwh+5aA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757139686; x=1757226086; bh=C
	/Qx8gn1aEPxWdZanYl378oDEkan1w0vCyVmbQR1Sik=; b=gbA4zXaK4C7Y9/vsd
	FpYF1zaJP4tTIhPgsRLgPhk5hzXehE3nNhn7xYf4BdLn29Y8quFwWguQBYJCEFu8
	EVeH91A24uHbt9THCOL+wdQdB3/O5bxnd6D8GJRZ5835sWG07pgKl0MoIeLxcOmU
	mu+bUTkQai8xnnxHrsBcSzR7vftDSuRZSRQ8jdO2SjEHw4MzBq3dmdC272eDbKra
	FCpv2h7KcKk4/MyugqVZfE7zdoxwYLHgGjr7LTlHxyTD+A0MxYgJ6tS0OtExYaBW
	QbsHjnzNoXZId/vzMMxqHhFxmLyfGXsk/acbzOIafdLv72k2BhlBzdvc1gHLmEri
	2exgA==
X-ME-Sender: <xms:5dK7aHc4ThQG4kYV4-fOOrYUFMmhoSETr_6yaHFZzEx5EDP1ALP8WA>
    <xme:5dK7aNMQs3Pv5tJWEfFPmF0Mnqu0nKkVUwKoQgcTBKAq0V9MVq4q7-N_Zbbe01ldB
    DoQcepS0_TXn-i4CX8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduuddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhguuceu
    vghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvghrnh
    epiedtfedufeejheevlefffedvkeegleelkeehuddvjefgtddtheeigfeitdegffejnecu
    ffhomhgrihhnpehshiiikhgrlhhlvghrrdgrphhpshhpohhtrdgtohhmpdhkvghrnhgvlh
    drohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedugedpmhhouggvpehsmh
    htphhouhhtpdhrtghpthhtohepshhlrghvrgesughusggvhihkohdrtghomhdprhgtphht
    thhopeihvghpvghilhhinhdrtghssehgmhgrihhlrdgtohhmpdhrtghpthhtohepshihii
    hkrghllhgvrhdqsghughhssehgohhoghhlvghgrhhouhhpshdrtghomhdprhgtphhtthho
    pegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhguvghrshdrrh
    hogigvlhhlsehlihhnrghrohdrohhrghdprhgtphhtthhopehtghhlgieslhhinhhuthhr
    ohhnihigrdguvgdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtih
    honhdrohhrghdprhgtphhtthhopehkshhtvgifrghrtheslhhinhhugihfohhunhgurght
    ihhonhdrohhrghdprhgtphhtthhopehpohhmsghrvggurghnnhgvsehnvgigsgdrtghomh
X-ME-Proxy: <xmx:5dK7aFSQAP437V0tX7uUcxgtGrgb-XsdxBbZsDD-q_Nxd8YwztNhVQ>
    <xmx:5dK7aKmLHzr7YNbIZt2Fqsl-m2CHHyGcoEAnWTR8eXUavxayDfMeZw>
    <xmx:5dK7aBRxG4BinL4kEveCMI60YtcLC6xYDqTOzUVPSlAA46G_sSajyg>
    <xmx:5dK7aJsi4l1wF_goKub4DYVFCxNAtEelK1xbO-e3qc82n9jB6JHt_Q>
    <xmx:5tK7aICrCqDKYGUvVsynEgeMmLVY_xewpS_mWdAFLm_gT8Nw1EwhFAG6>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0394C700065; Sat,  6 Sep 2025 02:21:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AxX0oEVx0u-k
Date: Sat, 06 Sep 2025 08:21:04 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: syzbot <syzbot+7ca256d0da4af073b2e2@syzkaller.appspotmail.com>,
 "Anders Roxell" <anders.roxell@linaro.org>,
 "Christian Brauner" <brauner@kernel.org>, "Yangtao Li" <frank.li@vivo.com>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 kstewart@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 "'pombredanne@nexb.com'" <pombredanne@nexb.com>,
 "Viacheslav Dubeyko" <slava@dubeyko.com>, syzkaller-bugs@googlegroups.com,
 "Thomas Gleixner" <tglx@linutronix.de>, yepeilin.cs@gmail.com
Message-Id: <66114372-5bd8-4f1b-8aea-1f6c4ec91bda@app.fastmail.com>
In-Reply-To: <68bbccf3.a70a0220.7a912.02c1.GAE@google.com>
References: <68bbccf3.a70a0220.7a912.02c1.GAE@google.com>
Subject: Re: [syzbot] [hfs?] general protection fault in hfs_find_init
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, Sep 6, 2025, at 07:56, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
>
> commit 42b0ef01e6b5e9c77b383d32c25a0ec2a735d08a
> Author: Arnd Bergmann <arnd@arndb.de>
> Date:   Fri Jul 11 08:46:51 2025 +0000
>
>     block: fix FS_IOC_GETLBMD_CAP parsing in blkdev_common_ioctl()
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17c0d312580000
> start commit:   ee88bddf7f2f Merge tag 'bpf-fixes' of git://git.kernel.org..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=28cc6f051378bb16
> dashboard link: https://syzkaller.appspot.com/bug?extid=7ca256d0da4af073b2e2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1026b182580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=159e0f0c580000

I took a look and concluded that my patch is unlikely to have
fixed the issue, because:

 - my patch was wrong and needed another fixup on top
 - the reproducer and kernel log show no reference to ioctl() calls,
   so they do not directly interact with the code I changed.

It is possible that my patch is hiding the root cause for the problem,
if part of the reproducer relies on a prior call to ioctl() on a block
device and this ioctl was broken by my patch. This still sounds like a
long shot though, and my first guess would be that the bisection
went wrong, possibly by running into more than one issue, or an
unreliable reproducer.

     Arnd

