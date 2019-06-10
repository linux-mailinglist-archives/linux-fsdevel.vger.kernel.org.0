Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33F5D3BE82
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2019 23:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389967AbfFJVW5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jun 2019 17:22:57 -0400
Received: from linux.microsoft.com ([13.77.154.182]:34646 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389571AbfFJVW5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jun 2019 17:22:57 -0400
Received: by linux.microsoft.com (Postfix, from userid 1029)
        id 4BCD320B7194; Mon, 10 Jun 2019 14:22:56 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by linux.microsoft.com (Postfix) with ESMTP id 41DCC311B1C8;
        Mon, 10 Jun 2019 14:22:56 -0700 (PDT)
Date:   Mon, 10 Jun 2019 14:22:56 -0700 (PDT)
From:   Jaskaran Singh Khurana <jaskarankhurana@linux.microsoft.com>
X-X-Sender: jaskarankhurana@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net
To:     Milan Broz <gmazyland@gmail.com>
cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, agk@redhat.com, snitzer@redhat.com,
        dm-devel@redhat.com, jmorris@namei.org, scottsh@microsoft.com,
        ebiggers@google.com, Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [RFC PATCH v3 1/1] Add dm verity root hash pkcs7 sig
 validation
In-Reply-To: <54170d18-31c7-463d-10b5-9af8b666df0f@gmail.com>
Message-ID: <alpine.LRH.2.21.1906101411520.15431@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.inter>
References: <20190607223140.16979-1-jaskarankhurana@linux.microsoft.com> <20190607223140.16979-2-jaskarankhurana@linux.microsoft.com> <54170d18-31c7-463d-10b5-9af8b666df0f@gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Sat, 8 Jun 2019, Milan Broz wrote:

> On 08/06/2019 00:31, Jaskaran Khurana wrote:
> Why is this different from existing FEC extension?
> FEC uses ifdefs in header to blind functions if config is not set.
>
> ifeq ($(CONFIG_DM_VERITY_FEC),y)
> dm-verity-objs                  += dm-verity-fec.o
> endif
>
> ...
>

The reasoning for doing it this way is that there might be scripts that 
create a device mapper device and then mount and use it, with the 
signature verification enabled in kernel the scripts would be passing the 
signature like:

veritysetup open params... --roothash-sig=<sig.p7>

If later due to some reason the DM_VERITY_VERIFY_ROOTHASH_SIG is disabled 
if we do not recognize the parameter then the scripts need to be changed 
or else they will fail with INVALID argument,
in current implementation the parameter for signature is always parsed but
enforced based on the config being set, so the scripts need not be 
changed.
Let me know if you still feel I should be changing this and I will be 
happy to make the change, just wanted to share my reasoning for this.

>
> Thanks,
> Milan
>
Regards,
Jaskaran
