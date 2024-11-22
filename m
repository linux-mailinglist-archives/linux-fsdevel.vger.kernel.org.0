Return-Path: <linux-fsdevel+bounces-35544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4B39D59A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 07:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4B10B2195A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 06:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BA617C992;
	Fri, 22 Nov 2024 06:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UdvEOMQ/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40C4178CEC
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 06:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732258309; cv=none; b=ECbQJsXjJsfRdR8odP895Dip19nHSe58pOAaFBfVRF9GDP5AUD1l6cGCtJ2c6ysn8QVE5tn/wisXvUbBsdU2OwupGzX1aImSVIoGdJ8fz58+YViWrui72+97OxsbfMCkvxAl+fbqjeVL45bT1+ocRTl7oKMNiZmx4tjm/au7CP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732258309; c=relaxed/simple;
	bh=FksEp9kapCY4+YbOqxOtRfRJLC2TEUlIdnGiXK6I00c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JbuyMAkVheh5gBaqwlFatrjJij7VKZTyfT0e72g5ou03IVK8kebqxijPxmlKMuNeYgcuS5eDT7uPC6BoToESdvqwDHdI1fwgi4JCMbWdA0NgDlf3QPCF8uZCHORk55wjKbWpVdpu/SRR0xk5aKvC6tkbKIuSLOdNgIpLufKbiq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UdvEOMQ/; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 22 Nov 2024 01:51:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732258305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rjgj1cBWl/+Hfb4W6G3LBJubD6GGLHSB/5rnaF15CvM=;
	b=UdvEOMQ/ljA52aWMaj+kjBRg6rsV/9XN0YFltdXsWPGJxpTRb2F4HQUsQ6IlSBuFwfYcC3
	jGx3uzQPKE2eIHvlo1ySZkNWszETq6lZ5yw4X1MiSCVbF5ZLe50pmGkzrCXVHwVLzBs1xE
	ypy3uUPd8Wh2Tk8EEv4jpxiVGBl24fI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Christoph Hellwig <hch@lst.de>, Theodore Ts'o <tytso@mit.edu>, 
	Michal Hocko <mhocko@suse.com>, Dave Chinner <david@fromorbit.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Yafang Shao <laoar.shao@gmail.com>, jack@suse.cz, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-bcachefs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "conduct@kernel.org" <conduct@kernel.org>
Subject: Re: [PATCH 1/2 v2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
Message-ID: <grcqflezvbht4mqyaalavqoneqgo2yfnmbdhbizrllv27dlgrl@jq3reem4va7i>
References: <vvulqfvftctokjzy3ookgmx2ja73uuekvby3xcc2quvptudw7e@7qj4gyaw2zfo>
 <71b51954-15ba-4e73-baea-584463d43a5c@linuxfoundation.org>
 <cl6nyxgqccx7xfmrohy56h3k5gnvtdin5azgscrsclkp6c3ko7@hg6wt2zdqkd3>
 <9efc2edf-c6d6-494d-b1bf-64883298150a@linuxfoundation.org>
 <be7f4c32-413e-4154-abe3-8b87047b5faa@linuxfoundation.org>
 <nu6cezr5ilc6vm65l33hrsz5tyjg5yu6n22tteqvx6fewjxqgq@biklf3aqlook>
 <v2ur4jcqvjc4cqdbllij5gh6inlsxp3vmyswyhhjiv6m6nerxq@mrekyulqghv2>
 <20241120234759.GA3707860@mit.edu>
 <20241121042558.GA20176@lst.de>
 <39e8f416-d136-4307-989a-361bf729e688@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39e8f416-d136-4307-989a-361bf729e688@linuxfoundation.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Nov 21, 2024 at 04:53:48PM -0700, Shuah Khan wrote:
> On 11/20/24 21:25, Christoph Hellwig wrote:
> > On Wed, Nov 20, 2024 at 03:47:59PM -0800, Theodore Ts'o wrote:
> > > On Wed, Nov 20, 2024 at 05:55:03PM -0500, Kent Overstreet wrote:
> > > > Shuah, would you be willing to entertain the notion of modifying your...
> > > 
> > > Kent, I'd like to gently remind you that Shuah is not speaking in her
> > > personal capacity, but as a representative of the Code of Conduct
> > > Committee[1], as she has noted in her signature.  The Code of Conduct
> > > Committee is appointed by, and reports to, the TAB[2], which is an
> > > elected body composed of kernel developers and maintainers.
> > 
> > FYI, without taking any stance on the issue under debate here, I find the
> > language used by Shuah on behalf of the Code of Conduct committee
> > extremely patronising and passive aggressive.  This might be because I
> > do not have an American academic class background, but I would suggest
> > that the code of conduct committee should educate itself about
> > communicating without projecting this implicit cultural and class bias
> > so blatantly.
> 
> I tend to use formal style when I speak on behalf of the Code of Conduct
> committee. I would label it as very formal bordering on pedantic.
> Would you prefer less formal style in the CoC communication?

Personally, it's always easier to take requests from a human, than a
faceless process that I have no input into.

I'll always rebell against the latter, but I'll always work to help out
or make things right with people in the community.

