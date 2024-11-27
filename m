Return-Path: <linux-fsdevel+bounces-36009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 356C19DAA4C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 16:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8E5628281E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 15:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054041FF7BC;
	Wed, 27 Nov 2024 15:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="cflNpNiE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BVxSiHKe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F64346447;
	Wed, 27 Nov 2024 15:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732719628; cv=none; b=pGOp+EOYf02if27i/cSijT6cUJPb2w/7NmiQ2W8v5sjV70wg+8hb8obM7RWpuGx+Yhx1phG2mDruxKLckaF/f/pKac9PnDxi28QxGIYCFXBhRuB+fc+NSAizkDLohxHUiZPgP4t0xGChFI5BMKVqymdTWGfWZhHO2+gbGhq5REQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732719628; c=relaxed/simple;
	bh=S8WOt3XS3ffuA4SkCF5xWhZI7UgStUwEvyQWNFBRWUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8l+KulKm81w2aySb/sGjeu0PudKfINndK4AVHiskHaMZ6eLk76fujw5wKMMgwTu8stmPjRcu9EOFPY/ESrVLptG0Ur8+lqPqxCP3yUCEvBHbg2q5ucodgpjl25uIMFX0gv1RP66PS9M2W7EspmBCgX0kXnHr5Tt/UNam3xFrhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza; spf=pass smtp.mailfrom=tycho.pizza; dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b=cflNpNiE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BVxSiHKe; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tycho.pizza
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 6177413802CB;
	Wed, 27 Nov 2024 10:00:23 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 27 Nov 2024 10:00:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1732719623; x=1732806023; bh=rdIuwMAQ6G
	ejsm7b5qViee1kStyXKxOtBCpCokGSvD0=; b=cflNpNiEwHtAQBw2zgCv4gadWK
	Q/YQjdsizsTuzoGPOn7+J/9WALRxliMimt/T1fwa0KXaTMza+ZA2K/Y8hcAgspjc
	SzA0mKedQQxSdeuq2LyFwXrHa0uqxM426HBZb1gqId+VqvsocBl1YonmrFaJ0u9J
	f4e8/IPUQxHNzASrhpHQx7Il0egtQBsuw+0WfwP0PFQ42pL7kdtMMxp+D29W6v2F
	CAAbFlC/Y/eDQoodCD2c8rhuirYk2D/QL1ByFsmyMcUHpwYy3Cp+/98sP9kTfYQY
	Ho8zMrWEtHknCX4Xcv/AWF+2xvU4X1NSeT55gP5t95DM7Rp7DBZS/rKpAyOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732719623; x=1732806023; bh=rdIuwMAQ6Gejsm7b5qViee1kStyXKxOtBCp
	CokGSvD0=; b=BVxSiHKe+WTKqTYCFwcCNnjBMd5UTbjDwb2Pq0niLaFLmlsMnTX
	VViUaEZO3PeSBDGbXdlpKg6VGxgmpdQd2CWpGsMqmHJDI4far0VCga+W/VLYPrJ3
	vwQiPWjfn+2yuZkavsRVZg+1zg5fzirWLwy0nMl6o8lIvIFIvKJqNo9RL7DL6QbG
	ToT2aN/+03pSBwjn3QJBCzooYZUfKJ/Zj6gnPpqd9YwG3Ce0hCjpx498dx1TRx4r
	r7d6YWC6z+1WXVfsapfonzkidsz6wiz5NZ1j+/4VxKd6VulnMeEnZThpHJCzjoaA
	rXImPYEZtF2/wk6qL0pkmw1kFrOZK7HRgYA==
X-ME-Sender: <xms:AjRHZ_AW874cCeLntUh0EWJFIkqu1O7JBUUq32Bgon5HlG9kzRa-kQ>
    <xme:AjRHZ1iAUkGEu7rrZQCnjohZOSAPdHqgTZntY-ZFilVqvO_z9bqp_3El58fBKdGfO
    O7-lPpKNjeGpc_wooY>
X-ME-Received: <xmr:AjRHZ6kN8Id0DqS1C3aJMg8NgWrYoTIen2stUp1XeusYvdPChEXRIOqsXQ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeelgdeijecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefvhigthhhoucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpih
    iiiigrqeenucggtffrrghtthgvrhhnpedthfffveekvefggfdvvdejiedvhfehleejtddt
    feegleeiheektdeljeeigeeigfenucffohhmrghinhepshhirhgvnhgrrdhorhhgrdhukh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthigt
    hhhosehthigthhhordhpihiiiigrpdhnsggprhgtphhtthhopedugedpmhhouggvpehsmh
    htphhouhhtpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhope
    gsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjrggtkhesshhushgv
    rdgtiidprhgtphhtthhopegvsghivgguvghrmhesgihmihhsshhiohhnrdgtohhmpdhrtg
    hpthhtohepkhgvvghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehskhhhrghnsehl
    ihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepiigshihsiigvkhesih
    hnrdifrgifrdhplhdprhgtphhtthhopegthihphhgrrhestgihphhhrghrrdgtohhm
