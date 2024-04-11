Return-Path: <linux-fsdevel+bounces-16713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C9E8A1C4D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 19:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2A76282EA7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 17:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23DE15E81D;
	Thu, 11 Apr 2024 16:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PvpttXMq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A26932C8B
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 16:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712852132; cv=none; b=Yqz0KVo+FCGiSDgU5ODpBoHJ0igkSwFfIXA1feft9gRneJ/vwDopvRzgHRGK2MuB8+Rduv/hwN0bOjVe8HiFJdRCA2K399WAmvCxe7mBSeMV0GdVLdYzhVK6++k8mKyN38RSIws1RLoaYEReWVpSTQCxJrrgnCyf9Wp9JDrQAbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712852132; c=relaxed/simple;
	bh=LkGZWrwcM7i1Yw0nWiLzlJnspf96t1s3gPexteQnoII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dc4P1rfTZEWsW0Dvqnpafw+TSrS9MIvJzOjpUlqUxncMhZ4tVRVTYa2Fx2d5pyEWW+op3cGCb666wByOcQzer5d2TRo4uXj4ozod5HpbXJQv2/SPUKuE6qX7rHl5tvXWTkw9TxDq6X0DNObXyBIszLXMXxx/peb0IdL1718yHUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PvpttXMq; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d700beb60bso129171161fa.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 09:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1712852128; x=1713456928; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YBU5cbcti1MoT6SGDsy6z4cIdlnVeSMn7eSvY9b74qk=;
        b=PvpttXMqhyOCJz+iu0AnVRjMW1DGLYX//13HX/uoNuQS5Db9uMZb1etPQTpC97Qkfd
         OMFLYm/B6gbFTDPxdehxgqQ6R32+C5EgoP8xFzFpfttpk88wpS62L1ORULHm/FMK6Dzw
         eLVf96rxuGN7ygULbg8NqgjCoStq0DLnNfMlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712852128; x=1713456928;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YBU5cbcti1MoT6SGDsy6z4cIdlnVeSMn7eSvY9b74qk=;
        b=WROxLf9ZQWk+RQIvkvuxl3PRyHtOqY21LfS9C14ZG0L9AqgqIzn4viagqE9QQIja0q
         DK7GEJQ7/cIgnuhxxZHKLSitforn7R3IhHg/m8UAFsVkYYKLFvF/BBLUXhkFwSwpJspw
         pAJ7vQepV6yAXlXRyTxRwbjKfh6V1O8ygcnefp0N1GhWLkXL7VaOmZGgN61bJ/U7ti3u
         dqiuf+2tB0fSjMSWWo+/WGg18Ko06h40xyuz/AT4uQeUlUzXxTe3dhoncV9StMzlBO8F
         Q86efqeOULbrZR0QFLww8BwRrkNQoQ7fTr3AwrQLTzyd7qOdI3v4gwZZd8zCBQXhVtxh
         3ZfA==
X-Forwarded-Encrypted: i=1; AJvYcCUFT4zwE34RiqPBTbkVzrfZzdkiPM+WST25evzl+bqSBwjkBbhGM+kk9hdz0vPqwvMhWC39sVz2CReGzSB+jcplckHVc8/N6Aa8Nsb93Q==
X-Gm-Message-State: AOJu0YxXF5pinULo/pKHhIue+ceQQwTCUPwOmALkAszaFaUxrQvaJ568
	sE2dvj/6fQdjytkV2QgRpmV/dygUr7myuLqgEI4Fzpc5jmn+bMUrIwU1oruK1+J8r+WM67TSfYY
	pvih8HA==
X-Google-Smtp-Source: AGHT+IGuPK0+YRbuk9o1p3r/Kq7fN1vH2ILJHZOi0naRzSR0RA1QEENCzCK/pvMmgC1setvKUcHbgA==
X-Received: by 2002:a2e:8350:0:b0:2d4:94eb:e9fe with SMTP id l16-20020a2e8350000000b002d494ebe9femr88519ljh.21.1712852128147;
        Thu, 11 Apr 2024 09:15:28 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id k23-20020a2ea277000000b002d9f8183e0esm44620ljm.81.2024.04.11.09.15.27
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 09:15:27 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d485886545so141086921fa.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 09:15:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX0P//BhvOmDBButANDo8XgTdaPt25W58QauI9Oi/9F3AlSVjB0MvNz1RfTWY5xaH9HNTQbtZjHOBUxybGO69UEsgJ6MIcOoRphm2rekg==
X-Received: by 2002:a2e:b90a:0:b0:2d4:6a34:97bf with SMTP id
 b10-20020a2eb90a000000b002d46a3497bfmr57110ljb.49.1712852127138; Thu, 11 Apr
 2024 09:15:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411001012.12513-1-torvalds@linux-foundation.org>
 <CAHk-=wiaoij30cnx=jfvg=Br3YTxhQjp4VWRc6=xYE2=+EVRPg@mail.gmail.com> <20240411-alben-kocht-219170e9dc99@brauner>
In-Reply-To: <20240411-alben-kocht-219170e9dc99@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 11 Apr 2024 09:15:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjrPDx=f5OSnQVbbJ4id6SZk-exB1VW9Uz3R7rKFvTQeQ@mail.gmail.com>
Message-ID: <CAHk-=wjrPDx=f5OSnQVbbJ4id6SZk-exB1VW9Uz3R7rKFvTQeQ@mail.gmail.com>
Subject: Re: [PATCH] vfs: relax linkat() AT_EMPTY_PATH - aka flink() - requirements
To: Christian Brauner <brauner@kernel.org>, Charles Mirabile <cmirabil@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andrew Lutomirski <luto@kernel.org>, Peter Anvin <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Apr 2024 at 02:05, Christian Brauner <brauner@kernel.org> wrote:
>
> I had a similar discussion a while back someone requested that we relax
> permissions so linkat can be used in containers.

Hmm.

Ok, that's different - it just wants root to be able to do it, but
"root" being just in the container itself.

I don't think that's all that useful - I think one of the issues with
linkat(AT_EMPTY_PATH) is exactly that "it's only useful for root",
which means that it's effectively useless. Inside a container or out.

Because very few loads run as root-only (and fewer still run with any
capability bits that aren't just "root or nothing").

Before I did all this, I did a Debian code search for linkat with
AT_EMPTY_PATH, and it's almost non-existent. And I think it's exactly
because of this "when it's only useful for root, it's hardly useful at
all" issue.

(Of course, my Debian code search may have been broken).

So I suspect your special case is actually largely useless, and what
the container user actually wanted was what my patch does, but they
didn't think that was possible, so they asked to just extend the
"root" notion.

I've added Charles to the Cc.

But yes, with my patch, it would now be trivial to make that

        capable(CAP_DAC_READ_SEARCH)

test also be

        ns_capable(f.file->f_cred->user_ns, CAP_DAC_READ_SEARCH)

instead. I suspect not very many would care any more, but it does seem
conceptually sensible.

As to your patch - I don't like your nd->root  games in that patch at
all. That looks odd.

Yes, it makes lookup ignore the dfd (so you avoid the TOCTOU issue),
but it also makes lookup ignore "/". Which happens to be ok with an
empty path, but still...

So it feels to me like that patch of yours mis-uses something that is
just meant for vfs_path_lookup().

It may happen to work, but it smells really odd to me.

             Linus

