Return-Path: <linux-fsdevel+bounces-63402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E7DBB82E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 23:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FF8919C6BD2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 21:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE1B263C8F;
	Fri,  3 Oct 2025 21:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="Td/mgmm1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9D135898;
	Fri,  3 Oct 2025 21:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759526137; cv=none; b=ObCf0R+i6d9Pba4CF0EPHuCYk/oboyuiRCIFyYMO2BCN+nkp8rH7/C7Pe1UD1r5zLHT8jBvlPQ8ynH/SA5Gh+o0YBTNfEgH7nkjNDkM8per+1baYKnRmYC2KpjOlh1k4A8qhIVwi+Gwz8TwA2jShW9N2RO9o2GZp5kafR+51HzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759526137; c=relaxed/simple;
	bh=79Fu2ZNjQ/N/Ec4B1PG7nkujis1ZaUQxH7GYIH/vnoc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CAj6O0I+ZQSSf5eBg+N/UdK8LRXUuegF5f5geWvvL3Ptoifozsjq3AmTxlRABTlLk8DB6nfQiQYlf0M4QXNeeZKiJWe0ZbQJPgFgGIOvRflrbFdnUs+YkDX2M+cN100W/Mht5dm18uzjfGxXw15SoJ2IEeFGzDJRKXHoVZ5iDCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be; spf=pass smtp.mailfrom=krisman.be; dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b=Td/mgmm1; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krisman.be
Received: by mail.gandi.net (Postfix) with ESMTPSA id F06104429F;
	Fri,  3 Oct 2025 21:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
	t=1759526127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UZ29I7lnXw0PLwXLW62+ndq9iv4f7LygyyrcnVx9szo=;
	b=Td/mgmm1HYdAvbnYuvTe9GwmLbPuMIjKlRP/8W6B7uKtCceYtS7vjWpUd2ouGhYJgBb/EN
	LIr0IheYGvIJ5Q3nTqXtrR3faZuTOzeyFAWyms1Qe1X5uwFlptqNG8dspWDCqylC3DUp2M
	eCRlmDCWWn6VTdR+7vdVUDhYWfHL4ymYdPNU7dvdfD/vO9fTGG9sPeoPoR53xRSYiEXFWV
	479Tb7cuoFfiAxceIcuauZwE9S9MHOJNIZW7HDUQTk6y5zHJ10Ob2XXx7b4pu9uYRv5GRB
	znY+jYfhb0LIhOOn+st9TR9B1jg7WnVyN2PHyT/A/Q9AwSqeEDdYXuxnc68gpQ==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: Chuck Lever <cel@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>,  linux-fsdevel@vger.kernel.org,
  linux-nfs@vger.kernel.org,  Chuck Lever <chuck.lever@oracle.com>,  Jeff
 Layton <jlayton@kernel.org>,  Volker Lendecke <Volker.Lendecke@sernet.de>,
  CIFS <linux-cifs@vger.kernel.org>
Subject: Re: [RFC PATCH] fs: Plumb case sensitivity bits into statx
In-Reply-To: <4a31ae5c-ddb2-40ae-ae8d-747479da69e3@kernel.org> (Chuck Lever's
	message of "Fri, 3 Oct 2025 17:05:09 -0400")
References: <20250925151140.57548-1-cel@kernel.org>
	<CAOQ4uxj-d87B+L+WgbFgmBQqdrYzrPStyfOKtVfcQ19bOEV6CQ@mail.gmail.com>
	<87tt0gqa8f.fsf@mailhost.krisman.be>
	<28ffeb31-beec-4c7a-ad41-696d0fd54afe@kernel.org>
	<87plb3ra1z.fsf@mailhost.krisman.be>
	<4a31ae5c-ddb2-40ae-ae8d-747479da69e3@kernel.org>
Date: Fri, 03 Oct 2025 17:15:24 -0400
Message-ID: <87ldlrr8k3.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gabriel@krisman.be

Chuck Lever <cel@kernel.org> writes:

> On 10/3/25 4:43 PM, Gabriel Krisman Bertazi wrote:
>> Chuck Lever <cel@kernel.org> writes:
>> 
>>> On 10/3/25 11:24 AM, Gabriel Krisman Bertazi wrote:
>
>>>> Does the protocol care about unicode version?  For userspace, it would
>>>> be very relevant to expose it, as well as other details such as
>>>> decomposition type.
>>>
>>> For the purposes of indicating case sensitivity and preservation, the
>>> NFS protocol does not currently care about unicode version.
>>>
>>> But this is a very flexible proposal right now. Please recommend what
>>> you'd like to see here. I hope I've given enough leeway that a unicode
>>> version could be provided for other API consumers.
>> 
>> But also, encoding version information is filesystem-wide, so it would
>> fit statfs.
>
> ext4 appears to have the ability to set the case folding behavior
> on each directory, that's why I started with statx.

Yes. casefold is set per directory, but the unicode version and
casefolding semantics used by those casefolded directories are defined
for the entire filesystem.

-- 
Gabriel Krisman Bertazi

