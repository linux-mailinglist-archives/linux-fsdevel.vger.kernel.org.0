Return-Path: <linux-fsdevel+bounces-58768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC13B31591
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 12:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15F441C25A51
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 10:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03BD2F60C4;
	Fri, 22 Aug 2025 10:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8khcRQX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8C442048;
	Fri, 22 Aug 2025 10:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755858901; cv=none; b=ITBCRZHG7cHVcZUbCE4MG9a5qcg2c+JECFIjDFeIH3T0s6/Cu2uFj/Q9AG72yoyQ6+KE1btB2zcOLq0GCnSwh0mw1jueRCxlisRSIDw6CD9+CuZWCfzUcHPWWFK34bqI78EiPYaB0HNxnfwNNAbN+nzhCtwZKT3biFSO/mn7gIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755858901; c=relaxed/simple;
	bh=Rf77/8QVQr7SUI15Gjp+gkc1tKp9nlY1mX2ozE8DsfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JkOLzQrehCqnFb0HBL3TMDb8CWlSMJdeL9a4UHVOE0iI8oNOHe3uTfeqeCTH4ks/rAlwhPFiOTV3DIsbdqDrn0Ui2WOOaKWBwyeHTRBg2BbxTV5I7EdQwLAn5Z6dGd3H76Vtj6lM4jpLWg8DaSaUFAqcrE12GvZNvHey1WdtMOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8khcRQX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4972BC4CEED;
	Fri, 22 Aug 2025 10:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755858900;
	bh=Rf77/8QVQr7SUI15Gjp+gkc1tKp9nlY1mX2ozE8DsfA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i8khcRQX9yWtpHDK3aCyE6vVz2Wv8bghpHqb/kxSR2bkV5yTUU/0FtxWVXpY7/IN6
	 y5OTmQ0N22DcxDpL0Vbcy7HHA0y+9SpkQkVoKG5WL/sz2NVmIjS3MaWQ0GdeAImKQx
	 QrZwxi1oCxdXG3zWOaAHEy+L+AktuCJwjMEmqDtdLlte02vKvoD7ZNI/SafQ92RtUm
	 gv0VvA5sk2I/y6O2ylDC+NOQ63pXz1AP/WJPN0diFwX6TpDSNzQukal5+3qCUtMePC
	 0B+95pMMcnYRWuVDPSGXGlWKBgBv3TIGSIkudBD5VpfZG7+tXZ+kg5dG4WLPOLiTnC
	 mBOyAOmQbRpyg==
Date: Fri, 22 Aug 2025 12:34:54 +0200
From: Christian Brauner <brauner@kernel.org>
To: Onur =?utf-8?B?w5Z6a2Fu?= <work@onurozkan.dev>
Cc: rust-for-linux@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com, 
	tmgross@umich.edu, dakr@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: file: use to_result for error handling
Message-ID: <20250822-worte-aufmerksam-5e985c84515c@brauner>
References: <20250821091001.28563-1-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250821091001.28563-1-work@onurozkan.dev>

On Thu, Aug 21, 2025 at 12:10:01PM +0300, Onur Özkan wrote:
> Simplifies error handling by replacing the manual check
> of the return value with the `to_result` helper.
> 
> Signed-off-by: Onur Özkan <work@onurozkan.dev>
> ---

Applied, thanks!

