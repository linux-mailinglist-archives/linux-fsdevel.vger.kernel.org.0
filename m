Return-Path: <linux-fsdevel+bounces-63437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A858BB9088
	for <lists+linux-fsdevel@lfdr.de>; Sat, 04 Oct 2025 19:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AB613C5027
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Oct 2025 17:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1F828506A;
	Sat,  4 Oct 2025 17:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9lhms3/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFE813A3ED;
	Sat,  4 Oct 2025 17:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759598848; cv=none; b=Zj91Bz52UTIE6jx8sQJCJDQtZyQDat79Db/yMnd+C7usxp4HZ7+jkOaM2vBkGywgEAeq2v1L6ElYSEazl+00a38f4aHIm6CnmUMIlFnA9JJOsIuaCKoMsC6NuxLA32IEzGcU5R4uEBPSN8Y5+H5IxSWAmLq3UtG3kDtkjPhltck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759598848; c=relaxed/simple;
	bh=uu7HOOFyGfgn7/79Ck9Jdp8RAV01CwyMxkrU7USL9Zc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h3oEJl2l+4e9VBpJELEwmmrHgQUiQNh7ZswJq3fxbNr6FpssrGFKBFVzNEyccu8XhQ9Tr6dxrO4JCbod80y63jijn4EUTEZw+D9kRrVDEztiKehFwbjoYVZ9CGdkMsnQEgTzFyndGkVwqXcyeGQaQbOSo7RUo21fg4kpGVMGOZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9lhms3/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7725EC4CEF1;
	Sat,  4 Oct 2025 17:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759598848;
	bh=uu7HOOFyGfgn7/79Ck9Jdp8RAV01CwyMxkrU7USL9Zc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=I9lhms3/42LXr3Rt51KchF2ZIJhunQIA54dRMkkPjDnz2gwa83F2Vxcx5HbANUH+8
	 tUYaI7zFKK+J2l8/WjiR2eWhh+qUkNzxT05H6qg56FtCcH3fgkUZ9qULPV4SVt35us
	 6qI3x2IzPEmnx2LJ0gi215ZaDu3e+sSMZ6cEP70ELlmiZkvXk0RnqK9f6l+3mtY0IU
	 tV+FusQYVNrkYKEVjPqNwcHPFiQosKDnESupiqT4iK16p30mVrv+rA1UrjTqANW9zY
	 1qei6hAjkKr+BaTNipbo11X1M6Z9y5M7XY7ND/2b0Ov913wFYS3lio5T7A8ExtS4Wd
	 CbzWVfo0oiKbw==
Message-ID: <afda62fa-d39a-4487-9c25-c409369bd667@kernel.org>
Date: Sat, 4 Oct 2025 13:27:26 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] fs: Plumb case sensitivity bits into statx
To: Gabriel Krisman Bertazi <gabriel@krisman.be>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
 Jeff Layton <jlayton@kernel.org>, Volker Lendecke
 <Volker.Lendecke@sernet.de>, CIFS <linux-cifs@vger.kernel.org>
References: <20250925151140.57548-1-cel@kernel.org>
 <CAOQ4uxj-d87B+L+WgbFgmBQqdrYzrPStyfOKtVfcQ19bOEV6CQ@mail.gmail.com>
 <87tt0gqa8f.fsf@mailhost.krisman.be>
 <28ffeb31-beec-4c7a-ad41-696d0fd54afe@kernel.org>
 <87plb3ra1z.fsf@mailhost.krisman.be>
 <4a31ae5c-ddb2-40ae-ae8d-747479da69e3@kernel.org>
 <87ldlrr8k3.fsf@mailhost.krisman.be>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <87ldlrr8k3.fsf@mailhost.krisman.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/3/25 5:15 PM, Gabriel Krisman Bertazi wrote:
> Chuck Lever <cel@kernel.org> writes:
> 
>> On 10/3/25 4:43 PM, Gabriel Krisman Bertazi wrote:
>>> Chuck Lever <cel@kernel.org> writes:
>>>
>>>> On 10/3/25 11:24 AM, Gabriel Krisman Bertazi wrote:
>>
>>>>> Does the protocol care about unicode version?  For userspace, it would
>>>>> be very relevant to expose it, as well as other details such as
>>>>> decomposition type.
>>>>
>>>> For the purposes of indicating case sensitivity and preservation, the
>>>> NFS protocol does not currently care about unicode version.
>>>>
>>>> But this is a very flexible proposal right now. Please recommend what
>>>> you'd like to see here. I hope I've given enough leeway that a unicode
>>>> version could be provided for other API consumers.
>>>
>>> But also, encoding version information is filesystem-wide, so it would
>>> fit statfs.
>>
>> ext4 appears to have the ability to set the case folding behavior
>> on each directory, that's why I started with statx.
> 
> Yes. casefold is set per directory, but the unicode version and
> casefolding semantics used by those casefolded directories are defined
> for the entire filesystem.
> 

Got it. That keeps the proposed statx changes simple. Let me look at how
extensible the statfs API is. Actually that falls a little outside of
the mission to support NFS's needs, so perhaps that should be a separate
effort? Let me know what you think.


-- 
Chuck Lever

