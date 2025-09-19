Return-Path: <linux-fsdevel+bounces-62197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28756B87E31
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 07:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD2EC1B287F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 05:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119B426E6F7;
	Fri, 19 Sep 2025 05:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="p6KZRzRi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594A223958C
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 05:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758258409; cv=none; b=NHrPgggUME8dmEhaJqHPOR1sQx0zF55/rkyibYJjijvsFDdFVJcPXrbTv/k5nOS3K+6Jj/bwDFQkfPFZOHUvKPk9nWlcpL7Rj3/5HELl/SdXmiCxLGrPYqTvh3FG7ilfTLnjehf1R+FBILXa4a/LQG/HTdqiXRUYYlqIs9uAZRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758258409; c=relaxed/simple;
	bh=4Oet7IJdgQOZjAS1fulNpokOsnBFwnyLhmecGcXAzzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ciyj6sXuxSRhCZDqX3zEPiAZVq7gjLVHgHJv33YPsVCa90QfiZtC9mcTegsGNG/X6mWpmhLp6hLirVvoJhyJWLmfBGZTou/gFTOuGqqUpvsLtjEIH6Qt3zdHjAuqxiZqktAiZoIOJ+2J4PfmUDue9TIMZVwJsbycNh53NPdHKKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=p6KZRzRi; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yi6AX3ynKuHOwGYc/r0VoNKCmK6aamDJHFP9hiEmb30=; b=p6KZRzRi1jUoQ3vE7HqtFEEsd8
	skYdlNM0kWUwSCkbky+7CwHYja9lKCPlMmndZXTnLv9js5nRSaNH/4ewj/t73TdtWU2ZLf3sShNGw
	mNVzBeU6nzf6K6a0rfrsZzoHlHKkgTn3XMdcnGnjGaeoJAwOMG816exb5wkYECHZjvqZsUYKkJAdX
	yq00kX9pq0qKiebYaeenwMHBf+zbUEemts8sTRiEMJOiK+LFrbNA4uvEYISxc0FC+wE6gIDGDL2kk
	i/7LyFOstoU1ZUxog4tGcZQrviprnNDnpApCXazhGw7vFib4H1heFNsP0uRAxlD90OjprcxdYKWWr
	0ag/OvAg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzTKV-0000000E459-133u;
	Fri, 19 Sep 2025 05:06:43 +0000
Date: Fri, 19 Sep 2025 06:06:43 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 6/6] debugfs: rename start_creating() to
 debugfs_start_creating()
Message-ID: <20250919050643.GI39973@ZenIV>
References: <20250915021504.2632889-1-neilb@ownmail.net>
 <20250915021504.2632889-7-neilb@ownmail.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915021504.2632889-7-neilb@ownmail.net>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Sep 15, 2025 at 12:13:46PM +1000, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
> 
> start_creating() is a generic name which I would like to use for a
> function similar to simple_start_creating(), only not quite so simple.
> 
> debugfs is using this name which, though static, will cause complaints
> if then name is given a different signature in a header file.
> 
> So rename it to debugfs_start_creating().

FWIW, there's one thing that might conflict with.  Take a look at this
in 3 of 4 callers of that thing:

        dentry = start_creating(name, parent);
 
        if (IS_ERR(dentry))
                return dentry;
 
        if (!(debugfs_allow & DEBUGFS_ALLOW_API)) {
                failed_creating(dentry);
                return ERR_PTR(-EPERM);
        }

Now, note that the very first thing start_creating() does is

        if (!(debugfs_allow & DEBUGFS_ALLOW_API))  
                return ERR_PTR(-EPERM);

and that debugfs_allow is assign-once variable - it's set only debugfs_kernel(),
called only via
early_param("debugfs", debugfs_kernel);

So that's dead code and had always been such.  All those checks had been added
at the same point - in a24c6f7bc923 "debugfs: Add access restriction option",
so at a guess the dead ones are rudiments from an earlier version of that patch
that hadn't been taken out by an accident - they should've been taken out and
shot on review, really.

They obviously need to go and that'll be textually close enough to the calls of
start_creating() to cause conflicts.