X-ME-Proxy: <xmx:AjRHZxwTK_jX14Y0JwfSyHuSkMY0wrZzCDMbqNHjRGAY7b0-FGnzAg>
    <xmx:AjRHZ0QPln-BxRzLCRLHJkE_efuG5vSYbJCAlDZmV62znucyR3LH7Q>
    <xmx:AjRHZ0Y0MrB8o4iyesrEleNQf3Fx06J8msOmIe7KrObUtFzX84FLHg>
    <xmx:AjRHZ1S3fHcnMACSu2ywrSAZBv0yKd8-kULbjpCW_wMxQwAgfRpuxw>
    <xmx:BzRHZwp1pUur4PqHCoyJD_QF3oGsE-w78jyWRy64W9zld5NnnfvtwmFz>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Nov 2024 10:00:16 -0500 (EST)
Date: Wed, 27 Nov 2024 08:00:12 -0700
From: Tycho Andersen <tycho@tycho.pizza>
To: Mark Brown <broonie@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Aleksa Sarai <cyphar@cyphar.com>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Tycho Andersen <tandersen@netflix.com>
Subject: Re: [PATCH 2/2] selftests/exec: add a test for execveat()'s comm
Message-ID: <Z0cz/Dhrw118WPiE@tycho.pizza>
References: <20241030203732.248767-1-tycho@tycho.pizza>
 <20241030203732.248767-2-tycho@tycho.pizza>
 <6c68dddb-84f3-4b73-987c-8334b2301d9b@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c68dddb-84f3-4b73-987c-8334b2301d9b@sirena.org.uk>

On Wed, Nov 27, 2024 at 02:25:29PM +0000, Mark Brown wrote:
> On Wed, Oct 30, 2024 at 02:37:32PM -0600, Tycho Andersen wrote:
> > From: Tycho Andersen <tandersen@netflix.com>
> > 
> > In the previous patch we've defined a couple behaviors:
> > 
> > 1. execveat(fd, AT_EMPTY_PATH, {"foo"}, ...) should render argv[0] as
> >    /proc/pid/comm
> > 2. execveat(fd, AT_EMPTY_PATH, {NULL}, ...) should keep the old behavior of
> >    rendering the fd as /proc/pid/comm
> > 
> > and just to be sure keeps working with symlinks, which was a concern in
> > [1], I've added a test for that as well.
> > 
> > The test itself is a bit ugly, because the existing check_execveat_fail()
> > helpers use a hardcoded envp and argv, and we want to "pass" things via the
> > environment to test various argument values, but it seemed cleaner than
> > passing one in everywhere in all the existing tests.
> 
> This test doesn't pass in my CI, running on an i.MX8MP Verdin board.
> This is an arm64 system and I'm running the tests on NFS.
> 
> > Output looks like:
> 
> >     ok 51 Check success of execveat(6, 'home/tycho/packages/...yyyyyyyyyyyyyyyyyyyy', 0)...
> >     # Check execveat(AT_EMPTY_PATH)'s comm is sentinel
> >     ok 52 Check success of execveat(9, '', 4096)...
> >     # Check execveat(AT_EMPTY_PATH)'s comm is sentinel
> >     ok 53 Check success of execveat(11, '', 4096)...
> >     # Check execveat(AT_EMPTY_PATH)'s comm is 9
> >     [   25.579272] process 'execveat' launched '/dev/fd/9' with NULL argv: empty string added
> >     ok 54 Check success of execveat(9, '', 4096)...
> 
> The output when things fail is:
> 
> # # Check execveat(AT_EMPTY_PATH)'s comm is sentinel
> # # bad comm, got: 11 expected: sentinel# child 8257 exited with 1 neither 0 nor 0
> # not ok 52 Check success of execveat(11, '', 4096)... 
> # # Check execveat(AT_EMPTY_PATH)'s comm is sentinel
> # # bad comm, got: 13 expected: sentinel# child 8258 exited with 1 neither 0 nor 0
> # not ok 53 Check success of execveat(13, '', 4096)... 
> 
> Full log from a failing job at:
> 
>    https://lava.sirena.org.uk/scheduler/job/993508
> 
> I didn't do any investigation beyond this.

Strange... but this series has been rejected by Linus anyway, so
probably not worth investigating further.

Tycho

