Return-Path: <linux-fsdevel+bounces-58055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B89B2876F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 22:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76AF77BF8F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 20:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A42123D7E3;
	Fri, 15 Aug 2025 20:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="V/60bMx4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dBLmzMgz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8DA18A6AE
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Aug 2025 20:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755291387; cv=none; b=Zu51tx6Dnz041h4rdrmUUOeQAaSQfkxmTwUMMqVEwVGKjyM6QMQEdfBDXQoygx3uB1EUOXDsLvPCC9avqKk5ir0sjZzoy/o7WC0sfckMyAcz+40ROYQ99m6RqMy6/fhPlmZAaN83VkKakuuIAyy+WUIe4YsO15A2/boF0B+78C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755291387; c=relaxed/simple;
	bh=c99e31d/0B5p4S6lPUIgxk70dOXq3deD8MWdFsc1mpU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=jTtq6SI+7rmBNo8XRE1/OruuzZhmdRo2e5vlI2uP4O5mLDk87llpqWsrRo8FiCCSOshHN5cfQooBHk3wZ1eAtNPDsjd5vmtqSziYUgv4e+jmu7+AtNRvaBBMEKPSzf85HjCw1pUkHQIWJql21gkqlziL7sqcmvQtPBVCxhuGTDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=V/60bMx4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dBLmzMgz; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 344517A0126;
	Fri, 15 Aug 2025 16:56:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 15 Aug 2025 16:56:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1755291383;
	 x=1755377783; bh=gcSDpqwp0lP+vAcpZPjDg+OyRWGWljQNMInNczKc0Kk=; b=
	V/60bMx4tZ1ATgVwWbqUVVsxnpZrQnVf2osJ0CiwHpnUgtbw277FWBsNBdh38tp1
	XQ1MM2IODiuDkUn7VKDea1hyrH5LQJVeOTrPF+5GBcsjruoUnudRbdDv3WQCHsik
	5X/d7lkyALwRjqfrK2gSYd9k/mEu/0hLadwLtBlV5A44F6kbcXroelfspU+uhCZO
	+6XQkjMFf16XoNKkEJ2koHS9IqcUSxv/NJruh7+9HkNWUPymc5YMDCiRrOljRpYg
	vc6uMPxAvBlLctmSXGBFIpDr8WJSPkDAm1ic7HDPi0KeA+M6ADOU6ETAKw3yNh7n
	jGHRfZymHJa0bN/oHpkKcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755291383; x=
	1755377783; bh=gcSDpqwp0lP+vAcpZPjDg+OyRWGWljQNMInNczKc0Kk=; b=d
	BLmzMgzauBAIIkQ43Xqlu/D51VkfVxFgSzohxP5gRwTYpJUer7F2Cuj55LjoXigG
	Lcs3ECr6MTIFebsZeaEYTFnA17gltI92XfwOBTKkuyjLHgi63Fh28ZY2o6olQJuR
	pgfYRoaBqAmDbJsBO/LSZNoUVkYQaqqiyVxVbc92s/Dr6462uSJLi/IyyHG/JlYd
	CelO8SoKepqZZhLiXmga/VumrYafCANLoYtCdQ7BVkko/qSwwg93VoilOOXrA/iG
	+0beJuZZQsBZE/EeoW4LKG03OwfRr1jn0p4LAnRdU/JxiaxHDNfL96trB8CtvtpZ
	xAIf3fLD3/0SRhT8eD3Cw==
X-ME-Sender: <xms:9p6faG_tAEo0YbSVBMd9BTAnkU5RSjjr9hnFDmE7OWh5rSp6-om4XA>
    <xme:9p6faG7IU7CIEg8jSDGrMpuyr1B0SK8lNT5Y1u0EKMwpoAzkz2026AYM8PhWesBXh
    vD5a74ndnY-3n2D>
