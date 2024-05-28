Return-Path: <linux-fsdevel+bounces-20309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 896E08D14DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 09:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35D7C1F22B74
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 07:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE79F71739;
	Tue, 28 May 2024 07:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eom72jNj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD2D45024;
	Tue, 28 May 2024 07:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716879924; cv=none; b=DY1NYl6pWmtxSgAYTLomb63XGO/X3PiEuc24oL4nDI3B9tbTZ6W2Ddfq2BXwHzDMiBQDk8mMlj0/f436KjRro/3tUCVGVNIS4AoDDbp78T9u7gPHT6Hof+9I3WTKC06wdR/RuOfrexrfI7UneqCH8w0J/Ti4AzCoh8IDOawrkY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716879924; c=relaxed/simple;
	bh=AJop6tQXrPDYxKxJR+T1Rffiqt/FIeu65U1e97Oj0gU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+UACKw+L1hyJEvKD7AkOVjGg7yaTFOQYTTG5MgtdUZBmNFJdU5ZakwKW6/wmaPJwDgxX16//ufAh1VezeIBBGs9RgpM4jxSW1KsXmY1XDvDf5U6ktyuq4ofFbqRSWoeJH1m+AGl1Wj8nTOL38wMdxgFI/vqu+G/jRsBtviU8fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eom72jNj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2373FC3277B;
	Tue, 28 May 2024 07:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716879923;
	bh=AJop6tQXrPDYxKxJR+T1Rffiqt/FIeu65U1e97Oj0gU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eom72jNj3HosJ7FhOQZg1BOvkvv+TbQkvdMqQvXp6DUAwncaYyXag1KhYIrU2KUt4
	 SfI/QjZvWLC6+tmKpCjdGiHDsebwnmfPivr4bzGLAHtBoxCZ4/hjRDzAM5ivkxmWWg
	 t3td3HpR69p60eyFuhhm2T2YWAcNxuALz7c9NqxvxEIUmOCWWJmrRBDt4wcjtWCO9F
	 TYk228KTde9hrnrxbYaYWIJL5ECp0xD5cx7LouREsZa8Msbt847nxJiTRfRBCMRVfn
	 0Rj3nbSbLjJ244Wlhpt7wF4CI8SJlTphxmOwufB7iUsOj6JVTKPzUeztCNyQzRoZKI
	 26v5JC4X2+BFA==
Date: Tue, 28 May 2024 09:05:17 +0200
From: Christian Brauner <brauner@kernel.org>
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "hch@infradead.org" <hch@infradead.org>, "jack@suse.cz" <jack@suse.cz>, 
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "alex.aring@gmail.com" <alex.aring@gmail.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "cyphar@cyphar.com" <cyphar@cyphar.com>, 
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "jlayton@kernel.org" <jlayton@kernel.org>, 
	"amir73il@gmail.com" <amir73il@gmail.com>, "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC v2] fhandle: expose u64 mount id to
 name_to_handle_at(2)
Message-ID: <20240528-restbetrag-zocken-df1f009dee04@brauner>
References: <20240523-exportfs-u64-mount-id-v2-1-f9f959f17eb1@cyphar.com>
 <ZlMADupKkN0ITgG5@infradead.org>
 <20240526.184753-detached.length.shallow.contents-jWkMukeD7VAC@cyphar.com>
 <ZlRy7EBaV04F2UaI@infradead.org>
 <20240527-hagel-thunfisch-75781b0cf75d@brauner>
 <20240527-raufen-skorpion-fa81805b3273@brauner>
 <49b6c50a50e517b6eb61d40af6fd1fd6e9c09cb2.camel@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <49b6c50a50e517b6eb61d40af6fd1fd6e9c09cb2.camel@hammerspace.com>

On Mon, May 27, 2024 at 03:47:33PM +0000, Trond Myklebust wrote:
> On Mon, 2024-05-27 at 15:17 +0200, Christian Brauner wrote:
> > 
> > Returning the 64bit mount id makes this race-free because we now have
> > statmount():
> > 
> > u64 mnt_id = 0;
> > name_to_handle_at(AT_FDCWD, "/path/to/file", &handle, &mnt_id, 0);
> > statmount(mnt_id);
> > 
> > Which gets you the device number which one can use to figure out the
> > uuid without ever having to open a single file (We could even expose
> > the
> > UUID of the filesystem through statmount() if we wanted to.).
> > 
> 
> It is not race free. statmount() depends on the filesystem still being
> mounted somewhere in your namespace, which is not guaranteed above.

The unsigned 64bit mount is not recyclable. It is a unique identifier
for a mount for the lifetime of the system. Even if bumped on every
cycle it will still take hundreds of years to overflow.

