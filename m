Return-Path: <linux-fsdevel+bounces-41275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A29A2D1D6
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2025 01:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11FEA3AA445
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2025 00:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341E72CA6;
	Sat,  8 Feb 2025 00:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="YHRtdASt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uHGtx/8Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D41383;
	Sat,  8 Feb 2025 00:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738972967; cv=none; b=JJFnFOI26okCRy4XfJBXUQkxZhavxPW4uBfBdD9AVrGqdZ4feVOwsduMhxlZ2CTtGCPFVMZb10s6WGwzCIcxmcXVCyXbcRQUgxpoVN7DgK4pfEq0ZpFUGrMOfumiB8WqRhqHK0VJy0L6hxXBzHJ/JmneaO9x9mu8Ngw4qhJ1MTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738972967; c=relaxed/simple;
	bh=TSP1JMmVi42tAOtGzn3k9oCoW5xLhTjyWksZSavSW7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i6lzNbKm5x7VAD8wBZ2rkLMICdZlFSEw0aBuG1PfVdAF0Gt0bmnRk9a6BSKhlFhS/q1p7WxHrGCIIFuR3Qe5KNK0IVCPVbCBO+wqujZHmYGu3hajNPXpw00g2VbXZQKm3JOQliS7SECNHsBVJ8tDUliX5UyLl4hRs+E0/J73nR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=YHRtdASt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uHGtx/8Y; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 688F1254010E;
	Fri,  7 Feb 2025 19:02:42 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 07 Feb 2025 19:02:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1738972962;
	 x=1739059362; bh=mrWw7gmE3NDMuFQEpyImkKuDcSno+4GUyYuDqXBEHeo=; b=
	YHRtdAStvjmtGKokAa6Y2Zrfunbbxso7mlsWZdg5xGhTf/Hrs4t0+/aUd9jRggtM
	GrsmQhmihu7FTyCsUMoTrSxMDbSTUQD+pAbzq/uOU8SCaMLlyrePd7pziEoDdHJo
	A0mnezmOriDfzpD3HYU2GBr0h7mXgZkGr7rjCiVsNnMBVCF32jwEYBnzbLdULhb5
	/Rx/SLZT6mayGuB3JPSOA0Z+lJrffsu/otn7p9epqj8p8+UjYCH4tst9ttRh4j0C
	6g+5Yi16nUyPpzE2eTQnyo4XzEz3LjgTL7Z57CiQE+kA3Ngs051ByBirO62hNkzx
	bt/xzDZ0MRk6b7gx5ZgrWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738972962; x=
	1739059362; bh=mrWw7gmE3NDMuFQEpyImkKuDcSno+4GUyYuDqXBEHeo=; b=u
	HGtx/8YNzTm+lTQATs3ZEB/btMMaans8yIFigcc/Wgh5FbOPWTQopMeOIpmR8FLi
	kOjqr6XcKhCdCPV4FlQcYBUPaCRRVfr3hCWUxXStV+OOcbsUftvklRPPCZY+EaGO
	bSMxGBd1Ida58KYdysm0w9mCaWWEPyiAx0WYqA9h2i55Lq5SSVcrTJAFBLl/yWuY
	jFe19sknFBsxzkzwwdgvlV0DGTTYulSVagk5Mh6/ZeV/eIuHDVW9oxMRuOdRomRk
	VISOqjAxUSIFm6LnapII/NADXDXrn0AGLvKkt9cEI1nmsVL/tMeHLuRZyG03PEIn
	cj5tw24PKtClVsjOk043Q==
X-ME-Sender: <xms:IJ-mZxSC1TKDZEeOOlX0QW683tcGOf_6bHb_NBnLj6piHlDtfEYNow>
    <xme:IJ-mZ6x2LAK606cQW2AoTstDH1aGL8honM13VHSHKTICIV0lKZjuPprpdQ5kENWrp
    0sHID1Li3vV__jZ>
X-ME-Received: <xmr:IJ-mZ21nfWXQiiTZ88T15QFKZeC0gzpmXf5qy_g6TiNNT7hvA7od1qS_ytu9sAqmLOane_Yh__9rKGNWR8V8OdMwmVjSeacg4QZvPgTR13Tfdf5LVxVf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdeijecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddv
    jeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugessghssggvrh
    hnugdrtghomheqnecuggftrfgrthhtvghrnhepjeffuddtgefhfffggfejheetjeeukeei
    teeiheevheetueeigfeiueelkeejkeeunecuffhomhgrihhnpehgihhthhhusgdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghr
    nhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmh
    htphhouhhtpdhrtghpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepvhgsrggskhgrsehsuhhsvgdrtgiipdhrtghpthhtohepmhhikhhloh
    hssehsiigvrhgvughirdhhuhdprhgtphhtthhopeifihhllhihsehinhhfrhgruggvrggu
    rdhorhhgpdhrtghpthhtoheptghhrhhishhtihgrnheshhgvuhhsvghlrdgvuhdprhgtph
    htthhopehjohhsvghfsehtohigihgtphgrnhgurgdrtghomhdprhgtphhtthhopehmshii
    vghrvgguihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprhgvghhrvghsshhiohhnsh
    eslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgv
    lhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:IZ-mZ5BjsAQquoPRdCCIk9aFAJn_Kk7MSjUZZawKqQaPr_MF0xs1_w>
    <xmx:IZ-mZ6iIkV1ZhC5dtnv_RbKcTcMqdI__c3w2hsXbxoSzO-8l15Uihg>
    <xmx:IZ-mZ9q7hMMR1uHMmZdyR5jquTTgWWiSzatvNE0DVOHzcJ4bZmz0wg>
    <xmx:IZ-mZ1hp3yuqJmcPghYQOezpPpVrgPEAd22-Pbb9Iod755E2MEJb_w>
    <xmx:Ip-mZ7ZvGEVKrIRz2zwUDDXwnxXMfycBuSTmpA19O1NcILkjs1VrADvo>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Feb 2025 19:02:39 -0500 (EST)
