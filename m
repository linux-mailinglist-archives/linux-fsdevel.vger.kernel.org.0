Return-Path: <linux-fsdevel+bounces-62938-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BB5BA646B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Sep 2025 00:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F85218995CE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Sep 2025 22:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0C123C506;
	Sat, 27 Sep 2025 22:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="eKyDbvq/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fj1sP+JD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CB628682;
	Sat, 27 Sep 2025 22:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759013620; cv=none; b=VrSoRTWshsBVANG/oIoX7ucNTANcArQE7FlcAPKUoei6lqgNXPMr3IVf1q9HkzYqeT8eYLSlDDF83zBA7H2/PbLC7zbzfSe0pZVMYfccV4jhaPhlgLQjLicYFemlvzTeF47/locnoRcx9lw2khMqGXosnTTF/WRKzV9qn3B5lH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759013620; c=relaxed/simple;
	bh=waBb0hPPk6mLfv0mSvcbxDflqmx7x/HwJzr4j44b6IA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rcN9gerGku7r76VfXLT8uUnuiC/wctu3R/gxa3+g6CnaOFgO13JxeWYs3WQ+WW4uH8CvsMOIjqAUjK2HvOWgo0jDUscAlJLHRNPyqbnA5ss7aMrm9XZl6v+SLOd9ycdKqzU1ajJ157WRS5c4bMr0UEtn9URHM13S026dxVIHx6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=eKyDbvq/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fj1sP+JD; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 953A81D00099;
	Sat, 27 Sep 2025 18:53:37 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Sat, 27 Sep 2025 18:53:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1759013617;
	 x=1759100017; bh=r8nlJBu4+DGKY/5R6PObJknBEO1eOAjKoGLmmZK/l90=; b=
	eKyDbvq/Eh8iaSy38AvYlWf4aOL1JcMHoMq5lQFzbZf/qVYYvwiJuSRXUw2wRkyi
	W84xxvDk7NHfE7DZlg+9RbWhBBAbvx9m+wRV2YfUavMdLu0A9IFeFXSLv+TF1krR
	QW7xfCZNiUiTZbltC0iQRuK1utU2zvflFuo7E1KSoGrSnZ57pKS5hP4tSDVieF4n
	i0vqcjPvxi/QhbwdZD9O5A7k7Mar+4XxER3w17Q9sHTBUdbwDMT/hwnZ/5eyITVA
	+QuHLcyNnrsiCOrW8BRrFOOPYSurbe9qzWPZvvGmQzjkIedVMiYZqhLQxtRydMow
	A3aFFVEY9aOfzVKVSCM+Fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759013617; x=
	1759100017; bh=r8nlJBu4+DGKY/5R6PObJknBEO1eOAjKoGLmmZK/l90=; b=F
	j1sP+JDD2LW7MH/hNDFObuIAHmvl4ktCJ9AAQMa3ZLeuGnsUe12x/HDf49NpLFFA
	htpaRVtzbHRuNFngwO8J6C2vX2NiZqvsCL+lTmcwy9jEErKo/PAaYqnxfp07fUCl
	vivDRwyOJspJ9inMbZbV/JswgJxiTuuLyuEwgJH2sRhfvANygX3Ix8zThfN2/zV3
	eO+fOgoBl58o3v/nUh0kAmQiV2GY6T28DNqhbz8bTEXYqDtd3C/6bvC+wBFCgLFK
	yn8skA2xg5yv6/SFUn4mNvvjEdME0UAcEAfSQ0HtZdn3o40dnCtKCWAPKmGzg2v6
	UMwMVXiVRDH2+Q+ARjfpg==
X-ME-Sender: <xms:72rYaOxzkHf1iBPn_ki2J2OddRSi2ii6KjXiEPLleocB1ub2u_NlzQ>
    <xme:72rYaDqvnQf9m9t4eNo7xSt3ZYBmgM2QeaIeq8ZHkPw4jJbAHxKFKpPEp3uG09Mc4
    qLRj7lsY84FsoH8J-iKxBm4Jt--fYdvGw5eeNNrUunwDbU57zWDUsI>
