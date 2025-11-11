Return-Path: <linux-fsdevel+bounces-67883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4C0C4CC9D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 10:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C37F04256B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 09:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95842F1FF5;
	Tue, 11 Nov 2025 09:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKG3wSjF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A482155389;
	Tue, 11 Nov 2025 09:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762854531; cv=none; b=tympJ2ElTjz4AfEtG4Swk2QQyjPIgRDc6GQD2x9Iunv11PTYFuKQaonhsGawnqVqraK7fW/Hb1OgGLCtzjXXkJTeEAA8IzDAbWXC4FkELbqOFDzwfyBfCW6VD0A8mXSNhl6z/Ce7r25i3UdUsAlO9XhD0vfoLGtglYLfpv10eXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762854531; c=relaxed/simple;
	bh=Xmlr8Id/6Z//lY5LW7VmtWmZos+x0Ts3itVyP3tresU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lUxPZU1HAnIymP9gBARcGNmUKAI9Tst5K95Xy3gG4P2PwHr4X1N22QH0CKUFi/ZEeWFszJ6MabUFQLI49Z0jXsaqIAOJGqajSSg59OeUMDYnzlltiwihEVc47f3FOX7V8puS2iFo/dIYaIUlrlArT9j4neNp2rwI7QxLovoWRbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKG3wSjF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB3BBC116B1;
	Tue, 11 Nov 2025 09:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762854530;
	bh=Xmlr8Id/6Z//lY5LW7VmtWmZos+x0Ts3itVyP3tresU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jKG3wSjFPl0edwk0JvoFI4JEMuxh8m/peX6ADOH4L1YcpqEShJ6EIAqR+TbqlGEhr
	 LHmgwZmIYSMs7XxFCcuDY87PmEiNLor/L9GGQ6hUTLkJZuSc1SR2ViGc+cg54Etq6V
	 wJIBQ2iFVC3zO8jyLTc4pTx/Z3TXvlDn8hwf6EeF/lQZvmI7Dm3dd/yl/DEOOkKa5T
	 wEno5O+/ROjoDoC67Z6L1yhfyj1ZTTYpY/LCR6NXMpilq+Z/+vY5R8gnyuJvo5Nosm
	 daASD5Hy4CuajmD49tCtzZGqEZRkTqbWMzGZr+ZtashjTg2p5TJ5Jc17lrybd3hmlt
	 scyT/K9y3icsQ==
Date: Tue, 11 Nov 2025 10:48:45 +0100
From: Christian Brauner <brauner@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, 
	Peter Zijlstra <peterz@infradead.org>
Cc: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] restart_block: simplify expiration timestamps
Message-ID: <20251111-formel-seufzen-bdf2c97c735a@brauner>
References: <20251110-restart-block-expiration-v1-0-5d39cc93df4f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251110-restart-block-expiration-v1-0-5d39cc93df4f@linutronix.de>

On Mon, Nov 10, 2025 at 10:38:50AM +0100, Thomas Weißschuh wrote:
> Various expiration timestamps are stored in the restart block as
> different types than their respective subsystem is using.
> 
> Align the types.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---

@Thomas, @Peter, do the timer/futex changes look fine to you?

