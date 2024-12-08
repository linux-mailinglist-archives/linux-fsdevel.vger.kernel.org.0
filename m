Return-Path: <linux-fsdevel+bounces-36699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 121679E82CD
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Dec 2024 01:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF71E1884809
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Dec 2024 00:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD5828EC;
	Sun,  8 Dec 2024 00:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="bAjxafTs";
	dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="WABFUFH2";
	dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="eZPlMsHw";
	dkim=neutral (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="JsnKPETn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.tnxip.de (mail.tnxip.de [49.12.77.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7881876
	for <linux-fsdevel@vger.kernel.org>; Sun,  8 Dec 2024 00:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.77.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733616685; cv=none; b=qLP6cFfs5XqPkgcQTyts3bcj1e/40VwJFSYB/59FAN5Fnm9tf5CfrdMOjaJekda4YTIcSWO7OneYAAlExUO60fR3Gr5tN40iSIU8PU5rtF8uHxHLh/oFbDng/vsGI/82aw/y3ojDJX3vfUqFferd3mOkfr+VGmEABKZmqWwu4OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733616685; c=relaxed/simple;
	bh=GYHDj+VEPYaRs41cswvVwIwEeEIeE+fwz6cEvVR+xxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oveQJE3la1OW47SdQAgOHXEFnZwgXKf3+Flam1KS5JrAEUCaT8eksvMNqUJFaYvGF8zutb0oVpyM+dU4AaYVJDbkRKE5eUv5gqk1ZMx4CSO0ybUuggWQm17Z8rT9mlmn1Q49N1v+oiVPhnQFnfR6Bh1dE2flXvwiWCeZVf4fnvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tnxip.de; spf=pass smtp.mailfrom=tnxip.de; dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=bAjxafTs; dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=WABFUFH2; dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=eZPlMsHw; dkim=neutral (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=JsnKPETn; arc=none smtp.client-ip=49.12.77.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tnxip.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tnxip.de
Received: from gw.tnxip.de (unknown [IPv6:fdc7:1cc3:ec03:1:8215:8949:cdce:4764])
	by mail.tnxip.de (Postfix) with ESMTPS id DEF00208CC;
	Sun,  8 Dec 2024 01:11:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tnxip.de; s=mail-vps;
	t=1733616676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GYHDj+VEPYaRs41cswvVwIwEeEIeE+fwz6cEvVR+xxg=;
	b=bAjxafTslhBOUh7VmE5Se7ElAV3kL63u1EItawDbXDh+R6jNdWkNGC/ySYtOCos62Z+rd3
	nkQ836iZIZu2wXOIV0ZshlPvDLivDGcGwbqxpxrqHYueW+M8MwO7ipdz/fXUiD29805fMc
	XS5sJM6CP61spxt2P1VE4hiCJDVoO3U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=tnxip.de;
	s=mail-vps-ed; t=1733616676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GYHDj+VEPYaRs41cswvVwIwEeEIeE+fwz6cEvVR+xxg=;
	b=WABFUFH2Vd37QqKT9ZOJQDjDg19DIYgMSCPsTt3EoycvywVQhsHgiyv3RmziHeEo5eY0Hl
	0bqPmN10j2geiyDw==
Received: from [IPV6:2a04:4540:8c02:dc00:6184:83fd:f934:64f6] (highlander.local [IPv6:2a04:4540:8c02:dc00:6184:83fd:f934:64f6])
	by gw.tnxip.de (Postfix) with ESMTPSA id 202772005EB73;
	Sun, 08 Dec 2024 01:11:16 +0100 (CET)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=tnxip.de;
	s=mail-gw-ed; t=1733616676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GYHDj+VEPYaRs41cswvVwIwEeEIeE+fwz6cEvVR+xxg=;
	b=eZPlMsHwTyP7xa5rcccDobBIjXgNOqILxd4pdP4rJbxPqedsGSqGG4zsAkNUPk0MOKYYtb
	dpp8Q19wxuknSGCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tnxip.de; s=mail-gw;
	t=1733616676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GYHDj+VEPYaRs41cswvVwIwEeEIeE+fwz6cEvVR+xxg=;
	b=JsnKPETnbNwhBNtdCOijVIjciRKM4lW9AN1xHLC94sn7QIXxdVeEzmtN37PCWwjk9RKuXU
	+kdQboUd1WjgzXRBrOFwHvpp0Z3BhSTpQNe9owRw3G53zVdUwfkaqTBZzT+HXt+NF8EsO+
	SsLJpd2883H4IVJWf/7ZPWa/x6RgrjA=
Message-ID: <9595459f-c6fc-4981-b1c7-bd349aee77c7@tnxip.de>
Date: Sun, 8 Dec 2024 01:11:15 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: silent data corruption in fuse in rc1
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Miklos Szeredi <mszeredi@redhat.com>, Josef Bacik <josef@toxicpanda.com>,
 Joanne Koong <joannelkoong@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 linux-fsdevel@vger.kernel.org
References: <p3iss6hssbvtdutnwmuddvdadubrhfkdoosgmbewvo674f7f3y@cwnwffjqltzw>
 <cb2ceebc-529e-4ed1-89fa-208c263f24fd@tnxip.de>
 <5zj4d3e7vscemwkod2kdz47tisumniv5jkmzlbaftjbb7vphn6@ncpmjph7tv77>
Content-Language: en-US, de-DE
From: =?UTF-8?Q?Malte_Schr=C3=B6der?= <malte.schroeder@tnxip.de>
In-Reply-To: <5zj4d3e7vscemwkod2kdz47tisumniv5jkmzlbaftjbb7vphn6@ncpmjph7tv77>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 08/12/2024 00:39, Kent Overstreet wrote:
> On Sun, Dec 08, 2024 at 12:01:11AM +0100, Malte Schröder wrote:
>> On 07/12/2024 22:58, Kent Overstreet wrote:
>>> Hey Miklos, I've got a user who noticed silent data corruption when
>>> building flatpaks on rc1; it appeared when using both bcachefs and btrfs
>>> as the host filesystem, it's now looking like fuse changes might be the
>>> culprit - we just got confirmation that reverting
>>> fb527fc1f36e252cd1f62a26be4906949e7708ff fixes it.
>>>
>>> Can you guys take it from here? Also, I think a data corruption in rc1
>>> merits a post mortem and hopefully some test improvements, this caused a
>>> bit of a freak out.
>> Hi
>> all,                                                                        
>>                                                                              
>>  
>> I did report this. What I encountered is flatpak installs failing on
>> bcachefs  
>> because of mismatching hashes. I did not notice any other issues, just
>> this    
>> thing with flatpak. Flatpak seems to put downloaded files into
>> directories     
>> mounted with "revokefs-fuse" on /var/tmp. So far I could only reproduce
>> this on
>> bcachefs, it does not happen when I make /var/tmp a tmpfs or when I
>> bind-mount
>> a directory from a btrfs onto
>> /var/tmp.                                        
>>                                                                              
>>  
>> To me there seems to be some bad interaction between fuse and
>> bcachefs.        
>>                                                                              
>>  
>> Reverting fb527fc1f36e252cd1f62a26be4906949e7708ff fixes the issue for
>> me.     
> You said it happened with btrfs as well?
That was my first assessment, but my method was flawed. I corrected
later. Sorry for the confusion.

