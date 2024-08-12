Return-Path: <linux-fsdevel+bounces-25705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F1594F5CD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 19:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EC2B1F220A8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 17:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85CA189529;
	Mon, 12 Aug 2024 17:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="wBgHZx9m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch [185.125.25.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FF4187FEE
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 17:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723483685; cv=none; b=itXK46+dH2hegmljz7DNQ6vhKJHbwj8BPBYh5R1vFDU8R3xX/YhgdEvcU37iJ7UAvFNfhhgrXCW94f6EDv9WbgvlXLVkdnE/Xku4L1UGtY13vdMwPYKWfoYvITdOlju4ZFgwI25dhSdptk+dZhhfgcxJ3U7azy23S9wxeMh2YjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723483685; c=relaxed/simple;
	bh=CKc3b6exLQErC5hRcitRGhW8g1CQ1KFfDiPZ6Q2KZDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oS0nKqz+Zc7xC47StZJ9MuR8Kd6cEIINU5DjHU8xnTlRF/KgrzONibBKGSxjYjAGD6GXJyawDSHdZ3N9Z+sCMn4EHza+AcqgcnK0h4yOnXTJUtpmgYPS5N03P+Q6fuMHmg+74aabVJsAiXynKOSACHp+mZWIzuLAVLNL0Jo84T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=wBgHZx9m; arc=none smtp.client-ip=185.125.25.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WjM0w1r3yzRZZ;
	Mon, 12 Aug 2024 19:28:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1723483680;
	bh=XKWk/ou9xWXyXZf/+83XFP+2SHkLmUCIRL9GwmSi0ho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wBgHZx9mwNsybst5E8+VFldSlu+WZDbFIw9eRnd9XAdvklasRu+i5pT+FIacs5Go7
	 3pRp48jTWuZtV8x2p5mO+1i1V9TUNq4/WibP8MlWZq/MjWOkE36609GIvPoSAWGhus
	 G/iGuRjgbZ6FmP2WmUzPuySQ20Tt+UxLF+uyWBZk=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4WjM0t5Tp4z5Lg;
	Mon, 12 Aug 2024 19:27:58 +0200 (CEST)
Date: Mon, 12 Aug 2024 19:27:53 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>
Cc: Jann Horn <jannh@google.com>, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Casey Schaufler <casey@schaufler-ca.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>, gnoack@google.com, jmorris@namei.org, serge@hallyn.com, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: f_modown and LSM inconsistency (was [PATCH v2 1/4] Landlock: Add
 signal control)
Message-ID: <20240812.Fie3aCh2eiwi@digikod.net>
References: <CAG48ez34C2pv7qugcYHeZgp5P=hOLyk4p5RRgKwhU5OA4Dcnuw@mail.gmail.com>
 <20240809.eejeekoo4Quo@digikod.net>
 <CAG48ez2Cd3sjzv5rKT1YcMi1AzBxwN8r-jTbWy0Lv89iik-Y4Q@mail.gmail.com>
 <20240809.se0ha8tiuJai@digikod.net>
 <CAG48ez3HSE3WcvA6Yn9vZp_GzutLwAih-gyYM0QF5udRvefwxg@mail.gmail.com>
 <CAHC9VhQsTH4Q8uWfk=SLwQ0LWJDK5od9OdhQ2UBUzxBx+6O8Gg@mail.gmail.com>
 <CAG48ez1fVS=Hg0szXxQym9Yfw4Pgs1THeviXO7wLXbC2-YrLEg@mail.gmail.com>
 <CAHC9VhS6=s9o4niaLzkDG6Egir4WL=ieDdyeKk4qzQo1WFi=WQ@mail.gmail.com>
 <CAG48ez2tvHgv7sOVP14gCF1MAGE-UzJoMCfZqdmY1nXX4FFV4Q@mail.gmail.com>
 <CAHC9VhQY+H7n2zCn8ST0Vu672UA=_eiUikRDW2sUDSN3c=gVQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhQY+H7n2zCn8ST0Vu672UA=_eiUikRDW2sUDSN3c=gVQw@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Mon, Aug 12, 2024 at 12:30:03PM -0400, Paul Moore wrote:
> On Mon, Aug 12, 2024 at 11:06 AM Jann Horn <jannh@google.com> wrote:
> > On Mon, Aug 12, 2024 at 4:57 PM Paul Moore <paul@paul-moore.com> wrote:
> > > On Mon, Aug 12, 2024 at 9:09 AM Jann Horn <jannh@google.com> wrote:
> > > > On Mon, Aug 12, 2024 at 12:04 AM Paul Moore <paul@paul-moore.com> wrote:
> > >
> > > ...
> > >
> > > > > From a LSM perspective I suspect we are always going to need some sort
> > > > > of hook in the F_SETOWN code path as the LSM needs to potentially
> > > > > capture state/attributes/something-LSM-specific at that
> > > > > context/point-in-time.
> > > >
> > > > The only thing LSMs currently do there is capture state from
> > > > current->cred. So if the VFS takes care of capturing current->cred
> > > > there, we should be able to rip out all the file_set_fowner stuff.
> > > > Something like this (totally untested):
> > >
> > > I've very hesitant to drop the LSM hook from the F_SETOWN path both
> > > because it is reasonable that other LSMs may want to do other things
> > > here,
> >
> > What is an example for other things an LSM might want to do there? As
> > far as I understand, the whole point of this hook is to record the
> > identity of the sender of signals - are you talking about an LSM that
> > might not be storing credentials in struct cred, or something like
> > that?
> 
> Sure.  The LSM framework is intentionally very vague and limited on
> what restrictions it places on individual LSMs; we want to be able to
> support a wide range of security models and concepts.  I view the
> F_SETOWN hook are important because it is a control point that is used
> to set/copy/transfer/whatever security attributes from the current
> process to a file/fd for the purpose of managing signals on the fd.
> 
> > > and adding a LSM hook to the kernel, even if it is re-adding a
> > > hook that was previously removed, is a difficult and painful process
> > > with an uncertain outcome.
> >
> > Do you mean that even if the LSM hook ends up with zero users
> > remaining, you'd still want to keep it around in case it's needed
> > again later?
> 
> I want the security_file_set_fowner() hook to remain a viable hook for
> capturing the current task's security attributes, regardless of what
> security attributes the LSM is interested in capturing and where those
> attributes are stored.

I don't see the point to keep an unused hook, we could add it back later
if there is a valid use case, but I'll send a v2 without this removal.

