Return-Path: <linux-fsdevel+bounces-11833-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6226F857864
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 10:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E50AD1F286BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 09:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAB51BF53;
	Fri, 16 Feb 2024 09:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F+SZlmcA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B961BDD5
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Feb 2024 09:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708074221; cv=none; b=a8FImEqV1i3W8BuI41gwfMrkeRII/j9XHg+i7THP89yGxnNQbo1Z3lwEKBsYgKv9dGL8fsEC6nfBEKM7rs6G6vTB3DBDriqNc+Hz4wKB0I8UEuF1chgkbEtuunGkKxtFMe7F93qlQVphhjcQyW42doTlA0d3+s5TnffGuV5NYrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708074221; c=relaxed/simple;
	bh=ZZmNR1RQyZgQYNy7KMuqoWTZAUI0q4bYpQEL09wbr/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRPVMVf616ge2kf1moMbf5LfkP5z53FXtlApZw890jHC+JsX8aueDtDxhcNa82x7wzMGjVn40VILEqLLyioghoVXDiyQpdziMVl++QjGMpVzL9HXYVnB4a+zhKRIe0htM4scRWwIt4aGm/Xh744EXw3d+/p2MmC5vfxHTzx8i8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F+SZlmcA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708074218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l0t0U+TrlyzELsdu+pcbq8tjnR7+g1Se07mMCMUwE7g=;
	b=F+SZlmcAZleYs5yL1JPQRPZnFWRSmbtwoMXHl09Ry/tOklj9wEiKvUFVoXVkPMn/G9K9iA
	nJVM8VJ72d84Iw8pwAbbIBGjzQ7L2HxBNUKEvmKYF5h8Bk9ALz4rULfFatHAHfEhOlbYRX
	S+6c7tBJrqZs1Chg+3+azjcI+Xh68WI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-jSjhTTVmPqybpTwi-5tLNg-1; Fri, 16 Feb 2024 04:03:34 -0500
X-MC-Unique: jSjhTTVmPqybpTwi-5tLNg-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-563e6dd8d64so281699a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Feb 2024 01:03:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708074213; x=1708679013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0t0U+TrlyzELsdu+pcbq8tjnR7+g1Se07mMCMUwE7g=;
        b=mYVHOVtPtU9/O7oNKZAFJ5+F8gZgWLEM2EOcyK5i0pECsrQI+SOr06I8vkIv6fyDZj
         ToRCkaMAhgdNCgKY+doEARKAiwVG4r3I29CtD949ZFS9vCTm1/j/vf/RVthvziSqksxR
         NfSQMBXZJtNQr4NR35PpOdbpiDR2ti6xp0/o1ajN7AZmtseJ16Lf5AeHkHtp78nAoRCJ
         Px3xkHSFRj2OKsRrS1CWHvUguwOXX6CeR67l3JqcuKjvP2XPxL/c4v+K/dXrI3OMmePP
         /4lyYTwsAm6bpf5xENwvUj3O65mAezh7dVphpUGSAZpUs0dNtAib8PmnDFjzZSWag+Q/
         plbA==
X-Forwarded-Encrypted: i=1; AJvYcCV4pL+P9YWZ+BoQIpyrdzb8l5YdabtvyjcQlGN2TRd6DdZjQ4Msxe+ZRzcxAT6N4UyNxK2XxPp194TIFHzTOm8HoePB+VpDqBc+2LOl0w==
X-Gm-Message-State: AOJu0YxAEgXFcO03Y2Myy83Dp2D5HkS2RfOt71sakMl6XhwViSB5HqzL
	LTDU0apnPYTvWdbM1DIGNgTMnZk6RDisWoyb8CPDj9AdyE4zqdJOVCSLwlF0PDQw8lbSpBgR4Gc
	31CDE/qltCWh777mpKJ93sSs1tJqIvB8j+fIEJbJtH/hJ+oAj02bezsBdNA4wKQ==
X-Received: by 2002:a17:906:22d1:b0:a3d:64b3:7f5a with SMTP id q17-20020a17090622d100b00a3d64b37f5amr2465204eja.52.1708074213393;
        Fri, 16 Feb 2024 01:03:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmsSNAx1+TbQlNwu28mkAFyVIt52uWjGlLtUrIWKGXpAv5Da14jN0NIkotw8oyj18FxHVzkg==
X-Received: by 2002:a17:906:22d1:b0:a3d:64b3:7f5a with SMTP id q17-20020a17090622d100b00a3d64b37f5amr2465182eja.52.1708074212812;
        Fri, 16 Feb 2024 01:03:32 -0800 (PST)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id vx2-20020a170907a78200b00a3d9a94b13fsm1256749ejc.136.2024.02.16.01.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 01:03:32 -0800 (PST)
