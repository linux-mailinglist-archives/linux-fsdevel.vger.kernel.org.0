Return-Path: <linux-fsdevel+bounces-25270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CEB94A5AE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 12:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E9181C20FED
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 10:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1621DE846;
	Wed,  7 Aug 2024 10:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PdEh3RMg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBC013F435;
	Wed,  7 Aug 2024 10:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723027006; cv=none; b=EHHFjvn44oKGYkbJis69Krz3/R0AcIaXUSax8r3BWdgAPyBV39r5Y/k9wgDJX/EplrCKK5+SQqtsgJgqXs8YBuIuu4brPhgq879P6nJAKJBzPet14ZcGleSTYR2cbIMDFmXhCUEjMhAFzTOgTJ/JwpgJJDjYDXhSRIiFGahUuR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723027006; c=relaxed/simple;
	bh=01fDQxl5Ur3cDTF3eX44TXxtfCwVlDO1cZtolHoV8eU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VF8LEomx041jh8WN5ACpa7Ct+fmopOl2NQGrkJkfO4/txjgxveM+WC84T8l47ww8Wn66PPD1KlJoJ6ioE3xM/SoCPvbW9KbBxs5VJDHTSUQWU5TvQW8WjHHFchjZf8cRo1qNCXigLlWXQcKSX/8RdmMW+F7uIf9dLt9A4DkNTbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PdEh3RMg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C1ECC32782;
	Wed,  7 Aug 2024 10:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723027006;
	bh=01fDQxl5Ur3cDTF3eX44TXxtfCwVlDO1cZtolHoV8eU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PdEh3RMg1Nfl520aAwW/gXkPerJy7Y63IucRZa9StOrhx0n8Enep8SOBS0SpXx1I6
	 f/lE9g28uBQ5cAGR4Qij4wZXyfTJ/IzASBfmpe70zzT1y4euBcT6E0fTTkd3K7kVQF
	 tUrZCdV4dUEunF359W+crExBOdasFL3OlucnKn7XUv0VLdWagjeKS0p0+bPwJgo4kG
	 xh+sF0UC64dMlKyFgU5CxFeHuB+EIkJ914b/KM6HlxACKFKvE+JzCu/1vgGSQ1vf/J
	 VRLZSX7ET3rB6I55oBXypUjv2bRu+EyDBiCqRNLzn9avhIjdQ+2lSDOhVox6yxZ+YT
	 g6Ros6k9xmvsg==
Date: Wed, 7 Aug 2024 12:36:41 +0200
From: Christian Brauner <brauner@kernel.org>
To: viro@kernel.org
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, bpf@vger.kernel.org, 
	cgroups@vger.kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 20/39] introduce "fd_pos" class, convert fdget_pos()
 users to it.
Message-ID: <20240807-nieten-geadelt-f7c4b127d067@brauner>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
 <20240730051625.14349-20-viro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240730051625.14349-20-viro@kernel.org>

On Tue, Jul 30, 2024 at 01:16:06AM GMT, viro@kernel.org wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> fdget_pos() for constructor, fdput_pos() for cleanup, all users of
> fd..._pos() converted trivially.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

