Return-Path: <linux-fsdevel+bounces-17900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B14168B3891
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 15:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC78E1C23758
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 13:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B821147C8B;
	Fri, 26 Apr 2024 13:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="YPtAgXSN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net [178.154.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57410146A95;
	Fri, 26 Apr 2024 13:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714138609; cv=none; b=QhZTqE05zyoYFsx4kK4s6IcLop0z1l0af1PlYAi+tR8hQojohMH2Qyu4Yb63rE6EZ01F26YPg6pplj0Ms3jMCLjfz6wEwCPSGY9FO/bVOxwSYye3ZMBHcg4y1oBwuDRTAtZBTklscHcPPCT/26jyp9etJ9thnoLbC/c3ETfo+6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714138609; c=relaxed/simple;
	bh=UZEKCSMOlPugsqTdVqsYjGwVSviRJ6x6JgpVujoo2HU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FrBJ8w58mCzl6chadBhSQ2NONtJ1JDubyKbyuAc5IfYqOs4CT9uVbzmUc4lLX3oBw01AGnPfMCkzTQ1PVQXBrxCrgvzBXQydcIudwb3HVpx7IhEEtC8Bz6hOHwH7qZZuUctxR+fgBrbxd2gPsGl0b5ZlfAKnyoOR0sHYac47fVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=YPtAgXSN; arc=none smtp.client-ip=178.154.239.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0d:409f:0:640:f1f0:0])
	by forward501a.mail.yandex.net (Yandex) with ESMTPS id 28F6661B17;
	Fri, 26 Apr 2024 16:36:39 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id aaNbhfCoGa60-MnW4YCOJ;
	Fri, 26 Apr 2024 16:36:37 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1714138597; bh=BnAGBRm2IUQnHS4izm6Ni2M7N8TM+Gw+UHZPQIZQ9Qo=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=YPtAgXSNXzwu0STQORXGdAKiogKF43T0eIO8ULFeEoYuX7801hLA7RGGgHu5ERvuT
	 YVESMsL8Ix69hizTursX9xlhbfsnrV7ZA/GuVjdHhZ9m6L3jZ1nz8Qt92TfeZc4URS
	 H8UshasGupfQRZLZJxZThjQEqJFGqd69YgBs9S2g=
Authentication-Results: mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <fd05ef9e-7f6f-43b1-98ae-6b25e299dd2f@yandex.ru>
Date: Fri, 26 Apr 2024 16:36:36 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] openat2: add OA2_INHERIT_CRED flag
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org, Stefan Metzmacher <metze@samba.org>,
 Eric Biederman <ebiederm@xmission.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>,
 Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
 Chuck Lever <chuck.lever@oracle.com>, Alexander Aring
 <alex.aring@gmail.com>, David Laight <David.Laight@aculab.com>,
 linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
References: <20240424105248.189032-1-stsp2@yandex.ru>
 <20240424105248.189032-3-stsp2@yandex.ru>
 <20240425-akrobatisch-palmen-4c1e7a0f69d2@brauner>
From: stsp <stsp2@yandex.ru>
In-Reply-To: <20240425-akrobatisch-palmen-4c1e7a0f69d2@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

25.04.2024 17:02, Christian Brauner пишет:
>>   struct open_flags {
>> -	int open_flag;
>> +	u64 open_flag;
> Btw, this change taken together with
All fixed in v5.
I dropped u64 use.
Other comments are addressed as well.
Please let me know if I missed some.

Thank you.

