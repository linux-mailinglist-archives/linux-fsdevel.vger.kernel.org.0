Return-Path: <linux-fsdevel+bounces-75983-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MH6C5xbfWm/RgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75983-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 02:32:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7BEC0035
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 02:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E84473027B4A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 01:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E0331985B;
	Sat, 31 Jan 2026 01:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5v7s4RF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1182A28DC4
	for <linux-fsdevel@vger.kernel.org>; Sat, 31 Jan 2026 01:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769823109; cv=none; b=H6yeAWvGCbTprQN0h6aDrwXN/LgqnsW81EK3xweq2NmloMY2QJIv2oFaHTpECO3Mh9tDwRRxVV751gpGJg24aOKYDaZoIopuKKkOFFzNltLxlzX7zxlXOCP9aG27RQ7bmKZZW7CSbMoJtBCTHGgtr9oJVU3a3UHoQZ8M77DrOwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769823109; c=relaxed/simple;
	bh=uxSptuxlUKEWbRT4Igc31bABpRpRKBUi1VOuQjhIz3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hLy9NO+rbmDqfHY9Hbq50GHwacciQtrB/s35aym3huz/ytvo+MjNd2sqCHKyKqGIKUT2jOu7FymvKuV8X4QLnvKj57vAm7Pk709MXCTI9mCmOC7ZcLac3GodwWpz8SYgvDuHsikRrvuYIvd/Rhlb+hF1I4AI3AbzCFU6ENvPdFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F5v7s4RF; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1248d27f293so4210399c88.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jan 2026 17:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769823107; x=1770427907; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MjS5gUmrvNUnt6r0vg+c+3hL04GhprNpFcL6xVhUsws=;
        b=F5v7s4RFW8lc3h8rSc+Bm/hPByCo6FLA6lqBA7e0dL1XIoMeUd5xAbOyKHx2jXvLF1
         07x0uluV1v0S+wDlNCeJ+HoQz9ah9w+a0XJx5O78NraA8zl8CCjU/vWGPaEF01WCU2nq
         2Qlj7CSr8MRKsRKgoqX892Yz1DPTPVNHumprNcNWbLFXSZRhCYl09ChC7qDy8ASOnblG
         SXvEDeG5isOd97Adi1SH2ybSB/OKzEHEgW35tOoOQazufr26M31q8cVaquZryaJAyaW0
         +UgFrzrn+v232nbYUqGTaAbbkyjjKZkr/RuOUPmOLzBzBD8vexfbPSV+upYuXj0DSGis
         mONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769823107; x=1770427907;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MjS5gUmrvNUnt6r0vg+c+3hL04GhprNpFcL6xVhUsws=;
        b=K/9A/I3VZ9HPXIc/myqRxLy++gNzowyftoEbk1iWUzuIgJCkcue6b2HItSqGLo3Eb6
         P+E8kP1FWyDw+sLrY37GmMEm3t/hqk4tb1LCW1QaWOv2iYV1YFNXh/vn8Y3NrTFnDtn/
         bqlkSNjVC9SXHliHv5SYq7h8I1iZa78alAT6fy53jOuYodVGyqr4iaqx4oTMI2ujZGwh
         Lc+PZkBwTVswucehoHvIQ9j53hCc6DuivkXYPoorRGhwGPNz5W5Y+Mmh/DpXeJqlmY3v
         OA0ohlFhBIwacs4iLH9vMykm+IOaUPXhsP+2KHJ3HnPCiUSk7mLwwGc5nlMaz+4AuDQD
         ND+w==
X-Forwarded-Encrypted: i=1; AJvYcCWvwKlD4ivTBCwaXrEthjYkPmg5bWMlF9NuBTcQGqb/PQSwcYae2BOBScN43wpQepyhFHypl+/TofJkiMzb@vger.kernel.org
X-Gm-Message-State: AOJu0YzQmN1eLg0sR3jGOrUNvua65vZ5YnxUuvitT+QgiKfYRBpwPg8n
	YTQXK4/D2yzx7upuCGiwEuNW9QF0/T0UGRpTOtgnjMDCCP1cHiok8XD9
