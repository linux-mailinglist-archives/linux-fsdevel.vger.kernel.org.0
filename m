Return-Path: <linux-fsdevel+bounces-63714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E856BCB670
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 04:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8B7B935088F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 02:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B13238C15;
	Fri, 10 Oct 2025 02:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbnS7UDX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064DE22ACE3
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 02:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760061909; cv=none; b=aB7DfxG+wnXjX88BdXKFaWu6bF5EK+YRIh65VLZSEvr4j4J/1T2uN8KdNBF0M/edFwL0IxBaElm3rtIwqPwCjQlEfqb+3dOjUPe6guLn2PpNHrHi3/SYUvYmxJ97QyYuCMa3vOjYy0wta3Bl+Nvr769EQuiUoAZ3oAvJS70gjw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760061909; c=relaxed/simple;
	bh=4TBHId0bMm9CdTNvUN5XuLKY3sjRAw7vbQwPUrCIGvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ruU5j8IAr3FZe4PqShonQlHQ5JvDHrFc7jgv91lldj3SR8n/mio9jSH3IEsEAAFXlDsh8mP3UHx5r4A+LgAWdCarCM6fplnkn5P76kqslB9KuEWgzdEZ8idOnTc3ZK7smh7+qpOc21swCOfmS0+vw0m0O2fxo65bNuk5oHOfxpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JbnS7UDX; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-27d4d6b7ab5so22331515ad.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Oct 2025 19:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760061907; x=1760666707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1rKJVS+vc6Xu/tqhvpZMEVhOAA3UUcIm1XqkGlHfjk=;
        b=JbnS7UDXsIYTTo2e2s7gJVPY/kak4SQig1MyyhIdw90c5SAA+PmWnxuo+Ai5opKtUm
         CKkW5stFwP8ln5958nyZy18yvzNgad3cOcsfzVOMH0kc51K7kUS2s39KHDYwmqZh2c1w
         iIomCa1pa6PtG/qVlvXIrxqex9/0Fqxjr/rp5Ie88v+ruC+EAJdEbcDcfeXtwFmrNkil
         8NUqVpj5mlBuDTzzY54cG2cIhIfPyHzfO+4rU+CsrhSNieJyUdZpPNYU2uUmrHXfyB/8
         sZOIJD8qCrjIGVvpH2d9fCiuWlxzBKifG2E8gXB80/uDTuj7//9qXseOGb17k2KlyIAb
         yfiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760061907; x=1760666707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h1rKJVS+vc6Xu/tqhvpZMEVhOAA3UUcIm1XqkGlHfjk=;
        b=HlpJAtTCSli8kYmAAs8kstTtih9GcCFFatY/EG/fFjWLP6yTINFEc26Zha40Rvluew
         +NOh3ySV0PjQ/67/SDHLFqiVs5ktRji2PRaWjC1MiPhWJFNvIHdsZvMcHk+4foOih027
         pYvIYWleEmzYGqdVoUFwxjgeXaCNAQ189Ur4tenPK6c9BSreT0GMRzREKAR7oUstLsb1
         g561VRAMf5hFnTY+eLIL8JSRS4mokBYOTbEJneyA4tB+3t3WCLlHOB2WNLl3CR3p3TdP
         aTym3uZsRpFahGxa5tMSHh6mb/w4F5qcory+9k1tiHXgLjAa7yuuLRUNsDsCLeCTiKxh
         kNDg==
X-Forwarded-Encrypted: i=1; AJvYcCVbYWtRpTzRp3ii2Qf5yf8jVPw9RWDy1o4VNN04A+fJgLNszmPk6mUSSUxleAXquN/UscnWzlbcy+aZw7C1@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb5WFvl70G5wuqi6i7xKVXKGAv/MDR4pXqkyD8+WW9nmpjQQjM
	mEUyv+tU5cNdacYcYeBWFuC/XkIrsiahYd+EnH5WDC03sowZJDVFiiB3
X-Gm-Gg: ASbGncujgToek/FpC9lbrSz6lzwvhKfhWWelW2xmPDtLVavsWtprAWV/xeuniuv57uJ
	Q+uMCEFl+C4xq2173s6mNnOktBxC4rHTjjMQFXy0RBHnwd+h3QTZOkYncLwW4fT1EW2sEbfUCsu
	1NWcphbjCCKavdtEsRSCpuoT/P51fMBu/81EjqX/MbswPj5QK7no2gcxxdjGSGiPmoHaEz6ei8J
	OX7hdIszHPx+Y7sdEKFhSGdDOEVGobSEq3D3btBU8DwkgsFc1eZo5WMeinaYuP4XdSu6qa3TI/+
	dVkaYQCy5a5g2EtnXLooljwMAQ5w2pUW+GYCLnPjR+J2kZ/V+HJ4W5U9OJ90cAXA+yHWVVWol+f
	y2H9Ntc2HWyItpFlYobIklbkbHZ0HdzLkd8HWj1A1ZkRGac29+GsjK2yLJlSjWCk=
