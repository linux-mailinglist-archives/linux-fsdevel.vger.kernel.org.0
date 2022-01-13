Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B169148D86E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jan 2022 14:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234937AbiAMNBO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jan 2022 08:01:14 -0500
Received: from fanzine2.igalia.com ([213.97.179.56]:55834 "EHLO
        fanzine2.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234886AbiAMNBN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jan 2022 08:01:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dPa3Wa4G0Ntaf/PAHf49k0YNPmHV5oeAKn8rSgh5kEc=; b=CnxYjoJKQXMHECLIgFDY9OwjrZ
        dDHeAU+Faj6F9g/LeGEKRlrNDdGPAC3ndM0eowAZ92cpS4VOU7l4JPHQOPiQ7vhkbEywnk3zq2Bzu
        c/iC8pxGzDd0/zZjKMuCNWobyfVx9rbWU35OQtXSMQYKQf03FR5yPoJejaXLPiseoo8u+rftbv5/e
        oMSWInG4C675yBgE1wglW2PoIeD9VRpgLi4Rrqpd7+IKo0ejDiwqZ1z2MRc6vjbhbFDg0sMo/7atw
        bk3l6Wh7A6gfxOctzBlUK8bmIe33lVS3/7Inm8iC4rEimboaIYzzsH+eGh9S27MjCJYTo44wjiN+t
        orzmudkA==;
Received: from [179.113.53.20] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1n7zj0-0007Pz-QF; Thu, 13 Jan 2022 14:01:07 +0100
Message-ID: <fbadf45f-e21f-6f23-8165-e3568f119ebb@igalia.com>
Date:   Thu, 13 Jan 2022 10:00:49 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 3/3] panic: Allow printing extra panic information on
 kdump
Content-Language: en-US
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, feng.tang@intel.com,
        siglesias@igalia.com, kernel@gpiccoli.net
References: <20211109202848.610874-1-gpiccoli@igalia.com>
 <20211109202848.610874-4-gpiccoli@igalia.com> <Yd/qmyz+qSuoUwbs@alley>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <Yd/qmyz+qSuoUwbs@alley>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 13/01/2022 06:02, Petr Mladek wrote:
> [...]
> Is anyone really using this approach? kmsg_dump() looks like a better
> choice when there are memory constrains. It does not need to reserve
> memory for booting the crash kernel.
> 
> I would not mind much but this change depends on a not fully reliable
> assumption, see below.
> 
> Also it will also complicate the solution for the kmsg_dump() code path.
> It would be better to discuss this togeter with the other patch
> https://lore.kernel.org/r/20220106212835.119409-1-gpiccoli@igalia.com

Hi Petr, thanks for your analysis here. Indeed, our use case benefits
from both this and the other patch in the thread you mentioned above -
see [0].


> [...]
>> (b) We assume that the code path won't return from __crash_kexec()
>> so we didn't guard against double execution of panic_print_sys_info().
> 
> This sounds suspiciously. There is small race window but it actually works.
> __crash_kexec() really never returns when @kexec_crash_image is
> loaded. Well, it might break in the future if the code is modified.
> 
> Best Regards,
> Petr

OK, so since this patch is already on linux-next and is relevant for our
use case, how about if we explicitly guard against the double print, as
I suggested in [0]?

Cheers,

Guilherme


[0]
https://lore.kernel.org/lkml/ba0e29ba-0e08-df6e-ade5-eb58ae2495e3@igalia.com/