X-Gm-Gg: AZuq6aIPPbE1Q5fJ2E6WXy2YNRxioZvp3dItaC5XjFaWEgEyz8MTxuZKIt+fKxiN1dc
	AsNZJFyij0L9mMJKoQbb+gNKj+zomGBQEo4CPHcajsAJTV5c7363WM+e0d0yD1psoso8PROf9hH
	CKhdK9PVj2F5MFlvVILgFXcD75YIT59PrbjRhNNAEZPGV7Rsa0QFxgmqTMOSTj7YfzADrkKEiPZ
	bZf9493WlLmdMy9hHsF14LeABXHlbI7LSRA4vigOUmHMdffIt7oUr5MnqgY45S/VjuOOGlZ+ZLc
	ZQbEFQSq94lGZ0xYydRykU6kA/IHnxOb0h05dggOeB475GNQGYxoYTjnzHJcKFILgYL38Kb9xP/
	EEOrEtoQHd9/IU4/xHlLFodcuzDVg/9tM0rNiAOlf6700ZqJr3fFG3v8JqgyDmYXDexQGX9IgCl
	Ze5ExvHw42Wg4ceZaT+Nb9vfE=
X-Received: by 2002:a05:7022:2488:b0:119:e56b:c762 with SMTP id a92af1059eb24-125c1014ed5mr2266211c88.39.1769823106769;
        Fri, 30 Jan 2026 17:31:46 -0800 (PST)
Received: from [172.25.67.25] ([172.59.130.240])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9e0304bsm12535789c88.14.2026.01.30.17.31.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 17:31:46 -0800 (PST)
Message-ID: <96d01e75-337b-45cf-9950-e5d4a2981921@gmail.com>
Date: Fri, 30 Jan 2026 17:31:39 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] btrfs: defer freeing of subpage private state to
 free_folio
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Matthew Wilcox <willy@infradead.org>
Cc: boris@bur.io, clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20260129230822.168034-1-inwardvessel@gmail.com>
 <776e54f6-c9b7-4b22-bde5-561dc65c9be7@gmx.com>
 <aXw-MiQWyYtZ3brh@casper.infradead.org>
 <00d098da-0d01-43f9-9efb-c18b6e8a771e@gmail.com>
 <ee4898be-b0e0-4163-b734-c2891239dce6@gmx.com>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <ee4898be-b0e0-4163-b734-c2891239dce6@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75983-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmx.com,infradead.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inwardvessel@gmail.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CC7BEC0035
X-Rspamd-Action: no action

On 1/30/26 12:36 PM, Qu Wenruo wrote:
> 
> 
> 在 2026/1/31 03:40, JP Kobryn 写道:
>> On 1/29/26 9:14 PM, Matthew Wilcox wrote:
>>> On Fri, Jan 30, 2026 at 01:46:59PM +1030, Qu Wenruo wrote:
>>>> Another question is, why only two fses (nfs for dir inode, and 
>>>> orangefs) are
>>>> utilizing the free_folio() callback.
>>>
>>> Alas, secretmem and guest_memfd are also using it.  Nevertheless, I'm
>>> not a fan of this interface existing, and would prefer to not introduce
>>> new users.  Like launder_folio, which btrfs has also mistakenly used.
>>>
>>
>> The part that felt concerning is how the private state is lost. If
>> release_folio() frees this state but the folio persists in the cache,
>> users of the folio afterward have to recreate the state. Is that the
>> expectation on how filesystems should handle this situation?
> 
> I believe that's the case.
> 
> Just like what we did in btrfs_do_readpage() and prepare_one_folio().
> 
> There is no difference between getting a new page and a page that is 
> released but not removed from the filemap.
> 
>>
>> In the case of the existing btrfs code, when the state is recreated (in
>> subpage mode), the bitmap data and lock states are all zeroed.
> 
> That's expected.
> 

Thanks all for the feedback. I get it now that we should treat it like a
fresh folio where applicable. With that said, I may have found a path
where unguarded access to the private field is happening. I'll send a
patch shortly and you can let me know your thoughts.


