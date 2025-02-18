Return-Path: <linux-fsdevel+bounces-41991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E95AEA39C4E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 13:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C17053B5164
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 12:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489912475D0;
	Tue, 18 Feb 2025 12:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="k4Ivd2Io";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tdRnouMm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1FC244E85;
	Tue, 18 Feb 2025 12:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739881989; cv=none; b=f4TLsCsv7owz2Hn1t5op1RwjGAj1buaFEYwu1aF2RhLXIn74az6jXCya4TcI/ka3/J6LNZUzqWXZV21v89aPCnL9XGHEXl4qJUtxo6+bvH3wPWSyfdoWrDzHO20x7872VQCRfqae1Lx2WOoxkhBo1p6PvqKt8ppxFGZGePNLvZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739881989; c=relaxed/simple;
	bh=0Lvv7rtjOdQIk9QQKm3hZYHB/EymOiAhSR+n77bEeKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lg22o78QH1+whxfxsU1swWvw41sXCTD9qU2ENd2ol5Xsmxqnvcx/UpH4EpihPXEED5VcrNIfjkWW+fisc8EIDRx4bf2gAFQb3ItaTIqDLVgBe4EMN3x/ttdQwGvqwGkKQdw51zoHqhi4baF6owov8uHl99xY6hX/qlCWtU2szWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=k4Ivd2Io; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tdRnouMm; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 26FAA1380A30;
	Tue, 18 Feb 2025 07:33:06 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 18 Feb 2025 07:33:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1739881986; x=
	1739968386; bh=28yRX83oWy8XKbFVALI7tpeopwOBxQY89HUmWnOuufI=; b=k
	4Ivd2Io2ISFOMlEcM6QW8uX1W04uRBe6cyikRg1yUumcQzqIQKxDFZuDM3S3ENt9
	QrxMJ4urvbq/3dsGzV1M7Gs4+55sp5a3EF2vXEV+iAkdqUa6FW6YtJfD1MSIlzi6
	zP/Gb58aU4fH93xuvJaZVMhba+bKggoMRDNJkCqGmvTWS2DYjFjO8zuFL+9BFhGd
	bfGr6vtVvZhcodPIiRh9rimPbA2/9zYratr+2J9QnaFkEFNNNtBsvJPnkZUM65wb
	11HYRfy0jexD/n2Ts+kF1Wj9gsXfp8fw5jL+PVD3aP7APvxNdQYOlCIr4BP3YJSB
	todkdMyoMGZ5uxw4vKKhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739881986; x=1739968386; bh=28yRX83oWy8XKbFVALI7tpeopwOBxQY89HU
	mWnOuufI=; b=tdRnouMmvB00wKWqqjIfD9DuQjO1oPw2Euvos6aajrdecbNZCks
	ZiEstQOTbaeD2ts7kF7fGpXNmaIPGPCW5muIZac3Nn068IQdam4FUYyE/KPaDY4j
	DgXoEMiDTadTsfVe7+6LzZ9M265Ep4YzjcrTAU6XGDUT7zSW+xsf2VdHZ2Hb66Xm
	SYxvvlEeVeG6OpZ9/+ru3x0HC2ICXaSCfh8P05OBWcpc0Y2hNT41aC86UFF3oGLy
	6d07wHJTJ0JkVWaNgWEjeTJZXwOdH0r7EXLF+162ZXsopY1rsX9dQQrL+hSXaFzD
	l5Oa4eL1BnJ8hkpqG8pG4BD0jGsGY7mwjyw==
X-ME-Sender: <xms:AX60Z8zE8KDmzrnCl3nk1830oGBrYLwQcLVt8VBVrT8QfTifn8FRIQ>
    <xme:AX60ZwQvWXPjSiMwJ-KBYHDIONj6M1gfO7hWaWmVyar_K6IM5qstWCkg5xQZxUR48
    Khj2reA5mm584D8V5Y>
X-ME-Received: <xmr:AX60Z-X0RgTueMH-lLTArY6O9tRixe0R1vRnLPG8ky2FuFVmsCece7o0hh12Cf3qQJPgXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiudefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepfdfmihhrihhllhcutedrucfu
    hhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvqeenucggtf
    frrghtthgvrhhnpeffvdevueetudfhhfffveelhfetfeevveekleevjeduudevvdduvdel
    teduvefhkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgdpnhgspghrtghpthhtohepjedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhgvfhhflhgvgihusehlihhnuhigrd
    grlhhisggrsggrrdgtohhmpdhrtghpthhtoheprgigsghovgeskhgvrhhnvghlrdgukhdp
    rhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqmhhmsehkvhgrtghkrdhorhhgpdhrtghpthhtohep
    sghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrh
    hnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvhhirhhoseiivghn
    ihhvrdhlihhnuhigrdhorhhgrdhukh
X-ME-Proxy: <xmx:AX60Z6hvOzDvTKjjo4hu8MTnw7ZCG6U2AF5ALuu6UxBYPDkvIJjtHg>
    <xmx:AX60Z-A-w8qSRRQl11N-UZGsf_1qY0K4-0xWw1Y0halL9_ieu0K68A>
    <xmx:AX60Z7KhBXcyKYN_r-p7NaTYx2XE2dHyg8FEhl0dAVNtDZpLrk2GCg>
    <xmx:AX60Z1BWYZvQDOoJdB0v9rlbOZYkvxxnf-_EBXk19-5wprydt9hhhQ>
    <xmx:An60Z0CCPLyLLkg6_RC_81gZx8NtsUt_qYQk3IvyS9GpFHYhx5gDvWPf>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 07:33:02 -0500 (EST)
Date: Tue, 18 Feb 2025 14:32:58 +0200
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: axboe@kernel.dk, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	brauner@kernel.org, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH 2/2] mm/truncate: don't skip dirty page in
 folio_unmap_invalidate()
Message-ID: <cedbmhuivcr2imkzuqebrrihdkfsmgqmplqqn7s2fusk3v4ezq@7jbz26dds76d>
References: <20250218120209.88093-1-jefflexu@linux.alibaba.com>
 <20250218120209.88093-3-jefflexu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218120209.88093-3-jefflexu@linux.alibaba.com>

On Tue, Feb 18, 2025 at 08:02:09PM +0800, Jingbo Xu wrote:
> ... otherwise this is a behavior change for the previous callers of
> invalidate_complete_folio2(), e.g. the page invalidation routine.

Hm. Shouldn't the check be moved to caller of the helper in mm/filemap.c?

Otherwise we would drop pages without writing them back. And lose user's
data.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

