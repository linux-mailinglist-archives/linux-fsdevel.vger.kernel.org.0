Return-Path: <linux-fsdevel+bounces-27966-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FF69653FD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 02:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 901F1B21E43
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 00:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9370233C5;
	Fri, 30 Aug 2024 00:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="W9rPqE/Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F67723BE
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2024 00:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724977633; cv=none; b=IbcqTz0gN+3re4GXcf+Gi1Fn5QoyChKli7haUg7PKhK5yklS7kGqGQnC1TM/o7C9DoT8odRkN+N4aZRPm3IHhcE/IZN/RFLvc6noMIDw10M+Atu3UtULEfOXaRDAGkvUONbWTaOYev45SW+ytlKD8upS6aUoukiW5GMkPqoeoK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724977633; c=relaxed/simple;
	bh=bJd9I32v7Otg4KdUboUZFduUF4MCAqDOB8cOCWhBtsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WO0h/DGr3QMxq+8n14xqlCL/hO3dlfTlBfUJ6sJWkLSsAVEX1n5l67iRQ6cKdnI0jZHM1N3C1AB6xbxZpJ6t+Q/jtg8+NnU71lNy3kx3yOs3b9lS8UbFXfoStyfIjS80MFncnagQewKFvndMCCTG1DMz2EwaN1oMs3raa7Ghbgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=W9rPqE/Z; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3718c176ed7so757401f8f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 17:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724977628; x=1725582428; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0U2GctD6QRgRftcHbwdJFZ3yjPiOgv4RiUO/asYgyGY=;
        b=W9rPqE/Zr5zlfmXkb42q8EjBvSCNp0os45rzNaiq5I97nExyat1eXbe3tOFMT1n/WR
         AG4xveJ8nSrIRbfyGeLqdE9fJjwHg8oDQma1kHU5z7lU7EXct8qaehGS3rKlj3YGFU0b
         44SrLEmm1tz7M8/eUOSpez279rxyTEqMEJWCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724977628; x=1725582428;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0U2GctD6QRgRftcHbwdJFZ3yjPiOgv4RiUO/asYgyGY=;
        b=aPcOlyzjlSuiqc7ESc6TBzzlTlQwBJb0/M272fhSCLvA9qLfIy4KlrKFDPptka3HMC
         OKMJdhqIMNCbVCbl6gT/exjH4YUHF0i2zsAbpAeQHSGwyhMTJwQrtfSLsXpDan3zFKjW
         EFIyI+XyxLBvVMRIEW6eDOl7F6vOwyZL1NiguJOXVH8QSJEkflEI1AhvPFgtlHMnePhi
         KAbMnbOlGjpLVaukfd23BLHoRl+69old0vIwVNhu8yocafj7hwDgkGFZM4FoNm69tss4
         FxbN4sk1i26MqNlquYJlmycAWzKXzKKNA4JFN6REDafUSspfPLeS6siHqYPE7Xe9mSo3
         bUgw==
X-Forwarded-Encrypted: i=1; AJvYcCUnk2DYQ2C2oC4Wktxr8XiBc1SToNKgc0wnEDpklXbSDFS+nmCLfuhIL5st4niK3dnlyquozaDWXPlxPlT8@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5C2dPRtRz4ikp6/R9bS4Mz9UU7e8uOs+eXs2n0fy/VTW/5aUN
	XkuYssJQPLWR80m/t5iCCWmo8j8KTCyx5ptg7OaZApTORJE09jUbhxobB45EMyXRC5V08+ZROJ2
	/70fynw==
X-Google-Smtp-Source: AGHT+IEfAn46gzynSKHHIK31FbobYniWaKF7naVylLsGO6BgLoC1fULpG88+Wmq+guWYyWqLZjzNuQ==
X-Received: by 2002:a05:6000:1802:b0:371:a844:d326 with SMTP id ffacd0b85a97d-3749b57febemr3035097f8f.43.1724977628141;
        Thu, 29 Aug 2024 17:27:08 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226c6a462sm1249247a12.14.2024.08.29.17.27.06
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 17:27:06 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3717ff2358eso804563f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 17:27:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXwLtBIWrTNJ3xPF3XFJTUcE5PGBG/aPe7XEXdOshb4d62tzDph6zHphxI6Uof8uVESlAaXd4EcI/cfm/XF@vger.kernel.org
X-Received: by 2002:adf:b647:0:b0:368:526d:41d8 with SMTP id
 ffacd0b85a97d-3749b548673mr2714437f8f.23.1724977626257; Thu, 29 Aug 2024
 17:27:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829182049.287086-1-stephen.s.brennan@oracle.com>
In-Reply-To: <20240829182049.287086-1-stephen.s.brennan@oracle.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 30 Aug 2024 12:26:49 +1200
X-Gmail-Original-Message-ID: <CAHk-=wjKbgRY+Jvu2GNaDXaAhyydOOW-R=0qCzM3mTLrZZg+iQ@mail.gmail.com>
Message-ID: <CAHk-=wjKbgRY+Jvu2GNaDXaAhyydOOW-R=0qCzM3mTLrZZg+iQ@mail.gmail.com>
Subject: Re: [PATCH] dcache: don't discard dentry_hashtable or d_hash_shift
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-debuggers@vger.kernel.org, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"

On Fri, 30 Aug 2024 at 06:21, Stephen Brennan
<stephen.s.brennan@oracle.com> wrote:
>
> I know this "fix" may seem a bit silly, but reading out the dentry
> hashtable contents from a core dump or live system has been a real life
> saver when debugging dentry cache bloat issues. Could we do something
> like this (even making it opt-in would be great) for v6.11?

Sure, applied with fixes to the comment (you seem to have dropped a word).

             Linus

