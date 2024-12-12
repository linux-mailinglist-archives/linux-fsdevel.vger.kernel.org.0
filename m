Return-Path: <linux-fsdevel+bounces-37191-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC03F9EF0CE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 17:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CFEA29C930
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 16:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704A5242F13;
	Thu, 12 Dec 2024 16:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kU1tf2WL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF68A235C43;
	Thu, 12 Dec 2024 16:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734020385; cv=none; b=smTu/EqIlTc8S24QsA8FXVIHrU0oBK4qcNi47NhTm17j5xWZaweieu9ZgVG6J1T8fbDeIqsUQG4vVsELv/dBcNVi5nIYLyV4bq9YX1PCavJwNLGbboBeu6+XpfBYZtXcO28iuriJlItUfyg6kK0gu6lFVCdIw7yiUydP+3fqyR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734020385; c=relaxed/simple;
	bh=/q5SnzbhKG9ZsCMsrsu0W8Znp+/aEL+IeBbjU+HdMSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=msKC1lao92RTgU6a+TAYO21TmCxvj3khxutHhcvV+N4tUu+MlDzsqFXJmq6SYAbVLKdNmP0fMcc34umL4vvos3TKyYD0Pnm+NbHBNC66Q+2Vyf3/7FY42FKZuecxl9JsemV4LjlLIKzzl64lIALNf5UJfOA/27/eCsjsvH7FUiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kU1tf2WL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E8EC4CECE;
	Thu, 12 Dec 2024 16:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734020385;
	bh=/q5SnzbhKG9ZsCMsrsu0W8Znp+/aEL+IeBbjU+HdMSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kU1tf2WLMnVVcvH1xXjvMEQdRk2bTipJP4lECV/VE24BXmJpK5owN+t8kxdVek7WY
	 JLU2MWQStFICqPmvt+vriHeMwxyOF9elzNuy1GnPnJUdpRMsXYK0Ij/Q6OSeA8+S4M
	 +BgcyDmPINCcfj5zYkov032maKCwVbbA7v11MzkOsRxYgXY6wFyDop/v41RQJ55bU2
	 r1VTRlE2/kR80q31CKN0Wc1YKHpa5cRI+x8pLtw7CYwvjFudozC6POwbw3HFwavhBq
	 b9HZOz+vi8r7JnnxWa3PZriQqHumHdNQd8i8mIA1EwkPNRKN6UNbWSbmgcDOAI7RXj
	 IE9P7iZucTI1g==
Date: Thu, 12 Dec 2024 08:19:45 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	Ritesh Harjani <ritesh.list@gmail.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Andrey Albershteyn <aalbersh@kernel.org>,
	John Garry <john.g.garry@oracle.com>
Subject: Re: [RFC 3/3] xfs_io: add extsize command support
Message-ID: <20241212161945.GB6657@frogsfrogsfrogs>
References: <cover.1733902742.git.ojaswin@linux.ibm.com>
 <6448e3adc13eff8b152f7954c838eb9315c91574.1733902742.git.ojaswin@linux.ibm.com>
 <20241211181827.GC6678@frogsfrogsfrogs>
 <Z1rRQdKs/9lHT6P7@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1rRQdKs/9lHT6P7@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>

On Thu, Dec 12, 2024 at 05:34:17PM +0530, Ojaswin Mujoo wrote:
> On Wed, Dec 11, 2024 at 10:18:27AM -0800, Darrick J. Wong wrote:
> > On Wed, Dec 11, 2024 at 01:24:04PM +0530, Ojaswin Mujoo wrote:
> > > extsize command is currently only supported with XFS filesystem.
> > > Lift this restriction now that ext4 is also supporting extsize hints.
> > > 
> > > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > 
> > Seems pretty straightforward to me.  Are you planning to add an extsize
> > option to chattr?
> 
> Do you mean e2fsprogs? If so, then yes we'll add it there eventually
> however for now I only have xfs_io patches since I was working on them 
> to make the extsize xfstests work with ext4.

Yep, and good to know (about adding chattr support eventually).

--D

> Regards,
> ojaswin
> > 
> > Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> > 
> > --D
> > 
> > > ---
> > >  io/open.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/io/open.c b/io/open.c
> > > index a30dd89a1fd5..2582ff9b862e 100644
> > > --- a/io/open.c
> > > +++ b/io/open.c
> > > @@ -997,7 +997,7 @@ open_init(void)
> > >  	extsize_cmd.args = _("[-D | -R] [extsize]");
> > >  	extsize_cmd.argmin = 0;
> > >  	extsize_cmd.argmax = -1;
> > > -	extsize_cmd.flags = CMD_NOMAP_OK;
> > > +	extsize_cmd.flags = CMD_NOMAP_OK | CMD_FOREIGN_OK;
> > >  	extsize_cmd.oneline =
> > >  		_("get/set preferred extent size (in bytes) for the open file");
> > >  	extsize_cmd.help = extsize_help;
> > > -- 
> > > 2.43.5
> > > 
> > > 
> 

