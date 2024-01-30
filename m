Return-Path: <linux-fsdevel+bounces-9475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB32841833
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 02:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33067284F74
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 01:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CF736113;
	Tue, 30 Jan 2024 01:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWgVHKIk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7D92E40E;
	Tue, 30 Jan 2024 01:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706577295; cv=none; b=g0RHkyOy3Xc3jXmQgtZyC3RmWV09JiOoRpYTFTeNqpEK9cy8I+J+ZFV+Bgt2JFuMaAiMBdhJ1OMwdUVd2DSvrIMb3J+kQblj9FdLhNyrp6qBZIohlosRA4vIl0ndBx9/i49KYV8vFbR5nmQ0q2bwe7k2nbexiGzgwXuU/v7KjC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706577295; c=relaxed/simple;
	bh=eoJyiGl4ayk4YTXbAr04VCd2Mc9MYdaEbukUT9Fp/5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jesIxSfQhveixhW8jNA3rps5mS4Y1aIyADNR4b5SUTYicHTcS1/cuhPyDOeRG1PHadhgzF+EirhS3I+MadHmWRNHBQksicPROU/9VmyLdft+9ZlBLbItLaOVZZ52/nDSqfAGFfN2PT0/EoJWgMuT2cpIXIY+pZbOtDqSRVHuWSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CWgVHKIk; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-68c53ed6c56so7121016d6.3;
        Mon, 29 Jan 2024 17:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706577292; x=1707182092; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e/aCaBG7yhYrHtqXVGKsvyj5q1AeIV6pyFfNUjCo8V0=;
        b=CWgVHKIk/VW7wfXH/cwif1edm7P8YOyaKMHjp2kCgWEDQDSoUKCvwCapx44xkO/BnU
         mDsAY/jSOvBr/TJ0JyBGQcHhbC7Wdz2OyTVS7qBxHSQqsBdoFQmwqW8og/VZulpeigkq
         og9TjG3GHJxuYAeWK7yMwOAv8vtaCxF0qjS+dn3OGVMTLkvcLUnfCxQvrUg5LiullXBg
         OiDxrRLi7JKbs/gdRFYGQMMmfAbnRRAEcYmljszHiTV0PhWjnHQp6wFMh4p89frACKsl
         SCwwNy3GRdeTLTFBcSdZDn7N2Hm8E6ppHdOHt5E0XMoJtXhUnCAf4ihFdlSvj7nBCf+b
         8DiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706577292; x=1707182092;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e/aCaBG7yhYrHtqXVGKsvyj5q1AeIV6pyFfNUjCo8V0=;
        b=uY68Y1eJMYQNaw58RGozCjm0zhitJvbV6FRfmboxOx1PQ8n8ZkSTgwVktWQZyF9OIs
         aeVag1rTKPPYu4Nqpi8NNHhM+qJSPvfx8+4uwnckXDtFkjzEOyLi61fSXC3jyDVk66cc
         knbSuQEaLG+JUF78U7CSpTNqxmZDn3LjhuY57FFHWj8Kb9RRG7x7mNf7vJ9iDVKskNcU
         Y8JKAVLkUrb7AuttcuGUiGfLwBgubAIl8wOcRNWsrD+koJsDR+FltJnfaEVV1T1unFGo
         +ikkMphayR+7q6nrZI2mpHP6hIM+d+XIeUDralBIvMT98fXawpKnLdN5hwY0WDn3pZcc
         HrDw==
X-Gm-Message-State: AOJu0YwyD+AS8rosRoIFnS4EF8o6t2bpMYT/ooHbvf5fCXn6bJiVcr50
	F3PZpnr5VQBUg5ecxa7DxerP4ziZdaFqo9jdxmunj6A93LYwFL8Z
X-Google-Smtp-Source: AGHT+IEBL+y9RmTTPRXJWgmfIA3BgVl8nyNgmtSI7JAEYrZpS3GHYTxtiPjQdbBKmwD1Km5HR3U4nA==
X-Received: by 2002:a05:6214:1d0d:b0:681:7ad3:db0a with SMTP id e13-20020a0562141d0d00b006817ad3db0amr7727553qvd.103.1706577292452;
        Mon, 29 Jan 2024 17:14:52 -0800 (PST)
Received: from [10.56.180.189] (184-057-057-014.res.spectrum.com. [184.57.57.14])
        by smtp.gmail.com with ESMTPSA id om8-20020a0562143d8800b0068c3d2ee00fsm3001919qvb.40.2024.01.29.17.14.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 17:14:52 -0800 (PST)
Message-ID: <5b498690-5641-4070-97da-90a6a12c7b7f@gmail.com>
Date: Mon, 29 Jan 2024 20:14:50 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Dropping page cache of individual fs
Content-Language: en-US
To: Theodore Ts'o <tytso@mit.edu>, Dave Chinner <david@fromorbit.com>
Cc: Christian Brauner <brauner@kernel.org>,
 lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-btrfs@vger.kernel.org,
 linux-block@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>
