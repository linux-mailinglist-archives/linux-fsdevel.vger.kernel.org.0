Return-Path: <linux-fsdevel+bounces-55262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F269DB090A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 17:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2974E58724F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 15:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E726B2F8C5C;
	Thu, 17 Jul 2025 15:31:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D10015A85A;
	Thu, 17 Jul 2025 15:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752766260; cv=none; b=u4YxmGLkl7lKqYUiosAlgdTh3RTuC6wDhOo0EMb4dUyNpyrIhe1aabYCo3DGRU6sSS+f6wPgGEOrMYE1uASPwyRTOO1AIN9YWhCSDm7FMyAzgLdn39FwH/egprkrxcJ2X9Zn4DsqLbUBGdcLFH3eVGwI7UW3MLBCh0HR6Gn0sBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752766260; c=relaxed/simple;
	bh=8sqZQtNchg/cFYrXE7aeC+9vbrIfv1vTGZCEu8dlk1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uiAylN8z9kxspmcV58Pm+03AN3fcOn6VgayjAH/qEvkyTjfLuA9wPBFMZiLswsSX8Kqwr4hArCp5zVbaKzF85z19/dBsRrICGuRVZP8FpW8CZ9SClDPteVhy+g8NQ1VUoRqcvCrYqF13E2lZm7WygZ2ikDrLhK9fUWoUlOu/lqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 56HFUYiY050253;
	Fri, 18 Jul 2025 00:30:34 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 56HFUYd3050250
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 18 Jul 2025 00:30:34 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <175a5ded-518a-4002-8650-cffc7f94aec4@I-love.SAKURA.ne.jp>
Date: Fri, 18 Jul 2025 00:30:33 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hfs: remove BUG() from
 hfs_release_folio()/hfs_test_inode()/hfs_write_inode()
To: Viacheslav Dubeyko <slava@dubeyko.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Yangtao Li <frank.li@vivo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
References: <ddee2787-dcd9-489d-928b-55a4a95eed6c@I-love.SAKURA.ne.jp>
 <b6e39a3e-f7ce-4f7e-aa77-f6b146bd7c92@I-love.SAKURA.ne.jp>
 <Z1GxzKmR-oA3Fmmv@casper.infradead.org>
 <b992789a-84f5-4f57-88f6-76efedd7d00e@I-love.SAKURA.ne.jp>
 <24e72990-2c48-4084-b229-21161cc27851@I-love.SAKURA.ne.jp>
 <db6a106e-e048-49a8-8945-b10b3bf46c47@I-love.SAKURA.ne.jp>
 <4c1eb34018cabe33f81b1aa13d5eb0adc44661e7.camel@dubeyko.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <4c1eb34018cabe33f81b1aa13d5eb0adc44661e7.camel@dubeyko.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav304.rs.sakura.ne.jp

On 2025/07/16 4:20, Viacheslav Dubeyko wrote:
> I don't think that it makes sense to add the function name here. I
> understand that you would like to be informative here. But, usually,
> HFS code doesn't show the the function name in error messages.
> 
> By the way, why are you using pr_warn() but not pr_err()? Any
> particular reason to use namely pr_warn()?

Simply mimicked

  pr_warn("filesystem was not cleanly unmounted, running fsck.hfs is recommended.  mounting read-only.\n");
  pr_warn("filesystem was not cleanly unmounted, running fsck.hfs is recommended.  leaving read-only.\n");

messages. But stronger level (i.e. pr_err()) is OK for locations
which should not occur.

> We had BUG() here before and, potentially, we could use pr_warn() +
> dump_stack() to be really informative here.

Since printing a lot of messages causes stalls, I'd like to keep minimum.

Although fsck.hfs cannot fix all problems in the filesystem image used by the
reproducer ( https://syzkaller.appspot.com/text?tag=ReproC&x=111450f0580000 ),
updating this patch to suggest running fsck.hfs might be helpful.

  ** /dev/loop0
     Executing fsck_hfs (version 540.1-Linux).
  ** Checking HFS volume.
     Invalid extent entry
  (3, 0)
  ** The volume   could not be verified completely.


