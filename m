Return-Path: <linux-fsdevel+bounces-3476-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FCD7F5205
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 22:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35DC52814F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 21:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03EC1A590;
	Wed, 22 Nov 2023 21:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="saaCeffv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C431A8;
	Wed, 22 Nov 2023 13:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Humg2PScZF2wDwV9BWUbbU67w2PP4g8zlkqlYFN20Ks=; b=saaCeffvvvXFQAMl5XrkZp/Ir1
	Qr5jS0Tl4PHDBDPU4+Kz8cC/AERvEe8TE6+lgVynBikt+bjlljWmV2aHZkgpXMl51l3ZeEdBCeoS4
	npSbxVDnboFB96eVhbUnTt475sGMob1LX0IKSskTyQmZHKCcoXx6KvPQVcFxnGpDi1GaxZotgWosS
	35JZzWQ0bVIDIvQwfLnQCGLU6qe8dq4u/6eUasj8sID2+n9O3rsgtH0Te9sshmx9pRuoLN+B7hXR9
	A93hFlEWg10arO2Yft3zS7I6nhLcMLKq/u5mBMX8JYm8gxiJPS/ZUMzhn6lO+Dws9G05ZwQizar64
	LARp+q3Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r5uOM-001mcA-1y;
	Wed, 22 Nov 2023 21:04:14 +0000
Date: Wed, 22 Nov 2023 21:04:14 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Gabriel Krisman Bertazi <krisman@suse.de>,
	linux-f2fs-devel@lists.sourceforge.net, ebiggers@kernel.org,
	linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH v6 0/9] Support negative dentries on
 case-insensitive ext4 and f2fs
Message-ID: <20231122210414.GI38156@ZenIV>
References: <20230816050803.15660-1-krisman@suse.de>
 <20231025-selektiert-leibarzt-5d0070d85d93@brauner>
 <655a9634.630a0220.d50d7.5063SMTPIN_ADDED_BROKEN@mx.google.com>
 <20231120-nihilismus-verehren-f2b932b799e0@brauner>
 <CAHk-=whTCWwfmSzv3uVLN286_WZ6coN-GNw=4DWja7NZzp5ytg@mail.gmail.com>
 <20231121020254.GB291888@mit.edu>
 <CAHk-=whb80quGmmgVcsq51cXw9dQ9EfNMi9otL9eh34jVZaD2g@mail.gmail.com>
 <CAHk-=wh+o0Zkzn=mtF6nB1b-EEcod-y4+ZWtAe7=Mi1v7RjUpg@mail.gmail.com>
 <20231121051215.GA335601@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121051215.GA335601@mit.edu>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Nov 21, 2023 at 12:12:15AM -0500, Theodore Ts'o wrote:
> Yeah, agreed, that would be a nice optimization.  However, in the
> unfortunate case where (a) it's non-ASCII, and (b) the input string is
> non-normalized and/or differs in case, we end up scanning some portion
> of the two strings twice; once doing the strcmp, and once doing the
> Unicode slow path.

The first pass is cheap and the second one will be running entirely
from the cache, so I doubt that scanning them twice will be a loss...

