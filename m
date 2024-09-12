Return-Path: <linux-fsdevel+bounces-29166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4481D976953
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 14:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEA6B1F245D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 12:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A1B1A4E89;
	Thu, 12 Sep 2024 12:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSXlP5+v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC0119E962;
	Thu, 12 Sep 2024 12:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726144987; cv=none; b=pyHrzXqDRvSL4uii+uUjWaJHwixGL3PWt3J1e1BbecQhgZiaFOAg9bvngGR/iVwqd8HOqed0pKAyxKZ2zzgrMLpFih5k7uVUr8ZxJbCs/LYX0eodKH73mzHmHKMM8ymcjx/oMJ9CmE+HuOc48IvjWm0c1QmEwVHoQqFbbFixEl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726144987; c=relaxed/simple;
	bh=VgxqEB5xRdGv/PMzmA6ig3YYUuVJHLkIf1/nT766Db8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q46CRKFHHmvpK1lpO+423uKdHrLO6/32VQkRv4PiZBqQ4xFKIvSxZ04m2OUQcu+32A2oncW9+nW6x41EoEWWDXI/zzUsKh2JjVGVez6EnEe1/2N74WmB/T6J391pIjBI0FSYydjF+S3juwUxgqnvTtb3kolqGIsUQYf6C5WfH3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZSXlP5+v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A94AC4CEC3;
	Thu, 12 Sep 2024 12:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726144986;
	bh=VgxqEB5xRdGv/PMzmA6ig3YYUuVJHLkIf1/nT766Db8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZSXlP5+vzgY4RfmG9bZ6o/uhf4j4Qcq6lOMdoEdFDOyaazqxqc83n6Hsp1ACDrugp
	 oKZ6uDbAORvtCiSvHIyfX+0RZyenijyyk/dA4z8eNDQS3RzOmbo2oOeRMG9gCmaSE9
	 8IAPSe3/9XKO+BWi0Q7snmY/e73iGv9oWjfKk6IzM6hC61MPS5wLNrZpGtulw6CGVG
	 VUYlGiWdUHgyz72pwnCAim/1NZ+ztpWvIJABisyYuF529jEgstD80BTiYxtQarRxKP
	 5Q9CBky1vszxnHeDbqZ+svV4zJkRIGzF4Q7Io3W0jlPW7TA/00Qd9I7DMHXQK5eQda
	 92OOVMsgA7IAQ==
Date: Thu, 12 Sep 2024 14:43:01 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] timekeeping: move multigrain ctime floor handling into
 timekeeper
Message-ID: <20240912-gaspreis-einmal-50609ecfcd2d@brauner>
References: <20240911-mgtime-v1-1-e4aedf1d0d15@kernel.org>
 <20240912-korallen-rasant-d612bd138207@brauner>
 <8de7cfc4958a739f3ce9dd3699a1a53fbb9dd074.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8de7cfc4958a739f3ce9dd3699a1a53fbb9dd074.camel@kernel.org>

On Thu, Sep 12, 2024 at 08:39:32AM GMT, Jeff Layton wrote:
> On Thu, 2024-09-12 at 14:31 +0200, Christian Brauner wrote:
> > On Wed, Sep 11, 2024 at 08:56:56AM GMT, Jeff Layton wrote:
> > > The kernel test robot reported a performance regression in some
> > > will-it-scale tests due to the multigrain timestamp patches. The data
> > > showed that coarse_ctime() was slowing down current_time(), which is
> > > called frequently in the I/O path.
> > > 
> > > Add ktime_get_coarse_real_ts64_with_floor(), which returns either the
> > > coarse time or the floor as a realtime value. This avoids some of the
> > > conversion overhead of coarse_ctime(), and recovers some of the
> > > performance in these tests.
> > > 
> > > The will-it-scale pipe1_threads microbenchmark shows these averages on
> > > my test rig:
> > > 
> > > 	v6.11-rc7:			83830660 (baseline)
> > > 	v6.11-rc7 + mgtime series:	77631748 (93% of baseline)
> > > 	v6.11-rc7 + mgtime + this:	81620228 (97% of baseline)
> > > 
> > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > Closes: https://lore.kernel.org/oe-lkp/202409091303.31b2b713-oliver.sang@intel.com
> > > Suggested-by: Arnd Bergmann <arnd@kernel.org>
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > > Arnd suggested moving this into the timekeeper when reviewing an earlier
> > > version of this series, and that turns out to be better for performance.
> > > 
> > > I'm not sure how this should go in (if acceptable). The multigrain
> > > timestamp patches that this would affect are in Christian's tree, so
> > > that may be best if the timekeeper maintainers are OK with this
> > > approach.
> > 
> > We will need this as otherwise we can't really merge the multigrain
> > timestamp work with known performance regressions?
> 
> Yes, I think we'll need something here. Arnd suggested an alternative
> way to do this that might be even better. I'm not 100% sure that it'll
> work though since the approach is a bit different.
> 
> I'd still like to see this go in for v6.12, so what I'd probably prefer
> is to take this patch initially (with the variable name change that
> John suggested), and then we can work on the alternative approach in
> the meantime
> 
> Would that be acceptable?

It would be ok with me but we should get a nodd from the time keeper folks.

