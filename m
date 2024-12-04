Return-Path: <linux-fsdevel+bounces-36414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C5D9E38A4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 12:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F9971616B8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 11:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD191AF0BC;
	Wed,  4 Dec 2024 11:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vrjv283z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E5519006B
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Dec 2024 11:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733311190; cv=none; b=qYXKyISNFxi64SjKlHjr4G+SiQAl3KwKNRWoQtk5Q6pXjh3ka9uJLzJDy+oZSBV09nK2HfjCJBQXOsbBm9iQL43oltaVNBmkTREQrch4J0aRJJUDJ3p8USwreGx2sMTvHTwYIMzq1+bG4mbsSWJjWWB37dvmZNU5cJxneiEHeLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733311190; c=relaxed/simple;
	bh=Dy9jX/ekcwKeZbizZwtndRd1MCXDW4M0S/Q2CHGD4CE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/efmmY4XkB9uMKXTW0SRNSC5QNxVQGVcbUXr62Q+tVyFdfYJEVGfyhOclKQiBXL7h3UCS02PIL87wuAaxE/nYLT+qoTmNYatXca5+rV7z8/T1xoIaBjgWQEfh2ocLRtKqEMozu2GatV6yUzeFGRIGjeBdN1t0SI45dX/sziotU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vrjv283z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 874D9C4CED1;
	Wed,  4 Dec 2024 11:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733311190;
	bh=Dy9jX/ekcwKeZbizZwtndRd1MCXDW4M0S/Q2CHGD4CE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vrjv283z++9Y+yWP6ID9NgixEzF/jNbigEyse9Gp1Vxym9OiYGwyOzSjTtj4SNUee
	 gBc0Arwrd/KAwvLoOKLY0+9jFyKsnCFOgg/uNB3B+kwStyWBggbcWPq+t3Yx8EfxTF
	 VaWHQpjzbVuQxdf2GOjrFc3tVDUOvHTdWqcc2xIB+f2rI+9OcZtffOosFsdsb6YzFJ
	 r7nPnKn3/g6rOgISl2YUX75f/l5KBPMRkcMW4x+FAU3s8RD1xQAgn7i9oPrd+8qNqb
	 jVwijKJVKYA7T4eLpCFGPxbTVt70BShEqpwz6i5QozrWLjXX47ntkCASVcxcW8Qcb5
	 k451O7lK4cKhQ==
Date: Wed, 4 Dec 2024 12:19:45 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: don't block write during exec on pre-content watched
 files
Message-ID: <20241204-poliklinisch-angreifbar-fb74926133ac@brauner>
References: <20241128142532.465176-1-amir73il@gmail.com>
 <20241203172440.hjmwhfg6b3uiuxaz@quack3>
 <20241204-felswand-filmverleih-b5a694ca46a4@brauner>
 <locrapgjuqnmkhhduydix2geekh5qe7eq2roiv5hmancbl2y53@zz75zx5w53cs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <locrapgjuqnmkhhduydix2geekh5qe7eq2roiv5hmancbl2y53@zz75zx5w53cs>

On Wed, Dec 04, 2024 at 12:06:54PM +0100, Mateusz Guzik wrote:
> On Wed, Dec 04, 2024 at 11:56:39AM +0100, Christian Brauner wrote:
> > Only one question: The FMODE_FSNOTIFY_HSM(exe_file->f_mode) cannot
> > change once it's set, right?
> > 
> > The reason I'm asking is that we don't want to end up in a scenario
> > where we didn't block writecount in exe_file_deny_write_access() but
> > then unblock someone else's writecount in exe_file_allow_write_access().
> > 
> 
> What's what I brought up, turns out its fine and the code will get a
> comment to that extent.
> 
> see https://lore.kernel.org/linux-fsdevel/CAGudoHGzfjpukQ1QbuH=0Fot2vAWyrez-aVdO5Fum+330v-hmA@mail.gmail.com/

Thank you! Then it seems we're good to go.

