Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE993CFDA1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 17:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241550AbhGTOw7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 10:52:59 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:53398 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238462AbhGTOS1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 10:18:27 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B10011FE26;
        Tue, 20 Jul 2021 14:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626793120; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ji29J1Gkiu8Hys+fl9zGXrxei7u7l7oipbZgKUbNk3Q=;
        b=SJPDFJHXJdiClijovK+GW0A5hpke0aJLMupCvE67MpCDZWTRah661tujK+HznLfZ/eT3S4
        xz79H3g77Y6n2TeBe0Sba2gx/Rs6T9AF6PDR2LAjF9Wow6NWvNBa4FKUNRB5g3glEWayBA
        ARstv5QKzvfNExFAezvpzHgBuxTmWFg=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 64EC413964;
        Tue, 20 Jul 2021 14:58:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id OEF8FaDk9mADFQAAGKfGzw
        (envelope-from <nborisov@suse.com>); Tue, 20 Jul 2021 14:58:40 +0000
Subject: Re: [PATCH] vfs: Optimize dedupe comparison
To:     Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        djwong@kernel.org
References: <20210715141309.38443-1-nborisov@suse.com>
 <YPBGoDlf9T6kFjk1@casper.infradead.org>
 <7c4c9e73-0a8b-5621-0b74-1bf34e4b4817@suse.com>
 <YPBPkupPDnsCXrLU@casper.infradead.org>
 <20210715223352.GB219491@dread.disaster.area>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <dba60154-874e-b6b9-21c4-5c2d9735029a@suse.com>
Date:   Tue, 20 Jul 2021 17:58:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210715223352.GB219491@dread.disaster.area>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 16.07.21 г. 1:33, Dave Chinner wrote:
> On Thu, Jul 15, 2021 at 04:09:06PM +0100, Matthew Wilcox wrote:
>> On Thu, Jul 15, 2021 at 05:44:15PM +0300, Nikolay Borisov wrote:
>>> I was wondering the same thing, but AFAICS it seems to be possible i.e
>>> if userspace spaces bad offsets, while all kinds of internal fs
>>> synchronization ops are going to be performed on aligned offsets, that
>>> doesn't mean the original ones, passed from userspace are themselves
>>> aligned explicitly.
>>
>> Ah, I thought it'd be failed before we got to this point.
>>
>> But honestly, I think x86-64 needs to be fixed to either use
>> __builtin_memcmp() or to have a nicely written custom memcmp().  I
>> tried to find the gcc implementation of __builtin_memcmp() on
>> x86-64, but I can't.
> 
> Yup, this. memcmp() is widley used in hot paths through all the
> filesystem code and the rest of the kernel. We should fix the
> generic infrastructure problem, not play whack-a-mole to with custom
> one-off fixes that avoid the problem just where it shows up in some
> profile...

I ported glibc's implementation of memcmp to the kernel and after
running the same workload I get the same performance as with the basic
memcmp implementation of doing byte comparison ...

> 
> Cheers,
> 
> Dave.
> 
