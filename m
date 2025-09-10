Return-Path: <linux-fsdevel+bounces-60749-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF23AB51268
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 11:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCBBA1B28080
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 09:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6481E3128CC;
	Wed, 10 Sep 2025 09:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="IN/tcU6S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RAvTtUwD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAF02D660E
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Sep 2025 09:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757496273; cv=none; b=EJNMMsPJYAQBn4zj17OkoHDG4JqmHmHoUhi/Q2iAzdC0g+y3AJftbuzT/h6jnv9uH14hFvKL1xe03ZnLiO7uja76onB4wtwk38hWmBCLsWYYAKx3mrMPKtrFbqFBp9n4+PaG+1XICZDjr0X/cw9nqtze0oyQMkyLsvqm3gHPXWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757496273; c=relaxed/simple;
	bh=4CcesortZweIgSBMarZ0Yat4OehimeCO7XkQ8WP2Ay0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sibhXSygqTObfvX/0Lb/RVdAMJl9y/3fZOAZE7Vb8P1prCiOGsqbzlwIWgcJ6vp3Q0KJfaHakzW3pc9VeDoWek7tc3UFUiOK8Lh2wg4BBLKaWA7jflKg2HEsdqX7KNowkb/+kiXQ91Hk1RV1sWH/Q0e6UW0cHOVXZe6TejMoYSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=IN/tcU6S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RAvTtUwD; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 5FAD51D000B3;
	Wed, 10 Sep 2025 05:24:29 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 10 Sep 2025 05:24:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1757496269;
	 x=1757582669; bh=gAfT26VRYkj84Bn5nizXgc7h8UdsZ8EiorAtGygTFG4=; b=
	IN/tcU6SZHX8mluzDdWvKuE0Y3UixnNV5NGJsuh3hPJlbQf6A1/AaufWxdpYXJF9
	9WQ4bRXfbLNEbaAUTXknw5vgSfhrl0FWYEj/+33ZOCqyGRSB1D5HRReIYcNqzyXC
	GZDP4yPhwn55jhqvWZ5ZZeJp2h33tZvj2hc2WYYbI6vL+5SBlOfGOpbTyidoLa9R
	y23m6STddbm0+fa5T+4nbR9uq3c7n3mCt3NRY4ENECBpwOduPfeeQgtml7NQ71CJ
	KIf5mHKg+/OWrTZaGvpQP0qiH4SdspbaMsWTS0sRuOMCM+7WknmCpso+UhmW7G7a
	GdOCJSiiGJiO2bX9XulUJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757496269; x=1757582669; bh=g
	AfT26VRYkj84Bn5nizXgc7h8UdsZ8EiorAtGygTFG4=; b=RAvTtUwDNze5mOQQo
	CaL8/gzeOjTANW8IFMkgdl0bFNfHagKX8DFNfCyHuEq06ODiYlZl3C56ZnLQSjN7
	EUH5jr8OqobP1nKDgYbdwPp6oWcF2qhSttlh9/DF6CfF/rImvpdRPFY1fum+0moI
	YthOJC5GyWvpy3Ya1wXTmNai//Rr7uN9k9tyog3zoqsWI1VhcoSEA1p8BRTwal2i
	KG1JOnQnzgs8lmSaZ/lRpfmfcI/dLKUxqhXLAvgWs8PSaG28XNb5T+UHW2CpudDy
	8p13eLYo2aTfRx77Rf3jNJUeIy6Yky6KoPOkuZLIMmbKSpzyNWtWLJ0N2t1VBTGe
	2TYQw==
X-ME-Sender: <xms:zUPBaPdhLnwEoWrYOsYNBkQEzgX1xc_6tenp56ugPRKU_uJV0-KiAw>
    <xme:zUPBaFaWwEFOMv7sHdmhrSOFAZvoVe2yLP-hplb_Hkb1xM0msgLJ2AAjt8yzuKzGj
    YjvnLSSYiTcG6cH>
