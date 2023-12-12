Return-Path: <linux-fsdevel+bounces-5702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7476A80EFFA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 16:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 296891F21015
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 15:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493ED75425;
	Tue, 12 Dec 2023 15:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="LzwyPqVo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466A583
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 07:20:55 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-124-235.bstnma.fios.verizon.net [173.48.124.235])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3BCFKGb9002440
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Dec 2023 10:20:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1702394419; bh=Rf4NyHU1FOsEao5ocA/GzTHYRoWx+CcxR8bLTSQhNCI=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=LzwyPqVoUn+Fn2+gO9Ci6S3jZyCMaoE4vCzLIRfuYho35bG2RlaZ1IypvFeQ3BAo/
	 JSdMGhuYhRPSlW1KCc07K7HPbRtNc1eTdm1b5n7I2bl8Pxd45Gz/rFYPfkLN4MIpXJ
	 XPPZTwqf+4pmZOffG7x9LykWkF8qZJcx1ryzTiY67SsgVyKkmmlcUMuLYxVB4mW4qi
	 WzzOp0lvvl4yaQP1dtNiX89TOrjc5g6yAtheEsOUAWUFEcUcYmu8Vk9KFqeYCGi11T
	 C2Jmld4XjsoLxSn9rLjQz9IaQ1/f7rcpr9JkXW6FHLr/t0n3Klkfq9ZAo5S13vZZQs
	 Z/OraBZLq2XJg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 9F47715C3B37; Tue, 12 Dec 2023 10:20:16 -0500 (EST)
Date: Tue, 12 Dec 2023 10:20:16 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Donald Buczek <buczek@molgen.mpg.de>
Cc: Dave Chinner <david@fromorbit.com>, NeilBrown <neilb@suse.de>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        linux-bcachefs@vger.kernel.org,
        Stefan Krueger <stefan.krueger@aei.mpg.de>,
        David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: file handle in statx
Message-ID: <20231212152016.GB142380@mit.edu>
References: <20231208024919.yjmyasgc76gxjnda@moria.home.lan>
 <630fcb48-1e1e-43df-8b27-a396a06c9f37@molgen.mpg.de>
 <20231208200247.we3zrwmnkwy5ibbz@moria.home.lan>
 <170233460764.12910.276163802059260666@noble.neil.brown.name>
 <20231211233231.oiazgkqs7yahruuw@moria.home.lan>
 <170233878712.12910.112528191448334241@noble.neil.brown.name>
 <20231212000515.4fesfyobdlzjlwra@moria.home.lan>
 <170234279139.12910.809452786055101337@noble.neil.brown.name>
 <ZXf1WCrw4TPc5y7d@dread.disaster.area>
 <e07d2063-1a0b-4527-afca-f6e6e2ecb821@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e07d2063-1a0b-4527-afca-f6e6e2ecb821@molgen.mpg.de>

On Tue, Dec 12, 2023 at 10:10:23AM +0100, Donald Buczek wrote:
> On 12/12/23 06:53, Dave Chinner wrote:
> 
> > So can someone please explain to me why we need to try to re-invent
> > a generic filehandle concept in statx when we already have a
> > have working and widely supported user API that provides exactly
> > this functionality?
> 
> name_to_handle_at() is fine, but userspace could profit from being
> able to retrieve the filehandle together with the other metadata in
> a single system call.

Can you say more?  What, specifically is the application that would
want to do that, and is it really in such a hot path that it would be
a user-visible improveable, let aloine something that can be actually
be measured?

						- Ted

