Return-Path: <linux-fsdevel+bounces-58005-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B329FB280AB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 15:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D1587BF638
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 13:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BAC3019CF;
	Fri, 15 Aug 2025 13:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="muzmQkJo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BEF433AD;
	Fri, 15 Aug 2025 13:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755264858; cv=none; b=m4p0NOlYQKWg/Xl7cHAK0aZ2ea2vFD8rOHsmRyu5JDiHy/ZViGVlUcjpCpI//K09xN1+1FqxQLY241VmbBisp6X1LILON0qQYGHomcmGBQYY+lFRt7ZqmvTQpzj0g14FVLsK2F/AeV51M5LLXbUwx73d842pf7bZNaJq/A3ZYfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755264858; c=relaxed/simple;
	bh=BXB508zA3OL2seIa1COdkMlSBvL7xWN2/dXNaPw2JgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZsDXrpEP5eD2Gnix1mJxGRJt10gQubhhZwhLI99K2CQTGkU9C0P2PWznkBv2N3Fjmjn5BjJRIDS2zDbF24CpKF2zKkxg57lD3+u1jk2jVxxQ+jgILzOJ+PeDtHKePohHn1YvC8VZQqGZBjBFdzJld9E5OkCK88NAcUrsn6OBdS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=muzmQkJo; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FVDxSnRjvGM2OT4FPdh+qpE0hswFsPCnnog2ea7qia0=; b=muzmQkJoKVJmAvhfswVPomxafQ
	0bInummlxk+x+eTodUt0JWs3xU2m/tkSS799h24V6o92kEYn4/qFIK9FOdhR5uOFTppJ5QTnRHtdU
	eFLiJIRZFikp6LbMJd4Lu/bhrWjbr3+V6fc9V/xmh+taC/JIYeAzzrb2thQOSIYF6uS1mLmzsaQNQ
	/LSUxKrIEPqJAVOKNPr2fq1U35hAY4zaGoDsgC1RvpUHse0zExVHk3FRIB98XPLdlO9XuPhgtihro
	wgsuhW6n/s0/VgD2wjhuoJo1EN/45RrWl5zUJFtEh2NDofr6u+gh9rmG++njFedJNnDx2lf96D2uv
	SbtnLwNw==;
Received: from [177.191.196.76] (helo=[192.168.0.154])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1umuZH-00Eeqp-F1; Fri, 15 Aug 2025 15:34:03 +0200
Message-ID: <e2238a17-3d0a-4c30-bc81-65c8c4da98e6@igalia.com>
Date: Fri, 15 Aug 2025 10:33:57 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/9] ovl: Enable support for casefold layers
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Theodore Tso <tytso@mit.edu>,
 linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 kernel-dev@igalia.com, Gabriel Krisman Bertazi <krisman@kernel.org>
References: <20250814-tonyk-overlayfs-v5-0-c5b80a909cbd@igalia.com>
 <cffb248a-87ce-434e-bd64-2c8112872a18@igalia.com>
 <CAOQ4uxiVFubhiC9Ftwt3kG=RoGSK7rBpPv5Z0GdZfk17dBO6YQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <CAOQ4uxiVFubhiC9Ftwt3kG=RoGSK7rBpPv5Z0GdZfk17dBO6YQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Amir,

On 8/14/25 21:06, Amir Goldstein wrote:
> On Thu, Aug 14, 2025 at 7:30 PM André Almeida <andrealmeid@igalia.com> wrote:
>> Em 14/08/2025 14:22, André Almeida escreveu:
>>> Hi all,
>>>
>>> We would like to support the usage of casefold layers with overlayfs to
>>> be used with container tools. This use case requires a simple setup,
>>> where every layer will have the same encoding setting (i.e. Unicode
>>> version and flags), using one upper and one lower layer.
>>>
>> Amir,
>>
>> I tried to run your xfstest for casefolded ovl[1] but I can see that it
>> still requires some work. I tried to fix some of the TODO's but I didn't
>> managed to mkfs the base fs with casefold enabled...
> When you write mkfs the base fs, I suspect that you are running
> check -overlay or something.
>
> This is not how this test should be run.
> It should run as a normal test on ext4 or any other fs  that supports casefold.
>
> When you run check -g casefold, the generic test generic/556 will
> be run if the test fs supports casefold (e.g. ext4).
>
> The new added test belongs to the same group and should run
> if you run check -g casefold if the test fs supports casefold (e.g. ext4).
>
I see, I used `check -overlay` indeed, thanks!

>> but we might as
>> well discuss this in a dedicated xfstest email thread if you want to
>> send a RFC for the test.
>>
>> [1]
>> https://github.com/amir73il/xfstests/commit/03b3facf60e14cab9fc563ad54893563b4cb18e4
>>
>>
> Can you point me to a branch with your ovl patches, so I can pull it
> for testing?

You can find my branch here, based on top of vfs.all: 
https://gitlab.freedesktop.org/andrealmeid/linux/-/commits/ovl_casefold

I fixed the following minor issues:

- 4/9: dropped the `kfree(cf_name);` - 6/9: fixed kernel robot warning 
`unused variable 'ofs'` - 8/9: change pr_warn_ratelimited() string

>
> Feel free to fix the 2 minor review comments on v5 in your branch.
>
> Thanks,
> Amir.

