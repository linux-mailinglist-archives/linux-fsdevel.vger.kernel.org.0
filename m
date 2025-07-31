Return-Path: <linux-fsdevel+bounces-56410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA01B171BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 15:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D499581D2C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 13:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179AD2C17B4;
	Thu, 31 Jul 2025 13:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="YBsRuC6O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D0A2C1589
	for <linux-fsdevel@vger.kernel.org>; Thu, 31 Jul 2025 13:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753967123; cv=none; b=q7QzVNj6Op8bRekYwOPJ2d5TPV8wFtNCyeOojIs+iKtJjUAgD5WuyBGc2ohLUE4Y1pjYstcyqShxgKTMkaeuRaD8ag/Jtseeirxf0UNIsYHTi+baODYVAXp+2MkWeq3q+2xLnUg8hQPemtvygdVAOl1V+VPGMRdesLkSZm4qNro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753967123; c=relaxed/simple;
	bh=cpGVLAirzve6q1QBOgLHvRrqrEgtPy/CLzXAgW1WyQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VkqAF+LZ2JoOKzgrzwEpZiejLyfVNFhnj0hgwalVu/teTbZA3iysX1ds8q1AKkWHZtMF6xPQP6/kr1VxLwsZyxhGv+LCLXFgX51E0zCJ50F2ocSloo17NC56PD4h+sGPoqjwPh0l2oHJ9B51QLKXhOSF/Jf8SD98gIVUFsMJIbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=YBsRuC6O; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-136.bstnma.fios.verizon.net [173.48.82.136])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 56VD4w5t009884
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Jul 2025 09:04:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1753967102; bh=SE+WJgY7kjD8m2Wd3MqzsMoIA0p7jjlnZgzpK+GhFQs=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=YBsRuC6OffkgLiPTmUGJKdahdnGV5b+ycAdp0wMOCdjZKeFc3T5pZ7KXYvi9MlNAK
	 HWTCpQ4KOjO2cOavHgfMKVrvopaEWeyXpPYk830D5DthuFKr/gepKrsg8Tzvnnz6p9
	 yUHKEox23TiKmAgIER+O05uDumfi2NPaHen5857XT+/mBrS8iliZ3PwijnVYD1glhu
	 RDJohZ2y9tiHta5SBeRgU7mFoyUpjyd0dSsNAwTbSEnQBV3jo0rUNoU4sBcH8QNWNl
	 VUde23meKhWlDcJIyQ1naRa5KO9Ebm+SU4U/VpjmQ55VjfW79GcEjJjIuEFX5i3xOF
	 aqKYMsGokQaiA==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 730E42E00D6; Thu, 31 Jul 2025 09:04:58 -0400 (EDT)
Date: Thu, 31 Jul 2025 09:04:58 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Luis Henriques <luis@igalia.com>, Miklos Szeredi <miklos@szeredi.hu>,
        Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] Another take at restarting FUSE servers
Message-ID: <20250731130458.GE273706@mit.edu>
References: <8734afp0ct.fsf@igalia.com>
 <20250729233854.GV2672029@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729233854.GV2672029@frogsfrogsfrogs>

On Tue, Jul 29, 2025 at 04:38:54PM -0700, Darrick J. Wong wrote:
> 
> Just speaking for fuse2fs here -- that would be kinda nifty if libfuse
> could restart itself.  It's unclear if doing so will actually enable us
> to clear the condition that caused the failure in the first place, but I
> suppose fuse2fs /does/ have e2fsck -fy at hand.  So maybe restarts
> aren't totally crazy.

I'm trying to understand what the failure scenario is here.  Is this
if the userspace fuse server (i.e., fuse2fs) has crashed?  If so, what
is supposed to happen with respect to open files, metadata and data
modifications which were in transit, etc.?  Sure, fuse2fs could run
e2fsck -fy, but if there are dirty inode on the system, that's going
potentally to be out of sync, right?

What are the recovery semantics that we hope to be able to provide?

     	     	      		     	     - Ted

