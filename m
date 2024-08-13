Return-Path: <linux-fsdevel+bounces-25787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4C69505D0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 15:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5A391F266C7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 13:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715081993AD;
	Tue, 13 Aug 2024 13:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ngb4R8OK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11B74C8C
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2024 13:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723554105; cv=none; b=mA6q6VMzta8VPk9Z9Y8wsQ3/4Oaw6STurf0pcaqjmuoE0swuPdNyeO53D7HymoBunF2DWf2R1UuTV+qhTABZRb1QBt/zsXi6OsR2t40CD6hLD4aSRiWLIy7NDQ+ApiNl2cOwWA2dxaSIZBy+WuvYISHl7mD0AUqUH6xKvFgFvQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723554105; c=relaxed/simple;
	bh=AHC5ohfHleud5Buz2l+yMvibH622W2iQCUvTnDPzn5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IEF8nkvrc50HRbs8FX+lD7PkTv66WE+gRApcX+ldwyMPP1YjFVfXdy/spUlzCuQUkqLIYWvjouL+qk5abVbaDsk4DG9HtfdUqL06EJGLGPnqqYc6uHCxLpTWfL5fjQva13X3XS3Yf5REro5axUuBY7osXOemLKC/bazy9ckaLzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ngb4R8OK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC45C4AF0B;
	Tue, 13 Aug 2024 13:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723554105;
	bh=AHC5ohfHleud5Buz2l+yMvibH622W2iQCUvTnDPzn5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ngb4R8OKYWrfvL2fekxTCt7UDS4U7jRT20UAvS4RlKViLQevS3S5my77mW/shWv47
	 uiPQHnia7OSujyLLrA/ZRsF5wI+LdLx9Pzhr15CYY50wd6/6YLjDWvjUX0xZ7LdR6z
	 7YK+lLOglmiU1I/Mto8EF1lnRLEdGvFULxVcfd4T0XPOFOwdbp5AAVEUfmmGibCiXx
	 8M4jZh0QScKWpogIqVlE/wxy21CmqmS401FzkE+W4UNZ70PUevveMFuBjpkzKL9zFL
	 NYx7grgVBBPEmSPkMqkYnIFrHp9E3fw4Hh9gWq0nzq76KLcp3g4pNodDNdSdy6yYLc
	 Cn0z2bqVqKRgg==
Date: Tue, 13 Aug 2024 15:01:40 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v2] file: reclaim 24 bytes from f_owner
Message-ID: <20240813-manchmal-jegliche-aecdc0f08b3e@brauner>
References: <20240813-work-f_owner-v2-1-4e9343a79f9f@kernel.org>
 <CAGudoHEdUfP8MJFLK6Pt6tnrGqQqKfi1sSa0G05W=7yyJoBPiA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHEdUfP8MJFLK6Pt6tnrGqQqKfi1sSa0G05W=7yyJoBPiA@mail.gmail.com>

On Tue, Aug 13, 2024 at 02:42:11PM GMT, Mateusz Guzik wrote:
> On Tue, Aug 13, 2024 at 2:31 PM Christian Brauner <brauner@kernel.org> wrote:
> > -int send_sigurg(struct fown_struct *fown)
> > +int send_sigurg(struct file *file)
> >  {
> > +       struct fown_struct *fown;
> >         struct task_struct *p;
> >         enum pid_type type;
> >         struct pid *pid;
> >         unsigned long flags;
> >         int ret = 0;
> >
> > +       fown = file_f_owner(file);
> > +       if (fown)
> > +               return 0;
> > +
> 
> if (!fown) ?

Bah, I had fixed that in-tree. Thanks!

