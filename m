Return-Path: <linux-fsdevel+bounces-40169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F620A201A5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 00:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AD8C1886BFB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 23:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0AF1DE2B5;
	Mon, 27 Jan 2025 23:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pyzS5Rt1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4DA1DE2A1;
	Mon, 27 Jan 2025 23:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738020421; cv=none; b=U3gqCp6CFylUgMe6AspI/nQfsja0tfWGWs13tZM2k3Ju4v59Ht3oCJPIU1GHuPEKxRSEKiEMmif1k9/m6ekVc08ZG7FodLPXdhPqdSJ9JbXbZPK6b9Ys1elYnEAf3J86jyW94HbxZpfHWrhPGUs5JVIwpNF2MsmaxsbwaGh4m+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738020421; c=relaxed/simple;
	bh=yPxfPWU2BE5UFFvv5J6KgISjFCHnr7rGzrI/NdnSLAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9277W6U+BvU+oydsR2KQ4SzMeuZZr/wjQkDyooZ2bXSFN45/IU2I5fMgo30gdw7bNvEyun+zUTmyGl3++l29Xqynzl9N6twVarhpIcjMsK/tPYCNlg1FhnH+B12G2J6aPzLHu/7PSSKYQgBJyqs2JakDga4xvd1frXpkJbB03s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pyzS5Rt1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24491C4CED2;
	Mon, 27 Jan 2025 23:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738020420;
	bh=yPxfPWU2BE5UFFvv5J6KgISjFCHnr7rGzrI/NdnSLAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pyzS5Rt1fFT4xwdWOUYXrb+FVdsbGR939Xvk96LURV33REYJyHy9fNRvheAuzm53K
	 zgNioPdB6YTQYyf1reYd3P3ldcX6zBsm0GRpxTbJ7EwocJrNkpyxCdgmnvcNp3DfHL
	 pWRxHuAXP7QyELg5EgRqMdiRRGsduAOMCHUwfbo2tOhBXoZUZtiCA1Vkl4IlQEPV0u
	 wxs9ChXC23X87a0L4q27w8FxmHHhwbNX1IUKrRFN07cOpAp1en1lLZFdY5jD02MVls
	 /S1xXEa4jcTs4cMUtBcaSjrG3/ESTm1gjByrVz13O+S9iOXnpxpIla793yjOGXgxYT
	 pv0z69B8n4Qww==
Date: Mon, 27 Jan 2025 18:26:58 -0500
From: Sasha Levin <sashal@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [git pull] d_revalidate pile
Message-ID: <Z5gWQnUDMyE5sniC@lappy>
References: <20250127044721.GD1977892@ZenIV>
 <Z5fAOpnFoXMgpCWb@lappy>
 <20250127173634.GF1977892@ZenIV>
 <Z5fyAPnvtNPPF5L3@lappy>
 <20250127213456.GH1977892@ZenIV>
 <20250127224059.GI1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250127224059.GI1977892@ZenIV>

On Mon, Jan 27, 2025 at 10:40:59PM +0000, Al Viro wrote:
>On Mon, Jan 27, 2025 at 09:34:56PM +0000, Al Viro wrote:
>
>> If so, then
>> 	a) it's a false positive (and IIRC, it's not the first time
>> kfence gets confused by that)
>> 	b) your bisection will probably converge to bdd9951f60f9
>> "dissolve external_name.u into separate members" which is where we'd
>> ended up with offsetof(struct external_name, name) being 4 modulo 8.
>>
>> As a quick test, try to flip the order of head and count in
>> struct external_name and see if that makes the warning go away.
>> If it does, I'm pretty certain that theory above is correct.
>
>Not quite...   dentry_string_cmp() assumes that ->d_name.name is
>word-aligned, so load_unaligned_zeropad() is done only to the
>second string (the one we compare against).

Sorry for the silence on my end: this issue doesn't reproduce
consistently, so I need to do more runs for these tests.

-- 
Thanks,
Sasha

