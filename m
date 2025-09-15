Return-Path: <linux-fsdevel+bounces-61329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B514B579A5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8385016A3B5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 12:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC942FFDDD;
	Mon, 15 Sep 2025 12:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGLYD6cJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB72138DDB
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 12:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757937666; cv=none; b=dl3PSoqFZ+UBmYzh/DdZpsqwlPvyMwfUj1NYGLseyRPUMUzhkX538ryxY0BBgVE8Ft7B/HIBBnkQZ3wuVrR3Kn/0G0DaX+Y7cZ6KJ7pTx+RvY8wBckimM6lROC4EIFn2kltAdVWYBLKfrLyHA4TqPVhGqzrvJOjxP5Phbu4F514=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757937666; c=relaxed/simple;
	bh=BJ/iuxDAk2SOdtNTjyMd/x3koCOzbGUo4/IMaQ4JdPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cxf9yN6u3+CKONl/ogZXBkVqt1Bh/4gcRo3t4zyGr7HTtDRfFJmxckuaYC0rpmT97BJ0gg2suTpMTdDQ4B0AGDuUC29zfJy9eoCOx7S+0r2ZwHrH+a1C1i1jBNq+hoALvQbjQKmr3yhrZy9Wax8XwFxd/V5PSh412iYpGx+zUUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGLYD6cJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D542C4CEF1;
	Mon, 15 Sep 2025 12:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757937665;
	bh=BJ/iuxDAk2SOdtNTjyMd/x3koCOzbGUo4/IMaQ4JdPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GGLYD6cJkho1JjHCviiyjK6DNY6MtpgzZvXsLhXVbYyvthhorWxNJuUcZbBy804x4
	 Nv1mZGTB14pjKOtwrLcC6DSdzTSThAjsCZSsP+UGYI1bt6wFYAMEIUNS/PmB3AvQe9
	 UpE/EEVrW2G8/QUx4lFyfH/B57hwsIUZd71OmWrwsizfQdD7JCFTcArH1xtSkDK0V6
	 gkvyTWQBP/MsT2thw/Cw4TY1cqa+N6zwayELCNef55hDbsKG/KU+g/dqOx7EHteAzQ
	 G7V1v48J2f1ctgRL240ejAJ79heMaobEdFWHL6CeZa+NttejfyHpY4CTbZsKpP10Sg
	 bwLeL2MleMk9Q==
Date: Mon, 15 Sep 2025 14:00:59 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org, amir73il@gmail.com, chuck.lever@oracle.com, 
	linkinjeon@kernel.org, john@apparmor.net
Subject: Re: [PATCH 03/21] filename_lookup(): constify root argument
Message-ID: <20250915-gelage-gutsbetrieb-b72eeb4b84d2@brauner>
References: <20250906090738.GA31600@ZenIV>
 <20250906091137.95554-1-viro@zeniv.linux.org.uk>
 <20250906091137.95554-3-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250906091137.95554-3-viro@zeniv.linux.org.uk>

On Sat, Sep 06, 2025 at 10:11:19AM +0100, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

