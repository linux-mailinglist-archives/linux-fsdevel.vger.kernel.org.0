Return-Path: <linux-fsdevel+bounces-59074-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53692B340F5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 15:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF40A7B2BE3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 13:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4A42673A5;
	Mon, 25 Aug 2025 13:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXB4Ji1v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACF4611E
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 13:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756129215; cv=none; b=Wv4DQDe/ffcxZU25Gur0V4d0nTxIrZILDQK1i8bu4l4ZsXm/nD8edvRBGbDUtiHHJR1ByKy4hPESIiRZQQtVG2ZEO+xsZbBi1+npeOjH2ZvB+RNfool/y0Khs59Z1Ck8i+6ecZ5nMbqsPJyYQLDHULfaycDqUJhcFRV/wtZbkEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756129215; c=relaxed/simple;
	bh=YLIoeRvhy13ui1JuzRY6+d0T7GjVDZ5GYQEbCShfKko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCjLsfpyrNci8zXrpG2915wvLoSfO1aCctlInD3e8Is7yUGsvq+usJ06OXjcF9pVd9ZbehtO639JIUMY4k9EqWBals/dxnu1sIQZ/tCICmGDcbw6+TthvI5GekYNcITKycUGL+CgzQmaV/NqIGsWL+4Dbop6MOlh4hulAi4kiUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXB4Ji1v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65196C4CEED;
	Mon, 25 Aug 2025 13:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756129215;
	bh=YLIoeRvhy13ui1JuzRY6+d0T7GjVDZ5GYQEbCShfKko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XXB4Ji1v6RgKj2DD3M8jlZSUFIKooIIuAcUHAKwZCaSuicguXnQ2aTosWsxfEy8xh
	 EcUSOzy/YDobKeSlzrHpjHiHeXGCrvDTMOSU0eQVobkl2BcSvbQbt5YRD5jTu8ySf9
	 0thsOBjhIQ6wXLmfjOZ3yVuGEyI+zDBbfZ1QAtBWZsUQCV6y4JA72XEDSMEfXaRRDq
	 jyB0Lol6v7XW8BY6lyVp9jOyLTqIeyeYfxmMzuJThXwAV8phcecBqePEm89pT/b6yu
	 Ym3booXcd5YljamGKrhWvKUImpJZx6pjdxK1nfLK/LFXAbbYeupIyMRRHHOgBWBrHF
	 nr/DcrWXbQqnA==
Date: Mon, 25 Aug 2025 15:40:12 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 48/52] do_move_mount_old(): use __free(path_put)
Message-ID: <20250825-hofft-zunahm-dbbd1c1b59c1@brauner>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
 <20250825044355.1541941-48-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825044355.1541941-48-viro@zeniv.linux.org.uk>

On Mon, Aug 25, 2025 at 05:43:51AM +0100, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

