Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251FA5B27DB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Sep 2022 22:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiIHUpx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 16:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiIHUpw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 16:45:52 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3F7C5789;
        Thu,  8 Sep 2022 13:45:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3492FCE20A9;
        Thu,  8 Sep 2022 20:45:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 258FCC433D6;
        Thu,  8 Sep 2022 20:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1662669947;
        bh=9J1C2KFcH969Z3x2PZqo6s1jyIaCFtzY0yxbCJi9HH0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J+NBqSIOd4nP66l7soHJqD67V7Ou0UKZW6aS3MEFeWbxGEZALOxpZzHnFCVf15uCq
         aHbQv6TiWuMjPR2xKMLkV85Fbjru5rpcW/SktGCRoa06o2Aa5NMW8IPxbXwWrlINWj
         mnpeHSkCjmB/0ihI6jJfJUv3fT0yIV9XMhj4bLT0=
Date:   Thu, 8 Sep 2022 13:45:46 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc: give /proc/cmdline size
Message-Id: <20220908134546.6054f611243da37b4f067938@linux-foundation.org>
In-Reply-To: <YxoywlbM73JJN3r+@localhost.localdomain>
References: <YxoywlbM73JJN3r+@localhost.localdomain>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 8 Sep 2022 21:21:54 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:

> Most /proc files don't have length (in fstat sense). This leads
> to inefficiencies when reading such files with APIs commonly found in
> modern programming languages. They open file, then fstat descriptor,
> get st_size == 0 and either assume file is empty or start reading
> without knowing target size.
> 
> cat(1) does OK because it uses large enough buffer by default.
> But naive programs copy-pasted from SO aren't:

What is "SO"?

> 	let mut f = std::fs::File::open("/proc/cmdline").unwrap();
> 	let mut buf: Vec<u8> = Vec::new();
> 	f.read_to_end(&mut buf).unwrap();
> 
> will result in
> 
> 	openat(AT_FDCWD, "/proc/cmdline", O_RDONLY|O_CLOEXEC) = 3
> 	statx(0, NULL, AT_STATX_SYNC_AS_STAT, STATX_ALL, NULL) = -1 EFAULT (Bad address)
> 	statx(3, "", AT_STATX_SYNC_AS_STAT|AT_EMPTY_PATH, STATX_ALL, {stx_mask=STATX_BASIC_STATS|STATX_MNT_ID, stx_attributes=0, stx_mode=S_IFREG|0444, stx_size=0, ...}) = 0
> 	lseek(3, 0, SEEK_CUR)                   = 0
> 	read(3, "BOOT_IMAGE=(hd3,gpt2)/vmlinuz-5.", 32) = 32
> 	read(3, "19.6-100.fc35.x86_64 root=/dev/m", 32) = 32
> 	read(3, "apper/fedora_localhost--live-roo"..., 64) = 64
> 	read(3, "ocalhost--live-swap rd.lvm.lv=fe"..., 128) = 116
> 	read(3, "", 12)
> 
> open/stat is OK, lseek looks silly but there are 3 unnecessary reads
> because Rust starts with 32 bytes per Vec<u8> and grows from there.
> 
> In case of /proc/cmdline, the length is known precisely.
> 
> Make variables readonly while I'm at it.

It seems arbitrary.  Why does /proc/cmdline in particular get this
treatment?

