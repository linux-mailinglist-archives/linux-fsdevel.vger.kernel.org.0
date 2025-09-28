Return-Path: <linux-fsdevel+bounces-62941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A31BA68E9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Sep 2025 08:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38F33189B992
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Sep 2025 06:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C610A29AAF8;
	Sun, 28 Sep 2025 06:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="VVbofX38";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t+eLY94B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC2517C91;
	Sun, 28 Sep 2025 06:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759040900; cv=none; b=blhHSDVFrx6bNxZDJaSvVlFm+TK7dOCrUQ4bN9QiPVY9cOqsQiS47fbB/ruU2WVmi+3v76Sin7rVl4sc1PMtJ77/TcewXw7JWVv+LpPZ6OvVQBnSnljSqvq2KWTXk8kzICFzS5N4KuA2mOTELFFnXiCyOqSoYI/8xVDy7Q23cKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759040900; c=relaxed/simple;
	bh=1jJ3UXkiTBHpAr35CJEpoeHW6DBsHpYvEI2k/LsxPJU=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=e9a5zHAxvHMC3Ak2CLXsGf56m78aWYL4I9D47ZymNC0NaiQABg/SLPWEUex3AaBciSEEk+qFfWosYaGzexfXzNVrqtVLX2mrg5M2BeyOgLPN7sZUtiA+zBoxzZTDy8H2oD0F6NOL6LKWXYvrkyXBLYPly/1Ru1nJE8FVKqf4Mfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=VVbofX38; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t+eLY94B; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E0F717A0059;
	Sun, 28 Sep 2025 02:28:16 -0400 (EDT)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-04.internal (MEProxy); Sun, 28 Sep 2025 02:28:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm2; t=1759040896; x=1759127296; bh=1lQLfvGFx0mhGzUYolHoy
	9+SW3FRLX6ooITsXVY1bxc=; b=VVbofX38vysnpD64UixBYgxBfA4Dub3eqTx4V
	WyW4Nuyu5hqEK4x9cNq8+ZAEliUnX1z7t9BBH82Je28yDSePjHp6bXNd0Ts5h600
	0OkbptN1E/YefLQGlwHg1kM2gLkZ6vsMYYQzC4DcuKeg7F/yOJIVpguCxAUOS8MD
	qJOc0hxjNO8dxPnBn0OOpwfNkPYTdotOf4809i7fB/c4nl40Pyt368v8ehV+XCIs
	6OlHxa9lTeJH0siR2ZrbFhjaomuHxJ8ThYJnAlfMM1Gu9X942tPDsqqngyXrsWGp
	aA+KA4sdLkRLc6pKPcD6aAxGnyqnnjXPERqmIsynWjeA3/9/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1759040896; x=1759127296; bh=1
	lQLfvGFx0mhGzUYolHoy9+SW3FRLX6ooITsXVY1bxc=; b=t+eLY94BF5vx3I46t
	nwVmFKtFxLjlIxmmk7QjX3uYUZUhwP+kt0Lztk74HOrAOuEqDmL6Jn5/u2wBc19E
	2NX0Ec10KuzLMGeweBoGmKzA15hdoHqXXU5lzzWxKToN1wft274BlSGVzMBXoTDz
	nWAQRyn/JkKodgve1JkqTHNSPSZ+UBKOmCbGypB+/ukGIHE+l00paloH1b8Zno8l
	0GAIa9QZ89BsIatmVwru3CzBuzFR7s2u5r/i7CymN9TddfFIdDEj/SgwXGjmpVBb
	vjdqmxWu7317YAsVehoSm1HfUBoVBkyJalwioObkQ4oDH8UqZyhRQJFG4UnFsGSK
	UzMJA==
X-ME-Sender: <xms:gNXYaNU-R3JfPdIP09xKhmDSFR1ggy_986R2ji1gNZ8TPnNmX_spDA>
    <xme:gNXYaIbysyjksuyOndLGk978X6nEW0V4wl4a9D707R8WjSiPy0kCSP2b87cE88qig
    kH-TxGjo69f5kJuQkvr9cohlJTwynmbn-3VwgeQ13CZTg-B4OBqKsw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejgeegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhrhhishcu
    ofhurhhphhihfdcuoehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpedvtdfgjeffteeiiefhvdduleeggffhgfegieefffdtieeggfek
    teegkeeifeejieenucffohhmrghinheprhgvughhrghtrdgtohhmnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhishhtshestgholhhorhhr
    vghmvgguihgvshdrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:gNXYaPKGmbiIUnu3ewhVBPRcD0JicXTyl3GDjNxCL95vnxm4HYMedQ>
    <xmx:gNXYaHfMS2kb8l84d0WCMPtmk1R1mv3XJsPd987I9GtGoVaDY_jTAw>
    <xmx:gNXYaG2rQXoOCDb_FG2wi6ZBnBAcWPOstILhgzkigkOqODOQlEGw6w>
    <xmx:gNXYaAjjR05O_8kQMsEj21-cPC3Y4saONRgR3pNTR8n84uotKcRo1g>
    <xmx:gNXYaNaf0AJgaVEtCxh5z5KJ7eKz-yTE9KgAn-mjpg6WfAWLd-_NnGpU>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 751C018C0067; Sun, 28 Sep 2025 02:28:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AlRs-DKaMj37
Date: Sun, 28 Sep 2025 02:27:46 -0400
From: "Chris Murphy" <lists@colorremedies.com>
To: "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>,
 "Linux Devel" <linux-fsdevel@vger.kernel.org>
Message-Id: <00c4be20-09c8-417e-bbae-e966200d87b9@app.fastmail.com>
In-Reply-To: <cd1ab2d8-35af-4707-8eee-ced3141d1126@app.fastmail.com>
References: <cd1ab2d8-35af-4707-8eee-ced3141d1126@app.fastmail.com>
Subject: Re: [BUG] 6.17.0, mount: /mnt/0: fsconfig() failed: File exists.
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Sun, Sep 28, 2025, at 1:53 AM, Chris Murphy wrote:


> Downstream bug includes full dmesg attached:
> https://bugzilla.redhat.com/show_bug.cgi?id=2399959

OK so this is a case of two devices with the same fsid. I simply forgot I had plugged in the original device planning to wipe it - its replacement is a new fs using metadata_uuid, with the original fsid.

But the two identical fsid's is the source of all this confusion, both user and I think the kernel is also confused.

I've added more details to the downstream bug report, including strace. 



-- 
Chris Murphy

