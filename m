Return-Path: <linux-fsdevel+bounces-25410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A114A94BC16
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 13:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0A1F1C21BEE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 11:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4881718B47F;
	Thu,  8 Aug 2024 11:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g516Diaj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EBF187872;
	Thu,  8 Aug 2024 11:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723115908; cv=none; b=W+tcuIZreJWIE5JfLbqFFJWYf8+2mMqMN2j+X8YbpKbTsGCfGHic+NnBVOYRQ4ODNdzIztSZ7DF3UXTnHagQlLyUPpGErgHyhi+bu8B7rHqgwgQMzMP9rjKr2qka3OLnDA60ktnAi7GDp5sF9bbeoVXVuz06OPPMp+Ota20cpUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723115908; c=relaxed/simple;
	bh=RTIpv//zhxsNaqYXJTMF22BgLEqyJhGTt3/9/NubP24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mfy9TBjOOs+y3DvAUn9WrG+3zVKsm1z9vzyX7gfJMNonvBroaIxg36McMFVPCS5+eOM0VW7RJLpvvCTdfACscLDHjmEihcSU7zDbgnFIp3zobtx14oTFbyUOGNRuHmBgZAsYaAl4/sHlNQ2RAeBtl7shKwYU2x1GH7HX1u5PbzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g516Diaj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D32CC4AF09;
	Thu,  8 Aug 2024 11:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723115908;
	bh=RTIpv//zhxsNaqYXJTMF22BgLEqyJhGTt3/9/NubP24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g516DiajKRDKGt8w3sVNzOUaZROH6buwHpYU7TN/SJdh9h7yzW+sMogTl4hzWjvrd
	 UQuKSopn4AdX8zYiah+ELAFUUbX/PJ+YmqRg5B0YDlC/sWZGw6+GbRhO1hp3JEhfcn
	 j75hsDJaL/gfmMpeRHotSx4/oAhzTFIDTwtnRaEC/6+062oqUBJGlcyMoOytjZFJvm
	 oTljrRJ1SEZPUjnG0GSiSIUwBPPjQagxAEdr+k6vPHWBWBuVuBG3Bfd/aSpXCoQTYO
	 4ltkwDhH4TKApOfcWMJ6VNeqYIJk2bYW1b+OHtTuWThzooy4ex74n9jqOmPJOniYHG
	 xKGZlA/kxH30Q==
Date: Thu, 8 Aug 2024 13:18:23 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Mateusz Guzik <mjguzik@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fs: try an opportunistic lookup for O_CREAT opens too
Message-ID: <20240808-schaukeln-erloschen-2a8b12a51d39@brauner>
References: <20240806-openfast-v2-1-42da45981811@kernel.org>
 <20240807-erledigen-antworten-6219caebedc0@brauner>
 <d682e7c2749f8e8c74ea43b8893a17bd6e9a0007.camel@kernel.org>
 <20240808-karnickel-miteinander-d4fa6cd5f3c7@brauner>
 <fd07d39ecb387d235f64b67ca621d22836a6dc38.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fd07d39ecb387d235f64b67ca621d22836a6dc38.camel@kernel.org>

> I don't think so. v3 has it drop out of rcuwalk and do the audit_inode
> call in the case of trailing slashes. I took great pains here to ensure
> that if we emitted a record before that we still do it after. Do let me
> know if I missed a case though.

Ah, I missed that this was predicated on audit not being enabled. Sorry
about the noise...

