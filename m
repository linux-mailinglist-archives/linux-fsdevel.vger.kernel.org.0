Return-Path: <linux-fsdevel+bounces-24186-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1C993AE49
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 11:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85DB2B23602
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 09:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B201514DA;
	Wed, 24 Jul 2024 09:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="BMmLNSgW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE33B14B095;
	Wed, 24 Jul 2024 09:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721811999; cv=none; b=a+8h3u+twFmmpD0YfHfI997oWITJwslP3GbcUvOu7o5x0Rwf9iuOk4xEx8R+9zuJU3uGCwhO4KkKvkh34Tn3fwP4HERb3F5F63/ZOnh1+FEGov7fec93626xYsUpGw8Ze5pZZAD9g2DUzFmRpSSNTa0wg4GO/0Wi/ktKQDjioqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721811999; c=relaxed/simple;
	bh=QrFxDcN4n10oTiBQIOKDoz81+N9yJcI+JrDQSMc3bAM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nV4P/GIdePYC4yuFPPYizLVZzkXcFNHFGS0snjOAdPA0DDWUBrZOGQV5bZQbryO/dYo68dgFmLlK3BGQf5z8L1+eBUcl/GQ+n7aO13Jf8Ev2gnouPMzFP2T5X6B+zOQsH15oQjPpODdT+uNZbyDytrX/dngJZ/uPluoBpO+5vIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=BMmLNSgW; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=QrFxDcN4n10oTiBQIOKDoz81+N9yJcI+JrDQSMc3bAM=;
	t=1721811997; x=1723021597; b=BMmLNSgWERq2pGvna94KZn8L9anOvRlRJCqcTE0pO2m3pc/
	Dp6sE6aWlfPFWrnSkAMrvRLxAJh5h2300EtSG/U3US2KvX5vYK5aVdc2PzUuF6A6BKI9esYvYZDYq
	FB3mTL1K9OmAxBTYlhw66UISnOjXC3J/uUjX9/5acydULb3EQ5Bta3j0UO7qM51I4IrW0RzLZ8B5v
	VWlBkjp6D1HisQmi/IH8dLzKNrSLpwFAW0aeC4FoC6U1Lbv5xCOIllUGfTSHr5wDMg4q7WojnaQmu
	XwnO2uLlSYFc3PTTfuVB/D2IzI6QyG+ICckkOWS16/15PMwVkeY00pzfN/BEfo3w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sWXxC-0000000DL4k-0XoI;
	Wed, 24 Jul 2024 11:06:34 +0200
Message-ID: <fcfc079f251657f9017f86b626e0595897cb8163.camel@sipsolutions.net>
Subject: Re: [PATCH] scripts: add macro_checker script to check unused
 parameters in macros
From: Johannes Berg <johannes@sipsolutions.net>
To: Andrew Morton <akpm@linux-foundation.org>, Julian Sun
	 <sunjunchao2870@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, jack@suse.cz, brauner@kernel.org, 
 viro@zeniv.linux.org.uk, masahiroy@kernel.org, n.schier@avm.de,
 ojeda@kernel.org,  djwong@kernel.org, kvalo@kernel.org
Date: Wed, 24 Jul 2024 11:06:33 +0200
In-Reply-To: <20240723150931.42f206f9cd86bc391b48c790@linux-foundation.org>
References: <20240723091154.52458-1-sunjunchao2870@gmail.com>
	 <20240723150931.42f206f9cd86bc391b48c790@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

>=20
> Makes me wonder who will run this, and why.

I suspect once it's there we could convince folks like the 0-day robot
maintainers or Jakub for nipa [1] to run it and at least flag newly
reported issues.

[1] https://github.com/linux-netdev/nipa


Or maybe run it with W=3D1 like we run kernel-doc then (cmd_checkdoc and
"$(call cmd,checkdoc)")?

johannes




