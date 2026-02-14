Return-Path: <linux-fsdevel+bounces-77222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBO6DfW+kGkVcwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 19:29:09 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 900E713CE20
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 19:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74DFD30157F5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 18:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341652D8DB5;
	Sat, 14 Feb 2026 18:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O3FJ5VEx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DOrKPF7F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC4E1A0BD0
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Feb 2026 18:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771093744; cv=none; b=La0DnH2Rfmv7npmI1O0rU3OHtZmNDtcTnObW6MG0OzPOny54DFKaullteRLE1fM8QJO1k2FEskw2SZq9Sfwdg1KD3E5o5tXxyV9qZxheSK01I1xLyRZ9a7Gpp5z3lUloLCiEMff9yN5ajFq9I+2GUwqK8wnF0cKUrAmYj1o7bB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771093744; c=relaxed/simple;
	bh=xgketm8c2mX6Go7ZUAVxbeJVFbH/hWwVLL5KIsUCjIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VpLcr2IadZwWce5i/e48mzpe8d8gCte6wQ/yprEXndR18WliZFNO6S13rnNwNCBBQTEYhfnATlyfWvpuBfW7GcUtiRiclTaTKHAAWm6M5Nn1t84jP9k/7V3bRsHkCFZSSojSL0U1P/1cb797/jpnoRVbPv3YvmVNV2rqSnaTZDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O3FJ5VEx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DOrKPF7F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771093742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4jRjucBZL6aCy/7jifuRxZxDNR6NSPskwAmOoovqDVY=;
	b=O3FJ5VEx5aPPgm3sI6o+y89AR73KPy+bUjazpUs/ehlZ03tOGiomnsTLG/d7R+4Y1Ugg7Z
	tNkpx8BC9dD3QSqUBIy1Ifbb42lJPfo/1EGE5jNfX2ekV6mYpFW4JvWsbD4OxX6x4UvlWC
	WKVsbh6xCfxXjMt+xqaQOK26kcrGO3o=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-_B_KRjF9PVGPZW_pUQ6yPg-1; Sat, 14 Feb 2026 13:29:00 -0500
X-MC-Unique: _B_KRjF9PVGPZW_pUQ6yPg-1
X-Mimecast-MFC-AGG-ID: _B_KRjF9PVGPZW_pUQ6yPg_1771093740
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c71304beb4so589393385a.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Feb 2026 10:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771093740; x=1771698540; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4jRjucBZL6aCy/7jifuRxZxDNR6NSPskwAmOoovqDVY=;
        b=DOrKPF7FRj6kJQRhU8Z5BbXc2TLaxeb210Y/B6Q+pPrl1OyYRadygDSNnZH1Ls83Y1
         ngR53jKAcOclbG6I3OuGuWFqqLWBwq4fWizSXhHfHP/ZGIficvyG6od4kphvgOCxG/rN
         f9MV7ELJywhmcVnjQuJ1FQw6jAWRexV7qxDQ4u+5ZxgNdasNjmxgoqWamKPs7uA4jtsL
         JjslHuAKLqTulJ5PtgS/W6fsJ2DlGtEoF6dlG79hLNBJVZuU4IYh77+gE94MAGt9ZczD
         fErqgjq8QTzrA+DTgKBEWcbj1b4GbU00H/q0o31i+jCzbrvfEPr9s79OexfxnDstf36m
         RADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771093740; x=1771698540;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4jRjucBZL6aCy/7jifuRxZxDNR6NSPskwAmOoovqDVY=;
        b=r65QAhhYFd1kojFkXYp+cmyJPMcIwrpcWd98VDxtBkJDc7vT6S7asa/VeOxYO8VaDH
         BTa9aMs6xJmcWup+S7s/NLBLVQ+ZxoavPF8LhNAczWfEuJ0Eng/0MjmEgfruCEvtePrJ
         KBE7X1cNp8HjyUYu0a4cQd4u8Evp1pYXw1tmEKa0ChaieXhMdo91BEkZfggOgcLGur4h
         nosuDGDpjghd40OKGXoLynhLvrbZys3+gKBIGhQwpDkZEmK3na5pMOjjG9+qHgAUZfhb
         myLEe3r7c5BKLo+DpIL35ze1Zho0wx0C8iZmIOO9quHwSewyaekVHWn1JrSgbBBwFiu8
         pVqg==
