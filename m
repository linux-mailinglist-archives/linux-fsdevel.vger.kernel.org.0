Return-Path: <linux-fsdevel+bounces-35728-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 563A29D7877
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 23:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAA5DB237B9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 22:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83AB1714A5;
	Sun, 24 Nov 2024 22:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="ZNJxW32m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3062500C2;
	Sun, 24 Nov 2024 22:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732486249; cv=none; b=n/RIq1dGBAwiewBuTNCqadscePviC9DfdBubljwLOy0f8ezlm4eHSPi7iomQz5faMLXNIbX2WwvNbTC1J8IQ8Ip/SejPcLuqcBe5sPHP+lWIrVcVpDzcdHbDQK9P6CJjJorynau+CbF9aoBm2dkigzCZn6h+9RN5VshYh3HN4mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732486249; c=relaxed/simple;
	bh=uXTxtY3GGLfY9YToycHfI2w8jR4zpNaqfpMsxvQkf4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHbZ67zYSzVJl1O8Ev1NbB4P8LLuJ5c77NlnknnXyT+8up38duY3nIVhoOcSBLMnVBj61pYzagShP2/yUbYHEt/+N49NlCwPYfWt28Ljt25LrWosIWrlC15ZbYdEw3Oevx+E9j3IfCUkiNAdFjEvjMmZBd9gorkPGmhEMwf5yRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=ZNJxW32m; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=IodPNdQkMHcfqmOdrLYoj7E2O5XjRNaT+YiBQ78dkDk=; b=ZNJxW32mTSIhE0qH
	g0wLe69ck2vIWfX0YoOatZqS+4hpXZUzFOib4i2+oOwFmxwV9uvutegkL53CddsFCaigJqt17wDMb
	jjp/ux9bbTDIc4m3Bf1Fw0nD5Ex/WUdYI4LW8hAFZKqosgis4n+YivyLd5roMnMc+4wPS8dqcolDi
	xzys31pVjhm6dysoN93qcRzevcOQXlAwa9/VA5eX5vqLMdjuYVKPAw4ruxtkfvKDAn4iGkHB3/k//
	B+cqhYEdF+CsJCh5sfr8vgBouvX5ldY0WiOEw/QQiB2LjqyU4sb3PAZyvDFxsyak7VVrZCYWHvjN3
	KclKDeILh3Af6AKxqw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tFKoK-001mws-09;
	Sun, 24 Nov 2024 22:10:32 +0000
Date: Sun, 24 Nov 2024 22:10:31 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Mateusz Guzik <mjguzik@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Hao-ran Zheng <zhenghaoran@buaa.edu.cn>, brauner@kernel.org,
	jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com,
	21371365@buaa.edu.cn,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] metadata updates vs. fetches (was Re: [PATCH v4] fs: Fix
 data race in inode_set_ctime_to_ts)
Message-ID: <Z0OkVxY3CW9fV8tp@gallifrey>
References: <61292055a11a3f80e3afd2ef6871416e3963b977.camel@kernel.org>
 <20241124094253.565643-1-zhenghaoran@buaa.edu.cn>
 <20241124174435.GB620578@frogsfrogsfrogs>
 <wxwj3mxb7xromjvy3vreqbme7tugvi7gfriyhtcznukiladeoj@o7drq3kvflfa>
 <20241124215014.GA3387508@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20241124215014.GA3387508@ZenIV>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 22:04:40 up 200 days,  9:18,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Al Viro (viro@zeniv.linux.org.uk) wrote:
> [Linus Cc'd]
> On Sun, Nov 24, 2024 at 06:56:57PM +0100, Mateusz Guzik wrote:
> 
> > However, since both sec and nsec are updated separately and there is no
> > synchro, reading *both* can still result in values from 2 different
> > updates which is a bug not addressed by any of the above. To my
> > underestanding of the vfs folk take on it this is considered tolerable.
> 
> Well...   You have a timestamp changing.  A reader might get the value
> before change, the value after change *or* one of those with nanoseconds
> from another.  It's really hard to see the scenario where that would
> be a problem - theoretically something might get confused seeing something
> like
> 	Jan 14 1995 12:34:49.214 ->
> 	Jan 14 1995 12:34:49.137 ->
> 	Nov 23 2024 14:09:17.137
> but... what would that something be?

make?
i.e. if the change was from:
 a) mmm dd yyyy hh::MM::00:950 ->
 b) mmm dd yyyy hh::MM::01:950 ->
 c) mmm dd yyyy hh::MM::01:200 ->
   
If you read (b) then you'd think that the file was 750ms newer
than it really was; which is a long time these days.

Dave

> We could add a seqcount, but stat(2) and friends already cost more than
> they should, IMO...
> 
> Linus, do you see any good reasons to bother with that kind of stuff?
> It's not the first time such metadata update vs. read atomicity comes
> up, maybe we ought to settle that for good and document the decision
> and reasons for it.
> 
> This time it's about timestamp (seconds vs. nanoseconds), but there'd
> been mode vs. uid vs. gid mentioned in earlier threads.
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

