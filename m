Return-Path: <linux-fsdevel+bounces-12722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 932F9862B6E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 17:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 331BF1F218EE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 16:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FDD179B2;
	Sun, 25 Feb 2024 16:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g1jWYfzZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE0D17984
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 Feb 2024 16:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708877351; cv=none; b=iAhxKNlRBg524EHImiLsSV5ImRxjPZjMV7Kwy2vOQ+LAH+j000VzVC0XmqcoOCUpXQgjtuRJRZ8Gno+e38d5o1tmguXqwNrdtTkY34CfoRYogxhm6nRPjFuli4Ol60+UlzEalKx7fSb4PNSRMHjvnz0YNQHr1XowWZceR/v49ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708877351; c=relaxed/simple;
	bh=bWVyG4ooUn4bG6bWqWfbJrqunJLdeEr0h0UomtvKp+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PtirGFqAiD8IdykHtcIqKsFwHEVnOpSfQy1X5rnkwCoA01CEhes9PYfADoehruGhkeH8la1fTHuPsJdLcnoyi+wWpXwVyR8WG5AU177l14ISX77jJBhThRQxMKbNVlR6+0euoxesSitKZgUfJvYut6Rd5nwkubrZUEmgj1Haj8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g1jWYfzZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708877348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4M+DNtT1zWFOoFWAPUy1ymTQkIScq55vkJSM4JvyW08=;
	b=g1jWYfzZzoR6EVZtrwwLdL6FO8/sRy8/qHrAdPpyvgofZnap84qu42UxJ0DFN8w2D1PF3B
	g6W0VlqXvpzKJx63/yhEpA9bNCDHT7Bln1maIlXMKGxkmRnmra/Ohik1Nt4p1J5BcTtPpY
	D/xmC0C6l6VSIVwgxvULoDMJOSQic7Y=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-nWGgw3sIMNywWoH2HsC3xA-1; Sun, 25 Feb 2024 11:09:06 -0500
X-MC-Unique: nWGgw3sIMNywWoH2HsC3xA-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6e4d20632c3so1093459b3a.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 Feb 2024 08:09:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708877345; x=1709482145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4M+DNtT1zWFOoFWAPUy1ymTQkIScq55vkJSM4JvyW08=;
        b=arACCGhaGaIf8OmJl4WF/wVNqEU6bhyq9Rt93iTegTTxnb/F86B1+GqlwONzQFxddu
         pRilzQxWQDZbKDwBkEHcZYBYKPIQn0FxmvqNW+kuvJwvYDmystPUHEa+TJ3fVQ7eJAzS
         91SMNAnvJ06MLJepiVYEHqQXiecmHdq2AOPHUUVYFhZgHL8ckLeEnRziNoujFsWsrkEK
         GqLaEcQgfRWRIAbrsTP+Vkq3SBGzM95GPcEL43lV8izs0I2EEsIyCpOJi52B0rX883jH
         EHKqJlj6fMNChmJHkrcCTk4rTVEw3KtbZ2XKMlA27XjoeEyEyvlMa6n+3c0LZfZlGZhD
         xHzQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6XSlMxIkNr/ks5i8eXM79U8HbrfytCJgyXOC1zQ7Vse/DosBk0xFXt2MJ8P0Fx//gP5YUHf7e4pdr/s44B5utwOXRUKrWbPYfuUWRFw==
X-Gm-Message-State: AOJu0YxoIuCOS6cB6ulJmMBn9nY/wgbo/cvogesezgfjQL+brcMDlZUu
	fYxda2FfXeWgr7eHLGcyjMesIrp10WSOCChluVxpWn7LqO6GFYjDWaaKBcIMdIxXRJsKuaN5+I3
	WeZ2HRgwNzVv9uZHCrbcK3XY+9s/7qeaDT0zgMdMEu6jrKh518gPnfFXl+AOvi20=
X-Received: by 2002:aa7:8693:0:b0:6e4:59b3:928c with SMTP id d19-20020aa78693000000b006e459b3928cmr3576542pfo.10.1708877345554;
        Sun, 25 Feb 2024 08:09:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELhdpuksSCkCVmptASRnZV0pLXZtX48KEkxUmfLHWYV0Z7mnKZWeD/8mPjgbAgBqUzUgyzRw==
X-Received: by 2002:aa7:8693:0:b0:6e4:59b3:928c with SMTP id d19-20020aa78693000000b006e459b3928cmr3576528pfo.10.1708877345170;
        Sun, 25 Feb 2024 08:09:05 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id f6-20020a056a00238600b006e0dd50b0d0sm2485386pfc.8.2024.02.25.08.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 08:09:04 -0800 (PST)
Date: Mon, 26 Feb 2024 00:08:59 +0800
From: Zorro Lang <zlang@redhat.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org,
	anand.jain@oracle.com, aalbersh@redhat.com, djwong@kernel.org,
	linux-fsdevel@vger.kernel.org, kdevops@lists.linux.dev,
	patches@lists.linux.dev
Subject: Re: [PATCH 2/3] check: add support for --list-group-tests
Message-ID: <20240225160859.tqbs2ltiqcj72ozj@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240216181859.788521-1-mcgrof@kernel.org>
 <20240216181859.788521-3-mcgrof@kernel.org>
 <ZdLNJD5pYaK84w3r@dread.disaster.area>
 <ZdYosXHe9ec04kBr@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdYosXHe9ec04kBr@bombadil.infradead.org>

On Wed, Feb 21, 2024 at 08:45:37AM -0800, Luis Chamberlain wrote:
> On Mon, Feb 19, 2024 at 02:38:12PM +1100, Dave Chinner wrote:
> > On Fri, Feb 16, 2024 at 10:18:58AM -0800, Luis Chamberlain wrote:
> > > Since the prior commit adds the ability to list groups but is used
> > > only when we use --start-after, let's add an option which leverages this
> > > to also allow us to easily query which tests are part of the groups
> > > specified.
> > > 
> > > This can be used for dynamic test configuration suites such as kdevops
> > > which may want to take advantage of this information to deterministically
> > > determine if a test falls part of a specific group.
> > > Demo:
> > > 
> > > root@demo-xfs-reflink /var/lib/xfstests # ./check --list-group-tests -g soak
> > > 
> > > generic/019 generic/388 generic/475 generic/476 generic/521 generic/522 generic/616 generic/617 generic/642 generic/648 generic/650 xfs/285 xfs/517 xfs/560 xfs/561 xfs/562 xfs/565 xfs/570 xfs/571 xfs/572 xfs/573 xfs/574 xfs/575 xfs/576 xfs/577 xfs/578 xfs/579 xfs/580 xfs/581 xfs/582 xfs/583 xfs/584 xfs/585 xfs/586 xfs/587 xfs/588 xfs/589 xfs/590 xfs/591 xfs/592 xfs/593 xfs/594 xfs/595 xfs/727 xfs/729 xfs/800
> > 
> > So how is this different to ./check -n -g soak?
> > 
> > '-n' is supposed to show you want tests are going to be run
> > without actually running them, so why can't you use that?
> 
> '-n' will replicate as if you are running all tests but just skip while
> --list-group-tests will just look for the tests for the group and bail right
> away, and it is machine readable.

What do you mean "replicate as if you are running all tests but just skip"?
Sorry I don't understand this explanation 100%, can you show us some examples
to explain what kind of job you hope "--list-group-tests" to do, but the "-n"
is helpless?

Thanks,
Zorro

> 
>   Luis
> 


