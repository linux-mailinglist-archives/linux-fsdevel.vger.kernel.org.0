Return-Path: <linux-fsdevel+bounces-24284-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B50E193CC35
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 03:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E98811C21110
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 01:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645AF17FF;
	Fri, 26 Jul 2024 01:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="psekbiTT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D9380B
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jul 2024 01:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721955944; cv=none; b=YZl3rTCkIw2fcrnZttLD4YKNlPPv6wM4nr1sSpxvn2XywDdd6CtPWIgD048ajALIsJjfOKlvZ9li0HdAbPqLHskFxnDrhisFoZgvG/qCrL/1J2XBiczh1YEfLf0zN5WYDP4gzF4DtTThCK7ubB21FCX7W1k9gCAZVMuRQ7Ev/2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721955944; c=relaxed/simple;
	bh=SYiXtPtA7u1goqwd0iJdJa6uUwj2jarWAZpR6Ns6Dk4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=G6cdoTafx98OCIJfpRd3yR6gZZ/XuvudhlqAfFuupRcIncdxrGa3BZctIkpY26SCrWcq/ZttMuf0lANrVBifikv1c1FJPw7a++nmRM5ZMHB6kO8hs6k4sos4dyG+8j+juGwp79eLNX9uDgXWEECDLGSKfeV3fqLPyhTJY/ILORs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=psekbiTT; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5cebd3bd468so296325eaf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 18:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721955942; x=1722560742; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wplub1KYBY00My21K+3e0Cz2sX6Rz/xbxhkg+HgxJvY=;
        b=psekbiTTFHay9shkJxoheIO3/dWGTsEXJXiUFlvGUtU8OsSz4r6sPIx80hg/NUxHOQ
         2GAAAcccdlqr4TTvILzxp7y20CWCcxDOfYCx1qXV7qNjMm9Z3kjuNMVjQW9+c0s2vjmL
         Rc4VQgqvHfbTJuDzviTkPZckquo2DiaLW2O9Fa0oXWXWmZsqK+PiC8YNaGdVtHrtNPwT
         mMsYQ8V5kaRVF4ltroYGArWMfGndTvHol+sdjNOKahjuC75wfsHwJqCxyOMfkgHC3zl/
         n5UKCS2jgoPkydBYyFSb9uKis+F8C1LTenl0DnAG5zjUEcshtZwfx+WrNLx/7Ei4FoXy
         hCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721955942; x=1722560742;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wplub1KYBY00My21K+3e0Cz2sX6Rz/xbxhkg+HgxJvY=;
        b=EblKc2xliA3vILP0EqzQrVCp/91VbQv4cGoluHeZTkHgAn/5c3fO4SUIwfYbJWWzYS
         PvbnZACGg4CZkWINdHKdgpsmBvMHQA0Kh8FmEbgSXkGxcuSG+cPWIUkVCwEOVP1N7thg
         1QLlvG2uKtsBXlZ8XNg+rzI6q1sBWx/kXR/QSkzyNYOtVJ/wmL6lGIpWTm8AdQP+x0wo
         xhLJxf62i0DrnmiUuNKZb3Ip2is3mYdMxJocwo1LQGxpolscDBCibJP326MOzb/8n44M
         XDlz9fkEf/eM/0tUZ5K5+qCHdl7biemRYJgix0naTb1mFVg+PmCIj+odG+WNcQqZFUg3
         1+TA==
X-Forwarded-Encrypted: i=1; AJvYcCU2zt7Sxe/59cwN2V/q+giSP38Z4F4/wvYjuBix5Bb+xBYGCbyPhDYCJQbEFp3OxUPUt1HZInAOX1uqARkY9lxoZdw7hN6KnaDYiFvL+A==
X-Gm-Message-State: AOJu0Yz4D9dY6L5OfQ4qSF4YKCBoKjJ9op1wlYh5Tp2RjfbgJeVNdbeB
	9m8ZsA58u90frZJjoE5o3hJQ5SSvjs5a+ALy2vzA/P5HSsPhPqsdwQM5Upb1cg==
X-Google-Smtp-Source: AGHT+IGnXV3TJ01uIVgCnW2YbhkwhU19alV6F/dmPEewcN1biNfibE6YR5zlLHgLvW0JKfRTuG4OLw==
X-Received: by 2002:a05:6820:270b:b0:5b9:e7db:1cf8 with SMTP id 006d021491bc7-5d5b429a512mr4384785eaf.4.1721955942191;
        Thu, 25 Jul 2024 18:05:42 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-709307923acsm552014a34.76.2024.07.25.18.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 18:05:39 -0700 (PDT)
Date: Thu, 25 Jul 2024 18:05:27 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Chuck Lever <chuck.lever@oracle.com>
cc: Hugh Dickins <hughd@google.com>, "Hong, Yifan" <jacky8hyf@gmail.com>, 
    Rob Landley <rob@landley.net>, linux-kernel@vger.kernel.org, 
    linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
    bugzilla-daemon@kernel.org
Subject: Re: [Bug 219094] gen_kheaders.sh gets stuck in an infinite loop (on
 tmpfs)
In-Reply-To: <bug-219094-5568-fyOeXKhNmt@https.bugzilla.kernel.org/>
Message-ID: <a2808893-d257-e6b3-e168-0478d7255621@google.com>
References: <bug-219094-5568@https.bugzilla.kernel.org/> <bug-219094-5568-fyOeXKhNmt@https.bugzilla.kernel.org/>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Please send responses by email reply-to-all rather than through bugzilla.

On Thu, 25 Jul 2024, bugzilla-daemon@kernel.org wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=219094
> 
> Hong, Yifan (jacky8hyf@gmail.com) reports:
> 
> I have hit a similar bug to https://bugzilla.kernel.org/show_bug.cgi?id=217681, but on tmpfs. 
> 
> Here's a small reproducer for the bug, from https://bugzilla.kernel.org/show_bug.cgi?id=217681#c1:
> 
> ```
> #include <sys/types.h>
> #include <dirent.h>
> #include <stdio.h>
> 
> int main(int argc, char *argv[])
> {
>   DIR *dir = opendir(".");
>   struct dirent *dd;
> 
>   while ((dd = readdir(dir))) {
>     printf("%s\n", dd->d_name);
>     rename(dd->d_name, "TEMPFILE");
>     rename("TEMPFILE", dd->d_name);
>   }
>   closedir(dir);
> }
> ```
> 
> Run in a directory with multiple (2000) files, it does not complete on tmpfs. I created a tmpfs mount point via
> 
> ```
> mount -o size=1G -t tmpfs none ~/tmpfs/mount/
> ```
> 
> The other bug was fixed on btrfs via https://lore.kernel.org/linux-btrfs/c9ceb0e15d92d0634600603b38965d9b6d986b6d.1691923900.git.fdmanana@suse.com/. Could anyone please see if the issue can be ported to tmpfs as well? Thanks in advance!
> 
> I am using a `Linux version 6.6.15` kernel, if that's useful to anyone.

Thank you for reporting, Yifan; and thank you for the easy reproducer, Rob.

Yes, it appears that tmpfs was okay for this up to v6.5, but cannot cope
from v6.6 onwards - a likely-sounding fix went into v6.10, but that must
have been for something different, v6.10 still failing on this repro.

Chuck, I'm hoping that you will have time to spare to solve this in latest;
and then we shall want a backport (of only this fix, or more?) for v6.6 LTS.

Thanks!
Hugh

