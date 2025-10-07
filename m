Return-Path: <linux-fsdevel+bounces-63560-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09AA3BC23CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 07 Oct 2025 19:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 687DE3B1164
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Oct 2025 17:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D60B2E8B97;
	Tue,  7 Oct 2025 17:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="oJyoRanE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1FF34BA34;
	Tue,  7 Oct 2025 17:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759857525; cv=none; b=OPH/KeiaYXTld+XcDLPhr6s27ojUnE/na4BY6L6TlYoNBSQoOAeuBc4/HH5tgbwU7lZrWYYgrTj3gGcDbGf1oGJ2A2PpDAGYormrtkVG+3NUOwwl5BLTI9lN8rxbMa+OwOgwbvTVlYryNOXW6ns9B+hyCmYSphgiwAyikjivOVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759857525; c=relaxed/simple;
	bh=dMf7/nWrPEAfCEel8RTbGaAKNbjuKalsfD7v7Px2e2c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=chycCK7NXlQNvq+D4iYLNK/hdGIBnV+hRaMU3KQJvXfxMwBHznp4d4hMHWnTPbMc1g1DU1H1UIOTI8pi6RgMTjGyfr+WgMGnNFGoVKBGpO58BN4KC+1jFfKCS+4lIzzpRd59hkYEg2w1JFZEpFWufsw5GZtQLpqrx59IUqifqpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be; spf=pass smtp.mailfrom=krisman.be; dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b=oJyoRanE; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krisman.be
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3F1B720611;
	Tue,  7 Oct 2025 17:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
	t=1759857515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LN3JiIQenX0k1gRiMm9O+TW/cr+5oKoRYpKNnH0RiiI=;
	b=oJyoRanEFYe7R8TRinz8cA+AUoIQ1lovSviOEw94Z8HjevowWH+1EkGEIOt4Jae57d7Nia
	BYx1dXVkQRNaP9kGmsKBgnTQq5uDvRymlbrK5O0LTSatZ0Dmts8NzlTjqxoeuglONcHRNA
	OyjlIC92L8+G+6oaxf5e9O2JGaFn8qxL9cul+l2xNcGuIMwWsnl2LGs3i/Sid8ZsDTc43J
	C4SjZgRiTRoIaxOAnQOVW/TZJSzxr/I0iYFTtFcm5DaWspTS5F4qtHpp3qhKYZA7gVHK3u
	k11IokFCxUDtCQYy6NjGRPinmluTysPhr9YOvEdyJKsuYOiB5tSgOOmva1ShiA==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: Christian Brauner <brauner@kernel.org>
Cc: Chuck Lever <cel@kernel.org>,  Amir Goldstein <amir73il@gmail.com>,
  linux-fsdevel@vger.kernel.org,  linux-nfs@vger.kernel.org,  Chuck Lever
 <chuck.lever@oracle.com>,  Jeff Layton <jlayton@kernel.org>,  Volker
 Lendecke <Volker.Lendecke@sernet.de>,  CIFS <linux-cifs@vger.kernel.org>
Subject: Re: [RFC PATCH] fs: Plumb case sensitivity bits into statx
In-Reply-To: <20251006-zypressen-paarmal-4167375db973@brauner> (Christian
	Brauner's message of "Mon, 6 Oct 2025 13:19:30 +0200")
References: <20250925151140.57548-1-cel@kernel.org>
	<CAOQ4uxj-d87B+L+WgbFgmBQqdrYzrPStyfOKtVfcQ19bOEV6CQ@mail.gmail.com>
	<87tt0gqa8f.fsf@mailhost.krisman.be>
	<28ffeb31-beec-4c7a-ad41-696d0fd54afe@kernel.org>
	<87plb3ra1z.fsf@mailhost.krisman.be>
	<4a31ae5c-ddb2-40ae-ae8d-747479da69e3@kernel.org>
	<87ldlrr8k3.fsf@mailhost.krisman.be>
	<20251006-zypressen-paarmal-4167375db973@brauner>
Date: Tue, 07 Oct 2025 13:18:32 -0400
Message-ID: <87zfa2pr4n.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gabriel@krisman.be

Christian Brauner <brauner@kernel.org> writes:

> On Fri, Oct 03, 2025 at 05:15:24PM -0400, Gabriel Krisman Bertazi wrote:
>> Chuck Lever <cel@kernel.org> writes:
>> 
>> > On 10/3/25 4:43 PM, Gabriel Krisman Bertazi wrote:
>> >> Chuck Lever <cel@kernel.org> writes:
>> >> 
>> >>> On 10/3/25 11:24 AM, Gabriel Krisman Bertazi wrote:
>> >
>> >>>> Does the protocol care about unicode version?  For userspace, it would
>> >>>> be very relevant to expose it, as well as other details such as
>> >>>> decomposition type.
>> >>>
>> >>> For the purposes of indicating case sensitivity and preservation, the
>> >>> NFS protocol does not currently care about unicode version.
>> >>>
>> >>> But this is a very flexible proposal right now. Please recommend what
>> >>> you'd like to see here. I hope I've given enough leeway that a unicode
>> >>> version could be provided for other API consumers.
>> >> 
>> >> But also, encoding version information is filesystem-wide, so it would
>> >> fit statfs.
>> >
>> > ext4 appears to have the ability to set the case folding behavior
>> > on each directory, that's why I started with statx.
>> 
>> Yes. casefold is set per directory, but the unicode version and
>> casefolding semantics used by those casefolded directories are defined
>> for the entire filesystem.
>
> I'm not too fond of wasting statx() space for this. Couldn't this be
> exposed via the new file_getattr() system call?:

Do you mean exposing of unicode version and flags to userspace? If so,
yes, for sure, it can be fit in file_get_attr. It was never exposed
before, so there is no user expectation about it!

Thanks,

-- 
Gabriel Krisman Bertazi

