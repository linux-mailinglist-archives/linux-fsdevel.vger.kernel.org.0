Return-Path: <linux-fsdevel+bounces-39138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05776A10841
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 14:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E5B01882F5F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 13:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75D744360;
	Tue, 14 Jan 2025 13:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="SaSOrO7c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4349249625
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 13:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736863114; cv=none; b=bDRjMao7U/MUpUuz5qHMWSxF27x7JNaKbCOipQgMThRlUh8Kn1crz2OZRV3nwpk9JAL85Zxir+pTuc5MxCGRcwJWjxdUEITvk1P+k89wzsrlcW/VncyIgyja/JH2OHd0WFCoKuz1Vxk7YmSH7JvC2eSu9cRjvkdPBxzRj0TFrxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736863114; c=relaxed/simple;
	bh=KOWpwa76h2JS2Po6Ok32t2A85PJPiBQXO+UNFW1FIk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hCh9DIKvLtE10MpHupYdOnDQTDB4ynK6lTB5Q72qLsMVgybsrb3QWPEFKb7UuQWIjOc1Sbg58Ee2aacQKwcNqkGOMMEkoI7DTWpS2IKQX/D4Un9e8UGvwmPXxlnO8USebSWYGslI8yTTjLCAj09LDfqxEHOPaHki9G0uHZhtrtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=SaSOrO7c; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-108-26-156-113.bstnma.fios.verizon.net [108.26.156.113])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 50EDvpEY003344
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 08:57:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1736863079; bh=FX7CkqWHdHk5KIIlkT7tie2aBHCRixCTbmo2nECMnvw=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=SaSOrO7cRWw1h3p6+uyklT9mZFWGe7vTVj9CYj+RnZMLXdUNhfdapVj3FKpYptqJz
	 wS0LZx20hGICDNi4k7aJ9D4+DtHFBZN/41oc787FLRJh9o0zgOuMIHH0chK3S56TFc
	 hrkZ62LNVd/33UdAHlrY+VLOTevy3imVlAknnb3KXwFXzPqv83tYeEKjSsWcRP8Osq
	 AW67VcMuESI3NJpqJP+q4IlGo5w29+dT0BLjSWsu7LzsLqi4urHb304uIUtRk8gyLj
	 TlMHgxEZKyDRf7YNtEyahP+CIW/wnugei5ve3D+YjKGdUwkx+A4StgQDFviIJMOcVd
	 mnr+eYgHVuRzw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id BFCA215C0175; Tue, 14 Jan 2025 08:57:51 -0500 (EST)
Date: Tue, 14 Jan 2025 08:57:51 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Jan Kara <jack@suse.cz>,
        Kun Hu <huk23@m.fudan.edu.cn>, jlayton@redhat.com,
        adilger.kernel@dilger.ca, david@fromorbit.com, bfields@redhat.com,
        viro@zeniv.linux.org.uk, christian.brauner@ubuntu.com, hch@lst.de,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        brauner@kernel.org, linux-bcachefs@vger.kernel.org,
        syzkaller@googlegroups.com
Subject: Re: Bug: INFO_ task hung in lock_two_nondirectories
Message-ID: <20250114135751.GB1997324@mit.edu>
References: <42BD15B5-3C6C-437E-BF52-E22E6F200513@m.fudan.edu.cn>
 <gwgec4tknjmjel4e37myyichugheuba3sy7cxkdqqj2raaglf5@n7uttxolimpa>
 <ftg6ukiq5secljpfloximhor2mjvda7qssydeqky4zcv4dpxxw@jadua4pcalva>
 <CACT4Y+ZtHUhXpETW+x8FpNbvN=xtKGZ1sBUQDr3TtKM+=7-xcg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACT4Y+ZtHUhXpETW+x8FpNbvN=xtKGZ1sBUQDr3TtKM+=7-xcg@mail.gmail.com>

On Tue, Jan 14, 2025 at 10:07:03AM +0100, Dmitry Vyukov wrote:
> I suspect the bulk of the reports are coming from academia
> researchers. In lots of academia papers based on syzkaller I see "we
> also reported X bugs to the upstream kernel". Somehow there seems to
> be a preference to keep things secret before publication, so upstream
> syzbot integration is problematic. Though it is well possible to
> publish papers based on OSS work, these usually tend to be higher
> quality and have better evaluation.
> 
> I also don't fully understand the value of "we also reported X bugs to
> the upstream kernel" for research papers. There is little correlation
> with the quality/novelty of research.

Oh, that's easy.  Statements make it more likely that program
committee members will more likely accept the paper because it's "real
world impact".

And if you're an academic, it's publish or perish, because due to the
gamification of tenure track committees.  Apparently in some countries
the pressure is so huge that academics have started submit fake/sham
papers:

   The startling rise in the publication of sham science papers has
   its roots in China, where young doctors and scientists seeking
   promotion were required to have published scientific papers. Shadow
   organisations – known as “paper mills” – began to supply fabricated
   work for publication in journals there.

   The practice has since spread to India, Iran, Russia, former Soviet
   Union states and eastern Europe, with paper mills supplying
   fabricated studies to more and more journals as increasing numbers
   of young scientists try to boost their careers by claiming false
   research experience. In some cases, journal editors have been
   bribed to accept articles, while paper mills have managed to
   establish their own agents as guest editors who then allow reams of
   falsified work to be published.

   https://www.theguardian.com/science/2024/feb/03/the-situation-has-become-appalling-fake-scientific-papers-push-research-credibility-to-crisis-point

At least in this case it appears to be real syzkaller reports,
although if they were submitting sham papers to sham journals, they at
least wouldn't be wasting upstream kernel developers' time.  :-)

It would be *nice* if researchers at *least* checked to see if their
reports had already been discovered using an unmodified Syzkaller (for
example, by checking the upstream Syzbot web pages).  After all, if
the unmodified/upstream Syzkaller can find the problem, in addition to
wasting our time even more, it's *clearly* not a new/novel result.

	    	    	     	    		- Ted

P.S.  If you want to push back on this nonsense, Usenix program
committee chairs are very much looking for open source professionals
to participate on the program committees for Usenix ATC (Annual
Technical Conference) and FAST (File System and Storage Technologies)
conference.  It's a huge amount of work; easily 40-60 hours of work over
3-4 months.  But it does get you to see what academics are up to, and
it's a way to help point out bogus research, and to push back on
research groups using ancient kernels (typically whatever kernel was
current when the lead professor was a graduate student)....

If you're interested, I can put you in touch with some of those
Program Committee chairs when they are asking me to serve --- there's
more than enough opportunity to go around.  :-)


