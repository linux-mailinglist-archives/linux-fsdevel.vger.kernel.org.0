Return-Path: <linux-fsdevel+bounces-56739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E60B1B2E3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 13:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD6EF62241D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 11:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907C725DCF0;
	Tue,  5 Aug 2025 11:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ckrfbauo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB1E156237;
	Tue,  5 Aug 2025 11:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754394999; cv=none; b=OoL8TZfJIwjB5GqJQ4wd2jgIt/gJS4djBOIQp5X/2fb7ZO67YMJgnTSaVtGoN2thlpOBLuVcGTsFQXmBDo3cokoTqYNhb60QwWJom2VxfmCeB5pCmpk+TsNZAIoHkZWSinJzfyBtY/euem1d30TdF/6vP5f4imrMyzUN1hEg6OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754394999; c=relaxed/simple;
	bh=dNl1xHjNm5mFtyiMIlq9/g/S2leO5PQ1dVfJ7Xc3KY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BnlblZ5h6K9ZlLTU/lu6sMSvL4VrmUBjVkObjYrgpXhpEgzWlDZ7yS9OJrpv/PdVOOYFeHL+y9nH64vHzT3Q6gxyMFjgip7spfdRyaHHhl7gg9B8gnSs1QZmmIm4H/i0DCap16L2RQSRUKCglN5DGa/VQ32WwHNMlbDLTYGKfG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ckrfbauo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB92AC4CEF0;
	Tue,  5 Aug 2025 11:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754394998;
	bh=dNl1xHjNm5mFtyiMIlq9/g/S2leO5PQ1dVfJ7Xc3KY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ckrfbauopv47LFlFfCex/pWFwumQxWbs8PdPfSupAFZlh5/JlDrg/IKWrEjcT0Tgm
	 WNhU2IusQ0cWxhJ7yAzIwEiFF7Hy7paKdWPIEiI+dCXolZgJuYsM8HHXb229EyNM5m
	 UNC5trN1XJgursV88g17+juMLU/sBleFRDhHZ4ZEiCsx8sUfipZtB258qPfN1Db6Q8
	 psqREw+GeBJ2L0/pM4Uv838wIRSjqynwl+Tx3tFgXNdfw1R7VUFNu9GVD2cED3Ay47
	 TDD14+fVTXa4/Rqaa//hJ650yyl6BtA2aCrC5tqFrxMLjf+44fLH+9ueLf43cR1zw8
	 sfHzkKzMUpnCw==
Date: Tue, 5 Aug 2025 13:56:34 +0200
From: Christian Brauner <brauner@kernel.org>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Sargun Dhillon <sargun@sargun.me>, Kees Cook <kees@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] fs: always return zero on success from replace_fd()
Message-ID: <20250805-nachdenken-villen-acb3462975f5@brauner>
References: <20250804-fix-receive_fd_replace-v2-1-ecb28c7b9129@linutronix.de>
 <20250804-rundum-anwalt-10c3b9c11f8e@brauner>
 <20250804155229.GY222315@ZenIV>
 <20250804180046-e3025fef-b610-4e4f-8878-1162e0e8975c@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250804180046-e3025fef-b610-4e4f-8878-1162e0e8975c@linutronix.de>

> I'll send a fixed version tomorrow.

Thanks! I appreciate it.

