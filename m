Return-Path: <linux-fsdevel+bounces-8083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 438FD82F3D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 19:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F41B1C238DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 18:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765801D55E;
	Tue, 16 Jan 2024 18:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qEnfWUNm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0601D559
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jan 2024 18:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705428767; cv=none; b=YW96/XGhLiuRLs4KlewYppTU2XiRekmEFJzOyA4dOw/Bp5zN7DHkKJFnLc2GojmusE8V3dfpNY2P5/BI7GSwukWOnY6+FP9gstEBITHvlib774gEemp5YZ6If0u8/P7L3RwD7t4KfAu7ccjNm+vLRUoaKqhboO5XRGlxxU1sKMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705428767; c=relaxed/simple;
	bh=dqm+7C7+r/P/ZG+9at5ofCBUlCIeqrq9u0Xyvah7w4Q=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To; b=WhS2zO+IF7DNXDuTQrcm9HW+xw7eP2Xw3gEmcuXRx1/+hGtTM8wg+Wfk8x6SKH0SVQAtlm7bbXsy3mabuGHgBMMlgYU1qzVVJYDNzcpEjkTOgRUEACNU0Hcl9MaMsjFaiiiOxzJjaA7wkyuMjnAUYTFLPpK7I64kuUcQOi1lBNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qEnfWUNm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BAEDC433C7;
	Tue, 16 Jan 2024 18:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705428767;
	bh=dqm+7C7+r/P/ZG+9at5ofCBUlCIeqrq9u0Xyvah7w4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qEnfWUNmAgYHEu9FKy9sjM9TWoUlGLx8QPkNHyUcPHmbW55jQSM2IFbTIKd5MYdG+
	 fMktQ+6rt9lHFO7sKj/67wnmCeVufbQ5Ed2z5b1p0MsQTGeQpRWuDa9Yh2XV/2giMh
	 nDmCx/VWWFJmxzFquH8TaSfiGXyH8IOsndaMhwPr8mUTzdSFunv4PfzsNwjWdWCVLs
	 NeMKEcsv/8vTeckJt1JpZxehYwR9kKf4U5wWaTF+SoAUP38GB9Dbttf6d+al9/a1zV
	 j0/Ad33xgM6qaonION4zxgNi3ioF2KjmRuiY4cy6hJaXA2Xht+wlyu4IctX8Ugoegk
	 QA9VGQgO2Hk2Q==
Date: Tue, 16 Jan 2024 10:12:45 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Bart Van Assche <bvanassche@acm.org>, lsf-pc@lists.linux-foundation.org,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>, naohiro.aota@wdc.com,
	Matias =?iso-8859-1?Q?Bj=F8rling?= <Matias.Bjorling@wdc.com>,
	Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
	dlemoal@kernel.org, slava@dubeiko.com
Subject: Re: [LSF/MM/BPF TOPIC] : Current status of ZNS SSD support in file
 systems
Message-ID: <ZabHHby_VlvysDLc@google.com>
References: <20240115082236.151315-1-slava@dubeyko.com>
 <0ea56c32-c71b-4997-b1c7-6d9bbc49a1dd@acm.org>
 <8012184C-DF1F-421B-93CA-07B27C0B39C9@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8012184C-DF1F-421B-93CA-07B27C0B39C9@dubeyko.com>

On 01/16, Viacheslav Dubeyko wrote:
> 
> 
> > On Jan 16, 2024, at 5:58 AM, Bart Van Assche <bvanassche@acm.org> wrote:
> > 
> > On 1/15/24 00:22, Viacheslav Dubeyko wrote:
> >> POTENTIAL ATTENDEES:
> >> bcachefs - Kent Overstreet
> >> btrfs - Naohiro Aota
> >> ssdfs - Viacheslav Dubeyko
> >> WDC - Matias Bjørling
> >> Samsung - Javier González
> >> Anybody else would like to join the discussion?
> > 
> > Since F2FS has a mature zoned storage implementation, you may want to
> > include the F2FS maintainer.
> > 
> 
> Sure. Jaegeuk, would you like to join the discussion?

Not a new topic tho, I already shoot an invite request. Let's see.

> 
> Thanks,
> Slava.