Message-ID: <b828162e-716a-4ccd-95bb-d51e31cea538@bsbernd.com>
Date: Sat, 8 Feb 2025 01:02:38 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][BISECTED] Crash with Bad page state for FUSE/Flatpak
 related applications since v6.13
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>,
 Matthew Wilcox <willy@infradead.org>, Christian Heusel
 <christian@heusel.eu>, Josef Bacik <josef@toxicpanda.com>,
 Miklos Szeredi <mszeredi@redhat.com>, regressions@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm <linux-mm@kvack.org>, =?UTF-8?Q?Mantas_Mikul=C4=97nas?=
 <grawity@gmail.com>
References: <2f681f48-00f5-4e09-8431-2b3dbfaa881e@heusel.eu>
 <CAJfpegtaTET+R7Tc1MozTQWmYfgsRp6Bzc=HKonO=Uq1h6Nzgw@mail.gmail.com>
 <Z6XWVU6ZTCIl3jnc@casper.infradead.org>
 <03eb13ad-03a2-4982-9545-0a5506e043d0@suse.cz>
 <CAJfpegtvy0N8dNK-jY1W-LX=TyGQxQTxHkgNJjFbWADUmzb6xA@mail.gmail.com>
 <f8b08ef9-5bba-490c-9d99-9ab955e68732@suse.cz>
 <94df7323-4ded-416a-b850-41e7ba034fdc@bsbernd.com>
 <CAJnrk1atv4N-BDWnwmESvczJhkayXyQqnLEypkmuJNKBa6gq8A@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJnrk1atv4N-BDWnwmESvczJhkayXyQqnLEypkmuJNKBa6gq8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/7/25 19:40, Joanne Koong wrote:
> On Fri, Feb 7, 2025 at 3:16 AM Bernd Schubert <bernd@bsbernd.com> wrote:
>>
>>
>>
>> On 2/7/25 11:55, Vlastimil Babka wrote:
>>> On 2/7/25 11:43, Miklos Szeredi wrote:
>>>> On Fri, 7 Feb 2025 at 11:25, Vlastimil Babka <vbabka@suse.cz> wrote:
>>>>
>>>>> Could be a use-after free of the page, which sets PG_lru again. The list
>>>>> corruptions in __rmqueue_pcplist also suggest some page manipulation after
>>>>> free. The -1 refcount suggests somebody was using the page while it was
>>>>> freed due to refcount dropping to 0 and then did a put_page()?
>>>>
>>>> Can you suggest any debug options that could help pinpoint the offender?
>>>
>>> CONFIG_DEBUG_VM enables a check in put_page_testzero() that would catch the
>>> underflow (modulo a tiny race window where it wouldn't). Worth trying.
>>
>> I typically run all of my tests with these options enabled
>>
>> https://github.com/bsbernd/tiny-qemu-virtio-kernel-config
>>
>>
>> If Christian or Mantas could tell me what I need to install and run, I
>> could probably quickly give it a try.
>>
> 
> Copying/pasting from [1], these are the repro steps that's listed:
> 
> 1) Install Bottles: flatpak install flathub com.usebottles.bottles
> 2) Open Bottles and create a bottle
> 3) In a terminal open the kernel log using dmesg/journalctl in follow mode
> 4) Once the bottle has been initialized, open it, select "Run
> Executable" and point it at any Windows executable
> Note that at that same moment a BUG: Bad page state in process fuse
> mainloop error message will appear and the system will become
> unresponsive (keyboard and mouse might still work but you'll be unable
> to actually do anything, open or close any application, or even reboot
> or shutdown; you are able to ping the device and initiate an SSH
> connection but all it does is just display the banner)
> 

Thanks Joanne! Hmm, I found "wmplayer" in a c drive, but there doesn't
happen much

   5241 pts/0    Ss     0:00 -bash
   5317 pts/1    S+     0:00 /home/bernd/.var/app/com.usebottles.bottles/data/bottles/runners/soda-9.0-1/bin/wi
   5319 ?        Ss     0:01 /home/bernd/.var/app/com.usebottles.bottles/data/bottles/runners/soda-9.0-1/bin/wi
   5321 pts/1    S+     0:01 C:\windows\system32\wineboot.exe --init
   5345 ?        Ssl    0:01 C:\windows\system32\services.exe
   5348 ?        Ssl    0:00 C:\windows\system32\winedevice.exe
   5359 ?        Ssl    0:01 C:\windows\system32\winedevice.exe
   5360 ?        I      0:00 [kworker/u130:0-rpciod]

It runs it, but no system issue. I had also tried "Obfuscate", but didn't
manage to feed it a file - it runs in the sandbox and no access to
my $HOME.

I need to see is if I can find some other files, but very late here
and busy with something else. It also runs in x2gokdrive and wine
then over another ssh hope to the vm guest, which has a kernel with all
these debug options - slow.

Bernd






