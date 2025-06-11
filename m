Return-Path: <linux-fsdevel+bounces-51299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B33AD537C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 13:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBF341C2558C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 11:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98691239090;
	Wed, 11 Jun 2025 11:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZc23MJE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67422E612B
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 11:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749640143; cv=none; b=AGMO7TEicqnws0Hnsx4tkHvE2t2jPkMlVV8QflNSgg83FIRVn+oM6e9rGxmSmRpa7bkFU2q5XHlmTWK/Wl3bbktm2mcGvlpBZu7uuFZFHY85QKySD20f/DzaaowhEVdrnOo+QoXsVoE8iLfZQVoGL6JOAXBUcNZMRPIneJZ0dPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749640143; c=relaxed/simple;
	bh=nBkaaxqk1iVwGZKPvjCk71c8/ZCh6ywgp7E095nmUkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gxGebEHV/N47uurvOUTF6pUCiXMK5jjzaJXouFAt3Ydr8q2yFNCGwaM9vErsNrIt0ChWAMJw0oR3yLtiSEFejL/3LJ5lEv3Nr0SZ//o+yfdEdsgyGdB9Uicfqrjj/L1r8XiJ/1WKGadJyKWwmg9t2LLx2oi2rQsZIddf8xEY5/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZc23MJE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7005EC4CEEE;
	Wed, 11 Jun 2025 11:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749640142;
	bh=nBkaaxqk1iVwGZKPvjCk71c8/ZCh6ywgp7E095nmUkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DZc23MJEKgR3y2HB5Ol9RHBZvFHuIU1rSYVJJ67YBWNq1ydqoPO1zjIN0jooXXFvQ
	 4bvd/qvvFJWqR/hra+UQg1A03sPqzcqbHo3/5Nomf3Ae1CqxLewg5I4iGjtelUYCE3
	 /xzMcUMtquq+NPrgwqTh7yHuRHWKdZGylmhKyg6z3AEigAjOpjfnX+QFH7usSz5s0f
	 wY9Q1SxZ0WzwREa+rZfX7xInxmoQ29HfYqfDK5XRREZurRi/OvP1K5dZ+ekFtY8L1/
	 98r3dl3AsCVlclo0kOmI4Ap/XmwfqkPXdXe4qXGudqt3Sm1HslWu/8vocaZofsKc0B
	 u2ucWyWa2VsVw==
Date: Wed, 11 Jun 2025 13:08:59 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, ebiederm@xmission.com, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 20/26] do_move_mount(): get rid of 'attached' flag
Message-ID: <20250611-motten-sporadisch-93d161c11e0a@brauner>
References: <20250610081758.GE299672@ZenIV>
 <20250610082148.1127550-1-viro@zeniv.linux.org.uk>
 <20250610082148.1127550-20-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250610082148.1127550-20-viro@zeniv.linux.org.uk>

On Tue, Jun 10, 2025 at 09:21:42AM +0100, Al Viro wrote:
> 'attached' serves as a proxy for "source is a subtree of our namespace
> and not the entirety of anon namespace"; finish massaging it away.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

