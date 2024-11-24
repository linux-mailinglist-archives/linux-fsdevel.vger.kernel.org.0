Return-Path: <linux-fsdevel+bounces-35738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAA09D7923
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 00:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8110B2166A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 23:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E6D17C220;
	Sun, 24 Nov 2024 23:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="vGfOvAtH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5B0F9F8;
	Sun, 24 Nov 2024 23:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732491514; cv=none; b=G/GVHC5g9XZRvcchhRWnRgJ6fIX0HHQ+sdEop8VLId/q7p69QbFLlbd2FQcd+4/IOAe/qqF3WU/QtTEizrRpCq4ryC4YWt0HUiT0q5r+oW5lYeYrPIQdvX23evqyjrkXrlym2m6v9h+bGd3W1jAaWqHg/nzGzKCliDZhxsKcd5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732491514; c=relaxed/simple;
	bh=46pt1LwJAI9ROlZ2qmARvK/oJzUUDN1RShpk7H8OMAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQ2k91ktZIqBNbcfUMga/S6hznz5NAX7FtsgDx595tgJxG/RfnVhkNuZ3sQaP9h0YUgGSesKYOOoD/EI4DaqaRqzFSeRyuKY7aQxWdj7m7445qPfBEu2YJ0Gs/AARb4SL/b5XDzUxwCU9zcwbVrR373gsPdmaVsMzo0vNbUFS14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=vGfOvAtH; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=hQpGXHofuyXCadOwcI6vhq8JseHMWJdwGGuZ+HibI/c=; b=vGfOvAtHkBLLixHmQhya+LDJXl
	zLR/z1RZGhIw4a39iF8UQ77Y0EO2spB6RwYfhpWorrLGdQI4brkmcpJ40JL14+Bi8hvccS2O1KgPE
	ttesZJXcgNBpHA50pkLwZ4gIxRjXJhJkQ03x79JIxFu+9Nf74zqTxF3EgBNotmyT09+kdq671rn65
	Q5rQpbStKf1gLpCt2IjlcuMQyw0VUF5/EBQMh1HcdA8ozN/RkYxvtB+20EL83RC+UFA4e6wJiiXR2
	rNLrSFO2CpxQXnwqCllmUA8saxFazcA42x2o5T6mOeQZXT+wBtbVI2A0a2iznE3eAkFxcq7B68umk
	aR+6pmZQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tFMBQ-00000001Ldq-191F;
	Sun, 24 Nov 2024 23:38:28 +0000
Date: Sun, 24 Nov 2024 23:38:28 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Hao-ran Zheng <zhenghaoran@buaa.edu.cn>, brauner@kernel.org,
	jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com,
	21371365@buaa.edu.cn
Subject: Re: [RFC] metadata updates vs. fetches (was Re: [PATCH v4] fs: Fix
 data race in inode_set_ctime_to_ts)
Message-ID: <20241124233828.GC3387508@ZenIV>
References: <61292055a11a3f80e3afd2ef6871416e3963b977.camel@kernel.org>
 <20241124094253.565643-1-zhenghaoran@buaa.edu.cn>
 <20241124174435.GB620578@frogsfrogsfrogs>
 <wxwj3mxb7xromjvy3vreqbme7tugvi7gfriyhtcznukiladeoj@o7drq3kvflfa>
 <20241124215014.GA3387508@ZenIV>
 <CAHk-=whYakCL3tws54vLjejwU3WvYVKVSpO1waXxA-vt72Kt5Q@mail.gmail.com>
 <CAGudoHEqDaY3=KuV9CuPja8UgVBhiZVZ7ej5r1yoSxRZaMnknA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHEqDaY3=KuV9CuPja8UgVBhiZVZ7ej5r1yoSxRZaMnknA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Nov 25, 2024 at 12:05:29AM +0100, Mateusz Guzik wrote:
> On Sun, Nov 24, 2024 at 11:10 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > So I mention the "rename and extend i_size_seqcount" as a solution
> > that I suspect might be acceptable if somebody has the motivation and
> > energy, but honestly I also think "nobody can be bothered" is
> > acceptable in practice.
> >
> 
> So happens recently the metadata ordeal also came up around getattr
> where a submitter wanted to lock the inode around it.

The posting Linus had been replying to:
https://lore.kernel.org/all/20241124215014.GA3387508@ZenIV/

> Until the day comes when someone has way too much time on their hands
> and patches it up (even that may encounter resistance though), I do
> think it would make sense to nicely write it down somewhere so for
> easy reference -- maybe as a comment above getattr and note around
> other places like the timespec helpers to read that.

See above.

For those who'd missed the getattr thread - the approach proposed and
NAKed there was to take ->i_rwsem (shared) in stat(2).  A non-starter
for obvious reasons, IMO.  Seqcount avoids those, but it would need to
be a pair of primitives used around the stores, with i_size_write()
*not* usable inside such scope.  Potential problems would be the
amount of time spent inside those scopes and amount of spinning it
would cause on the stat(2) side + the inode bloat.

All of that is modulo usefulness of such atomicity - nothing mentioned
so far seems to be a good reason to bother with all of that in the
first place...

