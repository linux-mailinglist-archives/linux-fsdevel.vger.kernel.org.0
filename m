Return-Path: <linux-fsdevel+bounces-59711-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88888B3CF19
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Aug 2025 21:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E97FE7A8D98
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Aug 2025 19:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A762DE700;
	Sat, 30 Aug 2025 19:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FkPHnGry"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B104CB5B
	for <linux-fsdevel@vger.kernel.org>; Sat, 30 Aug 2025 19:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756582854; cv=none; b=nGdd8iVIBAHB5OnIzt+GfJXCOc0Ya/UowAvS4+Md8C7yWZ8oUq0OZl/Tr7WLET3zoeJuFSyyqvF7ALU0srub7d1gczQgOPZtTTKRJ/wt76ri4FqxpDd9ZAw8OlUOEJIAj6SGPcHEq0aiW7xr8r1iZLAJxqiYFYlnDqP/A0pZQjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756582854; c=relaxed/simple;
	bh=NVyfZuF5eXnDMEWfWvdipVhfvul/3BEh8GaeO0XAkfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pHXd0T8foDYfrMcNP5z2E3zbziySnEjMV1miyQ/RHBaZNYCozgYE5fbJnQMQGKf25Wk5shwIuOUln9Sg7GLaSvZWy7A0rzXsJefb4idw5jvOdn4Yzh331qs8mt8yOziYg4/jIeGn7/wh3ihn0uu9ltuy8C5QtGBly4JMcOdd98E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FkPHnGry; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-61cc281171cso5414200a12.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 Aug 2025 12:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756582851; x=1757187651; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BHXYEtVKkWv32TfIsJQ5lSYcHHDKT8BOKc1JEzYA1IM=;
        b=FkPHnGryaG6bF9wrdEacNfmG0qb3G1t6T+P9s419VkqlTbiFjQolJtiRMD0MPZrqt8
         kEHF/PpaWoXCnzUUt5AfAu2hxJPhan9w9u2n4XDetdW7e4logj/thzX/vhRrWOXmTI4o
         F0Mye8E6FO+zt8YLQVbBwQs0IvoeIBKE3zl3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756582851; x=1757187651;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BHXYEtVKkWv32TfIsJQ5lSYcHHDKT8BOKc1JEzYA1IM=;
        b=S44rEmM1zwh/Qe3oG+sXebdGb79g7FCFVVl1NTFjmOpEf09oDbIBoKv9+1K7Sp6ENP
         1nICZj1nfCqaMyvSg+9anND2evH1Z3WszyPafKKFJ+SFfMi1CMftecuggOsnDlU+TV3U
         /jbz3lj6GHNo76jHallHpkO/AUuxBvLLsvfpvs6mr5AjGZ4Q2Se83VkUBZZt7Mq4aksL
         H/MGG4Ivs4WtzY3BEMU4rcTjQGUW8n6jgbttZ+YXZoSGWit9BSG0rpz2kVZVz5g7Llj9
         VcaPV0nuC7xZ+TxRs97yeS45TzjDBImWWciNTyBGl93ZK9GFTj1Cl3FWW61qBKMhf1PA
         NXIg==
X-Gm-Message-State: AOJu0YyIQF6yBkHVmPlCUy4rcByQiz30c3krEqsMSAPHg9AeYZJNCt3W
	lEPTmo+7aUu4z49S/gIf1j9jXCnvb+LxmA8xGFiEJzht4dV/qEW19Wu7VMy52nPdR0fCrtZ+MgM
	ubz96+4bVNQ==
