Return-Path: <linux-fsdevel+bounces-51282-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09389AD51FD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 12:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CCFA17F7C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 10:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB2327145D;
	Wed, 11 Jun 2025 10:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gx+4yCMX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2BC269CED
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 10:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749637978; cv=none; b=OQskbAueDu/1n/rDBU5mvbPtGcb9q0Mn6zlGPKgGjSrg4qh4RzlWIavn09sDbg7mKqFvDN3EZ4D70MGQzR6Bc8T+3EaUUbRpq6m1lDDKf7bf2s+cAkDyEqjLnJJ/8Hb4X+GPqNndLYqst7V0uJGkEoRxXTBnSN3SpZGR1ZVq4dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749637978; c=relaxed/simple;
	bh=OmzknkgcKeurcKMbve4JN65ox6mRDia/KTuGU9EZhco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LS2E/Lq1MIwTQ60jkcgAw/+6N6X11G9tCd2EoZT2+ff/I9WlKw1TxKAa4TsA/LVHIYllrWWOabNT2uL1h7AN1Ikta/EtWkSAyMiKtj7P1c49l3Qb9ZBhMkLjV56owf4KvFynuZo3d/WNq9S7BtGJ8sXkuvLFZmNT6DAEfHYEnb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gx+4yCMX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC184C4CEF1;
	Wed, 11 Jun 2025 10:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749637978;
	bh=OmzknkgcKeurcKMbve4JN65ox6mRDia/KTuGU9EZhco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gx+4yCMXuJH0Wto03mQnsEgAjGg7V6VACEiazeTUGR9DgYTzBXa8PFOf5FoYzLXP4
	 vcEC5CPJeGHRA6HlaydirIgb0xWi+DOSMDRrbxl+TtR3vWR5OYf5sEJA0bpyV27VTF
	 2uodLdri4dYl0fntSz2W19wMOnJ1iBgUMYNnrR+FuuiizjzGBmtpudcIzNzPAzqjit
	 p9srJPfOCAB1ldRmy64BQloWQksOgaiwRdnJOgc2CBKLqMD1DgfU4lxgmfzjux2PIA
	 XQ0luzGFfCROSb+UvUIvptafd5/OyRrheJZ3iiB4b2XpFz6g2mroA0zVCUISXc670T
	 m8l2s4Ir4MQ3w==
Date: Wed, 11 Jun 2025 12:32:54 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, ebiederm@xmission.com, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 05/26] constify is_local_mountpoint()
Message-ID: <20250611-horchen-glotz-fcdc18ae4daf@brauner>
References: <20250610081758.GE299672@ZenIV>
 <20250610082148.1127550-1-viro@zeniv.linux.org.uk>
 <20250610082148.1127550-5-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250610082148.1127550-5-viro@zeniv.linux.org.uk>

On Tue, Jun 10, 2025 at 09:21:27AM +0100, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

