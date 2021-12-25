Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D33CE47F453
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Dec 2021 20:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbhLYTWK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Dec 2021 14:22:10 -0500
Received: from fanzine2.igalia.com ([213.97.179.56]:48452 "EHLO
        fanzine2.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbhLYTWJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Dec 2021 14:22:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version
        :Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=NGtJZ5xa5kqlpRhS8Hm8lqpR3Vce3uFVp9NQv+IosLM=; b=PYPPp8fe9snSBdD/Yq6pTKJ6YV
        q3fW31LWHMi+MXJRVGuFC2K7q0llSpA03Rt3gIEztpUfpjuzNNOwGCS9jPmnExb74gR6snfK19AMH
        YnpUCurS6LgcFhuGWchVvwFykVKSAR9glZ6Khk8eqKhFhm5VZFXFPZy5rxaOCbPQo4YuEU5xTFPz/
        VMqXFf9+8M+oLK2dN5D9CaYBqYZJgEg7/s2eV6gwRWkMP+ChFivU5gH0T6EMQftoRoEXwGNIpUj7o
        qaWVAoIYm4c7vuy3jNMaxTrDb25dRW8P/yXSvSKOrhP9ZMqaoxmQD+UnIyktMC3HIJIQVVYYMW91c
        uKnUhOlw==;
Received: from [187.39.124.208] (helo=[192.168.0.109])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1n1Cbn-0002On-C0; Sat, 25 Dec 2021 20:21:35 +0100
Subject: Re: [PATCH 3/3] panic: Allow printing extra panic information on
 kdump
To:     Dave Young <dyoung@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, feng.tang@intel.com,
        siglesias@igalia.com, kernel@gpiccoli.net,
        kexec@lists.infradead.org
References: <20211109202848.610874-1-gpiccoli@igalia.com>
 <20211109202848.610874-4-gpiccoli@igalia.com>
 <YcMPzs6t8MKpEacq@dhcp-128-65.nay.redhat.com>
 <2d24ea70-e315-beb5-0028-683880c438be@igalia.com>
 <YcUj0EJvQt77OVs2@dhcp-128-65.nay.redhat.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Message-ID: <5b817a4f-0bba-7d79-8aab-33c58e922293@igalia.com>
Date:   Sat, 25 Dec 2021 16:21:17 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YcUj0EJvQt77OVs2@dhcp-128-65.nay.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 23/12/2021 22:35, Dave Young wrote:
> Hi Guilherme,
> [...]
> If only the doc update, I think it is fine to be another follup-up
> patch.
> 
> About your 1st option in patch log, there is crash_kexec_post_notifiers
> kernel param which can be used to switch on panic notifiers before kdump
> bootup.   Another way probably you can try to move panic print to be
> panic notifier. Have this been discussed before? 
> 

Hey Dave, thanks for the suggestion. I've considered that but didn't
like the idea. My reasoning was: allowing post notifiers on kdump will
highly compromise the reliability, whereas the panic_print is a solo
option, and not very invasive.

To mix it with all panic notifiers would just increase a lot the risk of
a kdump failure. Put in other words: if I'm a kdump user and in order to
have this panic_print setting I'd also need to enable post notifiers,
certainly I'll not use the feature, 'cause I don't wanna risk kdump too
much.

One other option I've considered however, and I'd appreciate your
opinion here, would be a new option on crash_kexec_post_notifiers that
allows the users to select *which few notifiers* they want to enable.
Currently it's all or nothing, and this approach is too heavy/risky I
believe. Allowing customization on which post notifiers the user wants
would be much better and in this case, having a post notifier for
panic_print makes a lot of sense. What do you think?

Thanks!