X-ME-Received: <xmr:zUPBaKWPM1nASEZHdUKfCX-jvYOJlVDEH5FTYXKLW0OKbA-qIaIBLX7b3lz6YGO0f7Drhck6gDpbZQuGchWIfSHKMIe7bgAtLzNTbafozM5y_i7cVT2O>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfhfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhguucfu
    tghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrghtth
    gvrhhnpeettdeuvdffvdelfeetieeugfelveejleegfeehffdtuddtieelvdeuvddtkeej
    geenucffohhmrghinhepnhgrrhhkihhvvgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgusegsshgsvghrnhgurdgtohhm
    pdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehstg
    hothhtrdgsrghuvghrshhfvghlugesuggrthgrsghrihgtkhhsrdgtohhmpdhrtghpthht
    oheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:zUPBaPjk5LmJgkkJW8YtW1tGfMyd3KR79DT0mc82Jmy19TzKGsNNIA>
    <xmx:zUPBaAU5ZI6aMWJBudMCXlkPpLh1uHMQc8TTw5Vy_QhcE55-Fthh-A>
    <xmx:zUPBaON3F254pRU21pLT0FDOzqUSgA5XLnl2e_UeK0O0gQ8DL__sNg>
    <xmx:zUPBaEb1yQbBb93apc2ymDHD8X37Zjs8qgfgqgPhLrKX8Kmn1Zn0ZA>
    <xmx:zUPBaBYCxVckBUp8dVCqRDsKncLYiW-frEYqaHdoUfUeIiY_uWk0unwe>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Sep 2025 05:24:28 -0400 (EDT)
Message-ID: <76548fc4-03b7-4be6-bdd9-66b825037d7f@bsbernd.com>
Date: Wed, 10 Sep 2025 11:24:27 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FUSE + Linux filesystem capabilities (2025)
To: Scott Bauersfeld <scott.bauersfeld@databricks.com>,
 linux-fsdevel@vger.kernel.org
References: <CAP9L_6Qxicq=hMy1B2gCGppyGtoXLQveY=xkxkknv2syS1dCQg@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAP9L_6Qxicq=hMy1B2gCGppyGtoXLQveY=xkxkknv2syS1dCQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/10/25 00:59, Scott Bauersfeld wrote:
> Hi all,
> 
> We are running into performance bottlenecks in our FUSE system due to
> the fact that we get GetXAttr lookups for "security.capabilities" for
> every individual write. Even when writeback caching is enabled, the
> kernel still sends FUSE this GetXAttr request for every individual
> write.
> 
> I found this thread from 2009 that discussed the exact same issue:
> https://fuse-devel.narkive.com/ZkJ00Lfr/fuse-linux-filesystem-capabilities
> 
> It seems that the only options are the time were either:
> 1. Return ENOSYS to disable all extended attributes for the filesystem
> 2. Disable CONFIG_SECURITY_FILE_CAPABILITIES (which no longer seems to
> be an option?)
> 
> We can't make use of ENOSYS because we do actually need to support
> some other extended attributes.
> 
> Questions:
> 1. Does anyone know if there is more recent discussion or any other
> way to prevent these GetXAttr calls for every write?
> 2. Would we still see these GetXAttr calls even if we used the new
> "passthrough" fuse option?
> 
> I guess one option is to submit a patch to the fuse kernel that allows
> filesystems to specify that they do not support this security feature,
> so the fuse kernel can always short circuit security.capability
> lookups. Does this sound like a reasonable change?
> 
> I also asked in the fuse-devel mailing list but was advised to ask here as well.


Try this in your fuse server  implementation, in the ->init() function

    /*
     * needs to handle additional flags:
     *      FUSE_OPEN_KILL_SUIDGID
     *      FATTR_KILL_SUIDGID
     *      FUSE_WRITE_KILL_SUIDGID
     * (See documentation of FUSE_CAP_HANDLE_KILLPRIV_V2 in libfuse)
     */
    fuse_set_feature_flag(connp, FUSE_CAP_HANDLE_KILLPRIV);
    fuse_set_feature_flag(connp, FUSE_CAP_HANDLE_KILLPRIV_V2);


Thanks,
Bernd

