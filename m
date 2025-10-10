Return-Path: <linux-fsdevel+bounces-63756-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DF3BCCF3E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 14:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9884D1A666A5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 12:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6782EE616;
	Fri, 10 Oct 2025 12:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fl26pxt8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00E62D0629;
	Fri, 10 Oct 2025 12:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760100216; cv=none; b=ZQK4deqD0gIPQO6VqkD07azWDUn9CccgdCDiSzmDFLbkbTfQM3NzQTU6UhZhGzq7YWADIEZvezg4L1+VQeIhH3o2mubT7iDvI85ES5GHHzhVujvFZlPfJidzzGOBQVXgbAL6KjqyetOXk4YkuPzqDbxC4pz9FtHTpnf+6Tfcy0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760100216; c=relaxed/simple;
	bh=cPAcxJ0PmB0Ua//fBc2QW7y4ImJVFHEqhu/WNimm9d4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gA9kMZsymDwHCJqywe2CluqDXkHSE92IgXELMmDQggEYeTwI6u+xWh/Aw8eSURxin+kIGlsxPHWT3kIG+LTUs5KDMGFkbW0FL225qGkTdJzjPL2Iwnan8jPtUKgtxO4CEM4l3Dj2QwMSB+RMWmGGPM1/ooW3HtGzRkpGvi8+RKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fl26pxt8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76CC3C4CEF1;
	Fri, 10 Oct 2025 12:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760100215;
	bh=cPAcxJ0PmB0Ua//fBc2QW7y4ImJVFHEqhu/WNimm9d4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Fl26pxt816Eu8aLRWVp0/NbyOQZmghicgKv5O9RBYvZzltI89rBjiHrNwwaWnVYuK
	 Gn9fKzyk5ig6a2o7Fbt+IYMyBt+K5/PZDtNEFNLMdURao2zAre1uXUDYcHZ+JzFDe/
	 qP6tJisEdoL77pKXT3dNfxqRbTjHDcGq637zAcvuZDmCheVMOyzaK7NFltnzLoJpdJ
	 oW/zDoyIf1N/uot6anZxnIfgi4FnJGNrKDHV6H/Xt5NZC3+cyDgOXUptnVaT2RfHUP
	 fROIc5mzZRtN0Gt8Mm3R2fJysXlzi92B2V5Qk9HpD/6hZXQ1UnFCLseOScMI7nW9mp
	 +nzJoCpBV/oZg==
Message-ID: <6b709bcc-d9bb-4227-8f84-96a67d86042b@kernel.org>
Date: Fri, 10 Oct 2025 08:43:33 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] fs: Plumb case sensitivity bits into statx
To: Christian Brauner <brauner@kernel.org>,
 Gabriel Krisman Bertazi <gabriel@krisman.be>
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
 <20251006-zypressen-paarmal-4167375db973@brauner>
 <87zfa2pr4n.fsf@mailhost.krisman.be>
 <20251010-rodeln-meilenstein-0ebf47663d35@brauner>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <20251010-rodeln-meilenstein-0ebf47663d35@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/10/25 7:11 AM, Christian Brauner wrote:
>>> I'm not too fond of wasting statx() space for this. Couldn't this be
>>> exposed via the new file_getattr() system call?:
>> Do you mean exposing of unicode version and flags to userspace? If so,
>> yes, for sure, it can be fit in file_get_attr. It was never exposed
>> before, so there is no user expectation about it!
> Imho it would fit better there than statx(). If this becomes really
> super common than we can also later decide to additional expose it via
> statx() but for now I think it'd be better to move this into the new
> file_attr()* apis.

Christian, I'm still not clear what you mean by "this". Do you mean only
the unicode version? Or do you mean both the unicode version *and* the
case sensitivity/preservation flags?


-- 
Chuck Lever