X-Google-Smtp-Source: AGHT+IFUKd5++PDzS5abSESfTQMJE2QGfoxe3f5Mp2ZuxGS2YUSKKiYyTeMogVzSyN+wUnOPRXUvpg==
X-Received: by 2002:a17:903:1aef:b0:250:1c22:e7b with SMTP id d9443c01a7336-290272e3a78mr128609435ad.43.1760061907263;
        Thu, 09 Oct 2025 19:05:07 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e179cesm41443735ad.34.2025.10.09.19.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 19:05:06 -0700 (PDT)
From: Jinliang Zheng <alexjlzheng@gmail.com>
X-Google-Original-From: Jinliang Zheng <alexjlzheng@tencent.com>
To: dave.hansen@intel.com
Cc: alexjlzheng@gmail.com,
	alexjlzheng@tencent.com,
	brauner@kernel.org,
	dave.hansen@linux.intel.com,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH] iomap: move prefaulting out of hot write path
Date: Fri, 10 Oct 2025 10:04:58 +0800
Message-ID: <20251010020505.3230463-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <486185f6-7da7-4fdc-9206-8f1eebd341cf@intel.com>
References: <486185f6-7da7-4fdc-9206-8f1eebd341cf@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> On 11/9/25 08:01, Darrick J. Wong wrote:
> > On Thu, Oct 09, 2025 at 05:08:51PM +0800, alexjlzheng@gmail.com wrote:
> >> From: Jinliang Zheng <alexjlzheng@tencent.com>
> >>
> >> Prefaulting the write source buffer incurs an extra userspace access
> >> in the common fast path. Make iomap_write_iter() consistent with
> >> generic_perform_write(): only touch userspace an extra time when
> >> copy_folio_from_iter_atomic() has failed to make progress.
> >>
> >> This patch is inspired by commit 665575cff098 ("filemap: move
> >> prefaulting out of hot write path").
> > Seems fine to me, but I wonder if dhansen has any thoughts about this
> > patch ... which exactly mirrors one he sent eight months ago?
> 
> I don't _really_ care all that much. But, yeah, I would have expected
> a little shout-out or something when someone copies the changelog and
> code verbatim from another patch:
> 
> 	https://lore.kernel.org/lkml/20250129181753.3927F212@davehans-spike.ostc.intel.com/
> 
> and then copies a comment from a second patch I did.

Sorry for forgetting to CC you in my previous email.

When I sent V1[1], I hadn't come across this email (which was an oversight on my part):
- https://lore.kernel.org/lkml/20250129181753.3927F212@davehans-spike.ostc.intel.com/

At that time, I was quite puzzled about why generic_perform_write() had moved prefaulting
out of the hot write path, while iomap_write_iter() had not done the same.

It wasn't until I was preparing V2[2] that I found the email above. However, the code around
had already undergone some changes by then, so I rebased the code in this email onto the
upstream version. My apologies for forgetting to CC you earlier.

[1] https://lore.kernel.org/linux-xfs/20250726090955.647131-2-alexjlzheng@tencent.com/
[2] https://lore.kernel.org/linux-xfs/20250730164408.4187624-2-alexjlzheng@tencent.com/

Hope you know I didn't mean any offense. Sorry about that.

> 
> But I guess I was cc'd at least. Also, if my name isn't on this one,
> then I don't have to fix any of the bugs it causes. Right? ;)
> 
> Just one warning: be on the lookout for bugs in the area. The
> prefaulting definitely does a good job of hiding bugs in other bits
> of the code. The generic_perform_write() gunk seems to have uncovered
> a bug or two.

Indeed, the reason I sent this patch was precisely because I was unsure why the change
for iomap_write_iter() hadn't been merged like the one for generic_perform_write() — I
wondered if there might be some underlying issue. I hoped to seek everyone's thoughts
through this patch. :)

> 
> Also, didn't Christoph ask you to make the comments wider the last
> time Alex posted this? I don't think that got changed.
> 
> 	https://lore.kernel.org/lkml/aIt8BYa6Ti6SRh8C@infradead.org/
> 
> Overall, the change still seems as valid to me as it did when I wrote the
> patch in the first place. Although it feels funny to ack my own
> patch.

If moving prefaulting out of the hot write path in iomap_write_iter() is indeed
acceptable, would you mind taking the time to rebase the code from your patch onto
the latest upstream version and submit a new patch? After all, you are the
original author of the change. :)

Thank you very much,
Jinliang. :)

