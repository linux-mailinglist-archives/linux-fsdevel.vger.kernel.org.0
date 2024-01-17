Return-Path: <linux-fsdevel+bounces-8137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F01682FFF8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 06:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 185F8286DD5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 05:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C678F47;
	Wed, 17 Jan 2024 05:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="lCTi0ygw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C998C06
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jan 2024 05:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705470941; cv=none; b=I8kqWFvPgGNkn4NVXWkZBT0DR/62qT3blZtePJ8o0Xw0Apr20rkZULN5CFi7dXIs1S6lvG/K3tjShCrK2pcIQfz63l6xnFF0s3s5hYE1g5aP5/0s5PNcI4qsabegdwl5Yj3sNDcGE2J7rYJ/bT+G3pKhXpUCO6b6VHH2h/XtHVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705470941; c=relaxed/simple;
	bh=Cajldxp5L4q+bgoRIKnlBgXzSAKMtR7sfecEvOfpwAs=;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tSLey+2fpJ692tv3d9I9suN6BqiqPxykg0T4GidDVBvzyoxNFv6m2ZlU0YrWku6vvK5VFwAbc5SKFwHzp98ZqEwM5Ia9Ea/Zy5UVi1EeX0Vx2OnZ0Gv5DsVZa9T6ILTvC/qHW+MiRdctYe6MS34skEF9Vd/Roy/19YwynEIHeOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=lCTi0ygw; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-112-211.bstnma.fios.verizon.net [173.48.112.211])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 40H5sv3E016205
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 00:54:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1705470901; bh=E6Z/eQkBMXHSee05+WcpGSIz4ByCJGYdInYrVxwiAVk=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=lCTi0ygwe47zegAHZboHFyqL3Sd5496YzTJRXwjVrME86O0SGElAaUC1FFlOL73QF
	 C2WX0qpUXggTBxcZrTHCnD+b7q4VV5CHVW5em+Tm3VCWP8B7y8bkMr2LrC/208YnUJ
	 HByA2MwQztUOiFI+Y6tkvXLd5nFtoNgFTt87OoxpVZkV3UK36kgNaakybCEELm8L8i
	 ebttMKfsy7qs+mqakIxV4DuOpAkRlnyigPymnoUORF2A14qORY0nwM8SDVW1yCjAoa
	 OpJdDQZzJl+nkzuj16Lllw4DAnHaUvhCIXyBUBfIGiSbC7khdXDosihq9XwXXDBsMJ
	 GNZLM844ywkxg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 89D5315C0278; Wed, 17 Jan 2024 00:54:57 -0500 (EST)
Date: Wed, 17 Jan 2024 00:54:57 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Greg KH <greg@kroah.com>, Mark Brown <broonie@kernel.org>,
        Neal Gompa <neal@gompa.dev>, Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Nikolai Kondrashov <spbnick@gmail.com>,
        Philip Li <philip.li@intel.com>, Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [GIT PULL] bcachefs updates for 6.8
Message-ID: <20240117055457.GL911245@mit.edu>
References: <xlynx7ydht5uixtbkrg6vgt7likpg5az76gsejfgluxkztukhf@eijjqp4uxnjk>
 <be2fa62f-f4d3-4b1c-984d-698088908ff3@sirena.org.uk>
 <gaxigrudck7pr3iltgn3fp5cdobt3ieqjwohrnkkmmv67fctla@atcpcc4kdr3o>
 <f8023872-662f-4c3f-9f9b-be73fd775e2c@sirena.org.uk>
 <olmilpnd7jb57yarny6poqnw6ysqfnv7vdkc27pqxefaipwbdd@4qtlfeh2jcri>
 <CAEg-Je8=RijGLavvYDvw3eOf+CtvQ_fqdLZ3DOZfoHKu34LOzQ@mail.gmail.com>
 <40bcbbe5-948e-4c92-8562-53e60fd9506d@sirena.org.uk>
 <2uh4sgj5mqqkuv7h7fjlpigwjurcxoo6mqxz7cjyzh4edvqdhv@h2y6ytnh37tj>
 <2024011532-mortician-region-8302@gregkh>
 <lr2wz4hos4pcavyrmswpvokiht5mmcww2e7eqyc2m7x5k6nbgf@6zwehwujgez3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lr2wz4hos4pcavyrmswpvokiht5mmcww2e7eqyc2m7x5k6nbgf@6zwehwujgez3>

