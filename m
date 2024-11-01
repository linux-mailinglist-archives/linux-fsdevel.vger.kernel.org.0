Return-Path: <linux-fsdevel+bounces-33468-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B59E9B91BC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 14:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBC5FB23688
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 13:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC4E19C54A;
	Fri,  1 Nov 2024 13:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tOUVDSc5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483EF4594D
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Nov 2024 13:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730466961; cv=none; b=VYO41xi+ieTeBIvKtvW9WLQo+RJ2KDDF+0+hnbuTi8VHJLWdE9AyQXKZhlQjKikVoQTZtSUQ/MjI1BTUJDsAm93xXUWrgjGJ1Fmn00Gd+ht1sPdh0u6OmJXeeZanIMyc/r94JXWCfp/shgP23/9kW1nQ7+RUU9vf7iJ4fegf2nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730466961; c=relaxed/simple;
	bh=KKc8CzR0UBTPWSsRzGZJGoyUIoTOzFeV0tmrBDkFjAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YwJUf/Z/jBwoMvAPwDG6YgEYpSDxiqqpZ/UhjeuJECymLdJ3O5HVis2aUG5y2wzJjAFPqJ5X22WxY/lQll7hN+ETgWFxPFQn9I6lS0g0uYMSo8ga9edfNu3dQgG2d5cx6YqQp6GVLO39LP+10N/as6CfVVzsiPMRyPWW89hRL50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tOUVDSc5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08526C4CED6;
	Fri,  1 Nov 2024 13:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730466960;
	bh=KKc8CzR0UBTPWSsRzGZJGoyUIoTOzFeV0tmrBDkFjAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tOUVDSc5pgiUTZwnlX+icKAeXKT7wEZQHGJGBG8HCoh+WHhx/WQsoAxhZdUpidyn4
	 0vYlyEhuyvj+0WffzIWH32dQzYIXqqL3Beg+h9Z7T1eo7e4NDu0hZYlfztFZmNpvDG
	 3n9g6HLugwJi52Wp9w8YO6YYeReHcvFpDhFCWM2jvkCyO3kGd1fLUccr4I7K6MGnPT
	 0xRzSN3XBjV02gjG6mK9xv4MJWInsX6a6fs2CQx/yDuMFjLrgF6ysq09gJkZZz1GXK
	 TcasLQD2NaqmjEt710/lttuicFY+ArJk3fveMhoFAASljHYGiVQWDHWIyhhLsscQc/
	 VMw47oq+jShyA==
Date: Fri, 1 Nov 2024 14:15:57 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: generic_permission() optimization
Message-ID: <20241101-infekt-ehegatte-ea8857d68127@brauner>
References: <CAHk-=whJgRDtxTudTQ9HV8BFw5-bBsu+c8Ouwd_PrPqPB6_KEQ@mail.gmail.com>
 <20241031060507.GJ1350452@ZenIV>
 <CAHk-=wh-Bom_pGKK+-=6FAnJXNZapNnd334bVcEsK2FSFKthhg@mail.gmail.com>
 <CAHk-=wj16HKdgiBJyDnuHvTbiU-uROc3A26wdBnNSrMkde5u0w@mail.gmail.com>
 <20241031222837.GM1350452@ZenIV>
 <CAHk-=wisMQcFUC5F1_NNPm+nTfBo__P9MwQ5jcGAer7vjz+WzQ@mail.gmail.com>
 <CAHk-=wgXEoAOFRkDg+grxs+p1U+QjWXLixRGmYEfd=vG+OBuFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgXEoAOFRkDg+grxs+p1U+QjWXLixRGmYEfd=vG+OBuFw@mail.gmail.com>

On Thu, Oct 31, 2024 at 03:17:18PM -1000, Linus Torvalds wrote:
> On Thu, 31 Oct 2024 at 12:34, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > So I'd rather start with just the cheap inode-only "ACL is clearly not
> > there" check, and later if we find that the ACL_NOT_CACHED case is
> > problematic do we look at that.
> 
> Actually, if I switch the tests around so that I do the permission bit
> check first, it becomes very natural to just check IS_POSIXACL() at
> the end (where we're about to go to the slow case, which will be
> touching i_sb anyway).

Applied.

