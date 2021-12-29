Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD70048142C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Dec 2021 15:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240332AbhL2OoN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Dec 2021 09:44:13 -0500
Received: from fanzine2.igalia.com ([213.97.179.56]:44002 "EHLO
        fanzine2.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236856AbhL2OoN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Dec 2021 09:44:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=xEhvsXnlkpoIMlNWlhVl6uBETW3daxxgh1OifCL6/Ic=; b=bY5rGx8IUHHNnLVISLoLY+p4+p
        48DUo77tF4nAHpbOlSNNgz7RAkYTihdO/MiVG7bTRVx4+oKW/xpAdZmUoLnpc/vIpRhDcsM/lT/P8
        0nn0vOYUVD7fgvj5k34q5ldRiMxqq/xzlq1Qwkav3nPKDgKDbasXm1JIpEMxXYivcxan0HU5mVtx7
        iT3tKgpqZUEtfCC66bJhK171KSuKgetpvHYaljZz/Iuz6BAjPs40hHUS9LqghiXMTNOfbKYJAGTrs
        oQeg7Kgdh5lX4rr8nVh+0wReP+F31gFMlAe+y8x4tFRtsm6biUt19vvCT+GRjQ2WVYmZ01MTldcO/
        l9lN5tEA==;
Received: from 200-153-146-242.dsl.telesp.net.br ([200.153.146.242] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1n2aBT-0008hr-Mp; Wed, 29 Dec 2021 15:44:07 +0100
To:     keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com
Cc:     linux-kernel@vger.kernel.org,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        gpiccoli@igalia.com, "Guilherme G. Piccoli" <kernel@gpiccoli.net>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: pstore/ramoops - why only collect a partial dmesg?
Message-ID: <a21201cf-1e5f-fed1-356d-42c83a66fa57@igalia.com>
Date:   Wed, 29 Dec 2021 11:43:51 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Anton / Colin / Kees / Tony, I'd like to understand the rationale
behind a ramoops behavior, appreciate in advance any information/advice!

I've noticed that while using ramoops as a backend for pstore, only the
first "record_size" bytes of dmesg is collected/saved in sysfs on panic.
It is the "Part 1" of dmesg - seems this is on purpose [0], so I'm
curious on why can't we save the full dmesg split in multi-part files,
like efi-pstore for example?

If that's an interesting idea, I'm willing to try implementing that in
case there are no available patches for it already (maybe somebody
worked on it for their own usage). My idea would be to have a tuning to
enable or disable such new behavior, and we could have files like
"dmesg-ramoops-0.partX" as the partitions of the full "dmesg-ramoops-0".

Thanks in advance,


Guilherme


[0]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/pstore/ram.c#n353