X-ME-Received: <xmr:9p6faN1zAav3Cg3YjWQS0tfxSuYxCx-13-eBuPCu8yKL3tH5l7IhEf0bYSmeHUzC_g6ML-IYw-Q5bI2iIrWh8GfX-cig-NIGzguxHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeegleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefufggjfhfkgggtgfesthhqmh
    dttderjeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugessghs
    sggvrhhnugdrtghomheqnecuggftrfgrthhtvghrnhepvedvffehgfdvudegffeiuefgie
    eutdelgefghfdtjeeukefftdfhgfffkedttdetnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugessghssggvrhhnugdrtghomhdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggthhhg
    vddttddtsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlh
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:9p6faNBgOX2zzsWi40z9NwNCgUNts-FmT_MP8fHC8wH-vpNlpy7uaQ>
    <xmx:9p6faP0DwRuEi409ZYGTgQsgbIadPj3kG-98f_5lerAeMbleWjQRcQ>
    <xmx:9p6faHuzlCly7uAopYLfo1Vn3oApAJGJHAgbCOqUGQ-65M9fVlmTWA>
    <xmx:9p6faP7kxh5GwHbBRZ3ar1_DR_CQOlqfVgcshKl39zW2STCTiwuk_g>
    <xmx:956faIB3U-i1qb3SARhgivqaMHf9JmZ9Xfb8R5wO7cN3IJ-YETAGNQJL>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Aug 2025 16:56:22 -0400 (EDT)
Date: Fri, 15 Aug 2025 22:56:17 +0200
From: Bernd Schubert <bernd@bsbernd.com>
To: Gang He <dchg2000@gmail.com>
CC: linux-fsdevel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_Fuse_over_io=5Furing_mode_cannot_handle_io?=
 =?US-ASCII?Q?depth_=3E_1_case_properly_like_the_default_mode?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAGmFzScM+UFXCuw5F3B3rZ8iFFyZxwSwBHJD6XwPnHVtqr5JMg@mail.gmail.com>
References: <CAGmFzScM+UFXCuw5F3B3rZ8iFFyZxwSwBHJD6XwPnHVtqr5JMg@mail.gmail.com>
Message-ID: <E1CDDCDF-0461-4522-985E-07EF212FE927@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On August 15, 2025 9:45:34 AM GMT+02:00, Gang He <dchg2000@gmail=2Ecom> wro=
te:
>Hi Bernd,
>
>Sorry for interruption=2E
>I tested your fuse over io_uring patch set with libfuse null example,
>the fuse over io_uring mode has better performance than the default
>mode=2E e=2Eg=2E, the fio command is as below,
>fio -direct=3D1 --filename=3D/mnt/singfile --rw=3Dread  -iodepth=3D1
>--ioengine=3Dlibaio --bs=3D4k --size=3D4G --runtime=3D60 --numjobs=3D1
>-name=3Dtest_fuse1
>
>But, if I increased fio iodepth option, the fuse over io_uring mode
>has worse performance than the default mode=2E e=2Eg=2E, the fio command =
is
>as below,
>fio -direct=3D1 --filename=3D/mnt/singfile --rw=3Dread  -iodepth=3D4
>--ioengine=3Dlibaio --bs=3D4k --size=3D4G --runtime=3D60 --numjobs=3D1
>-name=3Dtest_fuse2
>
>The test result showed the fuse over io_uring mode cannot handle this
>case properly=2E could you take a look at this issue? or this is design
>issue?
>
>I went through the related source code, I do not understand each
>fuse_ring_queue thread has only one  available ring entry? this design
>will cause the above issue?
>the related code is as follows,
>dev_uring=2Ec
>1099
>1100     queue =3D ring->queues[qid];
>1101     if (!queue) {
>1102         queue =3D fuse_uring_create_queue(ring, qid);
>1103         if (!queue)
>1104             return err;
>1105     }
>1106
>1107     /*
>1108      * The created queue above does not need to be destructed in
>1109      * case of entry errors below, will be done at ring destruction =
time=2E
>1110      */
>1111
>1112     ent =3D fuse_uring_create_ring_ent(cmd, queue);
>1113     if (IS_ERR(ent))
>1114         return PTR_ERR(ent);
>1115
>1116     fuse_uring_do_register(ent, cmd, issue_flags);
>1117
>1118     return 0;
>1119 }
>
>
>Thanks
>Gang


Hi Gang,

we are just slowly traveling back with my family from Germany to France - =
sorry for delayed responses=2E

Each queue can have up to N ring entries - I think I put in max 65535=2E

The code you are looking at will just add new entries to per queue lists=
=2E

I don't know why higher fio io-depth results in lower performance=2E A pos=
sible reason is that /dev/fuse request get distributed to multiple threads,=
 while fuse-io-uring might all go the same thread/ring=2E I had posted patc=
hes recently that add request  balancing between queues=2E=20

Cheers,
Bernd



Cheers,
Bernd

