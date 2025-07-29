Return-Path: <linux-fsdevel+bounces-56248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE9FB14F2C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 16:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F377B3B99EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 14:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F4F1D95B3;
	Tue, 29 Jul 2025 14:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7Uqwb0b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A1C1C861F
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Jul 2025 14:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753798970; cv=none; b=LW4kXEYUAExT6V19PPjV0Een+UfycT4hXVgCS9oSh/S5viCeEYaFug9jJ/2Jop/un5BW9jVpzcf+6E855mxEdT/QJ6uB9yxFSvZx6P7qWo7tG2c/cY6L8ueIdaJdN4xouYIOhhOp8se8NRL299t3OamCqDJU8IqEcbpp+VLHT2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753798970; c=relaxed/simple;
	bh=aTaq88eiE3t0hS83DWtgXoG67GRi0kA5yK6mfIJj6jE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pPZVfU8cYNYzIyK53GrpFJSWS5a6f9/3QgRTQ0um21Z1YlQxteJEnGI+2U6Hitzs/wrYmFxiMkCccJVCXxNcCYWbBDeNRdrpZMaDGT8DYl9x6bs6b5lISvhWultv3d6Xw7m+KC0e/TQ760po0Vz5fYcero556FRPr1lS2xjPapU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7Uqwb0b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF49C4CEEF;
	Tue, 29 Jul 2025 14:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753798970;
	bh=aTaq88eiE3t0hS83DWtgXoG67GRi0kA5yK6mfIJj6jE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N7Uqwb0bQrfmSIg48fDN7gyfswI9t0GcnLbiAvW8YUOtchzbY8XEfX16Cs3SMBHSB
	 FFVzT2aXKinKSMOBSxG3aYF5oq7ILdYObaiEstiKWdvdETYtjrIhjZFwOdBgzeRjcS
	 MZHWRRwtHUescS/DBV2bW5ufAhERKnUe9rvSurYHHduMPj7Q8X2NnLISFCfcyMh52T
	 IlifSl4LfccdTIUbzu+JxHLNk3RnBL9wkRXjx38cLOmJPCIqBsL34NhY52af2O5JGv
	 wJnSrs40yFjg+3/KbOVmq2GYZA8EvnL1XWunDMQzxPU3k6UUc4D6fNJlJqmED/VG0h
	 fK0u6uh5TVFGw==
Date: Tue, 29 Jul 2025 07:22:49 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>, "John@groves.net" <John@groves.net>,
	"joannelkoong@gmail.com" <joannelkoong@gmail.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"bernd@bsbernd.com" <bernd@bsbernd.com>,
	"neal@gompa.dev" <neal@gompa.dev>,
	"miklos@szeredi.hu" <miklos@szeredi.hu>
Subject: Re: [PATCH 08/14] libfuse: connect high level fuse library to
 fuse_reply_attr_iflags
Message-ID: <20250729142249.GU2672029@frogsfrogsfrogs>
References: <175279459673.714161.10658209239262310420.stgit@frogsfrogsfrogs>
 <175279459875.714161.9108157061004962886.stgit@frogsfrogsfrogs>
 <CAOQ4uxjRjssQr4M0JQShQHkDh_kh7Risj4BhkfTdfQuBVKY8LQ@mail.gmail.com>
 <20250718155514.GS2672029@frogsfrogsfrogs>
 <fa6b51a1-f2d9-4bf6-b20e-6ab4fd4fb3f0@ddn.com>
 <20250723175031.GJ2672029@frogsfrogsfrogs>
 <CAOQ4uxi8hTbhAB4a1z-Wsnp0px3HG4rM0j-Q7LTt_-zd1UsqeQ@mail.gmail.com>
 <20250729053533.GS2672029@frogsfrogsfrogs>
 <CAOQ4uxjwVnD9X6=LtcV7A+_peFs36YHm3tJO2ak+1OSxC36e9Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjwVnD9X6=LtcV7A+_peFs36YHm3tJO2ak+1OSxC36e9Q@mail.gmail.com>

