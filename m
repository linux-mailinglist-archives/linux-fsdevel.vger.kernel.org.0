Return-Path: <linux-fsdevel+bounces-49881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BC8AC45E4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 03:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97D227A3615
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 01:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FA086347;
	Tue, 27 May 2025 01:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="DtxVzkVk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71330FC0B
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 May 2025 01:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748309355; cv=none; b=eIlmrqjVY09dmnnQsd0+iz/TXe9XaKRxmd4hLEHnlriUPvkGyMHiI3Onor7an0sRLuS7dYUvUqY+K/0X9VQkWnn1IuUkU/nbcvza6s4iSBKyxMSrPvct1p3l1IM4b/R/NQ62HjgBeZiLaOSvX3YLlfMuddhxxOPGWpQYui/iFtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748309355; c=relaxed/simple;
	bh=5IibViLmmoFeOM/M7bnKdxviIlqJa76MWdYHHM96YWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mg9LP8/LjO47CE2JvGN+BdXBebivq1s2PsgKp1l9bGS/SA7PO2qB6EQHfPx2tlF15V++xDUAsPVP32jQOQKNpMYqkkxmfRg28QD7rdkqgJ16/XUuU+rY0kKW+QGdqWQDLQruuywfu8S4BZ6f5tFdMAxfkhWuMG5BZ0KperkdcX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=DtxVzkVk; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3dc729471e3so8813355ab.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 May 2025 18:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1748309351; x=1748914151; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kkh0kZy2WTvy+WvQ8T2v5I4CZ1YkRT9jaoraVAdG8jA=;
        b=DtxVzkVkNpiL0jexDexA6UFRUP4O6KEaAb31Uwjg81rMIvXNyXSHrlw7WFVVePWw7r
         ayp9MEcN3Lv4PbMbrklN9mkaCITHjxFfRa+uNpmVs4XPg2LHSdNi0cJXHABfG80PpypC
         YT441iZbCrHqqKXUJjfy/qRov1kphJETZVwWYOTNEpw/lOhG4bMCTlYWOTs1ihANf68Y
         NgFNSe7HKMS7idxoZIER0pS6deBon3eG0M81WM3Q5xsXnFAUtbOu6GUwdreTCxFhtxDT
         OwGnHTrLrCUVY5u8qkUhJGQXDvt7HTTGNY+iEqr6DYBXXx0ptRG1UHX9qmyf2qHO0Pmj
         bLyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748309351; x=1748914151;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kkh0kZy2WTvy+WvQ8T2v5I4CZ1YkRT9jaoraVAdG8jA=;
        b=dfPVnJ1QAZ/Ewy5chlwpgFUZZPt+iz1XReM1op1QF2l3fkl9dP1YOJNkd984nQOODk
         wp7o7edKT4rXWvZ7i9AP0t/WuTLrd+I3sopKjd2uh6A9yjhJl55/kK1TLwTUU8Bzzf01
         yHgH0FxC1q5Ow1tIg1EUXKEVrVMpgnwI75tbJryHm9M6nXzRMRt0XplTPpXQXowIUN1Z
         InMaY143nmurWmeHP4sSTd0ikCkC3jjeqzHVI2zDngBnT3+uRsZKchKprChx64R3HYmk
         5zecodEjdmfTZI6okZn2tlyKP7eS4zn0ztiw8pNf1A3xf7G1QQdNR6n3RQ6zQoRANs/W
         NLVA==
X-Forwarded-Encrypted: i=1; AJvYcCW1zOGTA5kCBTlFRNisYW7n8L5O0fuuKMYPeIdFKSLclDk3n2ChYSxAXt2ZcBHcUe6eV6kuvd5/5cZWd+ct@vger.kernel.org
X-Gm-Message-State: AOJu0YyoFNEy9upXUxNAlrlOmMPrmvprxIwNjmHp8bWLFDeQWmJ07u55
	S505I0sbv4TnqfyMQpu/bWKUaATCWcW+X0z53dbooqqbOUc3lgiy3CKrrWWHhp0E3uQ=
X-Gm-Gg: ASbGncuL6siiceC62F5ZAY9Af5aqPiJUWmmNm6wT2jDdWcaNx2msSBpA8HoXYYcIv2N
	Jb8+twRgawlOez9x+MGIEry5rG97jY/aFWazLaDk35BF5pUeHXWJnwSy5HAo0IY2O/rZq3zmPyk
	p4dwZ/azTuI7LxpXJQHYQoUEyMF3PeshTFmi4unb1NL65E9CQH5zEOuH9UZx6IP/bGlnxwCyK/p
	wydkrFOPUjOyVIQxXGjmGdr6hrwD6NrZL9H4hWBC7pYm9xLKBVKkNOCwd8Ea70nWpZ9Dc+tx5he
	r02l2JCPGOj7phW3xwmSMkKyN2nDoIVPhYehdgJQVrC2DO5m
X-Google-Smtp-Source: AGHT+IFgFAOam5L4wAa+zW2lPmfP5Ml6npe4O+tzECWQczGPCRtVYav8P+95ehVvWSC6sg3TR1o4dQ==
X-Received: by 2002:a05:6e02:1c25:b0:3dc:8b57:b76c with SMTP id e9e14a558f8ab-3dc9b68e0c3mr80333845ab.9.1748309351472;
        Mon, 26 May 2025 18:29:11 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fbcc3b1c90sm4950760173.56.2025.05.26.18.29.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 May 2025 18:29:10 -0700 (PDT)
Message-ID: <af92aeab-706c-4e72-8ccd-826a492afb1c@kernel.dk>
Date: Mon, 26 May 2025 19:29:09 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] regression from 974c5e6139db "xfs: flag as supporting
 FOP_DONTCACHE" (double free on page?)
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
 Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
 "Darrick J. Wong" <djwong@kernel.org>, Christian Brauner
 <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <20250525083209.GS2023217@ZenIV> <20250525180632.GU2023217@ZenIV>
 <40eeba97-a298-4ae1-9691-b5911ad00095@suse.cz>
 <431cb497-b1ad-40a0-86b1-228b0b7490b9@kernel.dk>
 <6741c978-98b1-4d6f-af14-017b66d32574@kernel.dk>
 <3d123216-c412-4779-8461-b6691d7cafc7@kernel.dk>
 <20250526235600.GZ2023217@ZenIV>
 <5a66f3f5-7038-4807-b744-d07103ebaea2@kernel.dk>
 <20250527012431.GA2023217@ZenIV>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250527012431.GA2023217@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/26/25 7:24 PM, Al Viro wrote:
> On Mon, May 26, 2025 at 06:58:47PM -0600, Jens Axboe wrote:
>> On 5/26/25 5:56 PM, Al Viro wrote:
>>> On Mon, May 26, 2025 at 11:38:53AM -0600, Jens Axboe wrote:
>>>>> I'll poke a bit more...
>>>>
>>>> I _think_ we're racing with the same folio being marked for writeback
>>>> again. Al, can you try the below?
>>>
>>> It seems to survive on top of v6.15^^
>>
>> Thanks for testing, Al! Assuming it goes without saying, but that's 6.15
>> with 478ad02d6844 reverted, right?
> 
> That's 6.15 without two last commits - 478ad02d6844 and the version bump ;-)

OK good, I would've been confused it not, but never hurts to confirm...

FWIW, have a branch here:

https://git.kernel.dk/cgit/linux/log/?h=dontcache

with the read/write side patches, and finally the revert as well.
There's a consolidation patch that can be done on top in terms of a
cleanup, but figured it was better to keep that separate from the actual
bug fix.

-- 
Jens Axboe

