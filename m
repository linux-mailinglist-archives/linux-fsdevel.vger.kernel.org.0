Return-Path: <linux-fsdevel+bounces-5106-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 283F6808341
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 09:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D211E1F222A8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 08:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564CF2FE0E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 08:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="AQCvEWvZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE34010FA
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 22:51:26 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-122-214.bstnma.fios.verizon.net [173.48.122.214])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3B76ok0S000645
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Dec 2023 01:50:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1701931849; bh=UfL2KoGggpRyXRxC/oRG3Gv/LsdkC3Op4OluyeXF4F4=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=AQCvEWvZ1ZNDqePQ7Faykh3MytTg4T3BXLjg8+ksZvjZdje+pz1Z5L037V5TD0reI
	 rziH1mKOVt8Gh2vp9GOv/C2EdeONUx9PBVIqL5nOX0h9eoDoBawLPZ6ZD5u9hKAVQJ
	 4Cg+ajzFVtW1wcgO4bBRYoWsZP4Sj3jvBD2qN3noneD+RA2cnkJhyE2uJII0gT1g4s
	 AJ0MrEskqHXgAZEMI/JYzkyPRVexOUt7Cv0WlC8VEHiOg0hbwwkiSAUYPIle5JlC/1
	 CysBCcPqOGppMQtHU0FO5Tb9F5IDy4GFp3wNV7p89D3izxsya6h4s0CIBongQGtAOz
	 XrQ4be/Nwl/fA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id AE0E215C057B; Thu,  7 Dec 2023 01:50:46 -0500 (EST)
Date: Thu, 7 Dec 2023 01:50:46 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Dave Chinner <david@fromorbit.com>, hch@lst.de,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] [RFC] iomap: Use FUA for pure data O_DSYNC DIO writes
Message-ID: <20231207065046.GA9663@mit.edu>
References: <20180301014144.28892-1-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180301014144.28892-1-david@fromorbit.com>

On Thu, Mar 01, 2018 at 12:41:44PM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> If we are doing direct IO writes with datasync semantics, we often
> have to flush metadata changes along with the data write. However,
> if we are overwriting existing data, there are no metadata changes
> that we need to flush. In this case, optimising the IO by using
> FUA write makes sense.
> 
> We know from teh IOMAP_F_DIRTY flag as to whether a specific inode
> requires a metadata flush - this is currently used by DAX to ensure
> extent modi$fication as stable in page fault operations. For direct
> IO writes, we can use it to determine if we need to flush metadata
> or not once the data is on disk.

Hi,

I've gotten an inquiry from some engineers at Microsoft who would
really like it if ext4 could use FUA writes when doing O_DSYNC writes,
since this is soemthing that SQL Server uses.  In the discussion for
this patch series back in 2018[1], ext4 hadn't yet converted over to
iomap for Direct I/O, and so adding this feature for ext4 wasn't
really practical.

[1] https://lore.kernel.org/all/20180319160650.mavedzwienzgwgqi@quack2.suse.cz/

Today, ext4 does use iomap for DIO, but an experiment seems to
indicate that something hasn't been wired up to enable FUA for O_DSYNC
writes.  I've looked at fs/iomap/direct-io.c and it wasn't immediately
obvious what I need to add to enable this feature.

I was wondering if you could me some quick hints about what and where
I should be looking?

Many thanks!

						- Ted