X-Forwarded-Encrypted: i=1; AJvYcCVpxbK6oMXpDi1MTJbkAGe81PGy4g8n7j+mQt+qWqrud0q/t5zx6g9JFXwUEwsklCGF8tEbarxr0vFTsdMm@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2vzs8HrYGlC99Ip1JR+2IQHxD/suSIjV1WN0TNEuXJPwTN6/l
	5um3ZRFTv7zYLwqYGaGRjxhZoufwh1V5UawaLk6wuHNlik2yR8WgURSDmJrXBDB/S8ZeMYcLsuM
	7QU/XFxEOqvyu41tILSoKZrV3AUSLbWXF4Qi/ocPrZ6rRd5pOB1riT8Q964dE2UUNm5g=
X-Gm-Gg: AZuq6aJmikKvj0mlbl/3pbG89Wrqu3zg6890sS7vUCpzd3poY03PkDP7KetFMv/dyfc
	ydvYraH0R+HDc8xOjw1w9GXNjC/sVX9L6DmIZB6SW5CVY9waVhOKUyH/TbrzZCKjdsjFslyrll4
	N+YjAV+f+gI0PM4aFwZ9BgBfKoM5Nrx0RqT4r4LtbmhqBS9Zvw1wF1m7uecUshvfag1cuI4hSJn
	AfrYcNU9D84JbY5jzxpIvNBfDjZqrSlG+Z75hAugqtqkNMYgIofQc6YFpec+xWk3CGhDwwJX/Tv
	Na0BKHmHWrujCtTXrTSlnCXmATf9ZROqoLtgnqfnSL/bkBjTtDNrC1lVuNKfogs0U4QPKFK3Tc2
	ovWLtwPCjjCWdVZbOPfFI
X-Received: by 2002:a05:620a:3710:b0:8c7:fdc:e853 with SMTP id af79cd13be357-8cb4225fbe0mr756916085a.1.1771093740216;
        Sat, 14 Feb 2026 10:29:00 -0800 (PST)
X-Received: by 2002:a05:620a:3710:b0:8c7:fdc:e853 with SMTP id af79cd13be357-8cb4225fbe0mr756914585a.1.1771093739817;
        Sat, 14 Feb 2026 10:28:59 -0800 (PST)
Received: from [172.31.1.12] ([70.105.242.59])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb2b20f5desm878549385a.41.2026.02.14.10.28.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Feb 2026 10:28:58 -0800 (PST)
Message-ID: <dfd0d59a-a0ca-484d-981a-55cac8d89717@redhat.com>
Date: Sat, 14 Feb 2026 13:28:56 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ANNOUNCE: nfs-utils-2.8.5 released.
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Linux NFS Mailing list <linux-nfs@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <fdf3631f-e924-4e4c-bd9f-db5b40a90bfe@redhat.com>
 <aYlpcPkq_glykQvJ@eldamar.lan>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <aYlpcPkq_glykQvJ@eldamar.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77222-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steved@redhat.com,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 900E713CE20
X-Rspamd-Action: no action



On 2/8/26 11:58 PM, Salvatore Bonaccorso wrote:
> Hi Steve,
> 
> On Mon, Feb 02, 2026 at 06:45:30AM -0500, Steve Dickson wrote:
>> Hello,
>>
>> This release contains the following:
>>
>>      * Man page corrections
>>      * min-threads parameter added to nfsdctl.
>>      * systemd updates to rpc-statd-notify.
>>      * blkmapd not built by default (--enable-blkmapd to re-enable)
>>      * A number of other bug fixes.
>>
>> The tarballs can be found in
>>    https://www.kernel.org/pub/linux/utils/nfs-utils/2.8.5/
>> or
>>    http://sourceforge.net/projects/nfs/files/nfs-utils/2.8.5
>>
>> The change log is in
>>     https://www.kernel.org/pub/linux/utils/nfs-utils/2.8.5/2.8.5-Changelog
>> or
>>   http://sourceforge.net/projects/nfs/files/nfs-utils/2.8.4/2.8.5-Changelog
>>
>>
>> The git tree is at:
>>     git://linux-nfs.org/~steved/nfs-utils
> 
> While 2.8.5 was released, I do not see yet a release commit and tag in
> the git repository, is this correct?
Sorry I was traveling and forgot do the push... It is there now.

steved.

> 
> Regards,
> Salvatore
> 


