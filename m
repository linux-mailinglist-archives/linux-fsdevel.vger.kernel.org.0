Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4504363FE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 16:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbhJUOXX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 10:23:23 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41204 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhJUOXW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 10:23:22 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D94172198A;
        Thu, 21 Oct 2021 14:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634826065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vCVClZQva3cjkU0Ggctmhx9vHw5IH07oOnPuSznKHCc=;
        b=q1Rl7OXqqZqRzSWQYA6FSt+zYSNrHDffShZs+f7WsVqu5TVOWsML5L9cE/m7XxuaSJij53
        OXJ9jhBBN0yAIOjzm2Hmm/PSA17f8TxAg9fCtiDFFnhSMJblGK/prAABYheHvXM/nD3Gjw
        R14S5HBHzhkSLZQ6p5KmO0HcTqg4YoQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 93AB713ACC;
        Thu, 21 Oct 2021 14:21:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rP+CIVF3cWGnOQAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 21 Oct 2021 14:21:05 +0000
Subject: Re: [PATCH v11 07/10] btrfs-progs: receive: process fallocate
 commands
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
References: <cover.1630514529.git.osandov@fb.com>
 <d37fc365eda31317abe6ef89be534d6b5effc0b7.1630515568.git.osandov@fb.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <6f428f1f-a6da-1b82-a0ba-5ceb38b3b16a@suse.com>
Date:   Thu, 21 Oct 2021 17:21:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <d37fc365eda31317abe6ef89be534d6b5effc0b7.1630515568.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 1.09.21 г. 20:01, Omar Sandoval wrote:
> From: Boris Burkov <boris@bur.io>
> 
> Send stream v2 can emit fallocate commands, so receive must support them
> as well. The implementation simply passes along the arguments to the
> syscall. Note that mode is encoded as a u32 in send stream but fallocate
> takes an int, so there is a unsigned->signed conversion there.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

However, kernel support for this hasn't landed, the kernel counterpart
patches add definitions but don't actually implement the code. BY the
looks of it it would seem that the proper send stream versioning could
be added first before any of this code lands. In this case we can simply
have the encoded writes stuff as protocol version 2 and leave the rest
of the commands for v3 for example.
