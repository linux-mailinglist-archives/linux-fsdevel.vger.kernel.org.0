Return-Path: <linux-fsdevel+bounces-44371-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 608D0A67F7D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 23:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE494886203
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 22:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD66D206F17;
	Tue, 18 Mar 2025 22:12:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938F72063FE
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Mar 2025 22:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742335924; cv=none; b=ZDyxX/650ForvCmkk9pd5jbQpSYDGqDF0SYl8tnnIHL2l+eE+E3m7jfhCbwzSvPLTkRXhxmbjizbKiHZ6l0VaEoyLfIyyyRNOOlEDU3i9J+YaoW2n0y1KD70yPiw3J8J2kIvYvUJVtZatqnSajMdApr7S66wdScn4ZxKI73O2cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742335924; c=relaxed/simple;
	bh=9d3EbaMoYysDxaknxbHqaz2DgcYC2l3wa8cV1wVoKeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c9CoMvygdn2m8GS8osP82CiQbmLxyC9YJSTX1pm6x37F8II4BnHGsLVxjbi/cnDNpPMFEq6SDPuySIb7zXKs7G0IVBNcBXY9VedP7qJzcYdP5kJSkXtvkXQR2ShH3jARjmGBCrbnhm8PJpjE6WDeB3zKFq98ASlUHHGLsgS+kuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-222.bstnma.fios.verizon.net [173.48.82.222])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52IMBSSr025381
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 18:11:29 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 284D02E010B; Tue, 18 Mar 2025 18:11:28 -0400 (EDT)
Date: Tue, 18 Mar 2025 18:11:28 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Demi Marie Obenour <demi@invisiblethingslab.com>
Cc: Dave Chinner <david@fromorbit.com>, cve@kernel.org, gnoack@google.com,
        gregkh@linuxfoundation.org, kent.overstreet@linux.dev,
        linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, mic@digikod.net,
        Demi Marie Obenour <demiobenour@gmail.com>
Subject: Re: Unprivileged filesystem mounts
Message-ID: <20250318221128.GA1040959@mit.edu>
References: <Z8948cR5aka4Cc5g@dread.disaster.area>
 <20250311021957.2887-1-demi@invisiblethingslab.com>
 <Z8_Q4nOR5X3iZq3j@dread.disaster.area>
 <Z9CYzjpQUH8Bn4AL@itl-email>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9CYzjpQUH8Bn4AL@itl-email>

On Tue, Mar 11, 2025 at 04:10:42PM -0400, Demi Marie Obenour wrote:
> 
> Why is it not possible to provide that guarantee?  I'm not concerned
> about infinite loops or deadlocks.  Is there a reason it is not possible
> to prevent memory corruption?

Companies and users are willing to pay to improve performance for file
systems.  q(For example, we have been working for Cloud services that
are interested in improving the performance of their first party
database products using the fact with cloud emulated block devices, we
can guarantee that 16k write won't be torn, and this can resul;t in
significant database performance.)

However, I have *yet* to see any company willing to invest in
hardening file systems against maliciously modified file system
images.  We can debate how much it might cost it to harden a file
system, but given how much companies are willing to pay --- zero ---
it's mostly an academic question.

In addition, if someone made a file system which is guaranteed to be
safe, but it had massive performance regressions relative other file
systems --- it's unclear how many users or system administrators would
use it.  And we've seen that --- there are known mitigations for CPU
cache attacks which are so expensive, that companies or end users have
chosen not to enable them.  Yes, there are some security folks who
believe that security is the most important thing, uber alles.
Unfortunately, those people tend not to be the ones writing the checks
or authorizing hiring budgets.

That being said, if someone asked me if it was best way to invest
software development dollars --- I'd say no.  Don't get me wrong, if
someone were to give me some minions tasked to harden ext4, I know how
I could keep them busy and productive.  But a more cost effective way
of addressing the "untrusted file sytem problem" would be:

(a) Run a forced fsck to check the file system for inconsistency
before letting the file system be mounted.

(b) Mount the file system in a virtual machine, and then make it
available to the host using something like 9pfs.  9pfs is very simple
file system which is easy to validate, and it's a strategy used by
gVisor's file system gopher.

These two approaches are complementary, with (a) being easier, and (b)
probably a bit more robust from a security perspective, but it a bit
more work --- with both providing a layered approach.

> > In this situation, the choice of what to do *must* fall to the user,
> > but the argument for "filesystem corruption is a CVE-worthy bug" is
> > that the choice has been taken away from the user. That's what I'm
> > saying needs to change - the choice needs to be returned to the
> > user...

Users can alwayus do stupid things.  For example, they could download
a random binary from the web, then execute it.  We've seen very
popular software which is instaled via "curl <URL> | bash".  Should we
therefore call bash be a CVE-vulnerability?

Realistically, this is probably a far bigger vulnerability if we're
talking about stupid user tricks.  ("But.... but... but... users need
to be able to install software" --- we can't stop them from piping the
output of curl into bash.)  Which is another reason why I don't really
blame the VP's that are making funding decisions; it's not clear that
the ROI of funding file system security hardening is the best way to
spend a company's dollars.  Remember, Zuckerburg has been quoted as
saying that he's laying off engineers so his company can buy more
GPU's, we know that funding is not infinite.  Every company is making
ROI decisions; you might not agree with the decisions, but trust me,
they're making them.

But if some company would like to invest software engineering effort
in addition features or perform security hardening --- they should
contact me, and I'd be happy to chat.  We have weekly ext4 video
conference calls, and I'm happy to collaborate with companies have a
business interest in seeing some feature get pursued.  There *have*
been some that are security related --- fscrypt and fsverity were both
implemented for ext4 first, in support of Android and ChromeOS's
security use cases.  But in practice this has been the exception, and
not the rule.

> Not automounting filesystems on hotplug is a _part_ of the solution.
> It cannot be the _entire_ solution.  Users sometimes need to be able to
> interact with untrusted filesystem images with a reasonable speed.

Running fsck on a file system *before* automounting file systems would
be a pretty decent start towards a solution.  Is it perfect?  No.  But
it would provide a huge amount of protection.

Note that this won't help if you have a malicious hardware that
*pretends* to be a USB storage device, but which doens't behave a like
a honest storage device.  For example, reading a particular sector
with one data at time T, and a different data at time T+X, with no
intervening writes.  There is no real defense to this attack, since
there is no way that you can authentiate the external storage device;
you could have a registry of USB vendor and model id's, but a device
can always lie about its id numbers.

If you are worried about this kind of attack, the only thing you can
do is to prevent external USB devices from being attached.  This *is*
something that you can do with Chrome and Android enterprise security
policies, and, I've talked to a bank's senior I/T leader that chose to
put epoxy in their desktop, to mitigate aginst a whole *class* of USB
security attacks.

Like everything else, security and usability and performance and costs
are all engineering tradeoffs.  So what works for one use case and
threat model won't be optimal for another, just as fscrypt works well
for Android and ChromeOS, but it doesn't necessarily work well for
other use cases (where I might recommed dm-crypt instead).

Cheers,

					- Ted


