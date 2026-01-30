Return-Path: <linux-fsdevel+bounces-75954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEUDKPTofGlTPQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 18:23:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C232BD01E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 18:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AED21303D7EA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 17:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699EB35770D;
	Fri, 30 Jan 2026 17:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTCgV0dt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8576834A794
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jan 2026 17:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769793015; cv=none; b=Khkx0yQfYK7l/v8OYow9I6Q2BVKkDoqIlo6ph1MeQyo/GsC6Tc5q5nunS3AXXw4MKtNLCL6WrMNfQD7Z4UDIsVBtRM956zOH+FRvzSnAEWDsGQD5+6JUp1WFJ4M15w2g+38jJsU2mY1MXl//5vgTiSBO/ADzVjSEkz0+Zb8Fa18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769793015; c=relaxed/simple;
	bh=9Qg6KVzRn8ED/ksxd36hCTObnVpqpAHvaJHihhA84FE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RvPJMPgNFey0s8eQ0yE3sb6oGqM2bnPfzrIFQs99vZM5vuYSonOMLG6iEkRU3WJGhigq8ywCyc6LGXdlcMNwt28OlEfnibyXQBVOZbKBVdE7QWjHMLeKXr8kRCt3G7cqD+wQQInId8dKaYIGe4u43BB15rs/t15MmCLwxIyoOBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eTCgV0dt; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2b70abe3417so5393746eec.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jan 2026 09:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769793014; x=1770397814; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qEv+1jOdrtgo6ukKhRIPZ07AVihRt5jwSiOESTmd48o=;
        b=eTCgV0dtRtkD4RVHSg87HSyE7M+9hT4PD8hwJ5C76vHkUlRYTJVuvYslwR7jm3Tky9
         XMKoFK+VYeyQnVZGwwnG3GVPjnAaB9XXt7ThMRFavcx92odSCDlMEao3FAtwOlfOQzl/
         9zwcPK2qt4tWvHbGuc1hCOILRKm0l4S25IqoaYEdOI0waJCLVGRCLxk94EpJB1tGx91d
         rkVgZGqg6kRjNguqxCcllOSb7IfEP27n/+YA/aLUlmgqCxnyGgn1boQVR8NoGMpe02PC
         VFWiyHpa1UXh7jePLhmNhHuf03aomfQBxYldc3W0vKuUL8v1z5oB+MdMCM3CvlN5EPx1
         9VYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769793014; x=1770397814;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qEv+1jOdrtgo6ukKhRIPZ07AVihRt5jwSiOESTmd48o=;
        b=NDU+YYHXfnM9ePgBC8yI/BsmXTt6j5uVS5d8NoNRza8yFPRQIWWygmWWmijs2JwtFK
         MfpoPfCB4tVbQhJ2KGPDpcrpzshCTGcAK2E93J0yE6Vf7HzVd+Q5EseOfLO0pU492qZd
         4VmrP1GwHq/yBqYRMenAgkauktX0CAudiLgjUZ6REJZ51PIoizDAc5SQzzqcrzD1RXPQ
         rYs3Xjnk15HFemTxv8mleojbo4WCRywq++/mNKvZyjEqbzxOuJGVQSecdZtVpDoiET4j
         v8PlmxIzMDmYhZEVijP/IGNvMoWENJZBVZAatlNZ49Vmvvkih8FTroe8ITZLI008wGBE
         TJQw==
X-Forwarded-Encrypted: i=1; AJvYcCUmUUJKawkU0XNDhEZ9iXwSuj1W8+r4tt+EQxiTCRby4QIknkBCoFzrrzI4OVQ0jJ+nAHM2OwmombFX91nv@vger.kernel.org
X-Gm-Message-State: AOJu0YzdOhkBumTRgtDqh1tWi/XH4UpXKahF2UNVTXJHBnnpqUx91Q2U
	Y33fF3ngyePisnB2yfcZdQpYwMWIGoxXzmBz54eygNbbbnvxhnAyd8pC
X-Gm-Gg: AZuq6aIRmP/JMbgZGqXiVQ3velK0QnpSW9k3DbhQaHEn+dgAByjVtW2GOdIINak9NP6
	xvnacTaht+yXjv4WsT8R3/PHlIJOau8B0CqulPFCqj2nH8Qt6bka0CI9ppc0h2BbPKcg2yanNrs
	WElr24FeGIQRjI5yamMaaqjhf45fcHjQ9172khMtKpbwuwdf7pSYYB7YwHm8Ftf9LLXPFHEePwH
	xXZARHGPJ7Cbx9SLuL9YnoJLvwHUV7Q80UOiKFYAUUAdhDacCLZ4ASJsEYVHIEZRjxx6hzkdhJy
	LJ+8rg2Hq00DUQnFUQiVpixIVNzocWk43YY9/6DLjejMjw0B0Uwz3XeZstCI9KZwOpjJsnX2o4g
	iv3jHhJxsFgrLbXEzfn9NBSa5hLvFsenxmzOkxpGp5SYv31hVD91A+g5UL7xlvw6Jr1sL0wuuLo
	B3pxSe5dwd1YQqgdM9itatuqVyKrUKGcMWt9wmH1d7
X-Received: by 2002:a05:7300:434f:b0:2b7:1746:c947 with SMTP id 5a478bee46e88-2b7c86268ebmr1882058eec.6.1769793013515;
        Fri, 30 Jan 2026 09:10:13 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1151:15:f2f0:9d80:548:2415? ([2620:10d:c090:500::797a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a16eab80sm11714614eec.9.2026.01.30.09.10.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 09:10:13 -0800 (PST)
Message-ID: <00d098da-0d01-43f9-9efb-c18b6e8a771e@gmail.com>
Date: Fri, 30 Jan 2026 09:10:11 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] btrfs: defer freeing of subpage private state to
 free_folio
To: Matthew Wilcox <willy@infradead.org>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: boris@bur.io, clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20260129230822.168034-1-inwardvessel@gmail.com>
 <776e54f6-c9b7-4b22-bde5-561dc65c9be7@gmx.com>
 <aXw-MiQWyYtZ3brh@casper.infradead.org>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <aXw-MiQWyYtZ3brh@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75954-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[infradead.org,gmx.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inwardvessel@gmail.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0C232BD01E
X-Rspamd-Action: no action

On 1/29/26 9:14 PM, Matthew Wilcox wrote:
> On Fri, Jan 30, 2026 at 01:46:59PM +1030, Qu Wenruo wrote:
>> Another question is, why only two fses (nfs for dir inode, and orangefs) are
>> utilizing the free_folio() callback.
> 
> Alas, secretmem and guest_memfd are also using it.  Nevertheless, I'm
> not a fan of this interface existing, and would prefer to not introduce
> new users.  Like launder_folio, which btrfs has also mistakenly used.
> 

The part that felt concerning is how the private state is lost. If
release_folio() frees this state but the folio persists in the cache,
users of the folio afterward have to recreate the state. Is that the
expectation on how filesystems should handle this situation?

In the case of the existing btrfs code, when the state is recreated (in
subpage mode), the bitmap data and lock states are all zeroed.

