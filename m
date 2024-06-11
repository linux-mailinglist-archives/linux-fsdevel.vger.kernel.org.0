Return-Path: <linux-fsdevel+bounces-21436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D45F4903CAD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 15:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FA1B2857EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 13:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3FB17C9E6;
	Tue, 11 Jun 2024 13:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OsdymXZt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103FA1E49E;
	Tue, 11 Jun 2024 13:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718111098; cv=none; b=YjraRxFMcgggJj86r5nFKqMfhEtx8h9dd9uAhNEZ1CqpPNgFiep5TGJowrDLIgy2DEpgDTbGXIHYzWcVoHvuNNxpmX35zUehngEFA4FJaJLhL538FVlfibCIhe8DFoYVO77AGakCBrokdBGRjMOaivFOSpHeV+5kkcmahUDJioU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718111098; c=relaxed/simple;
	bh=76BCTRyqFXDeGfhknZZgHm1a0wKEQG9KA+oh14PJzi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PsHu/dOUrlGw8DCEEwAhscdOL0SxME/4Szy083nCkCAfOUthBZ40A/4uy/41UW6bDkLaY+9wfTIuyvl1JJ+hgBv6oC0KukrQrYqWlnJrdwrPRy+z4yarBuhtxzAipQQif9YqDcyKZhwlK0aCu1VYnWT3Qv8+zpBclnNRU2ZT19g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OsdymXZt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF9F6C2BD10;
	Tue, 11 Jun 2024 13:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718111097;
	bh=76BCTRyqFXDeGfhknZZgHm1a0wKEQG9KA+oh14PJzi8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OsdymXZt/rgPWQil0J70ydCqqc4BUfDkyOiH0PZO8IBJze8JxeV9kBZMlKOs1z7JL
	 gZrMB5AM6bzTjfKkaUUy2DL1nlRuHS1TmLjqs/V5V6dRTlqdxgseupMMUHdBEMWKa1
	 4q8JmBsIYBO7J2T3n610ZSFCuaNM37uoZc1fUUcA6zrnZMdZknEocA6yYyWPIwkfMt
	 WsXrbIoqcgOO6kd/dUM1purmaWM4nxG1IWwUh4fEnlBAHeZPOJdWz8lmGigRdfh4gz
	 JUCU7QEWW4npBt351PbZdHDM1/gKliz+apBN0b8M2NlcYLQ0vWOCU0J9yBotEenCNz
	 cv1YTZxs7dF5A==
Date: Tue, 11 Jun 2024 15:04:52 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Jan Kara <jack@suse.cz>, viro@zeniv.linux.org.uk, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	josef@toxicpanda.com, hch@infradead.org
Subject: Re: [PATCH v3 1/2] vfs: add rcu-based find_inode variants for iget
 ops
Message-ID: <20240611-zwirn-zielbereich-9457b18177de@brauner>
References: <20240611101633.507101-1-mjguzik@gmail.com>
 <20240611101633.507101-2-mjguzik@gmail.com>
 <20240611105011.ofuqtmtdjddskbrt@quack3>
 <2aoxtcshqzrrqfvjs2xger5omq2fjkfifhkdjzvscrtybisca7@eoisrrcki2vw>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2aoxtcshqzrrqfvjs2xger5omq2fjkfifhkdjzvscrtybisca7@eoisrrcki2vw>

On Tue, Jun 11, 2024 at 01:40:37PM +0200, Mateusz Guzik wrote:
> On Tue, Jun 11, 2024 at 12:50:11PM +0200, Jan Kara wrote:
> > On Tue 11-06-24 12:16:31, Mateusz Guzik wrote:
> > > +/**
> > > + * ilookup5 - search for an inode in the inode cache
> >       ^^^ ilookup5_rcu
> > 
> 
> fixed in my branch
> 
> > > + * @sb:		super block of file system to search
> > > + * @hashval:	hash value (usually inode number) to search for
> > > + * @test:	callback used for comparisons between inodes
> > > + * @data:	opaque data pointer to pass to @test
> > > + *
> > > + * This is equivalent to ilookup5, except the @test callback must
> > > + * tolerate the inode not being stable, including being mid-teardown.
> > > + */
> > ...
> > > +struct inode *ilookup5_nowait_rcu(struct super_block *sb, unsigned long hashval,
> > > +		int (*test)(struct inode *, void *), void *data);
> > 
> > I'd prefer wrapping the above so that it fits into 80 columns.
> > 
> 
> the last comma is precisely at 80, but i can wrap it if you insist
> 
> > Otherwise feel free to add:
> > 
> > Reviewed-by: Jan Kara <jack@suse.cz>
> > 
> 
> thanks
> 
> I'm going to wait for more feedback, tweak the commit message to stress
> that this goes from 2 hash lock acquires to 1, maybe fix some typos and
> submit a v4.
> 
> past that if people want something faster they are welcome to implement
> or carry it over the finish line themselves.

I'm generally fine with this but I would think that we shouldn't add all
these helpers without any users. I'm not trying to make this a chicken
and egg problem though. Let's get the blessing from Josef to convert
btrfs to that *_rcu variant and then we can add that helper. Additional
helpers can follow as needed? @Jan, thoughts?