X-ME-Received: <xmr:72rYaI31CI8BKu4N9Vm3gp_EKrk6hqqtvzfVMmR7yPk7mbOLlzaFOdmLGPtwjkWm5a7SjmU_LPrsd8SZM6nePVaN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejfeeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepvfhinhhgmhgr
    ohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeduke
    evhfegvedvveeihedvvdeghfeglefgudegfeetvdekiefgledtheeggefhgfenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmh
    drohhrghdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepghhrohhugheskhgroh
    gurdhorhhgpdhrtghpthhtoheplhhinhhugigpohhsshestghruhguvggshihtvgdrtgho
    mhdprhgtphhtthhopegrshhmrgguvghushestghouggvfihrvggtkhdrohhrghdprhgtph
    htthhopegvrhhitghvhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhutghhohes
    ihhonhhkohhvrdhnvghtpdhrtghpthhtohepvhelfhhssehlihhsthhsrdhlihhnuhigrd
    guvghvpdhrtghpthhtohepghhnohgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthho
    pehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:72rYaEC5odOfJqOYh5CMS46GpTM6xDb9AVvtOmNS_6861b1DtbsztQ>
    <xmx:72rYaBNm-I01NRZ7X-TivQQ5r7FXtHG9_K3YPl08Zvco5qyjf6D3Ww>
    <xmx:72rYaARSft9Pt3RFDwW19UffJldfrP84_MOYoOmm6R_M_zdt2Mdogw>
    <xmx:72rYaB4mHnSpi0BBxfmydVJphgXGQj3ht06s42pDFl2BJTwV-n3H9A>
    <xmx:8WrYaBidm_w-c5MxqEUeR0C1ovUZt-MHB6emscia4wEALnuJnqC2crNk>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 27 Sep 2025 18:53:33 -0400 (EDT)
Message-ID: <dd5f424b-c6a8-4d0d-9ec0-1447fce7de39@maowtm.org>
Date: Sat, 27 Sep 2025 23:53:33 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] fs/9p: Reuse inode based on path (in addition to
 qid)
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 Greg Kurz <groug@kaod.org>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov
 <lucho@ionkov.net>, v9fs@lists.linux.dev, =?UTF-8?Q?G=C3=BCnther_Noack?=
 <gnoack@google.com>, linux-security-module@vger.kernel.org,
 Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
 Matthew Bobrowski <repnop@google.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 qemu-devel@nongnu.org
References: <aMih5XYYrpP559de@codewreck.org> <3070012.VW4agfvzBM@silver>
 <f2c94b0a-2f1e-425a-bda1-f2d141acdede@maowtm.org> <3774641.iishnSSGpB@silver>
 <20250917.Eip1ahj6neij@digikod.net>
 <f1228978-dac0-4d1a-a820-5ac9562675d0@maowtm.org>
 <20250927.ahGhiiy0koo0@digikod.net>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20250927.ahGhiiy0koo0@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/27/25 19:27, Mickaël Salaün wrote:
> Adding Greg Kurz too.
> 
> On Sun, Sep 21, 2025 at 05:24:49PM +0100, Tingmao Wang wrote:
>> On 9/17/25 16:00, Mickaël Salaün wrote:
>>> [...]
>>
>> Alternatively if we believe this to be a QEMU issue, maybe
>> Landlock don't need to work around it and should just hold fids (and use
>> QIDs to key the rules) anyway despite server quirks like these.  This can
>> perhaps then be fixed in QEMU?
> 
> Yes, I think it would make sense for Landlock to open and keep open a
> fid (and hopefully the related remote file).  However, the v9fs umount
> should be handled gracefully the same way Landlock tag inodes are
> handled.  This should come with a QEMU patch to fix the consistency
> issue.
> 
>>
>> (I guess the fact that QEMU is doing path tracking in the first place does
>> gives more precedent for justifying doing path tracking in v9fs as well,
>> but maybe that's the wrong way to think about it)
> 
> Anyway, if QEMU does it, wouldn't it be the same for Landlock to just
> rely on fid?

The fid can't be relied on because it's just a handle.  The client can
open multiple fids pointing to the same file (and in fact this is what
v9fs does - new fid for each open())

> If QEMU uses FD+O_PATH, then Landlock would work even for
> server-moved files.

(With this new approach, Landlock would have to key the rules based on
qid, but it also needs to hold an open fid to prevent that qid from being
reused (due to ext4 inode number reuse, etc))