Date: Fri, 16 Feb 2024 10:03:31 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: fstests@vger.kernel.org, anand.jain@oracle.com, 
	linux-fsdevel@vger.kernel.org, kdevops@lists.linux.dev, patches@lists.linux.dev
Subject: Re: [PATCH v2 fstests] check: add support for --start-after
Message-ID: <avlvdgunqc4hf5p2gzrb22cptsybskifpejylpehzcofkpbkm3@mvnva74o4boy>
References: <20240216010803.164750-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216010803.164750-1-mcgrof@kernel.org>

On 2024-02-15 17:08:02, Luis Chamberlain wrote:
> Often times one is running a new test baseline we want to continue to
> start testing where we left off if the last test was a crash. To do
> this the first thing that occurred to me was to use the check.time
> file as an expunge file but that doesn't work so well if you crashed
> as the file turns out empty.
> 
> So instead add super simple argument --start-after which let's you
> skip all tests until the test infrastructure has "seen" the test
> you want to skip. This does obviously work best if you are not using
> a random order, but that is rather implied. If you do use a random
> order --start-after still works, the final output will however just
> be randomized of course, but it should let you skip a failed known
> crash at least. The real value to --start-after though is for when
> you use a non-randomized order.
> 
> If the target test is not found in your test list we complain and
> bail. This is not as obvious when you specify groups, so likewise
> we do a special check when you use groups to ensure the test is at
> least part of one group.
> 
> Demo:
> 
> root@demo-xfs-reflink /var/lib/xfstests # ./check -s xfs_reflink -n -g soak --start-after generic/025
> Start after test generic/025 not found in any group specified.
> Be sure you specify a test present in one of your test run groups if using --start-after.
> 
> Your set of groups have these tests:
> 
> generic/476 generic/521 generic/522 generic/616 generic/617 generic/642 generic/650
> 
> root@demo-xfs-reflink /var/lib/xfstests # ./check -s xfs_reflink -n -g soak --start-after generic/522
> SECTION       -- xfs_reflink
> RECREATING    -- xfs on /dev/loop16
> FSTYP         -- xfs (non-debug)
> PLATFORM      -- Linux/x86_64 demo-xfs-reflink 6.5.0-5-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.5.13-1 (2023-11-29)
> MKFS_OPTIONS  -- -f -f -m reflink=1,rmapbt=1, -i sparse=1, /dev/loop5
> MOUNT_OPTIONS -- /dev/loop5 /media/scratch
> 
> generic/616
> generic/617
> generic/642
> generic/650
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
> 
> Changes since v1:
> 
> This all addresses Anand Jain's feedback.
> 
>  - Skip tests completely which are not going to be run
>  - Sanity test to ensure the test is part of a group, if you listed
>    groups, and if not provide a useful output giving the list of all
>    tests in your group so you can know better which one is a valid test
>    to skip
>  - Sanity test to ensure the test you specified is valid
>  - Moves the trim during file processing now using a routine
>    trim_start_after()
> 
>  check | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/check b/check
> index 71b9fbd07522..1c76f33192ba 100755
> --- a/check
> +++ b/check
> @@ -18,6 +18,8 @@ showme=false
>  have_test_arg=false
>  randomize=false
>  exact_order=false
> +start_after=false
> +start_after_test=""
>  export here=`pwd`
>  xfile=""
>  subdir_xfile=""
> @@ -80,6 +82,7 @@ check options
>      -b			brief test summary
>      -R fmt[,fmt]	generate report in formats specified. Supported formats: xunit, xunit-quiet
>      --large-fs		optimise scratch device for large filesystems
> +    --start-after	only start testing after the test specified
>      -s section		run only specified section from config file
>      -S section		exclude the specified section from the config file
>      -L <n>		loop tests <n> times following a failure, measuring aggregate pass/fail metrics
> @@ -120,6 +123,8 @@ examples:
>   check -x stress xfs/*
>   check -X .exclude -g auto
>   check -E ~/.xfstests.exclude
> + check --start-after btrfs/010
> + check -n -g soak --start-after generic/522
>  '
>  	    exit 1
>  }
> @@ -204,6 +209,24 @@ trim_test_list()
>  	rm -f $tmp.grep
>  }
>  
> +# takes the list of tests to run in $tmp.list and skips all tests until
> +# the specified test is found. This will ensure the tests start after the
> +# test specified, it skips the test specified.
> +trim_start_after()
> +{
> +	local skip_test="$1"
> +	local starts_regexp=$(echo $skip_test | sed -e 's|\/|\\/|')
> +	local grep_start_after=" | awk 'f;/.*'$starts_regexp'/{f=1}'"

Looks like grep_start_after is not used
Otherwise, LGTM:
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>

-- 
- Andrey


