Return-Path: <linux-fsdevel+bounces-5699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD37280EFEC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 16:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9850C281C0F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 15:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2E87542E;
	Tue, 12 Dec 2023 15:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Q5sj5B3t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41780D3
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 07:18:43 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-124-235.bstnma.fios.verizon.net [173.48.124.235])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3BCFGD14031942
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Dec 2023 10:16:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1702394176; bh=DtgEPyOZ4y0NfYNH2YIubU5zH6WNkZa4uw9X/YrTYR4=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=Q5sj5B3tLr9igBweNwduA6PZT0jYBpf0QnbgLveixW6seItI++ZBFGLTSfMerXbHS
	 p3Njc97PdcRGIf4TKVEIgxHBmronQjNXJXkrLeyzAbdW7GV1yA6oV2+VPV1gK1ydCA
	 plr3+UqY8u6qAlN8rPtYydnRcIslVMIPw7x6+DKRYXPcipRYnF6o/Q/c+IcjyVQ1nz
	 xX/twG+yBdGeDtIRnBvYz8ENuccCOYcaLXXX4fUlprrqCi9h59tRVipe7VYumU3kvK
	 SwIQLaIYDR3Ok4/grND9PhvZx+JGOPReXUzLdYhTXSVb3FEptumR75NlyxpN2qeOgl
	 1tSRfCDMZ1iaQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id A517515C1422; Tue, 12 Dec 2023 10:16:13 -0500 (EST)
Date: Tue, 12 Dec 2023 10:16:13 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Christoph Hellwig <hch@infradead.org>
Cc: John Garry <john.g.garry@oracle.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-ext4@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dchinner@redhat.com
Subject: Re: [RFC 0/7] ext4: Allocator changes for atomic write support with
 DIO
Message-ID: <20231212151613.GA142380@mit.edu>
References: <cover.1701339358.git.ojaswin@linux.ibm.com>
 <8c06c139-f994-442b-925e-e177ef2c5adb@oracle.com>
 <ZW3WZ6prrdsPc55Z@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <de90e79b-83f2-428f-bac6-0754708aa4a8@oracle.com>
 <ZXbqVs0TdoDcJ352@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <c4cf3924-f67d-4f04-8460-054dbad70b93@oracle.com>
 <ZXhb0tKFvAge/GWf@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXhb0tKFvAge/GWf@infradead.org>

On Tue, Dec 12, 2023 at 05:10:42AM -0800, Christoph Hellwig wrote:
> On Tue, Dec 12, 2023 at 07:46:51AM +0000, John Garry wrote:
> > It is assumed that the user will fallocate/dd the complete file before
> > issuing atomic writes, and we will have extent alignment and length as
> > required.
> 
> I don't think that's a long time maintainable usage model.

For databases that are trying to use this to significantly improve
their performance by eliminating double writes, the allocation and
writes are being done by a single process.  So for *that* use case, it
is quite maintainable.

Cheers,

						- Ted