X-Gm-Gg: ASbGncvy7d4p8NObsrSFOI9l0qsWJP9/+YxxzQIUII+cE/SuCXt3iMa3zegRa/exvMp
	SA+viUmb8IIsl/QImrWrr/lg7iUZrzTEFwbAHthcz/a8zKdvMBttBuGA+nRRRFNBFlLk4ZzFABy
	We6rZoM2mMYehzUwl/e7cIgvieWer5wyQ1e9Zdqn4i4kaZzodV0sObXSO8/FjKNyjLfcDY3IAgt
	EuHq6reMy3oopOGut6IeGk1H7Ia6f4GubAodOo/2rMbRcUyz4fJLL6SPfuZ1GoWnbtFg9FFTolP
	n/iNum9NBgzqA/6VU3rtyHnWNcwzqHnKLJqJ4S8x844t3D2VRqxS52cqSv4yoXGwvvxWjcHvX7I
	z6N6cmEoC3bEngIgoXJAD94584wa7Lz+Fp9czptz7kopWc/lg6o1BceAPjAWJzbCux5rpq97L
X-Google-Smtp-Source: AGHT+IE1nKKLWCne2j38vKXQDvfF8ZpUxsVk+vOy7yS9A3sbOvv+xL89EjQ7ZETsJrv1NXpZEWVY2A==
X-Received: by 2002:a05:6402:2547:b0:61d:249a:43fe with SMTP id 4fb4d7f45d1cf-61d26d9c38cmr2700281a12.24.1756582850812;
        Sat, 30 Aug 2025 12:40:50 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc22dfa1sm4001393a12.22.2025.08.30.12.40.49
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Aug 2025 12:40:50 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b04163fe08dso24056966b.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 Aug 2025 12:40:49 -0700 (PDT)
X-Received: by 2002:a17:907:1c27:b0:afe:e7f1:28c0 with SMTP id
 a640c23a62f3a-b01f20c6448mr276211066b.63.1756582848852; Sat, 30 Aug 2025
 12:40:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
 <20250828230806.3582485-61-viro@zeniv.linux.org.uk> <CAHk-=wgZEkSNKFe_=W=OcoMTQiwq8j017mh+TUR4AV9GiMPQLA@mail.gmail.com>
 <20250829001109.GB39973@ZenIV> <CAHk-=wg+wHJ6G0hF75tqM4e951rm7v3-B5E4G=ctK0auib-Auw@mail.gmail.com>
 <20250829060306.GC39973@ZenIV> <20250829060522.GB659926@ZenIV>
 <20250829-achthundert-kollabieren-ee721905a753@brauner> <20250829163717.GD39973@ZenIV>
 <20250830043624.GE39973@ZenIV> <20250830073325.GF39973@ZenIV>
In-Reply-To: <20250830073325.GF39973@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 30 Aug 2025 12:40:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiSNJ4yBYoLoMgF1M2VRrGfjqJZzem=RAjKhK8W=KohzQ@mail.gmail.com>
X-Gm-Features: Ac12FXxLGR1aqCFqh0I7NhxDju8JaDpqFeHveil8FDNWJ7YGKJCZcnDDTgpNs3M
Message-ID: <CAHk-=wiSNJ4yBYoLoMgF1M2VRrGfjqJZzem=RAjKhK8W=KohzQ@mail.gmail.com>
Subject: Re: [RFC] does # really need to be escaped in devnames?
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	Siddhesh Poyarekar <siddhesh@gotplt.org>, Ian Kent <raven@themaw.net>, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 30 Aug 2025 at 00:33, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> So...  Siddhesh, could you clarify the claim about breaking getmntent(3)?
> Does it or does it not happen on every system that has readonly AFS
> volumes mounted?

Hmm. Looking at various source trees using Debian code search, at
least dietlibc doesn't treat '#' specially at all.

And glibc seems to treat only a line that *starts* with a '#'
(possibly preceded by space/tab combinations) as an empty line.

klibc checks for '#' at the beginning of the file (without any
potential space skipping before)

Busybox seems to do the same "skip whitespace, then skip lines
starting with '#'" that glibc does.

So I think the '#'-escaping logic is wrong.  We should only escape '#'
marks at the beginning of a line (since we already escape spaces and
tabs, the "preceded by whitespace" doesn't matter).

And that means that we shouldn't do it in 'mangle()' at all - because
it's irrelevant for any field but the first.

And the first field in /proc/mounts is that 'r->mnt_devname' (or
show_devname), and again, that should only trigger on the first
character, not every character.

Now, could there be other libraries that get this even worse wrong? Of
course. But

             Linus

