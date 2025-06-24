Return-Path: <linux-fsdevel+bounces-52694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A0AAE5F14
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 10:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E97B44A2B42
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 08:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D4F257AF0;
	Tue, 24 Jun 2025 08:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dCAsgDZF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F64A257431;
	Tue, 24 Jun 2025 08:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750753560; cv=none; b=Tl153YRpWWpgQunxJwQrCgUTABfgbiEK/ejME7mWwV80SgzN6u4K3rgPjha8142rCqOts+8KNMmOicqgNgtaw0PzPgd+CIgbOrygWxj9GWrXsWsIbU01MyBJui/JSi+bBJN6wLSiIL1uJYADms9AdtJdfGR2lWlYyFnMv1njyR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750753560; c=relaxed/simple;
	bh=LGFffHC4oQQ92ppl02aATjfNr67ZE91Z/gYJUYeXGPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d6bo7ahV2BBWE4Vgd2HlfZtaolIfOyvkfeLAwnWcKDQX4TumqcEl5ir68unQArKOSqZ9Gib3EmjYEkBNLnmVsrgcWa00CTMeKLlHhlLu3VjvK7LbLH9s+UdTi2IISKNwMNYyhcTX9YFHHBIyAG497u2Spig3U0Z6HBYtTygEZm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dCAsgDZF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 089FBC4CEE3;
	Tue, 24 Jun 2025 08:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750753559;
	bh=LGFffHC4oQQ92ppl02aATjfNr67ZE91Z/gYJUYeXGPA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dCAsgDZFTit4K62DffNKX7nsgepKeYjFQaE4ttMRoHry15WM5s/kOQSZ5TyP8Q+8m
	 Vgq06ACz4V00US3HiPiu5IiDHXPWpoHsLorVXJnasYMTRkPy0vykWa6oX/RCiJ78ns
	 33PiI3vzQdiZsatpaOuVzWWLjDpKiGGvSsHMl0rC/ZPmB5HZ0l+JOKLv5d99J75Y+x
	 M9NfzbV34DHCCKkHCQaDkQf0AqW4xWVcJDBPOTzwdSIFKk39UmbOCSsZHMYEyvLnNs
	 hHiaSqzPn/sIur7y/0GOFpDlRAAZaXY5qy5gllqoQ/ITdPLvtU35F8NHDhwasWsRNb
	 jCUMgZuDCuw7w==
Date: Tue, 24 Jun 2025 10:25:55 +0200
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Simona Vetter <simona@ffwll.ch>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH 6/9] exportfs: add FILEID_PIDFS
Message-ID: <20250624-globus-rennt-aa2d1fae5a62@brauner>
References: <20250623-work-pidfs-fhandle-v1-0-75899d67555f@kernel.org>
 <20250623-work-pidfs-fhandle-v1-6-75899d67555f@kernel.org>
 <y6yp3ldhmmtl6mzr2arwr5fggzrlffc2pzvqbr7jkabqm5zm3u@6pwl22ctaxkx>
 <20250623-herzrasen-geblickt-9e2befc82298@brauner>
 <CAOQ4uxid1=97dZSZPB_4W5pocoU4cU-7G6WJ_4KQSGobZ_72xA@mail.gmail.com>
 <lo73q6ovi2m2skguq5ydedz2za4vud747ztwfxwzn33r3do7ia@p7y3sbyrznfi>
 <CAOQ4uxirz2sRrNNtO5Re=CdzwW+tLvoA0XHFW9V5HDPgh15g2A@mail.gmail.com>
 <idfofhnjxf35s4d6wifbdfh27a5blh5kzlpr5xkgkc3zkvz3nx@odyxd6o75a5a>
 <CAOQ4uxg9jWNxWg3ksoeEQ-KY0xKUwTPYokKN7d4whi_QDa=u_g@mail.gmail.com>
 <20250623-unklar-nachwachsen-09f3568700c8@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250623-unklar-nachwachsen-09f3568700c8@brauner>

> > You can leave it as is or use
> >     FILEID_PIDFS = 0x100,

I used that.