On Tue, Jul 29, 2025 at 09:50:30AM +0200, Amir Goldstein wrote:
> On Tue, Jul 29, 2025 at 7:35 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Thu, Jul 24, 2025 at 09:56:16PM +0200, Amir Goldstein wrote:
> > > > > Also a bit surprising to see all your lowlevel work and then fuse high
> > > > > level coming ;)
> > > >
> > > > Right now fuse2fs is a high level fuse server, so I hacked whatever I
> > > > needed into fuse.c to make it sort of work, awkwardly.  That stuff
> > > > doesn't need to live forever.
> > > >
> > > > In the long run, the lowlevel server will probably have better
> > > > performance because fuse2fs++ can pass ext2 inode numbers to the kernel
> > > > as the nodeids, and libext2fs can look up inodes via nodeid.  No more
> > > > path construction overhead!
> > > >
> > >
> > > I was wondering how well an LLM would be in the mechanical task of
> > > converting fuse2fs to a low level fuse fs, so I was tempted to try.
> > >
> > > Feel free to use it or lose it or use as a reference, because at least
> > > for basic testing it seems to works:
> > > https://github.com/amir73il/e2fsprogs/commits/fuse4fs/
> >
> > Heh, I'll take a closer look in the morning, but it looks like a
> > reasonable conversion.  Are you willing to add a "Co-developed-by" tag
> > per Sasha's recent proposal[1] if I pull it in?
> >
> > [1] https://lore.kernel.org/lkml/20250727195802.2222764-1-sashal@kernel.org/
> >
> 
> Sure. Added and pushed.
> 
> FYI, some behind the scenes for the interested:
> - The commit titles roughly align to the LLM prompts that I used

Heh.  For reproducibility, I wonder if it ought to be a good idea for
the commit messages to contain the prompts fed to the LLM?  Maybe I'll
suggest that to Sasha.

> - One liner commit message "LLM aided conversion" means it's mostly hands off
> - Anything other than the one liner commit message suggests human intervention,
>   that was usually done to make the code more human friendly, the patches
>   diffstat smaller and frankly, to match my human preferences

Oh, I was hoping you'd say that you reprompted all the way to working
patches, but I suppose AIs are rather expensive to operate.

> - I did not let the agent touch git at all and I took care of applying
> fixes into
>   respective patches manually when needed
> - The code compiles, but obviously does not work mid series

ha lol :)

> - The most interesting part was the last commit of tests, when the agent
>   was testing and fixing its own conversion. This comes with some nice
>   observations about machine-human collaboration in this context, for example:
> - The machine figured out the need to convert
>   EXT2_ROOT_INO <=> FUSE_ROOT_INO by itself from self testing,
>   created the conversion helpers and used them in lookup and some other
>   methods

<nod> I think Miklos mentioned that I could work around that by allowing
fuse servers to set the root nodeid with a mount option.

> - Obviously, it would have figured out that the conversion helpers need to
>   be used for all methods sooner or later during self testing, but its self
>   reflecting cycles can be so long and tedious for an observation that
>   look so trivial, so a nudge from human "convert all methods" really helps
>   speeding things up, at least with the agent/model/version that I used

Well we could just do the usual "make main exit(1) for the duration of
the chur^Wchanges" trick to avoid bisection bombs. :)

> I think that language/API conversion is one of the tasks where LLM
> can contribute most to humans, as long the work is meticulously
> reviewed by a human that has good knowledge of both source and
> target language/dialect.

Yeah.  Though first I need to lay the groundwork by figuring out if
macfuse/freebsd fuse actually provide the lowlevel library.  If not,
then per Ted's direction I'll have to implement both. :/

Maybe I'll try the Oracle codebot this week, though I think they said it
only knows Python.  Anyway, thanks for the inputs. :)

--D

> Thanks,
> Amir.
> 

