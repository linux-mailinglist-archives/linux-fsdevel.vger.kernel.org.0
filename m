Return-Path: <linux-fsdevel+bounces-44571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B5AA6A6F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 14:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BE551890D91
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 13:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D711DED4B;
	Thu, 20 Mar 2025 13:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHGfFgXs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EBE290F
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 13:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742476577; cv=none; b=K/9nCN0xk2zvJv5nz7JioiOHUTGe1xjnpnFPdhnRKbHfWj3hWyO3UkJFz8HQAMI2BQnwLrAw4+aqSCrXCv+/BuWsg5CnoLTRK4gabAsbqG3thSKLPbzVoCQb9aUuCRwlLGd4XdQnNbD0LaJ4oG+MNOfq4tbXXvGxF24tUYH19CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742476577; c=relaxed/simple;
	bh=vy+470Rn2r8EyhIqTpcBrNUT05BMtAbRRkja4bBUtfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/VGooXLQdYhs3E4RpJmSmfS5/GJexjYwY6QiPpsWVJrZ7tHPU2i4cmlsdCYPt5TJFY21AHxXCTuPcHmYZ87LqmME3klATz1xs3LEPXesT70JtNnRQoA8OEHOThoRaWcCXMRADZ4CwdiwKLRhJFh+BpBlxAx7uQGnpg5HBwbUXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHGfFgXs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 058C7C4CEDD;
	Thu, 20 Mar 2025 13:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742476576;
	bh=vy+470Rn2r8EyhIqTpcBrNUT05BMtAbRRkja4bBUtfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fHGfFgXs77UfYhbzo2cVZMcHsIbPJnZhfVX/QsW5SxeyH89O1rd5ir0LfQiQC3QdL
	 nSdYON2K0/bKGiLoplZDpeLszhF8ksK312B2e2on1a/MPoc0mCEsQYW7LNBEjEZSlC
	 ef+x0bBM/LvJe6UyCOduyV8OutxPV/YNWRr3JfJI7Uz4mXreRV0qQTywaegdF++2To
	 twRmzjZarfEbHK3kFTDx4JkXnDhOAEK9b4fIjjYUIKI3lZKs321QWtXp+nyX37dzAW
	 NiA3DZbAFgaA+dhSt117kuWsRArgvStdXh5RyDm7EBGZDm9BWZ3krCrF3Zf5yphe3i
	 9REjdu1HPwN5A==
Date: Thu, 20 Mar 2025 14:16:12 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Lennart Poettering <lennart@poettering.net>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Mike Yuan <me@yhndnzj.com>
Subject: Re: [PATCH v3 1/4] pidfs: improve multi-threaded exec and premature
 thread-group leader exit polling
Message-ID: <20250320-randvoll-kommode-da12f024a3f5@brauner>
References: <20250320-work-pidfs-thread_group-v3-0-b7e5f7e2c3b1@kernel.org>
 <20250320-work-pidfs-thread_group-v3-1-b7e5f7e2c3b1@kernel.org>
 <20250320105701.GA11256@redhat.com>
 <20250320112126.GB11256@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250320112126.GB11256@redhat.com>

On Thu, Mar 20, 2025 at 12:21:26PM +0100, Oleg Nesterov wrote:
> And just for the record...
> 
> Consider the simplest case: a single-threaded not-ptraced process
> exits. In this case do_notify_pidfd() will be called twice, from
> exit_notify() and right after that from do_notify_parent().

Yes.

> 
> We can cleanup this logic, but I don't think this is important and
> this needs a separate patch.

I would actually clean this up.

> 
> (With or without this change: if the exiting task is ptraced or its
>  parent exits without wait(), do_notify_pidfd() will be called even
>  more times, but I think we do not care at all).

Yes, though the ptrace codeflow is even more cursed so I'm not too
worried about making that clean (I wouldn't know how.).

