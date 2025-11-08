Return-Path: <linux-fsdevel+bounces-67533-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FCFC42D93
	for <lists+linux-fsdevel@lfdr.de>; Sat, 08 Nov 2025 15:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54C1118878CE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Nov 2025 14:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192D61E0E14;
	Sat,  8 Nov 2025 14:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="IKPY4bm9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86EB204C36
	for <linux-fsdevel@vger.kernel.org>; Sat,  8 Nov 2025 14:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762610496; cv=none; b=sru8xpAgeSg6OoKknnKtB8yjczSQTcnJqTAR2MxZTgyQThEcnnUZOF2+n4vZU6U4qdRdn6Mm8pUOsRtBodudbRqhU52iaY59WN48IXvpKn+0q+R41l3295sFK2Ccw47kqfKJ2Q3MvvKRfJkpvFU9jnSCjspxYWveB5xIZEsuSTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762610496; c=relaxed/simple;
	bh=CNJoTmBYU76d3qdtzuMHrbQpge/KdZ6/OsOyxVTEXWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIhXDIBRbfKlqTqXexftHM/XZ63pAjzS85+BmrWKd8EQtSiipkCfXJb9PykG6o6RMe3FCVn3QqeYP+VIpoh5SJHuzMrRTN60K72/RRSJrTF2sr/YBlgt1VjDetru5kY/zkD1oHPhi2JbV48p92ID2SKIZdyMdjhhC0WE+sdUbpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=IKPY4bm9; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-122-154.bstnma.fios.verizon.net [173.48.122.154])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5A8E1HK1015238
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 8 Nov 2025 09:01:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1762610479; bh=BNBVr38ff5e6t5oymiiuzp16Ba/4xNCIhgf/dMIqUZ4=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=IKPY4bm92ZJKv/V3v2BmYZzKzTXUZ7vZZLP0SAA6GazsILZzfi+mbLLGTDs88J0Oi
	 x9B5Wj4gFcnqH1jHKJOhNJ9wCAdAGAPthaqHFM7476pxK96d/e87sGgOvV49nMqqyh
	 PGAeISm0VeUEmgvEn2FUC1PCQAeSyXgK/a308VGvlDB5/wxfMwP30s/KKg77lRTbTj
	 ufC8lUQypDGKLyF243O/wDwlmDmyHkx3Is1jLQDUzuulbBhVSouSCbKLAJ7psslQt3
	 YK3ShcGolTHgasAUltXSkfyh2nOk165ofkKsmlVUsr1mxltQFGjfemUeJX16Vlq+xA
	 Fv3q/TJU9xpHw==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id C5DCE2E00D9; Sat, 08 Nov 2025 09:01:16 -0500 (EST)
Date: Sat, 8 Nov 2025 09:01:16 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "wqu@suse.com" <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC] Why generic/073 is generic but not btrfs specific?
Message-ID: <20251108140116.GB2988753@mit.edu>
References: <92ac4eb8cdc47ddc99edeb145e67882259d3aa0e.camel@ibm.com>
 <fb616f30-5a56-4436-8dc7-0d8fe2b4d772@suse.com>
 <06b369cd4fdf2dfb1cfe0b43640dbe6b05be368a.camel@ibm.com>
 <a43fd07d-88e6-473d-a0be-3ba3203785e6@suse.com>
 <ee43d81115d91ceb359f697162f21ce50cee29ff.camel@ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee43d81115d91ceb359f697162f21ce50cee29ff.camel@ibm.com>

On Thu, Nov 06, 2025 at 10:29:46PM +0000, Viacheslav Dubeyko wrote:
> > > Technically speaking, HFS+ is journaling file system in Apple implementation.
> > > But we don't have this functionality implemented and fully supported on Linux
> > > kernel side. Potentially, it can be done but currently we haven't such
> > > functionality yet. So, HFS/HFS+ doesn't use journaling on Linux kernel side  and
> > > no journal replay could happen. :)

If the implementation of HJFJS+ in Linux doesn't support metadata
consistency after a crash, I'd suggest adding HFS+ to
_has_metadat_journalling().  This will suppress a number of test
failures so you can focus on other issues which arguably is probably
higher priority for you to fix.

After you get HFS+ to run clean with the journalling tesets skipped,
then you can focus on adding that guarantee at that point, perhaps?

     	     	      	     	  - Ted

