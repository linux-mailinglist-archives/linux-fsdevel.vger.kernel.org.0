Return-Path: <linux-fsdevel+bounces-20496-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C028D416B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 00:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D14D1F226FD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 22:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D2E16F0E3;
	Wed, 29 May 2024 22:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="EEyJS1aH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sandeen.net (sandeen.net [63.231.237.45])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B07169AC5;
	Wed, 29 May 2024 22:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.231.237.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717021985; cv=none; b=azYolZ9171e/UVP+tLrrfSmkG1Sh51B/p9+1vA9I3ih348El6DwqmNx3QNHlgu2kcaJYIfdh/o4ldwsXH7VbbJ22XgShM7ox8dlboj4qTMJzzlpU5EPTj9UK49sLgCntdKgsQeL2f/bFV/knzMF5ZqKqfIr9gvLBT9KyPiwJg2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717021985; c=relaxed/simple;
	bh=vPSCn1US8q24nZmKVQnkbEnaWwJsPIAVyMitRy5BeBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nBNq0k9bgl+Jmm4sr1TRlb/wOisz0hAoK4NrE6pbfIdEj632/RKIdf3PBB2BVnxJTvFmIvsldREAV0+18x6X5sx8vE5D8rUXE3aIDDh7ppriAfHyw/MFMVU2zL3MKUc7XZ9kgA8OLPKSlHRQ7z9zT8ppwoKYHesl2M5Nkp1usNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=EEyJS1aH; arc=none smtp.client-ip=63.231.237.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Received: from [10.0.0.71] (usg [10.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by sandeen.net (Postfix) with ESMTPSA id ACBA511656;
	Wed, 29 May 2024 17:33:01 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sandeen.net ACBA511656
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net;
	s=default; t=1717021981;
	bh=EtX22mhDFfHazQS1F4btZ405qhG1Tw24hE685V275AI=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=EEyJS1aHmol+c+dTF8mt4od7E6tbCzkUhmUY5zmE/G+l2K2wIXsO89Xd257h7oEsD
	 VqARRPDZT9dhIk2b2On6rCGp0S0iJODjtMyhMJ6p2eVV0eQlQsrECM1y9PyIQ1nxSA
	 daiPia76ZO0DrlTOjYywZACWXBtOQAg/d2P5k+iY3aCXOkm8YCXSBynaBWnSk3X4j7
	 y9zXT0LCC4TYOnGA5CEy36ea6noU02KEBSqBxPOYyzxwcphL4JY593irV65474z4Lr
	 DD5cTAllMe26NHOscqkVXYRh5lDTELKCTgKEJINgMJKQRKSHkV+E6EPghRd5UURkgX
	 UIyDczLRVmFYw==
Message-ID: <7f676fbd-5858-4c9a-a4e5-9828955db1f5@sandeen.net>
Date: Wed, 29 May 2024 17:33:00 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] debugfs: ignore auto and noauto options if given
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Christian Brauner <brauner@kernel.org>, Eric Sandeen <sandeen@redhat.com>,
 linux-renesas-soc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, David Howells
 <dhowells@redhat.com>, linux-kernel@vger.kernel.org
References: <20240522083851.37668-1-wsa+renesas@sang-engineering.com>
 <20240524-glasfaser-gerede-fdff887f8ae2@brauner>
 <39a2d0a7-20f3-4a51-b2e0-1ade3eab14c5@sandeen.net>
 <oste3glol4affqkftofn6hgnldurnn4ghutsdmfl5bjgzwz66o@i4fneiudgzmu>
Content-Language: en-US
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <oste3glol4affqkftofn6hgnldurnn4ghutsdmfl5bjgzwz66o@i4fneiudgzmu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/29/24 5:05 PM, Wolfram Sang wrote:
> Hi Eric,
> 
> thanks for replying!
> 
>> @Wolfram, what did your actual fstab line look like? I wonder what is actually
>> trying to pass auto as a mount option, and why...
> 
> My fstab entry looks like this:
> 
> debugfs /sys/kernel/debug       debugfs auto            0       0
> 
> This happened on an embedded system using busybox 1.33.0. strace is
> currently not installed but I can try adding it if that is needed.
> 
> Happy hacking,
> 
>    Wolfram
> 

Welp, that looks like it:

# strace busybox mount /debugfs-test
...
stat("debugfs", 0x7fffc05d3d60)         = -1 ENOENT (No such file or directory)
mount("debugfs", "/debugfs-test", "debugfs", MS_SILENT, "auto") = -1 EINVAL (Invalid argument)
write(2, "mount: mounting debugfs on /debu"..., 66mount: mounting debugfs on /debugfs-test failed: Invalid argument
) = 66

This does not appear to be unique to debugfs:

# grep tmp /etc/fstab 
/dev/loop0	/tmp/xfs	xfs	auto 0 0
# strace busybox mount /tmp/xfs
...
mount("/dev/loop0", "/tmp/xfs", "xfs", MS_SILENT, "auto") = -1 EINVAL (Invalid argument)
write(2, "mount: mounting /dev/loop0 on /t"..., 64mount: mounting /dev/loop0 on /tmp/xfs failed: Invalid argument
) = 64

# dmesg | grep auto | tail -n 1
[ 1931.471667] xfs: Unknown parameter 'auto'

This looks to me like a busybox flaw, not a debugfs bug (change in unknown
argument behavior notwithstanding...)

-Eric

