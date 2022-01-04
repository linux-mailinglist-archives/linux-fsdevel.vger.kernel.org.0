Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D1E484190
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jan 2022 13:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbiADMSV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jan 2022 07:18:21 -0500
Received: from fanzine2.igalia.com ([213.97.179.56]:34586 "EHLO
        fanzine2.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbiADMSU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jan 2022 07:18:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version
        :Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=wl0Ta8NdJpzdh4+vEby4ifCaYNac1xvrXBQitmQtYws=; b=UwUxmosQBo6YkYzXuPjlSaXx0H
        gs4Fc0/y7iNqiSuE193S0itX/J9HAi9/y7f8jh+YeumfiLxVSKL9u5CVkd0X2LkU+4PoHgnWdxbsq
        Y4Rm1d1X2uDcwjtJm0vTuceUYCI16ntS35xyiqTK9xdJqwkR4oYWCnc5sPH3myTFS2f3NcnwcTZ+U
        TUSX5RoPLoi/l7ZeXbsqKYk8Ep3W+fjQcu3jR0kXuj6E6k8M6dgX0NtmFwOKcVO26f9Y0kwO535iX
        RJIDTZfA91sp0yuDaxlthRdUS9gq9M8kpw+CAFnzXLeYB1wwt5Ku1wWBVMOKxexe5aDbWggpgPmca
        oli17wzA==;
Received: from 200-153-146-242.dsl.telesp.net.br ([200.153.146.242] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1n4ilb-000Cid-F4; Tue, 04 Jan 2022 13:18:15 +0100
Subject: Re: pstore/ramoops - why only collect a partial dmesg?
To:     "Luck, Tony" <tony.luck@intel.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "anton@enomsg.org" <anton@enomsg.org>,
        "ccross@android.com" <ccross@android.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        "Guilherme G. Piccoli" <kernel@gpiccoli.net>
References: <a21201cf-1e5f-fed1-356d-42c83a66fa57@igalia.com>
 <2d1e9afa38474de6a8b1efc14925d095@intel.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Message-ID: <0ca4c27a-a707-4d36-9689-b09ef715ac67@igalia.com>
Date:   Tue, 4 Jan 2022 09:17:59 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <2d1e9afa38474de6a8b1efc14925d095@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 03/01/2022 20:31, Luck, Tony wrote:
> Guilherme,
> 
> The efi (and erst) backends for pstore have severe limitations on the size
> of objects that can store (just a few Kbytes) so pstore breaks the dmesg
> data into pieces.
> 
> I'm not super-familiar with how ramoops behaves, but maybe it allows setting
> a much larger "record_size" ... so this split isn't needed?
> 
> -Tony
> 

Hi Tony, thanks a lot for your response! It makes sense indeed, but in
my case, for example, I have a "log_buf_len=4M", but cannot allocate a
4M record_size - when I try that, I can only see page_alloc spews and
pstore/ramoops doesn't work. So, I could allocate 2M and that works
fine, but I then lose half of my dmesg heh
Hence my question.

If there's no special reason, I guess would make sense to allow ramoops
to split the dmesg, what do you think?
Cheers,


Guilherme
