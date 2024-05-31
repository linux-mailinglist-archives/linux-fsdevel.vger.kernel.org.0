Return-Path: <linux-fsdevel+bounces-20642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 789178D6522
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 17:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28A521F2681D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 15:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7677483;
	Fri, 31 May 2024 15:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="pmfaOblV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32B61848;
	Fri, 31 May 2024 15:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717168037; cv=none; b=Y+w+rep5+C+4FsWznutSJWnA+9IiitGaSdlIqOY6LEDI3H1LHT/2lnjXoqcVzmYzHg4Es+ckPzTwntf8XQkImm+d07cH9/ll4sId67a/aUn+7jYd0wf8FMOGqH4cDzUDqdzNe57xbt4Uv5kUfgEFt7WeQ9eMcLCw07ttkarnmso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717168037; c=relaxed/simple;
	bh=LtImTQMzLCUIj4hcTXTNSS+JNJevJKuaZQIJroG3UQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U8adokrZfPTtf0WCJ1fAS18Tk3XDZpD6Aiqztl7aR7Eu4+enLnNuc7PBpn63f+j6WMTZk77Knx4G298YTRnvsfgb1oVNNnb6OvrloRYozO2xNGS0dYfYqfp+hT6MY2znaYg/0EKzlqda5pmBVtTqPGalCAP8Dn1wYdjGe70Ib9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=pmfaOblV; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XOEKCyYff7smOUYYkJLuXoJt3Ho26Em9sCrJHHsHOGI=; b=pmfaOblVFosevlHaOQjdECRgdo
	/PxkYUITbH8QzPAI5KvZBNT4lnhKLQtp+IqmJbZ710dSq75WQ4+yKuRam4wWWQbVXhwi1IO2uXu4j
	1ZJzf4Cq7KfHOMml7/amMOkBQUfsrZQnyntXJv6HXK6qzWyYKd4ItDegohYzw9FWaHbb/RxeKnVQt
	f2egHiKFTw5pn5r9XXN0ORLE8I9th3uILtihxCgdt7fNQUSxKH2tJlc19fHOX/fYengt03lY1dv2P
	GFzkZLDKAetLquRHOTcANHF6WE2i0tzAviW+G4vYfX09eoyV/HaSyyYAeRt7GMLXQg/GNllOcNrqm
	Ypb4mfEw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <ema@debian.org>)
	id 1sD3qP-0044Q3-SS; Fri, 31 May 2024 15:07:02 +0000
Date: Fri, 31 May 2024 17:06:59 +0200
From: Emanuele Rocca <ema@debian.org>
To: David Howells <dhowells@redhat.com>
Cc: Andrea Righi <andrea.righi@canonical.com>,
	Jeff Layton <jlayton@kernel.org>, Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Christian Brauner <christian@brauner.io>,
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
	v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Luca Boccassi <bluca@debian.org>, TJ <linux@iam.tj>
Subject: Re: [PATCH v5 40/40] 9p: Use netfslib read/write_iter
Message-ID: <ZlnnkzXiPPuEK7EM@ariel.home>
References: <Zj0ErxVBE3DYT2Ea@gpd>
 <20231221132400.1601991-1-dhowells@redhat.com>
 <20231221132400.1601991-41-dhowells@redhat.com>
 <531994.1716450257@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <531994.1716450257@warthog.procyon.org.uk>
X-Debian-User: ema

Hi again,

On 2024-05-23 08:44, David Howells wrote:
> commit 39302c160390441ed5b4f4f7ad480c44eddf0962
> Author: David Howells <dhowells@redhat.com>
> Date:   Wed May 22 17:30:22 2024 +0100
> 
>     netfs, 9p: Fix race between umount and async request completion

I have tried this patch on top of 6.10-rc1 and unfortunately the problem
persists.

Meanwhile TJ (in CC) has been doing a lot of further investigation and
opened https://bugzilla.kernel.org/show_bug.cgi?id=218916.

