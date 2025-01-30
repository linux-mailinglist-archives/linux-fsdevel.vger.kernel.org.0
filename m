Return-Path: <linux-fsdevel+bounces-40406-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E57EA2325A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 17:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E37C63A5123
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 16:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11AA1EE7CB;
	Thu, 30 Jan 2025 16:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="XY+Lo9sy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAD91EE01A
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jan 2025 16:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738256229; cv=none; b=eIbJXWyBV9hTOYlXkDJlDqwxC/VeZbMsvjYlUOCt8gyXqeellBYt9jW0mYfLDAbrHjc0yprd15Xi80Q74mnajvhwJc/auoMk/NTICWZxqGvteVAYnHI75qi7MYptlMdsE0Jiwpu/ghCEafsGr7KOdlCxECyCmMRpRSjBu9BNzh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738256229; c=relaxed/simple;
	bh=qNsZZOVVt9T4yIfLD+iVbIMfvQv1WoQGzFy9F7Hzs30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fjwL+gvsVI7+OzFZpZQe3w4cX6avm6BNsjVV8wDyETHhv1wkqnfZFkS0jOwwh75V3IT2LrwEwxLaiQ1Anp6/mtWO1XAZFE+zqQb0xeB2hsmXT3uNbS2YYQUswLIuM7+q6r+oAHysRMlEPqx1VG+Vb7xB0JQyjfEx6zCcTfkYYdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=XY+Lo9sy; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (guestnat-104-133-8-96.corp.google.com [104.133.8.96] (may be forged))
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 50UGuhDm004150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 11:56:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1738256206; bh=7NvQXWafKj9Oe6SW4odCfOJB5cwhQial8Uh3QOR63VQ=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=XY+Lo9sylbLMqvfp+s7hfNYUoja4l00Jm6s3+HpXVI6FnDlFLCbqqjGtMY7QJnEWk
	 P7amA2YuLbjJHG5dickm/k3d3pIXy/LVBypqBdvS1KFFKFYFVn3qP4o5zjHdKcHTiW
	 QLczO1G1vALkXtdJJgM8x06uJhAYIvOA+5meFqjvSWJ+WQoFTGlT8hqo6l97mqFDmV
	 al4z4iX+uk1gpjcFz2QUAQrBuNZKRfsdpM4lT/BwSAuMX9NK6dwbFOX7gHz4MEBUkB
	 RJUs6yqPNLZBKz17EEUY4AJXLCA/+z+Yi5jw27X8lZGkeX3OUgVtBP8JlRaN7j+/pC
	 SBKrBQZ8ePSMA==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id B373F3404C7; Thu, 30 Jan 2025 08:56:42 -0800 (PST)
Date: Thu, 30 Jan 2025 08:56:42 -0800
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Day, Timothy" <timday@amazon.com>
Cc: Christoph Hellwig <hch@infradead.org>,
        "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "jsimmons@infradead.org" <jsimmons@infradead.org>,
        Andreas Dilger <adilger@ddn.com>, "neilb@suse.de" <neilb@suse.de>
Subject: Re: [LSF/MM/BPF TOPIC] Lustre filesystem upstreaming
Message-ID: <20250130165642.GA416991@mit.edu>
References: <5A3D5719-1705-466D-9A86-96DAFD7EAABD@amazon.com>
 <Z5h1wmTawx6P8lfK@infradead.org>
 <DD162239-D4B3-433C-A7C1-2DBEBFA881EC@amazon.com>
 <20250130142820.GA401886@mit.edu>
 <0E992E6A-AF0D-4DFB-A014-5A08184821CD@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0E992E6A-AF0D-4DFB-A014-5A08184821CD@amazon.com>

On Thu, Jan 30, 2025 at 04:18:29PM +0000, Day, Timothy wrote:
> 
> Lustre has a lot of usage and development outside of DDN/Whamcloud
> [1][2].  HPE, AWS, SuSe, Azure, etc. And at least at AWS, we use
> Lustre on fairly up-to-date kernels [3][4]. And I think this is
> becoming more common - although I don't have solid data on that.

I agree that I am seeing more use/interest of Lustre in various Cloud
deployments, and to the extent that Cloud clients tend to use newer
Linux kernels (e.g., commonly, the the LTS from the year before) that
certainly does make them use kernels newer than a typical RHEL kernel.

It's probably inherent in the nature of cluster file systems that they
won't be of interest for home users who aren't going to be paying the
cost of a dozen or so Cloud VM's being up on a more-or-less continuous
basis.  However, the reality is that more likely than not, developers
who are most likely to be using the latest upstream kernel, or maybe
even Linux-next, are not going to be using cloud VM's.

> And if you have dedicated hardware - setting up a small filesystem over
> TCP/IP isn't much harder than an NFS server IMHO. Just a mkfs and
> mount per storage target. With a single MDS and OSS, you only need two
> disks. So I think we have everything we need to enable upstream
> users/devs to use Lustre without too much hassle. I think it's mostly a
> matter of documentation and scripting.

Hmm... would it be possible to set up a simple toy Lustre file system
using a single system running in qemu --- i.e., using something like a
kvm-xfstests[1] test appliance?  TCP/IP over loopback might be
interesting, if it's posssible to run the Lustre MDS, OSS, and client
on the same kernel.  This would make repro testing a whole lot easier,
if all someone had to do was run the command "kvm-xfstests -c lustre smoke".

[1] https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-quickstart.md

							- Ted