On Tue, Jan 16, 2024 at 11:41:25PM -0500, Kent Overstreet wrote:
> > > No, it's a leadership/mentorship thing.
> > > 
> > > And this is something that's always been lacking in kernel culture.
> > > Witness the kind of general grousing that goes on at maintainer summits;
> > > maintainers complain about being overworked and people not stepping up
> > > to help with the grungy responsibilities, while simultaneously we still

     <blah blah blah>

> > > Tests and test infrastructure fall into the necessary but not fun
> > > category, so they languish.
> > 
> > No, they fall into the "no company wants to pay someone to do the work"
> > category, so it doesn't get done.
> > 
> > It's not a "leadership" issue, what is the "leadership" supposed to do
> > here, refuse to take any new changes unless someone ponys up and does
> > the infrastructure and testing work first?  That's not going to fly, for
> > valid reasons.

Greg is absolutely right about this.

> But good tools are important beacuse they affect the rate of everyday
> development; they're a multiplier on the money everone is spending on
> salaries.

Alas, companies don't see it that way.  They take the value that get
from Linux for granted, and they only care about the multipler effect
of their employees salaries (and sometimes not even that).  They most
certainly care about the salutary effects on the entire ecosyustem.
At least, I haven't seen any company make funding decisions on that
basis.

It's easy enough for you to blame "leadership", but the problem is the
leaders at the VP and SVP level who control the budgets, not the
leadership of the maintainers, who are overworked, and who often
invest in testing themselves, on their own personal time, because they
don't get adequate support from others.

It's also for that reason why we try to prove that people won't just
stick around enough for their pet feature (or in the case of ntfs,
their pet file system) gets into the kernel --- and then disappear.
For too often, this is what happens, either because they have their
itch scratched, or their company reassigns them to some other project
that is important for their company's bottom-line.

If that person is willing their own personal time, long after work
hours, to steward their contribution in the absence of corporate
support, great.  But we need to have that proven to us, or at the very
least, make sure the feature's long-term maintenace burden is as low
possible, to mitigate the likelihood that we won't see the new
engineer after their feature lands upstream.

> Having one common way of running all our functional VM tests, and a
> common collection of those tests would be a huge win for productivity
> because _way_ too many developers are still using slow ad hoc testing
> methods, and a good test runner (ktest) gets the edit/compile/test cycle
> down to < 1 minute, with the same tests framework for local development
> and automated testing in the big test cloud...

I'm going to call bullshit on this assertion.  The fact that we have
multiple ways of running our tests is not the reason why testing takes
a long time.

If you are going to run stress tests, which is critical for testing
real file systems, that's going to take at least an hour; more if you
want to test muliple file system features.  The full regression set
for ext4, using the common fstests testt suite, takes about 25 hours
of VM time; and about 2.5 hours of wall clock time since I shard it
across a dozen VM's.

Yes, w could try to add some unit tests which take much less time
running tests where fstests is creating a file system, mounting it,
exercising the code through userspace functions, and then unmounting
the file system and then checking the file system.  Even if that were
an adequate replacement for some of the existing fstests, (a) it's not
a replacement for stress testing, and (b) this would require a vast
amount of file system specific software engineering investment, and
where is that going from?

The bottom line is that problem is that having a one common way of
running our functional VM tests is not even *close* to root cause of
the problem.

	    	       	  	       - Ted