References: <20240116-tagelang-zugnummer-349edd1b5792@brauner>
 <ZabtYQqakvxJVYjM@dread.disaster.area> <20240117061742.GM911245@mit.edu>
From: Adrian Vovk <adrianvovk@gmail.com>
In-Reply-To: <20240117061742.GM911245@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/17/24 01:17, Theodore Ts'o wrote:
> What is the threat model that you are trying to protect against?  If
> the attacker has access to the memory of the suspended processor, then
> number of things you need to protect against becomes *vast*.  For one
> thing, if you're going to blow away the LUKS encryption on suspend,
> then during the resume process, *before* you allow general user
> processes to start running again (when they might try to read from the
> file system whose encryption key is no longer available, and thus will
> be treated to EIO errors), you're going to have to request that user
> to provide the encryption key, either directly or indirectly.

The threat we have in mind are cold-boot attacks, same as the threat 
that dm-crypt protects against when it lets us wipe the LUKS volume 
key.We want to limit the amount of plain-text user data an attacker can 
acquire from a suspended system.

As I mention elsewhere in this thread, the key word for me is "limit". 
I'm not expecting perfect security, but I'd like most plaintext file 
contents to be removed from memory on suspend so that an attacker cannot 
access most recently accessed files. Ideally it would be "all" not 
"most", of course, but I'll happily take what's feasible

> And if the attacker has access to the suspended memory, is it
> read-only access, or can the attacker modify the memory image to
> include a trojan that records the encryption once it is demanded of
> the user, and then mails it off to Moscow or Beijing or Fort Meade?

Yes, it's read-only access.

If the attacker has write access to the memory image while the system is 
suspended then it's complete game-over on all fronts. At that point they 
can completely replace the kernel if they so choose. This is not 
something I expect to be able to defend against outside of the solutions 
you mention, but those are not feasible on commodity consumer hardware. 
I'm looking to achieve the best we can with what we have. This is also 
not an attack I've heard of in the wild against consumer hardware; I 
know it's possible because I know people who've done it, but it takes 
many weeks (at least) of research and effort to prepare for a given chip 
- definitely not as easy as a cold-boot attack which can take seconds 
and works pretty universally.

> To address the whole set of problems, it might be that the answer
> might lie in something like confidential compute, where the all of the
> memory encrypted.  Now you don't need to worry about wiping the page
> cache, since it's all encrypted.  Of course, you still need to solve
> the problem of how to restablish the confidential compute keys after
> it has been wiped as part of the suspend, but you needed to solve that
> with the LUKS key anyway.

Without special hardware support you'll need to re-establish keys via 
unencrypted software, and unencrypted software can be replaced by an 
attacker if they're able to write to RAM. So it doesn't solve the 
problem you bring up. But anyway I feel this part of the discussion is 
starting to border on theoretical...

Though I suppose encrypting all the memory belonging to just the one 
user with that user's LUKS volume key could be an alternative solution. 
That way wiping out the key has the effect of "wiping out" all the 
user's related memory, at least until we can re-authenticate and bring 
it all back. But I suspect this would not only be extremely difficult to 
implement in the kernel but would also have huge performance cost 
without special hardware

> Anoter potential approach is a bit more targetted, which is to mark
> certain files as containing keying information, so the system can
> focus on making sure those pages are wiped at suspend time.  It still
> has issues, such as how the desire to wipe them from the memory at
> suspend time interacts with mlock(), which is often done by programs
> to prevent them from getting written to swap.  And of course, we still
> need to worry about what to do if the file is pinned because it's
> being accessed by RDMA or by sendfile(2) --- but perhaps a keyfile has
> no business of being accessed via RDMA or blasted out (unencrypted!)
> at high speed to a network connection via sendfile(2) --- and so
> perhaps those sorts of things should be disallowed if the file is
> marked as "this file contains secret keys --- treat it specially".

Secret keys are not what we're trying to protect here necessarily. 
Random user documents are often sensitive. People store tax documents, 
corporate secrets, or any number of other sensitive things on their 
computers. If an attacker can perform a cold boot attack on the device 
then depending on how recently these tax documents or corporate secrets 
were accessed they might just be in memory in plain text, which is not 
good. No amount of protecting the keys prevents this.

That said, having an extra security layer for secret keys would be 
useful. There are definitely files that contain sensitive data, and it 
would be useful to tell the kernel which files those are so that it can 
treat them extra carefully in the ways you suggest. Maybe even avoid 
putting them in plain text into the page cache? But this would have to 
be an extra step, since it's not feasible to make the user mark all the 
files that they consider to be sensitive

Adrian


