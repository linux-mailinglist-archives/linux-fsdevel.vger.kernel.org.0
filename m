Return-Path: <linux-fsdevel+bounces-11865-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5D28582C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 17:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C6421C21155
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 16:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7325E130AC9;
	Fri, 16 Feb 2024 16:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0YvxCAIK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D63C12F36A;
	Fri, 16 Feb 2024 16:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708101625; cv=none; b=iunBzwQZ6cP0zLC/gUyhXpA4jQNP3ecJk0iedFxXaZPBU9CPpajQB6O4QpgEfl/TUqNph7G+bHCBCydx6Bm20UBhExiI4RpLanlq8ISCXtUmHIpNAN2jTl6XaP82k0Igrd+qONOxTvo0apIkoy3YwkYqMaxXZgyyyHTEG6xwBN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708101625; c=relaxed/simple;
	bh=2fpSaUSpmNmZFejPzHSidGZ2KRLUi8JLJZRr4uGD0eM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pt12NxOpfPGmxFrorHF0uJoLqhpOyDgXSFcB5CiWZzkdF/L3pCJraVh5j+Ys7NoeHmCEiKEwEZbrMz+7nyTHICCcCLLsj1UdjC/M8gCbxszeulFsBNR8xfrfW3UQW7QBwuBKI9XwRb5/nQayFiBZNene1zUOIU4CRevCLdgTzwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0YvxCAIK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wKsTqNR6AtcCk0lTtaZMcMyccUl13BohQSF+nkXoPn0=; b=0YvxCAIKf89JEmy5lmXcvqvL3N
	g/cFYXDUHlfXg0GuPTW65E0cJUCYBhtQ46Zwl8U11yeGQ6kIUCRhU9/Nv5/TsW9vnpN1eb/f0T4Cf
	+5dq6gHVBrnwkRvRh9yQ2QwdXSiOp3r7OIyULjTLjVVPAmq/22QQuFfJ1lPTldZ0XVRytqWVhXg7r
	TS49wU9+aQQho33IPDmaECGmoJvHQ1YpiT/zit9dytM27GHaM05OXlfA6z6Qj5P2mtvNp3+RU/OVl
	DjsHzPokcn3zkByCpztDTxSNkkRSGjX5YstJ9KYPxtuauFmu/Pp6xEuTGrD9EJ0m9DRatTjud0DXx
	dpaao4Uw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rb1GB-000000031jo-2JX2;
	Fri, 16 Feb 2024 16:40:23 +0000
Date: Fri, 16 Feb 2024 08:40:23 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, aalbersh@redhat.com, chandan.babu@oracle.com,
	amir73il@gmail.com, djwong@kernel.org,
	linux-fsdevel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH] check: add support for --start-after
Message-ID: <Zc-P91LVKAZAgSwy@bombadil.infradead.org>
References: <20230907221030.3037715-1-mcgrof@kernel.org>
 <20230908052727.ccyxadtibouis74h@zlang-mailbox>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908052727.ccyxadtibouis74h@zlang-mailbox>
Sender: Luis Chamberlain <mcgrof@infradead.org>

Sorry for some reason I missed this.

On Fri, Sep 08, 2023 at 01:27:27PM +0800, Zorro Lang wrote:
> On Thu, Sep 07, 2023 at 03:10:30PM -0700, Luis Chamberlain wrote:
> > Often times one is running a new test baseline we want to continue to
> > start testing where we left off if the last test was a crash. To do
> > this the first thing that occurred to me was to use the check.time
> > file as an expunge file but that doesn't work so well if you crashed
> > as the file turns out empty.
> > 
> > So instead add super simple argument --start-after which let's you
> > skip all tests until the test infrastructure has "seen" the test
> > you want to skip. This does obviously work best if you are not using
> > a random order, but that is rather implied.
> > 
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > ---
> >  check | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> > 
> > diff --git a/check b/check
> > index 71b9fbd07522..1ecf07c1cb37 100755
> > --- a/check
> > +++ b/check
> > @@ -18,6 +18,8 @@ showme=false
> >  have_test_arg=false
> >  randomize=false
> >  exact_order=false
> > +start_after=false
> > +start_after_test=""
> >  export here=`pwd`
> >  xfile=""
> >  subdir_xfile=""
> > @@ -80,6 +82,7 @@ check options
> >      -b			brief test summary
> >      -R fmt[,fmt]	generate report in formats specified. Supported formats: xunit, xunit-quiet
> >      --large-fs		optimise scratch device for large filesystems
> > +    --start-after	only start testing after the test specified
> 
> This option conflicts with "-r" option.

I will add a check.

> >      -s section		run only specified section from config file
> >      -S section		exclude the specified section from the config file
> >      -L <n>		loop tests <n> times following a failure, measuring aggregate pass/fail metrics
> > @@ -313,6 +316,11 @@ while [ $# -gt 0 ]; do
> >  				<(sed "s/#.*$//" $xfile)
> >  		fi
> >  		;;
> > +	--start-after)
> > +		start_after=true
> > +		start_after_test="$2"
> 
> Do we really need two variables at here?

We can stick with one but we just need to use:

if [[ "$start_after_test != "" ]]

> 
> > +		shift
> > +		;;
> >  	-s)	RUN_SECTION="$RUN_SECTION $2"; shift ;;
> >  	-S)	EXCLUDE_SECTION="$EXCLUDE_SECTION $2"; shift ;;
> >  	-l)	diff="diff" ;;
> > @@ -591,6 +599,15 @@ _expunge_test()
> >  {
> >  	local TEST_ID="$1"
> >  
> > +	if $start_after; then
> > +		if [[ "$start_after_test" == ${TEST_ID}* ]]; then
> > +			start_after=false
> > +		fi
> > +		echo "       [skipped]"
> > +		return 0
> > +
> > +	fi
> 
> I can't understand how you use the --start-after. I though you'd like to remove
> all cases before the "start-after" from the running list. But when I saw here,
> I'm a little confused.

I hope the demo in the 2nd version of the patch helps. I'll send a v3.

  Luis

