Return-Path: <linux-fsdevel+bounces-1123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 817247D5C4A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 22:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DAE2281A87
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 20:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8525F3E47A;
	Tue, 24 Oct 2023 20:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNFVEaHU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FC53E01E
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 20:19:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63283C433C7;
	Tue, 24 Oct 2023 20:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698178760;
	bh=/jXqC7vbvPCmettO3DV3ntCzZ6lqFawlTkTOPw+dpkg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=cNFVEaHU/JSGFWmYYSgGbEUwcbU6E57XzHmF6PqxxLbNxe6qOiw0skHlgT2FAmt4E
	 pi7vTvmXtMoxa+QN5NsjIdLL7cod+koC+MMTHlEpmPJUMjUC2aCFbd6V/QPJYLMFs8
	 HeGKpzhI7MJVwlt6Q6WqHDPcW/boyVT98qJk/U++wdAZeq1FkdpLsbC5n4rWR+02Sm
	 4Zz7+vBjkN7QlHu9uefsCd9OegvQAC62mZ6Y5yTZ4a6WJMK/LSFJN+jV5JHIiYtpq6
	 BfJsXaU5B0axY0tFkCUNbOVQ0CdE3cC5UHu6WxcIlleK2U9pGJasSUCR6GhHkowEoo
	 o0g7zaVbON3Zw==
Message-ID: <62828738f237c3d972f71f8da150b3366eb3e1a0.camel@kernel.org>
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
From: Jeff Layton <jlayton@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dave Chinner <david@fromorbit.com>, Kent Overstreet
 <kent.overstreet@linux.dev>, Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, John Stultz <jstultz@google.com>,
 Thomas Gleixner <tglx@linutronix.de>,  Stephen Boyd <sboyd@kernel.org>,
 Chandan Babu R <chandan.babu@oracle.com>, "Darrick J. Wong"
 <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>, Andreas Dilger
 <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, Josef Bacik
 <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Hugh Dickins
 <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, Amir
 Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.de>, David Howells
 <dhowells@redhat.com>,  linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org,  linux-btrfs@vger.kernel.org,
 linux-mm@kvack.org, linux-nfs@vger.kernel.org
Date: Tue, 24 Oct 2023 16:19:17 -0400
In-Reply-To: <CAHk-=wibJqQGBXAr2S69FifUXdJJ=unAQT5ag0qRSQNxGk31Lw@mail.gmail.com>
References: 
	<CAHk-=wixObEhBXM22JDopRdt7Z=tGGuizq66g4RnUmG9toA2DA@mail.gmail.com>
	 <d6162230b83359d3ed1ee706cc1cb6eacfb12a4f.camel@kernel.org>
	 <CAHk-=wiKJgOg_3z21Sy9bu+3i_34S86r8fd6ngvJpZDwa-ww8Q@mail.gmail.com>
	 <5f96e69d438ab96099bb67d16b77583c99911caa.camel@kernel.org>
	 <20231019-fluor-skifahren-ec74ceb6c63e@brauner>
	 <0a1a847af4372e62000b259e992850527f587205.camel@kernel.org>
	 <ZTGncMVw19QVJzI6@dread.disaster.area>
	 <eb3b9e71ee9c6d8e228b0927dec3ac9177b06ec6.camel@kernel.org>
	 <ZTWfX3CqPy9yCddQ@dread.disaster.area>
	 <61b32a4093948ae1ae8603688793f07de764430f.camel@kernel.org>
	 <ZTcBI2xaZz1GdMjX@dread.disaster.area>
	 <CAHk-=whphyjjLwDcEthOOFXXfgwGrtrMnW2iyjdQioV6YSMEPw@mail.gmail.com>
	 <2c74660bc44557dba8391758535e4012cbea3724.camel@kernel.org>
	 <CAHk-=wibJqQGBXAr2S69FifUXdJJ=unAQT5ag0qRSQNxGk31Lw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-10-24 at 09:40 -1000, Linus Torvalds wrote:
> On Tue, 24 Oct 2023 at 09:07, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > The new flag idea is a good one. The catch though is that there are no
> > readers of i_version in-kernel other than NFSD and IMA, so there would
> > be no in-kernel users of I_VERSION_QUERIED_STRICT.
>=20
> I actually see that as an absolute positive.
>=20
> I think we should *conceptually* do those two flags, but then realize
> that there are no users of the STRICT version, and just skip it.
>=20
> So practically speaking, we'd end up with just a weaker version of
> I_VERSION_QUERIED that is that "I don't care about atime" case.
>=20

To be clear, this is not kernel-wide behavior. Most filesystems already
don't bump their i_version on atime updates. XFS is the only one that
does. ext4 used to do that too, but we fixed that several months ago.
I did try to just fix XFS in the same way, but the patch was NAK'ed.

> I really can't find any use that would *want* to see i_version updates
> for any atime updates. Ever.
>=20
> We may have had historical user interfaces for i_version, but I can't
> find any currently.
>=20
> But to be very very clear: I've only done some random grepping, and I
> may have missed something. I'm not dismissing Dave's worries, and he
> may well be entirely correct.
>=20
> Somebody would need to do a much more careful check than my "I can't
> find anything".

Exactly. I'm not really an XFS guy, so I took those folks at their word
that this was behavior that they just can't trivially change.

None of the in-kernel callers that look at i_version want it to be
incremented on atime-onlt updates, however. So IIRC, the objection was
due to offline repair/analysis tools that depend this the value being
incremented in a specific way.
--=20
Jeff Layton <jlayton@kernel.org>

