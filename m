Return-Path: <linux-fsdevel+bounces-49497-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D28EABD827
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 14:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F65E1B60A95
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 12:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216A3219E8;
	Tue, 20 May 2025 12:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fa2znJKV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F5A1172A;
	Tue, 20 May 2025 12:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747743946; cv=none; b=r/5poBi3zj6S06GEB7JKrxhE4u2+EMF3Bekq1iqozRcWxVoScr0NCOyfmDcJuY1MA2n5N3LI0IdtpAaTN3RBdLC4/3f4qReyUyBZF4SPKDkK9EwPyFTWbxXZ2nzdQ9ykC3DtK3Chp6nk65uVB9ON+ynXJIswUwKf5e5P83XKd3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747743946; c=relaxed/simple;
	bh=10VOOs9OpZbgOc/7CEG+2dPlzikjuwLA+ThlPNmj5HU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jm8th2Q17p/dZxBN/xUMhRmSN02WqV8p0FLG0G5UCcY6a25VlCfi4uaKTSrwgqYRmX77Z6a/xtdChwPs7ek7lvY762QzKAcRgyJVhuxr4+HSTRKUTZtMb3tfCbN2KKZNH8d43j7B+ztwOVagmX4no10cvqU5ZzIeW1PZhetHqCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fa2znJKV; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 20 May 2025 08:25:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747743940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3tTe7AZhcsLl1SFjFBWYt00FQokJCv6k4IfTZPHi9Gk=;
	b=fa2znJKViX8E2/nzL1p8DdYezYUsoHEk15n4AO9kEi+ClPGyobWI1DoqF7IwPkVmCQJLIc
	4A9gBcw3ziEUJlji3q1jSY1U+VDsqhfgiaKS7QVbp/cNLkqUI3iTdckj3aYF2K7v1P3199
	Y2nRlVc5VbJF4GRUtjzfmsmOxhj3aT0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 0/6] overlayfs + casefolding
Message-ID: <osbsqlzkc4zttz4gxa25exm5bhqog3tpyirsezcbcdesaucd7g@4sltqny4ybnz>
References: <20250520051600.1903319-1-kent.overstreet@linux.dev>
 <CAOQ4uxg8p2Kg0BKrU4NSUzLVVLWcW=vLaw4kJkVR1Q-LyRbRXA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxg8p2Kg0BKrU4NSUzLVVLWcW=vLaw4kJkVR1Q-LyRbRXA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, May 20, 2025 at 10:05:14AM +0200, Amir Goldstein wrote:
> On Tue, May 20, 2025 at 7:16 AM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> >
> > This series allows overlayfs and casefolding to safely be used on the
> > same filesystem by providing exclusion to ensure that overlayfs never
> > has to deal with casefolded directories.
> >
> > Currently, overlayfs can't be used _at all_ if a filesystem even
> > supports casefolding, which is really nasty for users.
> >
> > Components:
> >
> > - filesystem has to track, for each directory, "does any _descendent_
> >   have casefolding enabled"
> >
> > - new inode flag to pass this to VFS layer
> >
> > - new dcache methods for providing refs for overlayfs, and filesystem
> >   methods for safely clearing this flag
> >
> > - new superblock flag for indicating to overlayfs & dcache "filesystem
> >   supports casefolding, it's safe to use provided new dcache methods are
> >   used"
> >
> 
> I don't think that this is really needed.
> 
> Too bad you did not ask before going through the trouble of this implementation.
> 
> I think it is enough for overlayfs to know the THIS directory has no
> casefolding.

overlayfs works on trees, not directories...

